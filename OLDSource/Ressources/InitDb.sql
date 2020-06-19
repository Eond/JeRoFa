-- ----------------------------------------------------------------------------------------
-- 
-- Script SQL de création de la base de donnée du projet JeRoFa
-- Créé par Jean-François Brun et Jean-Michel Beauvais
-- En date du 4 novembre 2010
-- 
-- Dans le cadre du cours Programmation Orientée Objet II
-- Professeur : Ivan Desjardins
-- 
-- Les copyright vont au cégep de St-Jérôme et aux élèves nommés
--  plus haut.
-- ----------------------------------------------------------------------------------------

-- ----------------------------------------------------------------------------------------
-- Création de la base de données
-- ----------------------------------------------------------------------------------------
CREATE DATABASE IF NOT EXISTS `JeRoFa`;

-- ----------------------------------------------------------------------------------------
-- Tables Principales (A)
-- ----------------------------------------------------------------------------------------

-- Classes

CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblAClasses` (
    `intIDClasse` INT NOT NULL,
    `intDesVie` INT NOT NULL,
    `intNbCompetences` INT NOT NULL,
    `blnPerdToutPreRequis` BOOL NOT NULL,
    `blnNiveauxContinus` BOOL NOT NULL,
    `txtNomClasse` VARCHAR(100) NOT NULL,
    `memDescription` TEXT NULL,
    PRIMARY KEY ( `intIDClasse` )
);

-- Compétences

CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblACompetences` (
    `intIDCompetence` INT NOT NULL,
    `intIDAttribut` INT NOT NULL,
    `txtNomCompetence` VARCHAR(100) NOT NULL,
    `blnPenaliteArmure` BOOLEAN NOT NULL,
    `blnInne` BOOLEAN NOT NULL,
    `memDescription` TEXT NULL,
    PRIMARY KEY ( `intIDCompetence` )
);

-- Dons

CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblADons` (
    `intIDDon` INT NOT NULL,
    `txtNomDon` VARCHAR(100) NOT NULL,
    `memDescription` TEXT NULL,
    PRIMARY KEY ( `intIDDon` )
);

-- États

CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblAEtats` (
    `intIDEtat` INT NOT NULL,
    `txtNomEtat` VARCHAR(100) NOT NULL,
    `memDescription` TEXT NULL,
    PRIMARY KEY ( `intIDEtat` )
);

-- Personnages

CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblAPersonnages` (
    `intIDPersonnage` INT NOT NULL ,
    `intIDSexe` INT NOT NULL,
    `intIDRace` INT NOT NULL,
    `intIDCheveux` INT NOT NULL,
    `intIDYeux` INT NOT NULL,
    `intIDAlignement` INT NOT NULL,
    `intTaille` INT NOT NULL,
    `intPoids` INT NOT NULL,
    `intAge` INT NOT NULL,
    `intPVMax` INT NOT NULL,
    `intPV` INT NOT NULL,
    `intExperience` INT NOT NULL,
    `txtNomPersonnage` VARCHAR(100) NOT NULL,
    `memHistoire` TEXT NULL,
    `memPsychologie` TEXT NULL,
    `memNotes` TEXT NULL,
    PRIMARY KEY ( `intIDPersonnage` )
);

-- Objets

CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblAObjets` (
    `intIDObjet` INT NOT NULL,
    `intIDGrandeur` INT NOT NULL,
    `intIDTempsUtilisation` INT NOT NULL,
    `intIDDuree` INT NOT NULL,
    `intDurabilite` INT NOT NULL,
    `intDurete` INT NOT NULL,
    `intPoids` INT NOT NULL,
    `intTaille` INT NOT NULL,
    `txtNomObjet` VARCHAR(100) NOT NULL,
    `memDescription` TEXT NULL,
    PRIMARY KEY ( `intIDObjet` )
);

-- Sorts

CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblASorts` (
    `intIDSort` INT NOT NULL,
    `intIDTempsUtilisation` INT NOT NULL,
    `intIDDuree` INT NOT NULL,
    `blnAnnulable` BOOL NOT NULL,
    `blnResistMagique` BOOL NOT NULL,
    `txtNomSort` VARCHAR(100) NOT NULL,
    `memDescription` TEXT NULL,
    PRIMARY KEY ( `intIDSort` )
);

-- Races

CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblARaces` (
    `intIDRace` INT NOT NULL,
    `intIDGrandeur` INT NOT NULL,
    `intAgeMax` INT NOT NULL,
    `intAjustementNiveau` INT NOT NULL,
    `blnJouable` BOOL NOT NULL,
    `txtNomRace` VARCHAR(100) NOT NULL,
    `memDescription` TEXT NULL,
    PRIMARY KEY ( `intIDRace` )
);

-- ----------------------------------------------------------------------------------------
-- Début des tables B dites tables secondaires
-- ----------------------------------------------------------------------------------------

-- ----------------------------------------------------------------------------------------
--              tblARaces----tblZSexes-----tblAClasses
CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblBClassesPrivilegiees` (
    `intIDClassePrivilege` INT NOT NULL ,
    `intIDRace` INT NOT NULL ,
    `intIDClasse` INT NOT NULL ,
    `blnSexeImporte` BOOL NOT NULL ,
    `intIDSexe` INT NOT NULL ,
    PRIMARY KEY ( `intIDClassePrivilege` )
);
-- ----------------------------------------------------------------------------------------

-- ----------------------------------------------------------------------------------------
--             tblAClasses-----tblACompétences-----tblZDomaines
CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblBCompDomaine` (
    `intIDCompDomaine` INT NOT NULL ,
    `intIDClasse` INT NOT NULL ,
    `intIDCompetence` INT NOT NULL ,
    `intIDDomaine` INT NOT NULL ,
    PRIMARY KEY ( `intIDCompDomaine` )
);
-- ----------------------------------------------------------------------------------------

-- ----------------------------------------------------------------------------------------
--         tblASorts-----tblYCompoMaterielles-----tblZComposantes
CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblBCompoSort` (
    `intIDCompoSort` INT NOT NULL ,
    `intIDSort` INT NOT NULL ,
    `intIDComposante` INT NOT NULL ,
    `intArgNum` INT NOT NULL ,
    PRIMARY KEY ( `intIDCompoSort` )
);
-- ----------------------------------------------------------------------------------------

-- ----------------------------------------------------------------------------------------
--         tblAPersonnages-----tblYCroyances-----tblYDomainesDieu-----tblYDieuSpheres
CREATE TABLE IF NOT EXISTS  `JeRoFa`.`tblBDieux` (
    `intIDDieu`INT NOT NULL ,
    `intIDPerso` INT NOT NULL ,
    PRIMARY KEY ( `intIDDieu` )
);
-- ----------------------------------------------------------------------------------------

-- ----------------------------------------------------------------------------------------
--         tblADons-----tblYArgumentsDons-----tblZPortees-----tblZTypesEffets-----tblZCibles
CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblBEffetsDons` (
    `intIDEffetDon` INT NOT NULL ,
    `intIDDon` INT NOT NULL ,
    `intIDTypeEffet` INT NOT NULL ,
    `intIDPortee` INT NOT NULL ,
    `intIDCible` INT NOT NULL ,
    PRIMARY KEY ( `intIDEffetDon` )
);
-- ----------------------------------------------------------------------------------------

-- ----------------------------------------------------------------------------------------
--         tblAEtats-----tblYArgumentsEtat-----tblZCibles-----tblZPortees-----tblZTypesEffets
CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblBEffetsEtats` (
    `intIDEffetEtat` INT NOT NULL ,
    `intIDEtat` INT NOT NULL ,
    `intIDCible` INT NOT NULL ,
    `intIDPortee` INT NOT NULL ,
    `intIDTypeEffet` INT NOT NULL ,
    PRIMARY KEY ( `intIDEffetEtat` )
);
-- ----------------------------------------------------------------------------------------

-- ----------------------------------------------------------------------------------------
--         tblAObjets-----tblYArgumentsObjets-----tblZCibles-----tblZPortees-----tblZTypesEffets
CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblBEffetsObjet` (
    `intIDEffetObjet` INT NOT NULL ,
    `intIDObjet` INT NOT NULL ,
    `intIDTypeEffet` INT NOT NULL ,
    `intIDPortee` INT NOT NULL ,
    `intIDCible` INT NOT NULL ,
    PRIMARY KEY ( `intIDEffetObjet` )
);
-- ----------------------------------------------------------------------------------------

-- ----------------------------------------------------------------------------------------
--         tblASorts-----tblYArgumentsSorts-----tbllZArguments-----tblZCibles-----tblZPortees-----tblZTypesEffets
CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblBEffetsSort` (
    `intIDEffetSort` INT NOT NULL ,
    `intIDSort` INT NOT NULL ,
    `intIDTypeEffet` INT NOT NULL ,
    `intIDCible` INT NOT NULL ,
    `intIDPortee` INT NOT NULL ,
    PRIMARY KEY ( `intIDEffetSort` )
);
-- ----------------------------------------------------------------------------------------

-- ----------------------------------------------------------------------------------------
--         tblAObjets-----tblAPersonnages-----tblYContenu
CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblBInventaire` (
    `intIDInventaire` INT NOT NULL ,
    `intIDObjet` INT NOT NULL ,
    `intIDPerso` INT NOT NULL ,
    `memEtat` TEXT NULL ,
    PRIMARY KEY ( `intIDInventaire` )
);
-- ----------------------------------------------------------------------------------------

