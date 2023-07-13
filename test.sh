#!/bin/bash

# This is a test script to test the checkpoint after fine tunning the overflow tts model with the new data; the checkpoints are saved under ./out/overflow_ljspeech-*/checkpoint_*.pth

#tested phrases
test_phrase="The quick brown fox jumps over the lazy dog. The rain in Spain falls mainly on the plain. How much wood would a woodchuck chuck if a woodchuck could chuck wood. She sells seashells by the seashore. The shells she sells are surely seashells. So if she sells shells on the seashore, I'm sure she sells seashore shells. Peter Piper picked a peck of pickled peppers. A peck of pickled peppers Peter Piper picked. If Peter Piper picked a peck of pickled peppers, where's the peck of pickled peppers Peter Piper picked."


vocoder_name="vocoder_models/en/ljspeech/hifigan_v2"
out_path="./audio/output_audio/testlr/"
model_path="/home/hannibal/overflow_ft/out/"

pth=".pth"
checkpoint="/checkpoint_"
wav=".wav"
conf="/config.json"

#tested checkpoints
cps=("51000" "50500")

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