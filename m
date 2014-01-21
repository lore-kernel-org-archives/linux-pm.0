From: Adam Colligan <adam@adamcolligan.net>
Subject: PROBLEM: [Sony VAIO VPCF119HX] suspend/resume failure
Date: Mon, 20 Jan 2014 23:41:08 -0600
Message-ID: <52DE0874.101@AdamColligan.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:52820 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750740AbaAUFlM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jan 2014 00:41:12 -0500
Received: by mail-ob0-f171.google.com with SMTP id wp4so3085874obc.2
        for <linux-pm@vger.kernel.org>; Mon, 20 Jan 2014 21:41:11 -0800 (PST)
Received: from [192.168.1.101] ([70.114.137.227])
        by mx.google.com with ESMTPSA id fn10sm5686402obb.12.2014.01.20.21.41.09
        for <linux-pm@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 20 Jan 2014 21:41:10 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

Note: this report has been truncated in many places to restrict it to
what I believe is the 100 000 character limit of the mailing list. The
full report is available at
https://launchpadlibrarian.net/162984853/suspend-take2 .  Please also
note that while the original bug report was from an Nvidia driver
environment, I have switched the testing environment to Nouveau.

1. One line summary of the problem:
 [Sony VAIO VPCF119HX] suspend/resume failure non-free: nvidia

2. Full description of the problem/report:

See https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1154867 . 
Suspend appears to work correctly, and the hardware light indicators
show a suspend mode is active. However, upon wakeup, the machine always
kicks all the way down to BIOS/grub2 and boots as if it had been shut
down. Apport consistently logs a kernel oops for suspend/resume failure.

This failure is technically a regression, as suspend worked properly as
some point in the past two years (I believe during part of the Ubuntu
Raring cycle); however, I have not been able to recreate any success and
cannot pinpoint the time at which it worked.

The problem appears identical whether or not some suggested modules are
included to unload in /etc/pm/config.d.


3. Keywords:


