ifeq ($(strip $(CMSSW_13_0_13/config)),)
src_CMSSW_13_0_13_config := self/CMSSW_13_0_13/config
CMSSW_13_0_13/config  := src_CMSSW_13_0_13_config
src_CMSSW_13_0_13_config_BuildFile    := $(WORKINGDIR)/cache/bf/src/CMSSW_13_0_13/config/BuildFile
src_CMSSW_13_0_13_config_LOC_USE := self cmssw
src_CMSSW_13_0_13_config_EX_USE   := $(foreach d,$(src_CMSSW_13_0_13_config_LOC_USE),$(if $($(d)_EX_FLAGS_NO_RECURSIVE_EXPORT),,$d))
ALL_EXTERNAL_PRODS += src_CMSSW_13_0_13_config
src_CMSSW_13_0_13_config_INIT_FUNC += $$(eval $$(call EmptyPackage,src_CMSSW_13_0_13_config,src/CMSSW_13_0_13/config))
endif

