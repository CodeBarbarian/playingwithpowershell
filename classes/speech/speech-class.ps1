<#
    Add-Type Assemblies
#>
Add-Type -AssemblyName System.Speech

<#
.SYNOPSIS
    This class utilizes the System.Speech, so that you can make your scripts talk. 

.DESCRIPTION
    See synopsis. 

.EXAMPLE
    $Speech = New-Object Speech

    $Speech.Speak("Hello")

#>
Class Speech {
   Speak ($String) {
        $Speak = New-Object System.Speech.Synthesis.SpeechSynthesizer
        $Speak.Speak($String)
    }

    GoodMorning () {
        $this.Speak("Good Morning")
    }

    GoodNight () {
        $this.Speak("Good night")
    }

    CurrentTime() {
        # Get the current Date and Time
        $DateTime = Get-Date

        # Let us switch it around
        $ReturnObject = "The time is: " + ($DateTime.Hour.ToString()) + ":" + ($DateTime.Minute.ToString())
        
        # Speak the time
        $this.Speak($ReturnObject) 
    }
}

# Example
$Speech = New-Object Speech
$Speech.CurrentTime()
