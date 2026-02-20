#! /bin/bash

## This script is used to produce MiniAOD files from a gridpack for 2024 samples.
## Based on the MCM instructions found at https://cms-pdmv-prod.web.cern.ch/mcm/chained_requests?contains=GEN-Run3Summer22MiniAODv4-00307&page=0&shown=15
## Working 2026-2-19 on el9_amd_64_CMSSW_13_0_13 gridpacks
## Contributors: Sam BT, Kyungmin Park, Reshma Menon, Andrew C. Roberts

export SCRAM_ARCH=el9_amd64_gcc11
CMSSW=CMSSW_14_0_21

export BASEDIR=`pwd`

if [ "$#" -eq 5 ]; then
    index=$5
    echo "Using index" $index
elif [ "$#" -ne 4 ]; then
    echo "Wrong number of arguments!"
    echo "Usage: ./genFromGridpack_2024.sh gridpack nevents ctau nThreads"
    exit 1
fi

massname=$1
ctau=$2
nevent=$3
nthreads=$4
year=2024

echo "Base Directory: ${BASEDIR}"
LHEDIR=${BASEDIR}

[ -d ${LHEDIR} ] || mkdir ${LHEDIR}

FRAGMENT=${BASEDIR}/iDMe_template_fragment_acrobert.py

# old gridpack method
#namebase=${GP_f/.tar.xz/}
#gpbase=$(basename ${GRIDPACK/_el9_amd64_gcc11_CMSSW_13_0_13_tarball.tar.xz/})
#namebase="${gpbase/ctau-0/ctau-${ctau}}"

# new hotness
gridpack=iDMe_run3_${massname}_ctau-${ctau}_1jet_xptj80_el9_amd64_gcc11_CMSSW_13_0_13_tarball.tar.xz
gpbase=iDMe_run3_${massname}_ctau-0_1jet_xptj80
namebase=iDMe_run3_${massname}_ctau-${ctau}_1jet_xptj80

echo "Generating signal MC for gridpack ${gridpack}"
echo "Lifetime set to ${ctau} mm; generating ${nevent} events"

export VO_CMS_SW_DIR=/cvmfs/cms.cern.ch
source $VO_CMS_SW_DIR/cmsset_default.sh

if ! [ -r ${CMSSW}/src ] ; then
  scram p CMSSW ${CMSSW}
fi

cd ${CMSSW}/src
eval `scram runtime -sh`
scram b -j 4

RANDOMSEED=`od -vAn -N4 -tu4 < /dev/urandom`
#Sometimes the RANDOMSEED is too long for madgraph
RANDOMSEED=`echo $RANDOMSEED | rev | cut -c 3- | rev`

# clean
rm -rf *

# Copy and modify fragment
mkdir -p Configuration/GenProduction/python/
fragmentloc=Configuration/GenProduction/python/${namebase}-fragment.py
sed "s/#gridpack#/${gpbase}/g" ${FRAGMENT} > $fragmentloc

if [[ "$ctau" == "1" ]]; then exp=12
elif [[ "$ctau" == "10" ]]; then exp=13
elif [[ "$ctau" == "100" ]]; then exp=14
elif [[ "$ctau" == "1000" ]]; then exp=15
fi

sed -i -e 's/#exp#/'${exp}'/' $fragmentloc

eval `scram runtime -sh`
scram b -j 4

# Running GEN  Step
echo "---------- Step 1: GEN-SIM ----------" 
cfg_GEN_SIM=${namebase}_GEN-SIM_cfg.py
echo "Running in directory: $(pwd)"

echo "GEN-SIM cfg:" $cfg_GEN_SIM
echo "Template:" ${FRAGMENT} "Fragment:" Configuration/GenProduction/python/${namebase}-fragment.py
#echo "Input LHE file:" ${LHEDIR}/${namebase}.lhe 

