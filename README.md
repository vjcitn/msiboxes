# msiboxes
WDL for MSIsensor stratification

- Sept 5 2019

```
java -jar ~/cromwell-36.jar run main3.wdl
```
creates final.rds, which is a data.frame with format, providing
expression measures and microsatellite instability stratification
for selected genes and tumors in TCGA.  Bioconductor's curatedTCGAData
is used to obtain the expression data, and BiocOncoTK is used to
acquire the MSIsensor strata.
```
  X patient_barcode acronym symbol alias   log2ex msicode
1 1    TCGA-3C-AAAU    BRCA   CD8A  CD8A 4.293635      <4
2 2    TCGA-3C-AALI    BRCA   CD8A  CD8A 9.424675      <4
3 3    TCGA-3C-AALJ    BRCA   CD8A  CD8A 8.943649      <4
4 4    TCGA-3C-AALK    BRCA   CD8A  CD8A 7.286798      <4
```
