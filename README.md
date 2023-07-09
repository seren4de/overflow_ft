# Fine-Tuned TTS Overflow Model for Megan Speaker

This repository contains a fine-tuned TTS overflow model for the Megan speaker. The model has been trained to accurately reproduce the voice and speaking style of Megan, providing high-quality synthesized speech.

## Getting Started

Before using the model, there are a few steps you need to follow to set up your environment.

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
│       ├── Unfollow_02.txt
│       ├── Unfollow_02.wav
│       ├── Unfollow_03.txt
│       ├── Unfollow_03.wav
│       ├── Unfollow_04.txt
│       ├── Unfollow_04.wav
│       ├── Unfollow_05.txt
│       ├── Unfollow_05.wav
│       ├── Unfollow_06.txt
│       ├── Unfollow_06.wav
│       ├── Unfollow_07.txt
│       ├── Unfollow_07.wav
│       ├── Unfollow_08.txt
│       ├── Unfollow_08.wav
│       ├── Unfollow_09.txt
│       └── Unfollow_09.wav
```

### Directories ::

`./text/`
`./audio/`
`./corpus_directory/`

### Scripts ::

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
├── audio
│   ├── input_audio
│   │   ├── chapters
│   │   ├── com.txt
│   │   ├── megan13.mp3
│   │   ├── test_outputs
│   │   └── test_scripts
│   └── output_audio
│       └── unfollow
├── corpus_directory
│   └── Speaker1
│       ├── Unfollow_011.txt
│       ├── Unfollow_011.wav
│       ├── Unfollow_012.TextGrid
│       ├── Unfollow_012.txt
│       ├── Unfollow_012.wav
│       ├── Unfollow_021.TextGrid
│       ├── Unfollow_021.txt
│       ├── Unfollow_021.wav
│       ├── Unfollow_022.TextGrid
│       ├── Unfollow_022.txt
│       ├── Unfollow_022.wav
│       ├── Unfollow_031.TextGrid
│       ├── Unfollow_031.txt
│       ├── Unfollow_031.wav
│       ├── Unfollow_032.TextGrid
│       ├── Unfollow_032.txt
│       ├── Unfollow_032.wav
│       ├── Unfollow_033.TextGrid
│       ├── Unfollow_033.txt
│       ├── Unfollow_033.wav
│       ├── Unfollow_041.TextGrid
│       ├── Unfollow_041.txt
│       ├── Unfollow_041.wav
│       ├── Unfollow_042.TextGrid
│       ├── Unfollow_042.txt
│       ├── Unfollow_042.wav
│       ├── Unfollow_043.TextGrid
│       ├── Unfollow_043.txt
│       ├── Unfollow_043.wav
│       ├── Unfollow_051.TextGrid
│       ├── Unfollow_051.txt
│       ├── Unfollow_051.wav
│       ├── Unfollow_052.TextGrid
│       ├── Unfollow_052.txt
│       ├── Unfollow_052.wav
│       ├── Unfollow_053.TextGrid
│       ├── Unfollow_053.txt
│       ├── Unfollow_053.wav
│       ├── Unfollow_061.TextGrid
│       ├── Unfollow_061.txt
│       ├── Unfollow_061.wav
│       ├── Unfollow_062.TextGrid
│       ├── Unfollow_062.txt
│       ├── Unfollow_062.wav
│       ├── Unfollow_063.TextGrid
│       ├── Unfollow_063.txt
│       ├── Unfollow_063.wav
│       ├── Unfollow_064.TextGrid
│       ├── Unfollow_064.txt
│       ├── Unfollow_064.wav
│       ├── Unfollow_071.TextGrid
│       ├── Unfollow_071.txt
│       ├── Unfollow_071.wav
│       ├── Unfollow_072.TextGrid
│       ├── Unfollow_072.txt
│       ├── Unfollow_072.wav
│       ├── Unfollow_073.TextGrid
│       ├── Unfollow_073.txt
│       ├── Unfollow_073.wav
│       ├── Unfollow_074.TextGrid
│       ├── Unfollow_074.txt
│       ├── Unfollow_074.wav
│       ├── Unfollow_081.TextGrid
│       ├── Unfollow_081.txt
│       ├── Unfollow_081.wav
│       ├── Unfollow_082.TextGrid
│       ├── Unfollow_082.txt
│       ├── Unfollow_082.wav
│       ├── Unfollow_083.TextGrid
│       ├── Unfollow_083.txt
│       ├── Unfollow_083.wav
│       ├── Unfollow_084.TextGrid
│       ├── Unfollow_084.txt
│       ├── Unfollow_084.wav
│       ├── Unfollow_085.TextGrid
│       ├── Unfollow_085.txt
│       ├── Unfollow_085.wav
│       ├── Unfollow_091.TextGrid
│       ├── Unfollow_091.txt
│       ├── Unfollow_091.wav
│       ├── Unfollow_092.TextGrid
│       ├── Unfollow_092.txt
│       ├── Unfollow_092.wav
│       ├── Unfollow_093.TextGrid
│       ├── Unfollow_093.txt
│       ├── Unfollow_093.wav
│       ├── Unfollow_094.TextGrid
│       ├── Unfollow_094.txt
│       ├── Unfollow_094.wav
│       ├── Unfollow_095.TextGrid
│       ├── Unfollow_095.txt
│       └── Unfollow_095.wav
├── LICENSE
├── mp32wav_.py
├── README.md
├── split2sentences_.py
├── splitepub_.py
├── text
│   ├── input_text
│   │   ├── Unfollow_01.txt
│   │   ├── Unfollow_02.txt
│   │   ├── Unfollow_03.txt
│   │   ├── Unfollow_04.txt
│   │   ├── Unfollow_05.txt
│   │   ├── Unfollow_06.txt
│   │   ├── Unfollow_07.txt
│   │   ├── Unfollow_08.txt
│   │   ├── Unfollow_09.txt
│   │   └── Unfollow.epub
│   └── output_text
│       └── prepcript_unf_8.txt
└── tokenize_.py
```
