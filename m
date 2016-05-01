From: Sean Fu <fxinrong@gmail.com>
Subject: Fail to build tools/all
Date: Sun, 1 May 2016 13:11:33 +0800
Message-ID: <20160501050629.GA7386@linux-dunz.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: trenn@suse.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi guys:
        I encountered a build error when running "make V=1 tools/all".
        Shall we write a patch to fix it?
        The following is error log.

================================ start ==========================
commit 05cf8077e54b20dddb756eaa26f3aeb5c38dd3cf
Merge: cf78031 db5dd0d
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri Apr 1 20:03:33 2016 -0500
================================= end  =========================

============================== start ===========================
mkdir -p
/home/sean/work/source/upstream/kernel.linus/linux/tools/power/cpupower
&& make O=/home/sean/work/source/upstream/kernel.linus/linux
subdir=tools/power/cpupower --no-print-directory -C power/cpupower 
gcc  -DVERSION=\"4.6.rc1.190.g05cf80\" -DPACKAGE=\"cpupower\"
-DPACKAGE_BUGREPORT=\"linux-pm@vger.kernel.org\" -D_GNU_SOURCE -pipe
-DNLS -Wall -Wchar-subscripts -Wpointer-arith -Wsign-compare
-Wno-pointer-sign -Wdeclaration-after-statement -Wshadow -O1 -g -DDEBUG
-I./lib -I ./utils -o
/home/sean/work/source/upstream/kernel.linus/linux/utils/helpers/amd.o
-c utils/helpers/amd.c
utils/helpers/amd.c:7:21: fatal error: pci/pci.h: No such file or
directory
 #include <pci/pci.h>
                      ^
		      compilation terminated.
		      Makefile:218: recipe for target
		      '/home/sean/work/source/upstream/kernel.linus/linux/utils/helpers/amd.o'
		      failed
		      make[2]: ***
		      [/home/sean/work/source/upstream/kernel.linus/linux/utils/helpers/amd.o]
		      Error 1
		      Makefile:56: recipe for target 'cpupower' failed
		      make[1]: *** [cpupower] Error 2
		      Makefile:1548: recipe for target 'tools/all'
		      failed
		      make: *** [tools/all] Error 2
=============================== end ==========================

BestRegards
Sean
