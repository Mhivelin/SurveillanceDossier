# SurveillanceDossier
script PowerShell pour envoyer automatiquement sur un ftp


## installation

### Étape 1 : copier le script

#### option 1 : copier le script
* copier le script dans le dossier de votre choix

#### option 2 : cloner le projet
* cloner le projet dans le dossier de votre choix
```bash
git clone git@github.com:Mhivelin/SurveillanceDossier.git
```

### Étape 2 : modifier le script
* modifier le script pour y mettre les informations de votre serveur ftp
  * `$dossier` : le dossier à surveiller
  * `$filtre` : le filtre pour les fichiers à surveiller (inchangé = tous les fichiers)
  * `ftpServer` : le nom du serveur ftp
  * `ftpUser` : le nom d'utilisateur du serveur ftp
  * `ftpPassword` : le mot de passe du serveur ftp


### Étape 3 : Créer une Tâche Planifiée

1. Ouvrez le Planificateur de Tâches. Appuyez sur `Win + R`, tapez `taskschd.msc` et appuyez sur Entrée.

2. Créez une Nouvelle Tâche. Dans le Planificateur de Tâches, allez dans Action > Créer une tâche.

3. Configurez la Tâche :

   * Dans l'onglet Général, donnez un nom à votre tâche, par exemple, SurveillanceDossier.
Choisissez Exécuter que l'utilisateur soit connecté ou non et cochez Ne pas stocker le mot de passe.
Configurer le Déclencheur :

   * Allez dans l'onglet Déclencheurs et cliquez sur Nouveau.
Sélectionnez Au démarrage dans le menu déroulant Commencer la tâche.
Configurer l'Action :

   * Allez dans l'onglet Actions et cliquez sur Nouveau.
   * Dans Programme/script, entrez powershell.exe.
   * Dans Ajouter des arguments, entrez -ExecutionPolicy Bypass -File "C:\Chemin\vers\le\SurveillanceDossier.ps1" (remplacez C:\Chemin\vers\le\ par le chemin réel de votre script).

   * Configurer les Conditions et Paramètres :

   * Dans les onglets Conditions et Paramètres, ajustez les paramètres selon vos besoins.

   * Cliquez sur OK pour enregistrer la tâche.
  
### Étape 3 : Tester la Tâche Planifiée

* Testez la Tâche Planifiée. Retournez au Planificateur de Tâches, trouvez votre tâche dans la bibliothèque de tâches, faites un clic droit dessus et choisissez Exécuter pour tester.

* Vérifiez si le Script Fonctionne Correctement. Ajoutez un fichier dans le dossier surveillé et vérifiez si le script l'envoie au serveur FTP comme prévu.

**Notes Importantes** :

> **Assurez-vous que le chemin du script PowerShell est correct dans la configuration de la tâche.
assurez-vous que le compte utilisé pour exécuter la tâche a ces droits.**