#!/bin/bash

echo "Current directory: $(pwd)"

# EOS_FILE=/eos/uscms/store/group/lpcmetx/iDMe/premix_files_prefixed.txt

EOS_FILE=root://cmseos.fnal.gov//store/group/lpcmetx/iDMe/premix_files_prefixed.txt

xrdfs root://cmseos.fnal.gov stat /store/group/lpcmetx/iDMe/premix_files_prefixed.txt > /dev/null 2>&1

if [ $? -eq 0 ]; then
    echo "File found. Copying and printing..."
    xrdcp -f $EOS_FILE new_premix.txt
    head -n 10 new_premix.txt
else
    echo "Cannot access the file."
    exit 1
fi

# #!/bin/bash

# echo "Current directory: $(pwd)"

# EOS_FILE=/eos/uscms/store/group/lpcmetx/iDMe/premix_files_prefixed.txt

# if [ -r "$EOS_FILE" ]; then
#     echo "File is accessible locally: $EOS_FILE"
#     echo "Printing first 10 lines:"
#     head -n 10 "$EOS_FILE"
# else
#     echo "Cannot access the file locally: $EOS_FILE"
#     exit 1
# fi
