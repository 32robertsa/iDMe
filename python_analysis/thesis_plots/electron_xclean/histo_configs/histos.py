from hist import Hist
from hist.axis import StrCategory, Regular, Integer, IntCategory
import hist
import numpy as np
import awkward as ak

# General Purpose
samp = StrCategory([],name="samp",label="Sample Name",growth=True)
cut = StrCategory([],name="cut",label="Cut Applied",growth=True)

# functions to make histograms
class myHisto:
    def __init__(self):
        self.histograms = {}
        self.samp = "NO_SAMPLE"
        self.cut = "NO_CUT"

        # axis compendium
        self.samp = StrCategory([],name="samp",label="Sample Name",growth=True)
        self.cut = StrCategory([],name="cut",label="Cut Applied",growth=True)
        self.ele_type = self.parse_axis(('ele_type',['L','R']))
        self.match_type = self.parse_axis(('match_type',['L','R']))
# =======
#         self.ele_type = self.parse_axis(('ele_type',['L','R','Both']))
#         self.match_type = self.parse_axis(('match_type',['L','R','Both']))
# >>>>>>> kyungmin/main
        self.match = self.parse_axis(('match',[0,1]))
        self.met = self.parse_axis(('met',100,50,300))
        self.dR = self.parse_axis(('dR',100,0,5))
        self.vxy1 = self.parse_axis(('vxy',100,0,1))
        self.vxy10 = self.parse_axis(('vxy',100,0,10))
        self.vxy100 = self.parse_axis(('vxy',100,0,100))
        self.vtx_e1vxy = self.parse_axis(('vxy',200,0,10))
        self.vtx_e2vxy = self.parse_axis(('vxy',200,0,10))

        self.ele_pt = self.parse_axis(("pt",50,0,50))
        self.dphi = self.parse_axis(("phi",64,-3.2,3.2))
        self.phi = self.parse_axis(("phi",64,-3.2,3.2))
        self.abs_dphi = self.parse_axis(('phi',100,0,3))
        self.eta = self.parse_axis(('eta',100,-2.5,2.5))
        self.dxy = self.parse_axis(('dxy',500,0,5))
        self.r3 = self.parse_axis(('r3',500,0,100))
        self.dxy_signif = self.parse_axis(('signif',100,0,20))
        self.trk_chi2 = self.parse_axis(('chi2',100,0,5))
        self.vtx_chi2 = self.parse_axis(('chi2',100,0,5))
        self.iso = self.parse_axis(('iso',100,0,5))
        self.sieie = self.parse_axis(('sieie',100,0,0.1))
        self.detaseed = self.parse_axis(('detaSeed',100,0,5))
        self.HoverE = self.parse_axis(('hoe',100,0,200))
        self.EinvMinusPinv = self.parse_axis(('emp',100,0,5))
        self.numMissingHits = self.parse_axis(('missing',10,0,10))
        self.passConvVeto = self.parse_axis(('passVeto',[0,1]))
        self.vxy_relDiff = self.parse_axis(('rel_diff',50,-2,2))
        self.isMatched = self.parse_axis(('matched',[0,1]))
        self.isPF = self.parse_axis(('isPF',[0,1]))
        self.numHits = self.parse_axis(('numHits',20,0,20))
        self.trkProb = self.parse_axis(('prob',100,0,1))
        self.IDScore = self.parse_axis(('id',100,-1,3))
# <<<<<<< HEAD
#         self.ele_passID = self.parse_axis(('passID',[0,1]))
# =======
        self.ele_passID = self.parse_axis(('passID',[0,1,2,3]))
