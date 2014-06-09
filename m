From: Martin Steigerwald <Martin@lichtvoll.de>
Subject: Re: [REGRESSION] 3.15: Seems to turbo mode Intel Sandybridge Dual Core without need, overheating CPU
Date: Mon, 09 Jun 2014 23:41:40 +0200
Message-ID: <4677478.c1YrKzctMH@merkaba>
References: <1996399.buoKlNI5nG@merkaba> <13232691.DxAv2jorp8@merkaba>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mondschein.lichtvoll.de ([194.150.191.11]:42329 "EHLO
	mail.lichtvoll.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753913AbaFIVlt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 9 Jun 2014 17:41:49 -0400
In-Reply-To: <13232691.DxAv2jorp8@merkaba>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org

Am Montag, 9. Juni 2014, 23:33:43 schrieb Martin Steigerwald:
> Hi!
>=20
> Added linux-pm to Cc. Also reboots seems to fix up the condition:
>=20
> merkaba:~> grep . /sys/devices/system/cpu/cpu[0-3]/cpufreq/cpuinfo_cu=
r_freq
> /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq:830957
> /sys/devices/system/cpu/cpu1/cpufreq/cpuinfo_cur_freq:819628
> /sys/devices/system/cpu/cpu2/cpufreq/cpuinfo_cur_freq:800000
> /sys/devices/system/cpu/cpu3/cpufreq/cpuinfo_cur_freq:813476
> merkaba:~> sensors                                                   =
     =20
> acpitz-virtual-0
> Adapter: Virtual device
> temp1:        +71.0=B0C  (crit =3D +98.0=B0C)
>=20
> coretemp-isa-0000
> Adapter: ISA adapter
> Physical id 0:  +71.0=B0C  (high =3D +86.0=B0C, crit =3D +100.0=B0C)
> Core 0:         +70.0=B0C  (high =3D +86.0=B0C, crit =3D +100.0=B0C)
> Core 1:         +71.0=B0C  (high =3D +86.0=B0C, crit =3D +100.0=B0C)
>=20
> thinkpad-isa-0000
> Adapter: ISA adapter
> fan1:        3137 R
>=20
>=20
> Still hot in here and after reboot and login into KDE session there i=
s quite
> some CPU activity for a while.
>=20
> But way better than before.
>=20
> I can test whether this also happens with ACPI cpufreq driver.
>=20
> I think I didn=B4t see this with 3.14.

Its not just me:

Please change intel_pstate default to disable
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1188647

>=20
>=20
>=20
> Am Montag, 9. Juni 2014, 23:24:54 schrieb Martin Steigerwald:
> > Hi!
> >=20
> > I get:
> >=20
> > Jun  9 22:41:32 merkaba kernel: [39978.006479] CPU0: Package temper=
ature/speed normal
> > Jun  9 22:41:32 merkaba kernel: [39978.006481] CPU3: Package temper=
ature/speed normal
> > Jun  9 22:41:32 merkaba kernel: [39978.006482] CPU2: Package temper=
ature/speed normal
> > Jun  9 22:41:32 merkaba kernel: [39978.006487] CPU1: Package temper=
ature/speed normal
> > Jun  9 22:44:02 merkaba kernel: [40127.673372] CPU2: Core temperatu=
re above threshold, cpu clock throttled (total events =3D 56554)
> > Jun  9 22:44:02 merkaba kernel: [40127.673383] CPU3: Core temperatu=
re above threshold, cpu clock throttled (total events =3D 56554)
> > Jun  9 22:44:02 merkaba kernel: [40127.674313] CPU3: Core temperatu=
re/speed normal
> > Jun  9 22:44:02 merkaba kernel: [40127.674352] CPU2: Core temperatu=
re/speed normal
> > Jun  9 22:45:21 merkaba kernel: [40207.302287] mce: [Hardware Error=
]: Machine check events logged
> > Jun  9 22:46:32 merkaba kernel: [40278.054568] CPU0: Package temper=
ature/speed normal
> > Jun  9 22:46:32 merkaba kernel: [40278.054572] CPU3: Package temper=
ature/speed normal
> > Jun  9 22:46:32 merkaba kernel: [40278.054574] CPU2: Package temper=
ature/speed normal
> > Jun  9 22:46:32 merkaba kernel: [40278.054578] CPU1: Package temper=
ature/speed normal
> > Jun  9 22:48:06 merkaba kernel: [40371.570654] perf interrupt took =
too long (19348 > 17857), lowering kernel.perf_event_max_sample_rate to=
 7000
> > Jun  9 22:51:32 merkaba kernel: [40578.103629] CPU3: Package temper=
ature/speed normal
> > Jun  9 22:51:32 merkaba kernel: [40578.103633] CPU0: Package temper=
ature/speed normal
> > Jun  9 22:51:32 merkaba kernel: [40578.103638] CPU2: Package temper=
ature/speed normal
> > Jun  9 22:51:32 merkaba kernel: [40578.103639] CPU1: Package temper=
ature/speed normal
> > Jun  9 22:56:32 merkaba kernel: [40878.174734] CPU1: Package temper=
ature above threshold, cpu clock throttled (total events =3D 152620)
> > Jun  9 22:56:32 merkaba kernel: [40878.174737] CPU0: Package temper=
ature above threshold, cpu clock throttled (total events =3D 152620)
> > Jun  9 22:56:32 merkaba kernel: [40878.174742] CPU3: Package temper=
ature above threshold, cpu clock throttled (total events =3D 152620)
> > Jun  9 22:56:32 merkaba kernel: [40878.174744] CPU2: Package temper=
ature above threshold, cpu clock throttled (total events =3D 152620)
> > Jun  9 22:56:32 merkaba kernel: [40878.176744] CPU3: Package temper=
ature/speed normal
> > Jun  9 22:56:32 merkaba kernel: [40878.176746] CPU2: Package temper=
ature/speed normal
> > Jun  9 22:56:32 merkaba kernel: [40878.176748] CPU1: Package temper=
ature/speed normal
> > Jun  9 22:56:32 merkaba kernel: [40878.176749] CPU0: Package temper=
ature/speed normal
> > Jun  9 22:59:11 merkaba kernel: [41037.278705] CPU3: Core temperatu=
re/speed normal
> > Jun  9 22:59:11 merkaba kernel: [41037.278707] CPU2: Core temperatu=
re/speed normal
> > Jun  9 23:01:32 merkaba kernel: [41178.225837] CPU2: Package temper=
ature above threshold, cpu clock throttled (total events =3D 177343)
> > Jun  9 23:01:32 merkaba kernel: [41178.225841] CPU0: Package temper=
ature above threshold, cpu clock throttled (total events =3D 177343)
> > Jun  9 23:01:32 merkaba kernel: [41178.225843] CPU3: Package temper=
ature above threshold, cpu clock throttled (total events =3D 177343)
> > Jun  9 23:01:32 merkaba kernel: [41178.225845] CPU1: Package temper=
ature above threshold, cpu clock throttled (total events =3D 177343)
> > Jun  9 23:01:32 merkaba kernel: [41178.237850] CPU1: Package temper=
ature/speed normal
> > Jun  9 23:01:32 merkaba kernel: [41178.237853] CPU2: Package temper=
ature/speed normal
> > Jun  9 23:01:32 merkaba kernel: [41178.237855] CPU0: Package temper=
ature/speed normal
> > Jun  9 23:01:32 merkaba kernel: [41178.237856] CPU3: Package temper=
ature/speed normal
> > Jun  9 23:01:36 merkaba kernel: [41182.452403] mce: [Hardware Error=
]: Machine check events logged
> > Jun  9 23:06:32 merkaba kernel: [41478.291923] CPU1: Package temper=
ature above threshold, cpu clock throttled (total events =3D 204756)
> > Jun  9 23:06:32 merkaba kernel: [41478.291926] CPU0: Package temper=
ature above threshold, cpu clock throttled (total events =3D 204756)
> > Jun  9 23:06:32 merkaba kernel: [41478.291946] CPU3: Package temper=
ature above threshold, cpu clock throttled (total events =3D 204756)
> > Jun  9 23:06:32 merkaba kernel: [41478.291950] CPU2: Package temper=
ature above threshold, cpu clock throttled (total events =3D 204756)
> > Jun  9 23:11:32 merkaba kernel: [41778.341992] CPU3: Package temper=
ature/speed normal
> > Jun  9 23:11:32 merkaba kernel: [41778.341995] CPU0: Package temper=
ature/speed normal
> > Jun  9 23:11:32 merkaba kernel: [41778.341996] CPU1: Package temper=
ature/speed normal
> > Jun  9 23:11:32 merkaba kernel: [41778.341997] CPU2: Package temper=
ature/speed normal
> >=20
> >=20
> > And this:
> >=20
> > merkaba:~> sensors
> > acpitz-virtual-0
> > Adapter: Virtual device
> > temp1:        +96.0=B0C  (crit =3D +98.0=B0C)
> >=20
> > coretemp-isa-0000
> > Adapter: ISA adapter
> > Physical id 0:  +98.0=B0C  (high =3D +86.0=B0C, crit =3D +100.0=B0C=
)
> > Core 0:         +96.0=B0C  (high =3D +86.0=B0C, crit =3D +100.0=B0C=
)
> > Core 1:         +96.0=B0C  (high =3D +86.0=B0C, crit =3D +100.0=B0C=
)
> >=20
> > thinkpad-isa-0000
> > Adapter: ISA adapter
> > fan1:        3580 RPM
> >=20
> > merkaba:~> acpi -t
> > Thermal 0: ok, 96.0 degrees C
> >=20
> >=20
> > On
> >=20
> > martin@merkaba:~> phoronix-test-suite system-info
> >=20
> > Phoronix Test Suite v4.8.3
> > System Information
> >=20
> > Hardware:
> > Processor: Intel Core i5-2520M @ 3.20GHz (4 Cores), Motherboard: LE=
NOVO 42433WG, Chipset: Intel 2nd Generation Core Family DRAM, Memory: 8=
192MB, Disk: 300GB INTEL SSDSA2CW30 + 480GB Crucial_CT480M50, Graphics:=
 Intel HD 3000 (1300MHz), Audio: Intel 6 /C200, Network: Intel 82579LM =
Gigabit Connection + Intel Centrino Advanced-N 6205
> >=20
> > Software:
> > OS: Debian unstable, Kernel: 3.15.0-tp520 (x86_64), Desktop: KDE 4.=
13.1, Display Server: X Server 1.15.1, Display Driver: intel 2.21.15, O=
penGL: 3.1 Mesa 10.1.4, Compiler: GCC 4.8, File-System: btrfs, Screen R=
esolution: 1920x1080
> >=20
> >=20
> > during playing PlaneShift with Intel gfx.
> >=20
> >=20
> > I get the impression that Intel P-State driver turbo modes all of t=
he cores
> > needlessly *and* permanently once this condition is triggered. Usua=
lly
> > temperature is just about 55-60 degree celsius. But not at maximum.
> >=20
> >=20
> > I see this:
> >=20
> > merkaba:/sys/devices/system/cpu> grep . cpu[0-3]/cpufreq/cpuinfo_cu=
r_freq
> > cpu0/cpufreq/cpuinfo_cur_freq:3015917
> > cpu1/cpufreq/cpuinfo_cur_freq:3008984
> > cpu2/cpufreq/cpuinfo_cur_freq:3000000
> > cpu3/cpufreq/cpuinfo_cur_freq:3000000
> >=20
> >=20
> > Without that much work to do:
> >=20
> > merkaba:~> mpstat -P ALL 10
> > Linux 3.15.0-tp520 (merkaba)    09.06.2014      _x86_64_        (4 =
CPU)
> >=20
> > 23:21:42     CPU    %usr   %nice    %sys %iowait    %irq   %soft  %=
steal  %guest  %gnice   %idle
> > 23:21:52     all   15,61    0,00    2,68   10,33    0,15    0,00   =
 0,00    0,00    0,00   71,23
> > 23:21:52       0   25,70    0,00    4,22   22,59    0,30    0,00   =
 0,00    0,00    0,00   47,19
> > 23:21:52       1   20,02    0,00    1,80   14,71    0,10    0,00   =
 0,00    0,00    0,00   63,36
> > 23:21:52       2   10,14    0,00    2,61    3,01    0,10    0,00   =
 0,00    0,00    0,00   84,14
> > 23:21:52       3    6,63    0,00    2,11    0,80    0,10    0,00   =
 0,00    0,00    0,00   90,36
> >=20
> > 23:21:52     CPU    %usr   %nice    %sys %iowait    %irq   %soft  %=
steal  %guest  %gnice   %idle
> > 23:22:02     all   14,19    0,00    2,26   10,93    0,13    0,00   =
 0,00    0,00    0,00   72,50
> > 23:22:02       0   32,26    0,00    4,01   31,86    0,20    0,00   =
 0,00    0,00    0,00   31,66
> > 23:22:02       1   12,11    0,00    1,30    8,51    0,10    0,00   =
 0,00    0,00    0,00   77,98
> > 23:22:02       2    8,12    0,00    2,21    2,91    0,10    0,00   =
 0,00    0,00    0,00   86,66
> > 23:22:02       3    4,31    0,00    1,60    0,40    0,10    0,00   =
 0,00    0,00    0,00   93,59
> >=20
> > 23:22:02     CPU    %usr   %nice    %sys %iowait    %irq   %soft  %=
steal  %guest  %gnice   %idle
> > 23:22:12     all   25,33    0,03    2,63    9,00    0,15    0,00   =
 0,00    0,00    0,00   62,87
> > 23:22:12       0   35,71    0,00    4,01   19,56    0,20    0,00   =
 0,00    0,00    0,00   40,52
> > 23:22:12       1   27,43    0,00    1,90   10,61    0,20    0,00   =
 0,00    0,00    0,00   59,86
> > 23:22:12       2   22,14    0,10    2,40    4,41    0,10    0,00   =
 0,00    0,00    0,00   70,84
> > 23:22:12       3   15,96    0,10    2,21    1,41    0,10    0,00   =
 0,00    0,00    0,00   80,22
> >=20
> > 23:22:12     CPU    %usr   %nice    %sys %iowait    %irq   %soft  %=
steal  %guest  %gnice   %idle
> > 23:22:22     all   27,90    0,03    3,94    8,87    0,33    0,00   =
 0,00    0,00    0,00   58,94
> > 23:22:22       0   36,77    0,00    5,81   20,74    0,90    0,00   =
 0,00    0,00    0,00   35,77
> > 23:22:22       1   28,99    0,00    2,41   10,13    0,10    0,00   =
 0,00    0,00    0,00   58,38
> > 23:22:22       2   25,48    0,00    3,81    3,21    0,20    0,00   =
 0,00    0,00    0,00   67,30
> > 23:22:22       3   20,34    0,00    3,71    1,40    0,20    0,00   =
 0,00    0,00    0,00   74,35
> >=20
> >=20
> >=20
> > Will reboot now to see whether it resets that condition. Didn=B4t h=
appen during the whole
> > day.
> >=20
> > But seems to happen after a while of playing PlaneShift.
> >=20
> > Any hints?
>=20
> Thanks,
>=20

--=20
Martin 'Helios' Steigerwald - http://www.Lichtvoll.de
GPG: 03B0 0D6C 0040 0710 4AFA  B82F 991B EAAC A599 84C7
