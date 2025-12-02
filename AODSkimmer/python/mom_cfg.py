import FWCore.ParameterSet.Config as cms
import FWCore.ParameterSet.VarParsing as VarParsing
import FWCore.Utilities.FileUtils as FileUtils
from TrackingTools.TrackAssociator.default_cfi import TrackAssociatorParameterBlock


#Run3 imports
from Configuration.Eras.Era_Run3_cff import Run3                   #corresponds to Run3 2022 (maybe)
from Configuration.Eras.Era_Run3_2023_cff import Run3_2023         #corresponds to Run3 2023

import json
import sys

# globaltag

globaltag = '130X_mcRun3_2023_realistic_v14'
   


process = cms.Process("GENSKIMMER") 
process.load("FWCore.MessageService.MessageLogger_cfi")

process.load('Configuration.StandardSequences.Services_cff')
process.load("Configuration.EventContent.EventContent_cff")
process.load("TrackingTools.TransientTrack.TransientTrackBuilder_cfi")
process.load("Configuration.StandardSequences.GeometryRecoDB_cff")
process.load('Configuration.StandardSequences.MagneticField_38T_cff')
process.load('Configuration.StandardSequences.FrontierConditions_GlobalTag_cff')

from Configuration.AlCa.GlobalTag import GlobalTag
process.GlobalTag = GlobalTag(process.GlobalTag, globaltag, '')


process.maxEvents = cms.untracked.PSet( input = cms.untracked.int32(-1) )

process.source = cms.Source("PoolSource",
                                
                                fileNames = cms.untracked.vstring(
            'file:/uscms/home/reshmar/nobackup/CMSSW_13_0_13/src/iDMe/iDMe_Mchi-10p5_dMchi-1p0_mZDinput-30p0_ctau-0_1jet_icckw1_drjj0_xptj80_xqcut20_slc7_amd64_gcc11_CMSSW_13_0_13_tarball_22577496_MINIAOD_ctau-10.0_year-2022.root'
                )
                            )
#Doubt

# process.TFileService = cms.Service("TFileService",
#                                         fileName = cms.string("genoutpoot.root")
                                        
#                                         )


process.demo = cms.EDAnalyzer('ElectronSkimmer',   
genParticle    = cms.InputTag("prunedGenParticles"),
            effAreasConfigFile = cms.FileInPath("RecoEgamma/ElectronIdentification/data/Run3_Winter22/effAreaElectrons_cone03_pfNeuHadronsAndPhotons_122X.txt")

                              )


process.p = cms.Path(process.demo)


