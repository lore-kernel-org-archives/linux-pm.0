From: Geoffrey Ferrari <geoffrey.ferrari@oriel.oxon.org>
Subject: PROBLEM: 0ccd:0038 [Intel DH57JG] suspend/resume failure
Date: Fri, 8 Nov 2013 09:02:46 +0000
Message-ID: <CAAoeO9hQ9-Q1p+FZbdeMMD=q5Nqr1WVAfN-msJH4zdrinqyFGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f172.google.com ([74.125.82.172]:64790 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221Ab3KHJCt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 8 Nov 2013 04:02:49 -0500
Received: by mail-we0-f172.google.com with SMTP id q58so1675391wes.3
        for <linux-pm@vger.kernel.org>; Fri, 08 Nov 2013 01:02:47 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

[1.] 0ccd:0038 [Intel DH57JG] suspend/resume failure

[2.] When using the Cinergy Terratec T2 USB DVB device, my computer
fails to suspend fully and then cannot resume. The power light on the
Cinergy device and also on my computer remain on throughout. My
computer is a homebuilt machine based on Intel DH57JG motherboard
updated to the latest 0663 BIOS.

[3.]


[4.] Linux version 3.12.0-031200-generic (apw@gomeisa) (gcc version
4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201311031935 SMP Mon Nov 4
00:36:54 UTC 2013


[5.]

[6.] Problem can be recreated by using the Cinergy device with
tvheadend and then attempting to suspend/resume.

[7.]

Description:    Ubuntu 13.10
Release:        13.10

[7.1]

Linux blackpearl 3.12.0-031200-generic #201311031935 SMP Mon Nov 4
00:36:54 UTC 2013 x86_64 x86_64 x86_64 GNU/Linux

Gnu C                  4.8
Gnu make               3.81
binutils               2.23.52.20130913
util-linux             2.20.1
mount                  support
module-init-tools      9
e2fsprogs              1.42.8
pcmciautils            018
PPP                    2.4.5
Linux C Library        2.17
Dynamic linker (ldd)   2.17
Procps                 3.3.3
Net-tools              1.60
Kbd                    1.15.5
Sh-utils               8.20
wireless-tools         30
Modules Loaded         parport_pc ppdev bnep rfcomm intel_powerclamp
coretemp kvm_intel kvm arc4 crct10dif_pclmul crc32_pclmul rt2800usb
ghash_clmulni_intel aesni_intel rt2x00usb aes_x86_64 rt2800lib lrw
rt2x00lib gf128mul mac80211 glue_helper ablk_helper cryptd gpio_ich
cfg80211 dvb_usb_cinergyT2 dvb_usb dvb_core snd_hda_codec_hdmi
crc_ccitt btusb snd_hda_codec_realtek rc_core bluetooth snd_hda_intel
snd_hda_codec i915 snd_hwdep snd_pcm snd_page_alloc snd_seq_midi video
snd_seq_midi_event drm_kms_helper snd_rawmidi snd_seq drm
snd_seq_device psmouse snd_timer i2c_algo_bit snd soundcore serio_raw
mei_me microcode mei lpc_ich mac_hid lp parport hid_generic usbhid hid
e1000e ptp pps_core

[7.2]

processor : 0
vendor_id : GenuineIntel
cpu family : 6
model : 37
model name : Intel(R) Core(TM) i5 CPU         650  @ 3.20GHz
stepping : 2
microcode : 0xc
cpu MHz : 1199.000
cache size : 4096 KB
physical id : 0
siblings : 4
core id : 0
cpu cores : 2
apicid : 0
initial apicid : 0
fpu : yes
fpu_exception : yes
cpuid level : 11
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology
nonstop_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est
tm2 ssse3 cx16 xtpr pdcm sse4_1 sse4_2 popcnt aes lahf_lm ida arat
dtherm tpr_shadow vnmi flexpriority ept vpid
bogomips : 6399.62
clflush size : 64
cache_alignment : 64
address sizes : 36 bits physical, 48 bits virtual
power management:

processor : 1
vendor_id : GenuineIntel
cpu family : 6
model : 37
model name : Intel(R) Core(TM) i5 CPU         650  @ 3.20GHz
stepping : 2
microcode : 0xc
cpu MHz : 1199.000
cache size : 4096 KB
physical id : 0
siblings : 4
core id : 0
cpu cores : 2
apicid : 1
initial apicid : 1
fpu : yes
fpu_exception : yes
cpuid level : 11
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology
nonstop_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est
tm2 ssse3 cx16 xtpr pdcm sse4_1 sse4_2 popcnt aes lahf_lm ida arat
dtherm tpr_shadow vnmi flexpriority ept vpid
bogomips : 6399.62
clflush size : 64
cache_alignment : 64
address sizes : 36 bits physical, 48 bits virtual
power management:

processor : 2
vendor_id : GenuineIntel
cpu family : 6
model : 37
model name : Intel(R) Core(TM) i5 CPU         650  @ 3.20GHz
stepping : 2
microcode : 0xc
cpu MHz : 1199.000
cache size : 4096 KB
physical id : 0
siblings : 4
core id : 2
cpu cores : 2
apicid : 4
initial apicid : 4
fpu : yes
fpu_exception : yes
cpuid level : 11
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology
nonstop_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est
tm2 ssse3 cx16 xtpr pdcm sse4_1 sse4_2 popcnt aes lahf_lm ida arat
dtherm tpr_shadow vnmi flexpriority ept vpid
bogomips : 6399.62
clflush size : 64
cache_alignment : 64
address sizes : 36 bits physical, 48 bits virtual
power management:

processor : 3
vendor_id : GenuineIntel
cpu family : 6
model : 37
model name : Intel(R) Core(TM) i5 CPU         650  @ 3.20GHz
stepping : 2
microcode : 0xc
cpu MHz : 1199.000
cache size : 4096 KB
physical id : 0
siblings : 4
core id : 2
cpu cores : 2
apicid : 5
initial apicid : 5
fpu : yes
fpu_exception : yes
cpuid level : 11
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology
nonstop_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est
tm2 ssse3 cx16 xtpr pdcm sse4_1 sse4_2 popcnt aes lahf_lm ida arat
dtherm tpr_shadow vnmi flexpriority ept vpid
bogomips : 6399.62
clflush size : 64
cache_alignment : 64
address sizes : 36 bits physical, 48 bits virtual
power management:

[7.3]

parport_pc 32866 0 - Live 0x0000000000000000
ppdev 17711 0 - Live 0x0000000000000000
bnep 23966 2 - Live 0x0000000000000000
rfcomm 74658 16 - Live 0x0000000000000000
intel_powerclamp 19031 0 - Live 0x0000000000000000
coretemp 17728 0 - Live 0x0000000000000000
kvm_intel 144049 0 - Live 0x0000000000000000
kvm 457676 1 kvm_intel, Live 0x0000000000000000
arc4 12573 2 - Live 0x0000000000000000
crct10dif_pclmul 14250 0 - Live 0x0000000000000000
crc32_pclmul 13160 0 - Live 0x0000000000000000
rt2800usb 27196 0 - Live 0x0000000000000000
ghash_clmulni_intel 13259 0 - Live 0x0000000000000000
aesni_intel 55720 1 - Live 0x0000000000000000
rt2x00usb 20857 1 rt2800usb, Live 0x0000000000000000
aes_x86_64 17131 1 aesni_intel, Live 0x0000000000000000
rt2800lib 95449 1 rt2800usb, Live 0x0000000000000000
lrw 13294 1 aesni_intel, Live 0x0000000000000000
rt2x00lib 56053 3 rt2800usb,rt2x00usb,rt2800lib, Live 0x0000000000000000
gf128mul 14951 1 lrw, Live 0x0000000000000000
mac80211 634700 3 rt2x00usb,rt2800lib,rt2x00lib, Live 0x0000000000000000
glue_helper 14095 1 aesni_intel, Live 0x0000000000000000
ablk_helper 13597 1 aesni_intel, Live 0x0000000000000000
cryptd 20501 3 ghash_clmulni_intel,aesni_intel,ablk_helper, Live
0x0000000000000000
gpio_ich 13526 0 - Live 0x0000000000000000
cfg80211 504229 2 rt2x00lib,mac80211, Live 0x0000000000000000
dvb_usb_cinergyT2 18014 52 - Live 0x0000000000000000
dvb_usb 24578 1 dvb_usb_cinergyT2, Live 0x0000000000000000
dvb_core 122592 1 dvb_usb, Live 0x0000000000000000
snd_hda_codec_hdmi 41684 1 - Live 0x0000000000000000
crc_ccitt 12707 1 rt2800lib, Live 0x0000000000000000
btusb 28326 0 - Live 0x0000000000000000
snd_hda_codec_realtek 56888 1 - Live 0x0000000000000000
rc_core 28163 1 dvb_usb, Live 0x0000000000000000
bluetooth 391597 22 bnep,rfcomm,btusb, Live 0x0000000000000000
snd_hda_intel 57183 3 - Live 0x0000000000000000
snd_hda_codec 194881 3
snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_intel, Live
0x0000000000000000
i915 734026 4 - Live 0x0000000000000000
snd_hwdep 13613 1 snd_hda_codec, Live 0x0000000000000000
snd_pcm 107140 3 snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec, Live
0x0000000000000000
snd_page_alloc 18798 2 snd_hda_intel,snd_pcm, Live 0x0000000000000000
snd_seq_midi 13324 0 - Live 0x0000000000000000
video 19574 1 i915, Live 0x0000000000000000
snd_seq_midi_event 14899 1 snd_seq_midi, Live 0x0000000000000000
drm_kms_helper 53165 1 i915, Live 0x0000000000000000
snd_rawmidi 30465 1 snd_seq_midi, Live 0x0000000000000000
snd_seq 66061 2 snd_seq_midi,snd_seq_midi_event, Live 0x0000000000000000
drm 303133 5 i915,drm_kms_helper, Live 0x0000000000000000
snd_seq_device 14497 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 0x0000000000000000
psmouse 104113 0 - Live 0x0000000000000000
snd_timer 30038 2 snd_pcm,snd_seq, Live 0x0000000000000000
i2c_algo_bit 13564 1 i915, Live 0x0000000000000000
snd 73802 17 snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_seq_midi,snd_rawmidi,snd_seq,snd_seq_device,snd_timer,
Live 0x0000000000000000
soundcore 12680 1 snd, Live 0x0000000000000000
serio_raw 13462 0 - Live 0x0000000000000000
mei_me 18418 0 - Live 0x0000000000000000
microcode 23650 0 - Live 0x0000000000000000
mei 78609 1 mei_me, Live 0x0000000000000000
lpc_ich 21163 0 - Live 0x0000000000000000
mac_hid 13253 0 - Live 0x0000000000000000
lp 17799 0 - Live 0x0000000000000000
parport 42481 3 parport_pc,ppdev,lp, Live 0x0000000000000000
hid_generic 12548 0 - Live 0x0000000000000000
usbhid 53067 0 - Live 0x0000000000000000
hid 106254 2 hid_generic,usbhid, Live 0x0000000000000000
e1000e 257404 0 - Live 0x0000000000000000
ptp 18980 1 e1000e, Live 0x0000000000000000
pps_core 19352 1 ptp, Live 0x0000000000000000

[7.4]

0000-0cf7 : PCI Bus 0000:00
  0000-001f : dma1
  0020-0021 : pic1
  0040-0043 : timer0
  0050-0053 : timer1
  0060-0060 : keyboard
  0064-0064 : keyboard
  0070-0071 : rtc0
  0080-008f : dma page reg
  00a0-00a1 : pic2
  00c0-00df : dma2
  00f0-00ff : fpu
  03f8-03ff : serial
  0400-0403 : ACPI PM1a_EVT_BLK
  0404-0405 : ACPI PM1a_CNT_BLK
  0408-040b : ACPI PM_TMR
  0410-0415 : ACPI CPU throttle
  0420-042f : ACPI GPE0_BLK
    0428-042f : gpio_ich
  0430-0433 : iTCO_wdt
  0450-0450 : ACPI PM2_CNT_BLK
  0460-047f : iTCO_wdt
  0500-057f : gpio_ich
    0500-057f : pnp 00:05
      0530-053f : gpio_ich
      0540-054f : gpio_ich
  0680-06ff : pnp 00:05
0cf8-0cff : PCI conf1
0d00-ffff : PCI Bus 0000:00
  1000-101f : 0000:00:1f.3
  1020-103f : 0000:00:19.0
  1040-104f : 0000:00:1f.5
    1040-104f : ata_piix
  1050-105f : 0000:00:1f.5
    1050-105f : ata_piix
  1060-106f : 0000:00:1f.2
    1060-106f : ata_piix
  1070-107f : 0000:00:1f.2
    1070-107f : ata_piix
  1080-108f : 0000:00:16.2
    1080-108f : ata_generic
  1090-1097 : 0000:00:1f.5
    1090-1097 : ata_piix
  1098-109f : 0000:00:1f.5
    1098-109f : ata_piix
  10a0-10a7 : 0000:00:1f.2
    10a0-10a7 : ata_piix
  10a8-10af : 0000:00:1f.2
    10a8-10af : ata_piix
  10b0-10b7 : 0000:00:16.3
    10b0-10b7 : serial
  10b8-10bf : 0000:00:16.2
    10b8-10bf : ata_generic
  10c0-10c7 : 0000:00:16.2
    10c0-10c7 : ata_generic
  10c8-10cf : 0000:00:02.0
  10d0-10d3 : 0000:00:1f.5
    10d0-10d3 : ata_piix
  10d4-10d7 : 0000:00:1f.5
    10d4-10d7 : ata_piix
  10d8-10db : 0000:00:1f.2
    10d8-10db : ata_piix
  10dc-10df : 0000:00:1f.2
    10dc-10df : ata_piix
  10e0-10e3 : 0000:00:16.2
    10e0-10e3 : ata_generic
  10e4-10e7 : 0000:00:16.2
    10e4-10e7 : ata_generic
  2000-2fff : PCI Bus 0000:01



00000000-00000fff : reserved
00001000-0008efff : System RAM
0008f000-0009ffff : reserved
000a0000-000bffff : PCI Bus 0000:00
000c0000-000cdbff : Video ROM
000ce000-000cefff : Adapter ROM
000cf000-000cffff : Adapter ROM
000e0000-000fffff : reserved
  000f0000-000fffff : System ROM
00100000-db5dcfff : System RAM
  01000000-01753e24 : Kernel code
  01753e25-01d1653f : Kernel data
  01e6e000-01fcffff : Kernel bss
db5dd000-db5e4fff : reserved
db5e5000-db61efff : System RAM
db61f000-db66efff : reserved
db66f000-db6e9fff : System RAM
db6ea000-db7befff : ACPI Non-volatile Storage
db7bf000-db7e7fff : System RAM
db7e8000-db7f0fff : ACPI Tables
db7f1000-db7f1fff : System RAM
db7f2000-db7fefff : ACPI Tables
db7ff000-db7fffff : System RAM
db800000-dfffffff : reserved
  de000000-dfffffff : Graphics Stolen Memory
e0000000-f7ffffff : PCI Bus 0000:00
  e0000000-efffffff : 0000:00:02.0
  f0000000-f03fffff : 0000:00:02.0
  f0400000-f041ffff : 0000:00:19.0
    f0400000-f041ffff : e1000e
  f0420000-f0423fff : 0000:00:1b.0
    f0420000-f0423fff : ICH HD audio
  f0424000-f0424fff : 0000:00:19.0
    f0424000-f0424fff : e1000e
  f0425000-f0425fff : 0000:00:16.3
  f0426000-f04263ff : 0000:00:1d.0
    f0426000-f04263ff : ehci_hcd
  f0426400-f04267ff : 0000:00:1a.0
    f0426400-f04267ff : ehci_hcd
  f0426800-f04268ff : 0000:00:1f.3
  f0426900-f042690f : 0000:00:16.0
    f0426900-f042690f : mei_me
  f0427000-f0427fff : Intel Flush Page
  f0500000-f06fffff : PCI Bus 0000:01
  f0700000-f08fffff : PCI Bus 0000:01
f8000000-ffffffff : reserved
  f8000000-fbffffff : PCI MMCONFIG 0000 [bus 00-3f]
  fec00000-fec003ff : IOAPIC 0
  fed00000-fed003ff : HPET 0
  fed1f410-fed1f414 : iTCO_wdt
  fee00000-fee00fff : Local APIC
100000000-117ffffff : System RAM


[7.5]

00:00.0 Host bridge: Intel Corporation Core Processor DRAM Controller (rev 12)
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ >SERR- <PERR- INTx-
Latency: 0
Capabilities: [e0] Vendor Specific Information: Len=0c <?>
Kernel driver in use: agpgart-intel

00:02.0 VGA compatible controller: Intel Corporation Core Processor
Integrated Graphics Controller (rev 12) (prog-if 00 [VGA controller])
Subsystem: Intel Corporation Core Processor Integrated Graphics Controller
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin A routed to IRQ 42
Region 0: Memory at f0000000 (64-bit, non-prefetchable) [size=4M]
Region 2: Memory at e0000000 (64-bit, prefetchable) [size=256M]
Region 4: I/O ports at 10c8 [size=8]
Expansion ROM at <unassigned> [disabled]
Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
Address: fee0f00c  Data: 41c1
Capabilities: [d0] Power Management version 2
Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [a4] PCI Advanced Features
AFCap: TP+ FLR+
AFCtrl: FLR-
AFStatus: TP-
Kernel driver in use: i915

00:16.0 Communication controller: Intel Corporation 5 Series/3400
Series Chipset HECI Controller (rev 06)
Subsystem: Intel Corporation Device 474a
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin A routed to IRQ 41
Region 0: Memory at f0426900 (64-bit, non-prefetchable) [size=16]
Capabilities: [50] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [8c] MSI: Enable+ Count=1/1 Maskable- 64bit+
Address: 00000000fee0f00c  Data: 41b1
Kernel driver in use: mei_me

00:16.2 IDE interface: Intel Corporation 5 Series/3400 Series Chipset
PT IDER Controller (rev 06) (prog-if 85 [Master SecO PriO])
Subsystem: Intel Corporation Device 474a
Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin C routed to IRQ 18
Region 0: I/O ports at 10c0 [size=8]
Region 1: I/O ports at 10e4 [size=4]
Region 2: I/O ports at 10b8 [size=8]
Region 3: I/O ports at 10e0 [size=4]
Region 4: I/O ports at 1080 [size=16]
Capabilities: [c8] Power Management version 3
Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [d0] MSI: Enable- Count=1/1 Maskable- 64bit+
Address: 0000000000000000  Data: 0000
Kernel driver in use: ata_generic

00:16.3 Serial controller: Intel Corporation 5 Series/3400 Series
Chipset KT Controller (rev 06) (prog-if 02 [16550])
Subsystem: Intel Corporation Device 474a
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin B routed to IRQ 19
Region 0: I/O ports at 10b0 [size=8]
Region 1: Memory at f0425000 (32-bit, non-prefetchable) [size=4K]
Capabilities: [c8] Power Management version 3
Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [d0] MSI: Enable- Count=1/1 Maskable- 64bit+
Address: 0000000000000000  Data: 0000
Kernel driver in use: serial

00:19.0 Ethernet controller: Intel Corporation 82578DC Gigabit Network
Connection (rev 06)
Subsystem: Intel Corporation Device 0035
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin A routed to IRQ 40
Region 0: Memory at f0400000 (32-bit, non-prefetchable) [size=128K]
Region 1: Memory at f0424000 (32-bit, non-prefetchable) [size=4K]
Region 2: I/O ports at 1020 [size=32]
Capabilities: [c8] Power Management version 2
Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
Address: 00000000fee0200c  Data: 4142
Capabilities: [e0] PCI Advanced Features
AFCap: TP+ FLR+
AFCtrl: FLR-
AFStatus: TP-
Kernel driver in use: e1000e

00:1a.0 USB controller: Intel Corporation 5 Series/3400 Series Chipset
USB2 Enhanced Host Controller (rev 06) (prog-if 20 [EHCI])
Subsystem: Intel Corporation Device 474a
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin A routed to IRQ 16
Region 0: Memory at f0426400 (32-bit, non-prefetchable) [size=1K]
Capabilities: [50] Power Management version 2
Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [58] Debug port: BAR=1 offset=00a0
Capabilities: [98] PCI Advanced Features
AFCap: TP+ FLR+
AFCtrl: FLR-
AFStatus: TP+
Kernel driver in use: ehci-pci

00:1b.0 Audio device: Intel Corporation 5 Series/3400 Series Chipset
High Definition Audio (rev 06)
Subsystem: Intel Corporation Device 0035
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 43
Region 0: Memory at f0420000 (64-bit, non-prefetchable) [size=16K]
Capabilities: [50] Power Management version 2
Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
Address: 00000000fee0f00c  Data: 41e1
Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI 00
DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
ExtTag- RBE- FLReset+
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
MaxPayload 128 bytes, MaxReadReq 128 bytes
DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
LnkCap: Port #0, Speed unknown, Width x0, ASPM unknown, Latency L0
<64ns, L1 <1us
ClockPM- Surprise- LLActRep- BwNot-
LnkCtl: ASPM Disabled; Disabled- Retrain- CommClk-
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta: Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive-
BWMgmt- ABWMgmt-
Capabilities: [100 v1] Virtual Channel
Caps: LPEVC=0 RefClk=100ns PATEntryBits=1
Arb: Fixed- WRR32- WRR64- WRR128-
Ctrl: ArbSelect=Fixed
Status: InProgress-
VC0: Caps: PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
Arb: Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
Ctrl: Enable+ ID=0 ArbSelect=Fixed TC/VC=01
Status: NegoPending- InProgress-
VC1: Caps: PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
Arb: Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
Ctrl: Enable+ ID=1 ArbSelect=Fixed TC/VC=02
Status: NegoPending- InProgress-
Capabilities: [130 v1] Root Complex Link
Desc: PortNumber=0f ComponentID=00 EltType=Config
Link0: Desc: TargetPort=00 TargetComponent=00 AssocRCRB-
LinkType=MemMapped LinkValid+
Addr: 00000000fed1c000
Kernel driver in use: snd_hda_intel

00:1c.0 PCI bridge: Intel Corporation 5 Series/3400 Series Chipset PCI
Express Root Port 1 (rev 06) (prog-if 00 [Normal decode])
Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
I/O behind bridge: 00002000-00002fff
Memory behind bridge: f0500000-f06fffff
Prefetchable memory behind bridge: 00000000f0700000-00000000f08fffff
Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
ExtTag- RBE+ FLReset-
DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
MaxPayload 128 bytes, MaxReadReq 128 bytes
DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
LnkCap: Port #1, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 <1us, L1 <4us
ClockPM- Surprise- LLActRep+ BwNot-
LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ DLActive-
BWMgmt- ABWMgmt-
SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
Slot #0, PowerLimit 10.000W; Interlock- NoCompl+
SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
Changed: MRL- PresDet- LinkState-
RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
RootCap: CRSVisible-
RootSta: PME ReqID 0000, PMEStatus- PMEPending-
DevCap2: Completion Timeout: Range BC, TimeoutDis+ ARIFwd-
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-,
Selectable De-emphasis: -6dB
Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-,
EqualizationPhase1-
EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
Address: 00000000  Data: 0000
Capabilities: [90] Subsystem: Intel Corporation Device 474a
Capabilities: [a0] Power Management version 2
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Kernel driver in use: pcieport

00:1d.0 USB controller: Intel Corporation 5 Series/3400 Series Chipset
USB2 Enhanced Host Controller (rev 06) (prog-if 20 [EHCI])
Subsystem: Intel Corporation Device 474a
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin A routed to IRQ 23
Region 0: Memory at f0426000 (32-bit, non-prefetchable) [size=1K]
Capabilities: [50] Power Management version 2
Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [58] Debug port: BAR=1 offset=00a0
Capabilities: [98] PCI Advanced Features
AFCap: TP+ FLR+
AFCtrl: FLR-
AFStatus: TP-
Kernel driver in use: ehci-pci

00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev a6)
(prog-if 01 [Subtractive decode])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
I/O behind bridge: 0000f000-00000fff
Memory behind bridge: fff00000-000fffff
Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
Capabilities: [50] Subsystem: Intel Corporation Device 474a

00:1f.0 ISA bridge: Intel Corporation 5 Series Chipset LPC Interface
Controller (rev 06)
Subsystem: Intel Corporation Device 474a
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B- DisINTx-
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Capabilities: [e0] Vendor Specific Information: Len=10 <?>
Kernel driver in use: lpc_ich

00:1f.2 IDE interface: Intel Corporation 5 Series/3400 Series Chipset
4 port SATA IDE Controller (rev 06) (prog-if 8f [Master SecP SecO PriP
PriO])
Subsystem: Intel Corporation Device 474a
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin B routed to IRQ 19
Region 0: I/O ports at 10a8 [size=8]
Region 1: I/O ports at 10dc [size=4]
Region 2: I/O ports at 10a0 [size=8]
Region 3: I/O ports at 10d8 [size=4]
Region 4: I/O ports at 1070 [size=16]
Region 5: I/O ports at 1060 [size=16]
Capabilities: [70] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [b0] PCI Advanced Features
AFCap: TP+ FLR+
AFCtrl: FLR-
AFStatus: TP-
Kernel driver in use: ata_piix

00:1f.3 SMBus: Intel Corporation 5 Series/3400 Series Chipset SMBus
Controller (rev 06)
Subsystem: Intel Corporation Device 474a
Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Interrupt: pin C routed to IRQ 10
Region 0: Memory at f0426800 (64-bit, non-prefetchable) [size=256]
Region 4: I/O ports at 1000 [size=32]

00:1f.5 IDE interface: Intel Corporation 5 Series/3400 Series Chipset
2 port SATA IDE Controller (rev 06) (prog-if 85 [Master SecO PriO])
Subsystem: Intel Corporation Device 474a
Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Interrupt: pin B routed to IRQ 19
Region 0: I/O ports at 1098 [size=8]
Region 1: I/O ports at 10d4 [size=4]
Region 2: I/O ports at 1090 [size=8]
Region 3: I/O ports at 10d0 [size=4]
Region 4: I/O ports at 1050 [size=16]
Region 5: I/O ports at 1040 [size=16]
Capabilities: [70] Power Management version 3
Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [b0] PCI Advanced Features
AFCap: TP+ FLR+
AFCtrl: FLR-
AFStatus: TP-
Kernel driver in use: ata_piix

3f:00.0 Host bridge: Intel Corporation Core Processor QuickPath
Architecture Generic Non-core Registers (rev 02)
Subsystem: Intel Corporation Device 8086
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0

3f:00.1 Host bridge: Intel Corporation Core Processor QuickPath
Architecture System Address Decoder (rev 02)
Subsystem: Intel Corporation Device 8086
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0

3f:02.0 Host bridge: Intel Corporation Core Processor QPI Link 0 (rev 02)
Subsystem: Intel Corporation Device 8086
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0

3f:02.1 Host bridge: Intel Corporation Core Processor QPI Physical 0 (rev 02)
Subsystem: Intel Corporation Device 8086
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0

3f:02.2 Host bridge: Intel Corporation Core Processor Reserved (rev 02)
Subsystem: Intel Corporation Device 8086
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0

3f:02.3 Host bridge: Intel Corporation Core Processor Reserved (rev 02)
Subsystem: Intel Corporation Device 8086
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0


[7.6]

Attached devices:
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: ATA      Model: ST9640320AS      Rev: 0001
  Type:   Direct-Access                    ANSI  SCSI revision: 05

[7.7]


[X.]
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1238891
