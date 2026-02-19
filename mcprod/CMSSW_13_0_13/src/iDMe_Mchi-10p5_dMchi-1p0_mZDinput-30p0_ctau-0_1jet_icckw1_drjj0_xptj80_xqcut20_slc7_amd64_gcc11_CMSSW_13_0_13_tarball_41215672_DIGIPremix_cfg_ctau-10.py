# Auto generated configuration file
# using: 
# Revision: 1.19 
# Source: /local/reps/CMSSW/CMSSW/Configuration/Applications/python/ConfigBuilder.py,v 
# with command line options: --filein file:iDMe_Mchi-10p5_dMchi-1p0_mZDinput-30p0_ctau-0_1jet_icckw1_drjj0_xptj80_xqcut20_slc7_amd64_gcc11_CMSSW_13_0_13_tarball_41215672_GEN_ctau-10_year-2022.root --fileout file:iDMe_Mchi-10p5_dMchi-1p0_mZDinput-30p0_ctau-0_1jet_icckw1_drjj0_xptj80_xqcut20_slc7_amd64_gcc11_CMSSW_13_0_13_tarball_41215672_DIGIPremix_ctau-10_year-2022.root --mc --eventcontent PREMIXRAW --datatier GEN-SIM-RAW --step DIGI,DATAMIX,L1,DIGI2RAW --procModifiers premix_stage2,siPixelQualityRawToDigi --datamix PreMix --geometry DB:Extended --pileup_input dbs:/Neutrino_E-10_gun/Run3Summer22DRPremix-Summer22_124X_mcRun3_2022_realistic_v12-v2/GEN-SIM-DIGI-RAW --conditions 124X_mcRun3_2022_realistic_v12 --era Run3 --nThreads 1 --customise Configuration/DataProcessing/Utils.addMonitoring --python_filename iDMe_Mchi-10p5_dMchi-1p0_mZDinput-30p0_ctau-0_1jet_icckw1_drjj0_xptj80_xqcut20_slc7_amd64_gcc11_CMSSW_13_0_13_tarball_41215672_DIGIPremix_cfg_ctau-10.py --no_exec -n 10
import FWCore.ParameterSet.Config as cms

from Configuration.Eras.Era_Run3_cff import Run3
from Configuration.ProcessModifiers.premix_stage2_cff import premix_stage2
from Configuration.ProcessModifiers.siPixelQualityRawToDigi_cff import siPixelQualityRawToDigi

process = cms.Process('DIGI2RAW',Run3,premix_stage2,siPixelQualityRawToDigi)

# import of standard configurations
process.load('Configuration.StandardSequences.Services_cff')
process.load('SimGeneral.HepPDTESSource.pythiapdt_cfi')
process.load('FWCore.MessageService.MessageLogger_cfi')
process.load('Configuration.EventContent.EventContent_cff')
process.load('SimGeneral.MixingModule.mixNoPU_cfi')
process.load('Configuration.StandardSequences.GeometryRecoDB_cff')
process.load('Configuration.StandardSequences.MagneticField_cff')
process.load('Configuration.StandardSequences.DigiDM_cff')
process.load('Configuration.StandardSequences.DataMixerPreMix_cff')
process.load('Configuration.StandardSequences.SimL1EmulatorDM_cff')
process.load('Configuration.StandardSequences.DigiToRawDM_cff')
process.load('Configuration.StandardSequences.EndOfProcess_cff')
process.load('Configuration.StandardSequences.FrontierConditions_GlobalTag_cff')

process.maxEvents = cms.untracked.PSet(
    input = cms.untracked.int32(10),
    output = cms.optional.untracked.allowed(cms.int32,cms.PSet)
)

# Input source
process.source = cms.Source("PoolSource",
    dropDescendantsOfDroppedBranches = cms.untracked.bool(False),
    fileNames = cms.untracked.vstring('file:iDMe_Mchi-10p5_dMchi-1p0_mZDinput-30p0_ctau-0_1jet_icckw1_drjj0_xptj80_xqcut20_slc7_amd64_gcc11_CMSSW_13_0_13_tarball_41215672_GEN_ctau-10_year-2022.root'),
    inputCommands = cms.untracked.vstring(
        'keep *',
        'drop *_genParticles_*_*',
        'drop *_genParticlesForJets_*_*',
        'drop *_kt4GenJets_*_*',
        'drop *_kt6GenJets_*_*',
        'drop *_iterativeCone5GenJets_*_*',
        'drop *_ak4GenJets_*_*',
        'drop *_ak7GenJets_*_*',
        'drop *_ak8GenJets_*_*',
        'drop *_ak4GenJetsNoNu_*_*',
        'drop *_ak8GenJetsNoNu_*_*',
        'drop *_genCandidatesForMET_*_*',
        'drop *_genParticlesForMETAllVisible_*_*',
        'drop *_genMetCalo_*_*',
        'drop *_genMetCaloAndNonPrompt_*_*',
        'drop *_genMetTrue_*_*',
        'drop *_genMetIC5GenJs_*_*'
    ),
    secondaryFileNames = cms.untracked.vstring()
)

