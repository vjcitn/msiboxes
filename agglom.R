options(warn=-1)
args = commandArgs(trailingOnly=TRUE)
stopifnot(length(args)>1)
oname = args[1]
files = args[-1]
print(files)
fl = lapply(files, read.csv, stringsAsFactors=FALSE)
ans = do.call(rbind, fl)
saveRDS(ans, file=oname)
