import subprocess

def DownloadFile(srr):
    CommandPrefetch = ["prefetch",srr, "-O", "srr"]
    subprocess.run(CommandPrefetch)


if __name__ == '__main__':
    DownloadFile('SRR2047523')
