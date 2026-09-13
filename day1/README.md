# Day 1: Titanic Dataset Cleaning

## Dataset
Titanic passenger dataset, imported into SQL Server

## Summary
Cleaned and prepared the Titanic passenger dataset (418 records) by handling missing values across Age, Cabin, and Fare columns, and flagged missing cabin records for further analysis.

## Key Steps

**Handling Missing Ages**
- Identified ~20% of records with missing Age values
- Imputed missing ages using average age grouped by Passenger Class and Sex

**Handling Missing Cabins**
- Found 327 out of 418 records missing Cabin data (~78%)
- Created a `HasCabin` flag column (0 = missing, 1 = present) instead of guessing values

**Handling Missing Fare**
- Filled missing Fare values for 3rd class passengers using the class median

## Files
- `Day1_titanic_cleaning.sql`