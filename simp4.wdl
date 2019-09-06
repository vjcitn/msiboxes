

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
  File scr = "gs://fc-secure-316c235f-82e5-40fb-a576-8308a3ae10c4/exprByMSI_csv.R"
  command {
    Rscript  ${scr}  --tumor=${tum1} --gene=${g1}
  }
  output {
    File out = "${tum1}_${g1}.csv"
  }
  runtime {
    continueOnReturnCode: true
    docker: "vjcitn/vjconco:v3"
    disks: "local-disk 40 HDD"
    bootDiskSizeGb: 50
    memory: "24G"
    }   
}

