From: Vincenzo Costa <vincenzocosta16@gmail.com>
Subject: [Asus Eee PC 1215B] Resume doesn't work after suspend
Date: Fri, 16 Nov 2012 21:48:44 +0100
Message-ID: <CAGep=pfudZgx+_0hRvtnD+m=SpV1iBxftUeAE2Vru9a_kSPEGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:52485 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751459Ab2KPUsp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 16 Nov 2012 15:48:45 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so2181124pbc.19
        for <linux-pm@vger.kernel.org>; Fri, 16 Nov 2012 12:48:44 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: 1076103@bugs.launchpad.net

[1.] [Asus Eee PC 1215B] Resume doesn't work after suspend

[2.]
Description:
I had this bug with kubuntu 11.10 and it is still present after
upgrade to 12.04. I have an Asus 1215b laptop with Amd C60 cpu.

If I try to suspend the laptop, suspend seems to work at first, but then:
1) most of the times, the attempt to resume it brings to a black
screen as a result.
2) After that, it is necessary to switch off the laptop by keeping the
power button pressed.
3) Trying to switch on the laptop again produces a black screen and no
boot, unless I first remove the power cord and the battery, and try
again after putting them back in place.
4) Sometimes the first suspend attempt works correctly, but then,
after a succesful resume, the second attempt reproduces the bug again.

I tried the followings to see if it could help:
1) Changed from radeon driver to ATI proprietary fglrx driver, same result.
2) Installed the kernel 3.5.7 from
http://kernel.ubuntu.com/~kernel-ppa/mainline, but I had problems with
the fglrx ATI driver, and the first suspend and resume attempt
immediatelly reproduced the bug

The bug has been present with all the kernel versions used with
kubuntu 11.10 to current kernel version in Kubuntu 12.0.4.1:
uname -r: 3.2.0-32-generic

Last, the bug is present also with upstream kernel:
uname -r:
3.7.0-030700rc5-generic

Link to launchpad report:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1076103


[3.] kernel