-- ----------------------------------------------------------------------------------------
--         tblAClasses-----tblZAttributs-----tblZTypesLanceur
CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblBLanceurSort` (
    `intIDLanceurSort` INT NOT NULL ,
    `intIDClasse` INT NOT NULL ,
    `intIDTypeLanceur` INT NOT NULL ,
    `intIDAttribut` INT NOT NULL ,
    PRIMARY KEY ( `intIDLanceurSort`)
);
-- ----------------------------------------------------------------------------------------

-- ----------------------------------------------------------------------------------------
--         tblAClasses-----tblASorts-----tblYPrepSorts-----tblYSortsPerso-----tblZNiveauxSorts
CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblBSortsClasse` (
    `intIDSortClasse` INT NOT NULL ,
    `intIDClasse` INT NOT NULL ,
    `intIDSort` INT NOT NULL ,
    `intIDNiveauSort` INT NOT NULL ,
    PRIMARY KEY ( `intIDSortClasse` )
);
-- ----------------------------------------------------------------------------------------

-- ----------------------------------------------------------------------------------------
--                tblAClasses----- tblZFormules-----tblZStatistiques
CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblBStatsClasses` (
    `intIDStatClasse` INT NOT NULL ,
    `intIDStatistique` INT NOT NULL ,
    `intIDClasse` INT NOT NULL ,
    `intIDFormule` INT NOT NULL ,
    PRIMARY KEY ( `intIDStatClasse` )
);
-- ----------------------------------------------------------------------------------------

-- ----------------------------------------------------------------------------------------
--         tblAObjets-----tblAPersonnages
CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblBVisionsObjets` (
    `intIDVisionObjet` INT NOT NULL ,
    `intIDJoueur` INT NOT NULL ,
    `intIDObjet` INT NOT NULL ,
    `blnNomObjet` BOOL NOT NULL ,
    `blnPoids` BOOL NOT NULL ,
    `blnTaille` BOOL NOT NULL ,
    `blnTempsUtilisation` BOOL NOT NULL ,
    `blnDuree` BOOL NOT NULL ,
    `blnGrandeur` BOOL NOT NULL ,
    `blnDescription` BOOL NOT NULL ,
    `blnEffets` BOOL NOT NULL ,
    `memNotes` BOOL NOT NULL ,
    PRIMARY KEY ( `intIDVisionObjet` )
);
-- ----------------------------------------------------------------------------------------

-- ----------------------------------------------------------------------------------------
--         tblAPersonnages-----tblApersonnages-----tblYVisionsPersoCLasses
CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblBVisionsPersonnages` (
    `intIDVisionPerso` INT NOT NULL ,
    `intIDJoueur` INT NOT NULL ,
    `intIDPersonnage` INT NOT NULL ,
    `blnSexe` BOOL NOT NULL ,
    `blnRace` BOOL NOT NULL ,
    `blnNomPersonnage` BOOL NOT NULL ,
    `blnCheveux` BOOL NOT NULL ,
    `blnYeux` BOOL NOT NULL ,
    `blnTaille` BOOL NOT NULL ,
    `blnPoids` BOOL NOT NULL ,
    `blnAge` BOOL NOT NULL ,
    `blnAlignement` BOOL NOT NULL ,
    `blnSante` BOOL NOT NULL ,
    `memNotes` TEXT NULL ,
    PRIMARY KEY ( `intIDVisionPerso` )
);
-- ----------------------------------------------------------------------------------------

-- ----------------------------------------------------------------------------------------
--         tblAPersonnages-----tblARaces
CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblBVisionsRaces` (
    `intIDVisionRace` INT NOT NULL ,
    `intIDJoueur` INT NOT NULL ,
    `intIDRace` INT NOT NULL ,
    `blnNomRace` BOOL NOT NULL ,
    `blnAgeMax` BOOL NOT NULL ,
    `blnDescription` BOOL NOT NULL ,
    `memNotes` TEXT NULL ,
    PRIMARY KEY ( `intIDVisionRace` )
);
-- ----------------------------------------------------------------------------------------

-- ----------------------------------------------------------------------------------------
--         tblAPersonnages-----tblASorts
CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblBVisionsSorts` (
    `intIDVisionSort` INT NOT NULL ,
    `intIDJoueur` INT NOT NULL ,
    `intIDSort` INT NOT NULL ,
    `blnNomSort` BOOL NOT NULL ,
    `blnResistMagique` BOOL NOT NULL ,
    `blnTempsUtilisation` BOOL NOT NULL ,
    `blnDuree` BOOL NOT NULL ,
    `blnAnnulable` BOOL NOT NULL ,
    `blnEffets` BOOL NOT NULL ,
    `blnComposantes` BOOL NOT NULL ,
    `blnDescription` BOOL NOT NULL ,
    `memNotes` TEXT NULL ,
    PRIMARY KEY ( `intIDVisionSort` )
);
-- ----------------------------------------------------------------------------------------
-- fin Des Tables B
-- ----------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------
-- Tables de liens (Y)
-- ----------------------------------------------------------------------------------------

-- Les ages des races par étape de vie  (tblARaces - tblZEtapesAge)

CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblYAgesRaces` (
    `intIDRace` INT NOT NULL,
    `intIDEtapeAge` INT NOT NULL,
    `intAge` INT NOT NULL,
    PRIMARY KEY ( `intIDRace`, `intIDEtapeAge` )
);

-- Les ages des races par étape de vie  (tblAPersonnages - tblZAlphabets)

CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblYAlphaPerso` (
    `intIDPersonnage` INT NOT NULL,
    `intIDAlphabet` INT NOT NULL,
    PRIMARY KEY ( `intIDPersonnage`, `intIDAlphabet` )
);

-- Les arguments des effets des dons (tblBEffetsDons - tblZArguments)

CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblYArgumentsDon` (
    `intIDEffetDon` INT NOT NULL,
    `intIDArgument` INT NOT NULL,
    `txtArgument` VARCHAR(100) NOT NULL,
    PRIMARY KEY ( `intIDEffetDon`, `intIDArgument` )
);

-- Les arguments des effets des états (tblBEffetsEtats - tblZArguments)

CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblYArgumentsEtat` (
    `intIDEffetEtat` INT NOT NULL,
    `intIDArgument` INT NOT NULL,
    `txtArgument` VARCHAR(100) NOT NULL,
    PRIMARY KEY ( `intIDEffetEtat`, `intIDArgument` )
);

-- Les arguments des effets des objets (tblBEffetsObjet - tblZArguments)

CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblYArgumentsObjets` (
    `intIDEffetObjet` INT NOT NULL,
    `intIDArgument` INT NOT NULL,
    `txtArgument` VARCHAR(100) NOT NULL,
    PRIMARY KEY ( `intIDEffetObjet`, `intIDArgument` )
);

-- Les arguments des effets des sorts (tblBEffetsSort - tblZArguments)

CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblYArgumentSorts` (
    `intIDEffetSort` INT NOT NULL,
    `intIDArgument` INT NOT NULL,
    `txtArguement` VARCHAR(100) NOT NULL,
    PRIMARY KEY ( `intIDEffetSort`, `intIDArgument` )
);

-- Les types d'arguments des types d'effets (tblZTypesEffets - tblZArguments)

CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblYArgumentType` (
    `intIDTypeEffet` INT NOT NULL,
    `intIDArgument` INT NOT NULL,
    `txtValeurDefault` VARCHAR(100) NOT NULL,
    PRIMARY KEY ( `intIDTypeEffet`, `intIDArgument` )
);

-- Les attributs des personnages (tblAPersonnages - tblZAttributs)

CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblYAttributsPerso` (
    `intIDPersonnage` INT NOT NULL,
    `intIDAttribut` INT NOT NULL,
    `intAttribut` INT NOT NULL,
    PRIMARY KEY ( `intIDPersonnage`, `intIDAttribut` )
);

-- Les attributs influant sur les statistiques de classe (tblBStatsClasses - tblZAttributs)

CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblYAttributStats` (
    `intIDStatClasse` INT NOT NULL,
    `intIDAttribut` INT NOT NULL,
    PRIMARY KEY ( `intIDStatClasse`, `intIDAttribut` )
);

-- Les bonus/malus de race aux attributs (tblARaces - tblZAttributs)

CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblYBonusAttributs` (
    `intIDRace` INT NOT NULL,
    `intIDAttribut` INT NOT NULL,
    `intBonus` INT NOT NULL,
    PRIMARY KEY ( `intIDRace`, `intIDAttribut` )
);

-- Les bonus/malus de race aux compétences (tblARaces - tblACompetences)

CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblYBonusCompetences` (
    `intIDRace` INT NOT NULL,
    `intIDCompetence` INT NOT NULL,
    `intBonus` INT NOT NULL,
    PRIMARY KEY ( `intIDRace`, `intIDCompetence` )
);

-- Les bonus/malus de race aux statistiques de classe (tblARaces - tblBStatsClasses)

CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblYBonusStatClasses` (
    `intIDRace` INT NOT NULL,
    `intIDStatClasse` INT NOT NULL,
    `intBonus` INT NOT NULL,
    PRIMARY KEY ( `intIDRace`, `intIDStatClasse` )
);

-- Les couleurs de cheveux possible pour les races (de base) (tblARaces - tblZCheveux)

CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblYCheveuxRaces` (
    `intIDRace` INT NOT NULL,
    `intIDCheveux` INT NOT NULL,
    PRIMARY KEY ( `intIDRace`, `intIDCheveux` )
);

-- Les alignements possible pour une classe (aucun pour tout) (tblAClasses - tblZAlignements)

CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblYClassesAlignements` (
    `intIDClasse` INT NOT NULL,
    `intIDAlignement` INT NOT NULL,
    PRIMARY KEY ( `intIDClasse`, `intIDAlignement` )
);

-- Les classes d'un personnage (aucun pour tout) (tblAClasses - tblAPersonnages)

CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblYClassePerso` (
    `intIDClasse` INT NOT NULL,
    `intIDPersonnage` INT NOT NULL,
    PRIMARY KEY ( `intIDClasse`, `intIDPersonnage` )
);

