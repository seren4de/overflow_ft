#!/bin/bash

# This is a test script to test the checkpoint after fine tunning the overflow tts model with the new data; the checkpoints are saved under ./out/overflow_ljspeech-*/checkpoint_*.pth

#tested phrases
test_phrase="This is a test phrase to evaluate how much the learning rate influence the model performance over 500 and 1000 epochs, in each case the newer learning rate becomes 10 times the previous learning rate."


vocoder_name="vocoder_models/en/ljspeech/hifigan_v2"
out_path="./audio/output_audio/testlr/"
model_path="/home/hannibal/overflow_ft/out/"

#tested checkpoints
cps=("21000" "21500" "22000")

#tested learning rates  "1e-2"
lrs=("1e-5" "1e-5-2" "1e-4" "1e-3")


for lr in "${lrs[@]}";
do
    for cp in "${cps[@]}";
    do
        echo "[+] Testing the model with the learning rate $lr and the checkpoint $cp"
        tts --text "$test_phrase" --model_path $model_path$lr"/checkpoint_"$cp".pth" --config_path $model_path$lr"/config.json" --out_path $out_path$lr$cp".wav" --vocoder_name $vocoder_name 2>/dev/null
    done
done