cmsDriver.py \
    $fragmentloc \
    --fileout file:${namebase}_GEN-SIM_${year}.root \
    --mc --eventcontent RAWSIM,LHE --datatier GEN-SIM,LHE \
    --step LHE,GEN,SIM --geometry DB:Extended \
    --conditions 140X_mcRun3_2024_realistic_v26 --beamspot DBrealistic \
    --era Run3_2024 --nThreads $nthreads \
    --customise Configuration/DataProcessing/Utils.addMonitoring \
    --customise_commands process.RandomNumberGeneratorService.externalLHEProducer.initialSeed="int(${RANDOMSEED})" \
    --python_filename ${cfg_GEN_SIM} --no_exec -n ${nevent}

cmsRun ${cfg_GEN_SIM}

echo "---------- Step 2: DRPremix ----------"
set -e

cfg_DIGI_Premix=${namebase}_DIGIPremix_cfg.py
echo "Current working directory: $(pwd)"

cmsDriver.py  \
   --filein file:${namebase}_GEN-SIM_${year}.root \
   --fileout file:${namebase}_DIGIPremix_${year}.root \
   --mc --eventcontent PREMIXRAW --datatier GEN-SIM-RAW \
   --step DIGI,DATAMIX,L1,DIGI2RAW,HLT:2024v14 --procModifiers premix_stage2 --datamix PreMix \
   --geometry DB:Extended \
   --pileup_input filelist:${BASEDIR}/pileupfiles_2024.txt \
   --conditions 140X_mcRun3_2024_realistic_v26 \
   --era Run3_2024 --nThreads $nthreads \
   --customise Configuration/DataProcessing/Utils.addMonitoring \
   --python_filename ${cfg_DIGI_Premix} --no_exec -n ${nevent}

cmsRun ${cfg_DIGI_Premix}

#RECO step:
echo "---------- Step 3: RECO-PAT ----------"
cfg_RECO_PAT=${namebase}_RECO-PAT_cfg.py

cmsDriver.py  \
   --filein file:${namebase}_DIGIPremix_${year}.root \
   --fileout file:${namebase}_MiniAOD_${year}.root \
   --mc --eventcontent MINIAODSIM --datatier MINIAODSIM \
   --step RAW2DIGI,L1Reco,RECO,RECOSIM,PAT \
   --geometry DB:Extended \
   --conditions 140X_mcRun3_2024_realistic_v26 \
   --era Run3_2024 --nThreads $nthreads \
   --customise Configuration/DataProcessing/Utils.addMonitoring \
   --python_filename ${cfg_RECO_PAT} --no_exec -n ${nevent}

cmsRun -e -j ${namebase}_MiniAOD_${year}_report.xml ${cfg_RECO_PAT}

# Find line with format <TotalEvents>59</TotalEvents> and parse
nevts=$(grep "<TotalEvents>" ${namebase}_MiniAOD_${year}_report.xml)
nevts=${nevts/"<TotalEvents>"/}
nevts=${nevts/"</TotalEvents>"/}

echo "MiniAOD file complete with ${nevts} events."

remoteDIR="/store/group/lpcmetx/iDMe/Samples/acrobert/signal/2024"
cp ${namebase}_MiniAOD_${year}.root ${BASEDIR}/${namebase}_MiniAOD_${year}_${nevts}evts.root
echo "Final output ROOT file:" miniaod/${namebase}_MiniAOD_${year}_${nevts}evts.root 
if [ "$#" -eq 5 ]; then
    xrdcp -vf ${namebase}_MiniAOD_${year}.root root://cmseos.fnal.gov/$remoteDIR/MiniAOD/${namebase}_MiniAOD_${year}_${index}_${nevts}evts.root
    echo "The output MINIAOD file: root://cmseos.fnal.gov/$remoteDIR/MiniAOD/${namebase}_MiniAOD_${year}_${index}_${nevts}evts.root"
elif [ "$#" -eq 4 ]; then
    xrdcp -vf ${namebase}_MiniAOD_${year}.root root://cmseos.fnal.gov/$remoteDIR/MiniAOD/${namebase}_MiniAOD_${year}_${nevts}evts.root
    echo "The output MINIAOD file: root://cmseos.fnal.gov/$remoteDIR/MiniAOD/${namebase}_MiniAOD_${year}_${nevts}evts.root"
fi

echo "DONE!"
cd ${BASEDIR}
