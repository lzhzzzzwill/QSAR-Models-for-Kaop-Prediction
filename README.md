# QSAR-models-for-kaop-prediction

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

## Citing:
If you use the dataset or any trained models in your work, please cite the following article-
```bibtex
@article{LIN2024126649,
        title = {Unveiling similarities and differences in oxidation processes of oxidants and derived reactive oxygen species through machine learning interpretation of oxidation rate constants},
        journal = {Separation and Purification Technology},
        volume = {340},
        pages = {126649},
        year = {2024},
        issn = {1383-5866}
}
```

