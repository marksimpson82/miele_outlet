$dw_dir = "C:\temp\miele"

if(!(Test-Path -Path $dw_dir )) {
    New-Item -path $dw_dir -type d
}

$pdf_filename = "MieleOutletPricelist.pdf"

$tmp_filepath = [System.IO.Path]::GetTempFileName()
$dw_url = "http://application.miele.co.uk/resources/pdf/$pdf_filename"
Invoke-WebRequest -Uri $dw_url -OutFile $tmp_filepath -DisableKeepAlive -Headers @{"Cache-Control"="no-cache"}

$old_filepath = Join-Path -Path $dw_dir -ChildPath $pdf_filename

if(Test-Path -Path $old_filepath) {
    & "C:\Program Files\Git\usr\bin\diff.exe" $old_filepath $tmp_filepath
    
    if($LastExitCode -eq 0) {
        Write-Host "Contents are identical; nothing to do." -ForegroundColor Green
    }
    else {
        Write-Host "Contents differed; running bcompare" -ForegroundColor Red
        $proc = Start-Process bcompare.exe -PassThru -ArgumentList "$old_filepath $tmp_filepath"
        $proc.WaitForExit();
    }
}
else {
    Write-Host "No old file to diff against"
}

Move-Item $tmp_filepath $old_filepath -Force
