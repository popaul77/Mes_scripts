#!/usr/bin/env python
#'sources'
#'https://www.cgsecurity.org/wiki/Après_l'utilisation_de_PhotoRec'


import os
import os.path
import shutil

while True:
    source = raw_input('Enter the source directory\n')
    if os.path.exists(source):
        break
    else:
        print 'The directory you have entered does not exist'
while True:
    destination = raw_input('Enter the destination directory\n')
    if os.path.exists(destination):
        break
    else:
        print 'The directory you have entered does not exist'

for root, dirs, files in os.walk(source, topdown=False):
    for files2 in files:
        extension = os.path.splitext(os.path.join(root, files2))[1][1:]
        if os.path.exists(os.path.join(destination, extension)):
            shutil.copy(os.path.join(root, files2),
                        os.path.join(destination, extension))
        else:
            os.mkdir(os.path.join(destination, extension))
            shutil.copy(os.path.join(root, files2),
                        os.path.join(destination, extension))
