# Chemin du dossier à surveiller
$dossier = "C:\Chemin\vers\le\dossier"

# Filtre (par exemple, '*.txt' pour surveiller uniquement les fichiers .txt)
$filtre = '*.*' 

# Action à effectuer lors de l'ajout d'un fichier
$action = {
    param($chemin, $nomFichier)
    # Information sur l'événement
    Write-Host "Fichier ajouté: $nomFichier à $chemin"

    # Paramètres FTP
    $ftpServer = "ftp://votre.ftp.com/dossier"
    $ftpUser = "votreUtilisateur"
    $ftpPassword = "votreMotDePasse"

    # Création de l'objet WebClient
    $webClient = New-Object System.Net.WebClient
    $webClient.Credentials = New-Object System.Net.NetworkCredential($ftpUser, $ftpPassword)

    # Chemin du fichier local et destination FTP
    $cheminFichierLocal = Join-Path $chemin $nomFichier
    $uri = New-Object System.Uri($ftpServer + '/' + $nomFichier)

    # Transfert du fichier
    try {
        $webClient.UploadFile($uri, $cheminFichierLocal)
        Write-Host "Transfert réussi: $nomFichier"
    }
    catch {
        Write-Host "Erreur de transfert: $_"
    }
}

# Création de l'objet FileSystemWatcher
$fsw = New-Object IO.FileSystemWatcher $dossier, $filtre -Property @{
    IncludeSubdirectories = $false
    EnableRaisingEvents = $true
}

# Abonnement aux événements
Register-ObjectEvent $fsw Created -Action $action

# Pour garder le script en cours d'exécution
while ($true) { Start-Sleep -Seconds 10 }