[4.] Linux version 3.7.0-030700rc5-generic (apw@gomeisa) (gcc version
4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201211110835 SMP Sun Nov 11
13:35:49 UTC 2012

[5.]

[6.]

[7.] Description:    Ubuntu 12.04.1 LTS
Release:        12.04

[7.1] Linux teresapc 3.7.0-030700rc5-generic #201211110835 SMP Sun Nov
11 13:35:49 UTC 2012 x86_64 x86_64 x86_64 GNU/Linux

Gnu C                  4.6
Gnu make               3.81
binutils               2.22
util-linux             2.20.1
mount                  support
module-init-tools      3.16
e2fsprogs              1.42
pcmciautils            018
Linux C Library        2.15
Dynamic linker (ldd)   2.15
Procps                 3.2.8
Net-tools              1.60
Kbd                    1.15.2
Sh-utils               8.13
wireless-tools         30
Modules Loaded         rfcomm bnep parport_pc bluetooth ppdev
binfmt_misc dm_crypt joydev kvm_amd kvm eeepc_wmi asus_wmi
snd_hda_codec_realtek sparse_keymap snd_hda_codec_hdmi snd_seq_midi
snd_hda_intel snd_hda_codec uvcvideo arc4 snd_rawmidi
snd_seq_midi_event videobuf2_core snd_hwdep videodev ath9k snd_pcm
sp5100_tco snd_seq psmouse microcode videobuf2_vmalloc i2c_piix4
videobuf2_memops k10temp serio_raw mac80211 snd_timer snd_seq_device
ath9k_common ath9k_hw ath snd cfg80211 mac_hid soundcore msr
snd_page_alloc lp parport radeon ttm drm_kms_helper drm atl1c
i2c_algo_bit wmi video


[7.2.] processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 20
model           : 2
model name      : AMD C-60 APU with Radeon(tm) HD Graphics
stepping        : 0
microcode       : 0x5000101
cpu MHz         : 800.000
cache size      : 512 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 2
apicid          : 0
initial apicid  : 0
fpu             : yes
fpu_exception   : yes
cpuid level     : 6
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext
fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc
extd_apicid aperfmperf pni monitor ssse3 cx16 popcnt lahf_lm
cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch
ibs skinit wdt arat cpb hw_pstate npt lbrv svm_lock nrip_save
pausefilter
bogomips        : 1995.87
TLB size        : 1024 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 36 bits physical, 48 bits virtual
power management: ts ttp tm stc 100mhzsteps hwpstate cpb

processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 20
model           : 2
model name      : AMD C-60 APU with Radeon(tm) HD Graphics
stepping        : 0
microcode       : 0x5000101
cpu MHz         : 800.000
cache size      : 512 KB
physical id     : 0
siblings        : 2
core id         : 1
cpu cores       : 2
apicid          : 1
initial apicid  : 1
fpu             : yes
fpu_exception   : yes
cpuid level     : 6
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext
fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc
extd_apicid aperfmperf pni monitor ssse3 cx16 popcnt lahf_lm
cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch
ibs skinit wdt arat cpb hw_pstate npt lbrv svm_lock nrip_save
pausefilter
bogomips        : 1995.87
TLB size        : 1024 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 36 bits physical, 48 bits virtual
power management: ts ttp tm stc 100mhzsteps hwpstate cpb

[7.3] rfcomm 47923 0 - Live 0x0000000000000000
bnep 18400 2 - Live 0x0000000000000000
parport_pc 32867 0 - Live 0x0000000000000000
bluetooth 219394 10 rfcomm,bnep, Live 0x0000000000000000
ppdev 17114 0 - Live 0x0000000000000000
binfmt_misc 17541 1 - Live 0x0000000000000000
dm_crypt 23073 0 - Live 0x0000000000000000
joydev 17614 0 - Live 0x0000000000000000
kvm_amd 60195 0 - Live 0x0000000000000000
kvm 441559 1 kvm_amd, Live 0x0000000000000000
eeepc_wmi 13152 0 - Live 0x0000000000000000
asus_wmi 24582 1 eeepc_wmi, Live 0x0000000000000000
snd_hda_codec_realtek 79808 1 - Live 0x0000000000000000
sparse_keymap 13891 1 asus_wmi, Live 0x0000000000000000
snd_hda_codec_hdmi 37116 1 - Live 0x0000000000000000
snd_seq_midi 13325 0 - Live 0x0000000000000000
snd_hda_intel 38522 5 - Live 0x0000000000000000
snd_hda_codec 140413 3
snd_hda_codec_realtek,snd_hda_codec_hdmi,snd_hda_intel, Live
0x0000000000000000
uvcvideo 82215 0 - Live 0x0000000000000000
arc4 12574 2 - Live 0x0000000000000000
snd_rawmidi 30750 1 snd_seq_midi, Live 0x0000000000000000
snd_seq_midi_event 14900 1 snd_seq_midi, Live 0x0000000000000000
videobuf2_core 36138 1 uvcvideo, Live 0x0000000000000000
snd_hwdep 17765 1 snd_hda_codec, Live 0x0000000000000000
videodev 130085 2 uvcvideo,videobuf2_core, Live 0x0000000000000000
ath9k 147526 0 - Live 0x0000000000000000
snd_pcm 102478 3 snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec, Live
0x0000000000000000
sp5100_tco 13792 0 - Live 0x0000000000000000
snd_seq 61931 2 snd_seq_midi,snd_seq_midi_event, Live 0x0000000000000000
psmouse 92405 0 - Live 0x0000000000000000
microcode 23076 0 - Live 0x0000000000000000
videobuf2_vmalloc 12861 1 uvcvideo, Live 0x0000000000000000
i2c_piix4 13505 0 - Live 0x0000000000000000
videobuf2_memops 13405 1 videobuf2_vmalloc, Live 0x0000000000000000
k10temp 13174 0 - Live 0x0000000000000000
serio_raw 13216 0 - Live 0x0000000000000000
mac80211 573599 1 ath9k, Live 0x0000000000000000
snd_timer 29990 2 snd_pcm,snd_seq, Live 0x0000000000000000
snd_seq_device 14498 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 0x0000000000000000
ath9k_common 14054 1 ath9k, Live 0x0000000000000000
ath9k_hw 417643 2 ath9k,ath9k_common, Live 0x0000000000000000
ath 24124 3 ath9k,ath9k_common,ath9k_hw, Live 0x0000000000000000
snd 83674 20 snd_hda_codec_realtek,snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec,snd_rawmidi,snd_hwdep,snd_pcm,snd_seq,snd_timer,snd_seq_device,
Live 0x0000000000000000
cfg80211 217913 3 ath9k,mac80211,ath, Live 0x0000000000000000
mac_hid 13254 0 - Live 0x0000000000000000
soundcore 15092 1 snd, Live 0x0000000000000000
msr 12909 0 - Live 0x0000000000000000
snd_page_alloc 18799 2 snd_hda_intel,snd_pcm, Live 0x0000000000000000
lp 17800 0 - Live 0x0000000000000000
parport 46563 3 parport_pc,ppdev,lp, Live 0x0000000000000000
radeon 921927 0 - Live 0x0000000000000000
ttm 88493 1 radeon, Live 0x0000000000000000
drm_kms_helper 46934 1 radeon, Live 0x0000000000000000
drm 286536 3 radeon,ttm,drm_kms_helper, Live 0x0000000000000000
atl1c 46188 0 - Live 0x0000000000000000
i2c_algo_bit 13565 1 radeon, Live 0x0000000000000000
wmi 19257 1 asus_wmi, Live 0x0000000000000000
video 19413 1 asus_wmi, Live 0x0000000000000000

[7.4] cat /proc/ioports
0000-0cf7 : PCI Bus 0000:00
  0000-001f : dma1
  0020-0021 : pic1
  0040-0043 : timer0
  0050-0053 : timer1
  0060-0060 : keyboard
  0062-0062 : EC data
  0064-0064 : keyboard
  0066-0066 : EC cmd
  0070-0071 : rtc0
  0080-008f : dma page reg
  00a0-00a1 : pic2
  00c0-00df : dma2
  00f0-00ff : fpu
  03c0-03df : vga+
  040b-040b : pnp 00:02
    040b-040b : pnp 00:08
  04d0-04d1 : pnp 00:08
  04d6-04d6 : pnp 00:02
    04d6-04d6 : pnp 00:08
  0800-089f : pnp 00:02
    0800-089f : pnp 00:08
      0800-0803 : ACPI PM1a_EVT_BLK
      0804-0805 : ACPI PM1a_CNT_BLK
      0808-080b : ACPI PM_TMR
      0810-0815 : ACPI CPU throttle
      0820-0827 : ACPI GPE0_BLK
  0900-090f : pnp 00:02
    0900-090f : pnp 00:08
  0910-091f : pnp 00:02
    0910-091f : pnp 00:08
  0b00-0b0f : pnp 00:08
  0b20-0b3f : pnp 00:02
    0b20-0b3f : pnp 00:08
  0c00-0c01 : pnp 00:02
    0c00-0c01 : pnp 00:08
  0c14-0c14 : pnp 00:02
    0c14-0c14 : pnp 00:08
  0c50-0c51 : pnp 00:02
    0c50-0c51 : pnp 00:08
  0c52-0c52 : pnp 00:02
    0c52-0c52 : pnp 00:08
  0c6c-0c6c : pnp 00:02
    0c6c-0c6c : pnp 00:08
  0c6f-0c6f : pnp 00:02
    0c6f-0c6f : pnp 00:08
  0cd0-0cd1 : pnp 00:02
    0cd0-0cd1 : pnp 00:08
  0cd2-0cd3 : pnp 00:02
    0cd2-0cd3 : pnp 00:08
  0cd4-0cd5 : pnp 00:02
    0cd4-0cd5 : pnp 00:08
  0cd6-0cd7 : pnp 00:02
    0cd6-0cd7 : pnp 00:08
  0cd8-0cdf : pnp 00:02
    0cd8-0cdf : pnp 00:08
0cf8-0cff : PCI conf1
0d00-ffff : PCI Bus 0000:00
  d000-dfff : PCI Bus 0000:04
  e000-efff : PCI Bus 0000:02
    e000-e07f : 0000:02:00.0
      e000-e07f : atl1c
  f000-f0ff : 0000:00:01.0
  f100-f10f : 0000:00:11.0
    f100-f10f : ahci
  f110-f113 : 0000:00:11.0
    f110-f113 : ahci
  f120-f127 : 0000:00:11.0
    f120-f127 : ahci
  f130-f133 : 0000:00:11.0
    f130-f133 : ahci
  f140-f147 : 0000:00:11.0
    f140-f147 : ahci
  fe00-fefe : pnp 00:02
    fe00-fefe : pnp 00:08

cat /proc/iomem
00000000-0000ffff : reserved
00010000-0009ebff : System RAM
0009ec00-0009ffff : reserved
000a0000-000bffff : PCI Bus 0000:00
000c0000-000ce3ff : Video ROM
000e0000-000fffff : reserved
  000f0000-000fffff : System ROM
00100000-66c63fff : System RAM
  01000000-016d7380 : Kernel code
  016d7381-01ce6abf : Kernel data
  01de7000-01f46fff : Kernel bss
66c64000-66cb4fff : ACPI Non-volatile Storage
66cb5000-66cd5fff : reserved
66cd6000-66ce6fff : ACPI Non-volatile Storage
66ce7000-66d0afff : reserved
66d0b000-66d0bfff : System RAM
66d0c000-66d0cfff : ACPI Non-volatile Storage
66d0d000-66d10fff : System RAM
66d11000-66d15fff : ACPI Non-volatile Storage
66d16000-66d1cfff : reserved
66d1d000-66d23fff : ACPI Non-volatile Storage
66d24000-66d4afff : reserved
66d4b000-66d8dfff : ACPI Non-volatile Storage
66d8e000-66efffff : System RAM
66f00000-67ffffff : RAM buffer
7f000000-ffffffff : PCI Bus 0000:00
  c0000000-cfffffff : 0000:00:01.0
  d0000000-dfffffff : PCI Bus 0000:04
  e0000000-efffffff : PCI MMCONFIG 0000 [bus 00-ff]
    e0000000-efffffff : reserved
      e0000000-efffffff : pnp 00:01
  fdf00000-fe8fffff : PCI Bus 0000:04
  fe900000-fe9fffff : PCI Bus 0000:02
    fe900000-fe93ffff : 0000:02:00.0
      fe900000-fe93ffff : atl1c
  fea00000-feafffff : PCI Bus 0000:01
    fea00000-fea0ffff : 0000:01:00.0
      fea00000-fea0ffff : ath9k
  feb00000-feb3ffff : 0000:00:01.0
  feb40000-feb43fff : 0000:00:14.2
    feb40000-feb43fff : ICH HD audio
  feb44000-feb47fff : 0000:00:01.1
    feb44000-feb47fff : ICH HD audio
  feb48000-feb480ff : 0000:00:13.2
    feb48000-feb480ff : ehci_hcd
  feb49000-feb49fff : 0000:00:13.0
    feb49000-feb49fff : ohci_hcd
  feb4a000-feb4a0ff : 0000:00:12.2
    feb4a000-feb4a0ff : ehci_hcd
  feb4b000-feb4bfff : 0000:00:12.0
    feb4b000-feb4bfff : ohci_hcd
  feb4c000-feb4c3ff : 0000:00:11.0
    feb4c000-feb4c3ff : ahci
  fec00000-fec00fff : reserved
    fec00000-fec003ff : IOAPIC 0
  fec10000-fec10fff : reserved
    fec10000-fec10fff : pnp 00:02
      fec10000-fec1001f : pnp 00:08
  fed00000-fed00fff : reserved
    fed00000-fed00fff : pnp 00:02
      fed00000-fed003ff : HPET 0
  fed40000-fed44fff : pnp 00:08
  fed61000-fed70fff : reserved
    fed61000-fed70fff : pnp 00:02
  fed80000-fed8ffff : reserved
    fed80000-fed8ffff : pnp 00:02
      fed80000-fed80fff : pnp 00:08
  fee00000-fee00fff : Local APIC
    fee00000-fee00fff : pnp 00:02
  fef00000-ffffffff : reserved
    ffb80000-ffbfffff : pnp 00:08
    ffe00000-ffffffff : pnp 00:02

[7.5] lspci -vvv
00:00.0 Host bridge: Advanced Micro Devices [AMD] Family 14h Processor
Root Complex
        Subsystem: Advanced Micro Devices [AMD] Family 14h Processor
Root Complex
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 32

00:01.0 VGA compatible controller: Advanced Micro Devices [AMD] nee
ATI Wrestler [Radeon HD 6290] (prog-if 00 [VGA controller])
        Subsystem: ASUSTeK Computer Inc. Device 84e4
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 18
        Region 0: Memory at c0000000 (32-bit, prefetchable) [size=256M]
        Region 1: I/O ports at f000 [size=256]
        Region 2: Memory at feb00000 (32-bit, non-prefetchable) [size=256K]
        Expansion ROM at <unassigned> [disabled]
        Capabilities: [50] Power Management version 3
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] Express (v2) Root Complex Integrated Endpoint, MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s
<4us, L1 unlimited
                        ExtTag+ RBE+ FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq-
