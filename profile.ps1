#================================================================================#
# PowerShell Profile - C:\Users\mmirande\Documents\WindowsPowerShell\profile.ps1 #
#================================================================================#

# Path ==========================================================================#
$env:Path += "; C:\Program Files\Windows Azure SDK\v1.0\bin"
$env:path += "; C:\Program Files (x86)\nodejs"
$env:path += "; C:\Program Files (x86)\Python27"
$env:path += "; C:\Program Files (x86)\Git\bin"

# Globals =======================================================================#
$PROFILE = $HOME + "\Documents\WindowsPowerShell\profile.ps1"
$NODEMODULES = $HOME + "\AppData\Roaming\npm\node_modules"

# Startup =======================================================================#
clear
Set-ExecutionPolicy RemoteSigned #run local scripts only
Set-Location "C:\dev"
function prompt{
	$user = $env:username
	$location = Get-Location
	$date = Get-Date -format "ddd.MMM.dd.yyyy..HH:mm:ss"
	"$user.........$date..........($location)`n>>"
}

# Basics =======================================================================#
#Set-Alias example-alias "C:\path\to\some\thing.ext"


# Funcs ========================================================================#
function cd-dropbox { cd "$HOME\Documents\My Dropbox" }
function cd-chz { cd "C:\dev\chzbrgr" }
function edit-hgrc { notepad "$HOME\Mercurial.ini" }
function edit-profile { notepad $PROFILE }

function hg-latest($count){
	if( ! $count ){
		$count = 5
	}

	hg log --limit $count
}

function rjs($buildFile) {
	node "$NODEMODULES\requirejs\bin\r.js" -o $buildFile
}

# helper to allow the mklink under PowerShell
function mklink { cmd /c mklink $args }

# open explorer in this directory
function exp([string] $loc = '.') {
	explorer "/e,"$loc""
}

# return all IP addresses
function get-ips() {
	$ent = [net.dns]::GetHostEntry([net.dns]::GetHostName())
	return $ent.AddressList | ?{ $_.ScopeId -ne 0 } | %{
		[string]$_
	}
}

# return escaped html
function escape-html($text) {
	$text = $text.Replace('&', '&amp;')
	$text = $text.Replace('"', '&quot;')
	$text = $text.Replace('<', '&lt;')
	$text.Replace('>', '&gt;')
}