import json

data = [
    {
        "name": "Mchi-10p5_dMchi-1p0_ctau-10",
        "location": "/uscms/home/reshmar/nobackup/CMSSW_13_0_13/src/iDMe/AODSkimmer/Signal_Mchi-10p5_dMchi-1p0_ctau-10_2022_output.root",
        "type": "signal",
        "year": 2022
        
    }
]

# Write data to JSON file
with open("Mchi-10p5_dMchi-1p0_ctau-10.json", "w") as json_file:
    json.dump(data, json_file, indent=4)

print("JSON file created successfully!")