AuxPwr- TransPend-
                LnkCap: Port #0, Speed unknown, Width x0, ASPM
unknown, Latency L0 <64ns, L1 <1us
                        ClockPM- Surprise- LLActRep- BwNot-
                LnkCtl: ASPM Disabled; Disabled- Retrain- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed unknown, Width x0, TrErr- Train-
SlotClk- DLActive- BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Not Supported, TimeoutDis-
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
                LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance-
SpeedDis-, Selectable De-emphasis: -6dB
                         Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -6dB
        Capabilities: [a0] MSI: Enable- Count=1/1 Maskable- 64bit+
                Address: 0000000000000000  Data: 0000
        Capabilities: [100 v1] Vendor Specific Information: ID=0001
Rev=1 Len=010 <?>
        Kernel modules: radeon

00:01.1 Audio device: Advanced Micro Devices [AMD] nee ATI Wrestler
HDMI Audio [Radeon HD 6250/6310]
        Subsystem: ASUSTeK Computer Inc. Device 84e4
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin B routed to IRQ 40
        Region 0: Memory at feb44000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 3
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] Express (v2) Root Complex Integrated Endpoint, MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s
<4us, L1 unlimited
                        ExtTag+ RBE+ FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq-
AuxPwr- TransPend-
                LnkCap: Port #0, Speed unknown, Width x0, ASPM
unknown, Latency L0 <64ns, L1 <1us
                        ClockPM- Surprise- LLActRep- BwNot-
                LnkCtl: ASPM Disabled; Disabled- Retrain- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed unknown, Width x0, TrErr- Train-
SlotClk- DLActive- BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Not Supported, TimeoutDis-
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
                LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance-
SpeedDis-, Selectable De-emphasis: -6dB
                         Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -6dB
        Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
                Address: 00000000fee0200c  Data: 4181
        Capabilities: [100 v1] Vendor Specific Information: ID=0001
Rev=1 Len=010 <?>
        Kernel driver in use: snd_hda_intel
        Kernel modules: snd-hda-intel

00:04.0 PCI bridge: Advanced Micro Devices [AMD] Family 14h Processor
Root Port (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fea00000-feafffff
        Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [50] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] Express (v2) Root Port (Slot+), MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s
<64ns, L1 <1us
                        ExtTag+ RBE+ FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq-
AuxPwr- TransPend-
                LnkCap: Port #1, Speed 2.5GT/s, Width x1, ASPM L0s L1,
Latency L0 <64ns, L1 <1us
                        ClockPM- Surprise- LLActRep+ BwNot+
                LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled-
