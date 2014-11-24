From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
Subject: thermal sensor numbering change intended ?
Date: Mon, 24 Nov 2014 17:37:16 +0100
Message-ID: <54735EBC.4060409@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.15]:63991 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751005AbaKXQhV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 24 Nov 2014 11:37:21 -0500
Received: from [192.168.178.21] ([85.177.144.159]) by mail.gmx.com (mrgmx003)
 with ESMTPSA (Nemesis) id 0LsTge-1Y42QY1AW8-0121yg for
 <linux-pm@vger.kernel.org>; Mon, 24 Nov 2014 17:37:18 +0100
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "linux-pm@vger.kernel.org >> Linux PM list" <linux-pm@vger.kernel.org>

At a dedicated server (i3770) I'm realized today that the sensors # hav=
e been switched between 3.17.3 and .4.

With 4 I do have :
# tail -v /sys/devices/virtual/thermal/thermal_zone?/temp
=3D=3D> /sys/devices/virtual/thermal/thermal_zone0/temp <=3D=3D
64000

=3D=3D> /sys/devices/virtual/thermal/thermal_zone1/temp <=3D=3D
27800

=3D=3D> /sys/devices/virtual/thermal/thermal_zone2/temp <=3D=3D
29800


whereas with with 3.17.3 the highest temperature (about 60=C2=B0) was s=
hown at sensor 2.

Intended or a regression ?

--=20
Toralf
pgp key: 0076 E94E

