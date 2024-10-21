Jacob Patterson
jjp2495@rit.edu
CSEC473 Fall - Team Charlie

Instructions to Build:
	First, make sure that you are on a box that has enum4linux and crackmapexec as these will be
	the tools that we are aiming to use. Once these tools have been installed, you can download
	the main script off of the GitHub link seen below.

	https://github.com/RIT-GCI/CSEC473-2024-FALL-CHARLIE

	Then navigate to the RedTeam folder and download the 'ad_scan.sh' script.

Instructions to Run:
	Make sure to use 'chmod +x' on the script so that it can be ran.

	You may need to edit the script to include the IP address of the domain controller that
	you are looking to scan, these areas will be marked in the script. Currently the script
	is pointing at a test machine so make sure that the IP you need is correct.

	Once that is completed, there should be no other steps needed for this as the script will
	run all of the commands and generate an output file for each one, removing any previous
	files from past executions.