Retrain- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train-
SlotClk+ DLActive+ BWMgmt- ABWMgmt-
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd-
HotPlug- Surprise-
                        Slot #4, PowerLimit 75.000W; Interlock- NoCompl+
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet-
CmdCplt- HPIrq- LinkChg-
                        Control: AttnInd Unknown, PwrInd Unknown,
Power- Interlock-
                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt-
PresDet+ Interlock-
                        Changed: MRL- PresDet+ LinkState+
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal-
PMEIntEna- CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
                DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ ARIFwd-
                DevCtl2: Completion Timeout: 65ms to 210ms, TimeoutDis- ARIFwd-
                LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance-
SpeedDis+, Selectable De-emphasis: -6dB
                         Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -6dB
        Capabilities: [a0] MSI: Enable- Count=1/1 Maskable- 64bit+
                Address: 0000000000000000  Data: 0000
        Capabilities: [b0] Subsystem: Advanced Micro Devices [AMD] Device 1234
        Capabilities: [b8] HyperTransport: MSI Mapping Enable+ Fixed+
        Capabilities: [100 v1] Vendor Specific Information: ID=0001
Rev=1 Len=010 <?>
        Kernel driver in use: pcieport
        Kernel modules: shpchp

00:05.0 PCI bridge: Advanced Micro Devices [AMD] Family 14h Processor
Root Port (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
        I/O behind bridge: 0000e000-0000efff
        Memory behind bridge: fe900000-fe9fffff
        Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [50] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] Express (v2) Root Port (Slot+), MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s
<64ns, L1 <1us
                        ExtTag+ RBE+ FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq-
AuxPwr- TransPend-
                LnkCap: Port #2, Speed 2.5GT/s, Width x1, ASPM L0s L1,
Latency L0 <64ns, L1 <1us
                        ClockPM- Surprise- LLActRep+ BwNot+
                LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes Disabled-
Retrain- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train-
SlotClk+ DLActive+ BWMgmt- ABWMgmt-
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd-
HotPlug- Surprise-
                        Slot #5, PowerLimit 75.000W; Interlock- NoCompl+
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet-
CmdCplt- HPIrq- LinkChg-
                        Control: AttnInd Unknown, PwrInd Unknown,
Power- Interlock-
                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt-
PresDet+ Interlock-
                        Changed: MRL- PresDet+ LinkState+
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal-
PMEIntEna- CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
                DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ ARIFwd-
                DevCtl2: Completion Timeout: 65ms to 210ms, TimeoutDis- ARIFwd-
                LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance-
SpeedDis+, Selectable De-emphasis: -6dB
                         Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -6dB
        Capabilities: [a0] MSI: Enable- Count=1/1 Maskable- 64bit+
                Address: 0000000000000000  Data: 0000
        Capabilities: [b0] Subsystem: Advanced Micro Devices [AMD] Device 1234
        Capabilities: [b8] HyperTransport: MSI Mapping Enable+ Fixed+
        Capabilities: [100 v1] Vendor Specific Information: ID=0001
Rev=1 Len=010 <?>
        Kernel driver in use: pcieport
        Kernel modules: shpchp

00:11.0 SATA controller: Advanced Micro Devices [AMD] nee ATI
SB7x0/SB8x0/SB9x0 SATA Controller [AHCI mode] (prog-if 01 [AHCI 1.0])
        Subsystem: Advanced Micro Devices [AMD] nee ATI Device 4390
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 32
        Interrupt: pin A routed to IRQ 19
        Region 0: I/O ports at f140 [size=8]
        Region 1: I/O ports at f130 [size=4]
        Region 2: I/O ports at f120 [size=8]
        Region 3: I/O ports at f110 [size=4]
        Region 4: I/O ports at f100 [size=16]
        Region 5: Memory at feb4c000 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [70] SATA HBA v1.0 InCfgSpace
        Capabilities: [a4] PCI Advanced Features
                AFCap: TP+ FLR+
                AFCtrl: FLR-
                AFStatus: TP-
        Kernel driver in use: ahci

00:12.0 USB controller: Advanced Micro Devices [AMD] nee ATI
SB7x0/SB8x0/SB9x0 USB OHCI0 Controller (prog-if 10 [OHCI])
        Subsystem: Advanced Micro Devices [AMD] nee ATI
SB7x0/SB8x0/SB9x0 USB OHCI0 Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 32, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 18
        Region 0: Memory at feb4b000 (32-bit, non-prefetchable) [size=4K]
        Kernel driver in use: ohci_hcd

00:12.2 USB controller: Advanced Micro Devices [AMD] nee ATI
SB7x0/SB8x0/SB9x0 USB EHCI Controller (prog-if 20 [EHCI])
        Subsystem: Advanced Micro Devices [AMD] nee ATI
SB7x0/SB8x0/SB9x0 USB EHCI Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 32, Cache Line Size: 64 bytes
        Interrupt: pin B routed to IRQ 17
        Region 0: Memory at feb4a000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
                Bridge: PM- B3+
        Capabilities: [e4] Debug port: BAR=1 offset=00e0
        Kernel driver in use: ehci_hcd

00:13.0 USB controller: Advanced Micro Devices [AMD] nee ATI
SB7x0/SB8x0/SB9x0 USB OHCI0 Controller (prog-if 10 [OHCI])
        Subsystem: Advanced Micro Devices [AMD] nee ATI
SB7x0/SB8x0/SB9x0 USB OHCI0 Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 32, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 18
        Region 0: Memory at feb49000 (32-bit, non-prefetchable) [size=4K]
        Kernel driver in use: ohci_hcd

00:13.2 USB controller: Advanced Micro Devices [AMD] nee ATI
SB7x0/SB8x0/SB9x0 USB EHCI Controller (prog-if 20 [EHCI])
        Subsystem: Advanced Micro Devices [AMD] nee ATI
SB7x0/SB8x0/SB9x0 USB EHCI Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 32, Cache Line Size: 64 bytes
        Interrupt: pin B routed to IRQ 17
        Region 0: Memory at feb48000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
                Bridge: PM- B3+
        Capabilities: [e4] Debug port: BAR=1 offset=00e0
        Kernel driver in use: ehci_hcd

00:14.0 SMBus: Advanced Micro Devices [AMD] nee ATI SBx00 SMBus
Controller (rev 42)
        Subsystem: Advanced Micro Devices [AMD] nee ATI SBx00 SMBus Controller
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Kernel modules: sp5100_tco, i2c-piix4

00:14.2 Audio device: Advanced Micro Devices [AMD] nee ATI SBx00
Azalia (Intel HDA) (rev 40)
        Subsystem: ASUSTeK Computer Inc. Device 841c
        Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 32, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at feb40000 (64-bit, non-prefetchable)
