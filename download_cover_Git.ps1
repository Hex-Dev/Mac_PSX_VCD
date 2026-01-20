### Script PowerShell pour télécharger les covers PSX depuis GitHub Mac OS X

clear-host
write-host "Début du script de téléchargement des covers PSX depuis GitHub"


cd /Volumes/share/ART
$list = Get-ChildItem /Volumes/share/POPS -File -Name *.VCD | Sort-Object

foreach ($item in $list) {

    $url = "https://raw.githubusercontent.com/xlenore/psx-covers/refs/heads/main/covers/default/"

    $1 = $item.Split(".")[0] -replace "_","-"
    $2 = $item.Split(".")[1]
    $name = $1 + $2 + ".jpg"

    $cover = $url + $name

    write-host "Download du fichier :" $name

    $d1 = $name[0..3]  -join ""
    $d2 = $name[5..7]  -join ""
    $d3 = $name[8..9]  -join ""

    $destinationname = $d1 + "_" + $d2 + "." + $d3 + "_COV.jpg"

    ### Télécharger la cover et la renommer correctement :
    curl -L -o $destinationname $cover

    sleep 1
}
