##==========================================================================================================##
##Script Name = New User Creation - AD/Azure/O365 - Frontpoint Security												
##Author Name = Ben Bone																				
##Author Mail = ben.bone@frontpointsecurity.com																
##Version	  = v3.3 (8/5/2016)																			
##Description = This script was designed to ensure configuration integrity on core FP application systems. 	
##				The script runs several core functions to lock in configuration files and others to compare	
##				them with current state information. 														
##==========================================================================================================##
#=====================================================#
# Global Variables
#=====================================================#
$Date = Get-Date -format g
$MyName = [Environment]::UserName
$ErrorActionPreference = "SilentlyContinue"
$MyCred = get-credential 
#=====================================================#


#============================================================================#
# Function FP-NewADUser -- Create New User Account
# Set new PW to - Welcome1!
# Create new user from Template
#============================================================================#


#=============================================================================
# Function PauseFunction
#=============================================================================


#=====================================================#
# Function -- Main Menu (Non-Preferred Name)
#=====================================================#

Function MainMenu
{
do
{
	cls
	write-host -fore Red `n "==============================================================================================="
		write-host -fore Cyan `n "                                -- New User Creation --"
		write-host -fore Cyan `n "    -- Please ensure that all the below fields are populated before selecting 'GO' --"
		write-host -fore Yellow `n "My Name Is                      = " -NoNewline
        write-host "[" -ForegroundColor Yellow -NoNewline
        write-host "$MyName" -ForegroundColor White -NoNewline
        write-host "]" -ForegroundColor Yellow -NoNewline
		write-host -fore Yellow `n "User First Name                 = " -NoNewline
        write-host "[" -ForegroundColor Yellow -NoNewline
        write-host "$firstname" -ForegroundColor White -NoNewline
        write-host "]" -ForegroundColor Yellow -NoNewline
        write-host -fore Yellow `n "User Last Name                  = " -NoNewline
        write-host "[" -ForegroundColor Yellow -NoNewline
        write-host "$lastname" -ForegroundColor White -NoNewline
		write-host "]" -ForegroundColor Yellow -NoNewline
        write-host -fore Yellow `n "User Title                      = " -NoNewline
        write-host "[" -ForegroundColor Yellow -NoNewline
        write-host "$title" -ForegroundColor White -NoNewline
		write-host "]" -ForegroundColor Yellow -NoNewline
        write-host -fore Yellow `n "User Display Name               = " -NoNewline
        write-host "[" -ForegroundColor Yellow -NoNewline
        write-host "$DisplayName" -ForegroundColor White -NoNewline
		write-host "]" -ForegroundColor Yellow -NoNewline
        write-host -fore Yellow `n "User Logon Name                 = " -NoNewline
        write-host "[" -ForegroundColor Yellow -NoNewline
        write-host "$logon" -ForegroundColor White -NoNewline
		write-host "]" -ForegroundColor Yellow -NoNewline
        write-host -fore Yellow `n "User Department                 = " -NoNewline
        write-host "[" -ForegroundColor Yellow -NoNewline
        write-host "$department" -ForegroundColor White -NoNewline
		write-host "]" -ForegroundColor Yellow -NoNewline
        write-host -fore Yellow `n "User Address                    = " -NoNewline
        write-host "[" -ForegroundColor Yellow -NoNewline
        write-host "$location" -ForegroundColor White -NoNewline
		write-host "]" -ForegroundColor Yellow -NoNewline
	write-host -fore Red `n "==============================================================================================="
	write-host -fore Cyan `n "                                -- Set User Details --"
	write-host -fore Red `n "==============================================================================================="
	write-host -fore Cyan `n "      Step 1"
	write-host -fore Green `t '[1] Configure User Settings'
	write-host -fore Red `n "==============================================================================================="
	write-host -fore Cyan `n "                                -- Set User Department --"
	write-host -fore Red `n "==============================================================================================="
	write-host -fore Cyan `n "      Step 2"
	write-host -fore Green `t '[2] Accounting'
	write-host -fore Green `t '[3] Brand'
	write-host -fore Green `t '[4] Compliance'
	write-host -fore Green `t '[5] Contractors'
	write-host -fore Green `t '[6] Corporate'
	write-host -fore Green `t '[7] Data Strategy'
	write-host -fore Green `t '[8] Executives'
	write-host -fore Green `t '[9] Facilities'
	write-host -fore Green `t '[10] Finance'
	write-host -fore Green `t '[11] Fulfillment'
	write-host -fore Green `t '[12] IT'
	write-host -fore Green `t '[13] Recruiting'
	write-host -fore Green `t '[14] Sales'
	write-host -fore Green `t '[15] Support'
	write-host -fore Green `t '[16] Retention'

	write-host -fore Red `n "==============================================================================================="
	write-host -fore Cyan `n "                                -- Set User Location --"
	write-host -fore Red `n "==============================================================================================="
	write-host -fore Cyan `n "      Step 3"
	write-host -fore Green `t '[1595] 1595'
	write-host -fore Green `t '[1593] 1593'

	write-host -fore Red `n "==============================================================================================="
	write-host -fore Cyan `n "                                -- Execute User Creation --"
	write-host -fore Red `n "==============================================================================================="
	write-host -fore Cyan `n "      Step 4"
	write-host -fore Yellow `t '[GO] Create User'
	write-host -fore Red `n "==============================================================================================="
	write-host -fore Cyan `n "                                -- Help, or leave --"
	write-host -fore Red `n "==============================================================================================="
	write-host -fore Cyan `n "      Step 5"
    write-host -fore White `t "[H] Help! This tool isn't working (Submitts Ticket)"
	write-host -fore White `t "[E] Exit Utility"
	write-host -fore Red `n "==============================================================================================="
	$result = read-host
	cls
	switch ($result)
	{
		1 {
		$firstname = read-host -prompt "Please enter First Name"
        $lastname = read-host -prompt "Please enter Last Name"
        $DisplayName = read-host -prompt "Please Enter Display Name"
        $logon = read-host -prompt "Please enter Logon"
        $title = read-host -prompt "Please enter Title"
        $User = Get-ADUser -LDAPFilter "(sAMAccountName=$logon)"
        If ($User -eq $Null) {"User does not already exist"}
        Else {"User found in AD! Please Add a 1 or 2 to the Username!"} 
        Pause
		}
		2 {
		$OU = "OU=Accounting,OU=Users,OU=FPSSI,DC=FPSSI,DC=com"
        $department = "Accounting"
        $Group1 = "AzureADSync"
        $Group2 = "Finance-Documentation"
        $Group3 = "FPSSI"
        $Group4 = "FPSSI_VPN"
        $Group5 = "Payroll"
        $Group6 = "Remote Desktop Users"
        $Group7 = "Sales-Restricted"
        $Group8 = "Training"
        $Group9 = "Users with 10 Minute Screen Lock"
		}
		3 {
        $OU = "OU=Brand,OU=Users,OU=FPSSI,DC=FPSSI,DC=com" 
        $department = "Brand"
        $Group1 = "AzureADSync"
        $Group2 = "FPSSI"
        $Group3 = "FPSSI_VPN"
        $Group4 = "Marketing"
        $Group5 = "Qlikview - User"
        $Group6 = "Remote Desktop Users"
        $Group7 = "Users with 10 Minute Screen Lock"
        }
		4 {
        $OU = "OU=Compliance,OU=Users,OU=FPSSI,DC=FPSSI,DC=com"        
        $department = "Compliance"
        $Group1 = "AzureADSync"
        $Group2 = "Users with 10 Minute Screen Lock"
        $Group3 = "OPS"
        $Group4 = "FPSSI"
        $Group5 = "SHASTA Secondary"
        $Group6 = "Compliance"
        $Group7 = "SHASTA"
        $Group8 = "Customer Files - Modify"
        $Group9 = "Remote Desktop Users"
        $Group10 = "Print Operators"
          }  
        5 {
		$OU = "OU=Contractors,OU=Users,OU=FPSSI,DC=FPSSI,DC=com"
        $department = "Contractors"
        $Group1 = "AzureADSync"
        $Group2 = "Finance-Documentation"
        $Group3 = "FPSSI"
        $Group4 = "FPSSI_VPN"
        $Group5 = "Remote Desktop Users"
        $Group6 = "Users with 10 Minute Screen Lock"
          }   
        6 {
		$OU = "OU=Corporate,OU=Users,OU=FPSSI,DC=FPSSI,DC=com"
        $department = "Corporate"
        $Group1 = "AzureADSync"        
        $Group2 = "Finance-Documentation"
        $Group3 = "FPSSI"
        $Group4 = "FPSSI_VPN"
        $Group5 = "HR"
        $Group6 = "HR-Restricted"
        $Group7 = "Payroll"
        $Group8 = "Remote Desktop Users"
        $Group9 = "Sales-Restricted"
        $Group10 = "Training"
        $Group11 = "Users with 10 Minute Screen Lock"
        $Group12 = "Corporate Services"
        $Group13 = "Corporate Services Helpdesk"
          }  
        7 {
		$OU = "OU=Data Strategy,OU=Users,OU=FPSSI,DC=FPSSI,DC=com"
        $department = "Data Strategy"
        $Group1 = "AzureADSync"
        $Group2 = "Business Intelligence"
        $Group3 = "Customer Files - Modify"
        $Group4 = "FPSSI"
        $Group5 = "FPSSI_VPN"
        $Group6 = "MCKINLEY"
        $Group7 = "Qlikview - Development"
        $Group8 = "Remote Desktop Users"
        $Group9 = "Scripter Project "
          }  
        8 {
		$OU = "OU=Execs,OU=Users,OU=FPSSI,DC=FPSSI,DC=com"
        $department = "Executives"
        $Group1 = "AzureADSync"
        $Group2 = "Finance-Documentation"
        $Group3 = "FPSSI"
        $Group4 = "FPSSI_VPN"
        $Group5 = "HR"
        $Group6 = "HR-Restricted"
        $Group7 = "Payroll"
        $Group8 = "Remote Desktop Users"
        $Group9 = "Sales-Restricted"
        $Group10 = "Training"
        $Group11 = "Users with 10 Minute Screen Lock"
          }   
        9 {
		$OU = "OU=Facilities,OU=Users,OU=FPSSI,DC=FPSSI,DC=com"
        $department = "Facilities"
        $Group1 = "AzureADSync"
        $Group2 = "Finance-Documentation"
        $Group3 = "FPSSI"
        $Group4 = "FPSSI_VPN"
        $Group5 = "HR"
        $Group6 = "HR-Restricted"
        $Group7 = "Payroll"
        $Group8 = "Remote Desktop Users"
        $Group9 = "Sales-Restricted"
        $Group10 = "Training"
        $Group11 = "Users with 10 Minute Screen Lock"
          }
        10 {
		$OU = "OU=Finance,OU=Users,OU=FPSSI,DC=FPSSI,DC=com"
        $department = "Finance"
        $Group1 = "AzureADSync"
        $Group2 = "Corporate Strategy"
        $Group3 = "FPSSI"
        $Group4 = "FPSSI_VPN"
        $Group5 = "MCKINLEY"
        $Group6 = "Remote Desktop Users"
        $Group7 = "Corporate-Services"
        $Group8 = "CorporateServicesHelpdesk"
          }
        11 {
		$OU = "OU=Fulfillment,OU=Users,OU=FPSSI,DC=FPSSI,DC=com"
        $department = "Fulfillment"
        $Group1 = "AzureADSync"        
        $Group2 = "Customer Support"
        $Group3 = "FPSSI"
        $Group4 = "Fulfillment"
        $Group5 = "Fulfillment - Techs"
        $Group6 = "FULL - Printer Group"
        $Group7 = "HOOD Secondary"
        $Group8 = "Inventory"
        $Group9 = "OPS Secondary Printers"
        $Group10 = "ORODRUIN Primary"
        $Group11 = "Users with 10 Minute Screen Lock"
        $Group12 = "operations-support"
          }
        12 {
		$OU = "OU=IT,OU=Users,OU=FPSSI,DC=FPSSI,DC=com"
        $department = "IT"
        $Group1 = "AzureADSync"
        $Group2 = "IT"
        $Group3 = "fpssiapp001 $ Acronis Remote Users"
        $Group4 = "FPSSI"
        $Group5 = "MCKINLEY"
        $Group6 = "Qlikview - Development"
        $Group7 = "FPSSI_VPN"
        $Group8 = "Users"
        $Group9 = "Administrators"
        $Group10 = "Remote Desktop Users"
        $Group11 = "AzureADSync"
          }
        13 {
		$OU = "OU=Recruiting,OU=Users,OU=FPSSI,DC=FPSSI,DC=com"
        $department = "Recruiting"
        $Group1 = "AzureADSync"
        $Group2 = "Domain Users"
        $Group3 = "Finance-Documentation"
        $Group4 = "FPSSI"
        $Group5 = "FPSSI_VPN"
        $Group6 = "GPSERVER idle timeout disconnect"
        $Group7 = "HR"
        $Group8 = "HR-Restricted"
        $Group9 = "Remote Desktop Users"
        $Group10 = "Sales Restricted"
        $Group11 = "Training"
        $Group12 = "Users with 10 Minute Screen Lock"
          }
        14 {
		$OU = "OU=Sales and Support,OU=Users,OU=FPSSI,DC=FPSSI,DC=com"
        $department = "Sales"
        $Group1 = "AzureADSync"
        $Group2 = "FPSSI"
        $Group3 = "MonteViso"
        $Group4 = "OPS"
        $Group5 = "Remote Desktop Users"
        $Group6 = "Sales"
        $Group7 = "Sales-SSRS"
        $Group8 = "Users with 10 Minute Screen Lock"
        $Group9 = "Wb3 Deployment"
          }
        15 {
		$OU = "OU=Sales and Support,OU=Users,OU=FPSSI,DC=FPSSI,DC=com"
        $department = "Support"
        $Group1 = "AzureADSync"
        $Group2 = "Customer Retention Agents"
        $Group3 = "Customer Retention Specialists"
        $Group4 = "Customer Support"
        $Group5 = "FPSSI"
        $Group6 = "OPS"
        $Group7 = "Remote Desktop Users"
        $Group8 = "Users with 10 Minute Screen Lock"
        $Group9 = "frontpoint_all"
        $Group10 = "operations-support"
          }
       16 {
		$OU = "OU=Sales and Support,OU=Users,OU=FPSSI,DC=FPSSI,DC=com"
        $department = "Retention"
        $Group1 = "AzureADSync"
        $Group2 = "Customer Relations CSS"
        $Group3 = "Customer Support"
        $Group4 = "FPSSI"
        $Group5 = "OPS"
        $Group6 = "Remote Desktop Users"
        $Group7 = "Users with 10 Minute Screen Lock"
          }
        1595 {
        $location = "1595 Spring Hill Rd #110"
          }  
        1593 {
        $location = "1593 Spring Hill Rd"
          }     
		GO {
        FP-NewADUser
        AddGroups
            Write-Host -fore Cyan –NoNewLine 'Executing Account Sycn With Azure'
	        foreach ($element in 1..3)
	        {
		    Write-Host -NoNewline  "${element} " -BackgroundColor 'Cyan' -ForegroundColor 'Black'
		    Start-Sleep –Seconds 1
	        }
	        Write-Host ''
            Invoke-Command -ComputerName fpvi-azc1.fpssi.com {Start-ADSyncSyncCycle -PolicyType Delta}
            Pause
          }
        H {
        SendMail
          }
          "E" { "Exiting" }
		  default { "You did not select a valid option, please try again" }              
}

	IF (!($result -eq "E"))
	{

	}
}
while (!($result -eq "E"))

}

#=====================================================#
# Function -- Main Menu (Non-Preferred Name)
#=====================================================#

Function MainMenuPreferred
{
do
{
	cls
	write-host -fore Magenta `n "==============================================================================================="
		write-host -fore Cyan `n "                       -- New User Creation (Preferred Name User) --"
		write-host -fore Cyan `n "    -- Please ensure that all the below fields are populated before selecting 'GO' --"
		write-host -fore White `n "My Name Is                      = " -NoNewline
        write-host "[" -ForegroundColor White -NoNewline
        write-host "$MyName" -ForegroundColor Yellow -NoNewline
        write-host "]" -ForegroundColor White -NoNewline
		write-host -fore White `n "User First Name                 = " -NoNewline
        write-host "[" -ForegroundColor White -NoNewline
        write-host "$firstname" -ForegroundColor Yellow -NoNewline
        write-host "]" -ForegroundColor White -NoNewline
		write-host -fore White `n "User Preffered Name             = " -NoNewline
        write-host "[" -ForegroundColor White -NoNewline
        write-host "$preferred" -ForegroundColor Yellow -NoNewline
        write-host "]" -ForegroundColor White -NoNewline
        write-host -fore White `n "User Last Name                  = " -NoNewline
        write-host "[" -ForegroundColor White -NoNewline
        write-host "$lastname" -ForegroundColor Yellow -NoNewline
		write-host "]" -ForegroundColor White -NoNewline
		write-host -fore White `n "User Display Name               = " -NoNewline
        write-host "[" -ForegroundColor White -NoNewline
        write-host "$DisplayName" -ForegroundColor Yellow -NoNewline
        write-host "]" -ForegroundColor White -NoNewline
        write-host -fore White `n "User Title                      = " -NoNewline
        write-host "[" -ForegroundColor White -NoNewline
        write-host "$title" -ForegroundColor Yellow -NoNewline
		write-host "]" -ForegroundColor White -NoNewline
        write-host -fore White `n "User Logon Name                 = " -NoNewline
        write-host "[" -ForegroundColor White -NoNewline
        write-host "$logon" -ForegroundColor Yellow -NoNewline
		write-host "]" -ForegroundColor White -NoNewline
        write-host -fore White `n "User Department                 = " -NoNewline
        write-host "[" -ForegroundColor White -NoNewline
        write-host "$department" -ForegroundColor Yellow -NoNewline
		write-host "]" -ForegroundColor White -NoNewline
        write-host -fore White `n "User Address                    = " -NoNewline
        write-host "[" -ForegroundColor White -NoNewline
        write-host "$location" -ForegroundColor Yellow -NoNewline
		write-host "]" -ForegroundColor White -NoNewline
	write-host -fore Magenta `n "==============================================================================================="
	write-host -fore Cyan `n "                                -- Set User Details --"
	write-host -fore Magenta `n "==============================================================================================="
	write-host -fore Cyan `n "      Step 1"
	write-host -fore Yellow `t '[1] Configure User Settings'
	write-host -fore Magenta `n "==============================================================================================="
	write-host -fore Cyan `n "                                -- Set User Department --"
	write-host -fore Magenta `n "==============================================================================================="
	write-host -fore Cyan `n "      Step 2"
	write-host -fore Yellow `t '[2] Accounting'
	write-host -fore Yellow `t '[3] Brand'
	write-host -fore Yellow `t '[4] Compliance'
	write-host -fore Yellow `t '[5] Contractors'
	write-host -fore Yellow `t '[6] Corporate'
	write-host -fore Yellow `t '[7] Data Strategy'
	write-host -fore Yellow `t '[8] Executives'
	write-host -fore Yellow `t '[9] Facilities'
	write-host -fore Yellow `t '[10] Finance'
	write-host -fore Yellow `t '[11] Fulfillment'
	write-host -fore Yellow `t '[12] IT'
	write-host -fore Yellow `t '[13] Recruiting'
	write-host -fore Yellow `t '[14] Sales'
	write-host -fore Yellow `t '[15] Support'
	write-host -fore Yellow `t '[16] Retention'


	write-host -fore Magenta `n "==============================================================================================="
	write-host -fore Cyan `n "                                -- Set User Location --"
	write-host -fore Magenta `n "==============================================================================================="
	write-host -fore Cyan `n "      Step 3"
	write-host -fore Yellow `t '[1595] 1595'
	write-host -fore Yellow `t '[1593] 1593'

	write-host -fore Magenta `n "==============================================================================================="
	write-host -fore Cyan `n "                                -- Execute User Creation --"
	write-host -fore Magenta `n "==============================================================================================="
	write-host -fore Cyan `n "      Step 4"
	write-host -fore Green `t '[GO] Create User'
	write-host -fore Magenta `n "==============================================================================================="
	write-host -fore Cyan `n "                                -- Help, or leave --"
	write-host -fore Magenta `n "==============================================================================================="
	write-host -fore Cyan `n "      Step 5"
    write-host -fore White `t "[H] Help! This tool isn't working (Submitts Ticket)"
	write-host -fore White `t "[E] Exit Utility"
	write-host -fore Magenta `n "==============================================================================================="
	$result = read-host
	cls
	switch ($result)
	{
		1 {
		$firstname = read-host -prompt "Please enter First Name"
        $preferred = read-host -prompt "Please enter Preferred Name" 
        $lastname = read-host -prompt "Please enter Last Name"
        $DisplayName = read-host -prompt "Please Enter Display Name"
        $logon = read-host -prompt "Please enter Logon"
        $title = read-host -prompt "Please enter Title"
        $User = Get-ADUser -LDAPFilter "(sAMAccountName=$logon)"
        If ($User -eq $Null) {"User does not already exist"}
        Else {"User found in AD! Please Add a 1 or 2 to the Username!"} 
        Pause     
		}
		2 {
		$OU = "OU=Accounting,OU=Users,OU=FPSSI,DC=FPSSI,DC=com"
        $department = "Accounting"
        $Group1 = "AzureADSync"
        $Group2 = "Finance-Documentation"
        $Group3 = "FPSSI"
        $Group4 = "FPSSI_VPN"
        $Group5 = "Payroll"
        $Group6 = "Remote Desktop Users"
        $Group7 = "Sales-Restricted"
        $Group8 = "Training"
        $Group9 = "Users with 10 Minute Screen Lock"
		}
		3 {
        $OU = "OU=Brand,OU=Users,OU=FPSSI,DC=FPSSI,DC=com" 
        $department = "Brand"
        $Group1 = "AzureADSync"
        $Group2 = "FPSSI"
        $Group3 = "FPSSI_VPN"
        $Group4 = "Marketing"
        $Group5 = "Qlikview - User"
        $Group6 = "Remote Desktop Users"
        $Group7 = "Users with 10 Minute Screen Lock"
        }
		4 {
        $OU = "OU=Compliance,OU=Users,OU=FPSSI,DC=FPSSI,DC=com"        
        $department = "Compliance"
        $Group1 = "AzureADSync"
        $Group2 = "Users with 10 Minute Screen Lock"
        $Group3 = "OPS"
        $Group4 = "FPSSI"
        $Group5 = "SHASTA Secondary"
        $Group6 = "Compliance"
        $Group7 = "SHASTA"
        $Group8 = "Customer Files - Modify"
        $Group9 = "Remote Desktop Users"
        $Group10 = "Print Operators"
          }  
        5 {
		$OU = "OU=Contractors,OU=Users,OU=FPSSI,DC=FPSSI,DC=com"
        $department = "Contractors"
        $Group1 = "AzureADSync"
        $Group2 = "Finance-Documentation"
        $Group3 = "FPSSI"
        $Group4 = "FPSSI_VPN"
        $Group5 = "Remote Desktop Users"
        $Group6 = "Users with 10 Minute Screen Lock"
          }   
        6 {
		$OU = "OU=Corporate,OU=Users,OU=FPSSI,DC=FPSSI,DC=com"
        $department = "Corporate"
        $Group1 = "AzureADSync"        
        $Group2 = "Finance-Documentation"
        $Group3 = "FPSSI"
        $Group4 = "FPSSI_VPN"
        $Group5 = "HR"
        $Group6 = "HR-Restricted"
        $Group7 = "Payroll"
        $Group8 = "Remote Desktop Users"
        $Group9 = "Sales-Restricted"
        $Group10 = "Training"
        $Group11 = "Users with 10 Minute Screen Lock"
        $Group12 = "Corporate Services"
        $Group13 = "Corporate Services Helpdesk"
          }  
        7 {
		$OU = "OU=Data Strategy,OU=Users,OU=FPSSI,DC=FPSSI,DC=com"
        $department = "Data Strategy"
        $Group1 = "AzureADSync"
        $Group2 = "Business Intelligence"
        $Group3 = "Customer Files - Modify"
        $Group4 = "FPSSI"
        $Group5 = "FPSSI_VPN"
        $Group6 = "MCKINLEY"
        $Group7 = "Qlikview - Development"
        $Group8 = "Remote Desktop Users"
        $Group9 = "Scripter Project "
          }  
        8 {
		$OU = "OU=Execs,OU=Users,OU=FPSSI,DC=FPSSI,DC=com"
        $department = "Executives"
        $Group1 = "AzureADSync"
        $Group2 = "Finance-Documentation"
        $Group3 = "FPSSI"
        $Group4 = "FPSSI_VPN"
        $Group5 = "HR"
        $Group6 = "HR-Restricted"
        $Group7 = "Payroll"
        $Group8 = "Remote Desktop Users"
        $Group9 = "Sales-Restricted"
        $Group10 = "Training"
        $Group11 = "Users with 10 Minute Screen Lock"
          }   
        9 {
		$OU = "OU=Facilities,OU=Users,OU=FPSSI,DC=FPSSI,DC=com"
        $department = "Facilities"
        $Group1 = "AzureADSync"
        $Group2 = "Finance-Documentation"
        $Group3 = "FPSSI"
        $Group4 = "FPSSI_VPN"
        $Group5 = "HR"
        $Group6 = "HR-Restricted"
        $Group7 = "Payroll"
        $Group8 = "Remote Desktop Users"
        $Group9 = "Sales-Restricted"
        $Group10 = "Training"
        $Group11 = "Users with 10 Minute Screen Lock"
          }
        10 {
		$OU = "OU=Finance,OU=Users,OU=FPSSI,DC=FPSSI,DC=com"
        $department = "Finance"
        $Group1 = "AzureADSync"
        $Group2 = "Corporate Strategy"
        $Group3 = "FPSSI"
        $Group4 = "FPSSI_VPN"
        $Group5 = "MCKINLEY"
        $Group6 = "Remote Desktop Users"
        $Group7 = "Corporate-Services"
        $Group8 = "CorporateServicesHelpdesk"
          }
        11 {
		$OU = "OU=Fulfillment,OU=Users,OU=FPSSI,DC=FPSSI,DC=com"
        $department = "Fulfillment"
        $Group1 = "AzureADSync"        
        $Group2 = "Customer Support"
        $Group3 = "FPSSI"
        $Group4 = "Fulfillment"
        $Group5 = "Fulfillment - Techs"
        $Group6 = "FULL - Printer Group"
        $Group7 = "HOOD Secondary"
        $Group8 = "Inventory"
        $Group9 = "OPS Secondary Printers"
        $Group10 = "ORODRUIN Primary"
        $Group11 = "Users with 10 Minute Screen Lock"
        $Group12 = "operations-support"
          }
        12 {
		$OU = "OU=IT,OU=Users,OU=FPSSI,DC=FPSSI,DC=com"
        $department = "IT"
        $Group1 = "AzureADSync"
        $Group2 = "IT"
        $Group3 = "fpssiapp001 $ Acronis Remote Users"
        $Group4 = "FPSSI"
        $Group5 = "MCKINLEY"
        $Group6 = "Qlikview - Development"
        $Group7 = "FPSSI_VPN"
        $Group8 = "Users"
        $Group9 = "Administrators"
        $Group10 = "Remote Desktop Users"
        $Group11 = "AzureADSync"
          }
        13 {
		$OU = "OU=Recruiting,OU=Users,OU=FPSSI,DC=FPSSI,DC=com"
        $department = "Recruiting"
        $Group1 = "AzureADSync"
        $Group2 = "Domain Users"
        $Group3 = "Finance-Documentation"
        $Group4 = "FPSSI"
        $Group5 = "FPSSI_VPN"
        $Group6 = "GPSERVER idle timeout disconnect"
        $Group7 = "HR"
        $Group8 = "HR-Restricted"
        $Group9 = "Remote Desktop Users"
        $Group10 = "Sales Restricted"
        $Group11 = "Training"
        $Group12 = "Users with 10 Minute Screen Lock"
          }
        14 {
		$OU = "OU=Sales and Support,OU=Users,OU=FPSSI,DC=FPSSI,DC=com"
        $department = "Sales"
        $Group1 = "AzureADSync"
        $Group2 = "FPSSI"
        $Group3 = "MonteViso"
        $Group4 = "OPS"
        $Group5 = "Remote Desktop Users"
        $Group6 = "Sales"
        $Group7 = "Sales-SSRS"
        $Group8 = "Users with 10 Minute Screen Lock"
        $Group9 = "Wb3 Deployment"
          }
        15 {
		$OU = "OU=Sales and Support,OU=Users,OU=FPSSI,DC=FPSSI,DC=com"
        $department = "Support"
        $Group1 = "AzureADSync"
        $Group2 = "Customer Retention Agents"
        $Group3 = "Customer Retention Specialists"
        $Group4 = "Customer Support"
        $Group5 = "FPSSI"
        $Group6 = "OPS"
        $Group7 = "Remote Desktop Users"
        $Group8 = "Users with 10 Minute Screen Lock"
        $Group9 = "frontpoint_all"
        $Group10 = "operations-support"
          }
       16 {
		$OU = "OU=Sales and Support,OU=Users,OU=FPSSI,DC=FPSSI,DC=com"
        $department = "Retention"
        $Group1 = "AzureADSync"
        $Group2 = "Customer Relations CSS"
        $Group3 = "Customer Support"
        $Group4 = "FPSSI"
        $Group5 = "OPS"
        $Group6 = "Remote Desktop Users"
        $Group7 = "Users with 10 Minute Screen Lock"
          }
        1595 {
        $location = "1595 Spring Hill Rd #110"
          }  
        1593 {
        $location = "1593 Spring Hill Rd"
          }     
		GO {
        FP-NewADUserPreferred
        AddGroups

            Write-Host -fore Green –NoNewLine 'Executing Account Sycn With Azure'
	        foreach ($element in 1..3)
	        {
		    Write-Host –NoNewLine "${element} " -BackgroundColor 'Red' -ForegroundColor 'Yellow'
		    Start-Sleep –Seconds 1
	        }
	        Write-Host ''
            
            Invoke-Command -ComputerName fpvi-azc1.fpssi.com {Start-ADSyncSyncCycle -PolicyType Delta}
            Pause
          }
        H {
        SendMail
          }
          "E" { "Exiting" }
		  default { "You did not select a valid option, please try again" }             
}

	IF (!($result -eq "E"))
	{

	}
}
while (!($result -eq "E"))

}

#=====================================================#
# Function -- Create User
#=====================================================#

Function FP-NewADUser {
New-ADUser `
    -Credential $MyCred `
    -GivenName "$firstname" `
    -Surname "$lastname" `
    -Name "$lastname, $firstname" `
    -DisplayName "$DisplayName" `
    -sAMAccountName "$logon" `
    -UserPrincipalName "$firstname.$lastname@frontpointsecurity.com" `
    -EmailAddress "$firstname.$lastname@frontpointsecurity.com" `
    -OtherAttributes @{'proxyAddresses'="SIP:$firstname.$lastname@frontpointsecurity.com","SMTP:$firstname.$lastname@frontpointsecurity.com","SMTP:$firstname.$lastname@fpssi.onmicrosoft.com","smtp:$logon@fpssi.com"} `
    -Department "$department" `
    -Title "$title" `
    -Description "$title" `
    -Company "Frontpoint Security LLC" `
    -HomePage "www.frontpointsecurity.com" `
    -Path "$OU" `
    -profilePath "\\fpssi.com\mc\profiles\$logon" `
    -Enabled $True `
    -ChangePasswordAtLogon $False `
    -AccountPassword (ConvertTo-SecureString -AsPlainText "Welcome1!" -Force) `
    -OfficePhone 703-776-9100 `
    -Office "$location" `
    -StreetAddress "$location" `
    -City Vienna `
    -State VA `
    -PostalCode 20705 `
    -Country US `

}

#=====================================================#
# Function -- Create User Preferred
#=====================================================#

Function FP-NewADUserPreferred {
New-ADUser `
    -Credential $MyCred `
    -GivenName "$firstname" `
    -Surname "$lastname" `
    -Name "$lastname, $firstname" `
    -DisplayName "$DisplayName" `
    -sAMAccountName "$logon" `
    -UserPrincipalName "$preferred.$lastname@frontpointsecurity.com" `
    -EmailAddress "$preferred.$lastname@frontpointsecurity.com" `
    -OtherAttributes @{'proxyAddresses'="SIP:$preferred.$lastname@frontpointsecurity.com","SMTP:$preferred.$lastname@frontpointsecurity.com","SMTP:$preferred.$lastname@fpssi.onmicrosoft.com","smtp:$firstname.$lastname@frontpointsecurity.com","smtp:$logon@fpssi.com"} `
    -Department "$department" `
    -Title "$title" `
    -Description "$title" `
    -Company "Frontpoint Security LLC" `
    -HomePage "www.frontpointsecurity.com" `
    -Path "$OU" `
    -profilePath "\\fpssi.com\mc\profiles\$logon" `
    -Enabled $True `
    -ChangePasswordAtLogon $False `
    -AccountPassword (ConvertTo-SecureString -AsPlainText "Welcome1!" -Force) `
    -OfficePhone 703-776-9100 `
    -Office $location `
    -StreetAddress "$location" `
    -City Vienna `
    -State VA `
    -PostalCode 20705 `
    -Country US `

}

#=====================================================#
# Function -- Add Groups
#=====================================================#

Function AddGroups
{

        Add-ADGroupMember -Identity $Group1 -Members $logon
        Add-ADGroupMember -Identity $Group2 -Members $logon
        Add-ADGroupMember -Identity $Group3 -Members $logon
        Add-ADGroupMember -Identity $Group4 -Members $logon
        Add-ADGroupMember -Identity $Group5 -Members $logon
        Add-ADGroupMember -Identity $Group6 -Members $logon
        Add-ADGroupMember -Identity $Group7 -Members $logon
        Add-ADGroupMember -Identity $Group8 -Members $logon
        Add-ADGroupMember -Identity $Group9 -Members $logon
        Add-ADGroupMember -Identity $Group10 -Members $logon
        Add-ADGroupMember -Identity $Group11 -Members $logon
        Add-ADGroupMember -Identity $Group12 -Members $logon



}


#=====================================================#
# Function -- Send Mail
#=====================================================#

Function SendMail
{
	Send-MailMessage -To “ben.bone@frontpointsecurity.com” -From "NewUserTool@frontpointsecurity.com" -Subject “$MyName -- Help!” -smtpserver smtprelay.frontpointsecurity.com -Body "$Date == $MyName needs help with the New User Tool" 
}

#============================================================================#
# Menu / Body - This will Create the Menu that will execute your Functions
#============================================================================#

do
{
	cls
	write-host -fore Red `n "==============================================================================================="
		write-host -fore Cyan `n "                                -- New User Creation --"
		write-host -fore Cyan `n "    -- Please ensure that all the below fields are populated before selecting 'GO' --"
		write-host -fore Yellow `n "My Name Is                      = " -NoNewline
        write-host "[" -ForegroundColor Yellow -NoNewline
        write-host "$MyName" -ForegroundColor White -NoNewline
        write-host "]" -ForegroundColor Yellow -NoNewline
		write-host -fore Yellow `n "User First Name                 = " -NoNewline
        write-host "[" -ForegroundColor Yellow -NoNewline
        write-host "$firstname" -ForegroundColor White -NoNewline
        write-host "]" -ForegroundColor Yellow -NoNewline
		write-host -fore Yellow `n "User Preffered Name             = " -NoNewline
        write-host "[" -ForegroundColor Yellow -NoNewline
        write-host "$preferred" -ForegroundColor White -NoNewline
        write-host "]" -ForegroundColor Yellow -NoNewline
        write-host -fore Yellow `n "User Title                      = " -NoNewline
        write-host "[" -ForegroundColor Yellow -NoNewline
        write-host "$title" -ForegroundColor White -NoNewline
		write-host "]" -ForegroundColor Yellow -NoNewline
        write-host -fore Yellow `n "User Last Name                  = " -NoNewline
        write-host "[" -ForegroundColor Yellow -NoNewline
        write-host "$lastname" -ForegroundColor White -NoNewline
		write-host "]" -ForegroundColor Yellow -NoNewline
        write-host -fore Yellow `n "User Logon Name                 = " -NoNewline
        write-host "[" -ForegroundColor Yellow -NoNewline
        write-host "$logon" -ForegroundColor White -NoNewline
		write-host "]" -ForegroundColor Yellow -NoNewline
        write-host -fore Yellow `n "User Department                 = " -NoNewline
        write-host "[" -ForegroundColor Yellow -NoNewline
        write-host "$department" -ForegroundColor White -NoNewline
		write-host "]" -ForegroundColor Yellow -NoNewline
        write-host -fore Yellow `n "User Address                    = " -NoNewline
        write-host "[" -ForegroundColor Yellow -NoNewline
        write-host "$location" -ForegroundColor White -NoNewline
		write-host "]" -ForegroundColor Yellow -NoNewline
	write-host -fore Red `n "==============================================================================================="
	write-host -fore Cyan `n "                                -- Set User Details --"
	write-host -fore Red `n "==============================================================================================="
	write-host -fore Green `t '[1] Normal User Setup'
	write-host -fore Green `t '[2] User with a Preferred Name'
	write-host -fore Red `n "==============================================================================================="
	write-host -fore Cyan `n "                                -- Help, or leave --"
	write-host -fore Red `n "==============================================================================================="
    write-host -fore White `t "[H] Help! This tool isn't working (Submitts Ticket)"
	write-host -fore White `t "[E] Exit Utility"
	write-host -fore Red `n "==============================================================================================="
	$result = read-host
	cls
	switch ($result)
	{
		1 {
        MainMenu
		}
		2 {
        MainMenuPreferred
		}             
}

	IF (!($result -eq "E"))
	{
		Pause
	}
}
while (!($result -eq "E"))

#=================================#
#End Of Script - END - Confused
#=================================#