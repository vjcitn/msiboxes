# msiboxes
WDL for MSIsensor stratification

- Sept 7 2019

Local cromwell runs will likely need more compute power than a macbook.  The code is
primarily intended for use with dockstore.org.  Inputs must be provided; see the test.json
for an example.  To demonstrate local execution on a laptop with reasonably endowed R/bioc
(must have BiocOncoTK and curatedTCGAData installed), remove the runtime specs in the tasks
in main3.wdl and simp4.wdl.  The associated [dockstore workflow](https://dockstore.org/workflows/github.com/vjcitn/msiboxes/csvgen:master?tab=info) is public and can be run in terra with a push of a button.

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
