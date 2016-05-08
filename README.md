# perl5-parallel-SSH-Sudo
Perl script to install packages through multiple hosts through SSH.

Requirements:

Install Net::OpenSSH::Parallel
Install Config::IniFiles

Sample of confi.ini file:

[127.0.0.1]
user=testUser
port=22 #default
password=testPassword
label=HostnameDescription
