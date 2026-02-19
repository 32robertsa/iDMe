ifeq ($(strip $(DPGAnalysisHcalToolsAuto)),)
DPGAnalysisHcalToolsAuto := self/src/DPGAnalysis/HcalTools/plugins
DPGAnalysisHcalToolsAuto_LOC_USE := self cmssw  root DataFormats/HcalDetId DataFormats/HcalDigi DataFormats/HcalRecHit DataFormats/L1GlobalTrigger CondFormats/HcalObjects CondFormats/DataRecord EventFilter/HcalRawToDigi Geometry/CaloGeometry Geometry/HcalCommonData Geometry/Records Geometry/CaloTopology Geometry/HcalTowerAlgo DataFormats/FEDRawData CalibFormats/HcalObjects CalibCalorimetry/HcalAlgos FWCore/ServiceRegistry CommonTools/UtilAlgos
ALL_EXTERNAL_PLUGIN_PRODS += DPGAnalysisHcalToolsAuto
DPGAnalysis/HcalTools_relbigobj+=DPGAnalysisHcalToolsAuto
endif
ifeq ($(strip $(DQM/CastorMonitor)),)
DQMCastorMonitor := self/DQM/CastorMonitor
DQM/CastorMonitor := DQMCastorMonitor
DQMCastorMonitor_BuildFile    := $(RELEASETOP)/.SCRAM/$(SCRAM_ARCH)/MakeData/DirCache.mk
DQMCastorMonitor_EX_USE := $(foreach d, self cmssw  DataFormats/HcalDetId DataFormats/HcalRecHit DataFormats/HcalDigi CondFormats/CastorObjects CalibFormats/CastorObjects DataFormats/JetReco DataFormats/CastorReco Geometry/CaloGeometry FWCore/ParameterSet FWCore/Framework FWCore/MessageLogger DQMServices/Core DataFormats/FEDRawData rootmath,$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
ALL_EXTERNAL_PRODS += DQMCastorMonitor
DQMCastorMonitor_CLASS := LIBRARY
DQM/CastorMonitor_relbigobj+=DQMCastorMonitor
endif
ifeq ($(strip $(DQM/Integration)),)
src_DQM_Integration := self/DQM/Integration
DQM/Integration  := src_DQM_Integration
src_DQM_Integration_BuildFile    := $(RELEASETOP)/.SCRAM/$(SCRAM_ARCH)/MakeData/DirCache.mk
src_DQM_Integration_EX_USE := $(foreach d, self cmssw CoralBase RelationalAccess,$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
ALL_EXTERNAL_PRODS += src_DQM_Integration
endif

ifeq ($(strip $(DetectorDescription/DDCMS)),)
DetectorDescriptionDDCMS := self/DetectorDescription/DDCMS
DetectorDescription/DDCMS := DetectorDescriptionDDCMS
DetectorDescriptionDDCMS_BuildFile    := $(RELEASETOP)/.SCRAM/$(SCRAM_ARCH)/MakeData/DirCache.mk
DetectorDescriptionDDCMS_EX_USE := $(foreach d, self cmssw  FWCore/Framework FWCore/Utilities dd4hep rootmath rootgeom,$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
DetectorDescriptionDDCMS_EX_LIB   := DetectorDescriptionDDCMS
ALL_EXTERNAL_PRODS += DetectorDescriptionDDCMS
DetectorDescriptionDDCMS_CLASS := LIBRARY
DetectorDescription/DDCMS_relbigobj+=DetectorDescriptionDDCMS
endif
ifeq ($(strip $(DetectorDescriptionDD4hepPlugins)),)
DetectorDescriptionDD4hepPlugins := self/src/DetectorDescription/DDCMS/plugins
DetectorDescriptionDD4hepPlugins_LOC_USE := self cmssw  FWCore/Framework FWCore/ParameterSet dd4hep DetectorDescription/DDCMS rootgeom
ALL_EXTERNAL_PLUGIN_PRODS += DetectorDescriptionDD4hepPlugins
DetectorDescription/DDCMS_relbigobj+=DetectorDescriptionDD4hepPlugins
endif
ifeq ($(strip $(DetectorDescriptionPlugins)),)
DetectorDescriptionPlugins := self/src/DetectorDescription/DDCMS/plugins
DetectorDescriptionPlugins_LOC_LIB   := Geom
DetectorDescriptionPlugins_LOC_USE := self cmssw  FWCore/Framework FWCore/ParameterSet dd4hep DetectorDescription/DDCMS CondFormats/Common Geometry/Records MagneticField/Records
ALL_EXTERNAL_PLUGIN_PRODS += DetectorDescriptionPlugins
DetectorDescription/DDCMS_relbigobj+=DetectorDescriptionPlugins
endif
ifeq ($(strip $(DetectorDescriptionTestPlugins)),)
DetectorDescriptionTestPlugins := self/src/DetectorDescription/DDCMS/plugins
DetectorDescriptionTestPlugins_LOC_LIB   := Geom
DetectorDescriptionTestPlugins_LOC_USE := self cmssw  FWCore/Framework FWCore/ParameterSet dd4hep DetectorDescription/DDCMS Geometry/Records
ALL_EXTERNAL_PLUGIN_PRODS += DetectorDescriptionTestPlugins
DetectorDescription/DDCMS_relbigobj+=DetectorDescriptionTestPlugins
endif
ifeq ($(strip $(Fireworks/FWInterface)),)
FireworksFWInterface := self/Fireworks/FWInterface
Fireworks/FWInterface := FireworksFWInterface
FireworksFWInterface_BuildFile    := $(RELEASETOP)/.SCRAM/$(SCRAM_ARCH)/MakeData/DirCache.mk
FireworksFWInterface_EX_USE := $(foreach d, self cmssw  FWCore/Framework DataFormats/Provenance CondFormats/DataRecord CondFormats/RunInfo Fireworks/Core Fireworks/Geometry rootcore rootinteractive rootgeom rooteve rootrgl rootguihtml rootx11 boost_python FWCore/PythonParameterSet DataFormats/Common DataFormats/FWLite FWCore/Common FWCore/ParameterSet FWCore/ServiceRegistry FWCore/Utilities Fireworks/TableWidget,$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
FireworksFWInterface_LCGDICTS  := x 
FireworksFWInterface_EX_LIB   := FireworksFWInterface
ALL_EXTERNAL_PRODS += FireworksFWInterface
FireworksFWInterface_CLASS := LIBRARY
Fireworks/FWInterface_relbigobj+=FireworksFWInterface
endif
ifeq ($(strip $(FireworksFWInterfacePlugin)),)
FireworksFWInterfacePlugin := self/src/Fireworks/FWInterface/plugins
FireworksFWInterfacePlugin_LOC_USE := self cmssw  FWCore/Framework Fireworks/FWInterface SimDataFormats/Track SimDataFormats/TrackingHit SimDataFormats/TrackingAnalysis SimGeneral/TrackingAnalysis TrackingTools/PatternTools rootcore rootgeom rooteve
ALL_EXTERNAL_PLUGIN_PRODS += FireworksFWInterfacePlugin
Fireworks/FWInterface_relbigobj+=FireworksFWInterfacePlugin
endif
ifeq ($(strip $(Fireworks/Geometry)),)
FireworksGeometry := self/Fireworks/Geometry
Fireworks/Geometry := FireworksGeometry
FireworksGeometry_BuildFile    := $(RELEASETOP)/.SCRAM/$(SCRAM_ARCH)/MakeData/DirCache.mk
FireworksGeometry_EX_USE := $(foreach d, self cmssw  FWCore/PluginManager FWCore/Framework Geometry/CommonDetUnit Geometry/CaloGeometry Geometry/HGCalGeometry Geometry/DTGeometry Geometry/CSCGeometry Geometry/RPCGeometry Geometry/GEMGeometry Geometry/TrackerGeometryBuilder Geometry/Records DataFormats/GeometrySurface DataFormats/MuonDetId RecoLocalCalo/HGCalRecAlgos Fireworks/Core rootcore rootgeom rooteve rootphysics,$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
FireworksGeometry_EX_LIB   := FireworksGeometry
ALL_EXTERNAL_PRODS += FireworksGeometry
FireworksGeometry_CLASS := LIBRARY
Fireworks/Geometry_relbigobj+=FireworksGeometry
endif
ifeq ($(strip $(FireworksDisplayGeomPlugin)),)
FireworksDisplayGeomPlugin := self/src/Fireworks/Geometry/plugins
FireworksDisplayGeomPlugin_LOC_USE := self cmssw  FWCore/Framework Fireworks/Geometry Fireworks/Eve rooteve rootgeom rootphysics rootrgl MagneticField/Engine MagneticField/Records
ALL_EXTERNAL_PLUGIN_PRODS += FireworksDisplayGeomPlugin
Fireworks/Geometry_relbigobj+=FireworksDisplayGeomPlugin
endif
ifeq ($(strip $(FireworksGeometryDumpFWRecoGeometryPlugin)),)
FireworksGeometryDumpFWRecoGeometryPlugin := self/src/Fireworks/Geometry/plugins
FireworksGeometryDumpFWRecoGeometryPlugin_LOC_USE := self cmssw  Fireworks/Geometry rooteve rootgeom rootcore FWCore/Framework FWCore/ParameterSet Geometry/CaloGeometry Geometry/DTGeometry Geometry/CSCGeometry Geometry/RPCGeometry Geometry/TrackerGeometryBuilder Geometry/Records
ALL_EXTERNAL_PLUGIN_PRODS += FireworksGeometryDumpFWRecoGeometryPlugin
Fireworks/Geometry_relbigobj+=FireworksGeometryDumpFWRecoGeometryPlugin
endif
ifeq ($(strip $(FireworksGeometryDumpFWTGeoRecoGeometryPlugin)),)
FireworksGeometryDumpFWTGeoRecoGeometryPlugin := self/src/Fireworks/Geometry/plugins
FireworksGeometryDumpFWTGeoRecoGeometryPlugin_LOC_USE := self cmssw  Fireworks/Geometry rooteve rootgeom rootcore FWCore/Framework FWCore/ParameterSet Geometry/CaloGeometry Geometry/DTGeometry Geometry/CSCGeometry Geometry/RPCGeometry Geometry/TrackerGeometryBuilder Geometry/Records
ALL_EXTERNAL_PLUGIN_PRODS += FireworksGeometryDumpFWTGeoRecoGeometryPlugin
Fireworks/Geometry_relbigobj+=FireworksGeometryDumpFWTGeoRecoGeometryPlugin
endif
ifeq ($(strip $(FireworksGeometryDumpSimGeometryPlugin)),)
FireworksGeometryDumpSimGeometryPlugin := self/src/Fireworks/Geometry/plugins
FireworksGeometryDumpSimGeometryPlugin_LOC_USE := self cmssw  Fireworks/Geometry FWCore/Framework FWCore/ParameterSet rootgeom
ALL_EXTERNAL_PLUGIN_PRODS += FireworksGeometryDumpSimGeometryPlugin
Fireworks/Geometry_relbigobj+=FireworksGeometryDumpSimGeometryPlugin
endif
ifeq ($(strip $(FireworksGeometryFWRecoGeometryESProducerPlugin)),)
FireworksGeometryFWRecoGeometryESProducerPlugin := self/src/Fireworks/Geometry/plugins
FireworksGeometryFWRecoGeometryESProducerPlugin_LOC_USE := self cmssw  Fireworks/Geometry
ALL_EXTERNAL_PLUGIN_PRODS += FireworksGeometryFWRecoGeometryESProducerPlugin
Fireworks/Geometry_relbigobj+=FireworksGeometryFWRecoGeometryESProducerPlugin
endif
ifeq ($(strip $(FireworksGeometryFWTGeoRecoGeometryESProducerPlugin)),)
FireworksGeometryFWTGeoRecoGeometryESProducerPlugin := self/src/Fireworks/Geometry/plugins
FireworksGeometryFWTGeoRecoGeometryESProducerPlugin_LOC_USE := self cmssw  Fireworks/Geometry
ALL_EXTERNAL_PLUGIN_PRODS += FireworksGeometryFWTGeoRecoGeometryESProducerPlugin
Fireworks/Geometry_relbigobj+=FireworksGeometryFWTGeoRecoGeometryESProducerPlugin
endif
ifeq ($(strip $(FireworksGeometryMFProducerPlugin)),)
FireworksGeometryMFProducerPlugin := self/src/Fireworks/Geometry/plugins
FireworksGeometryMFProducerPlugin_LOC_USE := self cmssw  FWCore/Framework FWCore/ParameterSet clhep MagneticField/Engine MagneticField/Records rootgpad
ALL_EXTERNAL_PLUGIN_PRODS += FireworksGeometryMFProducerPlugin
Fireworks/Geometry_relbigobj+=FireworksGeometryMFProducerPlugin
endif
ifeq ($(strip $(FireworksGeometryPlugins)),)
FireworksGeometryPlugins := self/src/Fireworks/Geometry/plugins
FireworksGeometryPlugins_LOC_USE := self cmssw  Geometry/Records Fireworks/Geometry rootgpad rooteve rootgeom
ALL_EXTERNAL_PLUGIN_PRODS += FireworksGeometryPlugins
Fireworks/Geometry_relbigobj+=FireworksGeometryPlugins
endif
ifeq ($(strip $(FireworksGeometryTGeoMgrFromDddPlugin)),)
FireworksGeometryTGeoMgrFromDddPlugin := self/src/Fireworks/Geometry/plugins
FireworksGeometryTGeoMgrFromDddPlugin_LOC_USE := self cmssw  DetectorDescription/Core Fireworks/Geometry
ALL_EXTERNAL_PLUGIN_PRODS += FireworksGeometryTGeoMgrFromDddPlugin
Fireworks/Geometry_relbigobj+=FireworksGeometryTGeoMgrFromDddPlugin
endif
ifeq ($(strip $(FireworksGeometryValidateGeometryPlugin)),)
FireworksGeometryValidateGeometryPlugin := self/src/Fireworks/Geometry/plugins
FireworksGeometryValidateGeometryPlugin_LOC_USE := self cmssw  FWCore/Framework Geometry/RPCGeometry Geometry/DTGeometry Geometry/CSCGeometry Geometry/CaloGeometry Geometry/TrackerGeometryBuilder Geometry/Records Fireworks/Core Fireworks/Tracks rootcore rootgeom
ALL_EXTERNAL_PLUGIN_PRODS += FireworksGeometryValidateGeometryPlugin
Fireworks/Geometry_relbigobj+=FireworksGeometryValidateGeometryPlugin
endif
ifeq ($(strip $(Geometry/HGCalCommonData)),)
GeometryHGCalCommonData := self/Geometry/HGCalCommonData
Geometry/HGCalCommonData := GeometryHGCalCommonData
GeometryHGCalCommonData_BuildFile    := $(RELEASETOP)/.SCRAM/$(SCRAM_ARCH)/MakeData/DirCache.mk
GeometryHGCalCommonData_EX_USE := $(foreach d, self cmssw  DataFormats/GeometryVector DataFormats/ForwardDetId DetectorDescription/Core DetectorDescription/DDCMS FWCore/ParameterSet dd4hep,$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
GeometryHGCalCommonData_EX_LIB   := GeometryHGCalCommonData
ALL_EXTERNAL_PRODS += GeometryHGCalCommonData
GeometryHGCalCommonData_CLASS := LIBRARY
Geometry/HGCalCommonData_relbigobj+=GeometryHGCalCommonData
endif
ifeq ($(strip $(DD4hep_GeometryHGCalCommonDataPlugins)),)
DD4hep_GeometryHGCalCommonDataPlugins := self/src/Geometry/HGCalCommonData/plugins
DD4hep_GeometryHGCalCommonDataPlugins_LOC_LIB   := Geom
DD4hep_GeometryHGCalCommonDataPlugins_LOC_USE := self cmssw  DetectorDescription/DDCMS Geometry/HGCalCommonData dd4hep
ALL_EXTERNAL_PLUGIN_PRODS += DD4hep_GeometryHGCalCommonDataPlugins
Geometry/HGCalCommonData_relbigobj+=DD4hep_GeometryHGCalCommonDataPlugins
endif
ifeq ($(strip $(GeometryHGCalCommonDataESModules)),)
GeometryHGCalCommonDataESModules := self/src/Geometry/HGCalCommonData/plugins
GeometryHGCalCommonDataESModules_LOC_USE := self cmssw  DetectorDescription/Core DetectorDescription/DDCMS FWCore/Framework FWCore/MessageLogger FWCore/ParameterSet FWCore/PluginManager Geometry/HGCalCommonData Geometry/Records dd4hep
ALL_EXTERNAL_PLUGIN_PRODS += GeometryHGCalCommonDataESModules
Geometry/HGCalCommonData_relbigobj+=GeometryHGCalCommonDataESModules
endif
ifeq ($(strip $(GeometryHGCalCommonDataFastTimeESModules)),)
GeometryHGCalCommonDataFastTimeESModules := self/src/Geometry/HGCalCommonData/plugins
GeometryHGCalCommonDataFastTimeESModules_LOC_USE := self cmssw  DetectorDescription/Core FWCore/Framework FWCore/MessageLogger FWCore/ParameterSet FWCore/PluginManager Geometry/HGCalCommonData Geometry/Records
ALL_EXTERNAL_PLUGIN_PRODS += GeometryHGCalCommonDataFastTimeESModules
Geometry/HGCalCommonData_relbigobj+=GeometryHGCalCommonDataFastTimeESModules
endif
ifeq ($(strip $(GeometryHGCalCommonDataPlugin)),)
GeometryHGCalCommonDataPlugin := self/src/Geometry/HGCalCommonData/plugins
GeometryHGCalCommonDataPlugin_LOC_USE := self cmssw  DetectorDescription/Core FWCore/Framework FWCore/MessageLogger FWCore/ParameterSet FWCore/PluginManager Geometry/HGCalCommonData Geometry/Records
ALL_EXTERNAL_PLUGIN_PRODS += GeometryHGCalCommonDataPlugin
Geometry/HGCalCommonData_relbigobj+=GeometryHGCalCommonDataPlugin
endif
ifeq ($(strip $(Geometry/HGCalGeometry)),)
GeometryHGCalGeometry := self/Geometry/HGCalGeometry
Geometry/HGCalGeometry := GeometryHGCalGeometry
GeometryHGCalGeometry_BuildFile    := $(RELEASETOP)/.SCRAM/$(SCRAM_ARCH)/MakeData/DirCache.mk
GeometryHGCalGeometry_EX_USE := $(foreach d, self cmssw  DataFormats/ForwardDetId DataFormats/Common Geometry/CaloGeometry Geometry/CaloTopology Geometry/HGCalCommonData MagneticField/Engine TrackingTools/TrajectoryState TrackingTools/GeomPropagators,$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
GeometryHGCalGeometry_EX_LIB   := GeometryHGCalGeometry
ALL_EXTERNAL_PRODS += GeometryHGCalGeometry
GeometryHGCalGeometry_CLASS := LIBRARY
Geometry/HGCalGeometry_relbigobj+=GeometryHGCalGeometry
endif
ifeq ($(strip $(GeometryHGCalGeometryPlugins)),)
GeometryHGCalGeometryPlugins := self/src/Geometry/HGCalGeometry/plugins
GeometryHGCalGeometryPlugins_LOC_USE := self cmssw  FWCore/Framework FWCore/ParameterSet Geometry/HGCalGeometry Geometry/CaloTopology Geometry/Records
ALL_EXTERNAL_PLUGIN_PRODS += GeometryHGCalGeometryPlugins
Geometry/HGCalGeometry_relbigobj+=GeometryHGCalGeometryPlugins
endif
ifeq ($(strip $(Geometry/HcalCommonData)),)
GeometryHcalCommonData := self/Geometry/HcalCommonData
Geometry/HcalCommonData := GeometryHcalCommonData
GeometryHcalCommonData_BuildFile    := $(RELEASETOP)/.SCRAM/$(SCRAM_ARCH)/MakeData/DirCache.mk
GeometryHcalCommonData_EX_USE := $(foreach d, self cmssw  DetectorDescription/Core DetectorDescription/DDCMS DataFormats/HcalDetId CondFormats/GeometryObjects DataFormats/DetId DataFormats/Math DetectorDescription/RegressionTest FWCore/MessageLogger FWCore/ParameterSet FWCore/Utilities SimDataFormats/CaloHit dd4hep clhep,$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
GeometryHcalCommonData_EX_LIB   := GeometryHcalCommonData
ALL_EXTERNAL_PRODS += GeometryHcalCommonData
GeometryHcalCommonData_CLASS := LIBRARY
Geometry/HcalCommonData_relbigobj+=GeometryHcalCommonData
endif
ifeq ($(strip $(GeometryHcalCommonDataPlugins)),)
GeometryHcalCommonDataPlugins := self/src/Geometry/HcalCommonData/plugins
GeometryHcalCommonDataPlugins_LOC_USE := self cmssw  FWCore/Framework FWCore/ParameterSet Geometry/Records Geometry/HcalCommonData DetectorDescription/Core DetectorDescription/DDCMS CondFormats/GeometryObjects
ALL_EXTERNAL_PLUGIN_PRODS += GeometryHcalCommonDataPlugins
Geometry/HcalCommonData_relbigobj+=GeometryHcalCommonDataPlugins
endif
ifeq ($(strip $(Geometry/HcalTowerAlgo)),)
GeometryHcalTowerAlgo := self/Geometry/HcalTowerAlgo
Geometry/HcalTowerAlgo := GeometryHcalTowerAlgo
GeometryHcalTowerAlgo_BuildFile    := $(RELEASETOP)/.SCRAM/$(SCRAM_ARCH)/MakeData/DirCache.mk
GeometryHcalTowerAlgo_EX_USE := $(foreach d, self cmssw  Geometry/CaloGeometry Geometry/CaloTopology Geometry/HcalCommonData DataFormats/HcalDetId DataFormats/CaloTowers FWCore/MessageLogger FWCore/ParameterSet clhep boost_serialization,$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
GeometryHcalTowerAlgo_EX_LIB   := GeometryHcalTowerAlgo
ALL_EXTERNAL_PRODS += GeometryHcalTowerAlgo
GeometryHcalTowerAlgo_CLASS := LIBRARY
Geometry/HcalTowerAlgo_relbigobj+=GeometryHcalTowerAlgo
endif
ifeq ($(strip $(GeometryHcalTowerAlgoPlugins)),)
GeometryHcalTowerAlgoPlugins := self/src/Geometry/HcalTowerAlgo/plugins
GeometryHcalTowerAlgoPlugins_LOC_USE := self cmssw  FWCore/Framework Geometry/Records Geometry/HcalTowerAlgo
ALL_EXTERNAL_PLUGIN_PRODS += GeometryHcalTowerAlgoPlugins
Geometry/HcalTowerAlgo_relbigobj+=GeometryHcalTowerAlgoPlugins
endif
ifeq ($(strip $(DD4hep_GeometryMuonCommonDataPlugins)),)
DD4hep_GeometryMuonCommonDataPlugins := self/src/Geometry/MuonCommonData/plugins
DD4hep_GeometryMuonCommonDataPlugins_LOC_LIB   := Geom
DD4hep_GeometryMuonCommonDataPlugins_LOC_USE := self cmssw  DetectorDescription/DDCMS dd4hep
ALL_EXTERNAL_PLUGIN_PRODS += DD4hep_GeometryMuonCommonDataPlugins
Geometry/MuonCommonData_relbigobj+=DD4hep_GeometryMuonCommonDataPlugins
endif
ifeq ($(strip $(GeometryMuonCommonDataPlugin)),)
GeometryMuonCommonDataPlugin := self/src/Geometry/MuonCommonData/plugins
GeometryMuonCommonDataPlugin_LOC_USE := self cmssw  DetectorDescription/Core FWCore/PluginManager
ALL_EXTERNAL_PLUGIN_PRODS += GeometryMuonCommonDataPlugin
Geometry/MuonCommonData_relbigobj+=GeometryMuonCommonDataPlugin
endif
ifeq ($(strip $(Geometry/TrackerGeometryBuilder)),)
GeometryTrackerGeometryBuilder := self/Geometry/TrackerGeometryBuilder
Geometry/TrackerGeometryBuilder := GeometryTrackerGeometryBuilder
GeometryTrackerGeometryBuilder_BuildFile    := $(RELEASETOP)/.SCRAM/$(SCRAM_ARCH)/MakeData/DirCache.mk
GeometryTrackerGeometryBuilder_EX_USE := $(foreach d, self cmssw  DataFormats/GeometrySurface DataFormats/SiPixelDetId DataFormats/TrackerCommon DetectorDescription/Core FWCore/MessageLogger FWCore/Utilities Geometry/CommonDetUnit Geometry/CommonTopologies Geometry/TrackerNumberingBuilder CondFormats/GeometryObjects DataFormats/DetId DataFormats/SiStripDetId DetectorDescription/DDCMS clhep,$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
GeometryTrackerGeometryBuilder_EX_LIB   := GeometryTrackerGeometryBuilder
ALL_EXTERNAL_PRODS += GeometryTrackerGeometryBuilder
GeometryTrackerGeometryBuilder_CLASS := LIBRARY
Geometry/TrackerGeometryBuilder_relbigobj+=GeometryTrackerGeometryBuilder
endif
ifeq ($(strip $(GeometryTrackerGeometryBuilderPlugins)),)
GeometryTrackerGeometryBuilderPlugins := self/src/Geometry/TrackerGeometryBuilder/plugins
GeometryTrackerGeometryBuilderPlugins_LOC_USE := self cmssw  CondFormats/Alignment CondFormats/GeometryObjects CondFormats/AlignmentRecord DetectorDescription/Core FWCore/Framework FWCore/ParameterSet Geometry/Records Geometry/TrackerGeometryBuilder Geometry/TrackerNumberingBuilder
ALL_EXTERNAL_PLUGIN_PRODS += GeometryTrackerGeometryBuilderPlugins
Geometry/TrackerGeometryBuilder_relbigobj+=GeometryTrackerGeometryBuilderPlugins
endif
ifeq ($(strip $(L1Trigger/GlobalTriggerAnalyzer)),)
L1TriggerGlobalTriggerAnalyzer := self/L1Trigger/GlobalTriggerAnalyzer
L1Trigger/GlobalTriggerAnalyzer := L1TriggerGlobalTriggerAnalyzer
L1TriggerGlobalTriggerAnalyzer_BuildFile    := $(RELEASETOP)/.SCRAM/$(SCRAM_ARCH)/MakeData/DirCache.mk
L1TriggerGlobalTriggerAnalyzer_EX_USE := $(foreach d, self cmssw  FWCore/Framework FWCore/ParameterSet FWCore/Utilities DataFormats/Common DataFormats/L1GlobalTrigger DataFormats/L1GlobalMuonTrigger DataFormats/L1GlobalCaloTrigger DataFormats/Provenance DataFormats/L1Trigger CondFormats/L1TObjects CondFormats/DataRecord CommonTools/UtilAlgos,$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
L1TriggerGlobalTriggerAnalyzer_EX_LIB   := L1TriggerGlobalTriggerAnalyzer
ALL_EXTERNAL_PRODS += L1TriggerGlobalTriggerAnalyzer
L1TriggerGlobalTriggerAnalyzer_CLASS := LIBRARY
L1Trigger/GlobalTriggerAnalyzer_relbigobj+=L1TriggerGlobalTriggerAnalyzer
endif
ifeq ($(strip $(L1TriggerGlobalTriggerAnalyzerPlugins)),)
L1TriggerGlobalTriggerAnalyzerPlugins := self/src/L1Trigger/GlobalTriggerAnalyzer/plugins
L1TriggerGlobalTriggerAnalyzerPlugins_LOC_USE := self cmssw  FWCore/Framework L1Trigger/GlobalTriggerAnalyzer
ALL_EXTERNAL_PLUGIN_PRODS += L1TriggerGlobalTriggerAnalyzerPlugins
L1Trigger/GlobalTriggerAnalyzer_relbigobj+=L1TriggerGlobalTriggerAnalyzerPlugins
endif
ifeq ($(strip $(SimG4CMS/Calo)),)
SimG4CMSCalo := self/SimG4CMS/Calo
SimG4CMS/Calo := SimG4CMSCalo
SimG4CMSCalo_BuildFile    := $(RELEASETOP)/.SCRAM/$(SCRAM_ARCH)/MakeData/DirCache.mk
SimG4CMSCalo_EX_USE := $(foreach d, self cmssw  FWCore/PluginManager SimGeneral/GFlash SimG4Core/SensitiveDetector SimG4Core/Notification DataFormats/EcalDetId DataFormats/HcalDetId DataFormats/ForwardDetId DataFormats/Math CondFormats/GeometryObjects CondFormats/HcalObjects SimDataFormats/SimHitMaker SimDataFormats/CaloHit SimDataFormats/CaloTest Geometry/HcalCommonData Geometry/EcalCommonData Geometry/HGCalCommonData Geometry/Records FWCore/ParameterSet FWCore/MessageLogger FWCore/ServiceRegistry CommonTools/UtilAlgos boost clhep dd4hep geant4core hepmc root rootmath,$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
SimG4CMSCalo_EX_LIB   := SimG4CMSCalo
ALL_EXTERNAL_PRODS += SimG4CMSCalo
SimG4CMSCalo_CLASS := LIBRARY
SimG4CMS/Calo_relbigobj+=SimG4CMSCalo
endif
ifeq ($(strip $(SimG4CMSCaloPlugins)),)
SimG4CMSCaloPlugins := self/src/SimG4CMS/Calo/plugins
SimG4CMSCaloPlugins_LOC_USE := self cmssw  CommonTools/UtilAlgos CondFormats/DataRecord DataFormats/EcalDetId DataFormats/HcalDetId FWCore/Framework FWCore/ParameterSet FWCore/MessageLogger FWCore/PluginManager FWCore/ServiceRegistry Geometry/HcalCommonData Geometry/HcalTowerAlgo Geometry/HGCalGeometry Geometry/CaloTopology Geometry/Records SimDataFormats/CaloHit SimDataFormats/Track SimDataFormats/Vertex SimDataFormats/GeneratorProducts SimG4Core/Watcher SimG4CMS/Calo boost root clhep geant4core
ALL_EXTERNAL_PLUGIN_PRODS += SimG4CMSCaloPlugins
SimG4CMS/Calo_relbigobj+=SimG4CMSCaloPlugins
endif
ifeq ($(strip $(SimG4CMS/Forward)),)
SimG4CMSForward := self/SimG4CMS/Forward
SimG4CMS/Forward := SimG4CMSForward
SimG4CMSForward_BuildFile    := $(RELEASETOP)/.SCRAM/$(SCRAM_ARCH)/MakeData/DirCache.mk
SimG4CMSForward_EX_USE := $(foreach d, self cmssw  FWCore/Framework FWCore/ParameterSet FWCore/MessageLogger SimG4Core/SensitiveDetector SimG4Core/Notification SimG4Core/Physics SimG4CMS/Calo DataFormats/ForwardDetId DataFormats/Math SimDataFormats/SimHitMaker SimDataFormats/CaloHit Geometry/MTDCommonData boost clhep geant4core root rootmath,$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
SimG4CMSForward_EX_LIB   := SimG4CMSForward
ALL_EXTERNAL_PRODS += SimG4CMSForward
SimG4CMSForward_CLASS := LIBRARY
SimG4CMS/Forward_relbigobj+=SimG4CMSForward
endif
ifeq ($(strip $(SimG4CMSForwardPlugins)),)
SimG4CMSForwardPlugins := self/src/SimG4CMS/Forward/plugins
SimG4CMSForwardPlugins_LOC_USE := self cmssw  FWCore/PluginManager SimG4Core/Watcher SimG4Core/SensitiveDetector SimG4Core/Notification SimG4CMS/Forward SimDataFormats/CaloTest SimDataFormats/Forward FWCore/Framework FWCore/ParameterSet FWCore/MessageLogger geant4core root rootmath
ALL_EXTERNAL_PLUGIN_PRODS += SimG4CMSForwardPlugins
SimG4CMS/Forward_relbigobj+=SimG4CMSForwardPlugins
endif
ifeq ($(strip $(Validation/HGCalValidation)),)
ValidationHGCalValidation := self/Validation/HGCalValidation
Validation/HGCalValidation := ValidationHGCalValidation
ValidationHGCalValidation_BuildFile    := $(RELEASETOP)/.SCRAM/$(SCRAM_ARCH)/MakeData/DirCache.mk
ValidationHGCalValidation_EX_USE := $(foreach d, self cmssw  DataFormats/ForwardDetId DataFormats/HepMCCandidate DataFormats/ParticleFlowCandidate DQMServices/Core FWCore/Framework FWCore/ParameterSet FWCore/MessageLogger SimDataFormats/CaloAnalysis RecoLocalCalo/HGCalRecAlgos RecoLocalCalo/HGCalRecProducers geant4core clhep hepmc,$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
ValidationHGCalValidation_LCGDICTS  := x 
ValidationHGCalValidation_EX_LIB   := ValidationHGCalValidation
ALL_EXTERNAL_PRODS += ValidationHGCalValidation
ValidationHGCalValidation_CLASS := LIBRARY
Validation/HGCalValidation_relbigobj+=ValidationHGCalValidation
endif
ifeq ($(strip $(ValidationHGCalValidationAuto)),)
ValidationHGCalValidationAuto := self/src/Validation/HGCalValidation/plugins
ValidationHGCalValidationAuto_LOC_USE := self cmssw  DataFormats/ForwardDetId DataFormats/HcalDetId DataFormats/ParticleFlowCandidate DataFormats/Common DataFormats/L1THGCal DetectorDescription/Core DetectorDescription/DDCMS DQMServices/Core FWCore/Common FWCore/Framework FWCore/MessageLogger FWCore/ParameterSet FWCore/PluginManager FWCore/ServiceRegistry FWCore/Utilities Geometry/HGCalCommonData Geometry/HGCalGeometry Geometry/Records L1Trigger/L1THGCal SimDataFormats/CaloHit SimDataFormats/CaloTest SimDataFormats/CaloAnalysis SimDataFormats/GeneratorProducts SimDataFormats/Track SimDataFormats/ValidationFormats SimG4Core/Notification SimG4Core/Watcher SimG4CMS/Calo RecoLocalCalo/HGCalRecAlgos Validation/HGCalValidation geant4core dd4hep clhep hepmc cuda
ALL_EXTERNAL_PLUGIN_PRODS += ValidationHGCalValidationAuto
Validation/HGCalValidation_relbigobj+=ValidationHGCalValidationAuto
endif
ifeq ($(strip $(DQMOffline/Trigger)),)
DQMOfflineTrigger := self/DQMOffline/Trigger
DQMOffline/Trigger := DQMOfflineTrigger
DQMOfflineTrigger_BuildFile    := $(RELEASETOP)/.SCRAM/$(SCRAM_ARCH)/MakeData/DirCache.mk
DQMOfflineTrigger_EX_USE := $(foreach d, self cmssw  CommonTools/TriggerUtils CommonTools/Utils DQMServices/Core DataFormats/CaloTowers DataFormats/EgammaCandidates DataFormats/EgammaReco DataFormats/HLTReco DataFormats/HeavyIonEvent DataFormats/JetReco DataFormats/METReco DataFormats/MuonReco DataFormats/TauReco DataFormats/TrackReco FWCore/Framework FWCore/ParameterSet FWCore/ServiceRegistry FWCore/Utilities HLTrigger/HLTcore RecoEcal/EgammaCoreTools RecoEgamma/EgammaIsolationAlgos RecoJets/JetProducers MagneticField/Engine MagneticField/Records root boost,$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
DQMOfflineTrigger_EX_LIB   := DQMOfflineTrigger
ALL_EXTERNAL_PRODS += DQMOfflineTrigger
DQMOfflineTrigger_CLASS := LIBRARY
DQMOffline/Trigger_relbigobj+=DQMOfflineTrigger
endif
ifeq ($(strip $(DQMOfflineTriggerPlugins)),)
DQMOfflineTriggerPlugins := self/src/DQMOffline/Trigger/plugins
DQMOfflineTriggerPlugins_LOC_USE := self cmssw  FWCore/Framework FWCore/ParameterSet FWCore/ServiceRegistry DataFormats/HLTReco DataFormats/MuonReco DataFormats/EgammaCandidates DataFormats/TrackReco DataFormats/BTauReco DataFormats/TauReco DataFormats/METReco DataFormats/JetReco CommonTools/Egamma RecoVertex/KalmanVertexFit HLTrigger/HLTcore DQMServices/Core CommonTools/CandUtils CommonTools/Utils CommonTools/TriggerUtils DataFormats/VertexReco DQMOffline/Trigger TrackingTools/TransientTrack root roofit boost
ALL_EXTERNAL_PLUGIN_PRODS += DQMOfflineTriggerPlugins
DQMOffline/Trigger_relbigobj+=DQMOfflineTriggerPlugins
endif
ifeq ($(strip $(FWCore/Framework)),)
FWCoreFramework := self/FWCore/Framework
FWCore/Framework := FWCoreFramework
FWCoreFramework_BuildFile    := $(RELEASETOP)/.SCRAM/$(SCRAM_ARCH)/MakeData/DirCache.mk
FWCoreFramework_EX_USE := $(foreach d, self cmssw  DataFormats/Common DataFormats/Provenance FWCore/Common FWCore/Concurrency FWCore/MessageLogger FWCore/ParameterSet FWCore/PluginManager FWCore/ServiceRegistry FWCore/Reflection FWCore/Utilities FWCore/Version boost rootcore,$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
FWCoreFramework_EX_LIB   := FWCoreFramework
ALL_EXTERNAL_PRODS += FWCoreFramework
FWCoreFramework_CLASS := LIBRARY
FWCore/Framework_relbigobj+=FWCoreFramework
endif
ifeq ($(strip $(FWCore/ParameterSet)),)
FWCoreParameterSet := self/FWCore/ParameterSet
FWCore/ParameterSet := FWCoreParameterSet
FWCoreParameterSet_BuildFile    := $(RELEASETOP)/.SCRAM/$(SCRAM_ARCH)/MakeData/DirCache.mk
FWCoreParameterSet_EX_USE := $(foreach d, self cmssw  DataFormats/Provenance FWCore/MessageLogger FWCore/PluginManager FWCore/Utilities tbb boost,$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
FWCoreParameterSet_EX_LIB   := FWCoreParameterSet
ALL_EXTERNAL_PRODS += FWCoreParameterSet
FWCoreParameterSet_CLASS := LIBRARY
FWCore/ParameterSet_relbigobj+=FWCoreParameterSet
endif
ifeq ($(strip $(FWCore/Version)),)
FWCoreVersion := self/FWCore/Version
FWCore/Version := FWCoreVersion
FWCoreVersion_BuildFile    := $(RELEASETOP)/.SCRAM/$(SCRAM_ARCH)/MakeData/DirCache.mk
FWCoreVersion_EX_USE := $(foreach d, self cmssw  ,$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
FWCoreVersion_EX_LIB   := FWCoreVersion
ALL_EXTERNAL_PRODS += FWCoreVersion
FWCoreVersion_CLASS := LIBRARY
FWCore/Version_relbigobj+=FWCoreVersion
endif
ifeq ($(strip $(FastSimulation/SimplifiedGeometryPropagator)),)
FastSimulationSimplifiedGeometryPropagator := self/FastSimulation/SimplifiedGeometryPropagator
FastSimulation/SimplifiedGeometryPropagator := FastSimulationSimplifiedGeometryPropagator
FastSimulationSimplifiedGeometryPropagator_BuildFile    := $(RELEASETOP)/.SCRAM/$(SCRAM_ARCH)/MakeData/DirCache.mk
FastSimulationSimplifiedGeometryPropagator_EX_USE := $(foreach d, self cmssw  FWCore/Framework FWCore/ParameterSet FWCore/Utilities FWCore/PluginManager DataFormats/GeometryVector SimDataFormats/Track SimDataFormats/Vertex DataFormats/Math MagneticField/Engine MagneticField/Records RecoTracker/Record RecoTracker/TkDetLayers FWCore/ServiceRegistry GeneratorInterface/Pythia8Interface pythia8 heppdt clhep hepmc rootcore geant4core,$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
FastSimulationSimplifiedGeometryPropagator_EX_LIB   := FastSimulationSimplifiedGeometryPropagator
ALL_EXTERNAL_PRODS += FastSimulationSimplifiedGeometryPropagator
FastSimulationSimplifiedGeometryPropagator_CLASS := LIBRARY
FastSimulation/SimplifiedGeometryPropagator_relbigobj+=FastSimulationSimplifiedGeometryPropagator
endif
ifeq ($(strip $(FastSimulationSimplifiedGeometryPropagatorAuto)),)
FastSimulationSimplifiedGeometryPropagatorAuto := self/src/FastSimulation/SimplifiedGeometryPropagator/plugins
FastSimulationSimplifiedGeometryPropagatorAuto_LOC_USE := self cmssw  FWCore/Framework FWCore/ParameterSet TrackingTools/DetLayers TrackingTools/TrajectoryState TrackingTools/GeomPropagators RecoTracker/DeDx FastSimulation/TrajectoryManager FastSimulation/SimplifiedGeometryPropagator FastSimulation/Calorimetry FastSimulation/CaloGeometryTools FastSimulation/ShowerDevelopment Geometry/Records Geometry/CaloGeometry DataFormats/Math hepmc clhep
ALL_EXTERNAL_PLUGIN_PRODS += FastSimulationSimplifiedGeometryPropagatorAuto
FastSimulation/SimplifiedGeometryPropagator_relbigobj+=FastSimulationSimplifiedGeometryPropagatorAuto
endif
ifeq ($(strip $(GeneratorInterface/Pythia8Interface)),)
GeneratorInterfacePythia8Interface := self/GeneratorInterface/Pythia8Interface
GeneratorInterface/Pythia8Interface := GeneratorInterfacePythia8Interface
GeneratorInterfacePythia8Interface_BuildFile    := $(RELEASETOP)/.SCRAM/$(SCRAM_ARCH)/MakeData/DirCache.mk
GeneratorInterfacePythia8Interface_EX_USE := $(foreach d, self cmssw  FWCore/Concurrency FWCore/Framework FWCore/MessageLogger FWCore/Utilities SimDataFormats/GeneratorProducts GeneratorInterface/Core boost pythia8 evtgen hepmc clhep root,$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
GeneratorInterfacePythia8Interface_EX_LIB   := GeneratorInterfacePythia8Interface
ALL_EXTERNAL_PRODS += GeneratorInterfacePythia8Interface
GeneratorInterfacePythia8Interface_CLASS := LIBRARY
GeneratorInterface/Pythia8Interface_relbigobj+=GeneratorInterfacePythia8Interface
endif
ifeq ($(strip $(GeneratorInterfacePythia8Filters)),)
GeneratorInterfacePythia8Filters := self/src/GeneratorInterface/Pythia8Interface/plugins
GeneratorInterfacePythia8Filters_LOC_USE := self cmssw  GeneratorInterface/Pythia8Interface GeneratorInterface/PartonShowerVeto GeneratorInterface/ExternalDecays FWCore/Concurrency FWCore/MessageLogger FWCore/ParameterSet FWCore/ServiceRegistry FWCore/Utilities GeneratorInterface/Core hepmc pythia8 SimDataFormats/GeneratorProducts
ALL_EXTERNAL_PLUGIN_PRODS += GeneratorInterfacePythia8Filters
GeneratorInterface/Pythia8Interface_relbigobj+=GeneratorInterfacePythia8Filters
endif
ifeq ($(strip $(GeneratorInterfacePythia8Guns)),)
GeneratorInterfacePythia8Guns := self/src/GeneratorInterface/Pythia8Interface/plugins
GeneratorInterfacePythia8Guns_LOC_USE := self cmssw  GeneratorInterface/Pythia8Interface GeneratorInterface/ExternalDecays
ALL_EXTERNAL_PLUGIN_PRODS += GeneratorInterfacePythia8Guns
GeneratorInterface/Pythia8Interface_relbigobj+=GeneratorInterfacePythia8Guns
endif
ifeq ($(strip $(GeneratorInterfacePythia8JetMatchingFxFxHook)),)
GeneratorInterfacePythia8JetMatchingFxFxHook := self/src/GeneratorInterface/Pythia8Interface/plugins
GeneratorInterfacePythia8JetMatchingFxFxHook_LOC_USE := self cmssw  GeneratorInterface/Pythia8Interface
ALL_EXTERNAL_PLUGIN_PRODS += GeneratorInterfacePythia8JetMatchingFxFxHook
GeneratorInterface/Pythia8Interface_relbigobj+=GeneratorInterfacePythia8JetMatchingFxFxHook
endif
ifeq ($(strip $(GeneratorInterfacePythia8SLHAReader)),)
GeneratorInterfacePythia8SLHAReader := self/src/GeneratorInterface/Pythia8Interface/plugins
GeneratorInterfacePythia8SLHAReader_LOC_USE := self cmssw  GeneratorInterface/Pythia8Interface root
ALL_EXTERNAL_PLUGIN_PRODS += GeneratorInterfacePythia8SLHAReader
GeneratorInterface/Pythia8Interface_relbigobj+=GeneratorInterfacePythia8SLHAReader
endif
ifeq ($(strip $(GeneratorInterfacePythia8SUEPHook)),)
GeneratorInterfacePythia8SUEPHook := self/src/GeneratorInterface/Pythia8Interface/plugins
GeneratorInterfacePythia8SUEPHook_LOC_USE := self cmssw  GeneratorInterface/Pythia8Interface
ALL_EXTERNAL_PLUGIN_PRODS += GeneratorInterfacePythia8SUEPHook
GeneratorInterface/Pythia8Interface_relbigobj+=GeneratorInterfacePythia8SUEPHook
endif
ifeq ($(strip $(IOPool/Input)),)
IOPoolInput := self/IOPool/Input
IOPool/Input := IOPoolInput
IOPoolInput_BuildFile    := $(RELEASETOP)/.SCRAM/$(SCRAM_ARCH)/MakeData/DirCache.mk
IOPoolInput_EX_USE := $(foreach d, self cmssw  DataFormats/Common DataFormats/Provenance FWCore/Catalog FWCore/Framework FWCore/MessageLogger FWCore/ParameterSet FWCore/ServiceRegistry FWCore/Sources FWCore/Utilities IOPool/Common Utilities/StorageFactory clhep rootcore,$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
ALL_EXTERNAL_PRODS += IOPoolInput
IOPoolInput_CLASS := LIBRARY
IOPool/Input_relbigobj+=IOPoolInput
endif
ifeq ($(strip $(OnlineDB/Oracle)),)
OnlineDBOracle := self/OnlineDB/Oracle
OnlineDB/Oracle := OnlineDBOracle
OnlineDBOracle_BuildFile    := $(RELEASETOP)/.SCRAM/$(SCRAM_ARCH)/MakeData/DirCache.mk
OnlineDBOracle_EX_USE := $(foreach d, self cmssw  oracle oracleocci,$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
OnlineDBOracle_EX_LIB   := OnlineDBOracle
ALL_EXTERNAL_PRODS += OnlineDBOracle
OnlineDBOracle_CLASS := LIBRARY
OnlineDB/Oracle_relbigobj+=OnlineDBOracle
endif
ifeq ($(strip $(PhysicsTools/PatAlgos)),)
PhysicsToolsPatAlgos := self/PhysicsTools/PatAlgos
PhysicsTools/PatAlgos := PhysicsToolsPatAlgos
PhysicsToolsPatAlgos_BuildFile    := $(RELEASETOP)/.SCRAM/$(SCRAM_ARCH)/MakeData/DirCache.mk
PhysicsToolsPatAlgos_EX_USE := $(foreach d, self cmssw  CommonTools/CandAlgos CommonTools/MVAUtils DataFormats/Candidate DataFormats/Common DataFormats/JetReco DataFormats/Math DataFormats/MuonReco DataFormats/PatCandidates DataFormats/TrackReco DataFormats/VertexReco JetMETCorrections/JetCorrector FWCore/Framework FWCore/ParameterSet FWCore/Utilities PhysicsTools/IsolationAlgos PhysicsTools/PatUtils PhysicsTools/TensorFlow PhysicsTools/ONNXRuntime TrackingTools/Records clhep,$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
PhysicsToolsPatAlgos_EX_LIB   := PhysicsToolsPatAlgos
ALL_EXTERNAL_PRODS += PhysicsToolsPatAlgos
PhysicsToolsPatAlgos_CLASS := LIBRARY
PhysicsTools/PatAlgos_relbigobj+=PhysicsToolsPatAlgos
endif
ifeq ($(strip $(PhysicsToolsPatAlgos_plugins)),)
PhysicsToolsPatAlgos_plugins := self/src/PhysicsTools/PatAlgos/plugins
PhysicsToolsPatAlgos_plugins_LOC_USE := self cmssw  PhysicsTools/PatAlgos FWCore/Framework FWCore/ParameterSet FWCore/MessageLogger L1Trigger/GlobalTriggerAnalyzer HLTrigger/HLTcore DataFormats/PatCandidates DataFormats/BTauReco DataFormats/Common DataFormats/JetMatching DataFormats/JetReco DataFormats/MuonReco DataFormats/TrackReco DataFormats/Candidate DataFormats/HeavyIonEvent DataFormats/HepMCCandidate PhysicsTools/PatUtils CondFormats/JetMETObjects CondFormats/HcalObjects CondFormats/DataRecord CommonTools/Egamma JetMETCorrections/Objects JetMETCorrections/JetCorrector TrackingTools/TransientTrack RecoEgamma/EgammaTools SimDataFormats/Track SimDataFormats/Vertex SimDataFormats/PileupSummaryInfo SimGeneral/HepPDTRecord RecoMET/METAlgorithms RecoTracker/DeDx TrackingTools/IPTools TrackingTools/Records RecoTauTag/RecoTau root
ALL_EXTERNAL_PLUGIN_PRODS += PhysicsToolsPatAlgos_plugins
PhysicsTools/PatAlgos_relbigobj+=PhysicsToolsPatAlgos_plugins
endif
ifeq ($(strip $(PhysicsTools/NanoAOD)),)
src_PhysicsTools_NanoAOD := self/PhysicsTools/NanoAOD
PhysicsTools/NanoAOD  := src_PhysicsTools_NanoAOD
src_PhysicsTools_NanoAOD_BuildFile    := $(RELEASETOP)/.SCRAM/$(SCRAM_ARCH)/MakeData/DirCache.mk
src_PhysicsTools_NanoAOD_EX_USE := $(foreach d, self cmssw DataFormats/Common DataFormats/NanoAOD boost,$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
ALL_EXTERNAL_PRODS += src_PhysicsTools_NanoAOD
endif

ifeq ($(strip $(PhysicsToolsNanoAODPlugins)),)
PhysicsToolsNanoAODPlugins := self/src/PhysicsTools/NanoAOD/plugins
PhysicsToolsNanoAODPlugins_LOC_USE := self cmssw  FWCore/Framework FWCore/ParameterSet FWCore/ServiceRegistry FWCore/Utilities DataFormats/Candidate DataFormats/PatCandidates CommonTools/Egamma PhysicsTools/PatAlgos DataFormats/NanoAOD roothistmatrix RecoVertex/VertexTools RecoVertex/VertexPrimitives DataFormats/L1TGlobal IOPool/Provenance DQMServices/Core CondFormats/BTauObjects CondFormats/L1TObjects CondTools/BTau DataFormats/CTPPSDetId DataFormats/CTPPSReco DataFormats/ProtonReco CondFormats/RunInfo CondFormats/DataRecord fastjet fastjet-contrib
ALL_EXTERNAL_PLUGIN_PRODS += PhysicsToolsNanoAODPlugins
PhysicsTools/NanoAOD_relbigobj+=PhysicsToolsNanoAODPlugins
endif
ifeq ($(strip $(Utilities/StorageFactory)),)
UtilitiesStorageFactory := self/Utilities/StorageFactory
Utilities/StorageFactory := UtilitiesStorageFactory
UtilitiesStorageFactory_BuildFile    := $(RELEASETOP)/.SCRAM/$(SCRAM_ARCH)/MakeData/DirCache.mk
UtilitiesStorageFactory_LOC_FLAGS_CPPFLAGS   := -D_FILE_OFFSET_BITS=64
UtilitiesStorageFactory_EX_USE := $(foreach d, self cmssw  FWCore/PluginManager FWCore/MessageLogger FWCore/Utilities FWCore/ServiceRegistry FWCore/Version boost openssl tbb,$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
UtilitiesStorageFactory_EX_LIB   := UtilitiesStorageFactory
ALL_EXTERNAL_PRODS += UtilitiesStorageFactory
UtilitiesStorageFactory_CLASS := LIBRARY
Utilities/StorageFactory_relbigobj+=UtilitiesStorageFactory
endif
ifeq ($(strip $(UtilitiesStorageFactoryPlugins)),)
UtilitiesStorageFactoryPlugins := self/src/Utilities/StorageFactory/plugins
UtilitiesStorageFactoryPlugins_LOC_FLAGS_CPPFLAGS   := -D_FILE_OFFSET_BITS=64
UtilitiesStorageFactoryPlugins_LOC_USE := self cmssw  Utilities/StorageFactory
ALL_EXTERNAL_PLUGIN_PRODS += UtilitiesStorageFactoryPlugins
Utilities/StorageFactory_relbigobj+=UtilitiesStorageFactoryPlugins
endif
ifeq ($(strip $(Alignment/MillePedeAlignmentAlgorithm)),)
AlignmentMillePedeAlignmentAlgorithm := self/Alignment/MillePedeAlignmentAlgorithm
Alignment/MillePedeAlignmentAlgorithm := AlignmentMillePedeAlignmentAlgorithm
AlignmentMillePedeAlignmentAlgorithm_BuildFile    := $(RELEASETOP)/.SCRAM/$(SCRAM_ARCH)/MakeData/DirCache.mk
AlignmentMillePedeAlignmentAlgorithm_LOC_FLAGS_USE_SOURCE_ONLY   := Geometry/CommonDetUnit
AlignmentMillePedeAlignmentAlgorithm_EX_USE := $(foreach d, self cmssw  Alignment/CommonAlignment Alignment/CommonAlignmentAlgorithm Alignment/CommonAlignmentParametrization Alignment/MuonAlignment Alignment/ReferenceTrajectories CondFormats/PCLConfig DataFormats/CLHEP DataFormats/SiStripDetId DataFormats/GeometryVector DataFormats/TrackReco FWCore/MessageLogger FWCore/ParameterSet FWCore/PluginManager rootcore,$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
AlignmentMillePedeAlignmentAlgorithm_EX_LIB   := AlignmentMillePedeAlignmentAlgorithm
ALL_EXTERNAL_PRODS += AlignmentMillePedeAlignmentAlgorithm
AlignmentMillePedeAlignmentAlgorithm_CLASS := LIBRARY
Alignment/MillePedeAlignmentAlgorithm_relbigobj+=AlignmentMillePedeAlignmentAlgorithm
endif
ifeq ($(strip $(AlignmentMillePedeAlignmentAlgorithmAuto)),)
AlignmentMillePedeAlignmentAlgorithmAuto := self/src/Alignment/MillePedeAlignmentAlgorithm/plugins
AlignmentMillePedeAlignmentAlgorithmAuto_LOC_USE := self cmssw  Alignment/SurveyAnalysis FWCore/Framework FWCore/ParameterSet FWCore/ServiceRegistry CommonTools/UtilAlgos CondFormats/Common CondFormats/GeometryObjects DataFormats/HepMCCandidate DataFormats/TrackerCommon Geometry/TrackerGeometryBuilder DQMServices/Core Alignment/MillePedeAlignmentAlgorithm
ALL_EXTERNAL_PLUGIN_PRODS += AlignmentMillePedeAlignmentAlgorithmAuto
Alignment/MillePedeAlignmentAlgorithm_relbigobj+=AlignmentMillePedeAlignmentAlgorithmAuto
endif
ifeq ($(strip $(Calibration/HcalCalibAlgos)),)
CalibrationHcalCalibAlgos := self/Calibration/HcalCalibAlgos
Calibration/HcalCalibAlgos := CalibrationHcalCalibAlgos
CalibrationHcalCalibAlgos_BuildFile    := $(RELEASETOP)/.SCRAM/$(SCRAM_ARCH)/MakeData/DirCache.mk
CalibrationHcalCalibAlgos_EX_USE := $(foreach d, self cmssw  root rootgraphics rootminuit FWCore/Utilities CommonTools/UtilAlgos DataFormats/EcalDetId DataFormats/HcalDetId DataFormats/DetId DataFormats/HcalRecHit Geometry/HcalTowerAlgo CondTools/Hcal Calibration/Tools DataFormats/EcalRecHit DataFormats/GeometryVector Geometry/CaloGeometry Geometry/CaloTopology Utilities/Xerces,$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
CalibrationHcalCalibAlgos_LCGDICTS  := x 
CalibrationHcalCalibAlgos_EX_LIB   := CalibrationHcalCalibAlgos
ALL_EXTERNAL_PRODS += CalibrationHcalCalibAlgos
CalibrationHcalCalibAlgos_CLASS := LIBRARY
Calibration/HcalCalibAlgos_relbigobj+=CalibrationHcalCalibAlgos
endif
ifeq ($(strip $(CalibrationHcalCalibAlgosPlugins)),)
CalibrationHcalCalibAlgosPlugins := self/src/Calibration/HcalCalibAlgos/plugins
CalibrationHcalCalibAlgosPlugins_LOC_USE := self cmssw  Calibration/HcalCalibAlgos CondFormats/HcalObjects CondFormats/L1TObjects DataFormats/Common DataFormats/DetId DataFormats/EcalDetId DataFormats/HcalDetId DataFormats/HcalDigi DataFormats/HcalRecHit DataFormats/JetReco DataFormats/L1GlobalTrigger DataFormats/TrackReco DataFormats/HcalIsolatedTrack FWCore/Framework FWCore/MessageLogger FWCore/ParameterSet FWCore/ServiceRegistry FWCore/Utilities Geometry/Records HLTrigger/HLTcore Calibration/IsolatedParticles rootphysics boost root clhep hepmc CommonTools/UtilAlgos TrackingTools/TrackAssociator
ALL_EXTERNAL_PLUGIN_PRODS += CalibrationHcalCalibAlgosPlugins
Calibration/HcalCalibAlgos_relbigobj+=CalibrationHcalCalibAlgosPlugins
endif
ifeq ($(strip $(Calibration/IsolatedParticles)),)
CalibrationIsolatedParticles := self/Calibration/IsolatedParticles
Calibration/IsolatedParticles := CalibrationIsolatedParticles
CalibrationIsolatedParticles_BuildFile    := $(RELEASETOP)/.SCRAM/$(SCRAM_ARCH)/MakeData/DirCache.mk
CalibrationIsolatedParticles_EX_USE := $(foreach d, self cmssw  clhep boost root FWCore/Framework MagneticField/Engine DataFormats/DetId DataFormats/EcalDetId DataFormats/HcalDetId DataFormats/EcalRecHit DataFormats/HcalRecHit DataFormats/Common DataFormats/TrackReco SimDataFormats/CaloHit SimDataFormats/Track SimDataFormats/GeneratorProducts SimDataFormats/Vertex SimTracker/TrackerHitAssociation SimGeneral/HepPDTRecord Geometry/CaloGeometry Geometry/CaloTopology Geometry/EcalAlgo Geometry/HcalTowerAlgo RecoLocalCalo/EcalRecAlgos TrackingTools/TrajectoryState TrackingTools/GeomPropagators TrackingTools/TrackAssociator,$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
CalibrationIsolatedParticles_EX_LIB   := CalibrationIsolatedParticles
ALL_EXTERNAL_PRODS += CalibrationIsolatedParticles
CalibrationIsolatedParticles_CLASS := LIBRARY
Calibration/IsolatedParticles_relbigobj+=CalibrationIsolatedParticles
endif
ifeq ($(strip $(CalibrationElectronStudy)),)
CalibrationElectronStudy := self/src/Calibration/IsolatedParticles/plugins
CalibrationElectronStudy_LOC_USE := self cmssw  clhep boost root rootgraphics DataFormats/Common DataFormats/DetId DataFormats/L1GlobalTrigger DataFormats/L1Trigger DataFormats/TrackReco DataFormats/VertexReco DataFormats/JetReco DataFormats/Luminosity L1Trigger/GlobalTriggerAnalyzer SimGeneral/HepPDTRecord SimDataFormats/GeneratorProducts SimDataFormats/Vertex CondFormats/DataRecord CondFormats/L1TObjects FWCore/Framework FWCore/ParameterSet FWCore/ServiceRegistry FWCore/MessageLogger FWCore/Utilities CommonTools/UtilAlgos Geometry/Records MagneticField/Engine MagneticField/Records TrackingTools/TrackAssociator RecoJets/JetProducers HLTrigger/HLTcore Calibration/IsolatedParticles DataFormats/HcalIsolatedTrack
ALL_EXTERNAL_PLUGIN_PRODS += CalibrationElectronStudy
Calibration/IsolatedParticles_relbigobj+=CalibrationElectronStudy
endif
ifeq ($(strip $(CalibrationHcalRaddamMuon)),)
CalibrationHcalRaddamMuon := self/src/Calibration/IsolatedParticles/plugins
CalibrationHcalRaddamMuon_LOC_USE := self cmssw  clhep boost root rootgraphics DataFormats/Common DataFormats/DetId DataFormats/L1GlobalTrigger DataFormats/L1Trigger DataFormats/TrackReco DataFormats/VertexReco DataFormats/JetReco DataFormats/Luminosity L1Trigger/GlobalTriggerAnalyzer SimGeneral/HepPDTRecord SimDataFormats/GeneratorProducts SimDataFormats/Vertex CondFormats/DataRecord CondFormats/L1TObjects FWCore/Framework FWCore/ParameterSet FWCore/ServiceRegistry FWCore/MessageLogger FWCore/Utilities CommonTools/UtilAlgos Geometry/Records MagneticField/Engine MagneticField/Records TrackingTools/TrackAssociator RecoJets/JetProducers HLTrigger/HLTcore Calibration/IsolatedParticles DataFormats/HcalIsolatedTrack
ALL_EXTERNAL_PLUGIN_PRODS += CalibrationHcalRaddamMuon
Calibration/IsolatedParticles_relbigobj+=CalibrationHcalRaddamMuon
endif
ifeq ($(strip $(CalibrationIsoTrackCalib)),)
CalibrationIsoTrackCalib := self/src/Calibration/IsolatedParticles/plugins
CalibrationIsoTrackCalib_LOC_USE := self cmssw  clhep boost root rootgraphics DataFormats/Common DataFormats/DetId DataFormats/L1GlobalTrigger DataFormats/L1Trigger DataFormats/TrackReco DataFormats/VertexReco DataFormats/JetReco DataFormats/Luminosity L1Trigger/GlobalTriggerAnalyzer SimGeneral/HepPDTRecord SimDataFormats/GeneratorProducts SimDataFormats/Vertex CondFormats/DataRecord CondFormats/L1TObjects FWCore/Framework FWCore/ParameterSet FWCore/ServiceRegistry FWCore/MessageLogger FWCore/Utilities CommonTools/UtilAlgos Geometry/Records MagneticField/Engine MagneticField/Records TrackingTools/TrackAssociator RecoJets/JetProducers HLTrigger/HLTcore Calibration/IsolatedParticles DataFormats/HcalIsolatedTrack
ALL_EXTERNAL_PLUGIN_PRODS += CalibrationIsoTrackCalib
Calibration/IsolatedParticles_relbigobj+=CalibrationIsoTrackCalib
endif
ifeq ($(strip $(CalibrationIsoTrackCalibration)),)
CalibrationIsoTrackCalibration := self/src/Calibration/IsolatedParticles/plugins
CalibrationIsoTrackCalibration_LOC_USE := self cmssw  clhep boost root rootgraphics DataFormats/Common DataFormats/DetId DataFormats/L1GlobalTrigger DataFormats/L1Trigger DataFormats/TrackReco DataFormats/VertexReco DataFormats/JetReco DataFormats/Luminosity L1Trigger/GlobalTriggerAnalyzer SimGeneral/HepPDTRecord SimDataFormats/GeneratorProducts SimDataFormats/Vertex CondFormats/DataRecord CondFormats/L1TObjects FWCore/Framework FWCore/ParameterSet FWCore/ServiceRegistry FWCore/MessageLogger FWCore/Utilities CommonTools/UtilAlgos Geometry/Records MagneticField/Engine MagneticField/Records TrackingTools/TrackAssociator RecoJets/JetProducers HLTrigger/HLTcore Calibration/IsolatedParticles DataFormats/HcalIsolatedTrack
ALL_EXTERNAL_PLUGIN_PRODS += CalibrationIsoTrackCalibration
Calibration/IsolatedParticles_relbigobj+=CalibrationIsoTrackCalibration
endif
ifeq ($(strip $(CalibrationIsoTrig)),)
CalibrationIsoTrig := self/src/Calibration/IsolatedParticles/plugins
CalibrationIsoTrig_LOC_USE := self cmssw  clhep boost root rootgraphics DataFormats/Common DataFormats/DetId DataFormats/L1GlobalTrigger DataFormats/L1Trigger DataFormats/TrackReco DataFormats/VertexReco DataFormats/JetReco DataFormats/Luminosity L1Trigger/GlobalTriggerAnalyzer SimGeneral/HepPDTRecord SimDataFormats/GeneratorProducts SimDataFormats/Vertex CondFormats/DataRecord CondFormats/L1TObjects FWCore/Framework FWCore/ParameterSet FWCore/ServiceRegistry FWCore/MessageLogger FWCore/Utilities CommonTools/UtilAlgos Geometry/Records MagneticField/Engine MagneticField/Records TrackingTools/TrackAssociator RecoJets/JetProducers HLTrigger/HLTcore Calibration/IsolatedParticles DataFormats/HcalIsolatedTrack
ALL_EXTERNAL_PLUGIN_PRODS += CalibrationIsoTrig
Calibration/IsolatedParticles_relbigobj+=CalibrationIsoTrig
endif
ifeq ($(strip $(CalibrationIsolatedGenParticles)),)
CalibrationIsolatedGenParticles := self/src/Calibration/IsolatedParticles/plugins
CalibrationIsolatedGenParticles_LOC_USE := self cmssw  clhep boost root rootgraphics DataFormats/Common DataFormats/DetId DataFormats/L1GlobalTrigger DataFormats/L1Trigger DataFormats/TrackReco DataFormats/VertexReco DataFormats/JetReco DataFormats/Luminosity L1Trigger/GlobalTriggerAnalyzer SimGeneral/HepPDTRecord SimDataFormats/GeneratorProducts SimDataFormats/Vertex CondFormats/DataRecord CondFormats/L1TObjects FWCore/Framework FWCore/ParameterSet FWCore/ServiceRegistry FWCore/MessageLogger FWCore/Utilities CommonTools/UtilAlgos Geometry/Records MagneticField/Engine MagneticField/Records TrackingTools/TrackAssociator RecoJets/JetProducers HLTrigger/HLTcore Calibration/IsolatedParticles DataFormats/HcalIsolatedTrack
ALL_EXTERNAL_PLUGIN_PRODS += CalibrationIsolatedGenParticles
Calibration/IsolatedParticles_relbigobj+=CalibrationIsolatedGenParticles
endif
ifeq ($(strip $(CalibrationIsolatedParticlesGeneratedJets)),)
CalibrationIsolatedParticlesGeneratedJets := self/src/Calibration/IsolatedParticles/plugins
CalibrationIsolatedParticlesGeneratedJets_LOC_USE := self cmssw  clhep boost root rootgraphics DataFormats/Common DataFormats/DetId DataFormats/L1GlobalTrigger DataFormats/L1Trigger DataFormats/TrackReco DataFormats/VertexReco DataFormats/JetReco DataFormats/Luminosity L1Trigger/GlobalTriggerAnalyzer SimGeneral/HepPDTRecord SimDataFormats/GeneratorProducts SimDataFormats/Vertex CondFormats/DataRecord CondFormats/L1TObjects FWCore/Framework FWCore/ParameterSet FWCore/ServiceRegistry FWCore/MessageLogger FWCore/Utilities CommonTools/UtilAlgos Geometry/Records MagneticField/Engine MagneticField/Records TrackingTools/TrackAssociator RecoJets/JetProducers HLTrigger/HLTcore Calibration/IsolatedParticles DataFormats/HcalIsolatedTrack
ALL_EXTERNAL_PLUGIN_PRODS += CalibrationIsolatedParticlesGeneratedJets
Calibration/IsolatedParticles_relbigobj+=CalibrationIsolatedParticlesGeneratedJets
endif
ifeq ($(strip $(CalibrationIsolatedTracksCone)),)
CalibrationIsolatedTracksCone := self/src/Calibration/IsolatedParticles/plugins
CalibrationIsolatedTracksCone_LOC_USE := self cmssw  clhep boost root rootgraphics DataFormats/Common DataFormats/DetId DataFormats/L1GlobalTrigger DataFormats/L1Trigger DataFormats/TrackReco DataFormats/VertexReco DataFormats/JetReco DataFormats/Luminosity L1Trigger/GlobalTriggerAnalyzer SimGeneral/HepPDTRecord SimDataFormats/GeneratorProducts SimDataFormats/Vertex CondFormats/DataRecord CondFormats/L1TObjects FWCore/Framework FWCore/ParameterSet FWCore/ServiceRegistry FWCore/MessageLogger FWCore/Utilities CommonTools/UtilAlgos Geometry/Records MagneticField/Engine MagneticField/Records TrackingTools/TrackAssociator RecoJets/JetProducers HLTrigger/HLTcore Calibration/IsolatedParticles DataFormats/HcalIsolatedTrack
ALL_EXTERNAL_PLUGIN_PRODS += CalibrationIsolatedTracksCone
Calibration/IsolatedParticles_relbigobj+=CalibrationIsolatedTracksCone
endif
ifeq ($(strip $(CalibrationIsolatedTracksHcalScale)),)
CalibrationIsolatedTracksHcalScale := self/src/Calibration/IsolatedParticles/plugins
CalibrationIsolatedTracksHcalScale_LOC_USE := self cmssw  clhep boost root rootgraphics DataFormats/Common DataFormats/DetId DataFormats/L1GlobalTrigger DataFormats/L1Trigger DataFormats/TrackReco DataFormats/VertexReco DataFormats/JetReco DataFormats/Luminosity L1Trigger/GlobalTriggerAnalyzer SimGeneral/HepPDTRecord SimDataFormats/GeneratorProducts SimDataFormats/Vertex CondFormats/DataRecord CondFormats/L1TObjects FWCore/Framework FWCore/ParameterSet FWCore/ServiceRegistry FWCore/MessageLogger FWCore/Utilities CommonTools/UtilAlgos Geometry/Records MagneticField/Engine MagneticField/Records TrackingTools/TrackAssociator RecoJets/JetProducers HLTrigger/HLTcore Calibration/IsolatedParticles DataFormats/HcalIsolatedTrack
ALL_EXTERNAL_PLUGIN_PRODS += CalibrationIsolatedTracksHcalScale
Calibration/IsolatedParticles_relbigobj+=CalibrationIsolatedTracksHcalScale
endif
ifeq ($(strip $(CalibrationIsolatedTracksNxN)),)
CalibrationIsolatedTracksNxN := self/src/Calibration/IsolatedParticles/plugins
CalibrationIsolatedTracksNxN_LOC_USE := self cmssw  clhep boost root rootgraphics DataFormats/Common DataFormats/DetId DataFormats/L1GlobalTrigger DataFormats/L1Trigger DataFormats/TrackReco DataFormats/VertexReco DataFormats/JetReco DataFormats/Luminosity L1Trigger/GlobalTriggerAnalyzer SimGeneral/HepPDTRecord SimDataFormats/GeneratorProducts SimDataFormats/Vertex CondFormats/DataRecord CondFormats/L1TObjects FWCore/Framework FWCore/ParameterSet FWCore/ServiceRegistry FWCore/MessageLogger FWCore/Utilities CommonTools/UtilAlgos Geometry/Records MagneticField/Engine MagneticField/Records TrackingTools/TrackAssociator RecoJets/JetProducers HLTrigger/HLTcore Calibration/IsolatedParticles DataFormats/HcalIsolatedTrack
ALL_EXTERNAL_PLUGIN_PRODS += CalibrationIsolatedTracksNxN
Calibration/IsolatedParticles_relbigobj+=CalibrationIsolatedTracksNxN
endif
ifeq ($(strip $(CalibrationStudyCaloGen)),)
CalibrationStudyCaloGen := self/src/Calibration/IsolatedParticles/plugins
CalibrationStudyCaloGen_LOC_USE := self cmssw  clhep boost root rootgraphics DataFormats/Common DataFormats/DetId DataFormats/L1GlobalTrigger DataFormats/L1Trigger DataFormats/TrackReco DataFormats/VertexReco DataFormats/JetReco DataFormats/Luminosity L1Trigger/GlobalTriggerAnalyzer SimGeneral/HepPDTRecord SimDataFormats/GeneratorProducts SimDataFormats/Vertex CondFormats/DataRecord CondFormats/L1TObjects FWCore/Framework FWCore/ParameterSet FWCore/ServiceRegistry FWCore/MessageLogger FWCore/Utilities CommonTools/UtilAlgos Geometry/Records MagneticField/Engine MagneticField/Records TrackingTools/TrackAssociator RecoJets/JetProducers HLTrigger/HLTcore Calibration/IsolatedParticles DataFormats/HcalIsolatedTrack
ALL_EXTERNAL_PLUGIN_PRODS += CalibrationStudyCaloGen
Calibration/IsolatedParticles_relbigobj+=CalibrationStudyCaloGen
endif
ifeq ($(strip $(CalibrationStudyCaloResponse)),)
CalibrationStudyCaloResponse := self/src/Calibration/IsolatedParticles/plugins
CalibrationStudyCaloResponse_LOC_USE := self cmssw  clhep boost root rootgraphics DataFormats/Common DataFormats/DetId DataFormats/L1GlobalTrigger DataFormats/L1Trigger DataFormats/TrackReco DataFormats/VertexReco DataFormats/JetReco DataFormats/Luminosity L1Trigger/GlobalTriggerAnalyzer SimGeneral/HepPDTRecord SimDataFormats/GeneratorProducts SimDataFormats/Vertex CondFormats/DataRecord CondFormats/L1TObjects FWCore/Framework FWCore/ParameterSet FWCore/ServiceRegistry FWCore/MessageLogger FWCore/Utilities CommonTools/UtilAlgos Geometry/Records MagneticField/Engine MagneticField/Records TrackingTools/TrackAssociator RecoJets/JetProducers HLTrigger/HLTcore Calibration/IsolatedParticles DataFormats/HcalIsolatedTrack
ALL_EXTERNAL_PLUGIN_PRODS += CalibrationStudyCaloResponse
Calibration/IsolatedParticles_relbigobj+=CalibrationStudyCaloResponse
endif
ifeq ($(strip $(CalibrationStudyTriggerHLT)),)
CalibrationStudyTriggerHLT := self/src/Calibration/IsolatedParticles/plugins
CalibrationStudyTriggerHLT_LOC_USE := self cmssw  clhep boost root rootgraphics DataFormats/Common DataFormats/DetId DataFormats/L1GlobalTrigger DataFormats/L1Trigger DataFormats/TrackReco DataFormats/VertexReco DataFormats/JetReco DataFormats/Luminosity L1Trigger/GlobalTriggerAnalyzer SimGeneral/HepPDTRecord SimDataFormats/GeneratorProducts SimDataFormats/Vertex CondFormats/DataRecord CondFormats/L1TObjects FWCore/Framework FWCore/ParameterSet FWCore/ServiceRegistry FWCore/MessageLogger FWCore/Utilities CommonTools/UtilAlgos Geometry/Records MagneticField/Engine MagneticField/Records TrackingTools/TrackAssociator RecoJets/JetProducers HLTrigger/HLTcore Calibration/IsolatedParticles DataFormats/HcalIsolatedTrack
ALL_EXTERNAL_PLUGIN_PRODS += CalibrationStudyTriggerHLT
Calibration/IsolatedParticles_relbigobj+=CalibrationStudyTriggerHLT
endif
ifeq ($(strip $(CondCore/ESSources)),)
CondCoreESSources := self/CondCore/ESSources
CondCore/ESSources := CondCoreESSources
CondCoreESSources_BuildFile    := $(RELEASETOP)/.SCRAM/$(SCRAM_ARCH)/MakeData/DirCache.mk
CondCoreESSources_EX_USE := $(foreach d, self cmssw  FWCore/Framework FWCore/PluginManager CondCore/CondDB,$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
CondCoreESSources_EX_LIB   := CondCoreESSources
ALL_EXTERNAL_PRODS += CondCoreESSources
CondCoreESSources_CLASS := LIBRARY
CondCore/ESSources_relbigobj+=CondCoreESSources
endif
ifeq ($(strip $(CondCoreESSourcesPlugins)),)
CondCoreESSourcesPlugins := self/src/CondCore/ESSources/plugins
CondCoreESSourcesPlugins_LOC_USE := self cmssw  FWCore/Catalog FWCore/Framework CondCore/ESSources boost_regex
ALL_EXTERNAL_PLUGIN_PRODS += CondCoreESSourcesPlugins
CondCore/ESSources_relbigobj+=CondCoreESSourcesPlugins
endif
