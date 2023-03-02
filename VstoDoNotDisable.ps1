   If ($env:computername -like "*") {
   
    # Création du point d'entrée au registre HKU (s'il n'existe pas)
    if($false -eq (Test-Path HKU:\ ))
    {
        New-PSDrive -PSProvider Registry -Name HKU -Root HKEY_USERS | Out-Null
    }

    $results = ""

    # Récupération des répertoires enfants dans la ruche HKEY_USERS (Les users justement)       
    $hkuEntries = Get-ChildItem -Path HKU:\ |  Select-Object

    # on itère sur chaque user afin de recherche une entrée d'enregistrement d'URI Scheme pour iNot
    foreach($userEntry in $hkuEntries)
    {
        # $userEntry = $hkuEntries[3]
        $PathOutlook16 = $userEntry.Name + "\Software\Microsoft\Office\16.0\Outlook"
        $PathOutlook16 = $PathOutlook16.Replace("HKEY_USERS", "HKU:")

        $PathResiliency = $PathOutlook16 + "\Resiliency"
        $Addin = $PathResiliency + "\DoNotDisableAddinList"

        if($true -eq (Test-Path $PathOutlook16 ))
        {
        New-Item -Path $PathOutlook16 -Name Resiliency 
        #write-host "exist pas Resiliency"
        
        if($false -eq (Test-Path $Addin ))
        {
        New-Item -Path $PathResiliency -Name DoNotDisableAddinList 
        #write-host "Exist pas DoNotDisableAddinList"
        New-ItemProperty -Path $Addin -Name GenApi.iNot.Outlook -Value 1 -PropertyType dword -Force | Out-Null
                }

        if($true -eq (Test-Path $Addin ))
        {
        #write-host "Exist pas DoNotDisableAddinList"
        New-ItemProperty -Path $Addin -Name GenApi.iNot.Outlook -Value 1 -PropertyType dword -Force | Out-Null
                }
                }
        $PathOutlook15 = $userEntry.Name + "\Software\Microsoft\Office\15.0\Outlook"
        $PathOutlook15 = $PathOutlook15.Replace("HKEY_USERS", "HKU:")

        $PathResiliency = $PathOutlook15 + "\Resiliency"
        $Addin = $PathResiliency + "\DoNotDisableAddinList"
        if($true -eq (Test-Path $PathOutlook15 ))
        {
        New-Item -Path $PathOutlook15 -Name Resiliency 
        #write-host "exist pas Resiliency"
        
        if($false -eq (Test-Path $Addin ))
        {
        New-Item -Path $PathResiliency -Name DoNotDisableAddinList 
        #write-host "Exist pas DoNotDisableAddinList"
        New-ItemProperty -Path $Addin -Name GenApi.iNot.Outlook -Value 1 -PropertyType dword -Force | Out-Null
                }
         if($true -eq (Test-Path $Addin ))
        {
        #write-host "Exist pas DoNotDisableAddinList"
        New-ItemProperty -Path $Addin -Name GenApi.iNot.Outlook -Value 1 -PropertyType dword -Force | Out-Null
        
        }
        
        }

        
        }
        }
