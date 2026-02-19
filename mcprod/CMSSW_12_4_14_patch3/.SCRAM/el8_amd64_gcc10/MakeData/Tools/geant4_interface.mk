ALL_TOOLS      += geant4_interface
geant4_interface_EX_INCLUDE := /cvmfs/cms.cern.ch/el8_amd64_gcc10/external/geant4/10.7.2-b40a7ba2414e18fce0efe89a200cba68/include/Geant4 /cvmfs/cms.cern.ch/el8_amd64_gcc10/external/geant4/10.7.2-b40a7ba2414e18fce0efe89a200cba68/include
geant4_interface_EX_USE := clhep vecgeom zlib expat xerces-c root_cxxdefaults
geant4_interface_EX_FLAGS_CPPDEFINES  := -DGNU_GCC -DG4V9
geant4_interface_EX_FLAGS_CXXFLAGS  := -ftls-model=global-dynamic -pthread -DG4GEOM_USE_USOLIDS

