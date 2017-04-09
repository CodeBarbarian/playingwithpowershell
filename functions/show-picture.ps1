# =================== Script Config =================== #
# -------------Script dependant variables-------------- #
$AdjustmentWidth  = 15 # This is to adjust for the form Width (in pixels)
$AdjustmentHeight = 30 # This is to adjust for the form Height (in pixels)

<#
.SYNOPSIS
    Show-Picture

.DESCRIPTION
    Function to display a picture, given the direct path to it. 
    Using the Windows Form to do this

.EXAMPLE
    Show-Picture -Path 'c:\sample.jpg'

.PARAMETER Path
    The Path to the picturex

#>
function Show-Picture {
    param (
        [string]$Path  
    )

    if (-not($Path)) {
        # Exception code bla bla bla
    } else {
      # Get the image
      $ImageFile = (Get-Item $Path)
      # Turn it into a image object
      $Image = [System.Drawing.Image]::Fromfile($ImageFile)
    }

    # Load the assembly, so we can use the Windows Forms
    [void][reflection.assembly]::LoadWithPartialName("System.Windows.Forms")
    # Make sure the image style is the same all around
    [System.Windows.Forms.Application]::EnableVisualStyles()

    # Create the windows form
    $Form = New-Object Windows.Forms.Form

    # Define Title
    $Form.Text = $ImageFile.BaseName

    # Form Width + Height // The form needs to be bigger to fit the picture in it
    $Form.Width = $Image.Size.Width + $AdjustmentWidth
    $Form.Height =  $Image.Size.Height + $AdjustmentHeight

    # Create a picture box
    $PictureBox = new-object Windows.Forms.PictureBox
    $PictureBox.Width =  $Image.Size.Width
    $PictureBox.Height =  $Image.Size.Height

    # Set the image of the picture box
    $pictureBox.Image = $Image

    # Insert the picturebox inside the windows form
    $Form.Controls.Add($PictureBox)
    $Form.Add_Shown($Form.Activate())

    # Show the picture in the form dialog
    $Form.ShowDialog()

}

# Display picture 
Show-Picture -Path 'C:\sample.jpg'