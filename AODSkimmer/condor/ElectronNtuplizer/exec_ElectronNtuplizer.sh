#!/bin/bash

fname=$1
year=$2
nThreads=$3
isData=$4
isSignal=$5
outPath=$6

xrdcp root://cmseos.fnal.gov//store/user/acrobert/vbfidme/CMSSW_14_0_21_compiled_env_2025-12-15.tar.gz .
tar -xzf CMSSW_14_0_21_compiled_env_2025-12-15.tar.gz

mv ${fname}.txt CMSSW_14_0_21/src/iDMe/AODSkimmer
cd CMSSW_14_0_21/src/
export VO_CMS_SW_DIR=/cvmfs/cms.cern.ch
source $VO_CMS_SW_DIR/cmsset_default.sh
scram b ProjectRename
eval `scram runtime -sh`
cd iDMe/AODSkimmer
cmsRun scripts/ElectronNtuplizer_cfg.py flist=${fname}.txt data=${isData} signal=${isSignal} year=${year} numThreads=${nThreads}
mv test_output.root ntuples_${fname}.root
xrdcp -f ntuples_${fname}.root root://cmsdata.phys.cmu.edu/${outPath}/ntuples_${fname}.root
echo "Copied ntuples_${fname}.root"
echo "Done"
