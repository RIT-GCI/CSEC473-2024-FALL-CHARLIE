#!/bin/bash
import os
import random
import string

def create_fake_file(file_path, size):
    """Create a fake file with random content."""
    with open(file_path, 'w') as f:
        f.write(''.join(random.choices(string.ascii_letters + 
string.digits, k=size)))

def create_fake_directories(base_path, num_dirs=10, depth=0, max_depth=3):
    """Create fake directories with fake files."""
    if depth > max_depth:
        return

    fake_names = [
        "Backdoor_Installer", "Hacker_Tools", "Malware_Repo", "Exploits",
        "Phishing_Scripts", "Rootkit_Sources", "Crypto_Cracker", 
	"Data_Leak", "Command_and_Control", "Botnet_Config", "Stealth_Services", 
        "Payloads", "Recon_Data", "Keylogger_Files", "Access_Tokens"
    ]

    for i in range(num_dirs):
        dir_name = random.choice(fake_names) + f"_{depth}_{i+1}"
        dir_path = os.path.join(base_path, dir_name)

        os.makedirs(dir_path, exist_ok=True)
        print(f"Created directory: {dir_path}")

        # Create random files in the directory
        num_files = random.randint(2, 5)  # Random number of files per directory
        for j in range(num_files):
            file_name = f"file_{j+1}.txt"
            file_path = os.path.join(dir_path, file_name)
            file_size = random.randint(5, 50)  # Random file size between 5 and 50 characters
            create_fake_file(file_path, file_size)

        # Recursively create subdirectories
        if depth < max_depth:
            create_fake_directories(dir_path, num_dirs=random.randint(1, 3), depth=depth + 1, max_depth=max_depth)

if __name__ == "__main__":
    base_directory = "./"  # Change this to your desired path
    os.makedirs(base_directory, exist_ok=True)  # Create base directory if it doesn't exist
    create_fake_directories(base_directory, num_dirs=5)  # Create up to 5 top-level directories
