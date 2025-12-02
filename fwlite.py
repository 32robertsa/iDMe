from builtins import range
import ROOT
import sys
from DataFormats.FWLite import Events, Handle

from FWCore.ParameterSet.VarParsing import VarParsing


events = Events ("/uscms/home/reshmar/nobackup/CMSSW_13_0_13/src/iDMe/iDMe_Mchi-10p5_dMchi-1p0_mZDinput-30p0_ctau-0_1jet_icckw1_drjj0_xptj80_xqcut20_slc7_amd64_gcc11_CMSSW_13_0_13_tarball_22577496_MINIAOD_ctau-10.0_year-2022.root")

handle  = Handle ("std::vector<reco::GenParticle>")

label = ("prunedGenParticles")

ROOT.gROOT.SetBatch()        # don't pop up canvases
ROOT.gROOT.SetStyle('Plain') # white background

for event in events:
    event.getByLabel (label, handle)    
    genparticles = handle.product()    
    ngen = len(genparticles)
    #print ("Event ",event, " has gen particles=", ngen )
    pdg = genparticles.pdgId()
    # if (pdg == 11):
    #     if (genparticles.numberOfMothers() > 0):
    #         mother = genparticles.mother(0)
    #         print (mother)
        
    