<div align="center">

# Grobid Trainer

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

</div>

Grobid Trainer est un conteneur Docker basé sur celui de [Grobid](https://hub.docker.com/r/lfoppiano/grobid/) destiné à faciliter l'entraînement des modèles de [Grobid](https://github.com/kermitt2/grobid).

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
