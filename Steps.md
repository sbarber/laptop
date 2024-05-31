# Steps to get everything set up

## Initial Screen
1. Add user account to OS as part of the initial setup after power on.
2. Don't add an Apple account as part of this process
3. Don't connect to WiFi or any networks

## Disable MDM
1. Add the following lines to /etc/hosts: <br/>
<code>
0.0.0.0		iprofiles.apple.com  
0.0.0.0		mdmenrollment.apple.com  
0.0.0.0		deviceenrollment.apple.com  
0.0.0.0		gdmf.apple.com  
0.0.0.0		acmdm.apple.com  
0.0.0.0		albert.apple.com
</code>
1. Run `sudo profiles remove -all`
1. Running this should give you an error `sudo profiles show -type enrollment`
1. Reboot

## Network, updates and accounts
1. Connect to WiFi
1. Update the OS if needed
1. Add personal Apple Account to machine (mas dependency)

## Ansible
1. Run the ansible playbook (locally or from another machine)

