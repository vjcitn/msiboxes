import "https://raw.githubusercontent.com/vjcitn/msiboxes/master/simp4.wdl" as sub

# this is an approach to nested scatter
# results get very deep, e.g., cromwell-executions/genes/8dfedc1d-dd96-41dc-9cce-170ca5d4753f/call-tumors/shard-0/sub.tumors/5e28e8c6-f733-4fcf-b4f2-a1231cdfd78d/call-onetum/shard-0/execution/BRCA_CD8A.csv


task agt {
  Array[File] infiles
  File aggscr = "gs://vjc_scripts/agglom.R"
  command {
   Rscript ${aggscr} demo.rds ${sep=' ' infiles}
  }
  output {
   File rdsbytum = "demo.rds"
   }
  runtime {
    continueOnReturnCode: true
    docker: "vjcitn/vjconco:v3"
    disks: "local-disk 40 HDD"
    bootDiskSizeGb: 50
    memory: "24G"
    }   
 }

task agg {
  Array[File] inrds
  File concscr = "gs://vjc_scripts/conc.R"
  command {
   Rscript ${concscr} final.rds ${sep=' ' inrds}
  }
 output {
  File concatDF = "final.rds"
  }
  runtime {
    continueOnReturnCode: true
    docker: "vjcitn/vjconco:v3"
    disks: "local-disk 40 HDD"
    bootDiskSizeGb: 50
    memory: "24G"
    }   
}

workflow genes {
  Array[String] genes # unbound variables will get bindings from 'inputs' json
  Array[String] tumors 
  scatter (g in genes) {
   call sub.tumors {
    input: gene = g, tumors=tumors
    }
  }
  scatter (f in tumors.outs) {
    call agt { input: infiles = f }
   }
  call agg { input: inrds = agt.rdsbytum }
  output {
   Array[Array[File]] allout = tumors.outs
  }
}
