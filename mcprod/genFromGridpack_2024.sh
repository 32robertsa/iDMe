#! /bin/bash

## This script is used to produce MINI-AOD files from a gridpack for 2022 samples.

## Based on the MCM instructions found at https://cms-pdmv-prod.web.cern.ch/mcm/chained_requests?contains=GEN-Run3Summer22MiniAODv4-00307&page=0&shown=15

export SCRAM_ARCH=el9_amd64_gcc11
CMSSW=CMSSW_14_0_21

export BASEDIR=`pwd`
GRIDPACK=$1
nevent=$2
ctau=$3
nthreads=$4
year=2024

if [ "$#" -ne 4 ]; then
    echo "Wrong number of arguments!"
    echo "Usage: ./genFromGridpack_2024.sh gridpack nevents ctau nThreads"
    exit 1
fi

echo "Generating signal MC for gridpack ${GP_f}"
echo "Lifetime set to ${ctau} mm"

echo "Base Dir: ${BASEDIR}"
LHEDIR=${BASEDIR}


[ -d ${LHEDIR} ] || mkdir ${LHEDIR}

FRAGMENT="iDMe_pythiaGenFragment_ctau-100.py"

#namebase=${GP_f/.tar.xz/}
namebase=$(basename ${GRIDPACK/_el9_amd64_gcc11_CMSSW_13_0_13_tarball.tar.xz/})
namebase="${namebase/ctau-0/ctau-${ctau}}"

export VO_CMS_SW_DIR=/cvmfs/cms.cern.ch
source $VO_CMS_SW_DIR/cmsset_default.sh

if ! [ -r ${CMSSW}/src ] ; then
  scram p CMSSW ${CMSSW}
fi

cd ${CMSSW}/src
eval `scram runtime -sh`
scram b -j 4
tar xaf ${BASEDIR}/${GRIDPACK}
sed -i 's/exit 0//g' runcmsgrid.sh
ls -lrth

RANDOMSEED=`od -vAn -N4 -tu4 < /dev/urandom`
#Sometimes the RANDOMSEED is too long for madgraph
RANDOMSEED=`echo $RANDOMSEED | rev | cut -c 3- | rev`

#Running the LHE step
echo "---------- Step 0: LHE ----------"
sh runcmsgrid.sh ${nevent} ${RANDOMSEED} ${nthreads}
namebase=${namebase}_$RANDOMSEED
cp cmsgrid_final.lhe ${LHEDIR}/${namebase}.lhe
echo "${LHEDIR}/${namebase}.lhe" 

# clean
rm -rf *

# Prepare for GEN-SIM step
mkdir -p Configuration/GenProduction/python/

cp "${BASEDIR}/${FRAGMENT}" Configuration/GenProduction/python/.
eval `scram runtime -sh`
scram b -j 4

# Running GEN  Step
echo "---------- Step 1: GEN-SIM ----------" 
cfg_GEN_SIM=cfg/${namebase}_GEN-SIM_cfg.py
echo "Running in directory: $(pwd)"

echo "GEN-SIM cfg:" $cfg_GEN_SIM
echo "Fragment:" ${FRAGMENT}
echo "Input LHE file:" ${LHEDIR}/${namebase}.lhe 

cmsDriver.py \
    Configuration/GenProduction/python/${FRAGMENT} \
    --filein file:${LHEDIR}/${namebase}.lhe \
    --fileout file:${namebase}_GEN-SIM_${year}.root \
    --mc --eventcontent RAWSIM,LHE --datatier GEN-SIM,LHE \
    --step GEN,SIM --geometry DB:Extended \
    --conditions 140X_mcRun3_2024_realistic_v26 --beamspot DBrealistic \
    --era Run3_2024 --nThreads $nthreads \
    --customise Configuration/DataProcessing/Utils.addMonitoring \
    --python_filename cfg/${cfg_GEN_SIM} --no_exec -n ${nevent}

#Make each file unique to make later publication possible
linenumber=`grep -n 'process.source' ${cfg_GEN_SIM} | awk '{print $1}'`
linenumber=${linenumber%:*}
total_linenumber=`cat ${cfg_GEN_SIM} | wc -l`
bottom_linenumber=$((total_linenumber - $linenumber ))
tail -n $bottom_linenumber ${cfg_GEN_SIM=} > tail.py
head -n $linenumber ${cfg_GEN_SIM} > head.py
echo "    firstRun = cms.untracked.uint32(1)," >> head.py
echo "    firstLuminosityBlock = cms.untracked.uint32($RANDOMSEED)," >> head.py
cat tail.py >> head.py
mv head.py ${cfg_GEN_SIM}
rm -rf tail.py

cmsRun -p cfg/${cfg_GEN_SIM}


echo "---------- Step 2: DRPremix ----------"
set -e

cfg_DIGI_Premix=cfg/${namebase}_DIGIPremix_cfg.py
echo "Current working directory: $(pwd)"

cmsDriver.py  \
   --filein file:${namebase}_GEN-SIM_${year}.root \
   --fileout file:${namebase}_DIGIPremix_${year}.root \
   --mc --eventcontent PREMIXRAW --datatier GEN-SIM-RAW \
   --step DIGI,DATAMIX,L1,DIGI2RAW,HLT:2024v14 --procModifiers premix_stage2 --datamix PreMix \
   --geometry DB:Extended \
   --pileup_input filelist:${BASEDIR}/premix_files_prefixed.txt \
   --conditions 140X_mcRun3_2024_realistic_v26 \
   --era Run3_2024 --nThreads $nthreads \
   --customise Configuration/DataProcessing/Utils.addMonitoring \
   --python_filename cfg/${cfg_DIGI_Premix} --no_exec -n ${nevent}

cmsRun -p cfg/${cfg_DIGI_Premix}

#RECO step:
echo "---------- Step 3: RECO-PAT ----------"
cfg_RECO_PAT=cfg/${namebase}_RECO-PAT_cfg.py

cmsDriver.py  \
   --filein file:${namebase}_DIGIPremix_${year}.root \
   --fileout file:${namebase}_MiniAOD_${year}.root \
   --mc --eventcontent MINIAODSIM --datatier MINIAODSIM \
   --step RAW2DIGI,L1Reco,RECO,RECOSIM,PAT \
   --geometry DB:Extended \
   --conditions 140X_mcRun3_2024_realistic_v26 \
   --era Run3_2024 --nThreads $nthreads \
   --customise Configuration/DataProcessing/Utils.addMonitoring \
   --python_filename cfg/${cfg_RECO_PAT} --no_exec -n ${nevent}

cmsRun -p cfg/${cfg_RECO_PAT}

echo "MiniAOD file complete."

remoteDIR="/store/group/lpcmetx/iDMe/Samples/acrobert/signal/2024"
xrdcp -vf ${namebase}_MiniAOD_ctau-${ctau}_year-${year}.root root://cmseos.fnal.gov/$remoteDIR/MiniAOD/${namebase}_MiniAOD_ctau-${ctau}_year-${year}.root

echo "Final output ROOT file:" ${namebase}_MiniAOD_ctau-${ctau}_year-${year}.root 
echo "The output MINIAOD file: root://cmseos.fnal.gov/$remoteDIR/MiniAOD/${namebase}_MiniAOD_ctau-${ctau}_year-${year}.root"
echo "DONE!"

