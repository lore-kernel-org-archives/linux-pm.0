From: Jim Hochschild <illini_80@yahoo.com>
Subject: PROBLEM: cpufreq ondemand governor problem
Date: Tue, 06 Aug 2013 08:56:19 -0500
Message-ID: <52010083.5020005@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
Cc: 1136700@bugs.launchpad.net
List-Id: linux-pm@vger.kernel.org

[1.] One line summary of the problem:

cpufreq ondemand governor problem

[2.] Full description of the problem/report:

I'm seeing a problem with the cpufreq ondemand governor in Ubuntu 12.04 32-bit. When I
load one core of my Intel i5-3570 processor, instead of switching to a steady
3.8GHz clock as I would expect, the clock actually toggles between 1.6GHz (min
frequency) and 3.8GHz (max frequency), even though the core is maxed out at
100%. I can increase the time it spends at 3.8GHz by increasing the
sampling_down_factor tuning parameter, but it still switches back to 1.6GHz,
albeit less frequently. I've also tried 12.10 32-bit and it has the same
problem. However, 12.04 and 12.10 64-bit do not have the problem. I decided to
look into this a little further, so I copied the source code for the ondemand
governor module and added a little debug code to see what was going on. I found
that the __cpufreq_driver_getavg function call was sometimes returning a value
which was several orders of magnitude too small. For example:

[20174.251637] mygov: freq_avg(2) = 158 freq_cur = 3801000
[20174.251642] mygov: freq_avg(0) = 4149919 freq_cur = 1600000
[20174.251645] mygov: freq_avg(1) = 4149919 freq_cur = 1600000
[20174.251647] mygov: freq_avg(3) = 4120224 freq_cur = 1600000

As you can see, the return value freq_avg is very small for core 2, which is the
maxed out core. This value is calculated in mperf.c using 32-bit unsigned
integers (in the 32-bit OS case) and it includes a final 10-bit right shift. As
you can see, the normal return value is greater than 4meg, so before the shift it
is greater then 4gig, right at the limit of a 32-bit integer. I believe that the
erroneous return values are due to 32-bit overflow in the average frequency
calculation. However, in the 64-bit OS the calculation uses 64 bits since one of
the variables is declared as unsigned long, so there is no overflow. Note that
slower processors wouldn't show this problem since the average frequency numbers
would be smaller. Also, I have noticed that if I load 3 or 4 cores, the problem
disappears. This is because the processor maximum clock frequency is
automatically reduced to 3.7GHz or 3.6GHz respectively, and this frequency
reduction is enough to avoid overflow.

https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1136700

[3.] Keywords (i.e., modules, networking, kernel): Please note, Kernel.org uses a different keyword system then the Ubuntu Tags system.

modules ondemand

I'm sorry, I couldn't find any information about the Kernel.org keyword system.

[4.] Kernel version (from /proc/version):

