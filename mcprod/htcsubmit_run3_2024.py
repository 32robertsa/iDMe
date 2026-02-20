import os
import sys

def stringfy_friendly(num):
    if isinstance(num, int):
        return str(num)
    elif isinstance(num, float):
        if int(num*1000) > 0:
            num = round(num, 3)
            return str(num).replace('.', 'p') if '.' in str(num) else str(num)
        else:
            num = '%.3e' % num
            return num.replace('.', 'p')
    else:
        raise ValueError("{0} is not a number!".format(num))

if len(sys.argv) < 4:
    print("ERROR! Need 4 arguments")
    print("Usage: python3 htcsubmit_run3_2024.py m1 dm ctau nevents [nev_per_job]")
    sys.exit()

year = '2024'#sys.argv[3]
nThreads = 8 #int(sys.argv[4])
fragment = 'iDMe_template_fragment_acrobert.py'
prodchain = 'prodchain_from_massname_2024.sh'
    
m1 = float(sys.argv[1])
if m1 % 1. == 0.:
    m1 = int(m1)
dm = float(sys.argv[2])
ctau = int(sys.argv[3])
nevents = int(sys.argv[4])

m2 = m1*(1+dm)
mchi = (m1+m2)/2
dmchi = m2-m1
med = 3 * m1
stfm1 = stringfy_friendly(m1)
stfdm = stringfy_friendly(dm)
stfmed = stringfy_friendly(med)

#hbar_c = 0.1973269804e-12 # in GeV * mm
#lifetime_width = hbar_c/lifetime

procname = f'iDMe_run3_M1-{stfm1}_dM-{stfdm}_mZD-{stfmed}_ctau-{ctau}_1jet_xptj80_{int(nevents/1000)}k-evts_{year}'
massname = f'M1-{stfm1}_dM-{stfdm}_mZD-{stfmed}'
baseDir = "submissions/"+procname
here = os.getcwd()

# create submission directory
if not os.path.isdir(baseDir):
    os.mkdir(baseDir)
    os.mkdir(baseDir+"/logs")
if os.path.isdir(f"{baseDir}/submit"):
    os.system(f"rm -rf {baseDir}/submit")
os.mkdir(f"{baseDir}/submit")

# copy files
files_to_copy = [fragment, prodchain, 'runGeneration_2024.sh', 'pileupfiles_2024.txt']
for f in files_to_copy:
    os.system(f"cp {f} {baseDir+'/submit'}")

# tar submit directory
if os.path.exists(f"{baseDir}/submit.tar.gz"):
    os.system(f"rm {baseDir}/submit.tar.gz")
os.chdir(baseDir+"/submit")
os.system("tar -czf ../submit.tar.gz *")
os.chdir(here)

# make directory for log files
logDir = baseDir+f"/logs/ctau-{ctau}_{int(nevents/1000)}k-evts_{year}"
if os.path.isdir(logDir):
    os.system(f"rm -rf {logDir}")
os.mkdir(logDir)

if len(sys.argv) == 6:
    nev_per_job = int(sys.argv[5])
else:
    nev_per_job = 10000
print(f"{nev_per_job} events per job")
nJobs = nevents // nev_per_job
if nevents < nev_per_job:
    nJobs = 1
    nev_per_job = nevents

condor_cmd = "condor_submit condorTemplate_2024.jdl" 
condor_cmd += f' -append \"Arguments = {massname} {ctau} {nev_per_job} {nThreads} \$(Process)\"'
condor_cmd += f' -append \"transfer_input_files = {baseDir}/submit.tar.gz\"'
condor_cmd += f' -append \"request_cpus = {nThreads}\"'
condor_cmd += f' -append \"output = {logDir}/\$(Cluster)_\$(Process).out\"'
condor_cmd += f' -append \"error = {logDir}/\\$(Cluster)_\$(Process).err\"'
condor_cmd += f' -append \"log = {logDir}/\\$(Cluster)_\\$(Process).log\"'
condor_cmd += f' -append \"Queue {nJobs}\"'

print(condor_cmd)
os.system(condor_cmd)
