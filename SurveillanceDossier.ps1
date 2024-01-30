# Paramètres FTP
$ftpServer = "ftp://votre_serveur_ftp"
$ftpUser = "votre_utilisateur"
$ftpPassword = "votre_mot_de_passe"
$ftpFolder = "/chemin/ftp/"

# Dossier local à surveiller
$localFolder = "C:\Users\mariu\OneDrive\Bureau\dossiersurveille"

# Fonction pour envoyer un fichier via FTP
function Send-FtpFile {
    param (
        [string]$localFile,
        [string]$ftpUrl,
        [string]$ftpUser,
        [string]$ftpPassword
    )

    $webClient = New-Object System.Net.WebClient
    $webClient.Credentials = New-Object System.Net.NetworkCredential($ftpUser, $ftpPassword)
    $uri = New-Object System.Uri($ftpUrl)

    try {
        $webClient.UploadFile($uri, $localFile)
        # Suppression du fichier après le transfert
        Remove-Item $localFile -Force
    } catch {
        Write-Error "Erreur lors de l'envoi du fichier : $_"
    }
}

# Création d'un objet FileSystemWatcher
$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = $localFolder
$watcher.Filter = "*.*"
$watcher.IncludeSubdirectories = $false
$watcher.EnableRaisingEvents = $true

# Action à effectuer lors de l'ajout d'un fichier
$action = {
    param ($source, $e)
    $filePath = $e.FullPath


    # Préparation de l'URL pour le transfert FTP
    $ftpUrl = $ftpServer + $ftpFolder + "/" + [IO.Path]::GetFileName($filePath)

    # Envoi du fichier via FTP et suppression
    Send-FtpFile -localFile $filePath -ftpUrl $ftpUrl -ftpUser $ftpUser -ftpPassword $ftpPassword
}

# Abonnement aux événements
Register-ObjectEvent $watcher "Created" -Action $action

# Pour garder le script en cours d'exécution
while ($true) {
    Start-Sleep -Seconds 10
}
