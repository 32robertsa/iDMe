ALL_TOOLS      += self
self_EX_INCLUDE := /uscms_data/d3/reshmar/CMSSW_13_0_13/src/iDMe/UL_MCProduction/CMSSW_12_4_14_patch3/src /uscms_data/d3/reshmar/CMSSW_13_0_13/src/iDMe/UL_MCProduction/CMSSW_12_4_14_patch3/include/el8_amd64_gcc10/src /uscms_data/d3/reshmar/CMSSW_13_0_13/src/iDMe/UL_MCProduction/CMSSW_12_4_14_patch3/include/LCG /cvmfs/cms.cern.ch/el8_amd64_gcc10/cms/cmssw-patch/CMSSW_12_4_14_patch3/src
self_EX_LIBDIR := /uscms_data/d3/reshmar/CMSSW_13_0_13/src/iDMe/UL_MCProduction/CMSSW_12_4_14_patch3/biglib/el8_amd64_gcc10 /uscms_data/d3/reshmar/CMSSW_13_0_13/src/iDMe/UL_MCProduction/CMSSW_12_4_14_patch3/lib/el8_amd64_gcc10 /uscms_data/d3/reshmar/CMSSW_13_0_13/src/iDMe/UL_MCProduction/CMSSW_12_4_14_patch3/external/el8_amd64_gcc10/lib /cvmfs/cms.cern.ch/el8_amd64_gcc10/cms/cmssw-patch/CMSSW_12_4_14_patch3/biglib/el8_amd64_gcc10 /cvmfs/cms.cern.ch/el8_amd64_gcc10/cms/cmssw-patch/CMSSW_12_4_14_patch3/lib/el8_amd64_gcc10 /cvmfs/cms.cern.ch/el8_amd64_gcc10/cms/cmssw-patch/CMSSW_12_4_14_patch3/external/el8_amd64_gcc10/lib
self_EX_LIBDIR += \$(cmssw_EX_LIBDIR)
self_EX_FLAGS_CHECK_PRIVATE_HEADERS  := 1
self_EX_FLAGS_DEFAULT_COMPILER  := gcc
self_EX_FLAGS_EXTERNAL_SYMLINK  := PATH LIBDIR CMSSW_SEARCH_PATH
self_EX_FLAGS_LLVM_ANALYZER  := llvm-analyzer
self_EX_FLAGS_NO_EXTERNAL_RUNTIME  := LD_LIBRARY_PATH PATH CMSSW_SEARCH_PATH
TOOLS_OVERRIDABLE_FLAGS  +=CPPDEFINES CXXFLAGS FFLAGS CFLAGS CPPFLAGS LDFLAGS CUDA_FLAGS CUDA_LDFLAGS
self_EX_FLAGS_SCRAM_TARGETS  := haswell sandybridge nehalem
self_EX_FLAGS_SKIP_TOOLS_SYMLINK  := cxxcompiler ccompiler f77compiler gcc-cxxcompiler gcc-ccompiler gcc-f77compiler llvm-cxxcompiler llvm-ccompiler llvm-f77compiler llvm-analyzer-cxxcompiler llvm-analyzer-ccompiler icc-cxxcompiler icc-ccompiler icc-f77compiler x11 dpm
self_EX_FLAGS_SYMLINK_DEPTH_CMSSW_SEARCH_PATH  := 2
self_ORDER := 20000
IS_PATCH:=yes

