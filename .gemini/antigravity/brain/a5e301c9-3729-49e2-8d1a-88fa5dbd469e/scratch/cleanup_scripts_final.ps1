$files = @(
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

$targetScript = '<script src="https://t.contentsquare.net/uxa/dae4005d15a68.js"></script>'
$insertion = "  $targetScript"

foreach ($file in $files) {
    $path = "public\$file"
    if (Test-Path $path) {
        $content = Get-Content $path -Raw
        
        # Remove all existing script tags for this URL, regardless of surrounding whitespace
        # Use regex to match the tag even if it has different indentation or newlines
        $regex = "(?m)^\s*<script src=`"https://t.contentsquare.net/uxa/dae4005d15a68.js`"></script>\s*`r?`n"
        $content = [regex]::Replace($content, $regex, "")
        
        # Also catch versions without a following newline just in case
        $regex2 = "\s*<script src=`"https://t.contentsquare.net/uxa/dae4005d15a68.js`"></script>"
        $content = [regex]::Replace($content, $regex2, "")

        # Insert before </head>
        # Check if already there (shouldn't be after removals, but safe check)
        if ($content -notlike "*$insertion*") {
            $newContent = $content -replace '</head>', "$insertion`n</head>"
            Set-Content $path $newContent -NoNewline
            Write-Host "Updated $path"
        } else {
            Write-Host "$path already correct"
        }
    }
}
