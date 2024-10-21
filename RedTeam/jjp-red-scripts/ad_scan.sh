#! /bin/bash

#Jacob Patterson
#jjp2495@rit.edu
#Written 10/18/2024

#First remove any previous output files from past executions
#We use the touch command to create a file to avoid throwing errors
touch def_scan.txt && rm def_scan.txt
touch verbose_scan.txt && rm verbose_scan.txt
touch user_scan.txt && rm user_scan.txt
touch cred_scan.txt && rm cred_scan.txt
touch cme_null.txt && rm cme_null.txt
touch cme_anon.txt && rm cme_anon.txt
touch cme_users.txt && rm cme_users.txt
touch cme_policy.txt && rm cme_policy.txt

#--Enum4Linux Scans--
#Run a default enum4linux scan:
enum4linux -a 100.64.1.23 >> def_scan.txt

#Verbose scan:
enum4linux -v 100.64.1.23 >> verbose_scan.txt

#User List scan:
enum4linux -U 100.64.1.23 >> user_scan.txt

#User scan with credentials:
#If credentials are known, insert them into the quote marks
enum4linux -u '' -p '' -U 100.64.1.23 >> cred_scan.txt

#--CrackMapExec Commands--
#Enumerate Sessions:
crackmapexec smb 100.64.1.23 -u '' -p '' >> cme_null.txt
crackmapexec smb 100.64.1.23 -u 'a' -p '' >> cme_anon.txt

#User List:
crackmapexec smb 100.64.1.23 --users >> cme_users.txt

#Password Policy:
crackmapexec smb 100.64.1.23 -u '' -p '' --pass-pol >> cme_policy.txt
