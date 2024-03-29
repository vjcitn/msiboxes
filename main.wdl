import "simp4.wdl" as sub

# this is an approach to nested scatter
# results get very deep, e.g., cromwell-executions/genes/8dfedc1d-dd96-41dc-9cce-170ca5d4753f/call-tumors/shard-0/sub.tumors/5e28e8c6-f733-4fcf-b4f2-a1231cdfd78d/call-onetum/shard-0/execution/BRCA_CD8A.csv

task dowc {
  Array[File] infiles
  command {
    wc ${sep=' ' infiles}
  }
}

workflow genes {
  Array[String] genes = ["CD8A", "PDCD1LG2"]
  Array[String] tumors = ["BRCA", "STAD"]
  scatter (g in genes) {
   call sub.tumors {
    input: gene = g, tumors=tumors
    }
  }
  scatter (f in tumors.outs) {
    call dowc { input: infiles = f }
   }
  output {
   Array[Array[File]] allout = tumors.outs
  }
}
