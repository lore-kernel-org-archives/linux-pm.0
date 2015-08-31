From: Stanislav Kukla <stanislavkukla@gmail.com>
Subject: PROBLEM: [Gigabyte GA-H61M-D2H rev. 1.0] Sometimes does not suspend
Date: Mon, 31 Aug 2015 22:33:55 +0200
Message-ID: <CAEnLmo3q4HAUt5mpCmuoEKeGMmWmshf-vsS_PtiMdcMuTsP6SA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f66.google.com ([209.85.215.66]:33148 "EHLO
	mail-la0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752617AbbHaUd5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 31 Aug 2015 16:33:57 -0400
Received: by labqg3 with SMTP id qg3so7853248lab.0
        for <linux-pm@vger.kernel.org>; Mon, 31 Aug 2015 13:33:55 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: yinghai@kernel.org, bhelgaas@google.com

[1.] One line summary of the problem: [Gigabyte GA-H61M-D2H rev. 1.0]
Sometimes does not suspend

[2.] Full description of the problem/report: I am able to
suspend/resume the PC 3 times and then fourth attempt to suspend will
freeze - display is powered down, HDD stops spinning, but PC fan and
power LED will stay on and the PC is frozen and hard reset is needed.
I was able to reproduce this several times. The problem is present in
the latest upstream kernel 4.2-rc8. As the problem was not present in
the older versions of the kernel, I did kernel bisecting and
identified the first bad commit. Before this commit, suspend/resume on
my PC worked properly. The bad commit:

928bea964827d7824b548c1f8e06eccbbc4d0d7d is the first bad commit
commit 928bea964827d7824b548c1f8e06eccbbc4d0d7d
Author: Yinghai Lu <yinghai@kernel.org>
Date: Mon Jul 22 14:37:17 2013 -0700

    PCI: Delay enabling bridges until they're needed

    We currently enable PCI bridges after scanning a bus and assigning
    resources. This is often done in arch code.

    This patch changes this so we don't enable a bridge until necessary, i.e.,
    until we enable a PCI device behind the bridge. We do this in the generic
    pci_enable_device() path, so this also removes the arch-specific code to
    enable bridges.

    [bhelgaas: changelog]
    Signed-off-by: Yinghai Lu <yinghai@kernel.org>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>



[3.] Keywords (i.e., modules, networking, kernel):

[4.] Kernel version (from /proc/version): Linux version
4.2.0-040200rc8-generic (kernel@gomeisa) (gcc version 4.8.4 (Ubuntu
4.8.4-2ubuntu1~14.04) ) #201508240030 SMP Mon Aug 24 04:31:40 UTC 2015

[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)

[6.] A small shell script or example program which triggers the
     problem (if possible)

[7.] Environment
Description:    Ubuntu 14.04.2 LTS
Release:    14.04

[7.1.] Software (add the output of the ver_linux script here)
Linux ygzo-desktop 4.2.0-040200rc8-generic #201508240030 SMP Mon Aug
24 04:31:40 UTC 2015 x86_64 x86_64 x86_64 GNU/Linux

Gnu C                  4.8
Gnu make               3.81
binutils               2.24
util-linux             2.20.1
mount                  support
module-init-tools      15
e2fsprogs              1.42.9
pcmciautils            018
PPP                    2.4.5
Linux C Library        2.19
Dynamic linker (ldd)   2.19
Procps                 3.3.9
Net-tools              1.60
Kbd                    1.15.5
Sh-utils               8.21
wireless-tools         30
Modules Loaded         rfcomm bnep bluetooth usblp intel_rapl iosf_mbi
x86_pkg_temp_thermal intel_powerclamp coretemp gpio_ich
snd_hda_codec_hdmi kvm_intel snd_hda_codec_realtek kvm
snd_hda_codec_generic input_leds snd_hda_intel i915 crct10dif_pclmul
crc32_pclmul snd_hda_codec snd_hda_core snd_hwdep ghash_clmulni_intel
snd_pcm snd_seq_midi snd_seq_midi_event serio_raw snd_rawmidi video
drm_kms_helper snd_seq snd_seq_device snd_timer cryptd drm snd
soundcore ppdev mei_me 8250_fintek i2c_algo_bit lp shpchp mei mac_hid
parport_pc lpc_ich parport hid_generic usbhid hid ahci libahci atl1c

[7.2.] Processor information (from /proc/cpuinfo):
processor    : 0
vendor_id    : GenuineIntel
cpu family    : 6
model        : 42
model name    : Intel(R) Pentium(R) CPU G630 @ 2.70GHz
stepping    : 7
microcode    : 0x25
cpu MHz        : 2396.671
cache size    : 3072 KB
physical id    : 0
siblings    : 2
core id        : 0
cpu cores    : 2
apicid        : 0
initial apicid    : 0
fpu        : yes
fpu_exception    : yes
cpuid level    : 13
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
syscall nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor
ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 popcnt
tsc_deadline_timer xsave lahf_lm arat epb pln pts dtherm tpr_shadow
vnmi flexpriority ept vpid xsaveopt
bugs        :
bogomips    : 5388.19
clflush size    : 64
cache_alignment    : 64
address sizes    : 36 bits physical, 48 bits virtual
power management:

processor    : 1
vendor_id    : GenuineIntel
cpu family    : 6
model        : 42
model name    : Intel(R) Pentium(R) CPU G630 @ 2.70GHz
stepping    : 7
microcode    : 0x25
cpu MHz        : 2634.820
cache size    : 3072 KB
physical id    : 0
siblings    : 2
core id        : 1
cpu cores    : 2
apicid        : 2
initial apicid    : 2
fpu        : yes
fpu_exception    : yes
cpuid level    : 13
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
syscall nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl
xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor
ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 popcnt
tsc_deadline_timer xsave lahf_lm arat epb pln pts dtherm tpr_shadow
vnmi flexpriority ept vpid xsaveopt
bugs        :
bogomips    : 5388.19
clflush size    : 64
cache_alignment    : 64
address sizes    : 36 bits physical, 48 bits virtual
power management:

[7.3.] Module information (from /proc/modules):
rfcomm 69632 0 - Live 0x0000000000000000
bnep 20480 2 - Live 0x0000000000000000
bluetooth 507904 10 rfcomm,bnep, Live 0x0000000000000000
usblp 20480 0 - Live 0x0000000000000000
intel_rapl 20480 0 - Live 0x0000000000000000
iosf_mbi 16384 1 intel_rapl, Live 0x0000000000000000
x86_pkg_temp_thermal 16384 0 - Live 0x0000000000000000
intel_powerclamp 16384 0 - Live 0x0000000000000000
coretemp 16384 0 - Live 0x0000000000000000
gpio_ich 16384 0 - Live 0x0000000000000000
snd_hda_codec_hdmi 49152 1 - Live 0x0000000000000000
kvm_intel 163840 0 - Live 0x0000000000000000
snd_hda_codec_realtek 86016 1 - Live 0x0000000000000000
kvm 503808 1 kvm_intel, Live 0x0000000000000000
snd_hda_codec_generic 73728 1 snd_hda_codec_realtek, Live 0x0000000000000000
input_leds 16384 0 - Live 0x0000000000000000
snd_hda_intel 36864 3 - Live 0x0000000000000000
i915 1114112 3 - Live 0x0000000000000000
crct10dif_pclmul 16384 0 - Live 0x0000000000000000
crc32_pclmul 16384 0 - Live 0x0000000000000000
snd_hda_codec 135168 4
snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,
Live 0x0000000000000000
snd_hda_core 65536 5
snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,snd_hda_codec,
Live 0x0000000000000000
snd_hwdep 16384 1 snd_hda_codec, Live 0x0000000000000000
ghash_clmulni_intel 16384 0 - Live 0x0000000000000000
snd_pcm 102400 4
snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec,snd_hda_core, Live
0x0000000000000000
snd_seq_midi 16384 0 - Live 0x0000000000000000
snd_seq_midi_event 16384 1 snd_seq_midi, Live 0x0000000000000000
serio_raw 16384 0 - Live 0x0000000000000000
snd_rawmidi 32768 1 snd_seq_midi, Live 0x0000000000000000
video 36864 1 i915, Live 0x0000000000000000
drm_kms_helper 126976 1 i915, Live 0x0000000000000000
snd_seq 69632 2 snd_seq_midi,snd_seq_midi_event, Live 0x0000000000000000
snd_seq_device 16384 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 0x0000000000000000
snd_timer 32768 2 snd_pcm,snd_seq, Live 0x0000000000000000
cryptd 20480 1 ghash_clmulni_intel, Live 0x0000000000000000
drm 356352 5 i915,drm_kms_helper, Live 0x0000000000000000
snd 81920 17 snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_rawmidi,snd_seq,snd_seq_device,snd_timer,
Live 0x0000000000000000
soundcore 16384 1 snd, Live 0x0000000000000000
ppdev 20480 0 - Live 0x0000000000000000
mei_me 24576 0 - Live 0x0000000000000000
8250_fintek 16384 0 - Live 0x0000000000000000
i2c_algo_bit 16384 1 i915, Live 0x0000000000000000
lp 20480 0 - Live 0x0000000000000000
shpchp 36864 0 - Live 0x0000000000000000
mei 90112 1 mei_me, Live 0x0000000000000000
mac_hid 16384 0 - Live 0x0000000000000000
parport_pc 32768 1 - Live 0x0000000000000000
lpc_ich 24576 0 - Live 0x0000000000000000
parport 49152 3 ppdev,lp,parport_pc, Live 0x0000000000000000
hid_generic 16384 0 - Live 0x0000000000000000
usbhid 49152 0 - Live 0x0000000000000000
hid 118784 2 hid_generic,usbhid, Live 0x0000000000000000
ahci 36864 2 - Live 0x0000000000000000
libahci 32768 1 ahci, Live 0x0000000000000000
atl1c 49152 0 - Live 0x0000000000000000

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
/proc/ioports:
0000-0cf7 : PCI Bus 0000:00
  0000-001f : dma1
  0020-0021 : pic1
  0040-0043 : timer0
  0050-0053 : timer1
  0060-0060 : keyboard
  0061-0061 : PNP0800:00
  0064-0064 : keyboard
  0070-0073 : rtc0
  0080-008f : dma page reg
  00a0-00a1 : pic2
  00c0-00df : dma2
  00f0-00ff : PNP0C04:00
    00f0-00ff : fpu
  0290-029f : pnp 00:00
    0290-0294 : pnp 00:00
  02f8-02ff : serial
  0378-037a : parport0
  03c0-03df : vesafb
  0400-0403 : ACPI PM1a_EVT_BLK
  0404-0405 : ACPI PM1a_CNT_BLK
  0408-040b : ACPI PM_TMR
  0410-0415 : ACPI CPU throttle
  0420-042f : ACPI GPE0_BLK
  0430-0433 : iTCO_wdt.0.auto
  0450-0450 : ACPI PM2_CNT_BLK
  0454-0457 : pnp 00:06
  0460-047f : iTCO_wdt.0.auto
  04d0-04d1 : pnp 00:00
  04d2-04ff : pnp 00:04
  0500-051f : 0000:00:1f.3
  0580-05ff : gpio_ich.1.auto
    0580-05af : gpio_ich
    05b0-05bf : gpio_ich
    05c0-05cf : gpio_ich
  0800-087f : pnp 00:00
  0880-088f : pnp 00:00
0cf8-0cff : PCI conf1
0d00-ffff : PCI Bus 0000:00
  1000-107f : pnp 00:05
  1080-10ff : pnp 00:05
  1100-117f : pnp 00:05
  1180-11ff : pnp 00:05
  2000-2fff : PCI Bus 0000:01
  e000-efff : PCI Bus 0000:04
    ef00-ef7f : 0000:04:00.0
      ef00-ef7f : atl1c
  fa00-fa1f : 0000:00:1f.2
    fa00-fa1f : ahci
  fb00-fb03 : 0000:00:1f.2
    fb00-fb03 : ahci
  fc00-fc07 : 0000:00:1f.2
    fc00-fc07 : ahci
  fd00-fd03 : 0000:00:1f.2
    fd00-fd03 : ahci
  fe00-fe07 : 0000:00:1f.2
    fe00-fe07 : ahci
  ff00-ff3f : 0000:00:02.0

/proc/iomem:
00000000-00000fff : reserved
00001000-0009dbff : System RAM
0009dc00-0009f7ff : RAM buffer
0009f800-0009ffff : reserved
000a0000-000bffff : PCI Bus 0000:00
000c0000-000dffff : PCI Bus 0000:00
  000c0000-000cdfff : Video ROM
  000d0800-000d3fff : pnp 00:08
000e0000-000effff : pnp 00:08
000f0000-000fffff : reserved
  000f0000-000fffff : System ROM
00100000-c0faffff : System RAM
  01000000-017adf5b : Kernel code
  017adf5c-01d34d3f : Kernel data
  01eaa000-01fecfff : Kernel bss
c0fb0000-c0fb2fff : ACPI Non-volatile Storage
c0fb3000-c0feffff : ACPI Tables
c0ff0000-c0ffffff : reserved
c1000000-c19fffff : RAM buffer
c1a00000-df9fffff : reserved
  c1a00000-df9fffff : Graphics Stolen Memory
dfa00000-febfffff : PCI Bus 0000:00
  dfa00000-dfbfffff : PCI Bus 0000:01
  dfc00000-dfdfffff : PCI Bus 0000:01
  e0000000-efffffff : 0000:00:02.0
  f4000000-f7ffffff : PCI MMCONFIG 0000 [bus 00-3f]
    f4000000-f7ffffff : reserved
      f4000000-f7ffffff : pnp 00:07
  fb800000-fbbfffff : 0000:00:02.0
  fbe00000-fbefffff : PCI Bus 0000:04
    fbec0000-fbefffff : 0000:04:00.0
      fbec0000-fbefffff : atl1c
  fbff4000-fbff7fff : 0000:00:1b.0
    fbff4000-fbff7fff : ICH HD audio
  fbffb000-fbffb0ff : 0000:00:1f.3
  fbffc000-fbffc7ff : 0000:00:1f.2
    fbffc000-fbffc7ff : ahci
  fbffd000-fbffd3ff : 0000:00:1d.0
    fbffd000-fbffd3ff : ehci_hcd
  fbffe000-fbffe3ff : 0000:00:1a.0
    fbffe000-fbffe3ff : ehci_hcd
  fbfff000-fbfff00f : 0000:00:16.0
    fbfff000-fbfff00f : mei_me
fec00000-ffffffff : reserved
  fec00000-fec003ff : IOAPIC 0
  fed00000-fed003ff : HPET 0
    fed00000-fed003ff : PNP0103:00
  fed10000-fed1dfff : pnp 00:08
  fed1f410-fed1f414 : iTCO_wdt.0.auto
  fed20000-fed8ffff : pnp 00:08
  fee00000-fee00fff : Local APIC
    fee00000-fee00fff : pnp 00:08
  ffb00000-ffb7ffff : pnp 00:08
  ffb80000-ffbfffff : INT0800:00
  fff00000-ffffffff : pnp 00:08
100000000-3ffffffff : System RAM
400000000-41fdfffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)
00:00.0 Host bridge: Intel Corporation 2nd Generation Core Processor
Family DRAM Controller (rev 09)
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ >SERR- <PERR- INTx-
    Latency: 0
    Capabilities: [e0] Vendor Specific Information: Len=0c <?>
    Kernel driver in use: snb_uncore

