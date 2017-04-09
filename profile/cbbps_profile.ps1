# Original script by: Prateek Singh - https://geekeefy.wordpress.com
# Modified by: Morten Haugstad - https://codebarbarian.priv.no
# Function to Get Custom Directory path

        Write-Host '
   ______          __     ____             __               _           
  / ____/___  ____/ /__  / __ )____ ______/ /_  ____ ______(_)___ _____ 
 / /   / __ \/ __  / _ \/ __  / __ `/ ___/ __ \/ __ `/ ___/ / __ `/ __ \
/ /___/ /_/ / /_/ /  __/ /_/ / /_/ / /  / /_/ / /_/ / /  / / /_/ / / / /
\____/\____/\__,_/\___/_____/\__,_/_/  /_.___/\__,_/_/  /_/\__,_/_/ /_/ 

    Powershell is uniqe, because if all else fail - use force. 
    Remember to clean up after yourself, use Clean-Slate   
'

# Added a function to clean up memory in a powershell session,
Function Clean-Slate {
    Write-Host "Cleaning up your mess...  " -ForegroundColor Red
    Get-Variable | Where-Object { $startupVariables -notcontains $_.Name } | 
    ForEach-Object {
        try { 
            Remove-Variable -Name "$($_.Name)" -Force -Scope "global" -ErrorAction SilentlyContinue -WarningAction SilentlyContinue | Write-Host $_.Name -ForegroundColor Yellow
        } catch { 

        } finally {
            
        }
    }

    Write-Host "Finished!" -ForegroundColor Green
}

Function Get-CustomDirectory
{
    [CmdletBinding()]
    [Alias("CDir")]
    [OutputType([String])]
    Param
    (
        [Parameter(ValueFromPipeline=$true,Position=0)]
        $Path = $PWD.Path
    )
    
    Begin
    {
        #Custom directories as a HashTable
        $CustomDirectories = @{

            $env:TEMP                       = 'Temp'
            $env:APPDATA                    = 'AppData'
            "C:\Users\Morten\Desktop"       = 'Desktop'
            "C:\Users\Morten\Documents"     = 'Documents'
            "E:\"                           = 'Downloads'
            "C:\Users\Morten\Documents\playingwithpowershell"   = 'git'
        } 
    }
    Process
    {
        Foreach($Item in $Path)
        {
            $Match = ($CustomDirectories.GetEnumerator().name | Where-Object{$Item -eq "$_" -or $Item -like "$_*"} |`
            Select-Object @{n='Directory';e={$_}},@{n='Length';e={$_.length}} |Sort-Object Length -Descending |Select-Object -First 1).directory
            If($Match)
            {
                [String]($Item -replace [regex]::Escape($Match),$CustomDirectories[$Match])            
            }
            ElseIf($pwd.Path -ne $Item)
            {
                $Item + "Hello"
            }
            Else
            {
                $pwd.Path
            }
        }
    }
    End
    {
    }
}

# Custom Powershell Host Prompt()
Function Prompt
{   
    Write-Host "[CodeBarbarian] " -NoNewline; Write-Host "$([char]9829) " -ForegroundColor Red -NoNewline; Write-Host "PS " -NoNewline
    Write-Host $(Get-CustomDirectory) -ForegroundColor Green  -NoNewline        
    Write-Host " >_" -NoNewline -ForegroundColor Yellow
    return " "
}