-- Les compétences de classe des classes (tblAClasses - tblACompetences)

CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblYCompClasse` (
    `intIDClasse` INT NOT NULL,
    `intIDCompetence` INT NOT NULL,
    PRIMARY KEY ( `intIDClasse`, `intIDCompetence` )
);

-- Les compétences de classe des personnages (tblAPersonnages - tblACompetences)

CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblYCompetencesClasse` (
    `intIDPersonnage` INT NOT NULL,
    `intIDCompetence` INT NOT NULL,
    `intPoints` INT NOT NULL,
    PRIMARY KEY ( `intIDPersonnage`, `intIDCompetence` )
);

-- Les compétences hors-classe des personnages (tblAPersonnages - tblACompetences)

CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblYCompetencesHClasse` (
    `intIDPersonnage` INT NOT NULL,
    `intIDCompetence` INT NOT NULL,
    `intPoints` INT NOT NULL,
    PRIMARY KEY ( `intIDPersonnage`, `intIDCompetence` )
);

-- Les composantes matérielles pour les sorts (tblAObjets - tblBCompoSort)

CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblYCompoMaterielles` (
    `intIDCompoSort` INT NOT NULL,
    `intIDObjet` INT NOT NULL,
    PRIMARY KEY ( `intIDCompoSort`, `intIDObjet` )
);

-- Le contenu des contenants de l'inventaire (tblAObjets - tblBInventaire)

CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblYContenu` (
    `intIDInventaire` INT NOT NULL,
    `intIDObjet` INT NOT NULL,
    `intQuantite` INT NOT NULL,
    `memEtat` TEXT NULL,
    PRIMARY KEY ( `intIDInventaire`, `intIDObjet` )
);

-- La (ou les) croyance(s) du personnage (tblAPersonnages - tblBDieux)

CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblYCroyance` (
    `intIDDieu` INT NOT NULL,
    `intIDPersonnage` INT NOT NULL,
    PRIMARY KEY ( `intIDDieu`, `intIDPersonnage` )
);

-- Les objets de départ des classes (tblAObjets - tblAClasses)

CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblYDepartClasse` (
    `intIDClasse` INT NOT NULL,
    `intIDObjet` INT NOT NULL,
    `intQuantite` INT NOT NULL,
    PRIMARY KEY ( `intIDClasse`, `intIDObjet` )
);

-- Les objets de départ des dieux (tblAObjets - tblBDieux)

CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblYDepartDieu` (
    `intIDDieu` INT NOT NULL,
    `intIDObjet` INT NOT NULL,
    `intQuantite` INT NOT NULL,
    PRIMARY KEY ( `intIDDieu`, `intIDObjet` )
);

-- Les objets de départ des races (tblAObjets - tblARaces)

CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblYDepartRace` (
    `intIDRace` INT NOT NULL,
    `intIDObjet` INT NOT NULL,
    `intQuantite` INT NOT NULL,
    PRIMARY KEY ( `intIDRace`, `intIDObjet` )
);

-- Les sphères d'influance des dieux (tblBDieux - tblZSpheresDieux)

CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblYDieuSpheres` (
    `intIDDieu` INT NOT NULL,
    `intIDSphereDieu` INT NOT NULL,
    PRIMARY KEY ( `intIDDieu`, `intIDSphereDieu` )
);

-- Les types de don (tblADons - tblZTypesDons)

CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblYDonType` (
    `intIDDon` INT NOT NULL,
    `intIDTypeDon` INT NOT NULL,
    PRIMARY KEY ( `intIDDon`, `intIDTypeDon` )
);

-- Les domaines du dieu (tblBDieux - tblZDomaines)

CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblYDomainesDieu` (
    `intIDDieu` INT NOT NULL,
    `intIDDomaine` INT NOT NULL,
    PRIMARY KEY ( `intIDDieu`, `intIDDomaine` )
);

-- Les domaines de sorts du personnage (tblAPersonnages - tblZDomaines)

CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblYDomainesPerso` (
    `intIDPersonnage` INT NOT NULL,
    `intIDDomaine` INT NOT NULL,
    PRIMARY KEY ( `intIDPersonnage`, `intIDDomaine` )
);

-- Les écoles de magie abandonnées du personnage (tblAPersonnages - tblZEcoleMagie)

CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblYEcoleAbandonnees` (
    `intIDPersonnage` INT NOT NULL,
    `intIDEcoleMagie` INT NOT NULL,
    PRIMARY KEY ( `intIDPersonnage`, `intIDEcoleMagie` )
);

-- L'école de magie du personnage (tblAPersonnages - tblZEcoleMagie)

CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblYEcoleMage` (
    `intIDPersonnage` INT NOT NULL,
    `intIDEcoleMagie` INT NOT NULL,
    PRIMARY KEY ( `intIDPersonnage`, `intIDEcoleMagie` )
);

-- L'école de magie du sort (tblASorts - tblZEcoleMagie)

CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblYEcoleSort` (
    `intIDSort` INT NOT NULL,
    `intIDEcoleMagie` INT NOT NULL,
    PRIMARY KEY ( `intIDSort`, `intIDEcoleMagie` )
);

-- Les états sur le personnage (tblAEtat - tblAPersonnages)

CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblYEtatsPerso` (
    `intIDPersonnage` INT NOT NULL,
    `intIDEtat` INT NOT NULL,
    PRIMARY KEY ( `intIDPersonnage`, `intIDEtat` )
);

-- Les langues connues du personnage (tblAPersonnages - tblZLangues)

CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblYLanguesPerso` (
    `intIDPersonnage` INT NOT NULL,
    `intIDLangue` INT NOT NULL,
    PRIMARY KEY ( `intIDPersonnage`, `intIDLangue` )
);

-- Les langues de départ des races (tblARaces - tblZLangues)

CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblYLanguesRaceBase` (
    `intIDRace` INT NOT NULL,
    `intIDLangue` INT NOT NULL,
    PRIMARY KEY ( `intIDRace`, `intIDLangue` )
);

-- Les langues bonus des races (tblARaces - tblZLangues)

CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblYLanguesRaceBonus` (
    `intIDRace` INT NOT NULL,
    `intIDLangue` INT NOT NULL,
    PRIMARY KEY ( `intIDRace`, `intIDLangue` )
);

-- Les sorts préparés par le personnage (tblAPersonnages - tblBSortsClasse)

CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblYPrepSorts` (
    `intIDPersonnage` INT NOT NULL,
    `intIDSortClasse` INT NOT NULL,
    `blnUtilise` BOOL NOT NULL,
    PRIMARY KEY ( `intIDPersonnage`, `intIDSortClasse` )
);

-- Les pré-requis pour l'apprentissage d'une classe (tblAClasses - tblZTypesPreRequis)

CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblYPreRequisClasse` (
    `intIDClasse` INT NOT NULL,
    `intIDTypePreRequis` INT NOT NULL,
    `intIDElementPreRequis` INT NOT NULL,
    `intArgNum` INT NOT NULL,
    PRIMARY KEY ( `intIDClasse`, `intIDTypePreRequis` )
);

-- Les pré-requis pour l'apprentissage d'une compétence (tblACompetences - tblZTypesPreRequis)

CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblYPreRequisCompetence` (
    `intIDCompetence` INT NOT NULL,
    `intIDTypePreRequis` INT NOT NULL,
    `intIDElementPreRequis` INT NOT NULL,
    `intArgNum` INT NOT NULL,
    PRIMARY KEY ( `intIDCompetence`, `intIDTypePreRequis` )
);

-- Les pré-requis pour l'apprentissage d'un don (tblADon - tblZTypesPreRequis)

CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblYPreRequisDon` (
    `intIDDon` INT NOT NULL,
    `intIDTypePreRequis` INT NOT NULL,
    `intIDElementPreRequis` INT NOT NULL,
    `intArgNum` INT NOT NULL,
    PRIMARY KEY ( `intIDDon`, `intIDTypePreRequis` )
);

-- Les pré-requis pour l'utilisation OU l'activation d'un objet (tblAObjets - tblZTypesPreRequis)

CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblYPreRequisObjet` (
    `intIDObjet` INT NOT NULL,
    `intIDTypePreRequis` INT NOT NULL,
    `intIDElementPreRequis` INT NOT NULL,
    `intArgNum` INT NOT NULL,
    PRIMARY KEY ( `intIDObjet`, `intIDTypePreRequis` )
);

-- Les fiches de personnage des objets intelligents (tblAObjets - tblAPersonnages)

CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblYObjetIntelligent` (
    `intIDObjet` INT NOT NULL,
    `intIDPersonnage` INT NOT NULL,
    PRIMARY KEY ( `intIDObjet`, `intIDPersonnage` )
);

-- Les sorts connus par classes selon le niveau de classe (tblAClasses - tblZNiveauxSorts)

CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblYSortsConnus` (
    `intIDClasse` INT NOT NULL,
    `intIDNiveauSort` INT NOT NULL,
    `intNbSorts` INT NOT NULL,
    `intNiveauClasse` INT NOT NULL,
    PRIMARY KEY ( `intIDClasse`, `intNiveauClasse` )
);

-- Les sorts par jours par classes selon le niveau de classe (tblAClasses - tblZNiveauxSorts)

CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblYSortsJours` (
    `intIDClasse` INT NOT NULL,
    `intIDNiveauSort` INT NOT NULL,
    `intNbSorts` INT NOT NULL,
    `intNiveauClasse` INT NOT NULL,
    PRIMARY KEY ( `intIDClasse`, `intNiveauClasse` )
);

-- Les sorts connus par le personnage (tblAPersonnages - tblBSortsClasse)

CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblYSortsPerso` (
    `intIDPersonnage` INT NOT NULL,
    `intIDSortClasse` INT NOT NULL,
    PRIMARY KEY ( `intIDPersonnage`, `intIDSortClasse` )
);

-- Les types de sort (tblASorts - tblZTypesSort)

CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblYSortsType` (
    `intIDSort` INT NOT NULL,
    `intIDTypeSort` INT NOT NULL,
    PRIMARY KEY ( `intIDSort`, `intIDTypeSort` )
);

-- Les synergies entre les compétences (tblACompetences - tblACompetences)

CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblYSynergies` (
    `intIDNeedComp` INT NOT NULL,
    `intIDBoostComp` INT NOT NULL,
    `blnConditionnel` BOOL NOT NULL,
    PRIMARY KEY ( `intIDNeedComp`, `intIDBoostComp` )
);

-- Les types qu'un conteneur peut contenir (tblZTypesObjets - tblZTypesObjets)

CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblYTypesContenus` (
    `intIDTypeObjet` INT NOT NULL,
    `intIDTypeContenu` INT NOT NULL,
    PRIMARY KEY ( `intIDTypeObjet`, `intIDTypeContenu` )
);

-- Les types d'un personnage (tblAPersonnages - tblZTypesPersos)

CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblYTypePerso` (
    `intIDPersonnage` INT NOT NULL,
    `intIDTypePersonnage` INT NOT NULL,
    PRIMARY KEY ( `intIDPersonnage`, `intIDTypePersonnage` )
);

-- Les types d'un objet (tblAObjets - tblZTypesObjets)

CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblYTypeObjet` (
    `intIDObjet` INT NOT NULL,
    `intIDTypeObjet` INT NOT NULL,
    PRIMARY KEY ( `intIDObjet`, `intIDTypeObjet` )
);

-- Les types de races (tblARaces - tblZTypesRaces)

CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblYRaceType` (
    `intIDRace` INT NOT NULL,
    `intIDTypeRace` INT NOT NULL,
    PRIMARY KEY ( `intIDRace`, `intIDTypeRace` )
);

-- La vision d'une classe d'un  personnage par un autre personnage (tblAClasses - tblBVisionsPersonnages)

CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblYVisionPersoClasses` (
    `intIDVisionPerso` INT NOT NULL,
    `intIDClasse` INT NOT NULL,
    PRIMARY KEY ( `intIDVisionPerso`, `intIDClasse` )
);

-- Les couleurs d'yeux possible pour les races (de base) (tblARaces - tblZYeux)

CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblYYeuxRace` (
    `intIDRace` INT NOT NULL,
    `intIDYeux` INT NOT NULL,
    PRIMARY KEY ( `intIDRace`, `intIDYeux` )
);

-- ----------------------------------------------------------------------------------------
-- Tables Z, dites "Tables Paramètres "
-- ----------------------------------------------------------------------------------------

-- ----------------------------------------------------------------------------------------
-- Loyal Bon, Neutre Mauvais, Chaotique Neutre...
CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblZAlignements` (
    `intIDAlignement` INT NOT NULL ,
    `txtAlignement` VARCHAR( 100 ) NOT NULL ,
    `memDescription` TEXT NULL,
    PRIMARY KEY ( `intIDAlignement` )
);
-- ----------------------------------------------------------------------------------------

-- ----------------------------------------------------------------------------------------
-- Druidique, elfe,Infernal... ne pas confondre avec la langue!
CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblZAlphabets` (
    `intIDAlphabet` INT NOT NULL ,
    `txtNomAlphabet` VARCHAR( 100 ) NOT NULL ,
    `memDescription` TEXT NULL ,
    PRIMARY KEY ( `intIDAlphabet` )
);
-- ----------------------------------------------------------------------------------------

-- ----------------------------------------------------------------------------------------
-- Argument d'effet EX: Dés(d6), Fixe(4), Décimal(1.5)
CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblZArguments` (
    `intIDArgument` INT NOT NULL ,
    `txtArgument` VARCHAR( 100 ) NOT NULL ,
    `memDescription` TEXT NULL ,
    PRIMARY KEY ( `intIDArgument` )
);
-- ----------------------------------------------------------------------------------------

-- ----------------------------------------------------------------------------------------
-- Force(FOR) ,Sagesse(SAG),....
CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblZAttributs` (
    `intIDAttribut` INT NOT NULL ,
    `txtNomAttribut` VARCHAR( 100 ) NOT NULL ,
    `txtAbbrAttribut` VARCHAR( 100 ) NOT NULL ,
    `blnPhysique` BOOLEAN NOT NULL ,
    `memDescription` TEXT NULL,
    PRIMARY KEY ( `intIDAttribut` )
);
-- ----------------------------------------------------------------------------------------

-- ----------------------------------------------------------------------------------------
-- Couleur de cheveux EX: Rouge , Blond, Brun....
CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblZCheveux` (
    `intIDCheveux` INT NOT NULL ,
    `txtNomCheveux` VARCHAR( 100 ) ,
    `memDescription` TEXT NULL ,
    PRIMARY KEY ( `intIDCheveux` )
);
-- ----------------------------------------------------------------------------------------

-- ----------------------------------------------------------------------------------------
-- Personnel, Multiple,Zone, Rayon.....
CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblZCibles` (
    `intIDCible`INT NOT NULL ,
    `txtNomCible` VARCHAR( 100 ) NOT NULL ,
    `intArgNum` INT NOT NULL ,
    `memDescription`TEXT NULL,
    PRIMARY KEY ( `intIDCible` )
);
-- ----------------------------------------------------------------------------------------

-- ----------------------------------------------------------------------------------------
-- Verbales, Somatiques, Matérielles....
CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblZComposantes` (
    `intIDComposante` INT NOT NULL ,
    `txtNomComposante` VARCHAR( 100 ) NOT NULL ,
    `memDescription` TEXT NULL ,
    PRIMARY KEY ( `intIDComposante` )
);
-- ----------------------------------------------------------------------------------------

-- ----------------------------------------------------------------------------------------
-- Nombre d'objets de départs  
CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblZDepartObjets` (
    `intIDObjet` INT NOT NULL ,
    `intQuantite` INT NOT NULL ,
    PRIMARY KEY ( `intIDObjet` )
);
-- ----------------------------------------------------------------------------------------

-- ----------------------------------------------------------------------------------------
-- Soleil, Guérison, Destruction, Mal....
CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblZDomaines` (
    `intIDDomaine`INT NOT NULL ,
    `txtNomDomaine` VARCHAR( 100 ) NOT NULL ,
    `memDescription` TEXT NULL ,
    PRIMARY KEY ( `intIDDomaine` )
);
-- ----------------------------------------------------------------------------------------

-- ----------------------------------------------------------------------------------------
-- Concentration, Immédiat, Permanent...
CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblZDurees` (
    `intIDDuree` INT NOT NULL ,
    `txtDuree` VARCHAR( 100 ) NOT NULL ,
    `intCodeDuree` INT NOT NULL ,
    `memDescription` TEXT NULL ,
    PRIMARY KEY ( `intIDDuree` )
);
-- ----------------------------------------------------------------------------------------

-- ----------------------------------------------------------------------------------------
-- Évocation, Universelle...
CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblZEcoleMagie` (
    `intIDEcoleMagie` INT NOT NULL ,
    `txtNomEcoleMagie` VARCHAR( 100 ) NOT NULL ,
    `blnEcoleAbandonnable` BOOL NOT NULL ,
    `memDescription` TEXT NULL ,
    PRIMARY KEY( `intIDEcoleMagie` )
);
-- ----------------------------------------------------------------------------------------

-- ----------------------------------------------------------------------------------------
-- Adulte, Âge moyen, Vieux, Vénérable...
CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblZEtapesAge` (
    `intIDEtapeAge`INT NOT NULL ,
    `txtNomEtapeAge` VARCHAR( 100 ) NOT NULL ,
    `memDescription` TEXT NULL ,
    PRIMARY KEY ( `intIDEtapeAge` )
);
-- ----------------------------------------------------------------------------------------

-- ----------------------------------------------------------------------------------------
-- X, (X/2)-1, etc....
CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblZFormules` (
    `intIDFormule` INT NOT NULL ,
    `txtFormule` VARCHAR( 100 ) NOT NULL ,
    `memDescription` TEXT NULL ,
    PRIMARY KEY ( `intIDFormule` )
);
-- ----------------------------------------------------------------------------------------

-- ----------------------------------------------------------------------------------------
-- Minuscule, Colossal, Moyen...
CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblZGrandeurs` (
    `intIDGrandeur` INT NOT NULL ,
    `txtNomGrandeur` VARCHAR( 100 ) NOT NULL ,
    `intNumeroGrandeur` INT NOT NULL ,
    `memDescription` TEXT NULL ,
    PRIMARY KEY ( `intIDGrandeur` )
);
-- ----------------------------------------------------------------------------------------

-- ----------------------------------------------------------------------------------------
-- Commun Gnome, Nain, Elfe....
CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblZLangues` (
    `intIDLangue` INT NOT NULL ,
    `txtNomLangue` VARCHAR( 100 ) NOT NULL ,
    `intIDAlphabet` INT NOT NULL , 
    `memDescription` TEXT NULL ,
    PRIMARY KEY ( `intIDLangue` )
);
-- ----------------------------------------------------------------------------------------

-- ----------------------------------------------------------------------------------------
-- 0,1,2,3,4,5,6,7,8,9
CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblZNiveauxSorts` (
    `intIDNiveauSort` INT NOT NULL ,
    `intNiveauSort` INT NOT NULL ,
    `memDescription` TEXT NULL ,
    PRIMARY KEY ( `intIDNiveauSort`)
);
-- ----------------------------------------------------------------------------------------

-- ----------------------------------------------------------------------------------------
-- Personnel, Touché, Moyen, Loin, Plan, Fixe.....
CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblZPortees` (
    `intIDPortee` INT NOT NULL ,
    `txtNomPortee` VARCHAR( 100 ) NOT NULL ,
    `intDistance` INT NOT NULL ,
    `memDescription` TEXT NULL ,
    PRIMARY KEY ( `intIDPortee` )
);
-- ----------------------------------------------------------------------------------------

