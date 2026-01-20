Clear-Host

### Path to PSX games folders :
cd '/users/hexatune/documents/Sony PlayStation'

### list all folders in current directory :
$listfolder = Get-ChildItem -Directory | Sort-Object

### copier les scripts dans chaque dossier de jeu et les exécuter :

foreach ($folder in $listfolder) {
    cp $PSScriptRoot/VCD/binmerge $folder.FullName
    cp $PSScriptRoot/VCD/cue2pops $folder.FullName
    cd $folder.FullName
    $cue = Get-ChildItem -file *.cue 
    mkdir VCD

    
### merge BIN files into single VCD :
    python3 binmerge $cue.Name './VCD/merge'
###
    $cue = Get-ChildItem -file  './VCD/*.cue'

### convert CUE to POPS :
    cue2pops $cue.fullname

    cd ./VCD

### Extracting game ID from VCD file name :
    $gameid = strings  *.VCD | grep -oE "[A-Z]{4}_[0-9]{3}\.[0-9]{2}"

### Naming the final VCD file according to game ID :
    $gamename = $gameid[0] + "." + $folder.name + ".VCD"

### Rename the merged VCD file to the final game name :
    mv merge.VCD $gamename

    Write-Host "Jeu traité :" $gamename
    write-host ""
    Write-Host "prochain jeu dans 5 secondes..."
    sleep 5


}

### Script to copy all PSX VCD files from local Mac to NAS SMB share

### path NAS SMBshare :
$destination = "/Volumes/share/POPS/"

### path local Mac :
$source = "/users/hexatune/documents/Sony PlayStation/"

### list all VCD files recursively and copy to NAS :
$listgames = Get-ChildItem -File *.VCD $source -Recurse | Sort-Object
$listgames | ForEach-Object {

    Write-Host "Copie de " $_.Name " vers le NAS..."
    cp $_.FullName $destination -verbose
    sleep 1

}