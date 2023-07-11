#!/bin/bash

# This is a test script to test the checkpoint after fine tunning the overflow tts model with the new data; the checkpoints are saved under ./out/overflow_ljspeech-*/checkpoint_*.pth

#tested phrases
test_phrase="Armed with this information, my grandfather took action. He began by detailing his findings in a letter to the mayor, opening with a colorful description of the problem (“A malodorous sore with the scab off is open and running at the extreme southwest corner of Gage Park”) and concluding with a question"


vocoder_name="vocoder_models/en/ljspeech/hifigan_v2"
out_path="./audio/output_audio/testlr/"
model_path="/home/hannibal/overflow_ft/out/"

pth=".pth"
checkpoint="/checkpoint_"
wav=".wav"
conf="/config.json"

#tested checkpoints
cps=("21000" "21500" "22000" "22500" "23000" "23500" "24000" "25000" "25500" "26000" "26500" "27000" "27500" "28000" "28500" "29000" "29500" "30000" "30500")

#tested learning rates
lrs=("1e-3")


for lr in "${lrs[@]}";
do
    for cp in "${cps[@]}";
    do
        if [ -e $model_path$lr$checkpoint$cp$pth ]
        then
            echo "[+] Testing the model with the learning rate $lr and the checkpoint $cp"
            tts --text "$test_phrase" --model_path $model_path$lr$checkpoint$cp$pth --config_path $model_path$lr$conf --out_path $out_path$lr$cp$wav --vocoder_name $vocoder_name 2>/dev/null && echo "[=] test against checkpoint $cp Done"
        else
            echo "[-] no such file $model_path$lr$checkpoint$cp$pth"
        fi
    done
done
