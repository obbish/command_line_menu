#!/bin/bash

# Define command names and corresponding commands
commands=(
    "List Files:ls -l"
    "Show Date:date"
    "System Info:uname -a"
    "System Uptime:uptime"
)

# Function to display the menu
show_menu() {
    echo
    echo "Choose a command to run:"
    echo "-----------------------"
    for ((i=0; i<${#commands[@]}; i++)); do
        echo "[$i] ${commands[i]%%:*}"  # Display command name
    done
    echo
    echo "[q] Quit"
}

# Main function
main() {
    while true; do
        show_menu
        read -p "Enter your choice: " choice

        # Validate the choice
        if [[ "$choice" == "q" ]]; then
            echo "Exiting..."
            exit 0
        fi

        # Check if the choice is a valid number
        re='^[0-9]+$'
        if ! [[ $choice =~ $re ]] || (( choice < 0 || choice >= ${#commands[@]} )); then
            echo "Invalid choice. Please enter a valid number."
            continue
        fi

        # Execute the selected command
        command="${commands[choice]##*:}"  # Extract the command part
        echo "Executing: $command"
        eval "$command"
        break
    done
}

# Run the main function
main
