from hist import Hist
from hist.axis import StrCategory, Regular, Integer, IntCategory
import hist
import numpy as np
import awkward as ak
import analysisSubroutines as routines

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
        self.vtx_e1vxy = self.parse_axis(('vxy',100,0,2))
        self.vtx_e2vxy = self.parse_axis(('vxy',50,0,1))
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
    h.make('vtx_e1vxy','vtx_e1vxy')   
    h.make('vtx_e2vxy','vtx_e2vxy') 

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
        # print ("events.GenPart.fields:", events.GenPart.fields)
        # print("events.vtx.fields:", events.vtx.fields)
        
        
        mask_vtx = events.vtx.isMatched
        
        # vxy_genmatched = events.vtx.vxy[mask_vtx]       
        # vxy_genmatched_flat = ak.flatten(vxy_genmatched)  

        # vxy_no_genmatched = events.vtx.vxy[~mask_vtx] 
        # vxy_no_genmatched_flat = ak.flatten(vxy_no_genmatched)
        
        
        # mask_chi2 = events.GenPart.ID == 1000023        
        # vx_chi2 = ak.flatten(events.GenPart.vx[mask_chi2])
        # vy_chi2 = ak.flatten(events.GenPart.vy[mask_chi2])
        # vz_chi2 = ak.flatten(events.GenPart.vz[mask_chi2])

        # gamma_chi2 = ak.flatten(events.GenPart.e[mask_chi2])/ak.flatten(events.GenPart.mass[mask_chi2])

        gamma_ee = ak.flatten(events.vtx.energy[mask_vtx])/ak.flatten(events.vtx.m[mask_vtx])  #Gamma of vtx_ee
        vxy = ak.flatten(events.vtx.vxy[mask_vtx])
        ctau = vxy/gamma_ee
        print ("ctau from gen matched part:", ctau)
        
        #Let us assume gamma_ee is somewhat equal to gamma_chi2 
        # ctau = ak.flatten(events.vtx.vxy)/gamma_ee #gamma is correct. vtx.vxy is comparable to Lxy
        h.fill("vtx_e1vxy",vxy=ctau)

        
        

        # gamma_ll = ak.flatten(events.vtx.energy[mask_vtx])/ak.flatten(events.vtx.m[mask_vtx])
        # gamma_nogen_ll = ak.flatten(events.vtx.energy[~mask_vtx])/ak.flatten(events.vtx.m[~mask_vtx])

        
        # ctau_no_gen = /gamma_nogen_ll
        # h.fill("vtx_e2vxy",vxy=ctau_no_gen)        
        

        # ctau_gen = vxy_genmatched_flat/gamma_ll        
        # h.fill("vtx_e1vxy",vxy=ctau_gen)
        

        

        # # genele_vx = events.GenEle.vx
        # # print ("genele_vx:", genele_vx)

        # mask_genele = (events.GenPart.ID == 11) & (events.GenPart.motherID == 1000023)
        # vx_genele = ak.flatten(events.GenPart.vx[mask_genele])
        # print ("vx_genele:", vx_genele)
        
        
        # genele_vy = events.GenEle.vy
        # genele_vz = events.GenEle.vz

        



        

        # # last_mask = mask_chi2[events.GenPart.ID == 11]
        # # print ("len(last_mask):",len(last_mask))
        # # genele_vx = ak.flatten(events.GenEle.vx)
        # # genele_vy = ak.flatten(events.GenEle.vy)
        # # genele_vz = ak.flatten(events.GenEle.vz)


        # decaylength_chi2 = np.sqrt( (genele_vx-vx_chi2)**2 + (genele_vy-vy_chi2)**2 + (genele_vz-vz_chi2)**2 ) # in [cm]

        # ctau_chi2 = decaylength_chi2 / gamma_chi2
        # print ("ctau_chi2:", ctau_chi2)

        

        

        
        

        

    

        
        
        

        
        
       
        
      

   

        
        
        


        




        
              
        
        
       
        
       