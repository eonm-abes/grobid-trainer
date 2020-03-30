<div align="center">

# Grobid Trainer

</div>

Grobid Trainer est un conteneur Docker basé sur celui de Grobid destiné à faciliter l'entraînement des modèles de Grobid.

## Usage

__Création du conteneur Docker__

```
git clone https://github.com/eonm-abes/grobid-trainer/
cd grobid-trainer
make build
```
Le corpus d'entrainement doit être placé dans le dossier `input/`. Ce dossier est généré automatiquement lors de la création du conteneur docker.

__Lancement du conteneur Docker__

```sh
make run
```

Le lancement du conteneur va créer deux volumes : `input/` et `output/`. Ces volumes permettent d'échanger des données avec le conteneur.

__Lancement de l'entraînement__

```sh
make train
```
Les résultats de l'entraînement se trouvent dans le dossier `output/`

L'ensemble des commandes disponibles sont présentes dans le [Makefile](Makefile) de ce dépôt.
