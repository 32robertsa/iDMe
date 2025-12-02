import FWCore.ParameterSet.Config as cms
process = cms.Process("USER",era)

process.source = cms.Source("PoolSource",
                                
                                fileNames = cms.untracked.vstring("/uscms/home/reshmar/nobackup/CMSSW_13_0_13/src/iDMe/iDMe_Mchi-10p5_dMchi-1p0_mZDinput-30p0_ctau-0_1jet_icckw1_drjj0_xptj80_xqcut20_slc7_amd64_gcc11_CMSSW_13_0_13_tarball_22577496_MINIAOD_ctau-10.0_year-2022.root"    ) 


process.myAnalyzer = cms.EDAnalyzer("MyModule",
    genLabel = cms.InputTag("prunedGenParticles")
)

process.p = cms.Path(process.myAnalyzer)
