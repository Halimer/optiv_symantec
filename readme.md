# Distributor Code for Symantec
* From the Symantec CWP Settings page download the Amazon Linux agent(scwp_agent_amazonlinux_package.tar.gz)
* From the Symantec CWP Settings Page download the Windows Agent(scwp_agent_windows_package.zip)
* Upload both files to the S3 Bucket
* Select the scwp_agent_windows_package.zip file once it is in S3 and then select Make Public
* Then upload the SYM_WINDOWS.zip, SYM_AMAZON.zip, and manifest.json to the S3 Bucket
* Once uploaded click on the manifest.json file
* At the bottom of the page copy the https://s3.amazon.com/<bucket>/ part of the URL.  You don't need the manifest.json part
* Use that URL for Creating the System Manager Distributor Package