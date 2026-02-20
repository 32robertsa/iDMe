import os

fls = os.popen(f'xrdfs root://cmseos.fnal.gov/ ls /store/group/lpcmetx/iDMe/Samples/acrobert/signal/2024/MiniAOD/').read()
def condition(filename):
    return True

for f in fls.split('\n'):
    
    if f != '' and condition(f):
        os.system(f'xrdfs root://cmseos.fnal.gov/ rm {f}')
