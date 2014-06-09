From: Martin Steigerwald <Martin@lichtvoll.de>
Subject: Re: [REGRESSION] 3.15: Seems to turbo mode Intel Sandybridge Dual Core without need, overheating CPU
Date: Tue, 10 Jun 2014 00:11:50 +0200
Message-ID: <31874206.p2BkN8t4Hy@merkaba>
References: <1996399.buoKlNI5nG@merkaba> <4677478.c1YrKzctMH@merkaba> <1773550.hda5I1At4Q@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mondschein.lichtvoll.de ([194.150.191.11]:37106 "EHLO
	mail.lichtvoll.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751223AbaFIWLw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 9 Jun 2014 18:11:52 -0400
In-Reply-To: <1773550.hda5I1At4Q@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

Am Dienstag, 10. Juni 2014, 00:20:20 schrieb Rafael J. Wysocki:
> On Monday, June 09, 2014 11:41:40 PM Martin Steigerwald wrote:
> > Am Montag, 9. Juni 2014, 23:33:43 schrieb Martin Steigerwald:
> > > Hi!
> > >=20
> > > Added linux-pm to Cc. Also reboots seems to fix up the condition:
> > >=20
> > > merkaba:~> grep . /sys/devices/system/cpu/cpu[0-3]/cpufreq/cpuinf=
o_cur_freq
> > > /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq:830957
> > > /sys/devices/system/cpu/cpu1/cpufreq/cpuinfo_cur_freq:819628
> > > /sys/devices/system/cpu/cpu2/cpufreq/cpuinfo_cur_freq:800000
> > > /sys/devices/system/cpu/cpu3/cpufreq/cpuinfo_cur_freq:813476
> > > merkaba:~> sensors                                               =
         =20
> > > acpitz-virtual-0
> > > Adapter: Virtual device
> > > temp1:        +71.0=B0C  (crit =3D +98.0=B0C)
> > >=20
> > > coretemp-isa-0000
> > > Adapter: ISA adapter
> > > Physical id 0:  +71.0=B0C  (high =3D +86.0=B0C, crit =3D +100.0=B0=
C)
> > > Core 0:         +70.0=B0C  (high =3D +86.0=B0C, crit =3D +100.0=B0=
C)
> > > Core 1:         +71.0=B0C  (high =3D +86.0=B0C, crit =3D +100.0=B0=
C)
> > >=20
> > > thinkpad-isa-0000
> > > Adapter: ISA adapter
> > > fan1:        3137 R
> > >=20
> > >=20
> > > Still hot in here and after reboot and login into KDE session the=
re is quite
> > > some CPU activity for a while.
> > >=20
> > > But way better than before.
> > >=20
> > > I can test whether this also happens with ACPI cpufreq driver.
> > >=20
> > > I think I didn=B4t see this with 3.14.
> >=20
> > Its not just me:
> >=20
> > Please change intel_pstate default to disable
> > https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1188647
>=20
> Did you test the 3.15-rc kernels?  If so, do they have this problem t=
oo?

I think I saw this with 3.15-rc7 as well. Not so sure about 3.15-rc5.

I now switched to acpi + ondemand governor which seems to work better, =
as I
posted. I still hit cpu throttling, but well its hot inside here. And m=
aybe the fan
also needs some cleaning.

Anyway, need to get some sleep now. I can test with rc7, rc5 and probab=
ly
some older rc as I still have those available. Will take some time toug=
h.

Thanks,
--=20
Martin 'Helios' Steigerwald - http://www.Lichtvoll.de
GPG: 03B0 0D6C 0040 0710 4AFA  B82F 991B EAAC A599 84C7
