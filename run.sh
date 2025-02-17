#!/bin/bash

# Set up trap to handle interrupts
trap 'cleanup' INT TERM

# Function to clean up processes
cleanup() {
    echo "Cleaning up..."
    kill -TERM $ffmpeg_pid 2>/dev/null
    exit 1
}

# Check if a .mov file was provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <input_file.mov>"
    exit 1
fi

# Input .mov file
mov_file="$1"
base_name=$(basename "$mov_file" .mov)
dir_name=$(dirname "$mov_file")

# Create directories
frames_dir="$dir_name/${base_name}_frames"
text_out_dir="$dir_name/${base_name}_text_out"

mkdir -p "$frames_dir" "$text_out_dir"

# Step 1: Extract frames from the .mov file at 4 fps and save them in the frames directory
echo "Extracting frames from $mov_file to $frames_dir at 4 fps..."
ffmpeg -i "$mov_file" -vf fps=4 "$frames_dir/frame_%04d.png" </dev/null
ffmpeg_exit_code=$?

if [ $ffmpeg_exit_code -ne 0 ]; then
    echo "Error: ffmpeg process failed with exit code $ffmpeg_exit_code"
    exit 1
fi

echo "Frame extraction complete."

# Step 2: Run tesseract on each frame to generate text files in the text_out directory
echo "Running tesseract on frames and saving text files to $text_out_dir..."
for img in "$frames_dir"/frame_*.png; do
    img_base_name=$(basename "$img" .png)
    tesseract "$img" "$text_out_dir/${img_base_name}" -l eng
done

# Step 3: Call the Python script to merge the text
python_script="/Users/chim/Working/Thesis/Readings/src/get_text.py"
output_file="$dir_name/${base_name}.txt"

echo "Merging text using the Python script $python_script..."
python3 "$python_script" "$text_out_dir" "$output_file"

echo "Process complete! Final merged text saved to $output_file."