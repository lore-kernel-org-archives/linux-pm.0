From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
Subject: v3.18-rc2 compilation under a x86 KVM failed in drivers/thermal/thermal_core.c:
Date: Mon, 27 Oct 2014 17:14:20 +0100
Message-ID: <544E6F5C.7040900@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.15]:55080 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751628AbaJ0QOX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 27 Oct 2014 12:14:23 -0400
Received: from [192.168.178.21] ([78.54.158.72]) by mail.gmx.com (mrgmx001)
 with ESMTPSA (Nemesis) id 0LtZcC-1Y87K51HyW-010swC for
 <linux-pm@vger.kernel.org>; Mon, 27 Oct 2014 17:14:21 +0100
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "linux-pm@vger.kernel.org >> Linux PM list" <linux-pm@vger.kernel.org>

Is this an already known issue ? :

  CC      drivers/thermal/thermal_core.o
drivers/thermal/thermal_core.c: In function =E2=80=98handle_critical_tr=
ips=E2=80=99:
drivers/thermal/thermal_core.c:374:2: error: implicit declaration of fu=
nction =E2=80=98trace_thermal_zone_trip=E2=80=99 [-Werror=3Dimplicit-fu=
nction-declaration]
drivers/thermal/thermal_core.c: In function =E2=80=98update_temperature=
=E2=80=99:
drivers/thermal/thermal_core.c:471:2: error: implicit declaration of fu=
nction =E2=80=98trace_thermal_temperature=E2=80=99 [-Werror=3Dimplicit-=
function-declaration]
drivers/thermal/thermal_core.c: In function =E2=80=98thermal_cdev_updat=
e=E2=80=99:
drivers/thermal/thermal_core.c:1296:2: error: implicit declaration of f=
unction =E2=80=98trace_cdev_update=E2=80=99 [-Werror=3Dimplicit-functio=
n-declaration]
cc1: some warnings being treated as errors
scripts/Makefile.build:257: recipe for target 'drivers/thermal/thermal_=
core.o' failed
make[2]: *** [drivers/thermal/thermal_core.o] Error 1
scripts/Makefile.build:402: recipe for target 'drivers/thermal' failed
make[1]: *** [drivers/thermal] Error 2
Makefile:936: recipe for target 'drivers' failed
make: *** [drivers] Error 2
make: *** Waiting for unfinished jobs....

--=20
Toralf
pgp key: 0076 E94E