00:02.0 VGA compatible controller: Intel Corporation 2nd Generation
Core Processor Family Integrated Graphics Controller (rev 09) (prog-if
00 [VGA controller])
    Subsystem: Gigabyte Technology Co., Ltd Device d000
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin A routed to IRQ 26
    Region 0: Memory at fb800000 (64-bit, non-prefetchable) [size=4M]
    Region 2: Memory at e0000000 (64-bit, prefetchable) [size=256M]
    Region 4: I/O ports at ff00 [size=64]
    Expansion ROM at <unassigned> [disabled]
    Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
        Address: fee0300c  Data: 41c1
    Capabilities: [d0] Power Management version 2
        Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [a4] PCI Advanced Features
        AFCap: TP+ FLR+
        AFCtrl: FLR-
        AFStatus: TP-
    Kernel driver in use: i915

00:16.0 Communication controller: Intel Corporation 6 Series/C200
Series Chipset Family MEI Controller #1 (rev 04)
    Subsystem: Gigabyte Technology Co., Ltd Device 1c3a
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin A routed to IRQ 25
    Region 0: Memory at fbfff000 (64-bit, non-prefetchable) [size=16]
    Capabilities: [50] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [8c] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Address: 00000000fee0300c  Data: 41b1
    Kernel driver in use: mei_me

