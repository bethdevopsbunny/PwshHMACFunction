Azure Function in Powershell with HMAC Authentication 
______________

Template HTTP Trigger Function 
using .NET System.Security.Cryptography for HMAC Auth



reciver must replace boiler plate code in azure function and update 
request actions within 'passed authentication code.' note
and add the chosen key into the app settings under name 'SigningKey'

sender must perfom generate hmac locally on the payload and add the output to a header named 'authorization'
if the sender is doing so in powershell then the 'Generate-HMAC' function in this script can be used. 
