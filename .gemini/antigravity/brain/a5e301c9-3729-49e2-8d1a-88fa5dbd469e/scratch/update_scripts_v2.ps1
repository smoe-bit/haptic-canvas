$files = @(
    "towel_set_0020.html",
    "towel_set_0020i.html",
    "towel_set_0023.html",
    "towel_set_0023i.html",
    "towel_set_0024.html",
    "towel_set_0024i.html",
    "towel_set_0020e.html",
    "towel_set_0020ie.html",
    "towel_set_0023e.html",
    "towel_set_0023ie.html",
    "towel_set_0024e.html",
    "towel_set_0024ie.html",
    "desk_organiser_0011.html",
    "desk_organiser_0011i.html",
    "desk_organiser_0013.html",
    "desk_organiser_0013i.html",
    "desk_organiser_0015.html",
    "desk_organiser_0015i.html"
)

$scriptTag = '  <script src="https://t.contentsquare.net/uxa/dae4005d15a68.js"></script>'

foreach ($file in $files) {
    $path = "public\$file"
    if (Test-Path $path) {
        $content = Get-Content $path -Raw
        # Remove any existing version if it exists (just in case)
        $content = $content -replace [regex]::Escape($scriptTag) + "`r?`n", ""
        $content = $content -replace "  <script src=`"https://t.contentsquare.net/uxa/dae4005d15a68.js`"></script>`r?`n", ""
        
        # Insert after <head>
        $newContent = $content -replace '<head>', "<head>`n$scriptTag"
        Set-Content $path $newContent -NoNewline
        Write-Host "Updated $path"
    } else {
        Write-Warning "File not found: $path"
    }
}