-- ----------------------------------------------------------------------------------------
-- Mâle ,Femelle
CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblZSexes` (
    `intIDSexe` INT NOT NULL ,
    `txtNomSexe` VARCHAR( 100 ) NOT NULL ,
    `memDescription` TEXT NULL ,
    PRIMARY KEY ( `intIDSexe` )
);
-- ----------------------------------------------------------------------------------------

-- ----------------------------------------------------------------------------------------
-- Elfe, Humain, Magie....
CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblZSpheresDieux` (
    `intIDSphereDieu` INT NOT NULL ,
    `txtNomSphereDieu` VARCHAR( 100 ) NOT NULL ,
    `memDescription` TEXT NULL ,
    PRIMARY KEY ( `intIDSphereDieu` )
);
-- ----------------------------------------------------------------------------------------

-- ----------------------------------------------------------------------------------------
-- Bonus de base à l'attaque , reflex, vigueur , volontée, etc
CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblZStatistiques` (
    `intIDStatistique` INT NOT NULL ,
    `txtNomStatistique` VARCHAR( 100 ) NOT NULL ,
    `memDescription` TEXT NULL ,
    PRIMARY KEY ( `intIDStatistique` )
);
-- ----------------------------------------------------------------------------------------

-- ----------------------------------------------------------------------------------------
-- Action standard, Tour Complet, Action gratuite.....
CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblZTempsUtilisation` (
    `intIDTempsUtilisation` INT NOT NULL ,
    `txtNomTempsUtilisation` VARCHAR( 100 ) NOT NULL ,
    `intTempsUtilisation` INT NOT NULL ,
    `memDescription`TEXT NULL ,
    PRIMARY KEY ( `intIDTempsUtilisation` )
);
-- ----------------------------------------------------------------------------------------

-- ----------------------------------------------------------------------------------------
-- Don de guerrier, Métamagie, Création d'objets, Général
CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblZTypesDons` (
    `intIDTypeDon` INT NOT NULL ,
    `txtNomTypeDon` VARCHAR( 100 ) ,
    `blnTypeGeneral` BOOL NOT NULL ,
    `memDescription` TEXT NULL ,
    PRIMARY KEY ( `intIDTypeDon` )
);
-- ----------------------------------------------------------------------------------------

-- ----------------------------------------------------------------------------------------
-- Dégats , ajout d'état, retirer un état, Amélioration d'un attribut
CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblZTypesEffets` (
    `intIDTypeEffet` INT NOT NULL ,
    `txtNomTypeEffet` VARCHAR( 100 ) NOT NULL ,
    `intNbArguments` INT NOT NULL ,
    `memDescription`TEXT NULL ,
    PRIMARY KEY ( `intIDTypeEffet` )
);
-- ----------------------------------------------------------------------------------------

-- ----------------------------------------------------------------------------------------
-- Arcane ,Divin
CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblZTypesLanceur` (
    `intIDTypeLanceur` INT NOT NULL ,
    `txtNomTypeLanceur` VARCHAR( 100 ) NOT NULL ,
    `memDescription` TEXT NULL ,
    PRIMARY KEY ( `intIDTypeLanceur` )
);
-- ----------------------------------------------------------------------------------------

-- ----------------------------------------------------------------------------------------
-- Maudit, arme sac, livre
CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblZTypesObjets` (
    `intIDTypeObjet` INT NOT NULL ,
    `txtNomTypeObjet` VARCHAR( 100 ) NOT NULL ,
    `blnConteneur` BOOL NOT NULL ,
    `memDescription` TEXT NULL ,
    PRIMARY KEY( `intIDTypeObjet` )
);
-- ----------------------------------------------------------------------------------------

-- ----------------------------------------------------------------------------------------
-- PNJ, Joueur, Objet
CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblZTypesPersos` (
    `intIDTypePerso` INT NOT NULL ,
    `txtNomTypePerso` VARCHAR( 100 ) NOT NULL ,
    `memDescription` TEXT NULL ,
    PRIMARY KEY ( `intIDTypePerso` )
);
-- ----------------------------------------------------------------------------------------

-- ----------------------------------------------------------------------------------------
-- BAB, Niveau global, abilitée spéciale, etc.... * 
CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblZTypesPreRequis` (
    `intIDTypePreRequis` INT NOT NULL ,
    `txtNomTypePreRequis` VARCHAR( 100 ) NOT NULL ,
    `memDescription` TEXT NULL ,
    PRIMARY KEY ( `intIDTypePreRequis` )
);
-- ----------------------------------------------------------------------------------------

-- ----------------------------------------------------------------------------------------
-- Humanoide, aberration
CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblZTypesRaces` (
    `intIDTypeRace` INT NOT NULL ,
    `txtNomTypeRace` VARCHAR( 100 ) NOT NULL ,
    `memDescription` TEXT NULL ,
    PRIMARY KEY ( `intIDTypeRace` )
);
-- ----------------------------------------------------------------------------------------

-- ----------------------------------------------------------------------------------------
-- Acide ,Feu Bien Chaos
CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblZTypesSort` (
    `intIDTypeSort` INT NOT NULL ,
    `txtNomTypeSort` VARCHAR( 100 ) NOT NULL ,
    `memDescription` TEXT NULL ,
    PRIMARY KEY ( `intIDTypeSort` )
);
-- ----------------------------------------------------------------------------------------

-- ----------------------------------------------------------------------------------------
-- Bleu Marron, Jaune, Rouge, Blanc
CREATE TABLE IF NOT EXISTS `JeRoFa`.`tblZYeux` (
    `intIDYeux` INT NOT NULL ,
    `txtNomYeux` VARCHAR( 100 ) NOT NULL ,
    PRIMARY KEY ( `intIDYeux` ) 
);
-- ----------------------------------------------------------------------------------------

-- ----------------------------------------------------------------------------------------
-- Fin des tables Z
-- ----------------------------------------------------------------------------------------

