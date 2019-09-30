<#
.SYNOPSIS
    Create a new Project based on this CcOSExampleProject.

.PARAMETER NewProjectName
    Name of new project
#>
PARAM( 
    [PARAMETER(Mandatory)]
    $NewProjectName
)

<#
.SYNOPSIS
    Walk recursively through a directory and rename all Item Names from "CcOSExampleProject" to $NewProjectName

.PARAMETER Path
    Path to Start recursive search.
#>
Function Rename
{
    PARAM( 
        [PARAMETER(Mandatory)]
        $Path
    )
    $Items = Get-ChildItem $Path
    foreach($Item in $Items)
    {
        if($Item.Name -eq ".git")
        {
            continue
        }
        if($Item.PSIsContainer)
        {
            Rename ($Path + "/" + $Item.Name)
        }
        if($Item.Name.contains("CcOSExampleProject"))
        {
            $sNewName = $Item.Name.Replace("CcOSExampleProject", $NewProjectName);
            Move-Item ($Path + "/" + $Item.Name) ($Path + "/" + $sNewName) -Force
        }
    }
}

<#
.SYNOPSIS
    Walk recursively through a directory and replace "CcOSExampleProject" with $NewProjectName
    in all found files.

.PARAMETER Path
    Path to Start recursive replacement.
#>
Function ReplaceInFiles
{
    PARAM( 
        [PARAMETER(Mandatory)]
        $Path
    )
    $Items = Get-ChildItem $Path
    foreach($Item in $Items)
    {
        if($Item.Name -eq ".git")
        {
            continue
        }
        if($Item.Name.EndsWith($ThisScript))
        {
            continue
        }
        if($Item.PSIsContainer)
        {
            ReplaceInFiles ($Path + "/" + $Item.Name)
        }
        else
        {
            $FileName = $Path + "/" + $Item.Name
            if(FileContains $FileName "CCOSEXAMPLEPROJECT")
            {
                FileReplace $FileName "CCOSEXAMPLEPROJECT" $NewUpperProjectName
            }
            if(FileContains $FileName "CcOSExampleProject")
            {
                FileReplace $FileName "CcOSExampleProject" $NewProjectName
            }
        }
    }
}

<#
.SYNOPSIS
    Check if file contains a specified string
.DESCRIPTION
    Finding string in file is case sensitive.
    CommandLet will use Get-Content to parse each line and stop on first match
.PARAMETER FilePath
    Path to File where strings should be replaced
.PARAMETER String
    String to find in File
.EXAMPLE
    FileContains Test.txt "TestString"
#>
Function FileContains
{
    PARAM( 
        [PARAMETER(Mandatory)]
        $FilePath,
        [PARAMETER(Mandatory)]
        $String
    )
    $FileContent = Get-Content $FilePath
    foreach($Line in $FileContent)
    {
        if($Line -cmatch $String)
        {
            return $true
        }
    }
    return $false
}

<#
.SYNOPSIS
    Replace String in File
.DESCRIPTION
    Replace String in File case sensitive.
    CommandLet will use Get-Content to parse each line and Set-Content to write result
.PARAMETER FilePath
    Path to File where strings should be replaced
.PARAMETER String
    String to find in File
.PARAMETER WorkingDir
    String to be replaced with in file
.EXAMPLE
    FileReplace Test.txt "TestString" "Replacement"
#>
Function FileReplace
{
    PARAM( 
        [PARAMETER(Mandatory)]
        $FilePath,
        [PARAMETER(Mandatory)]
        $String,
        [PARAMETER(Mandatory)]
        $Replace
    )
    $FileContent = Get-Content $FilePath
    $NewFileContent = @()
    foreach($Line in $FileContent)
    {
        $NewLine = $Line -creplace $String, $Replace
        $NewFileContent += $NewLine
    }
    Set-Content $FilePath $NewFileContent
}

<#
.SYNOPSIS
    Format a CamelCase String to an UPPER_CASE String.
.DESCRIPTION
    Add an underline on each upper character or digit in string, except the firt.
    Example Outputs:
    CamelCase -> CAMEL_CASE
    camelCase -> CAMEL_CASE
    Camel2Case -> CAMEL_2_CASE
.PARAMETER String
    String to format into new string
.EXAMPLE
    CamelCaseToUpper "CamleCaseString"
#>
Function CamelCaseToUpper
{
    PARAM(
        [PARAMETER(Mandatory)]
        [string]$String
    )

    [char[]]$Chars = $String
    $Count = 0
    $NewString = ""
    foreach($Char in $Chars)
    {
        if( [char]::IsUpper($Char) -or
            [char]::IsDigit($Char))
        {
            if($Count -ne 0)
            {
                $Append = "_" + $Char
            }
            else
            {
                $Append = $Char
            }
        }
        else
        {
            $Append = [char]::ToUpper($Char)
        }
        $Count++
        $NewString += $Append
    }
    Return $NewString
}


<#
.SYNOPSIS
    Simple to upper script
.DESCRIPTION
.PARAMETER String
    String to format into new string
.EXAMPLE
    DefaultToUpper "CamleCaseString"
#>
Function DefaultToUpper
{
    PARAM(
        [PARAMETER(Mandatory)]
        [string]$String
    )

    [char[]]$Chars = $String
    $Count = 0
    $NewString = ""
    foreach($Char in $Chars)
    {
        $Append = [char]::ToUpper($Char)
        $Count++
        $NewString += $Append
    }
    Return $NewString
}

$NewUpperProjectName = DefaultToUpper $NewProjectName
$ThisScript = $MyInvocation.MyCommand.Name

Rename ..

ReplaceInFiles ..

# remove current CcOS and .submodules
if(Test-Path ../.gitmodules)
{
    git submodule deinit --all
    Remove-Item ../.gitmodules -Recurse -Force
}

if(Test-Path ../CcOS)
{
    git rm --cached ../CcOS
    Remove-Item ../CcOS -Recurse -Force
}

# add CcOS from git source
git submodule add --force https://coolcow.de/projects/CcOS.git ../CcOS
