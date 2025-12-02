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
        self.match = self.parse_axis(('match',[0,1]))
        self.met = self.parse_axis(('met',100,50,300))
        self.dR = self.parse_axis(('dR',100,0,5))
        self.vxy1 = self.parse_axis(('vxy',100,0,1))
        self.vxy10 = self.parse_axis(('vxy',100,0,10))
        self.vxy100 = self.parse_axis(('vxy',100,0,100))
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
        self.ele_passID = self.parse_axis(('passID',[0,1]))
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
    h.make('gen_ele_pt','ele_pt')      
    # matched reco electron, reco variables
    h.make("match_ele_pt",'match_type','ele_passID','ele_pt')     
    # matched reco electrons, corresponding gen object variables
    h.make("match_ele_gen_pt",'match_type','ele_passID','ele_pt')
    
    return h

subroutines = []


#.Electron means Regular (GED) electrons
def fillHistos(events,h,samp,cut,info,sum_wgt=1):
    h.samp = samp
    h.cut = cut
    wgt = events.eventWgt/sum_wgt
    
    if info["type"] == "signal":
        # defining stuff
        #Forget x-cleaning for now
        #Regular electrons
        # hasMatch_pf = (ak.count(events.Electron.pt,axis=1)>0) &\
        #               (ak.count_nonzero(events.Electron.genMatched,axis=1)>0)
        # hasMatch_lpt = (ak.count(events.LptElectron.pt,axis=1)>0) &\
        #                (ak.count_nonzero(events.LptElectron.genMatched,axis=1)>0)
        
        # print (hasMatch_pf)
        # match_pf = events[hasMatch_pf].Electron
        # match_pf = match_pf[match_pf.genMatched]    
        
        
        # countEmatched = ak.count(match_pf.pt, axis=1)
        # print ("Number of electrons matched to a GenEle or GenPos per event:",countEmatched)

        
        # genObj_pf = ak.where(match_pf.matchType==-1,events[hasMatch_pf].GenEle.motherID,events[hasMatch_pf].GenPos.motherID)
        # print ("The mother ID:", ak.to_list(genObj_pf))
         

        
        # match_pf = ak.flatten(match_pf)
        # genObj_pf = ak.flatten(genObj_pf)
        
        # match_pf_passID = ak.values_astype(match_pf.passID,int)

        print ("Fields of events.vtx:",ak.fields(events.vtx))
        print ("vtx.vxy:",events.vtx.vxy)
        # print ("First in the &:", ak.count(events.vtx.e1_refit_dxy,axis=1)) #This gives per event count
        
       
        # print ("count:", ak.count(events.vtx.e1_isMatched,axis=1))
        # print ("count_nonzero:",ak.count_nonzero(events.vtx.e1_isMatched,axis=1))


        hasMatch_pf = (ak.count(events.vtx.e1_refit_dxy,axis=1)>0) &\
                      (ak.count_nonzero(events.vtx.e1_isMatched,axis=1)>0)
        # hasMatch_pf = (ak.count(events.vtx.e1_typ,axis=1)>0) &\
        #               (ak.count_nonzero(events.vtx.e1_isMatched,axis=1)>0)
        
        print ("hasMatch_pf:", hasMatch_pf) #Chooses events with vtx_e1 greater than 0 and atleast one of them would be gen matched
        
        
        
        
        match_pf = events[hasMatch_pf].vtx.e1 #FRom these events, choose the vtx_e1 electrons
        print ("match_pf_before updating:",match_pf)
        print ("vtx.e1.vxy:", match_pf.vxy)

        
        match_pf = match_pf[match_pf.genMatched]     #Selecting only those vertex e1s that are gen matched
        print ("Final:", match_pf)
        vxy = match_pf.vxy
        print ("vxy:", ak.to_list(vxy))

        mask = match_pf.genMatched
        nomatch_pf = match_pf[~mask]   #The vtx_e1s that are not gen matched is 0 i.e. all vtx e1s are getting matched. 
        print ("nomatch:", nomatch_pf)
        
        # countEmatched = ak.count(match_pf.pt, axis=1)
        # print ("Number of vtx electrons matched to a GenEle or GenPos per event:",countEmatched)

        # countnomatched = ak.count(nomatch_pf.pt, axis=1)
        # print ("Number of vtx electrons not - matched to a GenEle or GenPos per event:",countnomatched)

        
        # genObj_pf = ak.where(match_pf.matchType==-1,events[hasMatch_pf].GenEle.motherID,events[hasMatch_pf].GenPos.motherID)
        # print ("The mother ID:", ak.to_list(genObj_pf))
         

        
        # match_pf = ak.flatten(match_pf)
        # genObj_pf = ak.flatten(genObj_pf)
        
        # match_pf_passID = ak.values_astype(match_pf.passID,int
        # print ("count:", ak.count(events.vtx.e2_isMatched,axis=1))
        # print ("count_nonzero:",ak.count_nonzero(events.vtx.e2_isMatched,axis=1))

        # hasMatch_pf = (ak.count(events.vtx.e2_refit_dxy,axis=1)>0) &\
        #               (ak.count_nonzero(events.vtx.e2_isMatched,axis=1)>0)
       
        # print ("hasMatch_pf:", hasMatch_pf)
         
        # match_pf = events[hasMatch_pf].vtx.e2 #FRom these events, choose the vtx_e1 electrons
        # print ("match_pf_before updating:",match_pf)

        
        # match_pf = match_pf[match_pf.genMatched]     #Selecting only those vertex e1s that are gen matched
        # print ("Final:", match_pf)

        # mask = match_pf.genMatched
        # nomatch_pf = match_pf[~mask]   #The vtx_e1s that are not gen matched is 0 i.e. all vtx e1s are getting matched. 
        # print ("nomatch:", nomatch_pf)











        
        
        #Lpt Electrons
        # match_lpt = events[hasMatch_lpt].LptElectron
        # match_lpt = match_lpt[match_lpt.genMatched]
        # genObj_lpt = ak.where(match_lpt.matchType==-1,events[hasMatch_lpt].GenEle,events[hasMatch_lpt].GenPos)
        # match_lpt = ak.flatten(match_lpt)
        # genObj_lpt = ak.flatten(genObj_lpt)
        # match_lpt_passID = ak.values_astype(match_lpt.passID,int)
       
         ## FILLING HISTOGRAMS ###          
        # h.fill("gen_ele_pt",pt=events.GenEle.pt,weight=1)
        # h.fill("gen_ele_pt",pt=events.GenPos.pt,weight=1)                
          
        #h.fill("match_ele_pt",match_type='R',passID=match_pf_passID,pt=match_pf.pt,weight=1)   #IMP 
        # h.fill("match_gen_ele_pt",match_type='R',passID=match_pf_passID,pt=genObj_pf.pt,weight=1)   #IMP  
        # #h.fill("match_gen_ele_mother_pdg", match_type='R',passID=match_pf_passID,mom = 
        # h.fill("match_ele_gen_pt",match_type='L',passID=match_lpt_passID,pt=genObj_lpt.pt,weight=1)


