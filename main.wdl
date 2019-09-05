import "simp4.wdl" as sub

workflow genes {
  Array[String] genes = ["CD8A", "PDCD1LG2"]
  scatter (g in genes) {
   call sub.tumors {
    input: gene = g
    }
  }
}
