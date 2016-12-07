##==========================================================================================================##
##Script Name = Network Load Balancer - Auto-Deployment Utility - Frontpoint Security												
##Author Name = Ben Bone																					
##Author Mail = ben.bone@frontpointsecurity.com																
##Version	  = v3.0 (09/17/2016)																			
##Description = This script is designed to allow the software development Bamboo servers deploy directly to 
##              the API, IWEBAPP & XWEB Clusters. This script is designed to Drainstop, ensure Drainstop is 
##              completed, Copy Configuration files, Start NLB Services and ensure services are opperational 														
##==========================================================================================================##
#=====================================================#
# Global Variables
#=====================================================#
$logDate = Get-Date -format g
$FilePath = ##Global File Path goes Here
$MyCreds = # get-credential ##Or We can specify username/password here (for XWEB Cluster)
$MyName = [Environment]::UserName
#=====================================================#

#=====================================================#
# NLB Cluster Management -- Individual Cluster Menus
#=====================================================#

#=======================================================================================================================================#
# Function -- XWEB Cluster Management Menu
#=======================================================================================================================================#
Function XWEBMenu {
do {
	write-host -fore Red `n "==============================================================================================="
		write-host -fore Cyan `n "                        -- Checking NLB Status, Please Wait --"
	write-host -fore Red `n "==============================================================================================="
        $XWEB2nodeStatus = Get-NlbClusterNode -hostname "FPHQ-XWEB2" -NodeName "FPHQ-XWEB2" 
        $XWEB2status = $XWEB2nodeStatus[0].State.ToString()
        $XWEB2status1 = $XWEB2nodeStatus[1].State.ToString()
        $XWEB2status2 = $XWEB2nodeStatus[2].State.ToString()
        $XWEB3nodeStatus = Get-NlbClusterNode -hostname "FPHQ-XWEB3" -NodeName "FPHQ-XWEB3" 
        $XWEB3status = $XWEB3nodeStatus[0].State.ToString()
        $XWEB3status1 = $XWEB3nodeStatus[1].State.ToString()
        $XWEB3status2 = $XWEB3nodeStatus[2].State.ToString()
        $IPs = Get-NlbClusterVip -HostName "fphq-xweb3" | Select-Object -ExpandProperty IPAddress
	cls
	write-host -fore Red `n "==============================================================================================="
		write-host -fore Cyan `n "                                -- NLB Check Status --"
		write-host -fore Cyan `n "                -- NLB Management Tool -- Cluster FPHQ-XWEB2/FPHQ-XWEB3 --"
	write-host -fore Red `n "==============================================================================================="
		write-host -fore Yellow `n "NLB Node                                      = " -NoNewline
        write-host "[" -ForegroundColor Yellow -NoNewline
        write-host "FPHQ-XWEB2" -ForegroundColor White -NoNewline
        write-host "]" -ForegroundColor Yellow -NoNewline
		write-host -fore Yellow `n "activate.frontpoint.com                       = " -NoNewline
        write-host "[" -ForegroundColor Yellow -NoNewline
        write-host "$XWEB2Status" -ForegroundColor White -NoNewline
        write-host "]" -ForegroundColor Yellow -NoNewline
		write-host -fore Yellow `n "janus.frontpoint.com                          = " -NoNewline
        write-host "[" -ForegroundColor Yellow -NoNewline
        write-host "$XWEB2Status1" -ForegroundColor White -NoNewline
        write-host "]" -ForegroundColor Yellow -NoNewline
        write-host -fore Yellow `n "web-order.frontpoint.com                      = " -NoNewline
        write-host "[" -ForegroundColor Yellow -NoNewline
        write-host "$XWEB2Status2" -ForegroundColor White -NoNewline
		write-host "]" -ForegroundColor Yellow -NoNewline
	write-host -fore Red `n "==============================================================================================="
		write-host -fore Yellow `n "NLB Node                                      = " -NoNewline
        write-host "[" -ForegroundColor Yellow -NoNewline
        write-host "FPHQ-XWEB3" -ForegroundColor White -NoNewline
        write-host "]" -ForegroundColor Yellow -NoNewline
		write-host -fore Yellow `n "activate.frontpoint.com                       = " -NoNewline
        write-host "[" -ForegroundColor Yellow -NoNewline
        write-host "$XWEB3Status" -ForegroundColor White -NoNewline
        write-host "]" -ForegroundColor Yellow -NoNewline
		write-host -fore Yellow `n "janus.frontpoint.com                          = " -NoNewline
        write-host "[" -ForegroundColor Yellow -NoNewline
        write-host "$XWEB3Status1" -ForegroundColor White -NoNewline
        write-host "]" -ForegroundColor Yellow -NoNewline
        write-host -fore Yellow `n "web-order.frontpoint.com                      = " -NoNewline
        write-host "[" -ForegroundColor Yellow -NoNewline
        write-host "$XWEB3Status2" -ForegroundColor White -NoNewline
		write-host "]" -ForegroundColor Yellow -NoNewline
	write-host -fore Red `n "==============================================================================================="
		write-host -fore White `n " Configured Cluster IP Addresses" -NoNewline
        foreach ($i in $IPs) {
        write-host -fore Yellow `n "Cluster IP        = " -NoNewline
        write-host "[" -ForegroundColor Yellow -NoNewline
        write-host "$i" -ForegroundColor White -NoNewline
        write-host "]" -ForegroundColor Yellow -NoNewline
        }
	write-host -fore Red `n "==============================================================================================="
	write-host -fore Cyan `n "                                -- Manage API Cluster --"
	write-host -fore Red `n "==============================================================================================="
	write-host -fore White `t  '[Please Select an option bellow]'
    write-host -fore Green `t  '[1] Drainstop FPHQ-XWEB2'
	write-host -fore Green `t  '[2] Drainstop FPHQ-XWEB3'
	write-host -fore Green `t  '[3] Start NLB Services on FPHQ-XWEB2'
	write-host -fore Green `t  '[4] Start NLB Services on FPHQ-XWEB3'
	write-host -fore Green `t  '[5] Re-Check Cluster Status'
	write-host -fore Red `n "==============================================================================================="
	write-host -fore Cyan `n "                                -- Help, or leave --"
	write-host -fore Red `n "==============================================================================================="
    write-host -fore White `t "[H] Help! This tool isn't working (Submitts Ticket)"
	write-host -fore White `t "[Q] Quit to Main Menu"
	write-host -fore Red `n "==============================================================================================="
	$result = read-host
	cls
	switch ($result)
	{
		1 {
        $NodeName = "FPHQ-XWEB2"
        $DoubleCheck = "FPHQ-XWEB3"
        $expected = "stopped"
        $doublecheckexpected = "Converged"
        DoubleCheckXWEBHosts
        Stop-NlbClusterNode -HostName $NodeName -InterfaceName "NLB" -Drain
        Stop-NlbClusterNode -HostName $NodeName -InterfaceName "NLB2" -Drain
        Stop-NlbClusterNode -HostName $NodeName -InterfaceName "NLB3" -Drain
        CheckHostStatus
		}
        2 {
        $NodeName = "FPHQ-XWEB3"
        $DoubleCheck = "FPHQ-XWEB2"
        $expected = "stopped"
        $doublecheckexpected = "Converged"
        DoubleCheckXWEBHosts
        Stop-NlbClusterNode -HostName $NodeName -InterfaceName "NLB" -Drain
        Stop-NlbClusterNode -HostName $NodeName -InterfaceName "NLB2" -Drain
        Stop-NlbClusterNode -HostName $NodeName -InterfaceName "NLB3" -Drain
        CheckHostStatus
		} 
        3 {
        $NodeName = "FPHQ-XWEB2"
        StartHosts
        $expected = "Converged"
        CheckHostXWEBStatus
		}
        4 {
        $NodeName = "FPHQ-XWEB3"
        StartHosts
        $expected = "Converged"
        CheckHostXWEBStatus
		}
        5 {
        $XWEB2nodeStatus = Get-NlbClusterNode -hostname "FPHQ-XWEB2" -NodeName "FPHQ-XWEB2" 
        $XWEB2status = $XWEB2nodeStatus[0].State.ToString()
        $XWEB2status1 = $XWEB2nodeStatus[1].State.ToString()
        $XWEB2status2 = $XWEB2nodeStatus[2].State.ToString()
        $XWEB3nodeStatus = Get-NlbClusterNode -hostname "FPHQ-XWEB3" -NodeName "FPHQ-XWEB3" 
        $XWEB3status = $XWEB3nodeStatus[0].State.ToString()
        $XWEB3status1 = $XWEB3nodeStatus[1].State.ToString()
        $XWEB3status2 = $XWEB3nodeStatus[2].State.ToString()
        }
        Q {
        Return
        }              
}

	IF (!($result -eq "E"))
	{
    Pause
	}
}
while (!($result -eq "E"))

}

#=======================================================================================================================================#

#=======================================================================================================================================#
# Function -- API Cluster Management Menu
#=======================================================================================================================================#

Function APIMenu {
do {
	write-host -fore Red `n "==============================================================================================="
		write-host -fore Cyan `n "                        -- Checking NLB Status, Please Wait --"
	write-host -fore Red `n "==============================================================================================="
        $API2nodeStatus = Get-NlbClusterNode -hostname "FPVI-API2" -NodeName "FPVI-API2" 
        $API2status = $API2nodeStatus[0].State.ToString()
        $API2status1 = $API2nodeStatus[1].State.ToString()
        $API2status2 = $API2nodeStatus[2].State.ToString()
        $API2status3 = $API2nodeStatus[3].State.ToString()
        $API3nodeStatus = Get-NlbClusterNode -hostname "FPVI-API3" -NodeName "FPVI-API3" 
        $API3status = $API3nodeStatus[0].State.ToString()
        $API3status1 = $API3nodeStatus[1].State.ToString()
        $API3status2 = $API3nodeStatus[2].State.ToString()
        $API3status3 = $API3nodeStatus[3].State.ToString()
        $IPs = Get-NlbClusterVip -HostName "fphq-API3" | Select-Object -ExpandProperty IPAddress

	cls
	write-host -fore Red `n "==============================================================================================="
		write-host -fore Cyan `n "                                -- NLB Check Status --"
		write-host -fore Cyan `n "                -- NLB Management Tool -- Cluster FPHQ-API2/FPHQ-API3 --"
	write-host -fore Red `n "==============================================================================================="
		write-host -fore Yellow `n "NLB Node                               = " -NoNewline
        write-host "[" -ForegroundColor Yellow -NoNewline
        write-host "FPHQ-API2" -ForegroundColor White -NoNewline
        write-host "]" -ForegroundColor Yellow -NoNewline
		write-host -fore Yellow `n "webapi.fpssi.com                       = " -NoNewline
        write-host "[" -ForegroundColor Yellow -NoNewline
        write-host "$API2Status" -ForegroundColor White -NoNewline
        write-host "]" -ForegroundColor Yellow -NoNewline
		write-host -fore Yellow `n "reporting.fpssi.com                    = " -NoNewline
        write-host "[" -ForegroundColor Yellow -NoNewline
        write-host "$API2Status1" -ForegroundColor White -NoNewline
        write-host "]" -ForegroundColor Yellow -NoNewline
        write-host -fore Yellow `n "webauth.fpssi.com                      = " -NoNewline
        write-host "[" -ForegroundColor Yellow -NoNewline
        write-host "$API2Status2" -ForegroundColor White -NoNewline
		write-host "]" -ForegroundColor Yellow -NoNewline
        write-host -fore Yellow `n "identity.fpssi.com                     = " -NoNewline
        write-host "[" -ForegroundColor Yellow -NoNewline
        write-host "$API2Status3" -ForegroundColor White -NoNewline
		write-host "]" -ForegroundColor Yellow -NoNewline
	write-host -fore Red `n "==============================================================================================="
		write-host -fore Yellow `n "NLB Node                               = " -NoNewline
        write-host "[" -ForegroundColor Yellow -NoNewline
        write-host "FPHQ-API3" -ForegroundColor White -NoNewline
        write-host "]" -ForegroundColor Yellow -NoNewline
		write-host -fore Yellow `n "webapi.fpssi.com                       = " -NoNewline
        write-host "[" -ForegroundColor Yellow -NoNewline
        write-host "$API3Status" -ForegroundColor White -NoNewline
        write-host "]" -ForegroundColor Yellow -NoNewline
		write-host -fore Yellow `n "reporting.fpssi.com                    = " -NoNewline
        write-host "[" -ForegroundColor Yellow -NoNewline
        write-host "$API3Status1" -ForegroundColor White -NoNewline
        write-host "]" -ForegroundColor Yellow -NoNewline
        write-host -fore Yellow `n "webauth.fpssi.com                      = " -NoNewline
        write-host "[" -ForegroundColor Yellow -NoNewline
        write-host "$API3Status2" -ForegroundColor White -NoNewline
		write-host "]" -ForegroundColor Yellow -NoNewline
        write-host -fore Yellow `n "identity.fpssi.com                     = " -NoNewline
        write-host "[" -ForegroundColor Yellow -NoNewline
        write-host "$API3Status3" -ForegroundColor White -NoNewline
		write-host "]" -ForegroundColor Yellow -NoNewline
	write-host -fore Red `n "==============================================================================================="
		write-host -fore White `n " Configured Cluster IP Addresses" -NoNewline
        foreach ($i in $IPs) {
        write-host -fore Yellow `n "Cluster IP        = " -NoNewline
        write-host "[" -ForegroundColor Yellow -NoNewline
        write-host "$i" -ForegroundColor White -NoNewline
        write-host "]" -ForegroundColor Yellow -NoNewline
        }
	write-host -fore Red `n "==============================================================================================="
	write-host -fore Cyan `n "                                -- Manage API Cluster --"
	write-host -fore Red `n "==============================================================================================="
	write-host -fore White `t  '[Please Select an option bellow]'
    write-host -fore Green `t  '[1] Drainstop FPHQ-API2'
	write-host -fore Green `t  '[2] Drainstop FPHQ-API3'
	write-host -fore Green `t  '[3] Start NLB Services on FPHQ-API2'
	write-host -fore Green `t  '[4] Start NLB Services on FPHQ-API3'
	write-host -fore Green `t  '[5] Re-Check Cluster Status'
	write-host -fore Red `n "==============================================================================================="
	write-host -fore Cyan `n "                                -- Help, or leave --"
	write-host -fore Red `n "==============================================================================================="
    write-host -fore White `t "[H] Help! This tool isn't working (Submitts Ticket)"
	write-host -fore White `t "[Q] Quit to Main Menu"
	write-host -fore Red `n "==============================================================================================="
	$result = read-host
	cls
	switch ($result)
	{
		1 {
        $NodeName = "FPHQ-API2"
        $DoubleCheck = "FPHQ-API3"
        $expected = "stopped"
        $doublecheckexpected = "Converged"
        DoubleCheckAPIHosts
        Stop-NlbClusterNode -HostName $NodeName -InterfaceName "NLB NIC" -Drain
        Stop-NlbClusterNode -HostName $NodeName -InterfaceName "NLB2" -Drain
        Stop-NlbClusterNode -HostName $NodeName -InterfaceName "NLB3" -Drain
        Stop-NlbClusterNode -HostName $NodeName -InterfaceName "NLB4" -Drain
        CheckHostStatus
		}
        2 {
        $NodeName = "FPVI-API3"
        $DoubleCheck = "FPVI-API2"
        $expected = "stopped"
        $doublecheckexpected = "Converged"
        DoubleCheckAPIHosts
        Stop-NlbClusterNode -HostName $NodeName -InterfaceName "NLB NIC" -Drain
        Stop-NlbClusterNode -HostName $NodeName -InterfaceName "NLB2" -Drain
        Stop-NlbClusterNode -HostName $NodeName -InterfaceName "NLB3" -Drain
        Stop-NlbClusterNode -HostName $NodeName -InterfaceName "NLB4" -Drain
        CheckHostStatus
		} 
        3 {
        $NodeName = "FPHQ-API2"
        StartHosts
        $expected = "Converged"
        CheckHostAPIStatus
		}
        4 {
        $NodeName = "FPHQ-API3"
        StartHosts
        $expected = "Converged"
        CheckHostAPIStatus
		}
        5 {
        $API2nodeStatus = Get-NlbClusterNode -hostname "FPHQ-API2" -NodeName "FPHQ-API2" 
        $API2status = $API2nodeStatus[0].State.ToString()
        $API2status1 = $API2nodeStatus[1].State.ToString()
        $API2status2 = $API2nodeStatus[2].State.ToString()
        $API2status3 = $API2nodeStatus[3].State.ToString()
        $API3nodeStatus = Get-NlbClusterNode -hostname "FPHQ-API3" -NodeName "FPHQ-API3" 
        $API3status = $API3nodeStatus[0].State.ToString()
        $API3status1 = $API3nodeStatus[1].State.ToString()
        $API3status2 = $API3nodeStatus[2].State.ToString()
        $API3status3 = $API3nodeStatus[3].State.ToString()
        }
        Q {
        Return
        }              
}

	IF (!($result -eq "E"))
	{
    Pause
	}
}
while (!($result -eq "E"))

}
#=======================================================================================================================================#

#=============================================================================================#
# Function StartHost - This function will Drain all nodes on $NodeName
#=============================================================================================#
Function StartHosts {
Write-Host -fore Yellow –NoNewLine "Starting NLB Services on" $NodeName "...."
	foreach ($element in 1..3)
	{
		Write-Host –NoNewLine "${element} " -BackgroundColor 'Green' -ForegroundColor 'Black'
		Start-Sleep –Seconds 1
	}
	Write-Host ''
start-nlbclusternode -HostName $NodeNAME

}
#=============================================================================================#

#=============================================================================================#
# Function DrainHost - This function will Drain all nodes on $NodeName
#=============================================================================================#
Function DrainHosts {
Write-Host -fore Yellow –NoNewLine "Drainstop on" $NodeName "in progress...."
	foreach ($element in 1..3)
	{
		Write-Host –NoNewLine "${element} " -BackgroundColor 'Green' -ForegroundColor 'Black'
		Start-Sleep –Seconds 1
	}
	Write-Host ''
stop-nlbclusternode -HostName $NodeNAME -Drain
}
#=============================================================================================#

#=============================================================================================#
# Function CheckHostStatusDrain - This function will check to ensure that the host is drained
#=============================================================================================#
Function CheckHostAPIStatus {

do {
cls
    $nodeStatus = Get-NlbClusterNode -hostname "$NodeName" -NodeName "$NodeName" 
    $status = $nodeStatus[0].State.ToString()
    $status1 = $nodeStatus[1].State.ToString()
    $status2 = $nodeStatus[2].State.ToString()
    $status3 = $nodeStatus[3].State.ToString()
    $flag = 1
if ($status -match $expected -and $status1 -match $expected -and $status2 -match $expected -and $status3 -match $expected)
{
Write-Host -fore Yellow –NoNewLine "Verfifying that the cluster $NodeName is $expected.... "
	foreach ($element in 1..3)
	{
		Write-Host –NoNewLine "${element} " -BackgroundColor 'Green' -ForegroundColor 'Black'
		Start-Sleep –Seconds 1
	}
	Write-Host ''
	write-host -fore Red `n "===================================="
	write-host -fore Cyan `n "$NodeName is $expected... "
	write-host -fore Red `n "===================================="
Start-Sleep -Seconds 5
break
}
else {
	write-host -fore Red `n "===================================="
	write-host -fore Cyan `n "$NodeName IS NOT $expected... "
	write-host -fore Red `n "===================================="
$flag = $flag + 1
}
if ($flag -igt 1) {
Write-Host -fore Yellow –NoNewLine "$NodeName is still draining, please wait! "
	foreach ($element in 1..3)
	{
		Write-Host –NoNewLine "${element} " -BackgroundColor 'Green' -ForegroundColor 'Black'
		Start-Sleep –Seconds 1
	}
	Write-Host ''
Start-Sleep -Seconds 5
}

$response = "Y"
 }
while ($response -eq "Y")
}
#=============================================================================================#

#=============================================================================================#
# Function CheckHostStatusDrain - This function will check to ensure that the host is drained
#=============================================================================================#
Function CheckHostXWEBStatus {

do {
cls
    $nodeStatus = Get-NlbClusterNode -hostname "$NodeName" -NodeName "$NodeName" 
    $status = $nodeStatus[0].State.ToString()
    $status1 = $nodeStatus[1].State.ToString()
    $status2 = $nodeStatus[2].State.ToString()
    $flag = 1
if ($status -match $expected -and $status1 -match $expected -and $status2 -match $expected)
{
Write-Host -fore Yellow –NoNewLine "Verfifying that the cluster $NodeName is $expected.... "
	foreach ($element in 1..3)
	{
		Write-Host –NoNewLine "${element} " -BackgroundColor 'Green' -ForegroundColor 'Black'
		Start-Sleep –Seconds 1
	}
	Write-Host ''
	write-host -fore Red `n "===================================="
	write-host -fore Cyan `n "$NodeName is $expected... "
	write-host -fore Red `n "===================================="
Start-Sleep -Seconds 5
break
}
else {
	write-host -fore Red `n "===================================="
	write-host -fore Cyan `n "$NodeName IS NOT $expected... "
	write-host -fore Red `n "===================================="
$flag = $flag + 1
}
if ($flag -igt 1) {
Write-Host -fore Yellow –NoNewLine "$NodeName is still draining, please wait! "
	foreach ($element in 1..3)
	{
		Write-Host –NoNewLine "${element} " -BackgroundColor 'Green' -ForegroundColor 'Black'
		Start-Sleep –Seconds 1
	}
	Write-Host ''
Start-Sleep -Seconds 5
}

$response = "Y"
 }
while ($response -eq "Y")
}
#=============================================================================================#

#=============================================================================================#
# Function CheckHostStatusDrain - This function will doublecheck partner hosts for services
#=============================================================================================#
Function DoubleCheckXWEBHosts {

do {
cls
	write-host -fore Red `n "==============================================================================================="
		write-host -fore Cyan `n "           -- Making Sure $DoubleCheck is Good Before Drainstop on $NodeName! --"
	write-host -fore Red `n "==============================================================================================="
start-sleep -seconds 5
    $nodeStatus = Get-NlbClusterNode -hostname "$DoubleCheck" -NodeName "$DoubleCheck" 
    $status = $nodeStatus[0].State.ToString()
    $status1 = $nodeStatus[1].State.ToString()
    $status2 = $nodeStatus[2].State.ToString()
    $flag = 1
if ($status -match $doublecheckexpected -and $status1 -match $doublecheckexpected -and $status2 -match $doublecheckexpected)
{
Write-Host -fore Yellow –NoNewLine "Verfifying that the cluster node $DoubleCheck is Converged before Draining $NodeName.... "
	foreach ($element in 1..3)
	{
		Write-Host –NoNewLine "${element} " -BackgroundColor 'Green' -ForegroundColor 'Black'
		Start-Sleep –Seconds 1
	}
	Write-Host ''
	write-host -fore Red `n "================================================================"
    write-host -fore Cyan `n"$DoubleCheck Host is Converged, Okay to Drainstop $NodeName" 
	write-host -fore Red `n "================================================================"

Pause
break
}
else {
$flag = $flag + 1
}
if ($flag -igt 1) {
	write-host -fore Red `n "====================================================================================================================="
    Write-Host -fore Cyan `n " Please Ensure $DoubleCheck Host is CONVERGED Before trying to Drainstop $NodeName -- Exiting, please try again! "
   	write-host -fore Red `n "====================================================================================================================="

Pause
Exit
}

$response = "N"
 }
while ($response -eq "Y")
}
#=============================================================================================#

#=============================================================================================#
# Function CheckHostStatusDrain - This function will doublecheck partner hosts for services
#=============================================================================================#
Function DoubleCheckAPIHosts {

do {
cls
	write-host -fore Red `n "==============================================================================================="
		write-host -fore Cyan `n "           -- Making Sure $DoubleCheck is Good Before Drainstop on $NodeName! --"
	write-host -fore Red `n "==============================================================================================="
start-sleep -seconds 5
    $nodeStatus = Get-NlbClusterNode -hostname "$DoubleCheck" -NodeName "$DoubleCheck" 
    $status = $nodeStatus[0].State.ToString()
    $status1 = $nodeStatus[1].State.ToString()
    $status2 = $nodeStatus[2].State.ToString()
    $status3 = $nodeStatus[3].State.ToString()
    $flag = 1
if ($status -match $doublecheckexpected -and $status1 -match $doublecheckexpected -and $status2 -match $doublecheckexpected -and $status3 -match $doublecheckexpected)
{
Write-Host -fore Yellow –NoNewLine "Verfifying that the cluster node $DoubleCheck is Converged before Draining $NodeName.... "
	foreach ($element in 1..3)
	{
		Write-Host –NoNewLine "${element} " -BackgroundColor 'Green' -ForegroundColor 'Black'
		Start-Sleep –Seconds 1
	}
	Write-Host ''
	write-host -fore Red `n "================================================================"
    write-host -fore Cyan `n"$DoubleCheck Host is Converged, Okay to Drainstop $NodeName" 
	write-host -fore Red `n "================================================================"

Pause
break
}
else {
$flag = $flag + 1
}
if ($flag -igt 1) {
	write-host -fore Red `n "====================================================================================================================="
    Write-Host -fore Cyan `n " Please Ensure $DoubleCheck Host is CONVERGED Before trying to Drainstop $NodeName -- Exiting, please try again! "
   	write-host -fore Red `n "====================================================================================================================="

Pause
Exit
}

$response = "N"
 }
while ($response -eq "Y")
}
#=============================================================================================#


#=====================================================#
# Main Menu -- Body
#=====================================================#

do {
	cls
	write-host -fore Red `n "==============================================================================================="
		write-host -fore Cyan `n "                                -- NLB Check Status --"
		write-host -fore Cyan `n "                -- NLB Management Tool -- Cluster Legend --"
	write-host -fore Red `n "==============================================================================================="
		write-host -fore Yellow `n "NLB Node Group                  = " -NoNewline
        write-host "[" -ForegroundColor Yellow -NoNewline
        write-host "FPHQ-API2/FPHQ-API3" -ForegroundColor White -NoNewline
        write-host "]" -ForegroundColor Yellow -NoNewline
		write-host -fore Yellow `n "Cluster                           -- " -NoNewline
        write-host "[" -ForegroundColor Yellow -NoNewline
        write-host "webapi.fpssi.com" -ForegroundColor White -NoNewline
        write-host "]" -ForegroundColor Yellow -NoNewline
		write-host -fore Yellow `n "Cluster VIP                       -- " -NoNewline
        write-host "[" -ForegroundColor Yellow -NoNewline
        write-host "172.18.40.79" -ForegroundColor White -NoNewline
        write-host "]" -ForegroundColor Yellow -NoNewline
        write-host -fore Yellow `n "Cluster                           -- " -NoNewline
        write-host "[" -ForegroundColor Yellow -NoNewline
        write-host "reporting.fpssi.com" -ForegroundColor White -NoNewline
		write-host "]" -ForegroundColor Yellow -NoNewline
        write-host -fore Yellow `n "Cluster VIP                       -- " -NoNewline
        write-host "[" -ForegroundColor Yellow -NoNewline
        write-host "172.18.40.94" -ForegroundColor White -NoNewline
		write-host "]" -ForegroundColor Yellow -NoNewline
		write-host -fore Yellow `n "Cluster                           -- " -NoNewline
        write-host "[" -ForegroundColor Yellow -NoNewline
        write-host "webauth.fpssi.com" -ForegroundColor White -NoNewline
        write-host "]" -ForegroundColor Yellow -NoNewline
		write-host -fore Yellow `n "Cluster VIP                       -- " -NoNewline
        write-host "[" -ForegroundColor Yellow -NoNewline
        write-host "172.18.40.84" -ForegroundColor White -NoNewline
        write-host "]" -ForegroundColor Yellow -NoNewline
        write-host -fore Yellow `n "Cluster                           -- " -NoNewline
        write-host "[" -ForegroundColor Yellow -NoNewline
        write-host "identity.fpssi.com" -ForegroundColor White -NoNewline
		write-host "]" -ForegroundColor Yellow -NoNewline
        write-host -fore Yellow `n "Cluster VIP                       -- " -NoNewline
        write-host "[" -ForegroundColor Yellow -NoNewline
        write-host "172.18.40.89" -ForegroundColor White -NoNewline
		write-host "]" -ForegroundColor Yellow -NoNewline
	write-host -fore Red `n "==============================================================================================="
		write-host -fore Yellow `n "NLB Node Group                  = " -NoNewline
        write-host "[" -ForegroundColor Yellow -NoNewline
        write-host "FPHQ-IWEBAPP2/FPHQ-IWEBAPP3" -ForegroundColor White -NoNewline
        write-host "]" -ForegroundColor Yellow -NoNewline
		write-host -fore Yellow `n "Cluster                           -- " -NoNewline
        write-host "[" -ForegroundColor Yellow -NoNewline
        write-host "wb3.fpssi.com" -ForegroundColor White -NoNewline
        write-host "]" -ForegroundColor Yellow -NoNewline
		write-host -fore Yellow `n "Cluster VIP                       -- " -NoNewline
        write-host "[" -ForegroundColor Yellow -NoNewline
        write-host "172.16.40.37" -ForegroundColor White -NoNewline
        write-host "]" -ForegroundColor Yellow -NoNewline
     write-host -fore Red `n "==============================================================================================="
		write-host -fore Yellow `n "NLB Node Group                  = " -NoNewline
        write-host "[" -ForegroundColor Yellow -NoNewline
        write-host "FPHQ-XWEB2/FPHQ-XWEB33" -ForegroundColor White -NoNewline
        write-host "]" -ForegroundColor Yellow -NoNewline
		write-host -fore Yellow `n "Cluster                           -- " -NoNewline
        write-host "[" -ForegroundColor Yellow -NoNewline
        write-host "activate.frontpoint.com" -ForegroundColor White -NoNewline
        write-host "]" -ForegroundColor Yellow -NoNewline
		write-host -fore Yellow `n "Cluster VIP                       -- " -NoNewline
        write-host "[" -ForegroundColor Yellow -NoNewline
        write-host "172.18.30.119" -ForegroundColor White -NoNewline
        write-host "]" -ForegroundColor Yellow -NoNewline
        write-host -fore Yellow `n "Cluster                           -- " -NoNewline
        write-host "[" -ForegroundColor Yellow -NoNewline
        write-host "janus.frontpoint.com" -ForegroundColor White -NoNewline
		write-host "]" -ForegroundColor Yellow -NoNewline
        write-host -fore Yellow `n "Cluster VIP                       -- " -NoNewline
        write-host "[" -ForegroundColor Yellow -NoNewline
        write-host "172.16.30.214" -ForegroundColor White -NoNewline
		write-host "]" -ForegroundColor Yellow -NoNewline
		write-host -fore Yellow `n "Cluster                           -- " -NoNewline
        write-host "[" -ForegroundColor Yellow -NoNewline
        write-host "web-order.frontpoint.com" -ForegroundColor White -NoNewline
        write-host "]" -ForegroundColor Yellow -NoNewline
		write-host -fore Yellow `n "Cluster VIP                       -- " -NoNewline
        write-host "[" -ForegroundColor Yellow -NoNewline
        write-host "172.16.30.118" -ForegroundColor White -NoNewline
        write-host "]" -ForegroundColor Yellow -NoNewline
        write-host -fore Yellow `n "Cluster                           -- " -NoNewline
	write-host -fore Red `n "==============================================================================================="
	write-host -fore Red `n "==============================================================================================="
	write-host -fore Cyan `n "                                -- Select NLB Cluster --"
	write-host -fore Red `n "==============================================================================================="
	write-host -fore White `t  '[Please Select an option bellow]'
	write-host -fore Green `t  '[1] FPHQ-XWEB2/FPHQ-XWEB3 Cluster'
	write-host -fore Green `t  '[2] FPHQ-API2/FPHQ-API3 Cluster'
	write-host -fore Green `t  '[3] FPHQ-IWEBAPP2/FPHQ-IWEBAPP3 Cluster'
	write-host -fore Red `n "==============================================================================================="
	write-host -fore Cyan `n "                                -- Help, or leave --"
	write-host -fore Red `n "==============================================================================================="
    write-host -fore White `t "[H] Help! This tool isn't working (Submitts Ticket)"
	write-host -fore White `t "[Q] Quit Utility"
	write-host -fore Red `n "==============================================================================================="
	$result = read-host
	cls
	switch ($result)
	{
		1 {
        XWEBMenu
		}
		2 {
        APIMenu
		}
        3 {
        IWEBAPPMenu
		} 
        Q {
        Exit
        }            
}

	IF (!($result -eq "E"))
	{
		Pause
	}
}
while (!($result -eq "E"))

#=================================#
#End Of Script
#=================================#