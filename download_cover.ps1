cd /Volumes/share/ART
$list = Get-ChildItem /Volumes/share/POPS -File -Name *.VCD | Sort-Object

foreach ($item in $list) {
    $url = "http://www.hwc.nat.cu/psx/"
    $name = $item.Split(".")[0] + "." + $item.Split(".")[1] + "_COV.jpg"
    $cover = $url + $name
write-host "Download du fichier :" $name
curl -L -o $name $cover

sleep 3
    # break
}

https://github.com/xlenore/psx-covers/blob/main/covers/default/SLPS-00307.jpg