# >>>>>>> kyungmin/main
        self.vtx_type = self.parse_axis(('vtype',['LL','LR','RR']))
        self.vtx_mass = self.parse_axis(('mass',100,0,30))
        self.vtx_sign = self.parse_axis(('sign',[-1,1]))
        self.vtx_pt = self.parse_axis(('pt',100,0,50))
        self.ele_ptRes = self.parse_axis(('ptres',100,-2,2))
        self.sigReco = self.parse_axis(('reco',[0,1]))
        self.vtxMatch = self.parse_axis(('match',[0,1]))
        self.dRCategories = self.parse_axis(('dRCat',['0to0p1','0p1to0p5','0p5toInf']))
        self.vxyCategories = self.parse_axis(('vxyCat',['0to1','1to5','5to10','10to15','15toInf']))
        self.ptCategories = self.parse_axis(('ptCat',['0to5','5to10','10to20','20toInf']))

    def make(self,name,*args,**hist_kwargs):
        if name in self.histograms.keys():
            print(f"Histogram {name} already exists! Skipping")
            return
        axes = [self.samp,self.cut]
        for ax in args:
            if type(ax) == tuple:
                axes.append(self.parse_axis(ax))
            else:
                axes.append(getattr(self,ax))
        self.histograms[name] = Hist(*axes,storage=hist.storage.Weight(),**hist_kwargs)
    
    def fill(self,name,**kwargs):
        self.histograms[name].fill(samp=self.samp,cut=self.cut,**kwargs)
    
    def parse_axis(self,a):
        name = a[0]
        if type(a[1]) == list:
            assert len(a) == 2
            if type(a[1][0]) == str:
                axis = StrCategory(a[1],name=name,label=name)
            else:
                axis = IntCategory(a[1],name=name,label=name)
        else:
            assert len(a) == 4
            axis = Regular(a[1],a[2],a[3],name=name,label=name)
        return axis



def make_histograms():
    h = myHisto()
    
    
    # quantities associated w/ gen objects
    h.make('vtx_e1vxy','vtx_e1vxy')   
    h.make('vtx_e2vxy','vtx_e2vxy') 

    h.make('gen_ele_pt','ele_pt')      
    # matched reco electron, reco variables
    h.make("match_ele_pt",'match_type','ele_passID','ele_pt')     
    # matched reco electrons, corresponding gen object variables
    h.make("match_ele_gen_pt",'match_type','ele_passID','ele_pt')
    
# =======
# def make_histograms():
#     h = myHisto()
    
#     # quantities associated w/ gen objects
#     h.make("gen_met",'met')
#     h.make("gen_dR",'dR')
#     h.make("gen_vxy1",'vxy1')
#     h.make("gen_vxy10",'vxy10')
#     h.make("gen_vxy100",'vxy100')
#     h.make("gen_leadpT",'ele_pt')
#     h.make("gen_vtx_METdPhi",'dphi')
#     h.make("gen_jetMETdPhi",'dphi')
#     h.make("gen_vtx_mass",'vtx_mass')
#     h.make('gen_vtx_pt','vtx_pt')
#     h.make('gen_vtx_eta','eta')
#     h.make('gen_vtx_phi','phi')

#     h.make("gen_met_unwgt",'met')
#     h.make("gen_dR_unwgt",'dR')
#     h.make("gen_vxy1_unwgt",'vxy1')
#     h.make("gen_vxy10_unwgt",'vxy10')
#     h.make("gen_vxy100_unwgt",'vxy100')
#     h.make("gen_leadpT_unwgt",'ele_pt')
#     h.make("gen_vtx_METdPhi_unwgt",'dphi')
#     h.make("gen_jetMETdPhi_unwgt",'dphi')
#     h.make("gen_vtx_mass_unwgt",'vtx_mass')
#     h.make('gen_vtx_pt_unwgt','vtx_pt')
#     h.make('gen_vtx_eta_unwgt','eta')
#     h.make('gen_vtx_phi_unwgt','phi')

