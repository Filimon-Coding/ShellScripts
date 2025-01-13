#!/bin/bash

# Base directory
BASE_DIR="/home/neov/Documents/MinCodingLinuxV/Prosjekter"

# Create directories for each semester
mkdir -p $BASE_DIR/1stSemester/{DiskretMatematikkDAPE1300,ProgrammeringDAPE1400,TeknologiOgSamfunnForProgrammerereDATA1100,WebutviklingOgInkluderendeDesignDATA1200}
mkdir -p $BASE_DIR/2ndSemester/{InternetOfThingsADSE1310,DatabaserDATA1500,WebprogrammeringDATA1700}
mkdir -p $BASE_DIR/3rdSemester/{MenneskeMaskinInteraksjonADSE2100,SystemutviklingDAFE2200,AlgoritmerOgDatastrukturerDATS2300}
mkdir -p $BASE_DIR/4thSemester/{OperativsystemerDATA2500,DatanettverkOgSkytjenesterDATA2410,PraktiskITProsjektDATA3710}

echo "Mappestruktur er opprettet under $BASE_DIR"
