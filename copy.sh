#!/run/current-system/sw/bin/bash

# Define the input and output directories
input_dir="input"
output_dir="output"

# Loop through each file in the input directory
for input_file in "$input_dir"/*; do
    # Extract the base filename (without path)
    base_filename=$(basename "$input_file")
    
    # Define the corresponding output file name
    output_file="$output_dir/${base_filename%.*}_compressed.mp4"
    
    # Check if the output file exists
    if [ -f "$output_file" ]; then
        # Get original timestamps
        mod_date=$(stat -c %y "$input_file" | cut -d'.' -f1)
        access_date=$(stat -c %x "$input_file" | cut -d'.' -f1)
        
        # Apply original timestamps to the output file
        touch -d "$mod_date" "$output_file"
        touch -a -d "$access_date" "$output_file"
        
        echo "Timestamps copied from '$input_file' to '$output_file'."
    else
        echo "Warning: No matching output file for '$input_file'."
    fi
done

echo "Timestamp copying completed."