#     h.make('gen_ele_pt','ele_pt')
#     h.make('gen_ele_eta','eta')
#     h.make('gen_ele_phi','phi')
#     h.make('gen_ele_vxy1','vxy1')
#     h.make('gen_ele_vxy10','vxy10')
#     h.make('gen_ele_vxy100','vxy100')
#     h.make("gen_ele_pt_vs_vxy1",'ele_pt','vxy1')
#     h.make("gen_ele_pt_vs_vxy10",'ele_pt','vxy10')
#     h.make("gen_ele_pt_vs_vxy100",'ele_pt','vxy100')
#     h.make("gen_ele_pt_vs_dR",'ele_pt','dR')
#     h.make("gen_ele_dR_vs_vxy1",'dR','vxy1')
#     h.make("gen_ele_dR_vs_vxy10",'dR','vxy10')
#     h.make("gen_ele_dR_vs_vxy100",'dR','vxy100')
#     h.make("gen_ele_pt_vs_vxy1_dRBinned",'ele_pt','vxy1','dRCategories')
#     h.make("gen_ele_pt_vs_vxy10_dRBinned",'ele_pt','vxy10','dRCategories')
#     h.make("gen_ele_pt_vs_vxy100_dRBinned",'ele_pt','vxy100','dRCategories')
#     h.make("gen_ele_pt_vs_dR_vxyBinned",'ele_pt','dR','vxyCategories')
#     h.make("gen_ele_dR_vs_vxy1_ptBinned",'dR','vxy1','ptCategories')
#     h.make("gen_ele_dR_vs_vxy10_ptBinned",'dR','vxy10','ptCategories')
#     h.make("gen_ele_dR_vs_vxy100_ptBinned",'dR','vxy100','ptCategories')
#     h.make("gen_ele_r3", 'r3')
#     h.make("gen_ele_r3_PVcorr", 'r3')

#     # reco --> vertexing efficiency
#     h.make("signalReco_vs_vtxMatch",'sigReco','vtxMatch')
#     h.make("signalReco_vs_vtxMatch_unwgt",'sigReco','vtxMatch')
    
#     # matched reco electron, reco variables
#     h.make("match_ele_pt",'match_type','ele_passID','ele_pt')
#     h.make("match_ele_eta",'match_type','ele_passID','eta')
#     h.make("match_ele_phi",'match_type','ele_passID','phi')
#     h.make("match_ele_dxy",'match_type','ele_passID','dxy')
#     h.make("match_ele_dxySignif",'match_type','ele_passID','dxy_signif')
#     h.make("match_ele_trkChi2",'match_type','ele_passID','trk_chi2')
#     h.make('match_ele_trkProb','match_type','ele_passID','trkProb')
#     h.make("match_ele_trkRelIso",'match_type','ele_passID','iso')
#     h.make("match_ele_calRelIso",'match_type','ele_passID','iso')
#     h.make("match_ele_PFRelIso",'match_type','ele_passID','iso')
#     h.make("match_ele_miniRelIso",'match_type','ele_passID','iso')
#     h.make("match_ele_mindRJets",'match_type','ele_passID','dR')
#     h.make("match_ele_isPF",'match_type','ele_passID','isPF')
#     h.make("match_ele_numTrkHits",'match_type','ele_passID','numHits')
#     h.make("match_ele_numPixHits",'match_type','ele_passID','numHits')
#     h.make("match_ele_numStripHits",'match_type','ele_passID','numHits')
#     h.make("match_ele_mindPhiJets",'match_type','ele_passID','dphi')
#     h.make("match_ele_sigmaIetaIeta",'match_type','ele_passID','sieie')
#     h.make("match_ele_absdEtaSeed",'match_type','ele_passID','detaseed')
#     h.make("match_ele_absdPhiIn",'match_type','ele_passID','abs_dphi')
#     h.make("match_ele_HOverE",'match_type','ele_passID','HoverE')
#     h.make("match_ele_1E1p",'match_type','ele_passID','EinvMinusPinv')
#     h.make("match_ele_expMissing",'match_type','ele_passID','numMissingHits')
#     h.make("match_ele_passConvVeto",'match_type','ele_passID','passConvVeto')
#     h.make("match_ele_IDscore",'match_type','ele_passID','IDScore')
    
