#!/run/current-system/sw/bin/bash


# Set input and output directories
INPUT_DIR="./input"
OUTPUT_DIR="./output"

# Create the output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Loop over video files with different extensions
for file in "$INPUT_DIR"/*.{mp4,mkv,mov,mpg}; do
    # Extract the base filename without extension
    filename=$(basename "$file")

    # Skip files that do not exist (bash might try to process non-existent files for some extensions)
    [ -e "$file" ] || continue
    # Perform the compression using GPU, retaining metadata
    #
    
    ffmpeg -hwaccel cuda -i "$file" -vcodec hevc_nvenc -cq 23 -preset slow -map_metadata 0 -movflags use_metadata_tags -c:a copy -copyts "$OUTPUT_DIR/${filename%.*}_compressed.mp4"
    echo "Compressed and retained metadata: $file -> $OUTPUT_DIR/${filename%.*}_compressed.mpg"
done