-- ----------------------------------------------------------------------------------------
-- Données --------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------
-- Filling J-F
-- ----------------------------------------------------------------------------------------
-- Table Des temps d'utilisations
REPLACE INTO `JeRoFa`.`tblZTempsUtilisation` (
    `intIDTempsUtilisation` ,
    `txtNomTempsUtilisation` ,
    `intTempsUtilisation` ,
    `memDescription`
) VALUES (
    '1', 'Standard', '1', ''
),(
    '2', 'Mouvement', '0', ''
),(
    '3', 'Tour complet', '2', ''
),(
    '4', 'Gratuite', '-1', ''
),(
    '5', 'Rapide', '-2', ''
),(
    '6', 'Immédiate', '-3', ''
),(
    '7', 'Nulle', '-4', ''
);
-- table des durées
REPLACE INTO `JeRoFa`.`tblZDurees` (
    `intIDDuree` ,
    `txtDuree` ,
    `intCodeDuree` ,
    `memDescription`
) VALUES (
    '1', 'Instantané','0',""
),(
    '2', 'Permanent','-2',""
),(
    '3', 'Concentration','-1',""
);
-- Tables des Races
REPLACE INTO `JeRoFa`.`tblARaces` (
`intIDRace` ,
`txtNomRace` ,
`intIDGrandeur` ,
`intAgeMax` ,
`blnJouable` ,
`intAjustementNiveau` ,
`memDescription`
) VALUES (
    '1', 'Humain', '1', '110', '-1', '0', ""
),(
    '2', 'Elfe', '1', '750', '-1', '0', ""
),(
    '3', 'Nain', '1', '450', '-1', '0', ""
);
-- table des grandeurs
REPLACE INTO `JeRoFa`.`tblZGrandeurs` (
    `intIDGrandeur` ,
    `txtNomGrandeur` ,
    `intNumeroGrandeur` ,
    `memDescription`
) VALUES (
    '1', 'Moyen', '0', ""
),(
    '2', 'Petit', '-1', ""
),(
    '3', 'Grand', '1', ""
),(
    '4', 'Énorme', '2', ""
),(
    '5', 'Gargantuesque', '3', ""
),(
    '6', 'Colossal', '4', ""
),(
    '7', 'Très Petit', '-2', ""
),(
    '8', 'Minuscule', '-3', ""
),(
    '9', 'Infime', '-4', ""
);
-- Table des étapes d'âge
REPLACE INTO `JeRoFa`.`tblZEtapesAge` (
    `intIDEtapeAge` ,
    `txtNomEtapeAge` , 
    `memDescription`
) VALUES (
    '1', 'Adulte', ""
),(
    '2', 'Age Moyen', ""
),(
    '3', 'Vieux', ""
),(
    '4', 'Vénérable', ""
);
-- Table des Ages par races
REPLACE INTO `JeRoFa`.`tblYAgesRaces` (
    `intIDRace` ,
    `intIDEtapeAge` , 
    `intAge`
) VALUES (
    '1', '1', '15' 
),(
    '1', '2', '35'
),(
    '1', '3', '53'
),(
    '1', '4', '70'
),(
    '2', '1', '110'
),(
    '2', '2', '175'
),(
    '2', '3', '263'
),(
    '2', '4', '350'
),(
    '3', '1', '40'
),(
    '3', '2', '125'
),(
    '3', '3', '188'
),(
    '3', '4', '250'
);
-- table de yeux
REPLACE INTO `JeRoFa`.`tblZYeux` (
    `intIDYeux` ,
    `txtNomYeux` 
) VALUES (
    '1', 'Bleu'
),(
    '2', 'Vert'
),(
    '3', 'Marron'
),(
    '4', 'Noir'
);
-- table de yeux de race
REPLACE INTO `JeRoFa`.`tblYYeuxRace` (
    `intIDRace` ,
    `intIDYeux`
) VALUES (
    '1', '1' 
),(
    '1', '2'
),(
    '1', '3'
),(
    '2', '1'
),(
    '2', '2'
),(
    '3', '3'
),(
    '3', '4'
);
-- table de type de race
REPLACE INTO `JeRoFa`.`tblZTypesRaces` (
    `intIDTypeRace` ,
    `txtNomTypeRace` ,
    `memDescription`
) VALUES (
    '1', 'Humanoïde',""
);
-- table de type de races associées
REPLACE INTO `JeRoFa`.`tblYRaceType` (
    `intIDRace` ,
    `intIDTypeRace` 
) VALUES (
    '1', '1'
),( 
    '2', '1'
),( 
    '2', '1'
);
-- table des alphabets
REPLACE INTO `JeRoFa`.`tblZAlphabets` (
    `intIDAlphabet` ,
    `txtNomAlphabet` ,
    `memDescription`
) VALUES (
    '1', 'Infernal',""
),(
    '2', 'Elfe',""
),(
    '3', 'Draconique',""
),(
    '4', 'Céleste',""
),(
    '5', 'Commun',""
),(
    '6', 'Nain',""
),(
    '7', 'Druidique',""
);
-- table des langues
REPLACE INTO `JeRoFa`.`tblZLangues` (
    `intIDLangue` ,
    `txtNomLangue` ,
    `intIDAlphabet` ,
    `memDescription`
) VALUES (
    '1', 'Abyssal','1',""
),(
    '2', 'Aquan','2',""
),(
    '3', 'Auran','3',""
),(
    '4', 'Céleste','4',""
),(
    '5', 'Commun','5',""
),(
    '6', 'Draconique','3',""
),(
    '7', 'Druidique','7',""
),(
    '8', 'Nain','6',""
),(
    '9', 'Elfe','2',""
),(
    '10', 'Géant','6',""
),(
    '11', 'Gnome','6',""
),(
    '12', 'Goblin','6',""
),(
    '13', 'Gnoll','5',""
),(
    '14', 'Halfelin','5',""
),(
    '15', 'Ignan','3',""
),(
    '16', 'Infernal','1',""
),(
    '17', 'Orque','6',""
),(
    '18', 'Sylvain','2',""
),(
    '19', 'Terran','6',""
),(
    '20', 'Commun des Profondeurs','2',""
);
-- table des langues par race de base
REPLACE INTO `JeRoFa`.`tblYLanguesRaceBase` (
    `intIDRace` ,
    `intIDLangue` 
) VALUES (
    '1', '5'
),( 
    '2', '5'
),( 
    '2', '9'
),( 
    '3', '5'
),( 
    '3', '8'
);
-- table des langues  bonus par race
REPLACE INTO `JeRoFa`.`tblYLanguesRaceBonus` (
    `intIDRace` ,
    `intIDLangue` 
) VALUES (
    '1', '1'
),( 
    '1', '2'
),( 
    '1', '3'
),( 
    '1', '4'
),( 
    '1', '6'
),( 
    '1', '8'
),( 
    '1', '9'
),( 
    '1', '10'
),( 
    '1', '11'
),( 
    '1', '12'
),( 
    '1', '13'
),( 
    '1', '14'
),( 
    '1', '15'
),( 
    '1', '16'
),( 
    '1', '17'
),( 
    '1', '18'
),( 
    '1', '19'
),( 
    '1', '20'
),( 
    '2', '6'
),( 
    '2', '11'
),( 
    '2', '12'
),( 
    '2', '13'
),( 
    '2', '17'
),( 
    '2', '18'
),( 
    '3', '10'
),( 
    '3', '11'
),( 
    '3', '12'
),( 
    '3', '17'
),( 
    '3', '19'
),( 
    '3', '20'
);
-- table des couleurs de cheveux
REPLACE INTO `JeRoFa`.`tblZCheveux` (
    `intIDCheveux` ,
    `txtNomCheveux` ,
    `memDescription` 
) VALUES (
    '1', 'Blond', ""
),(
    '2', 'Brun', ""
),(
    '3', 'Noir', ""
),(
    '4', 'Roux', ""
);
-- tables des couleurs de cheveux de race
REPLACE INTO `JeRoFa`.`tblYCheveuxRaces` (
    `intIDRace` ,
    `intIDCheveux` 
) VALUES (
    '1', '1'
),( 
    '1', '2'
),( 
    '1', '3'
),( 
    '1', '4'
),( 
    '2', '1'
),( 
    '2', '3'
),( 
    '3', '2'
),( 
    '3', '3'
),( 
    '3', '4'
);
-- table des sexes
REPLACE INTO `JeRoFa`.`tblZSexes` (
    `intIDSexe` ,
    `txtNomSexe` ,
    `memDescription`
) VALUES (
    '1', 'Male',""
),(
    '2', 'Femelle',""
);
-- table des types d'objets
REPLACE INTO `JeRoFa`.`tblZTypesObjets` (
    `intIDTypeObjet` ,
    `txtNomTypeObjet` ,
    `blnConteneur` ,
    `memDescription`
) VALUES (
    '1', 'Armure','0',""
),(
    '2', 'à deux mains','0',""
),(
    '3', 'Potion','0',""
),(
    '4', 'Huile','0',""
),(
    '5', 'Anneau','0',""
),(
    '6', 'Nourriture','0',""
),(
    '7', 'Parchemin','0',""
),(
    '8', 'Clé','0',""
),(
    '9', 'Sac','-1',""
),(
    '10', 'Livre','-1',""
),(
    '11', 'Arme','0',""
),(
    '12', 'Magique','0',""
),(
    '13', 'Percante','0',""
),(
    '14', 'Tranchante','0',""
),(
    '15', 'Contondante','0',""
),(
    '16', 'Naturelle','0',""
),(
    '17', 'à projectile','0',""
),(
    '18', 'Bouclier','0',""
),(
    '19', 'projectile','0',""
);
-- table des objets contenus
REPLACE INTO `JeRoFa`.`tblYTypesContenus` (
    `intIDTypeObjet` ,
    `intIDtypeContenu` 
) VALUES (
    '9', '1'
),(
    '9', '2'
),(
    '9', '3'
),(
    '9', '4'
),(
    '9', '5'
),(
    '9', '6'
),(
    '9', '7'
),(
    '9', '8'
),(
    '9', '9'
),(
    '9', '10'
),(
    '10', '7'
),(
    '10', '8'
);
-- table des objets
REPLACE INTO `JeRoFa`.`tblAObjets` (
    `intIDObjet` ,
    `txtNomObjet` ,
    `intDurabilite` ,
    `intDurete` ,
    `intPoids` ,
    `intTaille` ,
    `intIDTempsUtilisation` ,
    `intIDDuree` ,
    `intIDGrandeur` ,
    `memDescription` 
) VALUES (
        '1', 'Arc court'        ,'5' ,'5' ,'15','3' ,'5','1','1',""
),(
        '2', 'Épée courte'      ,'5' ,'10','2' ,'10','1' ,'1','1',""
),(
        '3', 'Épée à deux mains','10','10','8' ,'20','1' ,'1','1',""
),(
        '4', 'Armure de cuir'   ,'10','2' ,'15','10','7' ,'1','1',""
),(
        '5', 'Bouclier de bois' ,'7' ,'5' ,'5' ,'5' ,'7' ,'1','1',""
),(
        '6', 'Flèche en argent' ,'1' ,'1' ,'0' ,'1' ,'1' ,'1','1',""
),(
        '7', 'Livre'            ,'0' ,'2' ,'3' ,'2' ,'1' ,'1','1',""
);
-- table des types d'objets
REPLACE INTO `JeRoFa`.`tblYTypeObjet` (
    `intIDObjet` ,
    `intIDTypeObjet` 
) VALUES (
    '1', '11'
),(
    '1', '15'
),(
    '1', '17'
),(
    '2', '11'
),(
    '2', '13'
),(
    '2', '14'
),(
    '3', '11'
),(
    '3', '2'
),(
    '3', '13'
),(
    '3', '14'
),(
    '4', '1'
),(
    '5', '18'
),(
    '5', '15'
),(
    '6', '19'
),(
    '6', '13'
),(
    '7', '10'
),(
    '7', '15'
);
-- ----------------------------------------------------------------------------------------
-- Filling J-M
-- ----------------------------------------------------------------------------------------
-- Tables A
-- ----------------------------------------------------------------------------------------