#     # matched reco electrons, corresponding gen object variables
#     h.make("match_ele_gen_pt",'match_type','ele_passID','ele_pt')
#     h.make('match_ele_gen_vxy1','match_type','ele_passID','vxy1')
#     h.make('match_ele_gen_vxy10','match_type','ele_passID','vxy10')
#     h.make('match_ele_gen_vxy100','match_type','ele_passID','vxy100')
#     h.make('match_ele_gen_pt_vs_vxy1','match_type','ele_passID','ele_pt','vxy1')
#     h.make('match_ele_gen_pt_vs_vxy10','match_type','ele_passID','ele_pt','vxy10')
#     h.make('match_ele_gen_pt_vs_vxy100','match_type','ele_passID','ele_pt','vxy100')
#     h.make("match_ele_gen_pt_vs_dR",'match_type','ele_passID','ele_pt','dR')
#     h.make("match_ele_gen_dR_vs_vxy1",'match_type','ele_passID','dR','vxy1')
#     h.make("match_ele_gen_dR_vs_vxy10",'match_type','ele_passID','dR','vxy10')
#     h.make("match_ele_gen_dR_vs_vxy100",'match_type','ele_passID','dR','vxy100')
#     h.make("match_ele_gen_eta",'match_type','ele_passID','eta')
#     h.make('match_ele_gen_phi','match_type','ele_passID','phi')
#     h.make('match_ele_gen_dR','match_type','ele_passID','dR')
#     h.make('match_ele_ptRes','match_type','ele_passID','ele_ptRes')
#     h.make("match_ele_gen_pt_vs_vxy1_dRBinned",'match_type','ele_passID','ele_pt','vxy1','dRCategories')
#     h.make("match_ele_gen_pt_vs_vxy10_dRBinned",'match_type','ele_passID','ele_pt','vxy10','dRCategories')
#     h.make("match_ele_gen_pt_vs_vxy100_dRBinned",'match_type','ele_passID','ele_pt','vxy100','dRCategories')
#     h.make("match_ele_gen_pt_vs_dR_vxyBinned",'match_type','ele_passID','ele_pt','dR','vxyCategories')
#     h.make("match_ele_gen_dR_vs_vxy1_ptBinned",'match_type','ele_passID','dR','vxy1','ptCategories')
#     h.make("match_ele_gen_dR_vs_vxy10_ptBinned",'match_type','ele_passID','dR','vxy10','ptCategories')
#     h.make("match_ele_gen_dR_vs_vxy100_ptBinned",'match_type','ele_passID','dR','vxy100','ptCategories')


#     # fake reco electrons (not matched to a gen object)
#     h.make("fake_ele_pt",'ele_type','ele_passID','ele_pt')
#     h.make("fake_ele_eta",'ele_type','ele_passID','eta')
#     h.make("fake_ele_phi",'ele_type','ele_passID','phi')
#     h.make("fake_ele_dxy",'ele_type','ele_passID','dxy')
#     h.make("fake_ele_dxySignif",'ele_type','ele_passID','dxy_signif')
#     h.make("fake_ele_trkChi2",'ele_type','ele_passID','trk_chi2')
#     h.make('fake_ele_trkProb','ele_type','ele_passID','trkProb')
#     h.make("fake_ele_trkRelIso",'ele_type','ele_passID','iso')
#     h.make("fake_ele_calRelIso",'ele_type','ele_passID','iso')
#     h.make("fake_ele_PFRelIso",'ele_type','ele_passID','iso')
#     h.make("fake_ele_miniRelIso",'ele_type','ele_passID','iso')
#     h.make("fake_ele_mindRJets",'ele_type','ele_passID','dR')
#     h.make("fake_ele_isPF",'ele_type','ele_passID','isPF')
#     h.make("fake_ele_numTrkHits",'ele_type','ele_passID','numHits')
#     h.make("fake_ele_numPixHits",'ele_type','ele_passID','numHits')
#     h.make("fake_ele_numStripHits",'ele_type','ele_passID','numHits')
#     h.make("fake_ele_mindPhiJets",'ele_type','ele_passID','dphi')
#     h.make("fake_ele_sigmaIetaIeta",'ele_type','ele_passID','sieie')
#     h.make("fake_ele_absdEtaSeed",'ele_type','ele_passID','detaseed')
#     h.make("fake_ele_absdPhiIn",'ele_type','ele_passID','abs_dphi')
#     h.make("fake_ele_HOverE",'ele_type','ele_passID','HoverE')
#     h.make("fake_ele_1E1p",'ele_type','ele_passID','EinvMinusPinv')
#     h.make("fake_ele_expMissing",'ele_type','ele_passID','numMissingHits')
#     h.make("fake_ele_passConvVeto",'ele_type','ele_passID','passConvVeto')
#     h.make("fake_ele_IDscore",'ele_type','ele_passID','IDScore')
    
