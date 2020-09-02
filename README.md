

# Pays en chiffre

"Pays en chiffre" est une base de donnée permettant d'observer plusieurs informations autour des population de 135 pays.
## Prérequis

Posséder une instance [elephant](https://customer.elephantsql.com/instance).
Posséder une interface du type [DBeaver](https://dbeaver.io) avec une connexion vers l'instance elephant.


## Installation

Il faut utiliser importer et executer **1_create_everything.sql** dans DBeaver.

Puis importer les données dans **pays.csv** selon une des procédures:

### Exécuter un script préparé

Un fichier **insert_pays.sql** est disponible dans le repository git.
- Ouvrir le fichier **insert_pays.sql** dans DBeaver et exécuter le script.

### En passant par calc
- Ouvrir un nouveau fichier calc *(libre office)*.
- Cliquer sur le menu "<u>F</u>ichier" et "Ouvrir...".
	- et choisir **pays.csv**, cliquer sur "OK".

A présent il est possible de choisir parmi deux méthodes:

#### Utiliser le fichier **create_country.ods** déjà existant.
- Copier et coller les données en **A1**.
- Sur la seconde feuille les données devraient apparaître filtrées.
- Sur la troisième feuille, les requêtes sql sont prêtes à exécuter.
- Copier la colonne **A**.
- Sur DBeaver, ouvrir un nouveau script et sélectionner la base active appropriée.
- Coller et exécuter les requêtes.

#### Insérer les fonctions de filtre et la création des requêtes:
- Créer une nouvelle feuille, la renommer "pays_cleaned".
	- Copier/Coller le traitement suivant en **A1**.
```=SI(ESTVIDE($pays.A2)OU($pays.A2="N.A.");"NULL";SI(ESTNUM(TROUVE(" %"; $pays.A2)) ;SUBSTITUE($pays.A2;" %";"") ; SUBSTITUE($pays.A2;"'";" ")))```
		>J'espère que votre open office est en français.
	- Etendre le traitement jusqu'à la **colonne L** et la **ligne 235**.
	- Ouvrir de nouveau une feuille et coller le traitement suivant en **A1**.
```=CONCAT("insert into public.country (name,population,yearly_change,net_change,density,land_area,migrant,fertility_rate,medium_age,urban_population,world_share,insertion_date) values ('";$pays_cleaned.A2;"',";$pays_cleaned.B2;",";$pays_cleaned.C2;",";$pays_cleaned.D2;",";$pays_cleaned.E2;",";$pays_cleaned.F2;",";$pays_cleaned.G2;",";$pays_cleaned.H2;",";$pays_cleaned.I2;",";$pays_cleaned.J2;",";$pays_cleaned.K2;",";$pays_cleaned.L2;");")```
	- Etendre le traitement jusqu'à la **colonne L** et la **ligne 235**
- Copier la colonne **A** .
- Sur DBeaver, ouvrir un nouveau script et sélectionner la base active appropriée.
- Coller et exécuter les requêtes.

Votre base de donnée est prête *(enfin)* !

## Usage

A présent on peut tester les différents fonctionnalités

-   créer une  **fonction SQL**  qui retourne le pays (sous format de TABLE) qui correspond au critère passé en paramètre. Ce paramètre est le nom du pays.

On teste bêtement la fonction avec la requête suivante
```SQL
SELECT * FROM select_by_name('China');
```
-   créer une  **procédure SQL**  qui insert un nouveau pays avec des données random (on précise uniquement le pays)

La procédure est appelée avec la requête suivante
```SQL
CALL insert_country('Exemple');

SELECT * FROM country WHERE name = 'Exemple';
```
-   configurer un  **trigger**  qui va mettre à jour la colonne de la table correspondant à la date de l'insertion

On peut vérifier le résultat du trigger et de sa fonction associée avec cette requête
```SQL
SELECT * FROM country;
```
-   réaliser une  **fonction ou procédure stoquée**  pour retourner les pays qui sont regroupés par 4 tranches (à definir) de densité de population

Les différents niveaux de densités sont définis en argument tel que défini ci dessous 
```SQL
SELECT * FROM group_by_density(1000, 100, 50)
```