00:1a.0 USB controller: Intel Corporation 6 Series/C200 Series Chipset
Family USB Enhanced Host Controller #2 (rev 05) (prog-if 20 [EHCI])
    Subsystem: Gigabyte Technology Co., Ltd Device 5006
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin C routed to IRQ 18
    Region 0: Memory at fbffe000 (32-bit, non-prefetchable) [size=1K]
    Capabilities: [50] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [58] Debug port: BAR=1 offset=00a0
    Capabilities: [98] PCI Advanced Features
        AFCap: TP+ FLR+
        AFCtrl: FLR-
        AFStatus: TP-
    Kernel driver in use: ehci-pci

00:1b.0 Audio device: Intel Corporation 6 Series/C200 Series Chipset
Family High Definition Audio Controller (rev 05)
    Subsystem: Gigabyte Technology Co., Ltd Device a002
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 4 bytes
    Interrupt: pin A routed to IRQ 27
    Region 0: Memory at fbff4000 (64-bit, non-prefetchable) [size=16K]
    Capabilities: [50] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Address: 00000000fee0300c  Data: 41e1
    Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0
            ExtTag- RBE-
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
    Capabilities: [100 v1] Virtual Channel
        Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
        Arb:    Fixed- WRR32- WRR64- WRR128-
        Ctrl:    ArbSelect=Fixed
        Status:    InProgress-
        VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
            Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
            Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=01
            Status:    NegoPending- InProgress-
        VC1:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
            Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
            Ctrl:    Enable+ ID=1 ArbSelect=Fixed TC/VC=02
            Status:    NegoPending- InProgress-
    Capabilities: [130 v1] Root Complex Link
        Desc:    PortNumber=0f ComponentID=00 EltType=Config
        Link0:    Desc:    TargetPort=00 TargetComponent=00 AssocRCRB-