#     # matched reco vertex
#     h.make("match_vtx_dR",'vtx_type','dR')
#     h.make("match_vtx_mindxy",'vtx_type','dxy')
#     h.make("match_vtx_vxy1",'vtx_type','vxy1')
#     h.make("match_vtx_vxy10",'vtx_type','vxy10')
#     h.make("match_vtx_vxy100",'vtx_type','vxy100')
#     h.make("match_vtx_leadpT",'vtx_type','ele_pt')
#     h.make("match_vtx_METdPhi",'vtx_type','dphi')
#     h.make("match_vtx_mindRj",'vtx_type','dR')
#     h.make("match_vtx_chi2",'vtx_type','vtx_chi2')
#     h.make('match_vtx_mass','vtx_type','vtx_mass')
#     h.make('match_vtx_mindPhiJ','vtx_type','dphi')
#     h.make('match_vtx_sign','vtx_type','vtx_sign')
#     h.make('match_vtx_pt','vtx_type','vtx_pt')
#     h.make('match_vtx_eta','vtx_type','eta')
#     h.make('match_vtx_phi','vtx_type','phi')
#     h.make("match_vtx_type",'vtx_type')

#     # matched reco vertex, corresponding gen features
#     h.make("match_vtx_gen_dR",'vtx_type','dR')
#     h.make("match_vtx_gen_vxy1",'vtx_type','vxy1')
#     h.make("match_vtx_gen_vxy10",'vtx_type','vxy10')
#     h.make("match_vtx_gen_vxy100",'vtx_type','vxy100')
#     h.make("match_vtx_gen_METdPhi",'vtx_type','dphi')
#     h.make("match_vtx_gen_mass",'vtx_type','vtx_mass')
#     h.make('match_vtx_gen_pt','vtx_type','vtx_pt')
#     h.make('match_vtx_gen_eta','vtx_type','eta')
#     h.make('match_vtx_gen_phi','vtx_type','phi')
#     h.make("match_vtx_reco_dR_vs_gen_dR",'vtx_type','dR',('gendR',250,0,5))
#     h.make("match_vtx_reco_vxy1_vs_gen_vxy1",'vtx_type','vxy1',('genvxy',100,0,1))
#     h.make("match_vtx_reco_vxy10_vs_gen_vxy10",'vtx_type','vxy10',('genvxy',100,0,10))
#     h.make("match_vtx_reco_vxy100_vs_gen_vxy100",'vtx_type','vxy100',('genvxy',100,0,100))
#     h.make("match_vtx_reco_METdPhi_vs_gen_METdPhi",'vtx_type','dphi',('gendphi',64,-3.2,3.2))
#     h.make("match_vtx_reco_mass_vs_gen_mass",'vtx_type','vtx_mass',('gen_vtxmass',100,0,30))
#     h.make('match_vtx_reco_pt_vs_gen_pt','vtx_type','vtx_pt',('gen_pt',100,0,50))
#     h.make('match_vtx_reco_eta_vs_gen_eta','vtx_type','eta',('gen_eta',100,-2.5,2.5))
#     h.make('match_vtx_reco_phi_vs_gen_phi','vtx_type','phi',('gen_phi',64,-3.2,.32))

