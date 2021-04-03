$rgName = 'Contoso-RG'
$hub    = 'Hub'
$spoke1 = 'Spoke1'

Get-AzResource -ResourceGroupName $rgName | Sort-Object ResourceType | Format-Table Name,ResourceType

# Hub-to-Spoke1 Peering
Get-AzVirtualNetworkPeering -VirtualNetworkName $hub -ResourceGroupName $rgName | 
    Format-List Name,PeeringState,AllowVirtualNetworkAccess,AllowForwardedTraffic,AllowGatewayTransit,UseRemoteGateways,RemoteGateways

# Spoke1-to-Hub Peering
Get-AzVirtualNetworkPeering -VirtualNetworkName $spoke1 -ResourceGroupName $rgName | 
    Format-List Name,PeeringState,AllowVirtualNetworkAccess,AllowForwardedTraffic,AllowGatewayTransit,UseRemoteGateways,RemoteGateways


# main.bicep: first time (gwExists = false)  [25 min]
# -->
#     Name                      : Spoke1-to-Hub-Peering
#     PeeringState              : Connected
#     AllowVirtualNetworkAccess : True
#     AllowForwardedTraffic     : True
#     AllowGatewayTransit       : True
#     UseRemoteGateways         : False      <-------------------------------- correct, because there is no gateway
#     RemoteGateways            :
#
# main.bicep: second time (gwExists = true)  [3 min]
# -->
#     Name                      : Spoke1-to-Hub-Peering
#     PeeringState              : Connected
#     AllowVirtualNetworkAccess : True
#     AllowForwardedTraffic     : True
#     AllowGatewayTransit       : True
#     UseRemoteGateways         : True       <------------------------------- correct, because now there is a gateway
#     RemoteGateways            :


# Also:
#   a) 'UseRemoteGateways' wird korrekt gesetzt durch Template (gwExists = true).
#      Und umgekehrt (gwExists = false --> UseRemoteGateways: False)
#      Im Portal wird es aber nicht angezeigt.
#
#   b) 
#
# Kann man nicht die Bedingung dynamisch evaluieren?
# useRemoteGateways: gatewayExists ? true : false
