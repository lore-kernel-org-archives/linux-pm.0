From: Martin Steigerwald <Martin@lichtvoll.de>
Subject: Re: [REGRESSION] fan always on with 3.10-rc2
Date: Sun, 09 Jun 2013 20:34:10 +0200
Message-ID: <1461538.eEAU3Zp7hk@merkaba>
References: <15568618.SsOOjPSAq8@merkaba> <1825381.bJOGDrYABG@merkaba>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mondschein.lichtvoll.de ([194.150.191.11]:56394 "EHLO
	mail.lichtvoll.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751706Ab3FISeQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 9 Jun 2013 14:34:16 -0400
In-Reply-To: <1825381.bJOGDrYABG@merkaba>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Dirk Brandewie <dirk.brandewie@gmail.com>, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Frederic Weisbecker <fweisbec@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Michael Karcher <Michael.Karcher@fu-berlin.de>

Am Samstag, 8. Juni 2013, 22:34:44 schrieb Martin Steigerwald:
> Am Freitag, 24. Mai 2013, 13:03:18 schrieb Martin Steigerwald:
> > Hi!
> >=20
> > With 3.10-rc2 I see fan always or almost always on, even during ext=
ended
> > periods of basically idling around. I did not notice this with 3.9.=
 This is
> > on an ThinkPad T520 with Intel Sandybridge i5-2520M dual core with
> > hyperthreading at regularily 2,5 GhZ and Intel graphics (no nvidia)=
=2E
> >=20
> > I am using full hz:
> >=20
> > martin@merkaba:~/Linux/Kernel/Mainline/Bugs/fan always on with 3.10=
=2E2-rc2> xzgrep NO_HZ config-3.10.0-rc2-tp520.xz
> > CONFIG_NO_HZ_COMMON=3Dy
> > # CONFIG_NO_HZ_IDLE is not set
> > CONFIG_NO_HZ_FULL=3Dy
> > CONFIG_NO_HZ_FULL_ALL=3Dy
> > CONFIG_NO_HZ=3Dy
> > CONFIG_RCU_FAST_NO_HZ=3Dy
> >=20
> > And P-State driver (which I used in 3.9 already as well).
> >=20
> > Kernel config attached as xz. Use xzless or xzcat to display.
> >=20
> >=20
> > What puzzles is output of powertop, especially:
>=20
> Still present in 3.10-rc4.
>=20
> I disabled P-State driver but then rpm seems to be even worse.
>=20
> Around 2800 rpm all the time, was about 2650 with Intel P State drive=
r.
>=20
> Next I will try without CONFIG_NO_HZ_FULL and CONFIG_NO_HZ_FULL_ALL.

Okay, without these both the behavior is better. Fan still does not see=
m
to get into non running state, which it was able to with earlier kernel=
s
(or userspaces?), but its down to a quiet 1950 rpm with Intel P-State d=
river
enabled again. CC=B4d to people from thread "power management regressio=
n
in linux 3.10? (related to CONFIG_NO_HZ_FULL)" which I think is related=
=2E

Powertop values make a lot more sense as well:

PowerTOP v2.0     Overview   Idle stats   Frequency stats   Device stat=
s   Tunables                                    =20


          Package   |             Core    |            CPU 0       CPU =
1
                    |                     | C0 active   1,4%        0,9=
%
                    |                     | POLL        0,0%    0,0 ms =
 0,0%    0,0 ms
                    |                     | C1E-SNB     7,7%    3,0 ms =
 2,9%    5,3 ms
C2 (pc2)    1,1%    |                     |
C3 (pc3)    7,2%    | C3 (cc3)    8,4%    | C3-SNB      8,2%    3,1 ms =
 3,0%   15,2 ms
C6 (pc6)    4,9%    | C6 (cc6)    9,3%    | C6-SNB      7,0%    3,5 ms =
 6,2%   13,0 ms
C7 (pc7)    9,9%    | C7 (cc7)   64,3%    | C7-SNB     73,4%    6,8 ms =
84,0%   21,6 ms

                    |             Core    |            CPU 2       CPU =
3
                    |                     | C0 active   1,1%        0,9=
%
                    |                     | POLL        0,0%    0,0 ms =
 0,0%    0,0 ms
                    |                     | C1E-SNB    11,0%    6,9 ms =
 1,4%    4,8 ms
                    |                     |
                    | C3 (cc3)    9,3%    | C3-SNB      7,7%    5,8 ms =
 1,9%    6,0 ms
                    | C6 (cc6)   10,0%    | C6-SNB      8,5%    7,4 ms =
 4,1%    4,9 ms
                    | C7 (cc7)   64,9%    | C7-SNB     71,4%    8,2 ms =
91,1%    7,1 ms



PowerTOP v2.0     Overview   Idle stats   Frequency stats   Device stat=
s   Tunables                                    =20


            Package |             Core    |            CPU 0       CPU =
1
                    |                     | Actual    2,0 GHz     2,4 G=
Hz
Idle        54,4%   | Idle        97,4%   | Idle        98,9%       98,=
2%
2,90 GHz     0,6%   | 2,90 GHz     0,1%   | 2,90 GHz     0,1%        0,=
1%
2,81 GHz     2,6%   | 3,10 GHz     0,2%   | 3,10 GHz     0,1%        0,=
1%
3,10 GHz     1,2%   | 2,10 GHz     0,1%   | 2,10 GHz     0,0%        0,=
0%
3,21 GHz     7,3%   | 3,21 GHz     0,9%   | 3,21 GHz     0,1%        0,=
9%
2,10 GHz     2,3%   | 2,81 GHz     0,2%   | 2,81 GHz     0,1%        0,=
1%
3,00 GHz     3,5%   | 3,00 GHz     0,0%   | 3,00 GHz     0,0%        0,=
0%
2,40 GHz     3,5%   | 2,40 GHz     0,1%   | 2,40 GHz     0,1%        0,=
1%
1,91 GHz     1,0%   | 1,91 GHz     0,1%   | 1,91 GHz     0,0%        0,=
0%
2,21 GHz     0,6%   | 2,21 GHz     0,1%   | 2,21 GHz     0,1%        0,=
1%

                    |             Core    |            CPU 2       CPU =
3
                    |                     | Actual    2,4 GHz     2,5 G=
Hz
                    | Idle        56,3%   | Idle        98,4%       57,=
7%
                    | 2,90 GHz     0,5%   | 2,90 GHz     0,1%        0,=
9%
                    | 2,81 GHz     2,5%   | 2,81 GHz     0,1%        6,=
4%
                    | 3,10 GHz     1,1%   | 3,10 GHz     0,2%        2,=
2%
                    | 3,21 GHz     6,7%   | 3,00 GHz     0,0%        2,=
4%
                    | 3,00 GHz     3,5%   | 3,21 GHz     0,5%        3,=
4%
                    | 2,71 GHz     2,4%   | 2,50 GHz     0,1%        3,=
3%
                    | 2,50 GHz     1,1%   | 2,31 GHz     0,1%        0,=
4%
                    | 2,31 GHz     0,2%   | 2,71 GHz     0,1%        1,=
0%
                    | 2,60 GHz     1,0%   | 2,60 GHz     0,1%        2,=
7%


If I haven=B4t stated it. This is on a ThinkPad T520 with dual core
Sandybridge i5-2620M at 2.5 GHz (overclockable to 3.2 GhZ), now with
Kernel 3.10-rc5. I didn=B4t test this one with the full hz stuff enable=
d, only
rc2 and rc4.

> According to powertop CPU 0 is never idle
>=20
> PowerTOP v2.0     Overview   Idle stats   Frequency stats   Device st=
ats   Tunables                                    =20
>=20
>=20
>             Package |             Core    |            CPU 0       CP=
U 1
>                     |                     | Actual       843 MHz    1=
148 MHz
> Turbo Mode   2,2%   | Turbo Mode   2,1%   | Turbo Mode   2,1%        =
0,8%
> 2,50 GHz     0,9%   | 2,50 GHz     0,9%   | 2,50 GHz     0,9%        =
0,0%
> 2,00 GHz     0,0%   | 2,00 GHz     0,0%   | 2,00 GHz     0,0%        =
0,0%
> 1,80 GHz     0,1%   | 1,80 GHz     0,1%   | 1,80 GHz     0,1%        =
0,0%
> 1,60 GHz     0,0%   | 1,60 GHz     0,0%   | 1,60 GHz     0,0%        =
0,0%
> 1400 MHz     0,0%   | 1400 MHz     0,0%   | 1400 MHz     0,0%        =
0,0%
> 1200 MHz     0,0%   | 1200 MHz     0,0%   | 1200 MHz     0,0%        =
0,0%
> 1000 MHz     0,0%   | 1000 MHz     0,0%   | 1000 MHz     0,0%        =
0,0%
>  800 MHz    87,9%   |  800 MHz    87,3%   |  800 MHz    87,1%        =
3,5%
> Idle         9,0%   | Idle         9,6%   | Idle         9,9%       9=
5,7%
>=20
>                     |             Core    |            CPU 2       CP=
U 3
>                     |                     | Actual       953 MHz     =
905 MHz
>                     | Turbo Mode   0,8%   | Turbo Mode   0,7%        =
0,1%
>                     | 2,50 GHz     0,7%   | 2,50 GHz     0,7%        =
0,0%
>                     | 2,00 GHz     0,0%   | 2,00 GHz     0,0%        =
0,0%
>                     | 1,80 GHz     0,1%   | 1,80 GHz     0,1%        =
0,0%
>                     | 1,60 GHz     0,0%   | 1,60 GHz     0,0%        =
0,0%
>                     | 1400 MHz     0,0%   | 1400 MHz     0,0%        =
0,0%
>                     | 1200 MHz     0,0%   | 1200 MHz     0,0%        =
0,0%
>                     | 1000 MHz     0,0%   | 1000 MHz     0,0%        =
0,0%
>                     |  800 MHz    10,3%   |  800 MHz     7,4%        =
3,7%
>                     | Idle        88,1%   | Idle        91,0%       9=
6,2%
>=20
>=20
>=20
>=20
> PowerTOP v2.0     Overview   Idle stats   Frequency stats   Device st=
ats   Tunables                                    =20
>=20
>=20
>           Package   |             Core    |            CPU 0       CP=
U 1
>                     |                     | C0 active  32,5%        0=
,3%
>                     |                     | POLL       96,4%    0,9 m=
s  0,0%    0,0 ms
>                     |                     | C1E-SNB     0,0%    0,0 m=
s  0,0%    0,2 ms
> C2 (pc2)    0,0%    |                     |
> C3 (pc3)    0,0%    | C3 (cc3)    0,0%    | C3-SNB      0,0%    0,0 m=
s  0,0%    0,1 ms
> C6 (pc6)    0,0%    | C6 (cc6)    0,0%    | C6-SNB      0,0%    0,0 m=
s  0,0%    0,0 ms
> C7 (pc7)    0,0%    | C7 (cc7)    0,0%    | C7-SNB      0,0%    0,0 m=
s 99,2%   10,9 ms
>=20
>                     |             Core    |            CPU 2       CP=
U 3
>                     |                     | C0 active   1,2%        0=
,7%
>                     |                     | POLL        0,0%    0,0 m=
s  0,0%    0,0 ms
>                     |                     | C1E-SNB     0,0%    0,1 m=
s  0,1%    0,2 ms
>                     |                     |
>                     | C3 (cc3)    0,1%    | C3-SNB      0,0%    0,8 m=
s  0,0%    0,2 ms
>                     | C6 (cc6)    0,0%    | C6-SNB      0,0%    0,0 m=
s  0,0%    0,0 ms
>                     | C7 (cc7)   95,0%    | C7-SNB     97,7%   14,5 m=
s 97,7%   12,2 ms
>=20
>=20
> Old outputs with rc2 and P-State driver for comparison:
>=20
> >=20
> > PowerTOP v2.0     Overview   Idle stats   Frequency stats   Device =
stats   Tunables                                    =20
> >=20
> >=20
> >           Package   |             Core    |            CPU 0       =
CPU 1
> >                     |                     | C0 active 127,4%       =
 2,3%
> >                                                       ^^^^^^
> >                     |                     | POLL       98,1%    0,9=
 ms  0,0%    0,0 ms
> >                                                        ^^^^^
> >                     |                     | C1E-SNB     0,0%    0,0=
 ms  0,4%    0,9 ms
> > C2 (pc2)    0,0%    |                     |
> > C3 (pc3)    0,0%    | C3 (cc3)    0,0%    | C3-SNB      0,0%    0,0=
 ms  0,1%    0,8 ms
> > C6 (pc6)    0,0%    | C6 (cc6)    0,0%    | C6-SNB      0,0%    0,0=
 ms  0,0%    0,8 ms
> > C7 (pc7)    0,0%    | C7 (cc7)    0,0%    | C7-SNB      0,0%    0,0=
 ms 97,5%    7,4 ms
> >=20
> >                     |             Core    |            CPU 2       =
CPU 3
> >                     |                     | C0 active   1,9%       =
 0,8%
> >                     |                     | POLL        0,0%    0,0=
 ms  0,0%    0,0 ms
> >                     |                     | C1E-SNB     1,1%    1,3=
 ms  0,0%    0,1 ms
> >                     |                     |
> >                     | C3 (cc3)    0,3%    | C3-SNB      0,3%    1,0=
 ms  0,0%    0,2 ms
> >                     | C6 (cc6)    0,1%    | C6-SNB      0,1%    2,5=
 ms  0,0%    0,3 ms
> >                     | C7 (cc7)   96,2%    | C7-SNB     97,0%    7,2=
 ms 99,3%   17,2 ms
> >=20
> >=20
> > PowerTOP v2.0     Overview   Idle stats   Frequency stats   Device =
stats   Tunables                                    =20
> >=20
> >=20
> >             Package |             Core    |            CPU 0       =
CPU 1
> >                     |                     | Actual    3,2 GHz     3=
,1 GHz
> > Idle       100,0%   | Idle       100,0%   | Idle       100,0%      =
100,0%
> >=20
> >                     |             Core    |            CPU 2       =
CPU 3
> >                     |                     | Actual    3,0 GHz     3=
,0 GHz
> >                     | Idle       100,0%   | Idle       100,0%      =
100,0%
> >=20
> >=20
> > It seems the kernel is overbusying one core completely, if the outp=
ut of
> > powertop is correct. And why is Actual frequencing of CPUs that hig=
h?
> > I saw that kernel tends to overtact quickly. I thought this was due=
 to
> > getting work done quickly and then let it idle. But the idle stats
> > seem bogus to, maybe powertop is not up to date with current kernel=
s?
> >=20
> > I see no reason for busying one core. This happens when CPU usage i=
s
> > below 20%. The fan is consistently around 2640 rpm:
> >=20
> >=20
> > PowerTOP v2.0     Overview   Idle stats   Frequency stats   Device =
stats   Tunables                                    =20
> >=20
> > Summary: 399,8 wakeups/second,  0,0 GPU ops/second, 0,0 VFS ops/sec=
 and 3,0% CPU use
> >=20
> >                 Usage       Events/s    Category       Description
> >              2644 rpm                   Device         Laptop fan
> >             100,0%                      Device         Audio codec =
hwC0D1: Conexant
> >             100,0%                      Device         Audio codec =
hwC0D3: Intel
> >             100,0%                      Device         Audio codec =
hwC0D0: Conexant
> >              30,7 =B5s/s     112,3        Process        [ksoftirqd=
/0]
> >               4,2 ms/s      83,5        Process        kwin -sessio=
n 10cec7d36b000136265311700000023930000_1369322581_349094
> >               0,8 ms/s      67,3        Process        [irq/42-i915=
@pci]
> >               5,5 ms/s      53,6        Process        /usr/bin/X :=
0 vt7 -br -nolisten tcp -auth /var/run/xauth/A:0-eXsirc
> >             698,3 =B5s/s      13,3        Process        [irq/16-mm=
c0]
> >              85,8 =B5s/s       9,1        Process        [rcu_preem=
pt]
> >             297,1 =B5s/s       8,7        Process        /usr/sbin/=
mysqld --defaults-file=3D/home/martin/.local/share/akonadi/mysql.conf -=
-datadir
> >              78,6 =B5s/s       8,1        Process        [ksoftirqd=
/2]
> >               6,7 ms/s       3,7        Process        /usr/bin/pla=
sma-desktop
> >             218,9 =B5s/s       5,0        Interrupt      [1] timer(=
softirq)
> >               2,8 ms/s       2,9        Process        /usr/bin/kon=
sole -session 10cec7d36b000135326160200000249810027_1369322580_899575
> >              65,9 =B5s/s       3,6        Process        [ksoftirqd=
/1]
> >              69,8 =B5s/s       3,5        Process        [ksoftirqd=
/3]
> >              38,1 =B5s/s       3,4        Process        [rcuop/3]
> >              35,3 =B5s/s       2,4        Process        [rcuop/2]
> >               6,0 ms/s      0,00        Process        atop
> >              21,3 =B5s/s       1,8        Process        [irq/43-ah=
ci]
> >              33,3 =B5s/s       1,7        Process        [rcuop/0]
> >             122,3 =B5s/s       1,7        Process        [btrfs-tra=
nsacti]
> >              66,4 =B5s/s       1,5        Process        /usr/bin/d=
irmngr --daemon --sh
> >              61,2 =B5s/s       1,0        Process        [rcuop/1]
> >              29,2 =B5s/s       1,0        Process        /usr/lib/g=
vfs/gvfs-afc-volume-monitor
> >              40,8 =B5s/s       0,9        Timer          process_ti=
meout
> >              25,5 =B5s/s       0,9        Process        /usr/bin/p=
ython /usr/bin/hp-systray -x
> >              32,2 =B5s/s       0,7        Process        /usr/bin/d=
bus-daemon --fork --print-pid 5 --print-address 7 --session
> >               5,1 =B5s/s       0,7        Process        [irq/44-et=
h0]
> >             612,1 =B5s/s       0,4        Process        ksysguardd
> >             137,6 =B5s/s       0,5        Interrupt      [7] sched(=
softirq)
> >               5,6 =B5s/s       0,5        Timer          clocksourc=
e_watchdog
> >              71,2 =B5s/s       0,4        kWork          disk_event=
s_workfn
> >              57,5 =B5s/s       0,4        Process        kdeinit4: =
kded4 [kdeinit]
> >              68,3 =B5s/s       0,3        Process        akonadiser=
ver
> >              34,6 =B5s/s       0,3        Process        /usr/bin/v=
irtuoso-t +foreground +configfile /tmp/virtuoso_fB2599.ini +wait
> >              14,9 =B5s/s       0,3        Process        /usr/bin/g=
pg-agent --daemon --sh --write-env-file=3D/home/martin/.gnupg/gpg-agent=
-info-me
> >              39,4 =B5s/s      0,30        Process        /usr/bin/n=
epomukservicestub nepomukfileindexer
> >=20
> >=20
> > PowerTOP v2.0     Overview   Idle stats   Frequency stats   Device =
stats   Tunables                                    =20
> >=20
> >=20
> >               Usage     Device name
> >              2644 rpm     Laptop fan
> >               4,3%        CPU use
> >             100,0%        Audio codec hwC0D3: Intel
> >             100,0%        Audio codec hwC0D0: Conexant
> >             100,0%        Audio codec hwC0D1: Conexant
> >              20,9 pkts/s  Network interface: eth0 (e1000e)
> >             100,0%        USB device: usb-device-8087-0024
> >             100,0%        USB device: usb-device-8087-0024
> >             100,0%        Display backlight
> >             100,0%        Display backlight
> >             100,0%        USB device: EHCI Host Controller
> >             100,0%        USB device: Biometric Coprocessor (UPEK)
> >             100,0%        USB device: Integrated Smart Card Reader =
(Lenovo)
> >             100,0%        USB device: EHCI Host Controller
> >               0,0 ops/s   GPU
> >             100,0%        USB device: usb-device-17ef-100a
> >             100,0%        PCI Device: Intel Corporation 6 Series/C2=
00 Series Chipset Family PCI Express Root Port 5
> >             100,0%        PCI Device: Intel Corporation 6 Series/C2=
00 Series Chipset Family PCI Express Root Port 4
> >             100,0%        PCI Device: Intel Corporation 6 Series/C2=
00 Series Chipset Family PCI Express Root Port 2
> >             100,0%        PCI Device: Intel Corporation 6 Series/C2=
00 Series Chipset Family High Definition Audio Controller
> >             100,0%        PCI Device: Intel Corporation 6 Series/C2=
00 Series Chipset Family MEI Controller #1
> >             100,0%        USB device: PS/2+USB Mouse
> >             100,0%        PCI Device: Intel Corporation QM67 Expres=
s Chipset Family LPC Controller
> >             100,0%        PCI Device: Intel Corporation 6 Series/C2=
00 Series Chipset Family 6 port SATA AHCI Controller
> >             100,0%        PCI Device: Ricoh Co Ltd MMC/SD Host Cont=
roller
> >             100,0%        PCI Device: Silicon Image, Inc. SiI 3531 =
[SATALink/SATARaid] Serial ATA Controller
> >             100,0%        PCI Device: Ricoh Co Ltd R5C832 PCIe IEEE=
 1394 Controller
> >             100,0%        PCI Device: Intel Corporation 6 Series/C2=
00 Series Chipset Family USB Enhanced Host Controller #2
> >             100,0%        PCI Device: Intel Corporation 82579LM Gig=
abit Network Connection
> >             100,0%        PCI Device: Intel Corporation 6 Series/C2=
00 Series Chipset Family SMBus Controller
> >             100,0%        PCI Device: Intel Corporation 6 Series/C2=
00 Series Chipset Family PCI Express Root Port 1
> >             100,0%        PCI Device: Intel Corporation 6 Series/C2=
00 Series Chipset Family USB Enhanced Host Controller #1
> >             100,0%        PCI Device: Intel Corporation 2nd Generat=
ion Core Processor Family Integrated Graphics Controller
> >             100,0%        PCI Device: Intel Corporation 2nd Generat=
ion Core Processor Family DRAM Controller
> >             100,0%        PCI Device: Intel Corporation Centrino Ad=
vanced-N 6205 [Taylor Peak]
> >               0,0 pkts/s  Network interface: wlan0 (iwlwifi)
> >               0,0%        Thinkpad light
> >               0,0%        Radio device: thinkpad_acpi
> >               0,0%        Radio device: iwlwifi
> >=20
> >=20
> > I saw nothing outstanding in dmesg or kern.log, just
> >=20
> > merkaba:~#2> grep "Intel pstate controlling: cpu" /var/log/kern.log
> > May 20 10:03:31 merkaba kernel: [264852.930994] Intel pstate contro=
lling: cpu 1
> > May 20 10:03:31 merkaba kernel: [264852.944479] Intel pstate contro=
lling: cpu 2
> > May 20 10:03:31 merkaba kernel: [264852.957879] Intel pstate contro=
lling: cpu 3
> > May 21 09:14:03 merkaba kernel: [315800.710623] Intel pstate contro=
lling: cpu 1
> > May 21 09:14:03 merkaba kernel: [315800.724087] Intel pstate contro=
lling: cpu 2
> > May 21 09:14:03 merkaba kernel: [315800.737493] Intel pstate contro=
lling: cpu 3
> > May 21 20:01:20 merkaba kernel: [344305.122543] Intel pstate contro=
lling: cpu 1
> > May 21 20:01:20 merkaba kernel: [344305.135953] Intel pstate contro=
lling: cpu 2
> > May 21 20:01:20 merkaba kernel: [344305.149398] Intel pstate contro=
lling: cpu 3
> > May 21 21:52:18 merkaba kernel: [    1.441043] Intel pstate control=
ling: cpu 0
> > May 21 21:52:18 merkaba kernel: [    1.441084] Intel pstate control=
ling: cpu 1
> > May 21 21:52:18 merkaba kernel: [    1.441123] Intel pstate control=
ling: cpu 2
> > May 21 21:52:18 merkaba kernel: [    1.441162] Intel pstate control=
ling: cpu 3
> > May 23 17:22:29 merkaba kernel: [    1.860224] Intel pstate control=
ling: cpu 0
> > May 23 17:22:29 merkaba kernel: [    1.860267] Intel pstate control=
ling: cpu 1
> > May 23 17:22:29 merkaba kernel: [    1.860306] Intel pstate control=
ling: cpu 2
> > May 23 17:22:29 merkaba kernel: [    1.860345] Intel pstate control=
ling: cpu 3
> >=20
> > But these seem to be regular and I had them before as well.
> >=20
> > Thanks,
> >=20
>=20
--=20
Martin 'Helios' Steigerwald - http://www.Lichtvoll.de
GPG: 03B0 0D6C 0040 0710 4AFA  B82F 991B EAAC A599 84C7
