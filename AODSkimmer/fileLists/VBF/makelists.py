import os, sys, glob, subprocess

m1 = [0.1, 0.2, 0.5, 1., 2., 3., 5., 10., 20., 30., 40., 50., 60., 70., 80., 90., 100.]
dM = [0.1, 0.2]
ctau = [1, 10, 100]

name_template = 'VBFiDMe_Mchi-{}_dMchi-{}_mZDinput-{}_ctau-{}'
dset_template = '/privateMCProduction/acrobert-eventRECO-PAT_VBFiDMe_M1-{}_dM-{}_mZD-{}_ctau-{}_*evts*/*'
suffix = 'ptj20-40-30_mjj400_deta3p5'

for mX in m1:
    for dmX in dM:
        for ct in ctau:

            mChi = (mX + (1+dmX)*mX)/2
            dmChi = dmX*mX
            mZp = 3*mX

            strMchi = str(round(mChi, 2)).replace(".", "p")
            strdMchi = str(round(dmChi, 2)).replace(".", "p")
            strMZp = str(round(mZp, 1)).replace(".", "p")

            outname = dset_template.format(strMchi, strdMchi, strMZp, ct)

            # find dataset name
            output = subprocess.check_output(f'dasgoclient --query="dataset={outname} instance=prod/phys03"', shell=True)
            output = output.decode("utf-8").split('\n')

            dsets = [ds for ds in output if f'ctau-{ct}_' in ds]
            dsets.sort()
            try:
                this_dataset = dsets[-1]
            except:
                print(f'dasgoclient --query="dataset={outname} instance=prod/phys03"', dsets)
                
            output = subprocess.check_output(f'dasgoclient --query="file dataset={this_dataset} instance=prod/phys03" > datasets_Dec2025/VBFiDMe_Mchi-{strMchi}_dMchi-{strdMchi}_mZDinput-{strMZp}_ctau-{ct}_list.txt', shell=True)
            
            
