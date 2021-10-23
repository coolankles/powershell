$filter = Get-Date -Format "yyyyMM"
$filter = "my_app_log_$filter.csv"
$source = "c:\MY_DIR\logs"
$log_archives = "c:\MY_DIR\logs\archives\"
$log_archive_filename = $log_archives + $filter + ".zip"
Add-Type -assembly "system.io.compression.filesystem"
 # creates empty zip file:
[System.IO.Compression.ZipArchive] $arch = [System.IO.Compression.ZipFile]::Open($log_archive_filename,[System.IO.Compression.ZipArchiveMode]::Update)
# add your files to archive
Get-ChildItem "c:\my_dir\logs\$filter"      |
foreach {[System.IO.Compression.ZipFileExtensions]::CreateEntryFromFile($arch,$_.FullName,$_.Name)}
# archive will be updated with files after you close it. normally, in C#, you would use "using ZipArchvie arch = new ZipFile" and object would be disposed upon exiting "using" block. here you have to dispose manually:
$arch.Dispose()