[disabled] [size=16K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D3 NoSoftRst- PME-Enable+ DSel=0 DScale=0 PME-
        Kernel driver in use: snd_hda_intel
        Kernel modules: snd-hda-intel

00:14.3 ISA bridge: Advanced Micro Devices [AMD] nee ATI
SB7x0/SB8x0/SB9x0 LPC host controller (rev 40)
        Subsystem: Advanced Micro Devices [AMD] nee ATI
SB7x0/SB8x0/SB9x0 LPC host controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0

00:14.4 PCI bridge: Advanced Micro Devices [AMD] nee ATI SBx00 PCI to
PCI Bridge (rev 40) (prog-if 01 [Subtractive decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop+
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 64
        Bus: primary=00, secondary=03, subordinate=03, sec-latency=64
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fff00000-000fffff
        Prefetchable memory behind bridge: fff00000-000fffff
        Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-

00:15.0 PCI bridge: Advanced Micro Devices [AMD] nee ATI
SB700/SB800/SB900 PCI to PCI bridge (PCIE port 0) (prog-if 00 [Normal
decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Bus: primary=00, secondary=04, subordinate=06, sec-latency=0
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: fdf00000-fe8fffff
        Prefetchable memory behind bridge: 00000000d0000000-00000000dfffffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [50] Power Management version 3
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] Express (v2) Root Port (Slot+), MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s
<64ns, L1 <1us
                        ExtTag+ RBE+ FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq-
AuxPwr- TransPend-
                LnkCap: Port #247, Speed 2.5GT/s, Width x1, ASPM L0s
L1, Latency L0 <64ns, L1 <1us
                        ClockPM- Surprise- LLActRep+ BwNot+
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed unknown, Width x16, TrErr- Train-
SlotClk+ DLActive- BWMgmt- ABWMgmt-
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd-
HotPlug+ Surprise-
                        Slot #0, PowerLimit 0.000W; Interlock- NoCompl+
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet-
CmdCplt- HPIrq- LinkChg-
                        Control: AttnInd Unknown, PwrInd Unknown,
Power- Interlock-
                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt-
PresDet- Interlock-
                        Changed: MRL- PresDet- LinkState-
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal-
PMEIntEna- CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
                DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ ARIFwd-
                DevCtl2: Completion Timeout: 65ms to 210ms, TimeoutDis- ARIFwd-
                LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance-
SpeedDis-, Selectable De-emphasis: -6dB
                         Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -6dB
        Capabilities: [a0] MSI: Enable- Count=1/1 Maskable- 64bit+
                Address: 0000000000000000  Data: 0000
        Capabilities: [b0] Subsystem: Advanced Micro Devices [AMD] nee
ATI Device 0000
        Capabilities: [b8] HyperTransport: MSI Mapping Enable+ Fixed+
        Capabilities: [100 v1] Vendor Specific Information: ID=0001
Rev=1 Len=010 <?>
        Kernel driver in use: pcieport
        Kernel modules: shpchp

00:18.0 Host bridge: Advanced Micro Devices [AMD] Family 12h/14h
Processor Function 0 (rev 43)
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

00:18.1 Host bridge: Advanced Micro Devices [AMD] Family 12h/14h
Processor Function 1
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

00:18.2 Host bridge: Advanced Micro Devices [AMD] Family 12h/14h
Processor Function 2
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

00:18.3 Host bridge: Advanced Micro Devices [AMD] Family 12h/14h
Processor Function 3
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Capabilities: [f0] Secure device <?>
        Kernel driver in use: k10temp
        Kernel modules: k10temp

00:18.4 Host bridge: Advanced Micro Devices [AMD] Family 12h/14h
Processor Function 4
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

00:18.5 Host bridge: Advanced Micro Devices [AMD] Family 12h/14h
Processor Function 6
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

00:18.6 Host bridge: Advanced Micro Devices [AMD] Family 12h/14h
Processor Function 5
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

00:18.7 Host bridge: Advanced Micro Devices [AMD] Family 12h/14h
Processor Function 7
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

01:00.0 Network controller: Atheros Communications Inc. AR9285
Wireless Network Adapter (PCI-Express) (rev 01)
        Subsystem: AzureWave AW-NE785 / AW-NE785H 802.11bgn Wireless
Full or Half-size Mini PCIe Card
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at fea00000 (64-bit, non-prefetchable) [size=64K]
        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=375mA
PME(D0+,D1+,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit-
                Address: 00000000  Data: 0000
        Capabilities: [60] Express (v2) Legacy Endpoint, MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s
<512ns, L1 <64us
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
                DevCtl: Report errors: Correctable+ Non-Fatal+ Fatal-
Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+
AuxPwr+ TransPend-
                LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1,
Latency L0 <512ns, L1 <64us
                        ClockPM- Surprise- LLActRep- BwNot-
                LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled-
Retrain- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train-
SlotClk+ DLActive- BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Not Supported, TimeoutDis+
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
                LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance-
SpeedDis-, Selectable De-emphasis: -6dB
                         Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -6dB
        Capabilities: [100 v1] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt-
UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
                AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
        Capabilities: [140 v1] Virtual Channel
                Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
                Arb:    Fixed- WRR32- WRR64- WRR128-
                Ctrl:   ArbSelect=Fixed
                Status: InProgress-
                VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                        Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
                        Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=01
                        Status: NegoPending- InProgress-
        Capabilities: [160 v1] Device Serial Number 00-15-17-ff-ff-24-14-12
        Capabilities: [170 v1] Power Budgeting <?>
        Kernel driver in use: ath9k
        Kernel modules: ath9k

02:00.0 Ethernet controller: Atheros Communications Inc. AR8152 v2.0
Fast Ethernet (rev c1)
        Subsystem: ASUSTeK Computer Inc. Device 8468
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 41
        Region 0: Memory at fe900000 (64-bit, non-prefetchable) [size=256K]
        Region 2: I/O ports at e000 [size=128]
        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [48] MSI: Enable+ Count=1/1 Maskable- 64bit+
                Address: 00000000fee0300c  Data: 4191
        Capabilities: [58] Express (v1) Endpoint, MSI 00
                DevCap: MaxPayload 4096 bytes, PhantFunc 0, Latency
L0s unlimited, L1 unlimited
                        ExtTag- AttnBtn+ AttnInd+ PwrInd+ RBE+ FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr+ UncorrErr+ FatalErr- UnsuppReq-
AuxPwr+ TransPend-
                LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1,
Latency L0 unlimited, L1 unlimited
                        ClockPM+ Surprise- LLActRep- BwNot-
                LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes Disabled-
Retrain- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train-
SlotClk+ DLActive- BWMgmt- ABWMgmt-
        Capabilities: [6c] Vital Product Data
pcilib: sysfs_read_vpd: read failed: Connection timed out
                Not readable
        Capabilities: [100 v1] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt+
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP- SDES+ TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP+ BadDLLP+ Rollover- Timeout- NonFatalErr-
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
                AERCap: First Error Pointer: 14, GenCap+ CGenEn- ChkCap+ ChkEn-
        Capabilities: [180 v1] Device Serial Number ff-16-57-c8-54-04-a6-ff
        Kernel driver in use: atl1c
        Kernel modules: atl1c

[7.6] cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: ST9320325AS      Rev: 0003
  Type:   Direct-Access                    ANSI  SCSI revision: 05

[7.7] ls /proc/
1     1139  1636  1866  1933  2256  31   663  934        diskstats
kpageflags     slabinfo
10    1152  1637  1871  1934  23    32   7    935        dma
latency_stats  softirqs
1003  1182  1665  1874  1961  2360  33   70   957        dri
loadavg        stat
1006  12    1666  1888  1972  2380  34   71   967        driver
locks          swaps
1008  1238  1697  1895  1976  2381  392  735  972        execdomains
mdstat         sys
1012  1263  1698  1899  1985  2389  405  74   984        fb
meminfo        sysrq-trigger
1016  1266  1699  19    2     24    45   748  998        filesystems
misc           sysvipc
1024  13    17    1905  20    2402  47   759  acpi       fs
modules        timer_list
1082  14    1701  1908  2025  25    48   766  asound     interrupts
mounts         timer_stats
1087  1449  1706  1910  2026  26    5    8    buddyinfo  iomem
mtrr           tty
11    1492  1710  1913  2027  27    50   848  bus        ioports
net            uptime
1100  15    1712  1921  2059  28    587  873  cgroups    irq
pagetypeinfo   version
1105  1510  18    1924  21    29    59   876  cmdline    kallsyms
partitions     vmallocinfo
1111  1583  1818  1926  2158  3     625  877  consoles   kcore
sched_debug    vmstat
1128  16    1822  1928  2182  30    626  9    cpuinfo    key-users
schedstat      zoneinfo
1135  1632  1853  1929  2186  301   653  915  crypto     kmsg         scsi
1136  1633  1864  1930  22    302   654  919  devices    kpagecount   self

[X.] The bug behaves the same most of the times, but there have been
some changes in the behaviour as described in the launchpad link I
reported:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1076103
comment #9

I also followed the instructions on
http://www.kernel.org/doc/Documentation/power/basic-pm-debugging.txt
and performed some tests as follows:

first test:
# echo freezer > /sys/power/pm_test
# s2ram
Machine is unknown.
This machine can be identified by:
    sys_vendor   = "ASUSTeK Computer INC."
    sys_product  = "1215B"
    sys_version  = "x.x"
    bios_version = "0503"
# dmesg | tail -6
[   29.478205] type=1400 audit(1353088976.454:21): apparmor="STATUS"
operation="profile_replace" name="/usr/sbin/cupsd" pid=1005
comm="apparmor_parser"
[   29.782144] init: alsa-restore main process (1092) terminated with status 99
[   30.702350] init: anacron main process (1127) killed by TERM signal
[   80.344248] type=1400 audit(1353089027.350:22): apparmor="DENIED"
operation="capable" parent=1 profile="/usr/sbin/cupsd" pid=1008
comm="cupsd" pid=1008 comm="cupsd" capability=36
capname="block_suspend"
[  141.290233] type=1400 audit(1353089088.337:23): apparmor="DENIED"
operation="capable" parent=1 profile="/usr/sbin/cupsd" pid=1008
comm="cupsd" pid=1008 comm="cupsd" capability=36
capname="block_suspend"
[ 2666.084059] atl1c 0000:02:00.0: vpd r/w failed.  This is likely a
firmware bug on this device.  Contact the card vendor for a firmware
update.

second test:
# s2ram --force
..... ok the system tries the suspend test for 5 seconds, then it
resumes "almost"
successfully, but the screen now has a very strange problem. It is
"shifted" on the
right by about a half screen length, meaning that the right part of
the desktop is
on the left side of the screen, and the missing right part "follows"
on the left side of the screen.
It is really strange, because except for this image screw up, the
systems bahaves normally.
An attempt of doing Ctrl+Alt+F1 and then Ctrl+Alt+F7 causes the
displays to become almost black
and nothing is visible anymore.  Then Ctrl+Alt+Canc successfully
reboots the system cleanly. I report the dmesg output:

# dmesg |tail -8
[  745.790800] PM: Syncing filesystems ... done.
[  745.844128] PM: Preparing system for mem sleep
[  746.125395] Freezing user space processes ... (elapsed 0.01 seconds) done.
[  746.140760] Freezing remaining freezable tasks ... (elapsed 0.01
seconds) done.
[  746.156843] suspend debug: Waiting for 5 seconds.
[  751.117347] PM: Finishing wakeup.
[  751.117351] Restarting tasks ... done.
[  751.164134] video LNXVIDEO:00: Restoring backlight state

third test:
# echo "devices" > /sys/power/pm_test
# s2ram --force
... ok, the behaviour is exactly the same as before, with the screen
shift. Here is the
dmesg tail output:

[  362.360531] PM: Syncing filesystems ... done.
[  362.365945] PM: Preparing system for mem sleep
[  362.687149] Freezing user space processes ... (elapsed 0.01 seconds) done.
[  362.701842] Freezing remaining freezable tasks ... (elapsed 0.01
seconds) done.
[  362.717877] PM: Entering mem sleep
[  362.718044] Suspending console(s) (use no_console_suspend to debug)
[  362.779533] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[  362.822732] sd 0:0:0:0: [sda] Stopping disk
[  363.214241] PM: suspend of devices complete after 448.059 msecs
[  363.214248] PM: suspend devices took 0.496 seconds
[  363.214250] suspend debug: Waiting for 5 seconds.
[  368.176767] ath: phy0: ASPM enabled: 0x42
[  368.191557] snd_hda_intel 0000:00:01.1: irq 40 for MSI/MSI-X
[  368.209082] atl1c 0000:02:00.0: irq 41 for MSI/MSI-X
[  368.667540] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  370.585608] ata1.00: failed to get Identify Device Data, Emask 0x1
[  370.588600] ata1.00: failed to get Identify Device Data, Emask 0x1
[  370.588615] ata1.00: configured for UDMA/133
[  370.589151] sd 0:0:0:0: [sda] Starting disk
[  370.595348] Extended CMOS year: 2000
[  370.642710] PM: resume of devices complete after 2467.028 msecs
[  370.656561] PM: resume devices took 2.484 seconds
[  370.656608] PM: Finishing wakeup.
[  370.656612] Restarting tasks ... done.
[  370.700080] video LNXVIDEO:00: Restoring backlight state


fourth test:
# echo "platform" > /sys/power/pm_test
# s2ram --force
....well! The same result as before, with the screen shift. The dmesg
tail output:
PM: Syncing filesystems ... done.
[  199.518626] PM: Preparing system for mem sleep
[  199.777851] Freezing user space processes ... (elapsed 0.01 seconds) done.
[  199.792595] Freezing remaining freezable tasks ... (elapsed 0.01
seconds) done.
[  199.808604] PM: Entering mem sleep
[  199.808768] Suspending console(s) (use no_console_suspend to debug)
[  199.870105] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[  199.944959] sd 0:0:0:0: [sda] Stopping disk
[  200.334220] PM: suspend of devices complete after 477.814 msecs
[  200.334227] PM: suspend devices took 0.524 seconds
[  200.334583] PM: late suspend of devices complete after 0.349 msecs
[  200.364553] ehci_hcd 0000:00:13.2: wake-up capability enabled by ACPI
[  200.380161] ohci_hcd 0000:00:13.0: wake-up capability enabled by ACPI
[  200.380228] ehci_hcd 0000:00:12.2: wake-up capability enabled by ACPI
[  200.396153] ohci_hcd 0000:00:12.0: wake-up capability enabled by ACPI
[  200.396318] PM: noirq suspend of devices complete after 61.765 msecs
[  200.396379] ACPI: Preparing to enter system sleep state S3
[  200.396616] [Firmware Bug]: ACPI: BIOS _OSI(Linux) query ignored
[  200.528945] PM: Saving platform NVS memory
[  200.537526] suspend debug: Waiting for 5 seconds.
[  205.499138] ACPI: Waking up from system sleep state S3
[  205.664860] ohci_hcd 0000:00:12.0: wake-up capability disabled by ACPI
[  205.680523] ehci_hcd 0000:00:12.2: wake-up capability disabled by ACPI
[  205.680585] ohci_hcd 0000:00:13.0: wake-up capability disabled by ACPI
[  205.696535] ehci_hcd 0000:00:13.2: wake-up capability disabled by ACPI
[  205.744672] PM: noirq resume of devices complete after 95.805 msecs
[  205.745032] PM: early resume of devices complete after 0.227 msecs
[  205.745386] snd_hda_intel 0000:00:01.1: irq 40 for MSI/MSI-X
[  205.746611] ath: phy0: ASPM enabled: 0x42
[  205.778149] atl1c 0000:02:00.0: irq 41 for MSI/MSI-X
[  206.236196] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  208.160353] ata1.00: failed to get Identify Device Data, Emask 0x1
[  208.194584] ata1.00: failed to get Identify Device Data, Emask 0x1
[  208.194601] ata1.00: configured for UDMA/133
[  208.194842] sd 0:0:0:0: [sda] Starting disk
[  208.250551] PM: resume of devices complete after 2507.194 msecs
[  208.266979] PM: resume devices took 2.524 seconds
[  208.267071] PM: Finishing wakeup.
[  208.267076] Restarting tasks ... done.
[  208.315978] video LNXVIDEO:00: Restoring backlight state

5ft test:
# echo "processors" > /sys/power/pm_test
# s2ram --force
.... Nothing has changed, still resume with screen shift.
dmesg output:

[  191.458939] PM: Syncing filesystems ... done.
[  191.678113] PM: Preparing system for mem sleep
[  192.084380] Freezing user space processes ... (elapsed 0.01 seconds) done.
[  192.100530] Freezing remaining freezable tasks ... (elapsed 0.01
seconds) done.
[  192.116564] PM: Entering mem sleep
[  192.116734] Suspending console(s) (use no_console_suspend to debug)
[  192.178125] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[  192.233492] sd 0:0:0:0: [sda] Stopping disk
[  192.631346] PM: suspend of devices complete after 466.467 msecs
[  192.631354] PM: suspend devices took 0.512 seconds
[  192.631709] PM: late suspend of devices complete after 0.349 msecs
[  192.661057] ehci_hcd 0000:00:13.2: wake-up capability enabled by ACPI
[  192.676675] ohci_hcd 0000:00:13.0: wake-up capability enabled by ACPI
[  192.676742] ehci_hcd 0000:00:12.2: wake-up capability enabled by ACPI
[  192.692684] ohci_hcd 0000:00:12.0: wake-up capability enabled by ACPI
[  192.692849] PM: noirq suspend of devices complete after 61.109 msecs
[  192.692910] ACPI: Preparing to enter system sleep state S3
[  192.693151] [Firmware Bug]: ACPI: BIOS _OSI(Linux) query ignored
[  192.781942] PM: Saving platform NVS memory
[  192.790461] Disabling non-boot CPUs ...
[  192.791030] Broke affinity for irq 9
[  192.892517] smpboot: CPU 1 is now offline
[  192.893423] suspend debug: Waiting for 5 seconds.
[  197.854290] Enabling non-boot CPUs ...
[  197.854403] smpboot: Booting Node 0 Processor 1 APIC 0x1
[  197.857934] [sched_delayed] sched: RT throttling activated
[  197.865486] LVT offset 0 assigned for vector 0x400
[  197.868398] CPU1 is up
[  197.869345] ACPI: Waking up from system sleep state S3
[  198.018661] ohci_hcd 0000:00:12.0: wake-up capability disabled by ACPI
[  198.034417] ehci_hcd 0000:00:12.2: wake-up capability disabled by ACPI
[  198.034481] ohci_hcd 0000:00:13.0: wake-up capability disabled by ACPI
[  198.050389] ehci_hcd 0000:00:13.2: wake-up capability disabled by ACPI
[  198.098552] PM: noirq resume of devices complete after 95.779 msecs
[  198.098906] PM: early resume of devices complete after 0.222 msecs
[  198.099221] snd_hda_intel 0000:00:01.1: irq 40 for MSI/MSI-X
[  198.100612] ath: phy0: ASPM enabled: 0x42
[  198.132006] atl1c 0000:02:00.0: irq 41 for MSI/MSI-X
[  198.590449] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  200.528251] ata1.00: failed to get Identify Device Data, Emask 0x1
[  200.531536] ata1.00: failed to get Identify Device Data, Emask 0x1
[  200.531551] ata1.00: configured for UDMA/133
[  200.531772] sd 0:0:0:0: [sda] Starting disk
[  200.586148] PM: resume of devices complete after 2486.423 msecs
[  200.599426] PM: resume devices took 2.500 seconds
[  200.599496] PM: Finishing wakeup.
[  200.599499] Restarting tasks ... done.
[  200.624835] type=1400 audit(1353097416.540:17): apparmor="DENIED"
operation="capable" parent=1 profile="/usr/sbin/cupsd" pid=1005
comm="cupsd" pid=1005 comm="cupsd" capability=36
capname="block_suspend"
[  200.641466] video LNXVIDEO:00: Restoring backlight state

sixt test:
# echo "core" > /sys/power/pm_test
# s2ram --force

The same results, resume and screen shift.
The dmesg output:

[  423.568156] PM: Syncing filesystems ... done.
[  423.880769] PM: Preparing system for mem sleep
[  424.192253] Freezing user space processes ... (elapsed 0.01 seconds) done.
[  424.207865] Freezing remaining freezable tasks ... (elapsed 0.01
seconds) done.
[  424.223790] PM: Entering mem sleep
[  424.223964] Suspending console(s) (use no_console_suspend to debug)
[  424.285361] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[  424.333574] sd 0:0:0:0: [sda] Stopping disk
[  424.723827] PM: suspend of devices complete after 451.848 msecs
[  424.723834] PM: suspend devices took 0.500 seconds
[  424.724187] PM: late suspend of devices complete after 0.347 msecs
[  424.756179] ehci_hcd 0000:00:13.2: wake-up capability enabled by ACPI
[  424.771736] ohci_hcd 0000:00:13.0: wake-up capability enabled by ACPI
[  424.771803] ehci_hcd 0000:00:12.2: wake-up capability enabled by ACPI
[  424.787732] ohci_hcd 0000:00:12.0: wake-up capability enabled by ACPI
[  424.787999] PM: noirq suspend of devices complete after 63.813 msecs
[  424.788060] ACPI: Preparing to enter system sleep state S3
[  424.872522] PM: Saving platform NVS memory
[  424.881014] Disabling non-boot CPUs ...
[  424.882067] Broke affinity for irq 17
[  424.882078] Broke affinity for irq 18
[  424.983501] smpboot: CPU 1 is now offline
[  424.984516] Extended CMOS year: 2000
[  424.984595] suspend debug: Waiting for 5 seconds.
[  429.945524] Extended CMOS year: 2000
[  429.945606] ------------[ cut here ]------------
[  429.945622] WARNING: at
/home/apw/COD/linux/drivers/base/syscore.c:104
syscore_resume+0x9e/0xe0()
[  429.945625] Hardware name: 1215B
[  429.945633] Interrupts enabled after ledtrig_cpu_syscore_resume+0x0/0x20
[  429.945704] Modules linked in: rfcomm bnep bluetooth parport_pc
ppdev binfmt_misc dm_crypt joydev kvm_amd kvm eeepc_wmi asus_wmi
snd_hda_codec_realtek snd_hda_codec_hdmi sparse_keymap snd_hda_intel
uvcvideo arc4 snd_hda_codec videobuf2_core ath9k snd_hwdep videodev
mac80211 videobuf2_vmalloc snd_seq_midi snd_pcm videobuf2_memops
psmouse sp5100_tco microcode ath9k_common snd_rawmidi serio_raw
i2c_piix4 ath9k_hw snd_seq_midi_event snd_seq k10temp hid_generic
snd_timer snd_seq_device ath snd cfg80211 mac_hid soundcore
snd_page_alloc msr lp parport usbhid hid radeon ttm drm_kms_helper drm
i2c_algo_bit atl1c video wmi
[  429.945710] Pid: 2350, comm: s2ram Not tainted
3.7.0-030700rc5-generic #201211110835
[  429.945711] Call Trace:
[  429.945722]  [<ffffffff810588cf>] warn_slowpath_common+0x7f/0xc0
[  429.945727]  [<ffffffff810589c6>] warn_slowpath_fmt+0x46/0x50
[  429.945733]  [<ffffffff81569d30>] ? ledtrig_cpu_syscore_shutdown+0x20/0x20
[  429.945737]  [<ffffffff8144356e>] syscore_resume+0x9e/0xe0
[  429.945742]  [<ffffffff810a210a>] suspend_enter+0x13a/0x170
[  429.945746]  [<ffffffff810a220b>] suspend_devices_and_enter+0xcb/0x200
[  429.945749]  [<ffffffff810a2411>] enter_state+0xd1/0x100
[  429.945753]  [<ffffffff810a245b>] pm_suspend+0x1b/0x60
[  429.945758]  [<ffffffff810a14b5>] state_store+0x45/0x70
[  429.945765]  [<ffffffff81342d2f>] kobj_attr_store+0xf/0x30
[  429.945771]  [<ffffffff812059ff>] sysfs_write_file+0xef/0x170
[  429.945777]  [<ffffffff81193433>] vfs_write+0xb3/0x180
[  429.945781]  [<ffffffff81193772>] sys_write+0x52/0xa0
[  429.945787]  [<ffffffff816d339d>] system_call_fastpath+0x1a/0x1f
[  429.945790] ---[ end trace 0a022cacb5d2ec92 ]---
[  429.945801] Enabling non-boot CPUs ...
[  429.945921] smpboot: Booting Node 0 Processor 1 APIC 0x1
[  429.957002] LVT offset 0 assigned for vector 0x400
[  429.959808] CPU1 is up
[  429.960906] ACPI: Waking up from system sleep state S3
[  430.112921] ohci_hcd 0000:00:12.0: wake-up capability disabled by ACPI
[  430.128633] ehci_hcd 0000:00:12.2: wake-up capability disabled by ACPI
[  430.128697] ohci_hcd 0000:00:13.0: wake-up capability disabled by ACPI
[  430.144664] ehci_hcd 0000:00:13.2: wake-up capability disabled by ACPI
[  430.192766] PM: noirq resume of devices complete after 95.907 msecs
[  430.193085] PM: early resume of devices complete after 0.223 msecs
[  430.193413] snd_hda_intel 0000:00:01.1: irq 40 for MSI/MSI-X
[  430.194806] ath: phy0: ASPM enabled: 0x42
[  430.226104] atl1c 0000:02:00.0: irq 41 for MSI/MSI-X
[  430.684448] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  432.573969] ata1.00: failed to get Identify Device Data, Emask 0x1
[  432.577131] ata1.00: failed to get Identify Device Data, Emask 0x1
[  432.577146] ata1.00: configured for UDMA/133
[  432.577378] sd 0:0:0:0: [sda] Starting disk
[  432.631101] PM: resume of devices complete after 2438.430 msecs
[  432.644440] PM: resume devices took 2.452 seconds
[  432.644590] PM: Finishing wakeup.
[  432.644595] Restarting tasks ... done.
[  432.689459] video LNXVIDEO:00: Restoring backlight state


7th test:
# echo "none" > /sys/power/pm_test
# s2ram --force

...ok this reproduced the Bug immediately. It was not possible to resume.
I don't know how to recover the dmesg output.


I hope I gave all the necessary informations to track down the bug,
but feel free to contact me for any other request, and thank you in
advance for any possible help.

Vincenzo Costa
