---
- name: Configure Domain on Windows Server
  hosts: winserv
  gather_facts: yes

  tasks:
    - name: Copy PowerShell script to Windows Server
      win_copy:
        src: /home/debian/ansible/powershell_scripts/create_users2.ps1
        dest: C:\Users\Administrator\create_users2.ps1

    - name: Run PowerShell script to create users
      win_shell: |
        powershell.exe -ExecutionPolicy Bypass -File C:\Users\Administrator\create_users2.ps1
