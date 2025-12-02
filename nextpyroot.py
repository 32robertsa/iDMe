import ROOT
from ROOT import TCanvas
from ROOT import TH1D

f = ROOT.TFile("iDMe_Mchi-10p5_dMchi-1p0_mZDinput-30p0_ctau-0_1jet_icckw1_drjj0_xptj80_xqcut20_slc7_amd64_gcc11_CMSSW_13_0_13_tarball_22577496_MINIAOD_ctau-10.0_year-2022.root", "READ")

tree=f.Get("Events")


c = TCanvas("c", "", 800, 700)                 
branch = tree.Draw("recoGenParticles_prunedGenParticles__PAT.obj.m_state.vertex_.fCoordinates.fX","recoGenParticles_prunedGenParticles__PAT.obj.m_state.pdgId_ == 11")
c.Draw()

c.SaveAs("gen_check.png")





