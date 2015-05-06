From: Martin Steigerwald <martin@lichtvoll.de>
Subject: [BUG] ThinkPad T520 overheating with P-State driver
Date: Wed, 06 May 2015 22:36:37 +0200
Message-ID: <2208008.uDRZL3Gdb7@merkaba>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mondschein.lichtvoll.de ([194.150.191.11]:48122 "EHLO
	mail.lichtvoll.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751285AbbEFUgj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 6 May 2015 16:36:39 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Kristen Carlson Accardi <kristen@linux.intel.com>

Hello Kristen, hello,

Laptop overheats with Intel P-State driver like follows:

[ 6743.833543] CPU0: Package temperature above threshold, cpu clock=20
throttled (total events =3D 1)
[ 6743.833545] CPU1: Package temperature above threshold, cpu clock=20
throttled (total events =3D 1)
[ 6743.833567] CPU2: Package temperature above threshold, cpu clock=20
throttled (total events =3D 1)
[ 6743.833568] CPU3: Package temperature above threshold, cpu clock=20
throttled (total events =3D 1)
[ 6743.834580] CPU0: Package temperature/speed normal
[ 6743.834581] CPU1: Package temperature/speed normal
[ 6743.834607] CPU3: Package temperature/speed normal
[ 6743.834608] CPU2: Package temperature/speed normal

This happens on high cpu load and is easily triggerable by playing=20
PlaneShift or OpenMW.

Also reports a MCE machine check error sometimes.


This may partly be due to an aging hardware.


Yet, after I switched from Intel P-State driver to acpi-cpufreq driver =
the=20
issue got *much* better. I switched after I found that Intel P-State dr=
iver=20
doesn=B4t respect "noturbo" setting at all on this ThinkPad:

[Bug 97261] New: Intel P-State driver does not honor no_turbo
https://bugzilla.kernel.org/show_bug.cgi?id=3D97261

(I wanted to limit maximum performance in order to prevent the overheat=
ing)


I get frequencies like:

3080566
3068945
3009082
2999902=20

despite no_turbo setting. So it basically switches the complete dual co=
re=20
hypertreading CPU into turbo mode. Despite not even all cores being use=
d by=20
processes. PlaneShift basically runs single-threaded. Then there are so=
me=20
other processes active in background from time to time, but but they do=
 not=20
use the other core completely usually.


Yet with acpi-cpufreq without limiting maximum performance at all, I ge=
t the=20
following with the *same* workload:

Every 5,0s: cat cpu?/cpufreq/scaling_cur_freq ; sensors                =
                        =20
Wed May  6 22:12:41 2015

2501000
2501000
1000000
1000000
acpitz-virtual-0
Adapter: Virtual device
temp1:        +95.0=B0C  (crit =3D +98.0=B0C)

coretemp-isa-0000
Adapter: ISA adapter
Physical id 0:  +96.0=B0C  (high =3D +86.0=B0C, crit =3D +100.0=B0C)
Core 0:         +88.0=B0C  (high =3D +86.0=B0C, crit =3D +100.0=B0C)
Core 1:         +90.0=B0C  (high =3D +86.0=B0C, crit =3D +100.0=B0C)

thinkpad-isa-0000
Adapter: ISA adapter
fan1:        3578 RPM



Every 5,0s: cat cpu?/cpufreq/scaling_cur_freq ; sensors                =
                        =20
Wed May  6 22:22:22 2015

2501000
1000000
800000
1600000
acpitz-virtual-0
Adapter: Virtual device
temp1:        +96.0=B0C  (crit =3D +98.0=B0C)

coretemp-isa-0000
Adapter: ISA adapter
Physical id 0:  +97.0=B0C  (high =3D +86.0=B0C, crit =3D +100.0=B0C)
Core 0:         +89.0=B0C  (high =3D +86.0=B0C, crit =3D +100.0=B0C)
Core 1:         +90.0=B0C  (high =3D +86.0=B0C, crit =3D +100.0=B0C)

thinkpad-isa-0000
Adapter: ISA adapter
fan1:        3600 RPM


I barely see the Core temps go up to more than 92 degrees while with P-=
State=20
they were consistently hitting 96-98 degrees.

The performance is better and its overheating way less. It hit throttli=
ng=20
just twice so far, despite warmer room temperature today, while it basi=
cally=20
hits throttling to the extent PlaneShift or OpenMW become basically=20
unplayable with Intel P-State.

Its not perfect as I think it shouldn=B4t hit overheating at all, but w=
ell,=20
maybe thats aging hardware.


It is often said Intel P-State is technically better, but now I see tha=
t=20
acpi-cpufreq runs way better on my machine here.


martin@merkaba:~> phoronix-test-suite system-info

Phoronix Test Suite v5.2.1
System Information

Hardware:
Processor: Intel Core i5-2520M @ 2.50GHz (4 Cores), Motherboard: LENOVO=
=20
42433WG, Chipset: Intel 2nd Generation Core Family DRAM, Memory: 16384M=
B,=20
Disk: 300GB INTEL SSDSA2CW30 + 480GB Crucial_CT480M50, Graphics: Intel =
HD=20
3000 (1300MHz), Audio: Intel 6 /C200, Monitor: P24T-7 LED, Network: Int=
el=20
82579LM Gigabit Connection + Intel Centrino Advanced-N 6205

Software:
OS: Debian unstable, Kernel: 4.0.1-tp520-btrfs-trim-norace+ (x86_64),=20
Desktop: KDE 4.14.2, Display Server: X Server 1.16.4, Display Driver: i=
ntel=20
2.21.15, OpenGL: 3.3 Mesa 10.4.2, Compiler: GCC 4.9.2, File-System: btr=
fs,=20
Screen Resolution: 3840x1080


martin@merkaba:~> LANG=3DC lscpu
Architecture:          x86_64
CPU op-mode(s):        32-bit, 64-bit
Byte Order:            Little Endian
CPU(s):                4
On-line CPU(s) list:   0-3
Thread(s) per core:    2
Core(s) per socket:    2
Socket(s):             1
NUMA node(s):          1
Vendor ID:             GenuineIntel
CPU family:            6
Model:                 42
Model name:            Intel(R) Core(TM) i5-2520M CPU @ 2.50GHz
Stepping:              7
CPU MHz:               1200.000
CPU max MHz:           2501.0000
CPU min MHz:           800.0000
BogoMIPS:              4983.83
Virtualization:        VT-x
L1d cache:             32K
L1i cache:             32K
L2 cache:              256K
L3 cache:              3072K
NUMA node0 CPU(s):     0-3



There is also some other bug report about this:

Please change intel_pstate default to disable=20
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1188647

appears to be quite old, but still seems unresolved.

Ciao,
--=20
Martin 'Helios' Steigerwald - http://www.Lichtvoll.de
GPG: 03B0 0D6C 0040 0710 4AFA  B82F 991B EAAC A599 84C7
