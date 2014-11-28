From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
Subject: Re: thermal sensor numbering change intended ?
Date: Fri, 28 Nov 2014 10:57:10 +0100
Message-ID: <547846F6.5010307@gmx.de>
References: <54735EBC.4060409@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.20]:53208 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750994AbaK1J5O (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 28 Nov 2014 04:57:14 -0500
Received: from [192.168.178.21] ([78.54.166.219]) by mail.gmx.com (mrgmx101)
 with ESMTPSA (Nemesis) id 0M7kwW-1Y7Zv62V9s-00vLHo for
 <linux-pm@vger.kernel.org>; Fri, 28 Nov 2014 10:57:12 +0100
In-Reply-To: <54735EBC.4060409@gmx.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "linux-pm@vger.kernel.org >> Linux PM list" <linux-pm@vger.kernel.org>

On 11/24/2014 05:37 PM, Toralf F=C3=B6rster wrote:
> At a dedicated server (i3770) I'm realized today that the sensors # h=
ave been switched between 3.17.3 and .4.
>=20
> With 4 I do have :
> # tail -v /sys/devices/virtual/thermal/thermal_zone?/temp
> =3D=3D> /sys/devices/virtual/thermal/thermal_zone0/temp <=3D=3D
> 64000
>=20
> =3D=3D> /sys/devices/virtual/thermal/thermal_zone1/temp <=3D=3D
> 27800
>=20
> =3D=3D> /sys/devices/virtual/thermal/thermal_zone2/temp <=3D=3D
> 29800
>=20
>=20
> whereas with with 3.17.3 the highest temperature (about 60=C2=B0) was=
 shown at sensor 2.
>=20
> Intended or a regression ?
>=20

Hhm,
booting now into the same hardened kernel version, but new revision-r1 =
(new grsec patch) reverts it again, now I do have:

# tail -v /sys/devices/virtual/thermal/thermal_zone?/temp
=3D=3D> /sys/devices/virtual/thermal/thermal_zone0/temp <=3D=3D
27800

=3D=3D> /sys/devices/virtual/thermal/thermal_zone1/temp <=3D=3D
29800

=3D=3D> /sys/devices/virtual/thermal/thermal_zone2/temp <=3D=3D
67000


--=20
Toralf
pgp key: 0076 E94E

