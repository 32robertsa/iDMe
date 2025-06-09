#! /bin/bash

## This script is used to produce MINI-AOD files from a gridpack for 2022 samples.

## Based on the MCM instructions found at https://cms-pdmv-prod.web.cern.ch/mcm/chained_requests?contains=GEN-Run3Summer22MiniAODv4-00307&page=0&shown=15

export BASEDIR=`pwd`
GP_f=$1
nevent=$2
ctau=$3
nthreads=$4
year=2022

if [ "$#" -ne 4 ]; then
    echo "Wrong number of arguments!"
    echo "Usage: ./genFromGridpack_2022.sh gridpack nevents ctau nThreads"
    exit 1
fi

echo "Generating signal MC for gridpack ${GP_f}"
echo "Lifetime set to ${ctau} mm"

GRIDPACKDIR=${BASEDIR}
LHEDIR=${BASEDIR}


[ -d ${LHEDIR} ] || mkdir ${LHEDIR}

HADRONIZER="iDMe_pythiaGenFragment.py"

namebase=${GP_f/.tar.xz/}
namebase=$(basename ${GP_f/.tar.xz/})


export VO_CMS_SW_DIR=/cvmfs/cms.cern.ch
source $VO_CMS_SW_DIR/cmsset_default.sh


export SCRAM_ARCH=el8_amd64_gcc11
if ! [ -r CMSSW_12_4_14_patch3/src ] ; then
  scram p CMSSW CMSSW_12_4_14_patch3
fi

cd CMSSW_12_4_14_patch3/src
eval `scram runtime -sh`
scram b -j 4
tar xaf ${GRIDPACKDIR}/${GP_f}
sed -i 's/exit 0//g' runcmsgrid.sh
ls -lrth

RANDOMSEED=`od -vAn -N4 -tu4 < /dev/urandom`
#Sometimes the RANDOMSEED is too long for madgraph
RANDOMSEED=`echo $RANDOMSEED | rev | cut -c 3- | rev`

#Running the LHE step
echo "0.) LHE Step"
sh runcmsgrid.sh ${nevent} ${RANDOMSEED} ${nthreads}
namebase=${namebase}_$RANDOMSEED
cp cmsgrid_final.lhe ${LHEDIR}/${namebase}.lhe
echo "${LHEDIR}/${namebase}.lhe" 
rm -rf *
cd ${BASEDIR}

export SCRAM_ARCH=el8_amd64_gcc10
if ! [ -r CMSSW_12_4_14_patch3/src ] ; then
    scram p CMSSW CMSSW_12_4_14_patch3
fi
cd CMSSW_12_4_14_patch3/src
rm -rf *
mkdir -p Configuration/GenProduction/python/

cp "${BASEDIR}/${HADRONIZER}" Configuration/GenProduction/python/
echo "Happening!"
eval `scram runtime -sh`
scram b -j 4

# Running GEN  Step
echo "########################################################################################"
echo "########################################################################################"
echo "1.) GEN -SIM Step" 
genfragment=${namebase}_GEN_cfg_ctau-${ctau}.py
echo "Running in directory: $(pwd)"

echo "genfragment:" ${namebase}_GEN_cfg_ctau-${ctau}.py
cmsDriver.py Configuration/GenProduction/python/${HADRONIZER}  \
    --filein file:${LHEDIR}/${namebase}.lhe \
    --fileout file:${namebase}_GEN_ctau-${ctau}_year-${year}.root \
    --mc --eventcontent RAWSIM, LHE --datatier GEN-SIM,LHE \
    --step GEN,SIM --geometry DB:Extended \
    --conditions 124X_mcRun3_2022_realistic_v12 --beamspot Realistic25ns13p6TeVEarly2022Collision \
    --era Run3 --nThreads $nthreads \
    --customise Configuration/DataProcessing/Utils.addMonitoring \
    --python_filename ${genfragment} --no_exec -n ${nevent} || exit $?;

#Make each file unique to make later publication possible
linenumber=`grep -n 'process.source' ${genfragment} | awk '{print $1}'`
linenumber=${linenumber%:*}
total_linenumber=`cat ${genfragment} | wc -l`
bottom_linenumber=$((total_linenumber - $linenumber ))
tail -n $bottom_linenumber ${genfragment} > tail.py
head -n $linenumber ${genfragment} > head.py
echo "    firstRun = cms.untracked.uint32(1)," >> head.py
echo "    firstLuminosityBlock = cms.untracked.uint32($RANDOMSEED)," >> head.py
cat tail.py >> head.py
mv head.py ${genfragment}
rm -rf tail.py

cmsRun -p ${genfragment}


