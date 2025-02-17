# book_scrape

```markdown
# Video Text Extraction Tool

This tool extracts text from video files (.mov) using frame extraction and OCR. It processes videos at 4 frames per second and combines the extracted text into a single output file.

## Prerequisites

### For Mac Users
1. Install required tools:
```bash
# Using Homebrew
brew install ffmpeg
brew install tesseract
```

2. Install Python 3 if not already installed:
```bash
brew install python3
```

### For Windows Users
1. Install Windows Subsystem for Linux (WSL):
   - Open PowerShell as Administrator and run:
```powershell
wsl --install
```
   - Restart your computer
   - Complete Ubuntu setup when it opens (create username/password)

2. Install required tools in WSL:
```bash
# Update package manager
sudo apt update
sudo apt upgrade

# Install required packages
sudo apt install ffmpeg
sudo apt install tesseract-ocr
sudo apt install python3
```

## Installation

1. Clone this repository:
```bash
git clone git@github.com:nac-codes/book_scrape.git
cd book_scrape
```

2. Make the scripts executable:
```bash
chmod +x src/run.sh
chmod +x src/monitor.sh
```

## Usage

### Single Video Processing
To process a single video file:

```bash
# Mac
./src/run.sh path/to/your/video.mov

# Windows (in WSL)
./src/run.sh /mnt/c/path/to/your/video.mov
```

The script will:
1. Extract frames from the video
2. Perform OCR on each frame
3. Combine the text into a single output file

Output will be saved in the same directory as the input video:
- `video_frames/`: Directory containing extracted frames
- `video_text_out/`: Directory containing OCR results for each frame
- `video.txt`: Final combined text file

### Automatic Directory Monitoring
To monitor a directory for new videos:

```bash
# Mac
./src/monitor.sh

# Windows (in WSL)
./src/monitor.sh
```

The monitor script will:
- Watch the specified directory for .mov files
- Automatically process any new videos
- Create corresponding text files
- Check every 60 seconds for new content

## Configuration

### Changing Monitored Directory
Edit `monitor.sh` and update the `CORPORA_DIR` variable:

```bash
# Default location
CORPORA_DIR="/Users/chim/Working/Thesis/Readings/corpora"

# Change to your preferred directory
CORPORA_DIR="/your/preferred/path"
```

### Windows Path Notes
When using WSL, Windows paths need to be accessed through `/mnt/`:
- `C:\Users\` becomes `/mnt/c/Users/`
- `D:\Videos\` becomes `/mnt/d/Videos/`

## Troubleshooting

### Common Issues

1. **Permission Denied**
```bash
chmod +x src/run.sh src/monitor.sh
```

2. **Command Not Found**
Ensure you're in the correct directory and the scripts are executable.

3. **FFmpeg/Tesseract Not Found**
Verify installations:
```bash
# Check FFmpeg
ffmpeg -version

# Check Tesseract
tesseract --version
```

4. **WSL File Access Issues**
- Ensure you're using the correct path format (`/mnt/c/...`)
- Check file permissions in WSL
- Make sure files aren't in use by Windows processes

### For Additional Help
If you encounter issues:
1. Check that all prerequisites are installed
2. Verify file permissions
3. Ensure paths are correctly specified for your system
4. Check system logs for error messages

## Notes
- Processing time depends on video length and system performance
- Frame extraction rate is set to 4 FPS
- Text files are generated using English language OCR
```