4. Kernel version:
Linux version 3.13.0-031300-generic (apw@gomeisa) (gcc version 4.6.3
(Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201401192235 SMP Mon Jan 20 03:36:48
UTC 2014


5. Output of Oops.. message:

ProblemType: KernelOops
Annotation: This occured during a previous suspend and prevented it from
resuming properly.
Architecture: amd64
Date: Tue Jan 21 00:07:25 2014
DistroRelease: Ubuntu 13.10
ExecutablePath: /usr/share/apport/apportcheckresume
ExecutableTimestamp: 1386693790
Failure: suspend/resume
InterpreterPath: /usr/bin/python3.3
Package: linux-image-3.13.0-031300-generic
ProcCmdline: /usr/bin/python3 /usr/share/apport/apportcheckresume
ProcCwd: /
ProcEnviron:
 TERM=linux
 PATH=(custom, no user)
ProcMaps:
 00400000-0071d000 r-xp 00000000 fc:00
6167702                            /usr/bin/python3.3
 0091c000-0091d000 r--p 0031c000 fc:00
6167702                            /usr/bin/python3.3
 0091d000-009b6000 rw-p 0031d000 fc:00
6167702                            /usr/bin/python3.3
 009b6000-009d3000 rw-p 00000000 00:00 0
 029cd000-029ee000 rw-p 00000000 00:00
0                                  [heap]
 029ee000-02a0f000 rw-p 00000000 00:00
0                                  [heap]
 02a0f000-02a35000 rw-p 00000000 00:00
0                                  [heap]
 02a35000-02a58000 rw-p 00000000 00:00
0                                  [heap]
 02a58000-02a7d000 rw-p 00000000 00:00
0                                  [heap]
 02a7d000-02a90000 rw-p 00000000 00:00
0                                  [heap]
 02a90000-02aad000 rw-p 00000000 00:00
0                                  [heap]
 02aad000-02ac4000 rw-p 00000000 00:00
0                                  [heap]
 02ac4000-02aea000 rw-p 00000000 00:00
0                                  [heap]
 02aea000-02afc000 rw-p 00000000 00:00
0                                  [heap]
 02afc000-02b22000 rw-p 00000000 00:00
0                                  [heap]
 02b22000-02b43000 rw-p 00000000 00:00
0                                  [heap]
 02b43000-02b6c000 rw-p 00000000 00:00
0                                  [heap]
 02b6c000-02b9f000 rw-p 00000000 00:00
0                                  [heap]
 02b9f000-02c3b000 rw-p 00000000 00:00
0                                  [heap]
 02c3b000-02c69000 rw-p 00000000 00:00
0                                  [heap]
 7f32e8813000-7f32e8853000 rw-p 00000000 00:00 0
 7f32e8853000-7f32e8893000 rw-p 00000000 00:00 0
 7f32e8893000-7f32e88d3000 rw-p 00000000 00:00 0
 7f32e88d3000-7f32e88e8000 r-xp 00000000 fc:00
786686                     /lib/x86_64-linux-gnu/libgcc_s.so.1
 7f32e88e8000-7f32e8ae7000 ---p 00015000 fc:00
786686                     /lib/x86_64-linux-gnu/libgcc_s.so.1
 7f32e8ae7000-7f32e8ae8000 r--p 00014000 fc:00
786686                     /lib/x86_64-linux-gnu/libgcc_s.so.1
 7f32e8ae8000-7f32e8ae9000 rw-p 00015000 fc:00
786686                     /lib/x86_64-linux-gnu/libgcc_s.so.1
 7f32e8ae9000-7f32e8bcf000 r-xp 00000000 fc:00
6163597                    /usr/lib/x86_64-linux-gnu/libstdc++.so.6.0.18
 7f32e8bcf000-7f32e8dce000 ---p 000e6000 fc:00
6163597                    /usr/lib/x86_64-linux-gnu/libstdc++.so.6.0.18
 7f32e8dce000-7f32e8dd6000 r--p 000e5000 fc:00
6163597                    /usr/lib/x86_64-linux-gnu/libstdc++.so.6.0.18
 7f32e8dd6000-7f32e8dd8000 rw-p 000ed000 fc:00
6163597                    /usr/lib/x86_64-linux-gnu/libstdc++.so.6.0.18
 7f32e8dd8000-7f32e8ded000 rw-p 00000000 00:00 0
 7f32e8ded000-7f32e8f22000 r-xp 00000000 fc:00
6168302                    /usr/lib/x86_64-linux-gnu/libapt-pkg.so.4.12.0
 7f32e8f22000-7f32e9122000 ---p 00135000 fc:00
6168302                    /usr/lib/x86_64-linux-gnu/libapt-pkg.so.4.12.0
 7f32e9122000-7f32e9126000 r--p 00135000 fc:00
6168302                    /usr/lib/x86_64-linux-gnu/libapt-pkg.so.4.12.0
 7f32e9126000-7f32e9127000 rw-p 00139000 fc:00
6168302                    /usr/lib/x86_64-linux-gnu/libapt-pkg.so.4.12.0
 7f32e9127000-7f32e9128000 rw-p 00000000 00:00 0
 7f32e9128000-7f32e916d000 r-xp 00000000 fc:00
6167594                   
/usr/lib/python3/dist-packages/apt_pkg.cpython-33m-x86_64-linux-gnu.so
 7f32e916d000-7f32e936c000 ---p 00045000 fc:00
6167594                   
/usr/lib/python3/dist-packages/apt_pkg.cpython-33m-x86_64-linux-gnu.so
 7f32e936c000-7f32e936e000 r--p 00044000 fc:00
6167594                   
/usr/lib/python3/dist-packages/apt_pkg.cpython-33m-x86_64-linux-gnu.so
 7f32e936e000-7f32e9376000 rw-p 00046000 fc:00
6167594                   
/usr/lib/python3/dist-packages/apt_pkg.cpython-33m-x86_64-linux-gnu.so
 7f32e9376000-7f32e9385000 r-xp 00000000 fc:00
790356                     /lib/x86_64-linux-gnu/libbz2.so.1.0.4
 7f32e9385000-7f32e9584000 ---p 0000f000 fc:00
790356                     /lib/x86_64-linux-gnu/libbz2.so.1.0.4
 7f32e9584000-7f32e9585000 r--p 0000e000 fc:00
790356                     /lib/x86_64-linux-gnu/libbz2.so.1.0.4
 7f32e9585000-7f32e9586000 rw-p 0000f000 fc:00
790356                     /lib/x86_64-linux-gnu/libbz2.so.1.0.4
 7f32e9586000-7f32e9589000 r-xp 00000000 fc:00
6430471                   
/usr/lib/python3.3/lib-dynload/_bz2.cpython-33m-x86_64-linux-gnu.so
 7f32e9589000-7f32e9788000 ---p 00003000 fc:00
6430471                   
/usr/lib/python3.3/lib-dynload/_bz2.cpython-33m-x86_64-linux-gnu.so
 7f32e9788000-7f32e9789000 r--p 00002000 fc:00
6430471                   
/usr/lib/python3.3/lib-dynload/_bz2.cpython-33m-x86_64-linux-gnu.so
 7f32e9789000-7f32e978a000 rw-p 00003000 fc:00
6430471                   
/usr/lib/python3.3/lib-dynload/_bz2.cpython-33m-x86_64-linux-gnu.so
 7f32e978a000-7f32e97ca000 rw-p 00000000 00:00 0
 7f32e97ca000-7f32e980a000 rw-p 00000000 00:00 0
 7f32e980a000-7f32e984a000 rw-p 00000000 00:00 0
 7f32e984a000-7f32e989e000 r-xp 00000000 fc:00
786649                     /lib/x86_64-linux-gnu/libssl.so.1.0.0
 7f32e989e000-7f32e9a9e000 ---p 00054000 fc:00
786649                     /lib/x86_64-linux-gnu/libssl.so.1.0.0
 7f32e9a9e000-7f32e9aa1000 r--p 00054000 fc:00
786649                     /lib/x86_64-linux-gnu/libssl.so.1.0.0
 7f32e9aa1000-7f32e9aa7000 rw-p 00057000 fc:00
786649                     /lib/x86_64-linux-gnu/libssl.so.1.0.0
 7f32e9aa7000-7f32e9aa8000 rw-p 00000000 00:00 0
 7f32e9aa8000-7f32e9ab8000 r-xp 00000000 fc:00
6424115                   
/usr/lib/python3.3/lib-dynload/_ssl.cpython-33m-x86_64-linux-gnu.so
 7f32e9ab8000-7f32e9cb7000 ---p 00010000 fc:00
6424115                   
/usr/lib/python3.3/lib-dynload/_ssl.cpython-33m-x86_64-linux-gnu.so
 7f32e9cb7000-7f32e9cb8000 r--p 0000f000 fc:00
6424115                   
/usr/lib/python3.3/lib-dynload/_ssl.cpython-33m-x86_64-linux-gnu.so
 7f32e9cb8000-7f32e9cbb000 rw-p 00010000 fc:00
6424115                   
/usr/lib/python3.3/lib-dynload/_ssl.cpython-33m-x86_64-linux-gnu.so
 7f32e9cbb000-7f32e9cfb000 rw-p 00000000 00:00 0
 7f32e9cfb000-7f32e9d3b000 rw-p 00000000 00:00 0
 7f32e9d3b000-7f32e9d7b000 rw-p 00000000 00:00 0
 7f32e9d7b000-7f32e9dbb000 rw-p 00000000 00:00 0
 7f32e9dbb000-7f32e9dfb000 rw-p 00000000 00:00 0
 7f32e9dfb000-7f32e9e3b000 rw-p 00000000 00:00 0
 7f32e9e3b000-7f32e9fed000 r-xp 00000000 fc:00
786650                     /lib/x86_64-linux-gnu/libcrypto.so.1.0.0
 7f32e9fed000-7f32ea1ed000 ---p 001b2000 fc:00
786650                     /lib/x86_64-linux-gnu/libcrypto.so.1.0.0
 7f32ea1ed000-7f32ea208000 r--p 001b2000 fc:00
786650                     /lib/x86_64-linux-gnu/libcrypto.so.1.0.0
 7f32ea208000-7f32ea213000 rw-p 001cd000 fc:00
786650                     /lib/x86_64-linux-gnu/libcrypto.so.1.0.0
 7f32ea213000-7f32ea217000 rw-p 00000000 00:00 0
 7f32ea217000-7f32ea21b000 r-xp 00000000 fc:00
6424114                   
/usr/lib/python3.3/lib-dynload/_hashlib.cpython-33m-x86_64-linux-gnu.so
 7f32ea21b000-7f32ea41a000 ---p 00004000 fc:00
6424114                   
/usr/lib/python3.3/lib-dynload/_hashlib.cpython-33m-x86_64-linux-gnu.so
 7f32ea41a000-7f32ea41b000 r--p 00003000 fc:00
6424114                   
/usr/lib/python3.3/lib-dynload/_hashlib.cpython-33m-x86_64-linux-gnu.so
 7f32ea41b000-7f32ea41c000 rw-p 00004000 fc:00
6424114                   
/usr/lib/python3.3/lib-dynload/_hashlib.cpython-33m-x86_64-linux-gnu.so
 7f32ea41c000-7f32ea45c000 rw-p 00000000 00:00 0
 7f32ea45c000-7f32ea4bd000 rw-p 00000000 00:00 0
 7f32ea4bd000-7f32ea4fd000 rw-p 00000000 00:00 0
 7f32ea4fd000-7f32ea509000 r-xp 00000000 fc:00
786615                     /lib/x86_64-linux-gnu/libnss_files-2.17.so
 7f32ea509000-7f32ea708000 ---p 0000c000 fc:00
786615                     /lib/x86_64-linux-gnu/libnss_files-2.17.so
 7f32ea708000-7f32ea709000 r--p 0000b000 fc:00
786615                     /lib/x86_64-linux-gnu/libnss_files-2.17.so
 7f32ea709000-7f32ea70a000 rw-p 0000c000 fc:00
786615                     /lib/x86_64-linux-gnu/libnss_files-2.17.so
 7f32ea70a000-7f32ea715000 r-xp 00000000 fc:00
786613                     /lib/x86_64-linux-gnu/libnss_nis-2.17.so
 7f32ea715000-7f32ea914000 ---p 0000b000 fc:00
786613                     /lib/x86_64-linux-gnu/libnss_nis-2.17.so
 7f32ea914000-7f32ea915000 r--p 0000a000 fc:00
786613                     /lib/x86_64-linux-gnu/libnss_nis-2.17.so
 7f32ea915000-7f32ea916000 rw-p 0000b000 fc:00
786613                     /lib/x86_64-linux-gnu/libnss_nis-2.17.so
 7f32ea916000-7f32ea92d000 r-xp 00000000 fc:00
786601                     /lib/x86_64-linux-gnu/libnsl-2.17.so
 7f32ea92d000-7f32eab2c000 ---p 00017000 fc:00
786601                     /lib/x86_64-linux-gnu/libnsl-2.17.so
 7f32eab2c000-7f32eab2d000 r--p 00016000 fc:00
786601                     /lib/x86_64-linux-gnu/libnsl-2.17.so
 7f32eab2d000-7f32eab2e000 rw-p 00017000 fc:00
786601                     /lib/x86_64-linux-gnu/libnsl-2.17.so
 7f32eab2e000-7f32eab30000 rw-p 00000000 00:00 0
 7f32eab30000-7f32eab38000 r-xp 00000000 fc:00
786604                     /lib/x86_64-linux-gnu/libnss_compat-2.17.so
 7f32eab38000-7f32ead37000 ---p 00008000 fc:00
786604                     /lib/x86_64-linux-gnu/libnss_compat-2.17.so
 7f32ead37000-7f32ead38000 r--p 00007000 fc:00
786604                     /lib/x86_64-linux-gnu/libnss_compat-2.17.so
 7f32ead38000-7f32ead39000 rw-p 00008000 fc:00
786604                     /lib/x86_64-linux-gnu/libnss_compat-2.17.so
 7f32ead39000-7f32ead79000 rw-p 00000000 00:00 0
 7f32ead79000-7f32eadb9000 rw-p 00000000 00:00 0
 7f32eadb9000-7f32eaebc000 r-xp 00000000 fc:00
786607                     /lib/x86_64-linux-gnu/libm-2.17.so
 7f32eaebc000-7f32eb0bb000 ---p 00103000 fc:00
786607                     /lib/x86_64-linux-gnu/libm-2.17.so
 7f32eb0bb000-7f32eb0bc000 r--p 00102000 fc:00
786607                     /lib/x86_64-linux-gnu/libm-2.17.so
 7f32eb0bc000-7f32eb0bd000 rw-p 00103000 fc:00
786607                     /lib/x86_64-linux-gnu/libm-2.17.so
 7f32eb0bd000-7f32eb0d5000 r-xp 00000000 fc:00
790515                     /lib/x86_64-linux-gnu/libz.so.1.2.8
 7f32eb0d5000-7f32eb2d4000 ---p 00018000 fc:00
790515                     /lib/x86_64-linux-gnu/libz.so.1.2.8
 7f32eb2d4000-7f32eb2d5000 r--p 00017000 fc:00
790515                     /lib/x86_64-linux-gnu/libz.so.1.2.8
 7f32eb2d5000-7f32eb2d6000 rw-p 00018000 fc:00
790515                     /lib/x86_64-linux-gnu/libz.so.1.2.8
 7f32eb2d6000-7f32eb2fd000 r-xp 00000000 fc:00
790377                     /lib/x86_64-linux-gnu/libexpat.so.1.6.0
 7f32eb2fd000-7f32eb4fd000 ---p 00027000 fc:00
790377                     /lib/x86_64-linux-gnu/libexpat.so.1.6.0
 7f32eb4fd000-7f32eb4ff000 r--p 00027000 fc:00
790377                     /lib/x86_64-linux-gnu/libexpat.so.1.6.0
 7f32eb4ff000-7f32eb500000 rw-p 00029000 fc:00
790377                     /lib/x86_64-linux-gnu/libexpat.so.1.6.0
 7f32eb500000-7f32eb502000 r-xp 00000000 fc:00
786612                     /lib/x86_64-linux-gnu/libutil-2.17.so
 7f32eb502000-7f32eb701000 ---p 00002000 fc:00
786612                     /lib/x86_64-linux-gnu/libutil-2.17.so
 7f32eb701000-7f32eb702000 r--p 00001000 fc:00
786612                     /lib/x86_64-linux-gnu/libutil-2.17.so
 7f32eb702000-7f32eb703000 rw-p 00002000 fc:00
786612                     /lib/x86_64-linux-gnu/libutil-2.17.so
 7f32eb703000-7f32eb706000 r-xp 00000000 fc:00
786622                     /lib/x86_64-linux-gnu/libdl-2.17.so
 7f32eb706000-7f32eb905000 ---p 00003000 fc:00
786622                     /lib/x86_64-linux-gnu/libdl-2.17.so
 7f32eb905000-7f32eb906000 r--p 00002000 fc:00
786622                     /lib/x86_64-linux-gnu/libdl-2.17.so
 7f32eb906000-7f32eb907000 rw-p 00003000 fc:00
786622                     /lib/x86_64-linux-gnu/libdl-2.17.so
 7f32eb907000-7f32ebac4000 r-xp 00000000 fc:00
786621                     /lib/x86_64-linux-gnu/libc-2.17.so
 7f32ebac4000-7f32ebcc4000 ---p 001bd000 fc:00
786621                     /lib/x86_64-linux-gnu/libc-2.17.so
 7f32ebcc4000-7f32ebcc8000 r--p 001bd000 fc:00
786621                     /lib/x86_64-linux-gnu/libc-2.17.so
 7f32ebcc8000-7f32ebcca000 rw-p 001c1000 fc:00
786621                     /lib/x86_64-linux-gnu/libc-2.17.so
 7f32ebcca000-7f32ebccf000 rw-p 00000000 00:00 0
 7f32ebccf000-7f32ebce6000 r-xp 00000000 fc:00
786623                     /lib/x86_64-linux-gnu/libpthread-2.17.so
 7f32ebce6000-7f32ebee6000 ---p 00017000 fc:00
786623                     /lib/x86_64-linux-gnu/libpthread-2.17.so
 7f32ebee6000-7f32ebee7000 r--p 00017000 fc:00
786623                     /lib/x86_64-linux-gnu/libpthread-2.17.so
 7f32ebee7000-7f32ebee8000 rw-p 00018000 fc:00
786623                     /lib/x86_64-linux-gnu/libpthread-2.17.so
 7f32ebee8000-7f32ebeec000 rw-p 00000000 00:00 0
 7f32ebeec000-7f32ebf0f000 r-xp 00000000 fc:00
786610                     /lib/x86_64-linux-gnu/ld-2.17.so
 7f32ebf26000-7f32ebf66000 rw-p 00000000 00:00 0
 7f32ebf66000-7f32ebfa6000 rw-p 00000000 00:00 0
 7f32ebfd7000-7f32ec017000 rw-p 00000000 00:00 0
 7f32ec017000-7f32ec057000 rw-p 00000000 00:00 0
 7f32ec057000-7f32ec097000 rw-p 00000000 00:00 0
 7f32ec097000-7f32ec0d7000 rw-p 00000000 00:00 0
 7f32ec0d7000-7f32ec0d9000 rw-p 00000000 00:00 0
 7f32ec0d9000-7f32ec0da000 rw-p 00000000 00:00 0
 7f32ec0da000-7f32ec0db000 rw-p 00000000 00:00 0
 7f32ec0db000-7f32ec0dc000 rw-p 00000000 00:00 0
 7f32ec10c000-7f32ec10e000 rw-p 00000000 00:00 0
 7f32ec10e000-7f32ec10f000 r--p 00022000 fc:00
786610                     /lib/x86_64-linux-gnu/ld-2.17.so
 7f32ec10f000-7f32ec111000 rw-p 00023000 fc:00
786610                     /lib/x86_64-linux-gnu/ld-2.17.so
 7fff6f382000-7fff6f3a3000 rw-p 00000000 00:00
0                          [stack]
 7fff6f3fe000-7fff6f400000 r-xp 00000000 00:00
0                          [vdso]
 ffffffffff600000-ffffffffff601000 r-xp 00000000 00:00
0                  [vsyscall]
ProcStatus:
 Name:    apportcheckresu
 State:    R (running)
 Tgid:    1197
 Ngid:    0
 Pid:    1197
 PPid:    1140
 TracerPid:    0
 Uid:    0    0    0    0
 Gid:    0    0    0    0
 FDSize:    64
 Groups:    0
 VmPeak:       64616 kB
 VmSize:       64616 kB
 VmLck:           0 kB
 VmPin:           0 kB
 VmHWM:       14592 kB
 VmRSS:       14592 kB
 VmData:        8996 kB
 VmStk:         136 kB
 VmExe:        3188 kB
 VmLib:        8276 kB
 VmPTE:         144 kB
 VmSwap:           0 kB
 Threads:    1
 SigQ:    0/62478
 SigPnd:    0000000000000000
 ShdPnd:    0000000000000000
 SigBlk:    0000000000000000
 SigIgn:    0000000001001000
 SigCgt:    0000000180000002
 CapInh:    0000000000000000
 CapPrm:    0000001fffffffff
 CapEff:    0000001fffffffff
 CapBnd:    0000001fffffffff
 Seccomp:    0
 Cpus_allowed:    ff
 Cpus_allowed_list:    0-7
 Mems_allowed:    00000000,00000001
 Mems_allowed_list:    0
 voluntary_ctxt_switches:    231
 nonvoluntary_ctxt_switches:    26

SleepLog:

 
 Mon Jan 20 18:06:45 CST 2014: Running hooks for suspend.
 Running hook /usr/lib/pm-utils/sleep.d/000kernel-change suspend suspend:
 /usr/lib/pm-utils/sleep.d/000kernel-change suspend suspend: success.
 
 Running hook /usr/lib/pm-utils/sleep.d/000record-status suspend suspend:
 /usr/lib/pm-utils/sleep.d/000record-status suspend suspend: success.
 
 Running hook /usr/lib/pm-utils/sleep.d/00logging suspend suspend:
 Linux adam-vaio-lin 3.13.0-031300-generic #201401192235 SMP Mon Jan 20
03:36:48 UTC 2014 x86_64 x86_64 x86_64 GNU/Linux
 Module                  Size  Used by
 nls_iso8859_1          12713  1
 ip6table_filter        12815  0
 ip6_tables             27502  1 ip6table_filter
 iptable_filter         12810  0
 ip_tables              27716  1 iptable_filter
 x_tables               34194  4
ip6table_filter,ip_tables,iptable_filter,ip6_tables
 md4                    12595  0
 ctr                    13193  2
 ccm                    17856  2
 joydev                 17575  0
 snd_hda_codec_hdmi     46898  4
 coretemp               17728  0
 kvm_intel             144426  0
 arc4                   12573  2
 kvm                   468147  1 kvm_intel
 parport_pc             36962  0
 ppdev                  17711  0
 ath9k                 166504  0
 uvcvideo               82247  0
 ath9k_common           13551  1 ath9k
 ath9k_hw              462940  2 ath9k_common,ath9k
 videobuf2_vmalloc      13216  1 uvcvideo
 videobuf2_memops       13362  1 videobuf2_vmalloc
 videobuf2_core         40972  1 uvcvideo
 ath                    29145  3 ath9k_common,ath9k,ath9k_hw
 videodev              139761  2 uvcvideo,videobuf2_core
 bnep                   19884  2
 mac80211              654124  1 ath9k
 rfcomm                 74748  12
 snd_hda_codec_realtek    61978  1
 dm_multipath           27401  0
 btusb                  28326  0
 cfg80211              509407  3 ath,ath9k,mac80211
 psmouse               108513  0
 scsi_dh                14873  1 dm_multipath
 bluetooth             411140  22 bnep,btusb,rfcomm
 snd_hda_intel          57222  5
 snd_seq_midi           13324  0
 microcode              23788  0
 snd_hda_codec         199156  3
snd_hda_codec_realtek,snd_hda_codec_hdmi,snd_hda_intel
 snd_seq_midi_event     14899  1 snd_seq_midi
 i7core_edac            24565  0
 serio_raw              13462  0
 snd_rawmidi            30465  1 snd_seq_midi
 edac_core              62944  1 i7core_edac
 snd_hwdep              13613  1 snd_hda_codec
 snd_pcm               107140  3
snd_hda_codec_hdmi,snd_hda_codec,snd_hda_intel
 snd_seq                66061  2 snd_seq_midi_event,snd_seq_midi
 snd_seq_device         14497  3 snd_seq,snd_rawmidi,snd_seq_midi
 snd_page_alloc         18798  2 snd_pcm,snd_hda_intel
 snd_timer              30038  2 snd_pcm,snd_seq
 snd                    73850  21
snd_hda_codec_realtek,snd_hwdep,snd_timer,snd_hda_codec_hdmi,snd_pcm,snd_seq,snd_rawmidi,snd_hda_codec,snd_hda_intel,snd_seq_device,snd_seq_midi
 mac_hid                13253  0
 lpc_ich                21163  0
 soundcore              12680  1 snd
 sony_laptop            54937  0
 binfmt_misc            17508  1
 lp                     17799  0
 parport                42481  3 lp,ppdev,parport_pc
 nls_utf8               12557  2
 cifs                  470343  4
 fscache                64282  1 cifs
 xts                    12951  2
 gf128mul               14951  1 xts
 dm_crypt               23417  2
 hid_generic            12548  0
 usbhid                 53067  0
 hid                   106254  2 hid_generic,usbhid
 mmc_block              36435  2
 nouveau              1115818  3
 mxm_wmi                13021  1 nouveau
 wmi                    19363  2 mxm_wmi,nouveau
 i2c_algo_bit           13564  1 nouveau
 ttm                    89884  1 nouveau
 drm_kms_helper         53224  1 nouveau
 sky2                   63205  0
 firewire_ohci          45158  0
 ahci                   30063  3
 drm                   308397  5 ttm,drm_kms_helper,nouveau
 firewire_core          69362  1 firewire_ohci
 sdhci_pci              19241  0
 libahci                32277  1 ahci
 sdhci                  43409  1 sdhci_pci
 crc_itu_t              12707  1 firewire_core
 video                  19859  1 nouveau
              total       used       free     shared    buffers     cached
 Mem:       8027152    2445340    5581812          0      87620     791112
 -/+ buffers/cache:    1566608    6460544
 Swap:      8388604          0    8388604
 /usr/lib/pm-utils/sleep.d/00logging suspend suspend: success.
 
 Running hook /usr/lib/pm-utils/sleep.d/00powersave suspend suspend:
 /usr/lib/pm-utils/sleep.d/00powersave suspend suspend: success.
 
 Running hook /etc/pm/sleep.d/10_grub-common suspend suspend:
 /etc/pm/sleep.d/10_grub-common suspend suspend: success.
 
 Running hook /etc/pm/sleep.d/10_unattended-upgrades-hibernate suspend
suspend:
 /etc/pm/sleep.d/10_unattended-upgrades-hibernate suspend suspend: success.
 
 Running hook /usr/lib/pm-utils/sleep.d/50unload_alx suspend suspend:
 /usr/lib/pm-utils/sleep.d/50unload_alx suspend suspend: success.
 
 Running hook /usr/lib/pm-utils/sleep.d/60_wpa_supplicant suspend suspend:
 Selected interface 'wlan0'
 OK
 /usr/lib/pm-utils/sleep.d/60_wpa_supplicant suspend suspend: success.
 
 Running hook /usr/lib/pm-utils/sleep.d/75modules suspend suspend:
 /usr/lib/pm-utils/sleep.d/75modules suspend suspend: not applicable.
 
 Running hook /usr/lib/pm-utils/sleep.d/90clock suspend suspend:
 /usr/lib/pm-utils/sleep.d/90clock suspend suspend: not applicable.
 
 Running hook /usr/lib/pm-utils/sleep.d/94cpufreq suspend suspend:
 /usr/lib/pm-utils/sleep.d/94cpufreq suspend suspend: success.
 
 Running hook /usr/lib/pm-utils/sleep.d/95anacron suspend suspend:
 stop: Unknown instance:
 /usr/lib/pm-utils/sleep.d/95anacron suspend suspend: success.
 
 Running hook /usr/lib/pm-utils/sleep.d/95hdparm-apm suspend suspend:
 /usr/lib/pm-utils/sleep.d/95hdparm-apm suspend suspend: not applicable.
 
 Running hook /usr/lib/pm-utils/sleep.d/95led suspend suspend:
 /usr/lib/pm-utils/sleep.d/95led suspend suspend: not applicable.
 
 Running hook /usr/lib/pm-utils/sleep.d/98video-quirk-db-handler suspend
suspend:
 Kernel modesetting video driver detected, not using quirks.
 /usr/lib/pm-utils/sleep.d/98video-quirk-db-handler suspend suspend:
success.
 
 Running hook /usr/lib/pm-utils/sleep.d/99video suspend suspend:
 kernel.acpi_video_flags = 0
 /usr/lib/pm-utils/sleep.d/99video suspend suspend: success.
 
 Running hook /etc/pm/sleep.d/novatel_3g_suspend suspend suspend:
 /etc/pm/sleep.d/novatel_3g_suspend suspend suspend: success.
 
 Mon Jan 20 18:06:45 CST 2014: performing suspend
Tags: resume suspend

Uname: Linux 3.13.0-031300-generic x86_64
UserGroups:
ApportVersion: 2.12.5-0ubuntu2.2

6. Shell Script:
[n/a]

7.1 Software
[/usr/src/linux-headers-<version>/scripts ... cd here and go sh ver_linux ]

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux adam-vaio-lin 3.13.0-031300-generic #201401192235 SMP Mon Jan 20
03:36:48 UTC 2014 x86_64 x86_64 x86_64 GNU/Linux
 
Gnu C                  4.8
Gnu make               3.81
binutils               2.23.52.20130913
util-linux             2.20.1
mount                  support
module-init-tools      9
e2fsprogs              1.42.8
pcmciautils            018
PPP                    2.4.5
Linux C Library        2.17
Dynamic linker (ldd)   2.17
Procps                 3.3.3
Net-tools              1.60
Kbd                    1.15.5
Sh-utils               8.20
wireless-tools         30
Modules Loaded         nls_iso8859_1 ip6table_filter ip6_tables
iptable_filter ip_tables x_tables md4 ctr ccm joydev snd_hda_codec_hdmi
coretemp kvm_intel arc4 kvm parport_pc ppdev ath9k uvcvideo ath9k_common
ath9k_hw videobuf2_vmalloc videobuf2_memops videobuf2_core ath videodev
bnep mac80211 rfcomm snd_hda_codec_realtek dm_multipath btusb cfg80211
psmouse scsi_dh bluetooth snd_hda_intel snd_seq_midi microcode
snd_hda_codec snd_seq_midi_event i7core_edac serio_raw snd_rawmidi
edac_core snd_hwdep snd_pcm snd_seq snd_seq_device snd_page_alloc
snd_timer snd mac_hid lpc_ich soundcore sony_laptop binfmt_misc lp
parport nls_utf8 cifs fscache xts gf128mul dm_crypt hid_generic usbhid
hid mmc_block nouveau mxm_wmi wmi i2c_algo_bit ttm drm_kms_helper sky2
firewire_ohci ahci drm firewire_core sdhci_pci libahci sdhci crc_itu_t video



7.2 Processor information
[cat /proc/cpuinfo]

processor    : 0
vendor_id    : GenuineIntel
cpu family    : 6
model        : 30
model name    : Intel(R) Core(TM) i7 CPU       Q 820  @ 1.73GHz
stepping    : 5
microcode    : 0x3
cpu MHz        : 1199.000
cache size    : 8192 KB
physical id    : 0
siblings    : 8
core id        : 0
cpu cores    : 4
apicid        : 0
initial apicid    : 0
fpu        : yes
fpu_exception    : yes
cpuid level    : 11
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall
nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology
nonstop_tsc aperfmperf pni dtes64 monitor ds_cpl vmx smx est tm2 ssse3
cx16 xtpr pdcm sse4_1 sse4_2 popcnt lahf_lm ida dtherm tpr_shadow vnmi
flexpriority ept vpid
bogomips    : 3458.21
clflush size    : 64
cache_alignment    : 64
address sizes    : 36 bits physical, 48 bits virtual
power management:

[the other 7 processor entries have been truncated for space]



7.3 Module information
[cat /proc/modules]

nls_iso8859_1 12713 1 - Live 0x0000000000000000
ip6table_filter 12815 0 - Live 0x0000000000000000
ip6_tables 27502 1 ip6table_filter, Live 0x0000000000000000
iptable_filter 12810 0 - Live 0x0000000000000000
ip_tables 27716 1 iptable_filter, Live 0x0000000000000000
x_tables 34194 4 ip6table_filter,ip6_tables,iptable_filter,ip_tables,
Live 0x0000000000000000
md4 12595 0 - Live 0x0000000000000000
ctr 13193 2 - Live 0x0000000000000000
ccm 17856 2 - Live 0x0000000000000000
joydev 17575 0 - Live 0x0000000000000000
snd_hda_codec_hdmi 46898 4 - Live 0x0000000000000000
coretemp 17728 0 - Live 0x0000000000000000
kvm_intel 144426 0 - Live 0x0000000000000000
arc4 12573 2 - Live 0x0000000000000000
kvm 468147 1 kvm_intel, Live 0x0000000000000000
parport_pc 36962 0 - Live 0x0000000000000000
ppdev 17711 0 - Live 0x0000000000000000
ath9k 166504 0 - Live 0x0000000000000000
uvcvideo 82247 0 - Live 0x0000000000000000
ath9k_common 13551 1 ath9k, Live 0x0000000000000000
ath9k_hw 462940 2 ath9k,ath9k_common, Live 0x0000000000000000
videobuf2_vmalloc 13216 1 uvcvideo, Live 0x0000000000000000
videobuf2_memops 13362 1 videobuf2_vmalloc, Live 0x0000000000000000
videobuf2_core 40972 1 uvcvideo, Live 0x0000000000000000
ath 29145 3 ath9k,ath9k_common,ath9k_hw, Live 0x0000000000000000
videodev 139761 2 uvcvideo,videobuf2_core, Live 0x0000000000000000
bnep 19884 2 - Live 0x0000000000000000
mac80211 654124 1 ath9k, Live 0x0000000000000000
rfcomm 74748 12 - Live 0x0000000000000000
snd_hda_codec_realtek 61978 1 - Live 0x0000000000000000
dm_multipath 27401 0 - Live 0x0000000000000000
btusb 28326 0 - Live 0x0000000000000000
cfg80211 509407 3 ath9k,ath,mac80211, Live 0x0000000000000000
psmouse 108513 0 - Live 0x0000000000000000
scsi_dh 14873 1 dm_multipath, Live 0x0000000000000000
bluetooth 411140 22 bnep,rfcomm,btusb, Live 0x0000000000000000
snd_hda_intel 57222 5 - Live 0x0000000000000000
snd_seq_midi 13324 0 - Live 0x0000000000000000
microcode 23788 0 - Live 0x0000000000000000
snd_hda_codec 199156 3
snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_intel, Live
0x0000000000000000
snd_seq_midi_event 14899 1 snd_seq_midi, Live 0x0000000000000000
i7core_edac 24565 0 - Live 0x0000000000000000
serio_raw 13462 0 - Live 0x0000000000000000
snd_rawmidi 30465 1 snd_seq_midi, Live 0x0000000000000000
edac_core 62944 1 i7core_edac, Live 0x0000000000000000
snd_hwdep 13613 1 snd_hda_codec, Live 0x0000000000000000
snd_pcm 107140 3 snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec, Live
0x0000000000000000
snd_seq 66061 2 snd_seq_midi,snd_seq_midi_event, Live 0x0000000000000000
snd_seq_device 14497 3 snd_seq_midi,snd_rawmidi,snd_seq, Live
0x0000000000000000
snd_page_alloc 18798 2 snd_hda_intel,snd_pcm, Live 0x0000000000000000
snd_timer 30038 2 snd_pcm,snd_seq, Live 0x0000000000000000
snd 73850 21
snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_intel,snd_seq_midi,snd_hda_codec,snd_rawmidi,snd_hwdep,snd_pcm,snd_seq,snd_seq_device,snd_timer,
Live 0x0000000000000000
mac_hid 13253 0 - Live 0x0000000000000000
lpc_ich 21163 0 - Live 0x0000000000000000
soundcore 12680 1 snd, Live 0x0000000000000000
sony_laptop 54937 0 - Live 0x0000000000000000
binfmt_misc 17508 1 - Live 0x0000000000000000
lp 17799 0 - Live 0x0000000000000000
parport 42481 3 parport_pc,ppdev,lp, Live 0x0000000000000000
nls_utf8 12557 2 - Live 0x0000000000000000
cifs 470343 4 - Live 0x0000000000000000
fscache 64282 1 cifs, Live 0x0000000000000000
xts 12951 2 - Live 0x0000000000000000
gf128mul 14951 1 xts, Live 0x0000000000000000
dm_crypt 23417 2 - Live 0x0000000000000000
hid_generic 12548 0 - Live 0x0000000000000000
usbhid 53067 0 - Live 0x0000000000000000
hid 106254 2 hid_generic,usbhid, Live 0x0000000000000000
mmc_block 36435 2 - Live 0x0000000000000000
nouveau 1115818 3 - Live 0x0000000000000000
mxm_wmi 13021 1 nouveau, Live 0x0000000000000000
wmi 19363 2 nouveau,mxm_wmi, Live 0x0000000000000000
i2c_algo_bit 13564 1 nouveau, Live 0x0000000000000000
ttm 89884 1 nouveau, Live 0x0000000000000000
drm_kms_helper 53224 1 nouveau, Live 0x0000000000000000
sky2 63205 0 - Live 0x0000000000000000
firewire_ohci 45158 0 - Live 0x0000000000000000
ahci 30063 3 - Live 0x0000000000000000
drm 308397 5 nouveau,ttm,drm_kms_helper, Live 0x0000000000000000
firewire_core 69362 1 firewire_ohci, Live 0x0000000000000000
sdhci_pci 19241 0 - Live 0x0000000000000000
libahci 32277 1 ahci, Live 0x0000000000000000
sdhci 43409 1 sdhci_pci, Live 0x0000000000000000
crc_itu_t 12707 1 firewire_core, Live 0x0000000000000000
video 19859 1 nouveau, Live 0x0000000000000000



7.4 Loaded drive and hardware information
[cat /proc/ioports]

0000-0cf7 : PCI Bus 0000:00
  0000-001f : dma1
  0020-0021 : pic1
  0040-0043 : timer0
  0050-0053 : timer1
  0060-0060 : keyboard
  0062-0062 : EC data
  0064-0064 : keyboard
  0066-0066 : EC cmd
  0070-0077 : rtc0
  0080-008f : dma page reg
  00a0-00a1 : pic2
  00c0-00df : dma2
  00f0-00ff : fpu
  0400-0403 : ACPI PM1a_EVT_BLK
  0404-0405 : ACPI PM1a_CNT_BLK
  0408-040b : ACPI PM_TMR
  0410-0415 : ACPI CPU throttle
  0420-042f : ACPI GPE0_BLK
  0430-0433 : iTCO_wdt
  0450-0450 : ACPI PM2_CNT_BLK
  0460-047f : iTCO_wdt
  0500-057f : pnp 00:04
  0680-069f : pnp 00:04
  0800-0803 : pnp 00:04
0cf8-0cff : PCI conf1
0d00-ffff : PCI Bus 0000:00
  164e-164f : pnp 00:04
  9000-9fff : PCI Bus 0000:05
  a000-afff : PCI Bus 0000:04
    a000-a0ff : 0000:04:00.0
      a000-a0ff : sky2
  b000-bfff : PCI Bus 0000:03
  c000-cfff : PCI Bus 0000:02
  d000-dfff : PCI Bus 0000:01
    d000-d07f : 0000:01:00.0
  e000-e01f : 0000:00:1f.3
  e020-e03f : 0000:00:1f.2
    e020-e03f : ahci
  e040-e043 : 0000:00:1f.2
    e040-e043 : ahci
  e050-e057 : 0000:00:1f.2
    e050-e057 : ahci
  e060-e063 : 0000:00:1f.2
    e060-e063 : ahci
  e070-e077 : 0000:00:1f.2
    e070-e077 : ahci
  ff00-ff0f : pnp 00:04
  ff10-ff13 : pnp 00:04



7.5 PCI information
[sudo lspci -vvv]

00:00.0 Host bridge: Intel Corporation Core Processor DMI (rev 11)
    Subsystem: Sony Corporation Device 9067
    Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Capabilities: [40] #00 [0000]

00:03.0 PCI bridge: Intel Corporation Core Processor PCI Express Root
Port 1 (rev 11) (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
    I/O behind bridge: 0000d000-0000dfff
    Memory behind bridge: d0000000-e30fffff
    Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
    BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Capabilities: [40] Subsystem: Sony Corporation Device 9067
    Capabilities: [60] MSI: Enable- Count=1/2 Maskable+ 64bit-
        Address: 00000020  Data: 0000
        Masking: 00000000  Pending: 00000000
    Capabilities: [90] Express (v2) Root Port (Slot+), MSI 00
        DevCap:    MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns,
L1 <1us
            ExtTag+ RBE+ FLReset-
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr- UncorrErr+ FatalErr- UnsuppReq- AuxPwr-
TransPend-
        LnkCap:    Port #3, Speed 5GT/s, Width x16, ASPM L0s L1, Latency
L0 <512ns, L1 <4us
            ClockPM- Surprise+ LLActRep+ BwNot+
        LnkCtl:    ASPM L0s L1 Enabled; RCB 64 bytes Disabled- Retrain-
CommClk+
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 5GT/s, Width x16, TrErr- Train- SlotClk+
DLActive+ BWMgmt+ ABWMgmt-
        SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug-
Surprise-
            Slot #19, PowerLimit 0.000W; Interlock- NoCompl-
        SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt-
HPIrq- LinkChg-
            Control: AttnInd Off, PwrInd Off, Power- Interlock-
        SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet-
Interlock-
            Changed: MRL- PresDet- LinkState-
        RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna-
CRSVisible-
        RootCap: CRSVisible-
        RootSta: PME ReqID 0000, PMEStatus- PMEPending-
        DevCap2: Completion Timeout: Range BCD, TimeoutDis+ ARIFwd+
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
        LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-,
Selectable De-emphasis: -3.5dB
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete-, EqualizationPhase1-
             EqualizationPhase2-, EqualizationPhase3-,
LinkEqualizationRequest-
    Capabilities: [e0] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [100 v1] Advanced Error Reporting
        UESta:    DLP- SDES- TLP- FCP- CmpltTO+ CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt-
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
        CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
        CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
        AERCap:    First Error Pointer: 0e, GenCap- CGenEn- ChkCap- ChkEn-
    Capabilities: [150 v1] Access Control Services
        ACSCap:    SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+
UpstreamFwd+ EgressCtrl- DirectTrans-
        ACSCtl:    SrcValid- TransBlk- ReqRedir- CmpltRedir-
UpstreamFwd- EgressCtrl- DirectTrans-
    Capabilities: [160 v0] Vendor Specific Information: ID=0002 Rev=0
Len=00c <?>
    Kernel driver in use: pcieport

00:08.0 System peripheral: Intel Corporation Core Processor System
Management Registers (rev 11)
    Subsystem: Device 004d:0067
    Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Capabilities: [40] Express (v2) Root Complex Integrated Endpoint, MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns,
L1 <1us
            ExtTag- RBE+ FLReset-
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr-
TransPend-
        LnkCap:    Port #0, Speed unknown, Width x0, ASPM L0s, Latency
L0 unlimited, L1 unlimited
            ClockPM- Surprise+ LLActRep+ BwNot+
        LnkCtl:    ASPM Disabled; Disabled- Retrain- CommClk-
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed unknown, Width x0, TrErr- Train- SlotClk+
DLActive- BWMgmt- ABWMgmt-
        DevCap2: Completion Timeout: Not Supported, TimeoutDis-
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
        LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-,
Selectable De-emphasis: -6dB
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-,
EqualizationPhase1-
             EqualizationPhase2-, EqualizationPhase3-,
LinkEqualizationRequest-
    Capabilities: [100 v0] Vendor Specific Information: ID=0000 Rev=0
Len=000 <?>

00:08.1 System peripheral: Intel Corporation Core Processor Semaphore
and Scratchpad Registers (rev 11)
    Subsystem: Device 004d:0067
    Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Capabilities: [40] Express (v2) Root Complex Integrated Endpoint, MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns,
L1 <1us
            ExtTag- RBE+ FLReset-
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr-
TransPend-
        LnkCap:    Port #0, Speed unknown, Width x0, ASPM L0s, Latency
L0 unlimited, L1 unlimited
            ClockPM- Surprise+ LLActRep+ BwNot+
        LnkCtl:    ASPM Disabled; Disabled- Retrain- CommClk-
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed unknown, Width x0, TrErr- Train- SlotClk+
DLActive- BWMgmt- ABWMgmt-
        DevCap2: Completion Timeout: Not Supported, TimeoutDis-
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
        LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-,
Selectable De-emphasis: -6dB
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-,
EqualizationPhase1-
             EqualizationPhase2-, EqualizationPhase3-,
LinkEqualizationRequest-
    Capabilities: [100 v0] Vendor Specific Information: ID=0000 Rev=0
Len=000 <?>

00:08.2 System peripheral: Intel Corporation Core Processor System
Control and Status Registers (rev 11)
    Subsystem: Device 004d:0067
    Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Capabilities: [40] Express (v2) Root Complex Integrated Endpoint, MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns,
L1 <1us
            ExtTag- RBE+ FLReset-
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr-
TransPend-
        LnkCap:    Port #0, Speed unknown, Width x0, ASPM L0s, Latency
L0 unlimited, L1 unlimited
            ClockPM- Surprise+ LLActRep+ BwNot+
        LnkCtl:    ASPM Disabled; Disabled- Retrain- CommClk-
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed unknown, Width x0, TrErr- Train- SlotClk+
DLActive- BWMgmt- ABWMgmt-
        DevCap2: Completion Timeout: Not Supported, TimeoutDis-
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
        LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-,
Selectable De-emphasis: -6dB
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-,
EqualizationPhase1-
             EqualizationPhase2-, EqualizationPhase3-,
LinkEqualizationRequest-
    Capabilities: [100 v0] Vendor Specific Information: ID=0000 Rev=0
Len=000 <?>

00:08.3 System peripheral: Intel Corporation Core Processor
Miscellaneous Registers (rev 11)
    Subsystem: Device 004d:0067
    Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

00:10.0 System peripheral: Intel Corporation Core Processor QPI Link
(rev 11)
    Subsystem: Device 004d:0067
    Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

00:10.1 System peripheral: Intel Corporation Core Processor QPI Routing
and Protocol Registers (rev 11)
    Subsystem: Device 004d:0067
    Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

00:1a.0 USB controller: Intel Corporation 5 Series/3400 Series Chipset
USB2 Enhanced Host Controller (rev 05) (prog-if 20 [EHCI])
    Subsystem: Sony Corporation Device 9067
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin A routed to IRQ 16
    Region 0: Memory at e8e08000 (32-bit, non-prefetchable) [size=1K]
    Capabilities: [50] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [58] Debug port: BAR=1 offset=00a0
    Capabilities: [98] PCI Advanced Features
        AFCap: TP+ FLR+
        AFCtrl: FLR-
        AFStatus: TP-
    Kernel driver in use: ehci-pci

[audio device info removed for space]

00:1c.0 PCI bridge: Intel Corporation 5 Series/3400 Series Chipset PCI
Express Root Port 1 (rev 05) (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
    I/O behind bridge: 0000c000-0000cfff
    Memory behind bridge: e7a00000-e8dfffff
    Prefetchable memory behind bridge: 00000000e8f00000-00000000e90fffff
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
    BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns,
L1 <1us
            ExtTag- RBE+ FLReset-
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+
TransPend-
        LnkCap:    Port #1, Speed 2.5GT/s, Width x1, ASPM L0s L1,
Latency L0 <256ns, L1 <4us
            ClockPM- Surprise- LLActRep+ BwNot-
        LnkCtl:    ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
DLActive+ BWMgmt- ABWMgmt-
        SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+
Surprise+
            Slot #0, PowerLimit 10.000W; Interlock- NoCompl+
        SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt-
HPIrq- LinkChg-
            Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
        SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+
Interlock-
            Changed: MRL- PresDet+ LinkState+
        RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna-
CRSVisible-
        RootCap: CRSVisible-
        RootSta: PME ReqID 0000, PMEStatus- PMEPending-
        DevCap2: Completion Timeout: Range BC, TimeoutDis+ ARIFwd-
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
        LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-,
Selectable De-emphasis: -6dB
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-,
EqualizationPhase1-
             EqualizationPhase2-, EqualizationPhase3-,
LinkEqualizationRequest-
    Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
        Address: 00000000  Data: 0000
    Capabilities: [90] Subsystem: Sony Corporation Device 9067
    Capabilities: [a0] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Kernel driver in use: pcieport


[3 additional PCI bridge entries similar to above removed for space]

00:1d.0 USB controller: Intel Corporation 5 Series/3400 Series Chipset
USB2 Enhanced Host Controller (rev 05) (prog-if 20 [EHCI])
    Subsystem: Sony Corporation Device 9067
    [USB controller information truncated for space]
    Kernel driver in use: ehci-pci

00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev a5)
(prog-if 01 [Subtractive decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Bus: primary=00, secondary=0d, subordinate=0d, sec-latency=32
    I/O behind bridge: 0000f000-00000fff
    Memory behind bridge: fff00000-000fffff
    Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
    Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
    BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Capabilities: [50] Subsystem: Sony Corporation Device 9067

00:1f.0 ISA bridge: Intel Corporation Mobile 5 Series Chipset LPC
Interface Controller (rev 05)
    Subsystem: Sony Corporation Device 9067
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Capabilities: [e0] Vendor Specific Information: Len=10 <?>
    Kernel driver in use: lpc_ich

00:1f.2 SATA controller: Intel Corporation 5 Series/3400 Series Chipset
6 port SATA AHCI Controller (rev 05) (prog-if 01 [AHCI 1.0])
    Subsystem: Sony Corporation Device 9067
    [truncated for length]
    Kernel driver in use: ahci

00:1f.3 SMBus: Intel Corporation 5 Series/3400 Series Chipset SMBus
Controller (rev 05)
    Subsystem: Sony Corporation Device 9067
    Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Interrupt: pin C routed to IRQ 4
    Region 0: Memory at e8e05000 (64-bit, non-prefetchable) [size=256]
    Region 4: I/O ports at e000 [size=32]

01:00.0 VGA compatible controller: NVIDIA Corporation GT216M [GeForce GT
330M] (rev a2) (prog-if 00 [VGA controller])
    Subsystem: Sony Corporation Device 9067
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
    [Video card information truncated for space]
    Capabilities: [128 v1] Power Budgeting <?>
    Capabilities: [600 v1] Vendor Specific Information: ID=0001 Rev=1
Len=024 <?>
    Kernel driver in use: nouveau

[audio device info here removed for space]

02:00.0 Network controller: Qualcomm Atheros AR9287 Wireless Network
Adapter (PCI-Express) (rev 01)
    Subsystem: Foxconn International, Inc. Device e030
[network controller info here truncated for space]
    Kernel driver in use: ath9k

03:00.0 SD Host controller: Ricoh Co Ltd MMC/SD Host Controller
    [SD controller truncated for space]

03:00.1 System peripheral: Ricoh Co Ltd R5U2xx (R5U230 / R5U231 /
R5U241) [Memory Stick Host Controller]
    Subsystem: Sony Corporation Device 9067
[memory stick info truncated for space]

03:00.3 FireWire (IEEE 1394): Ricoh Co Ltd R5C832 PCIe IEEE 1394
Controller (prog-if 10 [OHCI])
    Subsystem: Sony Corporation Device 9067
[firewire info truncated for space]
    Kernel driver in use: firewire_ohci

03:00.4 SD Host controller: Ricoh Co Ltd MMC/SD Host Controller
    Subsystem: Sony Corporation Device 9067
[SD info truncated for space]
    Kernel driver in use: sdhci-pci

04:00.0 Ethernet controller: Marvell Technology Group Ltd. 88E8057 PCI-E
Gigabit Ethernet Controller (rev 10)
    Subsystem: Sony Corporation Device 9067
    [ethernet controller info truncated for space]
    Kernel driver in use: sky2

3f:00.0 Host bridge: Intel Corporation Core Processor QuickPath
Architecture Generic Non-Core Registers (rev 04)
    Subsystem: Sony Corporation Device 9067
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0

3f:00.1 Host bridge: Intel Corporation Core Processor QuickPath
Architecture System Address Decoder (rev 04)
    Subsystem: Sony Corporation Device 9067
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0

3f:02.0 Host bridge: Intel Corporation Core Processor QPI Link 0 (rev 04)
    Subsystem: Sony Corporation Device 9067
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0

3f:02.1 Host bridge: Intel Corporation Core Processor QPI Physical 0
(rev 04)
    Subsystem: Sony Corporation Device 9067
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0

3f:03.0 Host bridge: Intel Corporation Core Processor Integrated Memory
Controller (rev 04)
    Subsystem: Sony Corporation Device 9067
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0

3f:03.1 Host bridge: Intel Corporation Core Processor Integrated Memory
Controller Target Address Decoder (rev 04)
    Subsystem: Sony Corporation Device 9067
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0

3f:03.4 Host bridge: Intel Corporation Core Processor Integrated Memory
Controller Test Registers (rev 04)
    Subsystem: Sony Corporation Device 9067
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0

3f:04.0 Host bridge: Intel Corporation Core Processor Integrated Memory
Controller Channel 0 Control Registers (rev 04)
    Subsystem: Sony Corporation Device 9067
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0

3f:04.1 Host bridge: Intel Corporation Core Processor Integrated Memory
Controller Channel 0 Address Registers (rev 04)
    Subsystem: Sony Corporation Device 9067
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0

3f:04.2 Host bridge: Intel Corporation Core Processor Integrated Memory
Controller Channel 0 Rank Registers (rev 04)
    Subsystem: Sony Corporation Device 9067
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0

3f:04.3 Host bridge: Intel Corporation Core Processor Integrated Memory
Controller Channel 0 Thermal Control Registers (rev 04)
    Subsystem: Sony Corporation Device 9067
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0

[list of four "Channel 1" registers, similar to the four above, removed
for space]




7.6 SCSI information
[cat /proc/scsi/scsi]

Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: OCZ-VERTEX2      Rev: 1.32
  Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: MATSHITA Model: BD-MLT UJ240AS   Rev: 1.10
  Type:   CD-ROM                           ANSI  SCSI revision: 05


X.Additional Information:

1. Full Computer model:

Sony Vaio VCPF119HX


2. BIOS upgrade?:

BIOS is current, last manufacturer's update was in 2010.


3. Output of cat /proc/acpi/wakeup > wakeup

Device    S-state      Status   Sysfs node
P0PF      S4    *disabled  pci:0000:00:1e.0
USB1      S3    *disabled
USB2      S3    *disabled
USB3      S3    *disabled
USB4      S3    *disabled
USB5      S3    *disabled
USB6      S3    *disabled
USB7      S3    *disabled
HDEF      S4    *disabled  pci:0000:00:1b.0
RP01      S3    *disabled  pci:0000:00:1c.0
PXSX      S3    *disabled  pci:0000:02:00.0
RP03      S3    *disabled  pci:0000:00:1c.2
PXSX      S3    *enabled   pci:0000:04:00.0
EHC1      S3    *enabled   pci:0000:00:1d.0
EHC2      S3    *enabled   pci:0000:00:1a.0
RP06      S3    *disabled  pci:0000:00:1c.5
PXSX      S3    *disabled
PWRB      S4    *enabled

4. Suspend dmesg entry during trial described at
https://wiki.ubuntu.com/DebuggingKernelSuspend :

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 3.13.0-031300-generic (apw@gomeisa) (gcc
version 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201401192235 SMP Mon Jan
20 03:36:48 UTC 2014
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-3.13.0-031300-generic
root=UUID=0b979894-b551-4ac1-8dc3-04a316602bf5 ro acpi_osi=Linux
i8042.reset crashkernel=384M-2G:64M,2G-:128M quiet splash
acpi_backlight=vendor i8042.reset vt.handoff=7
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Centaur CentaurHauls
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009e7ff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009e800-0x000000000009ffff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff]
reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000cee74fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000cee75000-0x00000000ceeb4fff]
ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000ceeb5000-0x00000000ceec5fff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000ceec6000-0x00000000ceedbfff]
ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000ceedc000-0x00000000cef0bfff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000cef0c000-0x00000000cef0cfff]
ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000cef0d000-0x00000000cef0ffff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000cef10000-0x00000000cef11fff]
ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000cef12000-0x00000000cef15fff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000cef16000-0x00000000cef18fff]
ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000cef19000-0x00000000cef1cfff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000cef1d000-0x00000000cef2bfff]
ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000cef2c000-0x00000000cfffffff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed1b000-0x00000000fed1ffff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000ffa00000-0x00000000ffbfffff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000ffe00000-0x00000000ffffffff]
reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000022fffffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.6 present.
[    0.000000] DMI: Sony Corporation VPCF119HX/VAIO, BIOS R0280Y6 05/14/2010
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] No AGP bridge found
[    0.000000] e820: last_pfn = 0x230000 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-D3FFF write-protect
[    0.000000]   D4000-E7FFF uncachable
[    0.000000]   E8000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000 mask F80000000 write-back
[    0.000000]   1 base 080000000 mask FC0000000 write-back
[    0.000000]   2 base 0C0000000 mask FF0000000 write-back
[    0.000000]   3 base 100000000 mask F00000000 write-back
[    0.000000]   4 base 200000000 mask FC0000000 write-back
[    0.000000]   5 base 230000000 mask FF0000000 uncachable
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new
0x7010600070106
[    0.000000] original variable MTRRs
[    0.000000] reg 0, base: 0GB, range: 2GB, type WB
[    0.000000] reg 1, base: 2GB, range: 1GB, type WB
[    0.000000] reg 2, base: 3GB, range: 256MB, type WB
[    0.000000] reg 3, base: 4GB, range: 4GB, type WB
[    0.000000] reg 4, base: 8GB, range: 1GB, type WB
[    0.000000] reg 5, base: 8960MB, range: 256MB, type UC
[    0.000000] total RAM covered: 8192M
[    0.000000] Found optimal setting for mtrr clean up
[    0.000000]  gran_size: 64K     chunk_size: 64K     num_reg: 6     
lose cover RAM: 0G
[    0.000000] New variable MTRRs
[    0.000000] reg 0, base: 0GB, range: 2GB, type WB
[    0.000000] reg 1, base: 2GB, range: 1GB, type WB
[    0.000000] reg 2, base: 3GB, range: 256MB, type WB
[    0.000000] reg 3, base: 4GB, range: 4GB, type WB
[    0.000000] reg 4, base: 8GB, range: 512MB, type WB
[    0.000000] reg 5, base: 8704MB, range: 256MB, type WB
[    0.000000] e820: update [mem 0xd0000000-0xffffffff] usable ==> reserved
[    0.000000] e820: last_pfn = 0xcee75 max_arch_pfn = 0x400000000
[    0.000000] found SMP MP-table at [mem 0x000fc980-0x000fc98f] mapped
at [ffff8800000fc980]
[    0.000000] Scanning 1 areas for low memory corruption
[    0.000000] Base memory trampoline at [ffff880000098000] 98000 size 24576
[    0.000000] init_memory_mapping: [mem 0x00000000-0x000fffff]
[    0.000000]  [mem 0x00000000-0x000fffff] page 4k
[    0.000000] BRK [0x01fdc000, 0x01fdcfff] PGTABLE
[    0.000000] BRK [0x01fdd000, 0x01fddfff] PGTABLE
[    0.000000] BRK [0x01fde000, 0x01fdefff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x22fe00000-0x22fffffff]
[    0.000000]  [mem 0x22fe00000-0x22fffffff] page 2M
[    0.000000] BRK [0x01fdf000, 0x01fdffff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x22c000000-0x22fdfffff]
[    0.000000]  [mem 0x22c000000-0x22fdfffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x200000000-0x22bffffff]
[    0.000000]  [mem 0x200000000-0x22bffffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x00100000-0xcee74fff]
[    0.000000]  [mem 0x00100000-0x001fffff] page 4k
[    0.000000]  [mem 0x00200000-0xcedfffff] page 2M
[    0.000000]  [mem 0xcee00000-0xcee74fff] page 4k
[    0.000000] init_memory_mapping: [mem 0x100000000-0x1ffffffff]
[    0.000000]  [mem 0x100000000-0x1ffffffff] page 2M
[    0.000000] BRK [0x01fe0000, 0x01fe0fff] PGTABLE
[    0.000000] BRK [0x01fe1000, 0x01fe1fff] PGTABLE
[    0.000000] RAMDISK: [mem 0x34ab2000-0x36550fff]
[    0.000000] ACPI: RSDP 00000000000f0410 000024 (v02   Sony)
[    0.000000] ACPI: XSDT 00000000cef17e18 00005C (v01   Sony     VAIO
20100514 MSFT 00010013)
[    0.000000] ACPI: FACP 00000000cef10d98 0000F4 (v04   Sony     VAIO
20100514 MSFT 00010013)
[    0.000000] ACPI Warning: 32/64 FACS address mismatch in FADT - two
FACS tables! (20131115/tbfadt-395)
[    0.000000] ACPI BIOS Warning (bug): 32/64X FACS address mismatch in
FADT - 0xCEF28F40/0x00000000CEF2BD40, using 32 (20131115/tbfadt-522)
[    0.000000] ACPI: DSDT 00000000ceec6018 00A9B5 (v01   Sony     VAIO
20100514 INTL 20051117)
[    0.000000] ACPI: FACS 00000000cef28f40 000040
[    0.000000] ACPI: APIC 00000000cef16f18 00008C (v02   Sony     VAIO
20100514 MSFT 00010013)
[    0.000000] ACPI: MCFG 00000000cef2ad18 00003C (v01   Sony     VAIO
20100514 MSFT 00000097)
[    0.000000] ACPI: HPET 00000000cef2ac98 000038 (v01   Sony     VAIO
20100514 MSFT 00000003)
[    0.000000] ACPI: SLIC 00000000cef23a18 000176 (v01   Sony     VAIO
20100514 Sony 01000000)
[    0.000000] ACPI: SSDT 00000000cef11018 0009F1 (v01   Sony     VAIO
20100514 INTL 20051117)
[    0.000000] ACPI: SSDT 00000000cef10c18 00011D (v01   Sony     VAIO
20100514 INTL 20051117)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at [mem 0x0000000000000000-0x000000022fffffff]
[    0.000000] Initmem setup node 0 [mem 0x00000000-0x22fffffff]
[    0.000000]   NODE_DATA [mem 0x22fff5000-0x22fff9fff]
[    0.000000] Reserving 128MB of memory at 704MB for crashkernel
(System RAM: 8174MB)
[    0.000000]  [ffffea0000000000-ffffea0008bfffff] PMD ->
[ffff880227600000-ffff88022f5fffff] on node 0
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x00001000-0x00ffffff]
[    0.000000]   DMA32    [mem 0x01000000-0xffffffff]
[    0.000000]   Normal   [mem 0x100000000-0x22fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x00001000-0x0009dfff]
[    0.000000]   node   0: [mem 0x00100000-0xcee74fff]
[    0.000000]   node   0: [mem 0x100000000-0x22fffffff]
[    0.000000] On node 0 totalpages: 2092562
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 21 pages reserved
[    0.000000]   DMA zone: 3997 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 13178 pages used for memmap
[    0.000000]   DMA32 zone: 843381 pages, LIFO batch:31
[    0.000000]   Normal zone: 19456 pages used for memmap
[    0.000000]   Normal zone: 1245184 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x408
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x04] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x06] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x05] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x06] lapic_id[0x03] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x07] lapic_id[0x05] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x08] lapic_id[0x07] enabled)
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI
0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a701 base: 0xfed00000
[    0.000000] smpboot: Allowing 8 CPUs, 0 hotplug CPUs
[    0.000000] nr_irqs_gsi: 40
[    0.000000] PM: Registered nosave memory: [mem 0x0009e000-0x0009efff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000dffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000e0000-0x000fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xcee75000-0xceeb4fff]
[    0.000000] PM: Registered nosave memory: [mem 0xceeb5000-0xceec5fff]
[    0.000000] PM: Registered nosave memory: [mem 0xceec6000-0xceedbfff]
[    0.000000] PM: Registered nosave memory: [mem 0xceedc000-0xcef0bfff]
[    0.000000] PM: Registered nosave memory: [mem 0xcef0c000-0xcef0cfff]
[    0.000000] PM: Registered nosave memory: [mem 0xcef0d000-0xcef0ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xcef10000-0xcef11fff]
[    0.000000] PM: Registered nosave memory: [mem 0xcef12000-0xcef15fff]
[    0.000000] PM: Registered nosave memory: [mem 0xcef16000-0xcef18fff]
[    0.000000] PM: Registered nosave memory: [mem 0xcef19000-0xcef1cfff]
[    0.000000] PM: Registered nosave memory: [mem 0xcef1d000-0xcef2bfff]
[    0.000000] PM: Registered nosave memory: [mem 0xcef2c000-0xcfffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xd0000000-0xf7ffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xf8000000-0xfbffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfc000000-0xfebfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec00000-0xfec00fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec01000-0xfed1afff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed1b000-0xfed1ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed20000-0xfedfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfee01000-0xff9fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xffa00000-0xffbfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xffc00000-0xffdfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xffe00000-0xffffffff]
[    0.000000] e820: [mem 0xd0000000-0xf7ffffff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] setup_percpu: NR_CPUS:256 nr_cpumask_bits:256
nr_cpu_ids:8 nr_node_ids:1
[    0.000000] PERCPU: Embedded 29 pages/cpu @ffff88022fc00000 s86400
r8192 d24192 u262144
[    0.000000] pcpu-alloc: s86400 r8192 d24192 u262144 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3 4 5 6 7
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on. 
Total pages: 2059843
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line:
BOOT_IMAGE=/vmlinuz-3.13.0-031300-generic
root=UUID=0b979894-b551-4ac1-8dc3-04a316602bf5 ro acpi_osi=Linux
i8042.reset crashkernel=384M-2G:64M,2G-:128M quiet splash
acpi_backlight=vendor i8042.reset vt.handoff=7
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Checking aperture...
[    0.000000] No AGP bridge found
[    0.000000] Calgary: detecting Calgary via BIOS EBDA area
[    0.000000] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[    0.000000] Memory: 7997220K/8370248K available (7476K kernel code,
1128K rwdata, 3500K rodata, 1344K init, 1436K bss, 373028K reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000]     RCU dyntick-idle grace-period acceleration is enabled.
[    0.000000]     RCU restricting CPUs from NR_CPUS=256 to nr_cpu_ids=8.
[    0.000000]     Offload RCU callbacks from all CPUs
[    0.000000]     Offload RCU callbacks from CPUs: 0-7.
[    0.000000] NR_IRQS:16640 nr_irqs:744 16
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled
[    0.000000] allocated 33554432 bytes of page_cgroup
[    0.000000] please try 'cgroup_disable=memory' option if you don't
want memory cgroups
[    0.000000] hpet clockevent registered
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.004000] tsc: Detected 1729.093 MHz processor
[    0.000002] Calibrating delay loop (skipped), value calculated using
timer frequency.. 3458.18 BogoMIPS (lpj=6916372)
[    0.000005] pid_max: default: 32768 minimum: 301
[    0.000031] Security Framework initialized
[    0.000046] AppArmor: AppArmor initialized
[    0.000047] Yama: becoming mindful.
[    0.000573] Dentry cache hash table entries: 1048576 (order: 11,
8388608 bytes)
[    0.002047] Inode-cache hash table entries: 524288 (order: 10,
4194304 bytes)
[    0.002680] Mount-cache hash table entries: 256
[    0.002834] Initializing cgroup subsys memory
[    0.002839] Initializing cgroup subsys devices
[    0.002841] Initializing cgroup subsys freezer
[    0.002842] Initializing cgroup subsys blkio
[    0.002843] Initializing cgroup subsys perf_event
[    0.002845] Initializing cgroup subsys hugetlb
[    0.002861] CPU: Physical Processor ID: 0
[    0.002862] CPU: Processor Core ID: 0
[    0.002866] mce: CPU supports 9 MCE banks
[    0.002873] CPU0: Thermal monitoring handled by SMI
[    0.002880] Last level iTLB entries: 4KB 512, 2MB 7, 4MB 7
[    0.002880] Last level dTLB entries: 4KB 512, 2MB 32, 4MB 32
[    0.002880] tlb_flushall_shift: 6
[    0.002953] Freeing SMP alternatives memory: 28K (ffffffff81e6c000 -
ffffffff81e73000)
[    0.003918] ACPI: Core revision 20131115
[    0.008542] ACPI: All ACPI Tables successfully acquired
[    0.015578] ftrace: allocating 31023 entries in 122 pages
[    0.028491] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=0 pin2=0
[    0.068160] smpboot: CPU0: Intel(R) Core(TM) i7 CPU       Q 820  @
1.73GHz (fam: 06, model: 1e, stepping: 05)
[    0.175041] Performance Events: PEBS fmt1+, 16-deep LBR, Nehalem
events, Intel PMU driver.
[    0.175046] perf_event_intel: CPU erratum AAJ80 worked around
[    0.175047] perf_event_intel: CPUID marked event: 'bus cycles'
unavailable
[    0.175049] ... version:                3
[    0.175050] ... bit width:              48
[    0.175051] ... generic registers:      4
[    0.175052] ... value mask:             0000ffffffffffff
[    0.175053] ... max period:             000000007fffffff
[    0.175053] ... fixed-purpose events:   3
[    0.175054] ... event mask:             000000070000000f
[    0.176507] x86: Booting SMP configuration:
[    0.187548] CPU1: Thermal monitoring handled by SMI
[    0.189756] NMI watchdog: enabled on all CPUs, permanently consumes
one hw-PMU counter.
[    0.200882] CPU2: Thermal monitoring handled by SMI
[    0.214139] CPU3: Thermal monitoring handled by SMI
[    0.227394] CPU4: Thermal monitoring handled by SMI
[    0.240660] CPU5: Thermal monitoring handled by SMI
[    0.253921] CPU6: Thermal monitoring handled by SMI
[    0.267171] CPU7: Thermal monitoring handled by SMI
[    0.176509] .... node  #0, CPUs:      #1 #2 #3 #4 #5 #6 #7
[    0.269290] x86: Booted up 1 node, 8 CPUs
[    0.269299] smpboot: Total of 8 processors activated (27665.48 BogoMIPS)
[    0.276538] devtmpfs: initialized
[    0.283488] EVM: security.selinux
[    0.283490] EVM: security.SMACK64
[    0.283491] EVM: security.ima
[    0.283492] EVM: security.capability
[    0.283571] PM: Registering ACPI NVS region [mem
0xcee75000-0xceeb4fff] (262144 bytes)
[    0.283578] PM: Registering ACPI NVS region [mem
0xceec6000-0xceedbfff] (90112 bytes)
[    0.283581] PM: Registering ACPI NVS region [mem
0xcef0c000-0xcef0cfff] (4096 bytes)
[    0.283582] PM: Registering ACPI NVS region [mem
0xcef10000-0xcef11fff] (8192 bytes)
[    0.283584] PM: Registering ACPI NVS region [mem
0xcef1d000-0xcef2bfff] (61440 bytes)
[    0.284745] pinctrl core: initialized pinctrl subsystem
[    0.284818] regulator-dummy: no parameters
[    0.284855] RTC time:  0:07:11, date: 01/21/14
[    0.284893] NET: Registered protocol family 16
[    0.285041] cpuidle: using governor ladder
[    0.285043] cpuidle: using governor menu
[    0.285112] ACPI FADT declares the system doesn't support PCIe ASPM,
so disable it
[    0.285114] ACPI: bus type PCI registered
[    0.285116] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.285197] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem
0xf8000000-0xfbffffff] (base 0xf8000000)
[    0.285200] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in E820
[    0.291157] PCI: Using configuration type 1 for base access
[    0.292423] bio: create slab <bio-0> at 0
[    0.292618] ACPI: Added _OSI(Module Device)
[    0.292621] ACPI: Added _OSI(Processor Device)
[    0.292623] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.292624] ACPI: Added _OSI(Processor Aggregator Device)
[    0.292626] ACPI: Added _OSI(Linux)
[    0.296386] ACPI: Executed 1 blocks of module-level executable AML code
[    0.301334] [Firmware Bug]: ACPI: BIOS _OSI(Linux) query honored via
cmdline
[    0.307701] ACPI: SSDT 00000000cef15c18 000298 (v01  PmRef  Cpu0Ist
00003000 INTL 20051117)
[    0.308155] ACPI: Dynamic OEM Table Load:
[    0.308158] ACPI: SSDT           (null) 000298 (v01  PmRef  Cpu0Ist
00003000 INTL 20051117)
[    0.308289] ACPI: SSDT 00000000cef13618 0005CD (v01  PmRef  Cpu0Cst
00003001 INTL 20051117)
[    0.308723] ACPI: Dynamic OEM Table Load:
[    0.308726] ACPI: SSDT           (null) 0005CD (v01  PmRef  Cpu0Cst
00003001 INTL 20051117)
[    0.313581] ACPI: SSDT 00000000cef14a98 000303 (v01  PmRef    ApIst
00003000 INTL 20051117)
[    0.314087] ACPI: Dynamic OEM Table Load:
[    0.314090] ACPI: SSDT           (null) 000303 (v01  PmRef    ApIst
00003000 INTL 20051117)
[    0.317416] ACPI: SSDT 00000000cef12d98 000119 (v01  PmRef    ApCst
00003000 INTL 20051117)
[    0.317884] ACPI: Dynamic OEM Table Load:
[    0.317887] ACPI: SSDT           (null) 000119 (v01  PmRef    ApCst
00003000 INTL 20051117)
[    1.159948] ACPI: Interpreter enabled
[    1.159957] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep
State [\_S1_] (20131115/hwxface-580)
[    1.159963] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep
State [\_S2_] (20131115/hwxface-580)
[    1.159982] ACPI: (supports S0 S3 S4 S5)
[    1.159984] ACPI: Using IOAPIC for interrupt routing
[    1.160021] PCI: Using host bridge windows from ACPI; if necessary,
use "pci=nocrs" and report a bug
[    1.160234] ACPI: No dock devices found.
[    1.205443] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3e])
[    1.205450] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM
ClockPM Segments MSI]
[    1.205492] \_SB_.PCI0:_OSC invalid UUID
[    1.205493] _OSC request data:1 1f 0
[    1.205498] acpi PNP0A08:00: _OSC failed (AE_ERROR); disabling ASPM
[    1.206457] PCI host bridge to bus 0000:00
[    1.206461] pci_bus 0000:00: root bus resource [bus 00-3e]
[    1.206463] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7]
[    1.206465] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff]
[    1.206468] pci_bus 0000:00: root bus resource [mem
0x000a0000-0x000bffff]
[    1.206470] pci_bus 0000:00: root bus resource [mem
0x000d4000-0x000d7fff]
[    1.206472] pci_bus 0000:00: root bus resource [mem
0x000d8000-0x000dbfff]
[    1.206474] pci_bus 0000:00: root bus resource [mem
0x000dc000-0x000dffff]
[    1.206476] pci_bus 0000:00: root bus resource [mem
0x000e0000-0x000e3fff]
[    1.206479] pci_bus 0000:00: root bus resource [mem
0x000e4000-0x000e7fff]
[    1.206481] pci_bus 0000:00: root bus resource [mem
0xd0000000-0xfeafffff]
[    1.206492] pci 0000:00:00.0: [8086:d132] type 00 class 0x060000
[    1.206618] pci 0000:00:03.0: [8086:d138] type 01 class 0x060400
[    1.206673] pci 0000:00:03.0: PME# supported from D0 D3hot D3cold
[    1.206775] pci 0000:00:08.0: [8086:d155] type 00 class 0x088000
[    1.206894] pci 0000:00:08.1: [8086:d156] type 00 class 0x088000
[    1.207012] pci 0000:00:08.2: [8086:d157] type 00 class 0x088000
[    1.207123] pci 0000:00:08.3: [8086:d158] type 00 class 0x088000
[    1.207242] pci 0000:00:10.0: [8086:d150] type 00 class 0x088000
[    1.207344] pci 0000:00:10.1: [8086:d151] type 00 class 0x088000
[    1.207482] pci 0000:00:1a.0: [8086:3b3c] type 00 class 0x0c0320
[    1.207517] pci 0000:00:1a.0: reg 0x10: [mem 0xe8e08000-0xe8e083ff]
[    1.207618] pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
[    1.207706] pci 0000:00:1a.0: System wakeup disabled by ACPI
[    1.207760] pci 0000:00:1b.0: [8086:3b56] type 00 class 0x040300
[    1.207781] pci 0000:00:1b.0: reg 0x10: [mem 0xe8e00000-0xe8e03fff 64bit]
[    1.207874] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    1.207944] pci 0000:00:1b.0: System wakeup disabled by ACPI
[    1.207988] pci 0000:00:1c.0: [8086:3b42] type 01 class 0x060400
[    1.208069] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    1.208136] pci 0000:00:1c.0: System wakeup disabled by ACPI
[    1.208176] pci 0000:00:1c.1: [8086:3b44] type 01 class 0x060400
[    1.208257] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    1.208363] pci 0000:00:1c.2: [8086:3b46] type 01 class 0x060400
[    1.208444] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
[    1.208510] pci 0000:00:1c.2: System wakeup disabled by ACPI
[    1.208556] pci 0000:00:1c.5: [8086:3b4c] type 01 class 0x060400
[    1.208637] pci 0000:00:1c.5: PME# supported from D0 D3hot D3cold
[    1.208703] pci 0000:00:1c.5: System wakeup disabled by ACPI
[    1.208753] pci 0000:00:1d.0: [8086:3b34] type 00 class 0x0c0320
[    1.208783] pci 0000:00:1d.0: reg 0x10: [mem 0xe8e07000-0xe8e073ff]
[    1.208884] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    1.208972] pci 0000:00:1d.0: System wakeup disabled by ACPI
[    1.209020] pci 0000:00:1e.0: [8086:2448] type 01 class 0x060401
[    1.209137] pci 0000:00:1e.0: System wakeup disabled by ACPI
[    1.209181] pci 0000:00:1f.0: [8086:3b03] type 00 class 0x060100
[    1.209391] pci 0000:00:1f.2: [8086:3b2f] type 00 class 0x010601
[    1.209421] pci 0000:00:1f.2: reg 0x10: [io  0xe070-0xe077]
[    1.209434] pci 0000:00:1f.2: reg 0x14: [io  0xe060-0xe063]
[    1.209447] pci 0000:00:1f.2: reg 0x18: [io  0xe050-0xe057]
[    1.209459] pci 0000:00:1f.2: reg 0x1c: [io  0xe040-0xe043]
[    1.209472] pci 0000:00:1f.2: reg 0x20: [io  0xe020-0xe03f]
[    1.209485] pci 0000:00:1f.2: reg 0x24: [mem 0xe8e06000-0xe8e067ff]
[    1.209543] pci 0000:00:1f.2: PME# supported from D3hot
[    1.209645] pci 0000:00:1f.3: [8086:3b30] type 00 class 0x0c0500
[    1.209665] pci 0000:00:1f.3: reg 0x10: [mem 0xe8e05000-0xe8e050ff 64bit]
[    1.209692] pci 0000:00:1f.3: reg 0x20: [io  0xe000-0xe01f]
[    1.209976] pci 0000:01:00.0: [10de:0a29] type 00 class 0x030000
[    1.209989] pci 0000:01:00.0: reg 0x10: [mem 0xe2000000-0xe2ffffff]
[    1.210001] pci 0000:01:00.0: reg 0x14: [mem 0xd0000000-0xdfffffff
64bit pref]
[    1.210013] pci 0000:01:00.0: reg 0x1c: [mem 0xe0000000-0xe1ffffff
64bit pref]
[    1.210022] pci 0000:01:00.0: reg 0x24: [io  0xd000-0xd07f]
[    1.210031] pci 0000:01:00.0: reg 0x30: [mem 0xe3000000-0xe307ffff pref]
[    1.210162] pci 0000:01:00.1: [10de:0be2] type 00 class 0x040300
[    1.210174] pci 0000:01:00.1: reg 0x10: [mem 0xe3080000-0xe3083fff]
[    1.210337] pci 0000:00:03.0: PCI bridge to [bus 01]
[    1.210342] pci 0000:00:03.0:   bridge window [io  0xd000-0xdfff]
[    1.210345] pci 0000:00:03.0:   bridge window [mem 0xd0000000-0xe30fffff]
[    1.210456] pci 0000:02:00.0: [168c:002e] type 00 class 0x028000
[    1.210484] pci 0000:02:00.0: reg 0x10: [mem 0xe7a00000-0xe7a0ffff 64bit]
[    1.210601] pci 0000:02:00.0: supports D1
[    1.210603] pci 0000:02:00.0: PME# supported from D0 D1 D3hot
[    1.210639] pci 0000:02:00.0: System wakeup disabled by ACPI
[    1.219879] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    1.219891] pci 0000:00:1c.0:   bridge window [io  0xc000-0xcfff]
[    1.219902] pci 0000:00:1c.0:   bridge window [mem 0xe7a00000-0xe8dfffff]
[    1.220131] pci 0000:03:00.0: [1180:e822] type 00 class 0x080500
[    1.220185] pci 0000:03:00.0: MMC controller base frequency changed
to 50Mhz.
[    1.220215] pci 0000:03:00.0: reg 0x10: [mem 0xe6603000-0xe66030ff]
[    1.220357] pci 0000:03:00.0: supports D1 D2
[    1.220359] pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    1.220485] pci 0000:03:00.1: [1180:e230] type 00 class 0x088000
[    1.220508] pci 0000:03:00.1: reg 0x10: [mem 0xe6602000-0xe66020ff]
[    1.220650] pci 0000:03:00.1: supports D1 D2
[    1.220652] pci 0000:03:00.1: PME# supported from D0 D1 D2 D3hot D3cold
[    1.220774] pci 0000:03:00.3: [1180:e832] type 00 class 0x0c0010
[    1.220830] pci 0000:03:00.3: reg 0x10: [mem 0xe6601000-0xe66017ff]
[    1.220969] pci 0000:03:00.3: supports D1 D2
[    1.220971] pci 0000:03:00.3: PME# supported from D0 D1 D2 D3hot D3cold
[    1.221093] pci 0000:03:00.4: [1180:e822] type 00 class 0x080500
[    1.221149] pci 0000:03:00.4: reg 0x10: [mem 0xe6600000-0xe66000ff]
[    1.221289] pci 0000:03:00.4: supports D1 D2
[    1.221291] pci 0000:03:00.4: PME# supported from D0 D1 D2 D3hot D3cold
[    1.231932] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    1.231942] pci 0000:00:1c.1:   bridge window [io  0xb000-0xbfff]
[    1.231950] pci 0000:00:1c.1:   bridge window [mem 0xe6600000-0xe79fffff]
[    1.232303] pci 0000:04:00.0: [11ab:4380] type 00 class 0x020000
[    1.232584] pci 0000:04:00.0: reg 0x10: [mem 0xe5220000-0xe5223fff 64bit]
[    1.232754] pci 0000:04:00.0: reg 0x18: [io  0xa000-0xa0ff]
[    1.233307] pci 0000:04:00.0: reg 0x30: [mem 0xe5200000-0xe521ffff pref]
[    1.234071] pci 0000:04:00.0: supports D1 D2
[    1.234073] pci 0000:04:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    1.234341] pci 0000:04:00.0: System wakeup disabled by ACPI
[    1.234513] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    1.234522] pci 0000:00:1c.2:   bridge window [io  0xa000-0xafff]
[    1.234531] pci 0000:00:1c.2:   bridge window [mem 0xe5200000-0xe65fffff]
[    1.234624] acpiphp: Slot [1] registered
[    1.234640] pci 0000:00:1c.5: PCI bridge to [bus 05-0c]
[    1.234649] pci 0000:00:1c.5:   bridge window [io  0x9000-0x9fff]
[    1.234657] pci 0000:00:1c.5:   bridge window [mem 0xe3200000-0xe51fffff]
[    1.234748] pci 0000:00:1e.0: PCI bridge to [bus 0d] (subtractive decode)
[    1.234763] pci 0000:00:1e.0:   bridge window [io  0x0000-0x0cf7]
(subtractive decode)
[    1.234765] pci 0000:00:1e.0:   bridge window [io  0x0d00-0xffff]
(subtractive decode)
[    1.234767] pci 0000:00:1e.0:   bridge window [mem
0x000a0000-0x000bffff] (subtractive decode)
[    1.234770] pci 0000:00:1e.0:   bridge window [mem
0x000d4000-0x000d7fff] (subtractive decode)
[    1.234772] pci 0000:00:1e.0:   bridge window [mem
0x000d8000-0x000dbfff] (subtractive decode)
[    1.234774] pci 0000:00:1e.0:   bridge window [mem
0x000dc000-0x000dffff] (subtractive decode)
[    1.234776] pci 0000:00:1e.0:   bridge window [mem
0x000e0000-0x000e3fff] (subtractive decode)
[    1.234778] pci 0000:00:1e.0:   bridge window [mem
0x000e4000-0x000e7fff] (subtractive decode)
[    1.234781] pci 0000:00:1e.0:   bridge window [mem
0xd0000000-0xfeafffff] (subtractive decode)
[    1.235499] ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 12
14 15) *11
[    1.235581] ACPI: PCI Interrupt Link [LNKB] (IRQs 1 *3 4 5 6 7 11 12
14 15)
[    1.235660] ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 *4 5 6 7 10 12
14 15)
[    1.235738] ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 11 12
14 15) *10
[    1.235817] ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 7 10 12
14 15) *0, disabled.
[    1.235904] ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 7 11 12
14 15) *0, disabled.
[    1.235984] ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 *5 6 7 10 12
14 15)
[    1.236062] ACPI: PCI Interrupt Link [LNKH] (IRQs 1 3 4 5 6 7 *11 12
14 15)
[    1.236126] ACPI: PCI Root Bridge [CPBG] (domain 0000 [bus 3f])
[    1.236131] acpi PNP0A03:00: _OSC: OS supports [ExtendedConfig ASPM
ClockPM Segments MSI]
[    1.236136] acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    1.236214] PCI host bridge to bus 0000:3f
[    1.236217] pci_bus 0000:3f: root bus resource [bus 3f]
[    1.236223] pci 0000:3f:00.0: [8086:2c52] type 00 class 0x060000
[    1.236275] pci 0000:3f:00.1: [8086:2c81] type 00 class 0x060000
[    1.236326] pci 0000:3f:02.0: [8086:2c90] type 00 class 0x060000
[    1.236372] pci 0000:3f:02.1: [8086:2c91] type 00 class 0x060000
[    1.236417] pci 0000:3f:03.0: [8086:2c98] type 00 class 0x060000
[    1.236463] pci 0000:3f:03.1: [8086:2c99] type 00 class 0x060000
[    1.236509] pci 0000:3f:03.4: [8086:2c9c] type 00 class 0x060000
[    1.236555] pci 0000:3f:04.0: [8086:2ca0] type 00 class 0x060000
[    1.236600] pci 0000:3f:04.1: [8086:2ca1] type 00 class 0x060000
[    1.236645] pci 0000:3f:04.2: [8086:2ca2] type 00 class 0x060000
[    1.236690] pci 0000:3f:04.3: [8086:2ca3] type 00 class 0x060000
[    1.236737] pci 0000:3f:05.0: [8086:2ca8] type 00 class 0x060000
[    1.236782] pci 0000:3f:05.1: [8086:2ca9] type 00 class 0x060000
[    1.236828] pci 0000:3f:05.2: [8086:2caa] type 00 class 0x060000
[    1.236874] pci 0000:3f:05.3: [8086:2cab] type 00 class 0x060000
[    1.253051] ACPI: Enabled 3 GPEs in block 00 to 3F
[    1.253060] ACPI: \_SB_.PCI0: notify handler is installed
[    1.253133] ACPI: \_SB_.CPBG: notify handler is installed
[    1.253143] Found 2 acpi root devices
[    1.253198] ACPI : EC: GPE = 0x17, I/O: command/status = 0x66, data =
0x62
[    1.253332] vgaarb: device added:
PCI:0000:01:00.0,decodes=io+mem,owns=io+mem,locks=none
[    1.253338] vgaarb: loaded
[    1.253340] vgaarb: bridge control possible 0000:01:00.0
[    1.253522] SCSI subsystem initialized
[    1.253577] libata version 3.00 loaded.
[    1.253597] ACPI: bus type USB registered
[    1.253613] usbcore: registered new interface driver usbfs
[    1.253621] usbcore: registered new interface driver hub
[    1.253648] usbcore: registered new device driver usb
[    1.253776] PCI: Using ACPI for IRQ routing
[    1.255217] PCI: pci_cache_line_size set to 64 bytes
[    1.255435] e820: reserve RAM buffer [mem 0x0009e800-0x0009ffff]
[    1.255438] e820: reserve RAM buffer [mem 0xcee75000-0xcfffffff]
[    1.255526] NetLabel: Initializing
[    1.255527] NetLabel:  domain hash size = 128
[    1.255528] NetLabel:  protocols = UNLABELED CIPSOv4
[    1.255543] NetLabel:  unlabeled traffic allowed by default
[    1.255675] HPET: 8 timers in total, 5 timers will be used for
per-cpu timer
[    1.255684] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 40, 41, 42, 43, 44, 0
[    1.255691] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    1.257757] hpet: hpet2 irq 40 for MSI
[    1.257825] hpet: hpet3 irq 41 for MSI
[    1.257898] hpet: hpet4 irq 42 for MSI
[    1.257960] hpet: hpet5 irq 43 for MSI
[    1.258023] hpet: hpet6 irq 44 for MSI
[    1.258179] Switched to clocksource hpet
[    1.263762] AppArmor: AppArmor Filesystem Enabled
[    1.263786] pnp: PnP ACPI init
[    1.263800] ACPI: bus type PNP registered
[    1.263830] pnp 00:00: [dma 4]
[    1.263853] pnp 00:00: Plug and Play ACPI device, IDs PNP0200 (active)
[    1.263877] pnp 00:01: Plug and Play ACPI device, IDs INT0800 (active)
[    1.264005] pnp 00:02: Plug and Play ACPI device, IDs PNP0103 (active)
[    1.264040] pnp 00:03: Plug and Play ACPI device, IDs PNP0c04 (active)
[    1.264097] system 00:04: [io  0x0680-0x069f] has been reserved
[    1.264100] system 00:04: [io  0xff00-0xff0f] has been reserved
[    1.264102] system 00:04: [io  0xff10-0xff13] has been reserved
[    1.264105] system 00:04: [io  0x0800-0x0803] has been reserved
[    1.264108] system 00:04: [io  0x0400-0x047f] could not be reserved
[    1.264110] system 00:04: [io  0x0500-0x057f] has been reserved
[    1.264112] system 00:04: [io  0x164e-0x164f] has been reserved
[    1.264116] system 00:04: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.264154] pnp 00:05: Plug and Play ACPI device, IDs PNP0b00 (active)
[    1.264185] pnp 00:06: Plug and Play ACPI device, IDs PNP0303 (active)
[    1.264217] pnp 00:07: Plug and Play ACPI device, IDs SNY9011 PNP0f13
(active)
[    1.264656] system 00:08: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    1.264660] system 00:08: [mem 0xfed1b000-0xfed1bfff] has been reserved
[    1.264663] system 00:08: [mem 0xf8000000-0xfbffffff] has been reserved
[    1.264665] system 00:08: [mem 0xfed20000-0xfed3ffff] has been reserved
[    1.264668] system 00:08: [mem 0xfed45000-0xfed8ffff] has been reserved
[    1.264670] system 00:08: [mem 0xff000000-0xffffffff] could not be
reserved
[    1.264673] system 00:08: [mem 0xfee00000-0xfeefffff] could not be
reserved
[    1.264676] system 00:08: [mem 0xe8e0b000-0xe8e0bfff] has been reserved
[    1.264679] system 00:08: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.275047] pnp: PnP ACPI: found 9 devices
[    1.275050] ACPI: bus type PNP unregistered
[    1.283465] pci 0000:00:1c.0: bridge window [mem
0x00100000-0x000fffff 64bit pref] to [bus 02] add_size 200000
[    1.283479] pci 0000:00:1c.1: bridge window [mem
0x00100000-0x000fffff 64bit pref] to [bus 03] add_size 200000
[    1.283493] pci 0000:00:1c.2: bridge window [mem
0x00100000-0x000fffff 64bit pref] to [bus 04] add_size 200000
[    1.283506] pci 0000:00:1c.5: bridge window [mem
0x00100000-0x000fffff 64bit pref] to [bus 05-0c] add_size 200000
[    1.283518] pci 0000:00:1c.0: res[15]=[mem 0x00100000-0x000fffff
64bit pref] get_res_add_size add_size 200000
[    1.283521] pci 0000:00:1c.1: res[15]=[mem 0x00100000-0x000fffff
64bit pref] get_res_add_size add_size 200000
[    1.283523] pci 0000:00:1c.2: res[15]=[mem 0x00100000-0x000fffff
64bit pref] get_res_add_size add_size 200000
[    1.283526] pci 0000:00:1c.5: res[15]=[mem 0x00100000-0x000fffff
64bit pref] get_res_add_size add_size 200000
[    1.283532] pci 0000:00:1c.0: BAR 15: assigned [mem
0xe8f00000-0xe90fffff 64bit pref]
[    1.283537] pci 0000:00:1c.1: BAR 15: assigned [mem
0xe9100000-0xe92fffff 64bit pref]
[    1.283541] pci 0000:00:1c.2: BAR 15: assigned [mem
0xe9300000-0xe94fffff 64bit pref]
[    1.283545] pci 0000:00:1c.5: BAR 15: assigned [mem
0xe9500000-0xe96fffff 64bit pref]
[    1.283548] pci 0000:00:03.0: PCI bridge to [bus 01]
[    1.283552] pci 0000:00:03.0:   bridge window [io  0xd000-0xdfff]
[    1.283556] pci 0000:00:03.0:   bridge window [mem 0xd0000000-0xe30fffff]
[    1.283562] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    1.283570] pci 0000:00:1c.0:   bridge window [io  0xc000-0xcfff]
[    1.283580] pci 0000:00:1c.0:   bridge window [mem 0xe7a00000-0xe8dfffff]
[    1.283589] pci 0000:00:1c.0:   bridge window [mem
0xe8f00000-0xe90fffff 64bit pref]
[    1.283599] pci 0000:00:1c.1: PCI bridge to [bus 03]
[    1.283607] pci 0000:00:1c.1:   bridge window [io  0xb000-0xbfff]
[    1.283617] pci 0000:00:1c.1:   bridge window [mem 0xe6600000-0xe79fffff]
[    1.283625] pci 0000:00:1c.1:   bridge window [mem
0xe9100000-0xe92fffff 64bit pref]
[    1.283636] pci 0000:00:1c.2: PCI bridge to [bus 04]
[    1.283644] pci 0000:00:1c.2:   bridge window [io  0xa000-0xafff]
[    1.283653] pci 0000:00:1c.2:   bridge window [mem 0xe5200000-0xe65fffff]
[    1.283662] pci 0000:00:1c.2:   bridge window [mem
0xe9300000-0xe94fffff 64bit pref]
[    1.283672] pci 0000:00:1c.5: PCI bridge to [bus 05-0c]
[    1.283680] pci 0000:00:1c.5:   bridge window [io  0x9000-0x9fff]
[    1.283689] pci 0000:00:1c.5:   bridge window [mem 0xe3200000-0xe51fffff]
[    1.283698] pci 0000:00:1c.5:   bridge window [mem
0xe9500000-0xe96fffff 64bit pref]
[    1.283708] pci 0000:00:1e.0: PCI bridge to [bus 0d]
[    1.283724] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7]
[    1.283726] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff]
[    1.283729] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff]
[    1.283731] pci_bus 0000:00: resource 7 [mem 0x000d4000-0x000d7fff]
[    1.283733] pci_bus 0000:00: resource 8 [mem 0x000d8000-0x000dbfff]
[    1.283735] pci_bus 0000:00: resource 9 [mem 0x000dc000-0x000dffff]
[    1.283737] pci_bus 0000:00: resource 10 [mem 0x000e0000-0x000e3fff]
[    1.283740] pci_bus 0000:00: resource 11 [mem 0x000e4000-0x000e7fff]
[    1.283742] pci_bus 0000:00: resource 12 [mem 0xd0000000-0xfeafffff]
[    1.283744] pci_bus 0000:01: resource 0 [io  0xd000-0xdfff]
[    1.283746] pci_bus 0000:01: resource 1 [mem 0xd0000000-0xe30fffff]
[    1.283749] pci_bus 0000:02: resource 0 [io  0xc000-0xcfff]
[    1.283751] pci_bus 0000:02: resource 1 [mem 0xe7a00000-0xe8dfffff]
[    1.283753] pci_bus 0000:02: resource 2 [mem 0xe8f00000-0xe90fffff
64bit pref]
[    1.283755] pci_bus 0000:03: resource 0 [io  0xb000-0xbfff]
[    1.283758] pci_bus 0000:03: resource 1 [mem 0xe6600000-0xe79fffff]
[    1.283760] pci_bus 0000:03: resource 2 [mem 0xe9100000-0xe92fffff
64bit pref]
[    1.283762] pci_bus 0000:04: resource 0 [io  0xa000-0xafff]
[    1.283764] pci_bus 0000:04: resource 1 [mem 0xe5200000-0xe65fffff]
[    1.283767] pci_bus 0000:04: resource 2 [mem 0xe9300000-0xe94fffff
64bit pref]
[    1.283769] pci_bus 0000:05: resource 0 [io  0x9000-0x9fff]
[    1.283771] pci_bus 0000:05: resource 1 [mem 0xe3200000-0xe51fffff]
[    1.283773] pci_bus 0000:05: resource 2 [mem 0xe9500000-0xe96fffff
64bit pref]
[    1.283776] pci_bus 0000:0d: resource 4 [io  0x0000-0x0cf7]
[    1.283778] pci_bus 0000:0d: resource 5 [io  0x0d00-0xffff]
[    1.283780] pci_bus 0000:0d: resource 6 [mem 0x000a0000-0x000bffff]
[    1.283782] pci_bus 0000:0d: resource 7 [mem 0x000d4000-0x000d7fff]
[    1.283784] pci_bus 0000:0d: resource 8 [mem 0x000d8000-0x000dbfff]
[    1.283787] pci_bus 0000:0d: resource 9 [mem 0x000dc000-0x000dffff]
[    1.283789] pci_bus 0000:0d: resource 10 [mem 0x000e0000-0x000e3fff]
[    1.283791] pci_bus 0000:0d: resource 11 [mem 0x000e4000-0x000e7fff]
[    1.283793] pci_bus 0000:0d: resource 12 [mem 0xd0000000-0xfeafffff]
[    1.283829] NET: Registered protocol family 2
[    1.284007] TCP established hash table entries: 65536 (order: 7,
524288 bytes)
[    1.284297] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    1.284669] TCP: Hash tables configured (established 65536 bind 65536)
[    1.284693] TCP: reno registered
[    1.284707] UDP hash table entries: 4096 (order: 5, 131072 bytes)
[    1.284787] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes)
[    1.284916] NET: Registered protocol family 1
[    1.402331] pci 0000:01:00.0: Boot video device
[    1.402455] PCI: CLS 64 bytes, default 64
[    1.402503] Trying to unpack rootfs image as initramfs...
[    1.985216] Freeing initrd memory: 27260K (ffff880034ab2000 -
ffff880036551000)
[    1.985221] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    1.985224] software IO TLB [mem 0xcae75000-0xcee75000] (64MB) mapped
at [ffff8800cae75000-ffff8800cee74fff]
[    1.985633] Scanning for low memory corruption every 60 seconds
[    1.986052] Initialise system trusted keyring
[    1.986116] audit: initializing netlink socket (disabled)
[    1.986127] type=2000 audit(1390262832.880:1): initialized
[    2.022346] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    2.023779] zbud: loaded
[    2.023962] VFS: Disk quotas dquot_6.5.2
[    2.024014] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)

