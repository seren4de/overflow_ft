#!/bin/bash

# This is a test script to test the checkpoint after fine tunning the overflow tts model with the new data; the checkpoints are saved under ./out/overflow_ljspeech-*/checkpoint_*.pth

#tested phrases
test_phrase="my mother exclaimed with a slight shake of the head. She leaned down to take the paintbrushes from my grubby hands, and for a moment her blue eyes were level with mine—now wide with mischief imagining what it might be like to take a drink from a fire hydrant. “You’re so much like her.” She grinned and kissed my cheek.
I only had a fistful of years under my paint smock back then, but already—and to my greatest delight and honor—the comparisons to my aunt Margie came swift and steady: big hair, big voice, big personality. “Big personality” was sometimes code for “big drama,” but I didn’t know that yet. I adored Margie, and from the way my mother, grandmother, and the rest of my aunts spoke of her, I knew this resemblance to be a very good thing. “She has such beautiful, beautiful hair,” said one. “She is so sharp, just smart as a whip,” said another. “You sure do talk a lot,” said most of them. I couldn’t seem to stop myself, though it didn’t often occur to me to try. Mostly the words tumbling around inside my head mirrored the unruly curls that sat atop it: copious and uncontained, inevitably springing loose from every paltry attempt at confinement.
It fell to my poor mother to shoulder the yeoman’s share of the burden this created."


vocoder_name="vocoder_models/en/ljspeech/hifigan_v2"
out_path="./audio/output_audio/testlr/"
model_path="/home/hannibal/overflow_ft/out/"

pth=".pth"
checkpoint="/checkpoint_"
wav=".wav"
conf="/config.json"

#tested checkpoints
cps=("55500" "56000" "56500")

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