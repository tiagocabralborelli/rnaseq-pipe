import os
import subprocess


def GetfileList(path):
    files = os.listdir(path)
    return files

def ExtractFastq(file):
    command = ["fastq-dump", file, "-O", "fastq"]
    subprocess.run(command)


if __name__ == '__main__':
    SraFiles = GetfileList("./srr")
    for f in SraFiles:
        ExtractFastq(f)
