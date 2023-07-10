# Fine-Tuned TTS Overflow Model for Megan Speaker

This repository contains a fine-tuned TTS overflow model for the Megan speaker. The model has been trained to accurately reproduce the voice and speaking style of Megan, providing high-quality synthesized speech.

## Getting Started

Before using the model, setup both [mfa](https://montreal-forced-aligner.readthedocs.io/en/latest/getting_started.html) and [tts](https://tts.readthedocs.io/en/latest/inference.html) in seperate virtual environements.

### Activate MFA Environment

First, make sure to activate the MFA environment by running the appropriate command for your system.

```
<insert command to activate MFA virtual environment>
e.g. conda activate aligner
```

### Update Montreal Forced Aligner

Next, update the Montreal Forced Aligner to the latest version by running the following command:

```bash
conda update montreal-forced-aligner
```

This will ensure that you have the latest version of the aligner, which is necessary for aligning audio and text.

### Starting a New MFA Server

Before starting a new MFA server, make sure to run the following commands:

```bash
mfa server start
mfa server delete
mfa server init
```

This will start, delete, and initialize a new MFA server, allowing you to use the aligner with your data.

### DATA structure for speakerX ::

```bash
├── corpus_directory
│   └── Speaker1
│       ├── Unfollow_01.txt
│       ├── Unfollow_01.wav
│       ├── ...
│       ├── Unfollow_09.txt
│       └── Unfollow_09.wav
```

### Directories ::

`./text/`
`./audio/`
`./corpus_directory/`

### Scripts ::

- **train_overflow.py**::

```bash
(tts) ┌──(seren4de㉿Bitland)-[~/overflow_ft]
└─$ python clean_.py                             
                                                                                      
(tts) ┌──(seren4de㉿Bitland)-[~/overflow_ft]
└─$ python rmextmeta_py
```

```bash
CUDA_VISIBLE_DEVICES="0" PYTORCH_CUDA_ALLOC_CONF='max_split_size_mb:25' python train_overflow.py \
    --config_path ./config.json \
    --restore_path /home/hannibal/.local/share/tts/tts_models--en--ljspeech--overflow/model_file.pth
```

OR
ex1

```bash
CUDA_VISIBLE_DEVICES="0" PYTORCH_CUDA_ALLOC_CONF='max_split_size_mb:21' python train_overflow.py --config_path /home/hannibal/overflow_ft/config.json --restore_path /home/hannibal/.local/share/tts/tts_models--en--ljspeech--overflow/model_file.pth
```

ex2

```bash
CUDA_VISIBLE_DEVICES="0" PYTORCH_CUDA_ALLOC_CONF='max_split_size_mb:21' python train_overflow.py --config_path /home/hannibal/overflow_ft/out/1e-5/config.json --restore_path /home/hannibal/overflow_ft/out/1e-5/checkpoint_21500.pth
```

- **split2sentences_.py**::

```bash
python split2sentences_.py ./corpus_directory/
```

- **alignaudiotext_.py**::

```
aligns spoken phrases with their respective transcript, provided we have a formatted transcript of a whole chapter (mfa standards) and its respective audio segment (WAV)
```

```bash
python3 alignaudiotext_.py
```

**NOTE** : hit enter in term to update if it looks frozen.

OR

```bash
(aligner)
└─$ mfa server init
 INFO     Initializing the global MFA database server...                             
 INFO     Starting the global MFA database server...                                 
waiting for server to start.... done
server started
 INFO     global MFA database server started! 
```

```bash
mfa align --clean --single_speaker './corpus_directory' 'english_us_arpa' 'english_us_arpa' './corpus_directory'
```

- **splitepub_.py**::

```
splits epub books into raw text chapters using BeautifulSoup lib
```

```bash
python3 splitepub_.py ./text/input_text/Unfollow.epub ./text/input_text/
```

- **mp32wav_.py**::

```
converts large mp3 files to wav using audiosegment 
```

```bash
python3 mp32wav_.py ./audio/input_audio/chapters/unfollow/ ./audio/output_audio/unfollow/
```

```bash
mv ./audio/output_audio/unfollow/* ./corpus_directory/Speaker1/
```

- **tokenize_.py**::

```
formats the transcript for each chapter by speaker, in this case we only have one speaker :: Speaker1, for each spoken phrase 
```

```bash
python3 tokenize_.py
```

### Project structure ::

```bash
.
├── alignaudiotext_.py
├── README.md
├── rmextmeta_py
├── split2sentences_.py
├── splitepub_.py
├── test.sh
├── tokenize_.py
├── train_overflow.py
├── tree.txt
├── format.py
├── LICENSE
├── mp32wav_.py
├── clean_.py
├── config.json
├── audio
│   ├── input_audio
│   │   ├── chapters
│   │   │   ├── onelaststop
│   │   │   └── unfollow
│   └── output_audio
│       ├── testlr
│       │   ├── 1e-321000.wav
│       │   ├── ...
│       │   └── 1e-521500.wav
│       └── unfollow
│           ├── Unfollow_01.wav
│           ├── ...
│           └── Unfollow_09.wav
├── corpus_directory
│   └── Speaker1
│       ├── Unfollow_012.TextGrid
│       ├── Unfollow_012.txt
│       ├── Unfollow_012.wav
│       ├── ...
│       ├── Unfollow_095.TextGrid
│       ├── Unfollow_095.txt
│       └── Unfollow_095.wav
├── MyTTSDataset
│   ├── metadata.csv
│   └── wavs
│       ├── resample_.py
│       ├── Unfollow_012_100.wav
│       ├── Unfollow_012_101.wav
│       ├── Unfollow_012_102.wav
│       ├── ...
│       ├── Unfollow_095_98.wav
│       ├── Unfollow_095_99.wav
│       └── Unfollow_095_9.wav
├── out
│   ├── 1e-3
│   │   ├── checkpoint_21000.pth
│   │   ├── checkpoint_21500.pth
│   │   ├── config.json
│   │   ├── events.out.tfevents.1688974945.Bitland
│   │   ├── trainer_0_log.txt
│   │   └── train_overflow.py
│   ├── 1e-4
│   │   ├── checkpoint_21000.pth
│   │   ├── checkpoint_21500.pth
│   │   ├── config.json
│   │   ├── events.out.tfevents.1688970687.Bitland
│   │   ├── trainer_0_log.txt
│   │   └── train_overflow.py
│   ├── 1e-5
│   │   ├── checkpoint_21000.pth
│   │   ├── checkpoint_21500.pth
│   │   ├── config.json
│   │   ├── events.out.tfevents.1688965154.Bitland
│   │   ├── trainer_0_log.txt
│   │   └── train_overflow.py
│   ├── lj_parameters.pt
│   ├── overflow_ljspeech-July-10-2023_10+09AM-eb61a8e
│   │   ├── checkpoint_22000.pth
│   │   ├── config.json
│   │   ├── events.out.tfevents.1688980192.Bitland
│   │   ├── trainer_0_log.txt
│   │   └── train_overflow.py
│   └── phoneme_cache
│       ├── I3dhdnMvVW5mb2xsb3dfMDc0Xzc0_phoneme.npy
│       ├── ...
│       └── I3dhdnMvVW5mb2xsb3dfMDYzXzYz_phoneme.npy
└── text
    ├── input_text
    │   ├── unf_8.txt
    │   ├── Unfollow_01.txt
    │   ├── ...
    │   ├── Unfollow_09.txt
    │   └── Unfollow.epub
    └── output_text
        └── prepcript_unf_8.txt


```