LinkType=MemMapped LinkValid+
            Addr:    00000000fed1c000
    Kernel driver in use: snd_hda_intel

00:1c.0 PCI bridge: Intel Corporation 6 Series/C200 Series Chipset
Family PCI Express Root Port 1 (rev b5) (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
    I/O behind bridge: 00002000-00002fff
    Memory behind bridge: dfa00000-dfbfffff
    Prefetchable memory behind bridge: 00000000dfc00000-00000000dfdfffff
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
    BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0
            ExtTag- RBE+
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
        LnkCap:    Port #1, Speed 5GT/s, Width x1, ASPM L0s, Exit
Latency L0s <1us, L1 <64us
            ClockPM- Surprise- LLActRep+ BwNot-
        LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- CommClk-
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+
DLActive- BWMgmt- ABWMgmt-
        SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
            Slot #16, PowerLimit 10.000W; Interlock- NoCompl+
        SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt-
HPIrq- LinkChg-
            Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
        SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
            Changed: MRL- PresDet- LinkState-
        RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
        RootCap: CRSVisible-
        RootSta: PME ReqID 0000, PMEStatus- PMEPending-
        DevCap2: Completion Timeout: Range BC, TimeoutDis+, LTR-, OBFF
Not Supported ARIFwd-
        DevCtl2: Completion Timeout: 260ms to 900ms, TimeoutDis-,
LTR-, OBFF Disabled ARIFwd-
        LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete-, EqualizationPhase1-
             EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
    Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
        Address: 00000000  Data: 0000
    Capabilities: [90] Subsystem: Gigabyte Technology Co., Ltd Device 5001
    Capabilities: [a0] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Kernel driver in use: pcieport

00:1c.1 PCI bridge: Intel Corporation 82801 PCI Bridge (rev b5)
(prog-if 01 [Subtractive decode])
    Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Bus: primary=00, secondary=02, subordinate=03, sec-latency=0
    I/O behind bridge: 0000f000-00000fff
    Memory behind bridge: fff00000-000fffff
    Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
    BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0
            ExtTag- RBE+
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
        LnkCap:    Port #2, Speed 5GT/s, Width x1, ASPM L0s L1, Exit
Latency L0s <1us, L1 <4us
            ClockPM- Surprise- LLActRep+ BwNot-
        LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- CommClk-
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
DLActive+ BWMgmt+ ABWMgmt-
        SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
            Slot #1, PowerLimit 10.000W; Interlock- NoCompl+
        SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt-
HPIrq- LinkChg-
            Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
        SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
            Changed: MRL- PresDet- LinkState+
        RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
        RootCap: CRSVisible-
        RootSta: PME ReqID 0000, PMEStatus- PMEPending-
        DevCap2: Completion Timeout: Range BC, TimeoutDis+, LTR-, OBFF
Not Supported ARIFwd-
        DevCtl2: Completion Timeout: 260ms to 900ms, TimeoutDis-,
LTR-, OBFF Disabled ARIFwd-
        LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete-, EqualizationPhase1-
             EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
    Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
        Address: 00000000  Data: 0000
    Capabilities: [90] Subsystem: Gigabyte Technology Co., Ltd Device 5001
    Capabilities: [a0] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-

00:1c.4 PCI bridge: Intel Corporation 6 Series/C200 Series Chipset
Family PCI Express Root Port 5 (rev b5) (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 4 bytes
    Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
    I/O behind bridge: 0000e000-0000efff
    Memory behind bridge: fbe00000-fbefffff
    Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
    BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0
            ExtTag- RBE+
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
        LnkCap:    Port #5, Speed 5GT/s, Width x1, ASPM L0s L1, Exit
Latency L0s <512ns, L1 <4us
            ClockPM- Surprise- LLActRep+ BwNot-
        LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- CommClk+
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
DLActive+ BWMgmt+ ABWMgmt-
        SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
            Slot #4, PowerLimit 10.000W; Interlock- NoCompl+
        SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt-
HPIrq- LinkChg-
            Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
        SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
            Changed: MRL- PresDet- LinkState+
        RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
        RootCap: CRSVisible-
        RootSta: PME ReqID 0000, PMEStatus- PMEPending-
        DevCap2: Completion Timeout: Range BC, TimeoutDis+, LTR-, OBFF
Not Supported ARIFwd-
        DevCtl2: Completion Timeout: 260ms to 900ms, TimeoutDis-,
LTR-, OBFF Disabled ARIFwd-
        LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete-, EqualizationPhase1-
             EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
    Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
        Address: 00000000  Data: 0000
    Capabilities: [90] Subsystem: Gigabyte Technology Co., Ltd Device 5001
    Capabilities: [a0] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Kernel driver in use: pcieport

00:1d.0 USB controller: Intel Corporation 6 Series/C200 Series Chipset
Family USB Enhanced Host Controller #1 (rev 05) (prog-if 20 [EHCI])
    Subsystem: Gigabyte Technology Co., Ltd Device 5006
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin A routed to IRQ 23
    Region 0: Memory at fbffd000 (32-bit, non-prefetchable) [size=1K]
    Capabilities: [50] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [58] Debug port: BAR=1 offset=00a0
    Capabilities: [98] PCI Advanced Features
        AFCap: TP+ FLR+
        AFCtrl: FLR-
        AFStatus: TP-
    Kernel driver in use: ehci-pci

00:1f.0 ISA bridge: Intel Corporation H61 Express Chipset Family LPC
Controller (rev 05)
    Subsystem: Gigabyte Technology Co., Ltd Device 5001
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Capabilities: [e0] Vendor Specific Information: Len=0c <?>
    Kernel driver in use: lpc_ich

00:1f.2 SATA controller: Intel Corporation 6 Series/C200 Series
Chipset Family SATA AHCI Controller (rev 05) (prog-if 01 [AHCI 1.0])
    Subsystem: Gigabyte Technology Co., Ltd Device b005
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0
    Interrupt: pin B routed to IRQ 24
    Region 0: I/O ports at fe00 [size=8]
    Region 1: I/O ports at fd00 [size=4]
    Region 2: I/O ports at fc00 [size=8]
    Region 3: I/O ports at fb00 [size=4]
    Region 4: I/O ports at fa00 [size=32]
    Region 5: Memory at fbffc000 (32-bit, non-prefetchable) [size=2K]
    Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
        Address: fee0200c  Data: 41a1
    Capabilities: [70] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot+,D3cold-)
        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=00000004
    Capabilities: [b0] PCI Advanced Features
        AFCap: TP+ FLR+
        AFCtrl: FLR-
        AFStatus: TP-
    Kernel driver in use: ahci

00:1f.3 SMBus: Intel Corporation 6 Series/C200 Series Chipset Family
SMBus Controller (rev 05)
    Subsystem: Gigabyte Technology Co., Ltd Device 5001
    Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Interrupt: pin C routed to IRQ 4
    Region 0: Memory at fbffb000 (64-bit, non-prefetchable) [size=256]
    Region 4: I/O ports at 0500 [size=32]

02:00.0 PCI bridge: Integrated Technology Express, Inc. Device 8892
(rev 30) (prog-if 01 [Subtractive decode])
    Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Bus: primary=02, secondary=03, subordinate=03, sec-latency=32
    I/O behind bridge: 0000f000-00000fff
    Memory behind bridge: fff00000-000fffff
    Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
    Secondary status: 66MHz+ FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
    BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr+ DiscTmrStat- DiscTmrSERREn-
    Capabilities: [90] Power Management version 2
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=55mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [a0] Subsystem: Gigabyte Technology Co., Ltd Device 5000

04:00.0 Ethernet controller: Qualcomm Atheros AR8151 v2.0 Gigabit
Ethernet (rev c0)
    Subsystem: Gigabyte Technology Co., Ltd Device e000
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 4 bytes
    Interrupt: pin A routed to IRQ 28
    Region 0: Memory at fbec0000 (64-bit, non-prefetchable) [size=256K]
    Region 2: I/O ports at ef00 [size=128]
    Capabilities: [40] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [48] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Address: 00000000fee0100c  Data: 4122
    Capabilities: [58] Express (v1) Endpoint, MSI 00
        DevCap:    MaxPayload 4096 bytes, PhantFunc 0, Latency L0s
unlimited, L1 unlimited
            ExtTag- AttnBtn+ AttnInd+ PwrInd+ RBE+ FLReset-
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 512 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
        LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit
Latency L0s unlimited, L1 unlimited
            ClockPM+ Surprise- LLActRep- BwNot-
        LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- CommClk+
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
DLActive- BWMgmt- ABWMgmt-
    Capabilities: [6c] Vital Product Data
pcilib: sysfs_read_vpd: read failed: Connection timed out
        Not readable
    Capabilities: [100 v1] Advanced Error Reporting
        UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
        UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UESvrt:    DLP- SDES+ TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
        CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
        CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
        AERCap:    First Error Pointer: 14, GenCap+ CGenEn- ChkCap+ ChkEn-
    Capabilities: [180 v1] Device Serial Number ff-d0-2a-5a-50-e5-49-ff
    Kernel driver in use: atl1c

[7.6.] SCSI information (from /proc/scsi/scsi)
Attached devices:
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: Hitachi HDP72504 Rev: A52A
  Type:   Direct-Access                    ANSI  SCSI revision: 05

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
1     1273  137   1646  1789  19    2062  2190  2276  25    27    2905
 3304  407  648  766  902        consoles     interrupts  loadavg
 sched_debug    thread-self
10    128   138   1657  1797  1913  2064  22    23    2508  2773  2929
 3306  41   663  769  923        cpuinfo      iomem       locks
 schedstat      timer_list
1001  129   14    1665  1799  1968  2071  2209  24    2525  278   2977
 3321  482  676  79   926        crypto       ioports     mdstat
 scsi           timer_stats
11    13    1415  1695  18    2     2073  2213  2436  2532  2795  3
 337   5    680  8    978        devices      irq         meminfo
 self           tty
1151  130   1490  17    1802  20    2076  2216  2443  2542  28    30
 34    52   697  80   984        diskstats    kallsyms    misc
 slabinfo       uptime
1163  131   15    1711  1804  2026  21    2219  2456  2552  2832  3061
 354   53   7    814  acpi       dma          kcore       modules
 softirqs       version
1166  132   154   1716  1812  2044  2101  2231  2457  2577  2841  31
 36    59   723  823  asound     driver       keys        mounts
 stat           vmallocinfo
1198  133   155   1763  1838  2048  2102  2236  2466  2578  285   3118
 37    60   753  827  buddyinfo  execdomains  key-users   mtrr
 swaps          vmstat
12    134   156   1767  1847  2053  2181  2241  2480  26    29    32
 39    600  754  830  bus        fb           kmsg        net
 sys            zoneinfo
1248  135   1562  1776  1870  2055  2184  2250  2482  2641  2903  3294
 4     604  758  837  cgroups    filesystems  kpagecount  pagetypeinfo
 sysrq-trigger
127   136   1564  1787  1879  2059  2185  2272  2494  2664  2904  33
 40    618  765  9    cmdline    fs           kpageflags  partitions
 sysvipc

[X.] Other notes, patches, fixes, workarounds:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1412873