[truncated for space]

[    2.116406] EDD information not available.
[    2.116456] PM: Hibernation image not present or could not be loaded.
[    2.117733] Freeing unused kernel memory: 1344K (ffffffff81d1c000 -
ffffffff81e6c000)
[    2.117734] Write protecting the kernel read-only data: 12288k
[    2.119496] Freeing unused kernel memory: 704K (ffff880001750000 -
ffff880001800000)
[    2.120791] Freeing unused kernel memory: 596K (ffff880001b6b000 -
ffff880001c00000)
[    2.147725] systemd-udevd[165]: starting version 204
[    2.160865] [Firmware Bug]: ACPI(NGFX) defines _DOD but not _DOS
[    2.160893] ACPI: Video Device [NGFX] (multi-head: yes  rom: no 
post: no)
[    2.161157] input: Video Bus as
/devices/LNXSYSTM:00/device:00/PNP0A08:00/device:57/LNXVIDEO:02/input/input4
[    2.175493] sdhci: Secure Digital Host Controller Interface driver
[    2.175496] sdhci: Copyright(c) Pierre Ossman
[    2.177225] sdhci-pci 0000:03:00.0: SDHCI controller found
[1180:e822] (rev 0)
[    2.177452] sdhci-pci 0000:03:00.0: Will use DMA mode even though HW
doesn't fully claim to support it.
[truncated for space]

X. Other Notes:
Launchpad report
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1154867
-- 
_____________
Adam Colligan
adam@adamcolligan.net
+1 512 481 2678

