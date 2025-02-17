import os
import sys
from difflib import SequenceMatcher

def read_file(file_path):
    with open(file_path, 'r', encoding='utf-8') as file:
        return file.read().strip()

def similar(a, b):
    return SequenceMatcher(None, a, b).ratio()

def combine_texts(directory):
    files = sorted([f for f in os.listdir(directory) if f.endswith('.txt')])
    combined_text = ""
    prev_text = ""

    for file in files:
        current_text = read_file(os.path.join(directory, file))
        
        # Check if the current text is significantly different from the previous text
        if similar(prev_text, current_text) < 0.9:  # Adjust this threshold as needed
            combined_text += current_text + "\n\n"
        
        prev_text = current_text

    return combined_text.strip()

def main():
    if len(sys.argv) != 3:
        print("Usage: python3 script.py <input_directory> <output_file>")
        sys.exit(1)

    input_directory = sys.argv[1]
    output_file = sys.argv[2]

    combined_text = combine_texts(input_directory)

    with open(output_file, 'w', encoding='utf-8') as file:
        file.write(combined_text)

    print(f"Combined text has been written to {output_file}")

if __name__ == "__main__":
    main()