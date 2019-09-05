


workflow tumors {
  Array[String] tumors
  String gene
  scatter (t in tumors) {
    call onetum { input: tum1 = t, g1=gene }
   }
  output {
    Array[File] outs = onetum.out
  }
}

task onetum {
  String tum1 
  String g1
  File scr = "exprByMSI_csv.R"
  command {
    Rscript  ${scr}  --tumor=${tum1} --gene=${g1}
  }
  output {
    File out = "${tum1}_${g1}.csv"
  }
}

