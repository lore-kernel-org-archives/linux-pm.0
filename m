From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
Subject: does niced processes scales frequency too at the ondemand governor
 ?
Date: Wed, 06 Nov 2013 19:29:18 +0100
Message-ID: <527A8A7E.1050906@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: cpufreq@vger.kernel.org
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Running a Gentoo Linux at a 4-core CPU (i5) I realize, that compiling
packages using -j4 usually needs twice as long, if I run 4 BOINC
processes in the back ground (nice -n 19) too. Even considering effects
of invalidation of cache data this seems a too big impact in my eyes.

It looks for me like that the BOINC processes scales down the frequency=
,
when they are running. This behaviour however would be wrong IMO. The
frequency should be scaled just by the non-niced foreground processes,
right ?

--=20
MfG/Sincerely
Toralf F=C3=B6rster
pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3
