#!/usr/bin/env python
import sys
import re
import os
inFilename = sys.argv[1]
if os.path.isfile(inFilename):
    namelength = inFilename.rfind(".")
    name = inFilename[0:namelength]
    exten = inFilename[namelength:]
    outFilename = name + "_fetched" + exten
print "inFilename:", inFilename
print "outFilename:", outFilename


fpRead = open(inFilename, "r")
fpWrite = open(outFilename, "w+")

linePattern1 = re.compile(r'.* (Read) .* address (0x[0-9|a-f]+)')
linePattern2 = re.compile(r'.* (Write) .* address (0x[0-9|a-f]+)')
linePattern3 = re.compile(r'.* (IFetch) .* address (0x[0-9|a-f]+)')
lines = fpRead.readline()
while lines:
    match1 = linePattern1.match(lines)
    match2 = linePattern2.match(lines)
    match3 = linePattern3.match(lines)
    if match1:
        fpWrite.write("%s %s \n" %(0,match1.group(2)))  
    if match2:
        fpWrite.write("%s %s \n" %(1,match2.group(2)))  
    if match3:
        fpWrite.write("%s %s \n" %(2,match3.group(2)))  
    lines = fpRead.readline()
fpRead.close()
fpWrite.close()
