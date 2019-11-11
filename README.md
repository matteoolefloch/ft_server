# ft_server DOCUMENTATION EN COURS DE REDACTION
FT_SERVER project at 42 school Paris

# Comment faire ft_server

Pour faire le projet ft_server, je me suis servie des ressource suivante : 

Comment installer un serveur LEMP [https://www.linuxbabe.com/debian/install-lemp-stack-debian-10-buster]
Installer PHPMYADMIN [https://www.itzgeek.com/how-tos/linux/debian/how-to-install-phpmyadmin-with-nginx-on-debian-10.html]

# ATTENTION
Certaine commande ne sont pas disponible/installer sur notre version de debian buster tel que : 

La commande pour redemarer un service est :
```
systemctl restart nginx
```
Remplacer par 
```
service nginx restart 
```
Dans une bonne partie des tuto trouver sur internet vous allez retrouver la commande 
```
ufw
```
UFW est un pare-feux, il n'est pas installer d'origine avec debian donc pas besoin de s'en preocuper

# Liste de Tips 
1. Authoriser l'utilisateur root a acceder a la base de donnee via phpmyadmin
Dermarer le terminal sql avec la commande ```mysql```
Effectuer ces requettes SQL
```
update mysql.user set plugin = 'mysql_native_password' where user='root';
```

2. Authoriser la connexion phpmyadmin sans mot de passe 
Creer un fichier de configuration nommer ``` config.inc.php``` a l'aide du template ```config.template.inc.php``` situer a la racine de phpmyadmin
Remplacer 
```
L33$cfg['Servers'][$i]['AllowNoPassword'] = false;
```
Par
```
L33$cfg['Servers'][$i]['AllowNoPassword'] = true;
```
