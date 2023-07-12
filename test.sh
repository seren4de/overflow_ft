#!/bin/bash

# This is a test script to test the checkpoint after fine tunning the overflow tts model with the new data; the checkpoints are saved under ./out/overflow_ljspeech-*/checkpoint_*.pth

#tested phrases
test_phrase="The quick brown fox jumps over the lazy dog. This sentence contains all the letters of the English alphabet. It is often used to test the display of fonts and the accuracy of keyboards. The sentence has been in use since at least the late 19th century, and it remains a popular tool for testing today."


vocoder_name="vocoder_models/en/ljspeech/hifigan_v2"
out_path="./audio/output_audio/testlr/"
model_path="/home/hannibal/overflow_ft/out/"

pth=".pth"
checkpoint="/checkpoint_"
wav=".wav"
conf="/config.json"

#tested checkpoints
cps=("29500" "30000" "30500" "31000" "31500" "32000" "32500" "33000" "33500" "34000" "34500" "35000" "35500" "36000" "36500")

#tested learning rates
lrs=("1e-3") 


for lr in "${lrs[@]}";
do
    for cp in "${cps[@]}";
    do
        if [ -e $model_path$lr$checkpoint$cp$pth ]
        then
            if [ ! -e $out_path$lr"_"$cp$wav ]
            then
                echo "[+] Testing the model with the learning rate $lr and the checkpoint $cp"
                tts --text "$test_phrase" --model_path $model_path$lr$checkpoint$cp$pth --config_path $model_path$lr$conf --out_path $out_path$lr"_"$cp$wav --vocoder_name $vocoder_name 2>/dev/null && echo "[=] test against checkpoint $cp Done"
            else 
                echo "[-] $out_path$lr"_"$cp$wav already exists"
            fi
        else
            echo "[-] no such file $model_path$lr$checkpoint$cp$pth"
        fi
    done
done
