# Powershell Azure Function Using HMAC Authentication 


Template HTTP Trigger Function 
uses .NET System.Security.Cryptography for HMAC Auth



receiver must replace boiler plate code in azure function and update 
request actions within 'passed authentication code.' note
and add the chosen key into the app settings under name 'SigningKey'

sender must perfom generate hmac locally on the payload and add the output to a header named 'authorization'
if the sender is doing so in powershell then the 'Generate-HMAC' function in this script can be used. 

