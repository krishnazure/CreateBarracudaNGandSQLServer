
Switch-AzureMode -Name AzureServiceManagement 

$SubscriptionName = "Internal Consumption"
$Location = "East US"
$NGIPaddress = "10.0.0.5"
$vnetnametest = "AzureVNET"
$Subnetname = "Frontend"
$ngservicetest= "BNG-MultiNIC"

Select-AzureSubscription -SubscriptionName $SubscriptionName –Current


#Create  a new routetable 
New-AzureRouteTable -Name NGRouteTest -Location $location -Label "Route to NG Firewall"
 
#Routes to Route table 
Get-AzureRouteTable -Name NGRouteTest | Set-AzureRoute -RouteName Default -AddressPrefix 0.0.0.0/0 -NextHopType VirtualAppliance -NextHopIpAddress $NGIPaddress
 
#Bind Routetable to Subnet 
Set-AzureSubnetRouteTable -VirtualNetworkName $vnetnametest -SubnetName $Subnetname -RouteTableName NGRouteTest 
 
#IpForwarding 
get-azurevm -ServiceName $ngservicetest -Name $vnnametest | Set-AzureIPForwarding -Enable
