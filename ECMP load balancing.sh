# basic ecmp
# note that you can specify how much traffic goes to each gateway. 
# for example gw1,gw1,gw2 means 2/3 goes to gw1 and 1/3 to gw2

# This is an example of a 50% / 50% traffic split
/ ip route 
add dst-address=0.0.0.0/0 gateway=10.111.0.1,10.112.0.1 check-gateway=ping 

# Only necessary if you want to connect to the router from the internet. 
/ ip firewall mangle
add chain=input in-interface=wlan1 action=mark-connection new-connection-mark=wlan1_conn
add chain=input in-interface=wlan2 action=mark-connection new-connection-mark=wlan2_conn
add chain=output connection-mark=wlan1_conn action=mark-routing new-routing-mark=to_wlan1     
add chain=output connection-mark=wlan2_conn action=mark-routing new-routing-mark=to_wlan2    

/ ip route
add dst-address=0.0.0.0/0 gateway=10.111.0.1 routing-mark=to_wlan1 
add dst-address=0.0.0.0/0 gateway=10.112.0.1 routing-mark=to_wlan2