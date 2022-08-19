try
{
    $current_path = Get-Location
    $my_name = $(Split-Path -Leaf -Path $PSCommandPath)
    $parent_name = "script"
    if ($MyInvocation.PSCommandPath -ne $null)
    {
        $parent_name = $(Split-Path -Leaf -Path $MyInvocation.PSCommandPath)
    }
    $event_name = "SSharing_$($parent_name)"
    $mutex_name = "$($event_name)_2"

    #--------------------------------------------------
    # Create Event
    $event_reset_mode = New-Object System.Threading.EventResetMode
    $event = New-Object System.Threading.EventWaitHandle -ArgumentList $false, $event_reset_mode, $event_name
    if ($event -eq $null)
    {
        Write-Warning "Unable to create event."
        exit
    }

    #--------------------------------------------------
    # Create mutex
    $mutex = New-Object System.Threading.Mutex -ArgumentList $false, $mutex_name
    if ($mutex -eq $null)
    {
        Write-Warning "Unable to create mutex."
        $event.Close()
        exit
    }
    
    #--------------------------------------------------
    # Run SSharingPro
    $params = "-cur ""$($current_path)"" -event ""$($event_name)"" -pause "
    if ($args.Length -gt 0)
    {
        $params = "$($params)$($args)"
    }
    start-process -FilePath "shell:AppsFolder\SomeFellowSystemInc.SSharingProJP_d91f29x6h4532!SSharingPro" $params

    #--------------------------------------------------
    # Wait SSharingPro start (Timeout 10[sec])
    if ($event.WaitOne(10000)) {
        # Wait SSharingPro finish
        $result = $mutex.WaitOne()
    }
    else
    {
        Write-Warning "Unable to boot SSharing"
    }
}

catch
{
    Write-Warning "$($my_name) : exception"
    Write-Warning $_
}

if ($event -ne $null)
{
    $event.Close()
}

if ($mutex -ne $null)
{
    $mutex.Close()
}

exit