Linux version 3.11.0-031100rc4-generic (apw@gomeisa) (gcc version 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201308041735 SMP Sun Aug 4 21:45:18 UTC 2013

[5.] Output of Oops.. message (if applicable) with symbolic information resolved (see Documentation/oops-tracing.txt)

not applicable

[6.] A small shell script or example program which triggers the problem (if possible)

anything that causes 100% CPU utilization, for example:
perl -e 'for($i=0;$i<300000000;$i++){}'

[7.] Environment

Description:    Ubuntu 12.04.2 LTS
Release:        12.04

[7.1.] Software (add the output of the ver_linux script here)

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux elrond 3.11.0-031100rc4-generic #201308041735 SMP Sun Aug 4 21:45:18 UTC 2013 i686 i686 i386 GNU/Linux

Gnu C                  4.6
Gnu make               3.81
binutils               2.22
util-linux             2.20.1
mount                  support
module-init-tools      3.16
e2fsprogs              1.42
reiserfsprogs          3.6.21
pcmciautils            018
PPP                    2.4.5
Linux C Library        2.15
Dynamic linker (ldd)   2.15
Procps                 3.2.8
Net-tools              1.60
Kbd                    1.15.2
Sh-utils               8.13
wireless-tools         30
Modules Loaded         netconsole configfs ipt_REJECT xt_tcpudp xt_LOG iptable_filter ip_tables x_tables dm_crypt parport_pc ppdev lp parport binfmt_misc snd_ens1371 gameport snd_ac97_codec ac97_bus snd_pcm snd_seq_midi snd_rawmidi snd_seq_midi_event snd_seq snd_timer snd_seq_device hid_generic usblp snd psmouse coretemp soundcore usbhid snd_page_alloc hid serio_raw aesni_intel ablk_helper mac_hid cryptd lrw xts gf128mul mei_me lpc_ich mei aes_i586 cryptoloop i915 ahci libahci drm_kms_helper drm alx mdio i2c_algo_bit video

[7.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 58
model name      : Intel(R) Core(TM) i5-3570 CPU @ 3.40GHz
stepping        : 9
microcode       : 0x12
cpu MHz         : 1600.000
cache size      : 6144 KB
physical id     : 0
siblings        : 4
core id         : 0
cpu cores       : 4
apicid          : 0
initial apicid  : 0
fdiv_bug        : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 13
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx rdtscp lm constant_tsc arch_perfmon pebs bts xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm ida arat epb xsaveopt pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase smep erms
bogomips        : 6784.67
clflush size    : 64
cache_alignment : 64
address sizes   : 36 bits physical, 48 bits virtual
power management:

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 58
model name      : Intel(R) Core(TM) i5-3570 CPU @ 3.40GHz
stepping        : 9
microcode       : 0x12
cpu MHz         : 1600.000
cache size      : 6144 KB
physical id     : 0
siblings        : 4
core id         : 1
cpu cores       : 4
apicid          : 2
initial apicid  : 2
fdiv_bug        : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 13
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx rdtscp lm constant_tsc arch_perfmon pebs bts xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm ida arat epb xsaveopt pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase smep erms
bogomips        : 6784.67
clflush size    : 64
cache_alignment : 64
address sizes   : 36 bits physical, 48 bits virtual
power management:

processor       : 2
vendor_id       : GenuineIntel
cpu family      : 6
model           : 58
model name      : Intel(R) Core(TM) i5-3570 CPU @ 3.40GHz
stepping        : 9
microcode       : 0x12
cpu MHz         : 1600.000
cache size      : 6144 KB
physical id     : 0
siblings        : 4
core id         : 2
cpu cores       : 4
apicid          : 4
initial apicid  : 4
fdiv_bug        : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 13
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx rdtscp lm constant_tsc arch_perfmon pebs bts xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm ida arat epb xsaveopt pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase smep erms
bogomips        : 6784.67
clflush size    : 64
cache_alignment : 64
address sizes   : 36 bits physical, 48 bits virtual
power management:

processor       : 3
vendor_id       : GenuineIntel
cpu family      : 6
model           : 58
model name      : Intel(R) Core(TM) i5-3570 CPU @ 3.40GHz
stepping        : 9
microcode       : 0x12
cpu MHz         : 1600.000
cache size      : 6144 KB
physical id     : 0
siblings        : 4
core id         : 3
cpu cores       : 4
apicid          : 6
initial apicid  : 6
fdiv_bug        : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 13
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx rdtscp lm constant_tsc arch_perfmon pebs bts xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm ida arat epb xsaveopt pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase smep erms
bogomips        : 6784.67
clflush size    : 64
cache_alignment : 64
address sizes   : 36 bits physical, 48 bits virtual
power management:

[7.3.] Module information (from /proc/modules):

msr 12772 0 - Live 0x00000000
netconsole 14231 0 - Live 0x00000000
configfs 30380 2 netconsole, Live 0x00000000
ipt_REJECT 12512 2 - Live 0x00000000
xt_tcpudp 12788 77 - Live 0x00000000
xt_LOG 17544 39 - Live 0x00000000
iptable_filter 12706 1 - Live 0x00000000
ip_tables 18302 1 iptable_filter, Live 0x00000000
x_tables 22178 5 ipt_REJECT,xt_tcpudp,xt_LOG,iptable_filter,ip_tables, Live 0x00000000
dm_crypt 22524 0 - Live 0x00000000
parport_pc 32114 0 - Live 0x00000000
ppdev 17423 0 - Live 0x00000000
lp 13359 0 - Live 0x00000000
parport 40930 3 parport_pc,ppdev,lp, Live 0x00000000
binfmt_misc 17268 1 - Live 0x00000000
snd_ens1371 24847 2 - Live 0x00000000
gameport 15060 1 snd_ens1371, Live 0x00000000
snd_ac97_codec 110295 1 snd_ens1371, Live 0x00000000
ac97_bus 12642 1 snd_ac97_codec, Live 0x00000000
snd_pcm 94597 2 snd_ens1371,snd_ac97_codec, Live 0x00000000
snd_seq_midi 13132 0 - Live 0x00000000
snd_rawmidi 25157 2 snd_ens1371,snd_seq_midi, Live 0x00000000
snd_seq_midi_event 14475 1 snd_seq_midi, Live 0x00000000
snd_seq 55716 2 snd_seq_midi,snd_seq_midi_event, Live 0x00000000
snd_timer 28930 2 snd_pcm,snd_seq, Live 0x00000000
snd_seq_device 14137 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 0x00000000
hid_generic 12492 0 - Live 0x00000000
usblp 18377 0 - Live 0x00000000
snd 61270 12 snd_ens1371,snd_ac97_codec,snd_pcm,snd_seq_midi,snd_rawmidi,snd_seq,snd_timer,snd_seq_device, Live 0x00000000
psmouse 92607 0 - Live 0x00000000
coretemp 13352 0 - Live 0x00000000
soundcore 12600 1 snd, Live 0x00000000
usbhid 47620 0 - Live 0x00000000
snd_page_alloc 18398 1 snd_pcm, Live 0x00000000
hid 83045 2 hid_generic,usbhid, Live 0x00000000
serio_raw 13189 0 - Live 0x00000000
aesni_intel 18196 0 - Live 0x00000000
ablk_helper 13357 1 aesni_intel, Live 0x00000000
mac_hid 13077 0 - Live 0x00000000
cryptd 19821 1 ablk_helper, Live 0x00000000
lrw 13127 1 aesni_intel, Live 0x00000000
xts 12778 1 aesni_intel, Live 0x00000000
gf128mul 14503 2 lrw,xts, Live 0x00000000
mei_me 18123 0 - Live 0x00000000
lpc_ich 16987 0 - Live 0x00000000
mei 67046 1 mei_me, Live 0x00000000
aes_i586 16995 1 aesni_intel, Live 0x00000000
cryptoloop 12570 0 - Live 0x00000000
i915 606963 2 - Live 0x00000000
ahci 25703 8 - Live 0x00000000
libahci 30834 1 ahci, Live 0x00000000
drm_kms_helper 47306 1 i915, Live 0x00000000
drm 247743 3 i915,drm_kms_helper, Live 0x00000000
alx 31972 0 - Live 0x00000000
mdio 13559 1 alx, Live 0x00000000
i2c_algo_bit 13316 1 i915, Live 0x00000000
video 19046 1 i915, Live 0x00000000

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

0000-0cf7 : PCI Bus 0000:00
   0000-001f : dma1
   0020-0021 : pic1
   0040-0043 : timer0
   0050-0053 : timer1
   0060-0060 : keyboard
   0064-0064 : keyboard
   0070-0077 : rtc0
   0080-008f : dma page reg
   00a0-00a1 : pic2
   00c0-00df : dma2
   00f0-00ff : fpu
   0200-020f : pnp 00:04
   03f8-03ff : serial
   0400-0403 : ACPI PM1a_EVT_BLK
   0404-0405 : ACPI PM1a_CNT_BLK
   0408-040b : ACPI PM_TMR
   0410-0415 : ACPI CPU throttle
   0420-042f : ACPI GPE0_BLK
   0430-0433 : iTCO_wdt
   0450-0450 : ACPI PM2_CNT_BLK
   0454-0457 : pnp 00:06
   0458-047f : pnp 00:04
     0460-047f : iTCO_wdt
   04d0-04d1 : pnp 00:08
   0500-057f : pnp 00:04
   0680-069f : pnp 00:04
   0a00-0a0f : pnp 00:07
   0a20-0a2f : pnp 00:07
   0a30-0a3f : pnp 00:07
0cf8-0cff : PCI conf1
0d00-ffff : PCI Bus 0000:00
   d000-dfff : PCI Bus 0000:03
     d000-dfff : PCI Bus 0000:04
       d000-d03f : 0000:04:00.0
         d000-d03f : Ensoniq AudioPCI
   e000-efff : PCI Bus 0000:02
     e000-e07f : 0000:02:00.0
   f000-f03f : 0000:00:02.0
   f040-f05f : 0000:00:1f.3
   f060-f07f : 0000:00:1f.2
     f060-f07f : ahci
   f080-f083 : 0000:00:1f.2
     f080-f083 : ahci
   f090-f097 : 0000:00:1f.2
     f090-f097 : ahci
   f0a0-f0a3 : 0000:00:1f.2
     f0a0-f0a3 : ahci
   f0b0-f0b7 : 0000:00:1f.2
     f0b0-f0b7 : ahci
   ffff-ffff : pnp 00:04
     ffff-ffff : pnp 00:04

00000000-00000fff : reserved
00001000-0009d7ff : System RAM
0009d800-0009ffff : reserved
000a0000-000bffff : PCI Bus 0000:00
   000a0000-000bffff : Video RAM area
000c0000-000ce5ff : Video ROM
000d0000-000d3fff : PCI Bus 0000:00
000d4000-000d7fff : PCI Bus 0000:00
000d8000-000dbfff : PCI Bus 0000:00
000dc000-000dffff : PCI Bus 0000:00
000e0000-000fffff : reserved
   000e0000-000e3fff : PCI Bus 0000:00
   000e4000-000e7fff : PCI Bus 0000:00
   000f0000-000fffff : System ROM
00100000-1fffffff : System RAM
   01000000-01668062 : Kernel code
   01668063-019bd17f : Kernel data
   01aa1000-01b94fff : Kernel bss
20000000-201fffff : reserved
   20000000-201fffff : pnp 00:0b
20200000-40003fff : System RAM
40004000-40004fff : reserved
   40004000-40004fff : pnp 00:0b
40005000-d958dfff : System RAM
d958e000-d9a3dfff : reserved
d9a3e000-d9a3efff : ACPI Tables
d9a3f000-d9b61fff : ACPI Non-volatile Storage
d9b62000-da308fff : reserved
da309000-da309fff : System RAM
da30a000-da34cfff : ACPI Non-volatile Storage
da34d000-dac94fff : System RAM
dac95000-dafdcfff : reserved
dafdd000-daffffff : System RAM
db000000-db7fffff : RAM buffer
db800000-df9fffff : reserved
dfa00000-feafffff : PCI Bus 0000:00
   dfa00000-dfa00fff : pnp 00:0a
   e0000000-efffffff : 0000:00:02.0
   f7800000-f7bfffff : 0000:00:02.0
   f7c00000-f7cfffff : PCI Bus 0000:02
     f7c00000-f7c3ffff : 0000:02:00.0
       f7c00000-f7c3ffff : alx
   f7d00000-f7d0ffff : 0000:00:14.0
     f7d00000-f7d0ffff : xhci_hcd
   f7d11000-f7d110ff : 0000:00:1f.3
   f7d12000-f7d127ff : 0000:00:1f.2
     f7d12000-f7d127ff : ahci
   f7d13000-f7d133ff : 0000:00:1d.0
     f7d13000-f7d133ff : ehci_hcd
   f7d14000-f7d143ff : 0000:00:1a.0
     f7d14000-f7d143ff : ehci_hcd
   f7d16000-f7d1600f : 0000:00:16.0
     f7d16000-f7d1600f : mei_me
   f8000000-fbffffff : PCI MMCONFIG 0000 [bus 00-3f]
     f8000000-fbffffff : reserved
       f8000000-fbffffff : pnp 00:0a
fec00000-fec00fff : reserved
   fec00000-fec003ff : IOAPIC 0
fed00000-fed03fff : reserved
   fed00000-fed003ff : HPET 0
fed10000-fed17fff : pnp 00:0a
fed18000-fed18fff : pnp 00:0a
fed19000-fed19fff : pnp 00:0a
fed1c000-fed1ffff : reserved
   fed1c000-fed1ffff : pnp 00:0a
     fed1f410-fed1f414 : iTCO_wdt
fed20000-fed3ffff : pnp 00:0a
fed40000-fed44fff : pnp 00:00
fed45000-fed8ffff : pnp 00:0a
fed90000-fed93fff : pnp 00:0a
   fed90000-fed90fff : dmar0
   fed91000-fed91fff : dmar1
fee00000-fee00fff : Local APIC
   fee00000-fee00fff : reserved
ff000000-ffffffff : reserved
   ff000000-ffffffff : pnp 00:0a
100000000-21f5fffff : System RAM
21f600000-21fffffff : RAM buffer

[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: Intel Corporation Ivy Bridge DRAM Controller (rev 09)
         Subsystem: Giga-byte Technology Device 5000
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR- INTx-
         Latency: 0
         Capabilities: [e0] Vendor Specific Information: Len=0c <?>

00:02.0 VGA compatible controller: Intel Corporation Ivy Bridge Graphics Controller (rev 09) (prog-if 00 [VGA controller])
         Subsystem: Giga-byte Technology Device d000
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0
         Interrupt: pin A routed to IRQ 42
         Region 0: Memory at f7800000 (64-bit, non-prefetchable) [size=4M]
         Region 2: Memory at e0000000 (64-bit, prefetchable) [size=256M]
         Region 4: I/O ports at f000 [size=64]
         Expansion ROM at <unassigned> [disabled]
         Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
                 Address: fee0200c  Data: 41a1
         Capabilities: [d0] Power Management version 2
                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [a4] PCI Advanced Features
                 AFCap: TP+ FLR+
                 AFCtrl: FLR-
                 AFStatus: TP-
         Kernel driver in use: i915
         Kernel modules: i915

00:14.0 USB controller: Intel Corporation Panther Point USB xHCI Host Controller (rev 04) (prog-if 30 [XHCI])
         Subsystem: Giga-byte Technology Device 5007
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0
         Interrupt: pin A routed to IRQ 40
         Region 0: Memory at f7d00000 (64-bit, non-prefetchable) [size=64K]
         Capabilities: [70] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [80] MSI: Enable+ Count=1/8 Maskable- 64bit+
                 Address: 00000000fee0f00c  Data: 4171
         Kernel driver in use: xhci_hcd

00:16.0 Communication controller: Intel Corporation Panther Point MEI Controller #1 (rev 04)
         Subsystem: Giga-byte Technology Device 1c3a
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0
         Interrupt: pin A routed to IRQ 43
         Region 0: Memory at f7d16000 (64-bit, non-prefetchable) [size=16]
         Capabilities: [50] Power Management version 3
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [8c] MSI: Enable+ Count=1/1 Maskable- 64bit+
                 Address: 00000000fee0f00c  Data: 41b1
         Kernel driver in use: mei_me
         Kernel modules: mei-me

00:1a.0 USB controller: Intel Corporation Panther Point USB Enhanced Host Controller #2 (rev 04) (prog-if 20 [EHCI])
         Subsystem: Giga-byte Technology Device 5006
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0
         Interrupt: pin A routed to IRQ 16
         Region 0: Memory at f7d14000 (32-bit, non-prefetchable) [size=1K]
         Capabilities: [50] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [58] Debug port: BAR=1 offset=00a0
         Capabilities: [98] PCI Advanced Features
                 AFCap: TP+ FLR+
                 AFCtrl: FLR-
                 AFStatus: TP-
         Kernel driver in use: ehci-pci

00:1c.0 PCI bridge: Intel Corporation Panther Point PCI Express Root Port 1 (rev c4) (prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0, Cache Line Size: 64 bytes
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
         I/O behind bridge: 0000f000-00000fff
         Memory behind bridge: fff00000-000fffff
         Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
         BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
         Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
                 DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
                         ExtTag- RBE+ FLReset-
                 DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
                         RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                         MaxPayload 128 bytes, MaxReadReq 128 bytes
                 DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
                 LnkCap: Port #1, Speed 5GT/s, Width x4, ASPM unknown, Latency L0 <1us, L1 <16us
                         ClockPM- Surprise- LLActRep+ BwNot-
                 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                 LnkSta: Speed 2.5GT/s, Width x0, TrErr- Train+ SlotClk+ DLActive- BWMgmt- ABWMgmt-
                 SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
                         Slot #0, PowerLimit 25.000W; Interlock- NoCompl+
                 SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
                         Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
                 SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
                         Changed: MRL- PresDet- LinkState-
                 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
                 RootCap: CRSVisible-
                 RootSta: PME ReqID 0000, PMEStatus- PMEPending-
                 DevCap2: Completion Timeout: Range BC, TimeoutDis+ ARIFwd-
                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
                 LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
                          Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
                          Compliance De-emphasis: -6dB
                 LnkSta2: Current De-emphasis Level: -3.5dB
         Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
                 Address: 00000000  Data: 0000
         Capabilities: [90] Subsystem: Giga-byte Technology Device 5001
         Capabilities: [a0] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
         Kernel driver in use: pcieport
         Kernel modules: shpchp

00:1c.4 PCI bridge: Intel Corporation Panther Point PCI Express Root Port 5 (rev c4) (prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0, Cache Line Size: 64 bytes
         Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
         I/O behind bridge: 0000e000-0000efff
         Memory behind bridge: f7c00000-f7cfffff
         Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
         BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
         Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
                 DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
                         ExtTag- RBE+ FLReset-
                 DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
                         RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                         MaxPayload 128 bytes, MaxReadReq 128 bytes
                 DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
                 LnkCap: Port #5, Speed 5GT/s, Width x1, ASPM unknown, Latency L0 <512ns, L1 <16us
                         ClockPM- Surprise- LLActRep+ BwNot-
                 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                 LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
                 SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
                         Slot #4, PowerLimit 10.000W; Interlock- NoCompl+
                 SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
                         Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
                 SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
                         Changed: MRL- PresDet- LinkState-
                 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
                 RootCap: CRSVisible-
                 RootSta: PME ReqID 0000, PMEStatus- PMEPending-
                 DevCap2: Completion Timeout: Range BC, TimeoutDis+ ARIFwd-
                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
                 LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
                          Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
                          Compliance De-emphasis: -6dB
                 LnkSta2: Current De-emphasis Level: -3.5dB
         Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
                 Address: 00000000  Data: 0000
         Capabilities: [90] Subsystem: Giga-byte Technology Device 5001
         Capabilities: [a0] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
         Kernel driver in use: pcieport
         Kernel modules: shpchp

00:1c.6 PCI bridge: Intel Corporation 82801 PCI Bridge (rev c4) (prog-if 01 [Subtractive decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0, Cache Line Size: 64 bytes
         Bus: primary=00, secondary=03, subordinate=04, sec-latency=0
         I/O behind bridge: 0000d000-0000dfff
         Memory behind bridge: fff00000-000fffff
         Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
         BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
         Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
                 DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
                         ExtTag- RBE+ FLReset-
                 DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
                         RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                         MaxPayload 128 bytes, MaxReadReq 128 bytes
                 DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
                 LnkCap: Port #7, Speed 5GT/s, Width x1, ASPM unknown, Latency L0 <1us, L1 <16us
                         ClockPM- Surprise- LLActRep+ BwNot-
                 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                 LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
                 SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
                         Slot #6, PowerLimit 10.000W; Interlock- NoCompl+
                 SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
                         Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
                 SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
                         Changed: MRL- PresDet- LinkState-
                 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
                 RootCap: CRSVisible-
                 RootSta: PME ReqID 0000, PMEStatus- PMEPending-
                 DevCap2: Completion Timeout: Range BC, TimeoutDis+ ARIFwd-
                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
                 LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-, Selectable De-emphasis: -6dB
                          Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
                          Compliance De-emphasis: -6dB
                 LnkSta2: Current De-emphasis Level: -3.5dB
         Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
                 Address: 00000000  Data: 0000
         Capabilities: [90] Subsystem: Giga-byte Technology Device 5001
         Capabilities: [a0] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-

00:1d.0 USB controller: Intel Corporation Panther Point USB Enhanced Host Controller #1 (rev 04) (prog-if 20 [EHCI])
         Subsystem: Giga-byte Technology Device 5006
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0
         Interrupt: pin A routed to IRQ 23
         Region 0: Memory at f7d13000 (32-bit, non-prefetchable) [size=1K]
         Capabilities: [50] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [58] Debug port: BAR=1 offset=00a0
         Capabilities: [98] PCI Advanced Features
                 AFCap: TP+ FLR+
                 AFCtrl: FLR-
                 AFStatus: TP-
         Kernel driver in use: ehci-pci

00:1f.0 ISA bridge: Intel Corporation Panther Point LPC Controller (rev 04)
         Subsystem: Giga-byte Technology Device 5001
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0
         Capabilities: [e0] Vendor Specific Information: Len=0c <?>
         Kernel driver in use: lpc_ich
         Kernel modules: lpc_ich

00:1f.2 SATA controller: Intel Corporation Panther Point 6 port SATA Controller [AHCI mode] (rev 04) (prog-if 01 [AHCI 1.0])
         Subsystem: Giga-byte Technology Device b005
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0
         Interrupt: pin B routed to IRQ 41
         Region 0: I/O ports at f0b0 [size=8]
         Region 1: I/O ports at f0a0 [size=4]
         Region 2: I/O ports at f090 [size=8]
         Region 3: I/O ports at f080 [size=4]
         Region 4: I/O ports at f060 [size=32]
         Region 5: Memory at f7d12000 (32-bit, non-prefetchable) [size=2K]
         Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
                 Address: fee0100c  Data: 4191
         Capabilities: [70] Power Management version 3
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
                 Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=00000004
         Capabilities: [b0] PCI Advanced Features
                 AFCap: TP+ FLR+
                 AFCtrl: FLR-
                 AFStatus: TP-
         Kernel driver in use: ahci
         Kernel modules: ahci

00:1f.3 SMBus: Intel Corporation Panther Point SMBus Controller (rev 04)
         Subsystem: Giga-byte Technology Device 5001
         Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
         Interrupt: pin C routed to IRQ 5
         Region 0: Memory at f7d11000 (64-bit, non-prefetchable) [size=256]
         Region 4: I/O ports at f040 [size=32]
         Kernel modules: i2c-i801

02:00.0 Ethernet controller: Atheros Communications Inc. AR8161 Gigabit Ethernet (rev 10)
         Subsystem: Giga-byte Technology Device e000
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0, Cache Line Size: 64 bytes
         Interrupt: pin A routed to IRQ 44
         Region 0: Memory at f7c00000 (64-bit, non-prefetchable) [size=256K]
         Region 2: I/O ports at e000 [size=128]
         Capabilities: [40] Power Management version 3
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [58] Express (v1) Endpoint, MSI 00
                 DevCap: MaxPayload 4096 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
                         ExtTag- AttnBtn+ AttnInd+ PwrInd+ RBE+ FLReset-
                 DevCtl: Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
                         RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                         MaxPayload 128 bytes, MaxReadReq 512 bytes
                 DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
                 LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 unlimited, L1 unlimited
                         ClockPM+ Surprise- LLActRep- BwNot-
                 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                 LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
         Capabilities: [c0] MSI: Enable+ Count=1/16 Maskable+ 64bit+
                 Address: 00000000fee0100c  Data: 41c1
                 Masking: 0000fffe  Pending: 00000000
         Capabilities: [d8] MSI-X: Enable- Count=16 Masked-
                 Vector table: BAR=0 offset=00002000
                 PBA: BAR=0 offset=00003000
         Capabilities: [100 v1] Advanced Error Reporting
                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                 UESvrt: DLP- SDES+ TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
                 AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
         Capabilities: [180 v1] Device Serial Number ff-9e-7b-b3-90-2b-34-ff
         Kernel driver in use: alx
         Kernel modules: alx

03:00.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev 41) (prog-if 01 [Subtractive decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0, Cache Line Size: 64 bytes
         Bus: primary=03, secondary=04, subordinate=04, sec-latency=32
         I/O behind bridge: 0000d000-0000dfff
         Memory behind bridge: fff00000-000fffff
         Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
         Secondary status: 66MHz+ FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
         BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                 PriDiscTmr- SecDiscTmr+ DiscTmrStat- DiscTmrSERREn-
         Capabilities: [90] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=55mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [a0] Subsystem: Giga-byte Technology Device 8892

04:00.0 Multimedia audio controller: Ensoniq 5880B [AudioPCI] (rev 02)
         Subsystem: Ensoniq Creative Sound Blaster AudioPCI128
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort+ <MAbort+ >SERR- <PERR- INTx-
         Latency: 32 (3000ns min, 32000ns max)
         Interrupt: pin A routed to IRQ 18
         Region 0: I/O ports at d000 [size=64]
         Capabilities: [dc] Power Management version 1
                 Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
         Kernel driver in use: snd_ens1371
         Kernel modules: snd-ens1371

[7.6.] SCSI information (from /proc/scsi/scsi)

Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: INTEL SSDSC2CT24 Rev: 335t
   Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi2 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: WDC WD3200AAKS-0 Rev: 12.0
   Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi3 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: WDC WD1600AAJS-0 Rev: 58.0
   Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi4 Channel: 00 Id: 00 Lun: 00
   Vendor: HL-DT-ST Model: BD-RE  WH12LS38  Rev: 1.00
   Type:   CD-ROM                           ANSI  SCSI revision: 05

[7.7.] Other information that might be relevant to the problem (please look in /proc and include all information that you think to be relevant):

1/     1367/  2277/  2515/  2775/  40/        cgroups        misc
10/    1399/  2278/  2533/  2777/  41/        cmdline        modules
1005/  1400/  2279/  2541/  2781/  42/        consoles       mounts@
1037/  1401/  2281/  2542/  2783/  43/        cpuinfo        mtrr
1038/  1403/  2285/  2547/  2787/  44/        crypto         net@
1039/  1427/  2287/  2550/  2789/  45/        devices        pagetypeinfo
1049/  1457/  2290/  2552/  2799/  465/       diskstats      partitions
1058/  1473/  23/    2563/  28/    469/       dma            sched_debug
1062/  15/    2343/  2566/  2867/  5/         dri/           schedstat
1065/  16/    2345/  2586/  2869/  56/        driver/        scsi/
1069/  1654/  24/    2588/  29/    607/       execdomains    self@
11/    1679/  2429/  26/    2946/  61/        fb             slabinfo
1104/  17/    2433/  2603/  3/     62/        filesystems    softirqs
1107/  1701/  2438/  2604/  30/    643/       fs/            stat
1121/  1741/  2444/  2608/  3009/  645/       interrupts     swaps
1122/  1747/  2449/  266/   3011/  673/       iomem          sys/
1141/  18/    2477/  267/   3015/  7/         ioports        sysrq-trigger
1145/  2/     2484/  268/   31/    8/         irq/           sysvipc/
1148/  20/    2489/  269/   32/    81/        kallsyms       timer_list
12/    2054/  2490/  27/    33/    812/       kcore          timer_stats
1216/  2087/  2494/  270/   34/    82/        key-users      tty/
1246/  21/    2496/  271/   35/    9/         kmsg           uptime
1251/  2160/  25/    274/   351/   912/       kpagecount     version
13/    22/    2501/  275/   352/   937/       kpageflags     vmallocinfo
1344/  2213/  2503/  2753/  353/   949/       latency_stats  vmstat
1350/  2216/  2505/  2760/  36/    acpi/      loadavg        zoneinfo
1358/  2217/  2507/  2762/  37/    asound/    locks
1361/  2245/  2509/  2769/  39/    buddyinfo  mdstat
1363/  2246/  2510/  2771/  4/     bus/       meminfo

[X.] Other notes, patches, fixes, workarounds:

I've tried 32-bit kernel versions 2.6, 3.2, 3.5, 3.8 and 3.11 and they all have
this problem.

I booted the 3.11 kernel with intel_pstate=disable to test the ondemand
governor. I didn't see the problem in 3.11 with intel_pstate enabled, with
either the powersave or the performance governor.

I've been using a workaround, which is to detect and correct for the overflow in
a modified version of the ondemand governor.  This is just a band-aid, not a
real fix, as it doesn't actually prevent the overflow, but this way I only have
to compile one small module.

Regards,
Jim Hochschild
