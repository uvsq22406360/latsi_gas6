# Projet GAS6 - Interpréteur LATSI

Projet réalisé dans le cadre de l'UE **Grammaires et Analyse Syntaxique** (L3 Informatique, Université Paris Cité, 2023-2024).

L'objectif est d'implémenter un interpréteur pour le langage **LATSI** (Langage Très Simple d'Instructions) en utilisant **OCaml**, **ocamllex** et **Menhir**.

## Structure du projet

- `ast.ml` : Définition de l'arbre de syntaxe abstraite.
- `lexer.mll` : Analyseur lexical (tokens).
- `parser.mly` : Grammaire et analyseur syntaxique.
- `interpreter.ml` : Gestion de l'environnement (variables A-Z) et exécution des instructions.
- `main.ml` : Point d'entrée du programme.

## Compilation et Exécution

Le projet utilise **dune** pour la compilation.

### Prérequis

- OCaml
- Dune
- Menhir

### Commandes

Pour compiler le projet :

```bash
dune build

```

Pour exécuter un programme LATSI (par exemple `test.txt`) :

```bash
dune exec ./main.exe test.txt

```

## Fonctionnalités réalisées

Nous avons implémenté les étapes 1 à 4 du sujet.

### Syntaxe et Instructions supportées

- **Variables** : Gestion des 26 variables (A-Z) initialisées à 0.

- **Affichage** : `IMPRIME` (expressions arithmétiques et chaînes de caractères) et `NL` (saut de ligne).

- **Conditionnelle** : `SI ... ALORS ...` (avec opérateurs `=`, `<`, `>`, `<=`, `>=`, `<>`).

- **Flux de contrôle** :
- Exécution des lignes par ordre croissant (indépendamment de leur position dans le fichier).

- `VAVERS` (GOTO) vers une ligne calculée dynamiquement.

- Arrêt avec `FIN`.

- **Entrées** : Instruction `ENTREE` pour saisir des valeurs.

- **Commentaires** : `REM`.

### Extensions (Optionnel)

(Coche ou décoche ce que tu as vraiment fait, c'est pour l'étape 4 "Extensions" )

- [ ] Affectations multiples (`X=1, Y=2`).
- [ ] Affectations simultanées (`X,Y = Y,X`).
- [ ] Sous-routines (`SOUSROUTINE` / `RETOURNE`).

---

**Auteurs :**
Ayoub Boussaid
