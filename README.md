# Active Directory Home Lab With Bulk User Creation

## Description

This project is demonstration of creating an active directory home lab on VMware. I will be creating a Domain Controller (DC) using Microsoft Server 2022 and a domain using Microsoft Windows 11 Enterprise. To simulate a large business environment I will create over 1000 users in Active Directory and proceed to log into those newly created accounts on the domain via internet. In this lab I'll need a Microsoft Server 2022 ISO, A Windows 11 Enterprise ISO, VMWare and a Powershell script.

This project is demonstration of creating an active directory (AD) home lab on VMware. I will be creating a Domain Controller and a domain. To simulate a large business environment I will create over 1000 users in AD.

> Read more about terms used in Active Directory such as Domain Controller, Domain Service, Trusts and Objects on my [ActiveDirectoryBasics](https://github.com/darkoid/ActiveDirectoryBasics) repository.

## Hardware Requirement

- Minimum : 2GB on DomainController & 1GB on Domain VMs
- Recommended : 4GB on DomainController & 2GB on Domain VMs
> Total RAM spend on virtual machines should not be more than half of systems'. In total your sytem should have 6GB to 12GB of RAM.

## Software Requirement

### Environment Used

- VMware Workstation Player (windows) or VMware Fusion Pro (mac)
- Microsoft Server 2022 21H2
- Microsoft Windows 11 Enterprise
> Download the above files beforehand as that will take some time.

### Language and Utilities Used

- Active Directory
- PowerShell
- Command Prompt (cmd.exe)

## Links

- https://www.vmware.com/go/getplayer-win (workstation trial version)
- https://www.vmware.com/go/getfusion (fusion trial version)
- https://www.microsoft.com/en-us/evalcenter/download-windows-server-2022 (MS Server 2022)
- https://www.microsoft.com/en-in/evalcenter/download-windows-11-enterprise (Windows 11)

### Things to know before

- I'll tell you to make passwords sometimes with special char and sometimes with a simple password to create a good environment for next projects of vulnerability assessment and AD exploits.

# Program Walkthrough

The topology of my active direcotory lab for this project -

![image](https://github.com/darkoid/ActiveDirectoryLab/assets/81341961/38aeb710-1c67-41d0-9086-d9048c83ac72)

For the Virtual Machine that will be hosting my Domain Controller, I need two network adapters. I need the NAT that will use my host IP address from my home router and an internal network so that my DC can communicate with other Virtual Machines. For the internal network I will be using **vnet0**. Refer to the diagram at the beginning. <a href="./vnet0.md">How to create vnet0 and setup two networks in windows?</a>

https://github.com/darkoid/ActiveDirectoryLab/assets/81341961/cbc39365-3ea0-4427-9b2e-191a331a2f31

https://github.com/darkoid/ActiveDirectoryLab/assets/81341961/0bea7a7b-4c45-43b1-a29a-7834ea9b68a6

After installing Windows Server 2022 on the Virtual Machine with username/password = **Server22/Server@@2022** the first thing I do is install VMware tools to ease my copy-pasting and get resolution according to my window size. And before restarting I also rename this pc to **MARVEL-DC** to make this a Marvel thmemed active .

![image](https://github.com/darkoid/ActiveDirectoryLab/assets/81341961/030e6e8c-0dc3-4375-9262-131cc53cd53a)

Now lets install and configure AD DS on our server. Follow the video tutorial.
```
Details used-
Root domain name: MARVEL.local
DSRM Password: Password@1
NetBIOS doamin name: MARVEL
```
/////video here////

Now lets setup Users on our server. If you are ever getting confused about the user and password just follow the topology.
```
Details used-
username : password = fcastle:Password1, mmurdock:Password2, tstark:Morgan@2022, sqlservice:MYpassword!@#2023
```
/////video here////

Lets create a share so we enable the port 139 for SMB service as most organisation have to share files and they do it via SMB share on port 139 and we are trying to simulate that.

/////video here////

Lets change few policies and permissions so that when we goto our ActiveDirectoryAttacks we have several attack vectors to practice on.

/////video here//// Also show change the user SQL service's description to mention the password as well.

Now that we are finished setting up users, shares and policies, we can install windows 11 (Client1) and join it to our Domain.

## Credits

I made this project to revise the Active Directory stuff I learned from [PEH Course](https://academy.tcm-sec.com/p/practical-ethical-hacking-the-complete-course) by [@hmaverickadams](https://github.com/hmaverickadams) over 2 years ago.

## Need Help ?
Please open up an issue if you encounter any issues and I will try to resolve them as and when I can.

## Want to contribute ?
Please send a pull request if you add a feature or would like to contribute.
