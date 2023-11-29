#!/bin/sh
current_directory=$(pwd)
parent_directory="${current_directory%/*}"
project_name="codecrafters-git-rust"
project_path="${parent_directory}/${project_name}"

# Display the final directory
echo "$project_path"