REPLACE INTO `JeRoFa`.`tblASorts` (
    `intIDSort`,
    `intIDTempsUtilisation`,
    `intIDDuree`,
    `blnAnnulable`,
    `blnResistMagique`,
    `txtNomSort`,
    `memDescription`
) VALUES (
    '1', '1', '0', '0', '0', "Création d'eau", ""
), (
    '2', '1', '0', '0', '-1', "Guérison de blessures mineures", ""
), (
    '3', '1', '-1', '-1', '0', "Détection de la magie", ""
), (
    '4', '1', '0', '0', '0', "Détection des poisons", ""
), (
    '5', '1', '10', '0', '-1', "Guidance", ""
), (
    '6', '1', '0', '0', '-1', "Blessure mineure", ""
), (
    '7', '1', '100', '-1', '0', "Lumière", ""
), (
    '8', '1', '0', '0', '-1', "Réparations", ""
), (
    '9', '1', '0', '0', '-1', "Purification de l'eau et de la nourriture", ""
), (
    '10', '1', '100', '0', '-1', "Lecture de la magie", ""
), (
    '11', '1', '10', '0', '-1', "Résistance", ""
), (
    '12', '1', '10', '0', '-1', "Vertue", ""
), (
    '13', '1', '1', '0', '-1', "Étourdissement", ""
), (
    '14', '1', '10', '-1', '0', "Lumières dansantes", ""
), (
    '15', '1', '0', '0', '-1', "Éclat", ""
), (
    '16', '1', '0', '0', '-1', "Rayon de givre", ""
), (
    '17', '1', '10', '-1', '0', "Sons fantômes", ""
), (
    '18', '1', '0', '0', '-1', "Dérangement de mort-vivant", ""
), (
    '19', '1', '10', '0', '-1', "Touché de fatigue", ""
), (
    '20', '1', '-1', '0', '0', "Main de mage", ""
), (
    '21', '1', '100', '0', '0', "Message", ""
), (
    '22', '1', '0', '0', '-1', "Ouvrir/Fermer", ""
), (
    '23', '1', '-2', '0', '0', "Marque arcane", ""
), (
    '24', '1', '600', '0', '0', "Prestidigitation", ""
), (
    '25', '1', '0', '0', '0', "Éclaboussure acide", ""
);
-- ----------------------------------------------------------------------------------------
-- Tables Y
-- ----------------------------------------------------------------------------------------

REPLACE INTO `JeRoFa`.`tblYSynergies` (
    `intIDNeedComp`,
    `intIDBoostComp`,
    `blnConditionnel`
) VALUES (
    '3', '10', '0'
), (
    '3', '1', '-1'
), (
    '3', '19', '0'
), (
    '3', '35', '0'
), (
    '6', '1', '-1'
), (
    '7', '1', '-1'
), (
    '8', '1', '-1'
), (
    '9', '42', '-1'
), (
    '13', '43', '-1'
), (
    '16', '32', '0'
), (
    '20', '41', '0'
), (
    '21', '37', '0'
), (
    '23', '15', '0'
), (
    '25', '39', '-1'
), (
    '33', '39', '-1'
), (
    '34', '10', '0'
), (
    '37', '42', '-1'
), (
    '41', '2', '0'
), (
    '41', '20', '0'
), (
    '42', '37', '-1'
), (
    '43', '4', '-1'
), (
    '43', '13', '-1'
);

-- ----------------------------------------------------------------------------------------
-- Tables Z
-- ----------------------------------------------------------------------------------------

REPLACE INTO `JeRoFa`.`tblZAttributs` (
    `intIDAttribut`,
    `txtNomAttribut`,
    `txtAbbrAttribut`,
    `blnPhysique`,
    `memDescription`
) VALUES (
    '1', 'Force', 'FOR', '-1', ''
),(
    '2', 'Dexterité', 'DEX', '-1', ''
),(
    '3', 'Constitution', 'CON', '-1', ''
),(
    '4', 'Intelligence', 'INT', '0', ''
),(
    '5', 'Sagesse', 'SAG', '0', ''
),(
    '6', 'Charisme', 'CHA', '0', ''
);

REPLACE INTO `JeRoFa`.`tblZFormules` (
    `intIDFormule`,
    `txtFormule`,
    `memDescription`
) VALUES (
    '1', 'X', "Bonus de base à l'attaque : Fort"
), (
    '2', 'FLOOR(0.75*X)', "Bonus de base à l'attaque : Moyen"
), (
    '3', 'FLOOR(X/2)', "Bonus de base à l'attaque : Faible"
), (
    '4', 'FLOOR(X/2)+2', "Jet de sauvegarde : Fort"
), (
    '5', 'FLOOR(X/3)', "Jet de sauvegarde : Faible"
);

