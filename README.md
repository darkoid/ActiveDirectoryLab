# Active Directory Home Lab With Bulk User Creation

## Description

This project is demonstration of creating an active directory home lab on VMware. I will be creating a Domain Controller (DC) using Microsoft Server 2022 and a domain using Microsoft Windows 11 Enterprise. To simulate a large business environment I will create over 1000 users in Active Directory and proceed to log into those newly created accounts on the domain via internet. In this lab I'll need a Microsoft Server 2022 ISO, A Windows 11 Enterprise ISO, VMWare and a Powershell script.

This project is demonstration of creating an active directory (AD) home lab on VMware. I will be creating a Domain Controller and a domain. To simulate a large business environment I will create over 1000 users in AD.

> Read more about terms used in Active Directory such as Domain Controller, Domain Service, Trusts and Objects on my [ActiveDirectoryBasics](https://github.com/darkoid/ActiveDirectoryBasics) repository.

## Hardware Requirement

- Minimum : 2GB on DomainController & 2GB on Domain VMs
- Recommended : 6GB on DomainController & 4GB on Domain VMs
> Total RAM spend on virtual machines should not be more than half of systems'. In total your sytem should have 8GB to 20GB of RAM.

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

![image](https://github.com/darkoid/ActiveDirectoryLab/assets/81341961/cf604c73-17ed-4c81-9622-df1d8cac58e7)
Apologies for some yellow dots I was making this on cloud.smartdraw and website started showing error and I coudn't reload otherwise it would asked to pay so I ss it as it was. Hope its not too inconvinient.

For the Virtual Machine that will be hosting my Domain Controller, I need two network adapters. I need the NAT that will use my host IP address from my home router and an internal network so that my DC can communicate with other Virtual Machines. For the internal network I will be using **vnet0**. Refer to the diagram at the beginning. <a href="./vnet0.md">How to create vnet0 and setup two networks in windows?</a>

https://github.com/darkoid/ActiveDirectoryLab/assets/81341961/677149f3-e91b-4561-a186-071422627460

https://github.com/darkoid/ActiveDirectoryLab/assets/81341961/e3f219ba-41f0-4dff-94ea-6b261e41a474

First install Windows Server 2022 on the Virtual Machine with **Server@@2022** for the administrator. First thing to do is install VMware tools to ease my copy-pasting and get resolution according to my window size.  Now take a snapshot and before restarting I also rename this pc to **MARVEL-DC** to make this a Marvel thmemed AD Lab.

![image](https://github.com/darkoid/ActiveDirectoryLab/assets/81341961/030e6e8c-0dc3-4375-9262-131cc53cd53a)

Now lets install and configure AD DS on our server. Follow the video tutorial.
```
Details used-
Root domain name: MARVEL.local
DSRM Password: Password@1
NetBIOS doamin name: MARVEL
```

https://github.com/darkoid/ActiveDirectoryLab/assets/81341961/0482fb63-0584-42a2-8199-bbaaaa1f58e5

After restart the logon portal will look like this (MARVEL/ in front of our user)-

![image](https://github.com/darkoid/ActiveDirectoryLab/assets/81341961/c827ee3f-1385-4f0d-994c-b6a631d2d10e)

Now lets setup Users on our server. If you are ever getting confused about the user and password just follow the topology. Also in this video we create a share so we enable the port 139 for SMB service as most organisation have to share files and they do it via SMB share on port 139 and we are trying to simulate that.
```
Details used-
username : password = fcastle:Password1, mmurdock:Password2, tstark:Morgan@2022, sqlservice:MYpassword!@#2023
file share profile = SMB Share - Quick
file share name = Micro
```


https://github.com/darkoid/ActiveDirectoryLab/assets/81341961/d9796fdc-738c-4b1a-af90-8e06a832e85f


I forgot to record the part where i put the SQLService user password in its description which you can see is shown after I was finished creating users. I did this because many admins thinks that description can't be read by others which we'll show that its not true in our [ActiveDirectoryAttacks](https://github.com/darkoid/ActiveDirectoryAttacks).

Lets change few policies and permissions so that when we do ActiveDirectoryAttacks, we have several attack vectors to practice on.


https://github.com/darkoid/ActiveDirectoryLab/assets/81341961/7155cea5-49a2-47b2-b6d4-a233ea3051d6


Lets take a snapshot here as we have done steps followed by TCM so if anything goes wrong we can turn back.

Now lets login to domain specific Tony Stark account instead of Administrator in Server 2022 with credential (**MARVEL\tstark : Morgan@2022**)-

![image](https://github.com/darkoid/ActiveDirectoryLab/assets/81341961/1b4d98a4-8d01-4655-b141-e6de84753770)

Now lets install **Remote Access** with RAS and Routing server roles so our client computers can acess the internet via our DC and configure it with NAT service on our **vnet0** network-


https://github.com/darkoid/ActiveDirectoryLab/assets/81341961/6e983863-2901-4fe3-9baf-a714158b547e


After config It started showing error & asking to restart so I did and it fixed the problem. Next step is to setup DHCP roles to our AD environment-


https://github.com/darkoid/ActiveDirectoryLab/assets/81341961/d21b342f-01cf-475f-a7d5-593771d9e579


lets begin bulk user addition with our [script](/bulk-user-addition.ps1). I have also added an additional [script](/bulk-user-from-names.ps1) to add users using a `name.txt` file. Note that I pasted the code from main machine to server as its advised now to use Browser on the server machine-


https://github.com/darkoid/ActiveDirectoryLab/assets/81341961/fbca67b8-161c-4346-a462-aea209fe346b


**Now that we are finished setting up our server machine, we can now install windows 11 (Client11)**
> Note: When we setup Windows 11 on VMWare it asks for encryption on the vm, which is requirement for updated windows so just put a simple password like **Password** and tick to remember it. We won't be needing this password in our ActiveDirectoryAttacks project.

```
Details used in windows 11 enterprise installation-
Enter your name : Client11
Password : Password12345
Security Questions : All answers were "bob"
Privacy settings : off to everything
```

First thing to do after login is to install VMWare tools and take snapshot then change computer name to **THEPUNISHER** and set network adapter to vnet0 and restart -

![image](https://github.com/darkoid/ActiveDirectoryLab/assets/81341961/136be3f2-edfa-45c5-b102-0f2b5a5f0edb)

I have set both the machines this way with custom background to easily go back and forth -

![image](https://github.com/darkoid/ActiveDirectoryLab/assets/81341961/6ed5d15e-5a05-4cfa-a97f-704eff8a6aa3)

Take a snapshot of this client machine so if anythings goes wront we can turn back.

![image](https://github.com/darkoid/ActiveDirectoryLab/assets/81341961/788b41d5-12bf-45a3-a532-723774fc219d)

Remember at this point it is absolutly important to have both machines running. Lets go to our **client11** (THEPUNISHER) machine and make it a member of the domain "MARVEL.local" -


https://github.com/darkoid/ActiveDirectoryLab/assets/81341961/2afc82cb-8153-491a-8f3b-77dd0ddba423


As you can see we got the MARVEL\fcastle on our logon portal -

![image](https://github.com/darkoid/ActiveDirectoryLab/assets/81341961/84f348e6-0eb4-483b-958f-3be924e4a36f)

As you can see we can ping domain and access internet -

![image](https://github.com/darkoid/ActiveDirectoryLab/assets/81341961/598f02a3-1146-4c07-a14b-aa9a1cb0f7fd)

To check the accounts we created via script lets logon to one of them after signing out of fcastle user-


https://github.com/darkoid/ActiveDirectoryLab/assets/81341961/69f3a882-a22b-47a7-b21f-b98f7b209b4d


## Credits

I made this project to revise the Active Directory stuff I learned from [PEH Course](https://academy.tcm-sec.com/p/practical-ethical-hacking-the-complete-course) by [@hmaverickadams](https://github.com/hmaverickadams) over 2 years ago.

## Need Help ?
Please open up an issue if you encounter any issues and I will try to resolve them as and when I can.

## Want to contribute ?
Please send a pull request if you add a feature or would like to contribute.
