######################################################################## 
# Written and Copy/Pasted On: 6/13/2018 11:35 PM 
########################################################################

#Hide the powershell popup window
Add-Type -Name win -MemberDefinition '[DllImport("user32.dll")] public static extern bool ShowWindow(int handle, int state);' -Namespace native
[native.win]::ShowWindow(([System.Diagnostics.Process]::GetCurrentProcess() | Get-Process).MainWindowHandle,0)

function GenerateForm { 
#region Import the Assemblies 
[reflection.assembly]::loadwithpartialname("System.Windows.Forms") | Out-Null 
[reflection.assembly]::loadwithpartialname("System.Drawing") | Out-Null 
#endregion Import the Assemblies 

#region Main Window
$HelpDeskForm = New-Object System.Windows.Forms.Form 
$Drive01 = New-Object System.Windows.Forms.Button 
$Drive02 = New-Object System.Windows.Forms.Button 
$Drive03 = New-Object System.Windows.Forms.Button 
$Drive04 = New-Object System.Windows.Forms.Button 
$LegacyBackups = New-Object System.Windows.Forms.Button 
$Infrastructure = New-Object System.Windows.Forms.Button 
$InitialFormWindowState = New-Object System.Windows.Forms.FormWindowState 
#endregion Main Window

#region Handlers
$handler_Drive01_Click= 
{
	net use F: \\ServerIP\ShareName
	explorer.exe F:\
}

$handler_Drive02_Click= 
{
	net use F: \\ServerIP\ShareName
	explorer.exe F:\
}

$handler_Drive03_Click= 
{
	net use F: \\ServerIP\ShareName
	explorer.exe F:\
}

$handler_Drive04_Click= 
{
	net use F: \\ServerIP\ShareName
	explorer.exe F:\
}

#endregion Handlers

#region Correct the initial state of the form to prevent the .Net maximized form issue 
$OnLoadForm_StateCorrection= 
{
$HelpDeskForm.WindowState = $InitialFormWindowState 
}

#Set coordinates to 0
$xButton=0
$yButton=0

$xApp=240
$yApp=151

$xButtonSize=240
$yButtonSize=23


#region Primary Help Desk Window
$HelpDeskForm.Text = "Drive Mapper" 
$HelpDeskForm.Name = "HelpDeskForm" 
$HelpDeskForm.DataBindings.DefaultDataSourceUpdateMode = 0 
$System_Drawing_Size = New-Object System.Drawing.Size 
$System_Drawing_Size.Width = $xApp 
$System_Drawing_Size.Height = $yApp
$HelpDeskForm.ClientSize = $System_Drawing_Size
#endregion Primary Help Desk Window



#region Drive01 Drive Map
$Drive01.TabIndex = 0 
$Drive01.Name = "Drive01" 
$System_Drawing_Size = New-Object System.Drawing.Size 
$System_Drawing_Size.Width = $xButtonSize
$System_Drawing_Size.Height = $yButtonSize
$Drive01.Size = $System_Drawing_Size 
$Drive01.UseVisualStyleBackColor = $True
$Drive01.Text = "Drive01"
$System_Drawing_Point = New-Object System.Drawing.Point 
$System_Drawing_Point.X = $xButton
$System_Drawing_Point.Y = $yButton
$Drive01.Location = $System_Drawing_Point 
$Drive01.DataBindings.DefaultDataSourceUpdateMode = 0 
$Drive01.add_Click($handler_Finance_Click)
$HelpDeskForm.Controls.Add($Drive01)
#endregion Drive01 Drive Map

#region Drive02 Drive Map
$Drive02.TabIndex = 1 
$Drive02.Name = "Drive02" 
$System_Drawing_Size = New-Object System.Drawing.Size 
$System_Drawing_Size.Width = $xButtonSize
$System_Drawing_Size.Height = $yButtonSize
$Drive02.Size = $System_Drawing_Size 
$Drive02.UseVisualStyleBackColor = $True
$Drive02.Text = "Drive02"
$System_Drawing_Point = New-Object System.Drawing.Point 
$System_Drawing_Point.X = $xButton
$System_Drawing_Point.Y = $yButton+23
$Drive02.Location = $System_Drawing_Point 
$Drive02.DataBindings.DefaultDataSourceUpdateMode = 0 
$Drive02.add_Click($handler_Spectrum_Click)
$HelpDeskForm.Controls.Add($Drive02)
#endregion Drive02 Drive Map

#region Drive03
$Drive03.TabIndex = 2 
$Drive03.Name = "Drive03" 
$System_Drawing_Size = New-Object System.Drawing.Size 
$System_Drawing_Size.Width = $xButtonSize
$System_Drawing_Size.Height = $yButtonSize
$Drive03.Size = $System_Drawing_Size 
$Drive03.UseVisualStyleBackColor = $True
$Drive03.Text = "Drive03"
$System_Drawing_Point = New-Object System.Drawing.Point 
$System_Drawing_Point.X = $xButton
$System_Drawing_Point.Y = $yButton+23+23
$Drive03.Location = $System_Drawing_Point 
$Drive03.DataBindings.DefaultDataSourceUpdateMode = 0 
$Drive03.add_Click($handler_LegacyProjects_Click)
$HelpDeskForm.Controls.Add($Drive03)
#endregion Drive03

#region Drive04 Drive Map
$Drive04.TabIndex =3 
$Drive04.Name = "Drive04" 
$System_Drawing_Size = New-Object System.Drawing.Size 
$System_Drawing_Size.Width = $xButtonSize
$System_Drawing_Size.Height = $yButtonSize
$Drive04.Size = $System_Drawing_Size 
$Drive04.UseVisualStyleBackColor = $True
$Drive04.Text = "Drive04"
$System_Drawing_Point = New-Object System.Drawing.Point 
$System_Drawing_Point.X = $xButton
$System_Drawing_Point.Y = $yButton+23+23+23
$Drive04.Location = $System_Drawing_Point 
$Drive04.DataBindings.DefaultDataSourceUpdateMode = 0 
$Drive04.add_Click($handler_FileHistory_Click)
$HelpDeskForm.Controls.Add($Drive04)
#endregion Drive04 Drive Map

#Save the initial state of the form 
$InitialFormWindowState = $HelpDeskForm.WindowState 
#Init the OnLoad event to correct the initial state of the form 
$HelpDeskForm.add_Load($OnLoadForm_StateCorrection) 
#Show the Form 
$HelpDeskForm.ShowDialog()| Out-Null

} #End Function

#Call the Function 
GenerateForm 

