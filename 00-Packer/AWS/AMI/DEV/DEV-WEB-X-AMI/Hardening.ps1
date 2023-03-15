# Sample Hardening.ps1
#
# This script demonstrates a basic example of applying some CIS benchmarks for Windows Server 2022.
# It is not exhaustive and should not be considered a complete solution for Windows hardening.

# Disable SMBv1
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" SMB1 -Type DWORD -Value 0

# Set Minimum Password Length to 14 characters
Set-LocalUser -MinimumPasswordLength 14

# Set Account Lockout Threshold to 5 invalid attempts
net accounts /lockoutthreshold:5

# Set Account Lockout Duration to 15 minutes
net accounts /lockoutduration:15

# Set Reset Account Lockout Counter After to 15 minutes
net accounts /lockoutwindow:15

# Configure Audit Policy to include Success and Failure for 'Account Logon Events' and 'Logon Events'
auditpol /set /subcategory:"Account Logon" /success:enable /failure:enable
auditpol /set /subcategory:"Logon" /success:enable /failure:enable

# Enable Windows Firewall
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled True

# Block incoming traffic on unused ports (example: block incoming traffic on port 445)
New-NetFirewallRule -DisplayName "Block Unused Port 445" -Direction Inbound -Protocol TCP -LocalPort 445 -Action Block
