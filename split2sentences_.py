import os
import subprocess
from pydub import AudioSegment
from pydub.silence import split_on_silence

transcript_file = './text/output_text/prepcript_unf_8.txt'
audio_file = './corpus_directory/Speaker1/Unfollow_08.wav'
output_dir = './audio/output_audio/unfollow/'

def split_audio(audio_file, textgrid_file, output_dir):
    audio = AudioSegment.from_wav(audio_file)
    with open(textgrid_file, 'r') as f:
        lines = f.readlines()
    for i, line in enumerate(lines):
        if 'intervals [' in line:
            start_time = float(lines[i + 3].split('=')[-1].strip())
            end_time = float(lines[i + 4].split('=')[-1].strip())
            sentence_audio = audio[start_time * 1000:end_time * 1000]
            sentence_audio.export(os.path.join(output_dir, f'{start_time}-{end_time}.wav'), format='wav')


textgrid_file = os.path.join(output_dir, os.path.basename(audio_file).replace('.wav', '.TextGrid'))
split_audio(audio_file, textgrid_file, output_dir)