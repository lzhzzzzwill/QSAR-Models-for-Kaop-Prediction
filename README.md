# QSAR-models-for-kaop-prediction

## This repository contains the data and scripts involved in the publication:
[Unveiling similarities and differences in oxidation processes of oxidants and derived reactive oxygen species through machine learning interpretation of oxidation rate constants](https://www.sciencedirect.com/science/article/pii/S1383586624003885?via%3Dihub)
<div align="center">
  <img src="https://github.com/lzhzzzzwill/QSAR-Models-for-Kaop-Prediction/blob/main/viz/TOC1.png">
</div>

## Environment requirements:
### Python 3.8.16:
Model construction
### R 4.2.1
Visualization

## Code files:
### The workflow.ipynb:
The workflow for QSAR models construction and evaluation, applicability domain and model interpretation. Visualization for model interpretation. (.OH as an example for all processes)
### viz.R:
Visualization for workflow. (.OH as an example for all processes)

## Software:
### Vs code: 
Code Editor for The workflow.ipynb
### R studio:
Code Editor for viz.R
### Rdkit package:
Calculation for Morgan and MACCS molecular fingerprints
### PaDEL-Descriptor software:
Calculation for CDK, Ext, Graph, Estate, Pub, Sub, SubC, KR, KRC, AP2D, and AP2DC  molecular fingerprints.
### Scikit-learn package:
Construction of models SVM, KNN, DT, RF, and GBDT. 
### xgboost package:
Construction of model XGB.
### scikit-opt:
Optimization of hyperparameter.
### shap package:
Interpretation of models.