process.options = cms.untracked.PSet(
    FailPath = cms.untracked.vstring(),
    IgnoreCompletely = cms.untracked.vstring(),
    Rethrow = cms.untracked.vstring(),
    SkipEvent = cms.untracked.vstring(),
    accelerators = cms.untracked.vstring('*'),
    allowUnscheduled = cms.obsolete.untracked.bool,
    canDeleteEarly = cms.untracked.vstring(),
    deleteNonConsumedUnscheduledModules = cms.untracked.bool(True),
    dumpOptions = cms.untracked.bool(False),
    emptyRunLumiMode = cms.obsolete.untracked.string,
    eventSetup = cms.untracked.PSet(
        forceNumberOfConcurrentIOVs = cms.untracked.PSet(
            allowAnyLabel_=cms.required.untracked.uint32
        ),
        numberOfConcurrentIOVs = cms.untracked.uint32(0)
    ),
    fileMode = cms.untracked.string('FULLMERGE'),
    forceEventSetupCacheClearOnNewRun = cms.untracked.bool(False),
    holdsReferencesToDeleteEarly = cms.untracked.VPSet(),
    makeTriggerResults = cms.obsolete.untracked.bool,
    modulesToIgnoreForDeleteEarly = cms.untracked.vstring(),
    numberOfConcurrentLuminosityBlocks = cms.untracked.uint32(0),
    numberOfConcurrentRuns = cms.untracked.uint32(1),
    numberOfStreams = cms.untracked.uint32(0),
    numberOfThreads = cms.untracked.uint32(1),
    printDependencies = cms.untracked.bool(False),
    sizeOfStackForThreadsInKB = cms.optional.untracked.uint32,
    throwIfIllegalParameter = cms.untracked.bool(True),
    wantSummary = cms.untracked.bool(False)
)

# Production Info
process.configurationMetadata = cms.untracked.PSet(
    annotation = cms.untracked.string('--filein nevts:10'),
    name = cms.untracked.string('Applications'),
    version = cms.untracked.string('$Revision: 1.19 $')
)

# Output definition

process.PREMIXRAWoutput = cms.OutputModule("PoolOutputModule",
    dataset = cms.untracked.PSet(
        dataTier = cms.untracked.string('GEN-SIM-RAW'),
        filterName = cms.untracked.string('')
    ),
    fileName = cms.untracked.string('file:iDMe_Mchi-10p5_dMchi-1p0_mZDinput-30p0_ctau-0_1jet_icckw1_drjj0_xptj80_xqcut20_slc7_amd64_gcc11_CMSSW_13_0_13_tarball_41215672_DIGIPremix_ctau-10_year-2022.root'),
    outputCommands = process.PREMIXRAWEventContent.outputCommands,
    splitLevel = cms.untracked.int32(0)
)

# Additional output definition

# Other statements
process.mixData.input.fileNames = cms.untracked.vstring([])
from Configuration.AlCa.GlobalTag import GlobalTag
process.GlobalTag = GlobalTag(process.GlobalTag, '124X_mcRun3_2022_realistic_v12', '')

# Path and EndPath definitions
process.digitisation_step = cms.Path(process.pdigi)
process.datamixing_step = cms.Path(process.pdatamix)
process.L1simulation_step = cms.Path(process.SimL1Emulator)
process.digi2raw_step = cms.Path(process.DigiToRaw)
process.endjob_step = cms.EndPath(process.endOfProcess)
process.PREMIXRAWoutput_step = cms.EndPath(process.PREMIXRAWoutput)

# Schedule definition
process.schedule = cms.Schedule(process.digitisation_step,process.datamixing_step,process.L1simulation_step,process.digi2raw_step,process.endjob_step,process.PREMIXRAWoutput_step)
from PhysicsTools.PatAlgos.tools.helpers import associatePatAlgosToolsTask
associatePatAlgosToolsTask(process)

# customisation of the process.

# Automatic addition of the customisation function from Configuration.DataProcessing.Utils
from Configuration.DataProcessing.Utils import addMonitoring 

#call to customisation function addMonitoring imported from Configuration.DataProcessing.Utils
process = addMonitoring(process)

# End of customisation functions


# Customisation from command line

# Add early deletion of temporary data products to reduce peak memory need
from Configuration.StandardSequences.earlyDeleteSettings_cff import customiseEarlyDelete
process = customiseEarlyDelete(process)
# End adding early deletion