REPLACE INTO `JeRoFa`.`tblZTypesSort` (
    `intIDTypeSort`,
    `txtNomTypeSort`,
    `memDescription`
) VALUES (
    '1', 'Acide', ""
), (
    '2', 'Air', ""
), (
    '3', 'Chaotique', ""
), (
    '4', 'Froid', ""
), (
    '5', 'Noirceur', ""
), (
    '6', 'Mort', ""
), (
    '7', 'Terre', ""
), (
    '8', 'Électricité', ""
), (
    '9', 'Mal', ""
), (
    '10', 'Peur', ""
), (
    '11', 'Feu', ""
), (
    '12', 'Force', ""
), (
    '13', 'Bien', ""
), (
    '14', 'Dépendant de la langue', ""
), (
    '15', 'Loi', ""
), (
    '16', 'Lumière', ""
), (
    '17', 'Mental', ""
), (
    '18', 'Sonique', ""
), (
    '19', 'Eau', ""
);
-- Table des Alignements
REPLACE INTO `JeRoFa`.`tblZAlignements` (
	`intIDAlignement` ,
	`txtAlignement` , 
	`memDescription`
) VALUES (
	'1', 'Loyal Bon', ""
),(
	'2', 'Neutre Bon', ""
),(
	'3', 'Chaotique Bon', ""
),(
	'4', 'Loyal Neutre', ""
),(
	'5', 'Neutre', ""
),(
	'6', 'Chaotique Neutre', ""
),(
	'7', 'Loyal Mauvais', ""
),(
	'8', 'Neutre Mauvais', ""
),(
	'9', 'Chaotique Mauvais', ""
);
-- table identifiant les lanceurs de sorts et leurs attributs
REPLACE INTO `JeRoFa`.`tblBLanceurSort` (
	`intIDLanceurSort` ,
	`intIDClasse` ,
	`intIDTypeLanceur` ,
	`intIDAttribut`
) VALUES (
	'1', '1', '2', '5'
),(
	'2', '2', '1', '4'
),(
	'3', '3', '1', '6'
),(
	'4', '6', '2', '5'
);
-- table des alignements par classe
REPLACE INTO `JeRoFa`.`tblYClassesAlignements` (
	`intIDClasse` ,
	`intIDAlignement`
) VALUES (
	'1', '1'
),(	
	'1', '2'
),(	
	'1', '3'
),(
	'1', '4'
),(
	'1', '5'
),(
	'1', '6'
),(
	'1', '7'
),(
	'1', '8'
),(
	'1', '9'
),(	
	'2', '1'
),(	
	'2', '2'
),(	
	'2', '3'
),(
	'2', '4'
),(
	'2', '5'
),(
	'2', '6'
),(
	'2', '7'
),(
	'2', '8'
),(
	'2', '9'
),(
	'3', '1'
),(	
	'3', '2'
),(	
	'3', '3'
),(
	'3', '4'
),(
	'3', '5'
),(
	'3', '6'
),(
	'3', '7'
),(
	'3', '8'
),(
	'3', '9'
),(
	'4', '1'
),(	
	'4', '2'
),(	
	'4', '3'
),(
	'4', '4'
),(
	'4', '5'
),(
	'4', '6'
),(
	'4', '7'
),(
	'4', '8'
),(
	'4', '9'
),(
	'5', '1'
),(	
	'5', '2'
),(	
	'5', '3'
),(
	'5', '4'
),(
	'5', '5'
),(
	'5', '6'
),(
	'5', '7'
),(
	'5', '8'
),(
	'5', '9'
),(
	'6', '1'
),(	
	'6', '2'
),(	
	'6', '3'
),(
	'6', '4'
),(
	'6', '5'
),(
	'6', '6'
),(
	'6', '7'
),(
	'6', '8'
),(
	'6', '9'
);
-- table des compétences de domaine
REPLACE INTO `JeRoFa`.`tblBCompDomaine` (
	`intIDCompDomaine` ,
	`intIDClasse` ,
	`intIDCompetence` ,
	`intIDDomaine`
) VALUES (
	'1', '1', '21', '11'
),(
	'2', '1', '22', '11'
),(
	'3', '1', '23', '11'
),(
	'4', '1', '24', '11'
),(
	'5', '1', '25', '11'
),(
	'6', '1', '39', '19'
),(
	'7', '1', '3', '20'
),(
	'8', '1', '12', '20'
),(
	'9', '1', '18', '20'
);
-- table des domaines
REPLACE INTO `JeRoFa`.`tblZDomaines` (
	`intIDDomaine` ,
	`txtNomDomaine` ,
	`memDescription`
) VALUES (
	'1', 'Air', ""
),(
	'2', 'Animal', ""
),(
	'3', 'Chao', ""
),(
	'4', 'Mort', ""
),(
	'5', 'Destruction', ""
),(
	'6', 'Terre', ""
),(
	'7', 'Mal', ""
),(
	'8', 'Feu', ""
),(
	'9', 'Bien', ""
),(
	'10', 'Guérison', ""
),(
	'11', 'Connaisance', ""
),(
	'12', 'Loi', ""
),(
	'13', 'Chance', ""
),(
	'14', 'Magie', ""
),(
	'15', 'Plantes', ""
),(
	'16', 'Protection', ""
),(
	'17', 'Force', ""
),(
	'18', 'Soleil', ""
),(
	'19', 'Voyage', ""
),(
	'20', 'Fourberie', ""
),(
	'21', 'Guerre', ""
),(
	'22', 'Eau', ""
);
-- table des liens entre les classes et les compétences
REPLACE INTO `JeRoFa`.`tblYCompClasse` (
	`intIDClasse` ,
	`intIDCompetence`
) VALUES (
	'1', '5'
),(
	'1', '6'
),(
	'1', '7'
),(
	'1', '8'
),(
	'1', '10'
),(
	'1', '17'
),(
	'1', '21'
),(
	'1', '22'
),(
	'1', '24'
),(
	'1', '25'
),(
	'1', '37'
),(
	'2', '5'
),(
	'2', '6'
),(
	'2', '7'
),(
	'2', '8'
),(
	'2', '9'
),(
	'2', '21'
),(
	'2', '22'
),(
	'2', '23'
),(
	'2', '24'
),(
	'2', '25'
),(
	'2', '37'
),(
	'3', '3'
),(
	'3', '5'
),(
	'3', '6'
),(
	'3', '7'
),(
	'3', '8'
),(
	'3', '21'
),(
	'3', '37'
),(
	'4', '4'
),(
	'4', '6'
),(
	'4', '7'
),(
	'4', '8'
),(
	'4', '16'
),(
	'4', '19'
),(
	'4', '20'
),(
	'4', '32'
),(
	'4', '40'
),(
	'5', '1'
),(
	'5', '2'
),(
	'5', '3'
),(
	'5', '6'
),(
	'5', '7'
),(
	'5', '8'
),(
	'5', '9'
),(
	'5', '10'
),(
	'5', '11'
),(
	'5', '12'
),(
	'5', '13'
),(
	'5', '14'
),(
	'5', '16'
),(
	'5', '18'
),(
	'5', '19'
),(
	'5', '20'
),(
	'5', '23'
),(
	'5', '26'
),(
	'5', '27'
),(
	'5', '28'
),(
	'5', '29'
),(
	'5', '30'
),(
	'5', '31'
),(
	'5', '33'
),(
	'5', '34'
),(
	'5', '35'
),(
	'5', '38'
),(
	'5', '40'
),(
	'5', '41'
),(
	'5', '42'
),(
	'5', '43'
),(
	'6', '4'
),(
	'6', '5'
),(
	'6', '6'
),(
	'6', '7'
),(
	'6', '8'
),(
	'6', '16'
),(
	'6', '17'
),(
	'6', '18'
),(
	'6', '20'
),(
	'6', '26'
),(
	'6', '27'
),(
	'6', '32'
),(
	'6', '33'
),(
	'6', '38'
),(
	'6', '39'
),(
	'6', '40'
),(
	'6', '43'
);
-- table des classes
REPLACE INTO `JeRoFa`.`tblAClasses` (
	`intIDClasse` ,
	`intDesVie` ,
	`intNbCompetences` ,
	`blnPerdToutPreRequis` ,
	`blnNiveauxContinus` ,
	`txtNomClasse` ,
	`memDescription` 
) VALUES (
	'1', '8','2','-1','0','Prêtre', ""
),(
	'2', '4','2','0','0','Magicien', ""
),(
	'3', '4','2','0','0','Sorcier', ""
),(
	'4', '10','2','0','0','Guerrier', ""
),(
	'5', '6','8','0','0','Roublard', ""
),(
	'6', '8','6','0','0','Ranger', ""
);
REPLACE INTO `JeRoFa`.`tblACompetences` (
	`intIDCompetence`,
	`intIDAttribut`,
	`txtNomCompetence`,
	`blnPenaliteArmure`,
	`blnInne`,
	`memDescription`
) VALUES (
	'1', '4', 'Identifier', '0',  '-1', "Identifier un objet."
),(
	'2', '2', 'Équilibre', '-1',  '-1', "Garder l'équilibre."
),(
	'3', '6', 'Bluffe', '0', '-1', "Contre le jet de phycologie."
),(
	'4', '1', 'Escalade', '-1', '-1', "Grimper un mur ou une pente."
),(
	'5', '3', 'Concentration', '0', '-1', "Se concentrer à faire quelque chose."
),(
	'6', '4', 'Artisanat(Alchimie)', '0', '-1', "Fabriquer des concotions alchimiques."
),(
	'7', '4', 'Artisanat(Armes)', '0', '-1', "Fabriquer des armes."
),(
	'8', '4', 'Artisanat(Armures)', '0', '-1', "Fabriquer des armures."
),(
	'9', '4', 'Décripter', '0', '0', "Déchiffrer un texte d'une langue inconnue."
),(
	'10', '6', 'Diplomacie', '0', '-1', ""
),(
	'11', '4', 'Désactivation', '0', '0', "Rendre un objet ou un mécanisme inutilisable ou défaillant."
),(
	'12', '6', 'Déguisement', '0', '-1', "Changer son apparence."
),(
	'13', '2', 'Évasion', '-1', '-1', "S'échapper de diverses situations (physiques)."
),(
	'14', '4', 'Contrefaçon', '0', '-1', "Créer de faux documents."
),(
	'15', '6', "Recherche d'information", '0', '-1', "Trouver des détails sur un endroit, un objet, une personne ou autre choses similaires."
),(
	'16', '6', 'Dressage', '0', '0', "Dresser des animaux."
),(
	'17', '5', 'Soins', '0', '-1', "Traiter quelqu'un."
),(
	'18', '2', 'Cacher', '-1', '-1', "Se cacher à la vue des autres."
),(
	'19', '6', 'Intimider', '0', '-1', "Intimider quelqu'un."
),(
	'20', '1', 'Saut', '-1', '-1', "Distance et hauteur de saut."
),(
	'21', '4', 'Connaissances(Arcanes)', '0', '0', "Connaissance des arcanes."
),(
	'22', '4', 'Connaissances(Histoire)', '0', '0', "Connaissance de l'histoire."
),(
	'23', '4', 'Connaissances(Locale)', '0', '0', "Connaissance des légendes et lois."
),(
	'24', '4', 'Connaissances(Religion)', '0', '0', "Connaissance des religions."
),(
	'25', '4', 'Connaissances(Plans)', '0', '0', "Connaissance des plans d'existance."
),(
	'26', '5', 'Perception auditive', '0', '-1', "Entendre les bruits autour."
),(
	'27', '2', 'Déplacements silencieux', '-1', '-1', "Bouger sans faire de bruits."
),(
	'28', '2', 'Dévérouiller', '0', '0', "Ouvrir les cadenas et autres verrous."
),(
	'29', '6', 'Performance(Acte)', '0', '-1', "Improvisation, théâtre et autre."
),(
	'30', '6', 'Performance(Dance)', '0', '-1', "Dances de diverses sortes."
),(
	'31', '6', 'Performance(Chant)', '0', '-1', "Divers chants."
),(
	'32', '2', 'Équitation', '0', '-1', "Monter un animal pour se déplacer."
),(
	'33', '4', 'Fouille', '0', '-1', "Chercher et trouver différentes choses."
),(
	'34', '5', 'Psycologie', '0', '-1', "Comprendre les vraies intentions de quelqu'un."
),(
	'35', '2', 'Pickpocket', '-1', '0', "Voler un objet à quelqu'un ou cacher un objet sur soi."
),(
	'36', '0', 'Communication', '0', '0', "Communiquer dans d'autres langues."
),(
	'37', '4', 'Art de la magie', '0', '0', "Identifier les sorts."
),(
	'38', '5', 'Détection', '0', '-1', "Apercevoir certaines choses."
),(
	'39', '5', 'Survie', '0', '-1', "Survivre dans la nature par soi-même."
),(
	'40', '1', 'Nage', '-1', '-1', "Se déplacer dans l'eau."
),(
	'41', '2', 'Acrobaties', '-1', '0', "Effectuer des roulades!"
),(
	'42', '6', "Utilisation d'objets magique", '0', '0', "Utiliser des objets ayant des propriétés magiques."
),(
	'43', '2', 'Maîtrise des cordes', '0', '-1', "Attacher ou détacher des cordes."
);
-- table des écoles de magie
REPLACE INTO `JeRoFa`.`tblZEcoleMagie` (
	`intIDEcoleMagie` ,
	`txtNomEcoleMagie` ,
	`blnEcoleAbandonnable` ,
	`memDescription`
) VALUES (
	'1', 'Abjuration','-1', ""
),(
	'2', 'Conjuration','-1', ""
),(
	'3', 'Divination','0', ""
),(
	'4', 'Enchantement','-1', ""
),(
	'5', 'Illusion','-1', ""
),(
	'6', 'Necromancie','-1', ""
),(
	'7', 'Transmutation','-1', ""
),(
	'8', 'Évocation','-1', ""
),(
	'9', 'Universelle','0', ""
);
-- Table des composantes pour les sorts
REPLACE INTO `JeRoFa`.`tblZComposantes` (
	`intIDComposante` ,
	`txtNomComposante` , 
	`memDescription`
) VALUES (
	'1', 'Verbale', "Voix"
),(
	'2', 'Somatique', "Gestes"
),(
	'3', 'Matérielle', "Objets Consummé"
),(
	'4', 'Focus', "Objet"
),(
	'5', 'Focus Divin', " Objet Divin"
),(
	'6', 'Exp', "Expérience"
);
-- Table des niveaux de sorts
REPLACE INTO `JeRoFa`.`tblZNiveauxSorts` (
	`intIDNiveauSort` ,
	`intNiveauSort` ,
	`memDescription`
) VALUES (
	'1', '0', ""
),(
	'2', '1', ""
),(
	'3', '2', ""
),(
	'4', '3', ""
),(
	'5', '4', ""
),(
	'6', '5', ""
),(
	'7', '6', ""
),(
	'8', '7', ""
),(
	'9', '8', ""
),(
	'10', '9', ""
);
-- table des types de lanceurs de sorts
REPLACE INTO `JeRoFa`.`tblZTypesLanceur` (
	`intIDTypeLanceur` ,
	`txtNomTypeLanceur` ,
	`memDescription`
) VALUES (
	'1', 'Arcanique', ""
),(
	'2', 'Divin', ""
);
REPLACE INTO `JeRoFa`.`tblybonusattributs` (
	`intIDRace` ,
	`intIDAttribut` ,
	`intBonus`
) VALUES (
	'3', '3', '2'
),(
	'3', '6', '-2'
),(
	'2', '3', '-2'
),(
	'2', '2', '2'
);
REPLACE INTO `JeRoFa`.`tblybonuscompetences` (
	`intIDRace` ,
	`intIDCompetence` ,
	`intBonus`
) VALUES (
	'2', '26', '2'
),(
	'2', '38', '2'
),(
	'2', '33', '2'
);
