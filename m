From: Martin Steigerwald <Martin@lichtvoll.de>
Subject: Re: [REGRESSION] 3.15: Seems to turbo mode Intel Sandybridge Dual Core without need, overheating CPU
Date: Tue, 10 Jun 2014 11:31:01 +0200
Message-ID: <2227580.NQeh4KI5E8@merkaba>
References: <1996399.buoKlNI5nG@merkaba> <1773550.hda5I1At4Q@vostro.rjw.lan> <2491989.M5MhllcFpf@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mondschein.lichtvoll.de ([194.150.191.11]:60000 "EHLO
	mail.lichtvoll.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750743AbaFJJbe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 10 Jun 2014 05:31:34 -0400
In-Reply-To: <2491989.M5MhllcFpf@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

Am Dienstag, 10. Juni 2014, 00:29:52 schrieb Rafael J. Wysocki:
> On Tuesday, June 10, 2014 12:20:20 AM Rafael J. Wysocki wrote:
> > On Monday, June 09, 2014 11:41:40 PM Martin Steigerwald wrote:
> > > Am Montag, 9. Juni 2014, 23:33:43 schrieb Martin Steigerwald:
> > > > Hi!
> > > >=20
> > > > Added linux-pm to Cc. Also reboots seems to fix up the conditio=
n:
> > > >=20
> > > > merkaba:~> grep . /sys/devices/system/cpu/cpu[0-3]/cpufreq/cpui=
nfo_cur_freq
> > > > /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq:830957
> > > > /sys/devices/system/cpu/cpu1/cpufreq/cpuinfo_cur_freq:819628
> > > > /sys/devices/system/cpu/cpu2/cpufreq/cpuinfo_cur_freq:800000
> > > > /sys/devices/system/cpu/cpu3/cpufreq/cpuinfo_cur_freq:813476
> > > > merkaba:~> sensors                                             =
           =20
> > > > acpitz-virtual-0
> > > > Adapter: Virtual device
> > > > temp1:        +71.0=B0C  (crit =3D +98.0=B0C)
> > > >=20
> > > > coretemp-isa-0000
> > > > Adapter: ISA adapter
> > > > Physical id 0:  +71.0=B0C  (high =3D +86.0=B0C, crit =3D +100.0=
=B0C)
> > > > Core 0:         +70.0=B0C  (high =3D +86.0=B0C, crit =3D +100.0=
=B0C)
> > > > Core 1:         +71.0=B0C  (high =3D +86.0=B0C, crit =3D +100.0=
=B0C)
> > > >=20
> > > > thinkpad-isa-0000
> > > > Adapter: ISA adapter
> > > > fan1:        3137 R
> > > >=20
> > > >=20
> > > > Still hot in here and after reboot and login into KDE session t=
here is quite
> > > > some CPU activity for a while.
> > > >=20
> > > > But way better than before.
> > > >=20
> > > > I can test whether this also happens with ACPI cpufreq driver.
> > > >=20
> > > > I think I didn=B4t see this with 3.14.
> > >=20
> > > Its not just me:
> > >=20
> > > Please change intel_pstate default to disable
> > > https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1188647
> >=20
> > Did you test the 3.15-rc kernels?  If so, do they have this problem=
 too?
>=20
> Or is that just you have tried intel_pstate for the first time?

No. Have intel_pstate running since some kernel releases.

--=20
Martin 'Helios' Steigerwald - http://www.Lichtvoll.de
GPG: 03B0 0D6C 0040 0710 4AFA  B82F 991B EAAC A599 84C7
