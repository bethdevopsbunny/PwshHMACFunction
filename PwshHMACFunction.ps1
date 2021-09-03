using namespace System.Net

# Input bindings are passed in via param block.
param($Request, $TriggerMetadata)


## Raw Empty Check
if($null -eq $Request.rawbody){
    
    # return bad request if empty body
    Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
        StatusCode = [HttpStatusCode]::BadRequest
        Body       = "Unable to validate authentication header for messages with empty body"
    })
    
    
}else{
    
    
    
    function Generate-HMAC {
        param (
            $RawBodyPayload,
            $Base64Key
            )
            
            $hmacsha = New-Object System.Security.Cryptography.HMACSHA256
            $hmacsha.key = [Convert]::FromBase64String($Base64Key)
            $signature = $hmacsha.ComputeHash([Text.Encoding]::UTF8.GetBytes($RawBodyPayload))
            $HMACValue = "HMAC " + [Convert]::ToBase64String($signature)
            
            return $HMACValue
            
        }
        
        $GeneratedHMAC  = Generate-HMAC -RawBodyPayload $Request.rawbody -Base64Key $ENV:SigningKey
       
        if ($GeneratedHMAC -eq $Request.headers.authorization){   
            
            
            ## Payload data = $Request.body
            
            
            ###
            ##  passed authentication code. 
            ### 



        # Associate values to output bindings by calling 'Push-OutputBinding'.
        Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
            StatusCode = [HttpStatusCode]::OK
            Body = $ReturnPayload
        })

    }
    else
    {
        # return failed authentication
        Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
            StatusCode = [HttpStatusCode]::Unauthorized
            Body       = "Failed Authentication"
        })

    }

}