#     # fake reco vertices
#     h.make("fake_vtx_dR",'vtx_type','dR')
#     h.make("fake_vtx_mindxy",'vtx_type','dxy')
#     h.make("fake_vtx_vxy1",'vtx_type','vxy1')
#     h.make("fake_vtx_vxy10",'vtx_type','vxy10')
#     h.make("fake_vtx_vxy100",'vtx_type','vxy100')
#     h.make("fake_vtx_leadpT",'vtx_type','ele_pt')
#     h.make("fake_vtx_METdPhi",'vtx_type','dphi')
#     h.make("fake_vtx_mindRj",'vtx_type','dR')
#     h.make("fake_vtx_chi2",'vtx_type','vtx_chi2')
#     h.make('fake_vtx_mass','vtx_type','vtx_mass')
#     h.make('fake_vtx_mindPhiJ','vtx_type','dphi')
#     h.make('fake_vtx_sign','vtx_type','vtx_sign')
#     h.make('fake_vtx_pt','vtx_type','vtx_pt')
#     h.make('fake_vtx_eta','vtx_type','eta')
#     h.make('fake_vtx_phi','vtx_type','phi')
#     h.make("fake_vtx_type",'vtx_type')
    
#     # misc other quantities
#     h.make("PFMET",'met')
#     h.make("PFMET_vs_genMET",'met',('genmet',100,50,300))


# >>>>>>> kyungmin/main
    return h

subroutines = []


def fillHistos(events,h,samp,cut,info,sum_wgt=1):
    h.samp = samp
    h.cut = cut
    wgt = events.eventWgt/sum_wgt
    
    if info["type"] == "signal":        

        # print ("Fields of events.vtx:",ak.fields(events.vtx))
        # print ("vtx.vxy:",events.vtx.vxy)
        
        hasMatch_pf = (ak.count(events.vtx.e1_refit_dxy,axis=1)>0) &\
                      (ak.count_nonzero(events.vtx.e1_isMatched,axis=1)>0)
        
        # print ("hasMatch_pf:", hasMatch_pf) #Chooses events which has greater than 0 vtx e1s and atleast one of them would be gen matched
                
        # match_pf = events[hasMatch_pf].vtx.e1   #We now select vtx e1s from these chosen events         
        # vxyor= match_pf.vxy
        # vxy_allvtxe1 = ak.flatten(vxyor)
        

        # #I want to focus on vtx.e1s not gen matched
        # mask = match_pf.genMatched
        # nogenmatch = match_pf[~mask] #These are the vtx.e1s that are not gen matched i.e not coming from a gen electron
        # print ("nogenmatch:", nogenmatch)
        # vxy_nomatch = nogenmatch.vxy
        # vxynomatch = ak.flatten(vxy_nomatch)
        # print ("vxy of no gen match:", ak.to_list(vxynomatch))
        # h.fill("vtx_e1vxy",vxy=vxynomatch)

        # #Focus on vtxe1s that are gen matched
        # match_pf = match_pf[mask]     #These are the vtx e1s which are gen matched   
        # vxy = match_pf.vxy
        # vxynew=ak.flatten(vxy)

        
       #  match_pf = events[hasMatch_pf].vtx.e2   #We now select vtx e1s from these chosen events         
       #  vxyor= match_pf.vxy
       #  vxy_allvtxe2 = ak.flatten(vxyor)
       #  #h.fill("vtx_e2vxy",vxy=vxy_allvtxe2)
        

       #  #I want to focus on vtx.e1s not gen matched
       #  mask = match_pf.genMatched
       #  nogenmatch = match_pf[~mask] #These are the vtx.e1s that are not gen matched i.e not coming from a gen electron
       #  print ("nogenmatch:", nogenmatch)
       #  vxy_nomatch = nogenmatch.vxy
       #  vxynomatch = ak.flatten(vxy_nomatch)
       #  print ("vxy of no gen match:", ak.to_list(vxynomatch))
       #  #h.fill("vtx_e2vxy",vxy=vxynomatch)

       #  #Focus on vtxe1s that are gen matched
       #  match_pf = match_pf[mask]     #These are the vtx e1s which are gen matched   
       #  vxy = match_pf.vxy
       #  vxynew=ak.flatten(vxy)
       # # h.fill("vtx_e2vxy",vxy=vxynew)



        vtxe2 = events.vtx.e2
        vxye2 = vtxe2.vxy
        vtx_e2_flat = ak.flatten(vxye2)
        h.fill("vtx_e2vxy",vxy=vtx_e2_flat)

