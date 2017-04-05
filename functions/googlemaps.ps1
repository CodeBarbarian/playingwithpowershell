<#
.SYNOPSIS
    This script uses the Google Maps API to convert an address into cordinates you can use for spatial analysis or mapping

.DESCRIPTION
    See synopsis. This also shows how to handle Json in powershell to some degree.
    
    To get an API key to use google maps, go to: https://developers.google.com/maps/documentation/geocoding/geocoding-strategies 
    Make sure you are logged into your account, and hit "GET A KEY"

    Should be able to query the API 2500 times before you need a license.

.EXAMPLE
    Get-Cordinates -Address "Slottsplassen 1, 0010 Oslo"

#>


# =================== Script Config =================== #

# -------------Script dependant variables-------------- #
# Put your API Key here
$Api_Key = ''

<#
.SYNOPSIS
    Get-Cordinates

.DESCRIPTION
    Function to retrieve the cordinates of a given address, and displays it as a google.maps.com link

.EXAMPLE
    Get-Cordinates -Address "Slottsplassen 1, 0010 Oslo"

.PARAMETER Address
    The address location for the the place you are searching

#>
function Get-Cordinates {
    param (
        [string]$Address
    )

    # The API URL (Where we will use a HTTP GET to retrieve the JSON data)
    $Api_Url = "https://maps.googleapis.com/maps/api/geocode/json?address=$Address&key=$Api_Key"

    # Invoking a WebRequest with the HTTP Get method on the API URL above
    $Response = Invoke-WebRequest -Uri $Api_Url -Method Get

    # Convert it to objects
    $Data = ConvertFrom-Json $Response

    # Set the cordinates(Latitude And Longitude) from the data we collected
    $Latitude  = $Data.results.geometry.location.lat -replace ',','.'
    $Longitude = $Data.results.geometry.location.lng -replace ',','.'

    # Display the URL for google maps
    $Cordinates = ('Direct link: https://www.google.no/maps/place/'+$Latitude.tostring()+','+$Longitude.tostring())
    Write-Output $Cordinates

}

# Run Get-Cordinates function
Get-Cordinates -Address 'Slottsplassen 1, 0010 Oslo'