echo "########################################################################################"
echo "3.) DIGIPremix Step"
set -e

template_cfg="/uscms/home/reshmar/nobackup/CMSSW_13_0_13/src/iDMe/UL_MCProduction/template_DRPremix_cfg_2022.py"
#genfragment="${template_cfg}"

genfragment=${namebase}_DRPremix_cfg_ctau-${ctau}.py


cmsDriver.py  \
   --filein file:PLACEHOLDER_IN.root \
   --fileout file:PLACEHOLDER_OUT.root \
   --mc --eventcontent PREMIXRAW --datatier GEN-SIM-RAW \
   --step DIGI,DATAMIX,L1,DIGI2RAW,HLT:2022v12 --procModifiers premix_stage2,siPixelQualityRawToDigi --datamix PreMix \
   --geometry DB:Extended \
   --pileup_input filelist:/store/user/reshmar/iDMe/premix_files_prefixed.txt \
   --conditions 124X_mcRun3_2022_realistic_v12 \
   --era Run3 --nThreads $nthreads \
   --customise Configuration/DataProcessing/Utils.addMonitoring \
   --python_filename ${genfragment} --no_exec -n ${nevent} || exit $?;

sed -i -e "s/PLACEHOLDER_IN.root/${namebase}_GEN_ctau-${ctau}_year-${year}.root/g" ${genfragment}
sed -i -e "s/PLACEHOLDER_OUT.root/${namebase}_DRPremix_ctau-${ctau}_year-${year}.root/g" ${genfragment}
sed -i -e "s/NEVT/${nevent}/g" ${genfragment}
sed -i -e "s/NTHREAD/${nthreads}/g" ${genfragment}

cmsRun -p ${genfragment}

# template_cfg="/uscms/home/reshmar/nobackup/CMSSW_13_0_13/src/iDMe/UL_MCProduction/template_DRPremix_cfg_2022.py"

echo "SUCCESS DP!"

# Rename the generated config file to a standardized template name
# mv "${genfragment}" "${template_cfg}"
# genfragment="${template_cfg}"


# (Optional) You can confirm the file was renamed
# if [[ -f "${template_cfg}" ]]; then
#     echo "Template created: ${template_cfg}"
# else
#     echo "ERROR: Renaming failed!"
#     exit 1
# fi
# sed -i -e "s/PLACEHOLDER_IN.root/${namebase}_GEN_ctau-${ctau}_year-${year}.root/g" ${genfragment}
# sed -i -e "s/PLACEHOLDER_OUT.root/${namebase}_DRPremix_ctau-${ctau}_year-${year}.root/g" ${genfragment}
# sed -i -e "s/NEVT/${nevent}/g" ${genfragment}
# sed -i -e "s/NTHREAD/${nthreads}/g" ${genfragment}

# cmsRun -p ${genfragment}

# Doing MINIAOD Step
echo "########################################################################################"
echo "########################################################################################"
echo "6.) MINIAOD Step"
genfragment=${namebase}_MINIAOD_cfg_ctau-${ctau}.py

cmsDriver.py \
    --filein file:${namebase}_DRPremix_ctau-${ctau}_year-${year}.root \
    --fileout file:${namebase}_MINIAOD_ctau-${ctau}_year-${year}.root \
    --mc --eventcontent MINIAODSIM --datatier MINIAODSIM \
    --step PAT --geometry DB:Extended \
    --conditions 130X_mcRun3_2022_realistic_v5 \
    --era Run3 --nThreads $nthreads \
    --customise Configuration/DataProcessing/Utils.addMonitoring \
    --customise_commands "process.MINIAODSIMoutput.outputCommands = cms.untracked.vstring([line for line in process.MINIAODSIMoutput.outputCommands if 'slimmedCaloJets' not in line and 'oniaPhotonCandidates' not in line and 'offlineSlimmedPrimaryVerticesWithBS' not in line and 'primaryVertexWithBSAssociation' not in line and 'slimmedHcalRecHits' not in line])" \
    --python_filename ${genfragment} --no_exec --runUnscheduled -n ${nevent} || exit $?;

echo "process.options = cms.untracked.PSet(SkipEvent = cms.untracked.vstring('ProductNotFound'))" >> ${genfragment}
cmsRun -p ${genfragment}

echo "list of output files:"
ls -ltr *.root

#Path needs to be fixed
remoteDIR="/store/group/lpcmetx/iDMe//Samples/signal/2022"
xrdcp -vf ${namebase}_MINIAOD_ctau-${ctau}_year-${year}.root root://cmseos.fnal.gov/$remoteDIR/MINIAOD/${namebase}_MINIAOD_ctau-${ctau}_year-${year}.root

echo "DONE."
