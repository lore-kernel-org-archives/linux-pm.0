From: Adrian Byszuk <adrian.byszuk@gmail.com>
Subject: PROBLEM: resuming from suspend-to-ram hangs
Date: Mon, 26 Nov 2012 18:14:25 +0100
Message-ID: <50B3A371.10101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:35461 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934000Ab2KZROa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 26 Nov 2012 12:14:30 -0500
Received: by mail-la0-f46.google.com with SMTP id p5so5997515lag.19
        for <linux-pm@vger.kernel.org>; Mon, 26 Nov 2012 09:14:27 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

Hello all-mighty linux kernel developers.

My laptop (Asus F3F-AP075) can't wake up from suspend to RAM, it seems
to hang completely while resuming. What seems to be a bit odd, is that
LED for HDD lights on all the time while the system is hanged.
To be more precise: s2ram used to work on this notebook, but it stopped
to. Some time ago I changed the HDD from typical 2.5' hard drive to an
OCZ Vertex4 SSD drive (and installed a new distribution on it) - I think
that's the moment it stopped working (however I'm not suspending often,
so it could also be a pure coincidence).
This problem is 100% reproducible on both Debian 3.2 kernel and vanilla
3.6.x kernels.

Following the Documentation/power/s2ram.txt I've got something like this
from dmesg:
[    0.253496]   Magic number: 0:56:890
[    0.253501]   hash matches drivers/base/power/main.c:571
[    0.253542] pci 0000:00:1f.3: hash matches

and PCI 00:1f.3 device is:
00:1f.3 SMBus: Intel Corporation N10/ICH 7 Family SMBus Controller (rev 02)

I'm willing to debug this by myself, but I need your help. Could someone
tell where to start looking?

Regards,
Adrian

#sh scripts/ver_linux:

Linux adrian-lap 3.6.7 #5 SMP PREEMPT Mon Nov 26 14:19:09 CET 2012
x86_64 GNU/Linux

Gnu C                  4.7
Gnu make               3.81
binutils               2.22
util-linux             ver_linux: line 23: fdformat: command not found
mount                  support
module-init-tools      found
Linux C Library        2.13
Dynamic linker (ldd)   2.13
Procps                 3.3.3
Kbd                    1.15.3
Sh-utils               8.13
Modules Loaded         ablk_helper cryptd aes_x86_64 aes_generic rfcomm
bnep pci_stub vboxpci vboxnetadp vboxnetflt binfmt_misc vboxdrv uinput
nfsd auth_rpcgss nfs_acl nfs lockd fscache sunrpc btusb bluetooth loop
firewire_sbp2 hid_generic usbhid hid stkwebcam videodev media joydev
arc4 8139too iTCO_wdt iTCO_vendor_support uhci_hcd iwl3945 iwlegacy
mac80211 lpc_ich snd_hda_codec_si3054 8139cp sdhci_pci mii sdhci
firewire_ohci firewire_core crc_itu_t mfd_core snd_hda_codec_idt
ehci_hcd mmc_core usbcore r592 memstick psmouse rng_core serio_raw
coretemp pcspkr i2c_i801 usb_common snd_hda_intel snd_hda_codec cfg80211
snd_hwdep snd_pcm snd_page_alloc snd_seq snd_seq_device snd_timer snd
soundcore battery ac asus_laptop sparse_keymap rfkill input_polldev
evdev acpi_cpufreq mperf processor ext4 crc16 jbd2 mbcache ata_generic
microcode i915 thermal video button i2c_algo_bit drm_kms_helper drm
i2c_core thermal_sys

# cat /proc/cpuinfo:
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 15
model name      : Intel(R) Core(TM)2 CPU         T5500  @ 1.66GHz
stepping        : 6
microcode       : 0xd1
cpu MHz         : 996.000
cache size      : 2048 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 2
apicid          : 0
initial apicid  : 0
fpu             : yes
fpu_exception   : yes
cpuid level     : 10
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
syscall nx lm constant_tsc arch_perfmon pebs bts rep_good nopl
aperfmperf pni dtes64 monitor ds_cpl est tm2 ssse3 cx16 xtpr pdcm
lahf_lm dtherm
bogomips        : 3324.92
clflush size    : 64
cache_alignment : 64
address sizes   : 36 bits physical, 48 bits virtual
power management:

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 15
model name      : Intel(R) Core(TM)2 CPU         T5500  @ 1.66GHz
stepping        : 6
microcode       : 0xd1
cpu MHz         : 996.000
cache size      : 2048 KB
physical id     : 0
siblings        : 2
core id         : 1
cpu cores       : 2
apicid          : 1
initial apicid  : 1
fpu             : yes
fpu_exception   : yes
cpuid level     : 10
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
syscall nx lm constant_tsc arch_perfmon pebs bts rep_good nopl
aperfmperf pni dtes64 monitor ds_cpl est tm2 ssse3 cx16 xtpr pdcm
lahf_lm dtherm
bogomips        : 3324.92
clflush size    : 64
cache_alignment : 64
address sizes   : 36 bits physical, 48 bits virtual
power management:

# cat /proc/modules:
ablk_helper 12572 0 - Live 0xffffffffa078e000
cryptd 14559 1 ablk_helper, Live 0xffffffffa0785000
aes_x86_64 16796 1 - Live 0xffffffffa077f000
aes_generic 37122 1 aes_x86_64, Live 0xffffffffa0774000
rfcomm 37038 14 - Live 0xffffffffa0769000
bnep 17345 2 - Live 0xffffffffa05d7000
pci_stub 12429 1 - Live 0xffffffffa04c1000
vboxpci 23040 0 - Live 0xffffffffa05d0000 (O)
vboxnetadp 25443 0 - Live 0xffffffffa05c8000 (O)
vboxnetflt 23221 0 - Live 0xffffffffa05c1000 (O)
binfmt_misc 16974 1 - Live 0xffffffffa075f000
vboxdrv 217495 3 vboxpci,vboxnetadp,vboxnetflt, Live 0xffffffffa058a000 (O)
uinput 17361 1 - Live 0xffffffffa0514000
nfsd 236550 2 - Live 0xffffffffa054f000
auth_rpcgss 37102 1 nfsd, Live 0xffffffffa0544000
nfs_acl 12511 1 nfsd, Live 0xffffffffa04bc000
nfs 122995 0 - Live 0xffffffffa051c000
lockd 70976 2 nfsd,nfs, Live 0xffffffffa0501000
fscache 40076 1 nfs, Live 0xffffffffa04f6000
sunrpc 189709 6 nfsd,auth_rpcgss,nfs_acl,nfs,lockd, Live 0xffffffffa04c6000
btusb 17300 0 - Live 0xffffffffa053e000
bluetooth 187463 24 rfcomm,bnep,btusb, Live 0xffffffffa048d000
loop 26516 0 - Live 0xffffffffa0481000
firewire_sbp2 21745 0 - Live 0xffffffffa0414000
hid_generic 12385 0 - Live 0xffffffffa046f000
usbhid 44452 0 - Live 0xffffffffa0475000
hid 93518 2 hid_generic,usbhid, Live 0xffffffffa0442000
stkwebcam 26790 0 - Live 0xffffffffa040c000
videodev 99739 1 stkwebcam, Live 0xffffffffa0428000
media 18109 1 videodev, Live 0xffffffffa03ee000
joydev 17108 0 - Live 0xffffffffa0406000
arc4 12536 2 - Live 0xffffffffa034c000
8139too 26327 0 - Live 0xffffffffa03fe000
iTCO_wdt 12831 0 - Live 0xffffffffa0307000
iTCO_vendor_support 12649 1 iTCO_wdt, Live 0xffffffffa02b1000
uhci_hcd 30814 0 - Live 0xffffffffa03f5000
iwl3945 54386 0 - Live 0xffffffffa03c6000
iwlegacy 54678 1 iwl3945, Live 0xffffffffa033d000
mac80211 423307 2 iwl3945,iwlegacy, Live 0xffffffffa035d000
lpc_ich 16665 0 - Live 0xffffffffa0281000
snd_hda_codec_si3054 12758 1 - Live 0xffffffffa0302000
8139cp 26423 0 - Live 0xffffffffa0351000
sdhci_pci 17754 0 - Live 0xffffffffa0333000
mii 12675 2 8139too,8139cp, Live 0xffffffffa02e3000
sdhci 30597 1 sdhci_pci, Live 0xffffffffa02f9000
firewire_ohci 35291 0 - Live 0xffffffffa02eb000
firewire_core 56645 2 firewire_sbp2,firewire_ohci, Live 0xffffffffa02d4000
crc_itu_t 12347 1 firewire_core, Live 0xffffffffa02ca000
mfd_core 12601 1 lpc_ich, Live 0xffffffffa02cf000
snd_hda_codec_idt 61647 1 - Live 0xffffffffa045e000
ehci_hcd 48637 0 - Live 0xffffffffa041b000
mmc_core 84816 2 sdhci_pci,sdhci, Live 0xffffffffa03d8000
usbcore 148405 5 btusb,usbhid,stkwebcam,uhci_hcd,ehci_hcd, Live
0xffffffffa030d000
r592 17323 0 - Live 0xffffffffa02a2000
memstick 13696 1 r592, Live 0xffffffffa028b000
psmouse 76669 0 - Live 0xffffffffa02b6000
rng_core 12614 0 - Live 0xffffffffa02ac000
serio_raw 12849 0 - Live 0xffffffffa029d000
coretemp 12854 0 - Live 0xffffffffa0294000
pcspkr 12595 0 - Live 0xffffffffa0250000
i2c_i801 16963 0 - Live 0xffffffffa0255000
usb_common 12354 1 usbcore, Live 0xffffffffa01ea000
snd_hda_intel 30388 3 - Live 0xffffffffa0278000
snd_hda_codec 99628 3
snd_hda_codec_si3054,snd_hda_codec_idt,snd_hda_intel, Live
0xffffffffa025e000
cfg80211 178277 3 iwl3945,iwlegacy,mac80211, Live 0xffffffffa0223000
snd_hwdep 13148 1 snd_hda_codec, Live 0xffffffffa01e5000
snd_pcm 75529 3 snd_hda_codec_si3054,snd_hda_intel,snd_hda_codec, Live
0xffffffffa020f000
snd_page_alloc 17065 2 snd_hda_intel,snd_pcm, Live 0xffffffffa0205000
snd_seq 52897 0 - Live 0xffffffffa01f7000
snd_seq_device 13132 1 snd_seq, Live 0xffffffffa01bd000
snd_timer 26605 2 snd_pcm,snd_seq, Live 0xffffffffa01ef000
snd 60877 15
snd_hda_codec_si3054,snd_hda_codec_idt,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_seq,snd_seq_device,snd_timer,
Live 0xffffffffa01d5000
soundcore 13026 1 snd, Live 0xffffffffa01cc000
battery 13109 0 - Live 0xffffffffa01c7000
ac 12624 0 - Live 0xffffffffa01c2000
asus_laptop 22742 0 - Live 0xffffffffa01b6000
sparse_keymap 12760 1 asus_laptop, Live 0xffffffffa00f5000
rfkill 18902 5 bluetooth,cfg80211,asus_laptop, Live 0xffffffffa01b0000
input_polldev 12906 1 asus_laptop, Live 0xffffffffa01a2000
evdev 17406 20 - Live 0xffffffffa0198000
acpi_cpufreq 12893 0 - Live 0xffffffffa018f000
mperf 12411 1 acpi_cpufreq, Live 0xffffffffa01ab000
processor 28098 3 acpi_cpufreq, Live 0xffffffffa00ed000
ext4 434100 3 - Live 0xffffffffa0124000
crc16 12343 2 bluetooth,ext4, Live 0xffffffffa00fb000
jbd2 82043 1 ext4, Live 0xffffffffa010e000
mbcache 12985 1 ext4, Live 0xffffffffa00e8000
ata_generic 12490 0 - Live 0xffffffffa0109000
microcode 17625 0 - Live 0xffffffffa005c000
i915 487264 3 - Live 0xffffffffa0070000
thermal 17383 0 - Live 0xffffffffa0103000
video 17630 1 i915, Live 0xffffffffa0056000
button 12930 1 i915, Live 0xffffffffa0012000
i2c_algo_bit 12751 1 i915, Live 0xffffffffa004e000
drm_kms_helper 35294 1 i915, Live 0xffffffffa0066000
drm 217040 4 i915,drm_kms_helper, Live 0xffffffffa0018000
i2c_core 23855 6 videodev,i2c_i801,i915,i2c_algo_bit,drm_kms_helper,drm,
Live 0xffffffffa000b000
thermal_sys 22203 3 processor,thermal,video, Live 0xffffffffa0000000

# cat /proc/ioports:
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
  0170-0177 : 0000:00:1f.2
    0170-0177 : ata_piix
  01f0-01f7 : 0000:00:1f.2
    01f0-01f7 : ata_piix
  0250-0253 : pnp 00:0a
  0256-025f : pnp 00:0a
  0376-0376 : 0000:00:1f.2
    0376-0376 : ata_piix
  03c0-03df : vga+
  03f6-03f6 : 0000:00:1f.2
    03f6-03f6 : ata_piix
  0400-041f : 0000:00:1f.3
  0480-04bf : pnp 00:08
  04d0-04d1 : pnp 00:08
  0800-087f : pnp 00:08
    0800-0803 : ACPI PM1a_EVT_BLK
    0804-0805 : ACPI PM1a_CNT_BLK
    0808-080b : ACPI PM_TMR
    0810-0815 : ACPI CPU throttle
    0820-0820 : ACPI PM2_CNT_BLK
    0828-082f : ACPI GPE0_BLK
    0830-0833 : iTCO_wdt
      0830-0833 : iTCO_wdt
    0860-087f : iTCO_wdt
      0860-087f : iTCO_wdt
0cf8-0cff : PCI conf1
0d00-ffff : PCI Bus 0000:00
  1000-1fff : PCI Bus 0000:01
  2000-2fff : PCI Bus 0000:02
  c000-cfff : PCI Bus 0000:03
  d000-dfff : PCI Bus 0000:05
    d800-d8ff : 0000:05:00.0
      d800-d8ff : 8139too
  e400-e41f : 0000:00:1d.3
    e400-e41f : uhci_hcd
  e480-e49f : 0000:00:1d.2
    e480-e49f : uhci_hcd
  e800-e81f : 0000:00:1d.1
    e800-e81f : uhci_hcd
  e880-e89f : 0000:00:1d.0
    e880-e89f : uhci_hcd
  ec00-ec07 : 0000:00:02.0
  ffa0-ffaf : 0000:00:1f.2
    ffa0-ffaf : ata_piix

# cat /proc/iomem
00000000-0000ffff : reserved
00010000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : PCI Bus 0000:00
000c0000-000c7fff : Video ROM
000d0000-000dffff : PCI Bus 0000:00
000e0000-000fffff : reserved
  000f0000-000fffff : System ROM
00100000-b77affff : System RAM
  01000000-01441d42 : Kernel code
  01441d43-01888b7f : Kernel data
  0191d000-019eafff : Kernel bss
b77b0000-b77bdfff : ACPI Tables
b77be000-b77fffff : ACPI Non-volatile Storage
b7800000-ffffffff : PCI Bus 0000:00
  b7800000-b79fffff : PCI Bus 0000:01
  b7a00000-b7bfffff : PCI Bus 0000:01
  b7c00000-b7dfffff : PCI Bus 0000:02
  bdf00000-bfefffff : PCI Bus 0000:03
  d0000000-dfffffff : 0000:00:02.0
  e0000000-e3ffffff : PCI MMCONFIG 0000 [bus 00-3f]
    e0000000-e3ffffff : pnp 00:0b
  fdf00000-fdffffff : PCI Bus 0000:02
    fdfff000-fdffffff : 0000:02:00.0
      fdfff000-fdffffff : iwl3945
  fe000000-fe7fffff : PCI Bus 0000:03
  fe800000-fe8fffff : PCI Bus 0000:05
    fe8fe800-fe8fe8ff : 0000:05:01.3
      fe8fe800-fe8fe8ff : r592
    fe8fec00-fe8fecff : 0000:05:01.2
      fe8fec00-fe8fecff : mmc1
    fe8ff000-fe8ff7ff : 0000:05:01.0
      fe8ff000-fe8ff7ff : firewire_ohci
    fe8ff800-fe8ff8ff : 0000:05:01.1
      fe8ff800-fe8ff8ff : mmc0
    fe8ffc00-fe8ffcff : 0000:05:00.0
      fe8ffc00-fe8ffcff : 8139too
  fea80000-feafffff : 0000:00:02.1
  feb3bc00-feb3bfff : 0000:00:1d.7
    feb3bc00-feb3bfff : ehci_hcd
  feb3c000-feb3ffff : 0000:00:1b.0
    feb3c000-feb3ffff : ICH HD audio
  feb40000-feb7ffff : 0000:00:02.0
  feb80000-febfffff : 0000:00:02.0
  fec00000-fec003ff : IOAPIC 0
  fec10000-fec17fff : pnp 00:0a
  fec18000-fec1ffff : pnp 00:0a
  fec20000-fec27fff : pnp 00:0a
  fed00000-fed003ff : HPET 0
  fed13000-fed19fff : pnp 00:01
  fed1c000-fed1ffff : pnp 00:08
    fed1f410-fed1f414 : iTCO_wdt
      fed1f410-fed1f414 : iTCO_wdt
  fed20000-fed3ffff : pnp 00:08
  fed45000-fed89fff : pnp 00:08
  fee00000-fee00fff : Local APIC
    fee00000-fee00fff : reserved
      fee00000-fee00fff : pnp 00:0a
  ffb80000-ffffffff : reserved
    fff00000-ffffffff : pnp 00:08

# lspci -vvv:
00:00.0 Host bridge: Intel Corporation Mobile 945GM/PM/GMS, 943/940GML
and 945GT Express Memory Controller Hub (rev 03)
        Subsystem: ASUSTeK Computer Inc. Device 1317
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ >SERR- <PERR- INTx-
        Latency: 0
        Capabilities: [e0] Vendor Specific Information: Len=09 <?>
        Kernel driver in use: agpgart-intel

00:02.0 VGA compatible controller: Intel Corporation Mobile 945GM/GMS,
943/940GML Express Integrated Graphics Controller (rev 03) (prog-if 00
[VGA controller])
        Subsystem: ASUSTeK Computer Inc. Device 1252
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at feb80000 (32-bit, non-prefetchable) [size=512K]
        Region 1: I/O ports at ec00 [size=8]
        Region 2: Memory at d0000000 (32-bit, prefetchable) [size=256M]
        Region 3: Memory at feb40000 (32-bit, non-prefetchable) [size=256K]
        Expansion ROM at <unassigned> [disabled]
        Capabilities: [90] MSI: Enable- Count=1/1 Maskable- 64bit-
                Address: 00000000  Data: 0000
        Capabilities: [d0] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Kernel driver in use: i915

00:02.1 Display controller: Intel Corporation Mobile 945GM/GMS/GME,
943/940GML Express Integrated Graphics Controller (rev 03)
        Subsystem: ASUSTeK Computer Inc. Device 1252
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Region 0: Memory at fea80000 (32-bit, non-prefetchable) [size=512K]
        Capabilities: [d0] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-

00:1b.0 Audio device: Intel Corporation N10/ICH 7 Family High Definition
Audio Controller (rev 02)
        Subsystem: ASUSTeK Computer Inc. Device 1253
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 43
        Region 0: Memory at feb3c000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
                Address: 00000000fee0300c  Data: 41c1
        Capabilities: [70] Express (v1) Root Complex Integrated
Endpoint, MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s
<64ns, L1 <1us
                        ExtTag- RBE- FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+
TransPend-
                LnkCap: Port #0, Speed unknown, Width x0, ASPM unknown,
Latency L0 <64ns, L1 <1us
                        ClockPM- Surprise- LLActRep- BwNot-
                LnkCtl: ASPM Disabled; Disabled- Retrain- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed unknown, Width x0, TrErr- Train- SlotClk-
DLActive- BWMgmt- ABWMgmt-
        Capabilities: [100 v1] Virtual Channel
                Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
                Arb:    Fixed- WRR32- WRR64- WRR128-
                Ctrl:   ArbSelect=Fixed
                Status: InProgress-
                VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                        Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128-
WRR256-
                        Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=01
                        Status: NegoPending- InProgress-
                VC1:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                        Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128-
WRR256-
                        Ctrl:   Enable+ ID=1 ArbSelect=Fixed TC/VC=80
                        Status: NegoPending- InProgress-
        Capabilities: [130 v1] Root Complex Link
                Desc:   PortNumber=0f ComponentID=02 EltType=Config
                Link0:  Desc:   TargetPort=00 TargetComponent=02
AssocRCRB- LinkType=MemMapped LinkValid+
                        Addr:   00000000fed1c000
        Kernel driver in use: snd_hda_intel

00:1c.0 PCI bridge: Intel Corporation N10/ICH 7 Family PCI Express Port
1 (rev 02) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 32 bytes
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 00001000-00001fff
        Memory behind bridge: b7800000-b79fffff
        Prefetchable memory behind bridge: 00000000b7a00000-00000000b7bfffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s
unlimited, L1 unlimited
                        ExtTag- RBE- FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+
TransPend-
                LnkCap: Port #1, Speed 2.5GT/s, Width x1, ASPM L0s L1,
Latency L0 <1us, L1 <4us
                        ClockPM- Surprise- LLActRep+ BwNot-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled+ Retrain-
CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+
DLActive- BWMgmt- ABWMgmt-
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+
Surprise+
                        Slot #2, PowerLimit 10.000W; Interlock- NoCompl-
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt-
HPIrq- LinkChg-
                        Control: AttnInd Unknown, PwrInd Unknown, Power-
Interlock-
                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt-
PresDet- Interlock-
                        Changed: MRL- PresDet- LinkState-
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal-
PMEIntEna- CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
        Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
                Address: fee0300c  Data: 4191
        Capabilities: [90] Subsystem: ASUSTeK Computer Inc. Device 1317
        Capabilities: [a0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D3 NoSoftRst- PME-Enable+ DSel=0 DScale=0 PME-
        Capabilities: [100 v1] Virtual Channel
                Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
                Arb:    Fixed+ WRR32- WRR64- WRR128-
                Ctrl:   ArbSelect=Fixed
                Status: InProgress-
                VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                        Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128-
WRR256-
                        Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=01
                        Status: NegoPending- InProgress-
                VC1:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                        Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128-
WRR256-
                        Ctrl:   Enable- ID=0 ArbSelect=Fixed TC/VC=00
                        Status: NegoPending- InProgress-
        Capabilities: [180 v1] Root Complex Link
                Desc:   PortNumber=01 ComponentID=02 EltType=Config
                Link0:  Desc:   TargetPort=00 TargetComponent=02
AssocRCRB- LinkType=MemMapped LinkValid+
                        Addr:   00000000fed1c001
        Kernel driver in use: pcieport

00:1c.1 PCI bridge: Intel Corporation N10/ICH 7 Family PCI Express Port
2 (rev 02) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 32 bytes
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
        I/O behind bridge: 00002000-00002fff
        Memory behind bridge: fdf00000-fdffffff
        Prefetchable memory behind bridge: 00000000b7c00000-00000000b7dfffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s
unlimited, L1 unlimited
                        ExtTag- RBE- FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+
TransPend-
                LnkCap: Port #2, Speed 2.5GT/s, Width x1, ASPM L0s L1,
Latency L0 <256ns, L1 <4us
                        ClockPM- Surprise- LLActRep+ BwNot-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain-
CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
DLActive+ BWMgmt- ABWMgmt-
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+
Surprise+
                        Slot #3, PowerLimit 10.000W; Interlock- NoCompl-
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt-
HPIrq- LinkChg-
                        Control: AttnInd Unknown, PwrInd Unknown, Power-
Interlock-
                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt-
PresDet+ Interlock-
                        Changed: MRL- PresDet- LinkState+
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal-
PMEIntEna- CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
        Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
                Address: fee0300c  Data: 41a1
        Capabilities: [90] Subsystem: ASUSTeK Computer Inc. Device 1317
        Capabilities: [a0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [100 v1] Virtual Channel
                Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
                Arb:    Fixed+ WRR32- WRR64- WRR128-
                Ctrl:   ArbSelect=Fixed
                Status: InProgress-
                VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                        Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128-
WRR256-
                        Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=01
                        Status: NegoPending- InProgress-
                VC1:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                        Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128-
WRR256-
                        Ctrl:   Enable- ID=0 ArbSelect=Fixed TC/VC=00
                        Status: NegoPending- InProgress-
        Capabilities: [180 v1] Root Complex Link
                Desc:   PortNumber=02 ComponentID=02 EltType=Config
                Link0:  Desc:   TargetPort=00 TargetComponent=02
AssocRCRB- LinkType=MemMapped LinkValid+
                        Addr:   00000000fed1c001
        Kernel driver in use: pcieport

00:1c.2 PCI bridge: Intel Corporation N10/ICH 7 Family PCI Express Port
3 (rev 02) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 32 bytes
        Bus: primary=00, secondary=03, subordinate=04, sec-latency=0
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: fe000000-fe7fffff
        Prefetchable memory behind bridge: 00000000bdf00000-00000000bfefffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s
unlimited, L1 unlimited
                        ExtTag- RBE- FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+
TransPend-
                LnkCap: Port #3, Speed 2.5GT/s, Width x1, ASPM L0s L1,
Latency L0 <256ns, L1 <4us
                        ClockPM- Surprise- LLActRep+ BwNot-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain-
CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+
DLActive- BWMgmt- ABWMgmt-
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+
Surprise+
                        Slot #4, PowerLimit 10.000W; Interlock- NoCompl-
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt-
HPIrq- LinkChg-
                        Control: AttnInd Unknown, PwrInd Unknown, Power-
Interlock-
                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt-
PresDet- Interlock-
                        Changed: MRL- PresDet- LinkState-
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal-
PMEIntEna- CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
        Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
                Address: fee0300c  Data: 41b1
        Capabilities: [90] Subsystem: ASUSTeK Computer Inc. Device 1317
        Capabilities: [a0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D3 NoSoftRst- PME-Enable+ DSel=0 DScale=0 PME-
        Capabilities: [100 v1] Virtual Channel
                Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
                Arb:    Fixed+ WRR32- WRR64- WRR128-
                Ctrl:   ArbSelect=Fixed
                Status: InProgress-
                VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                        Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128-
WRR256-
                        Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=01
                        Status: NegoPending- InProgress-
                VC1:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                        Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128-
WRR256-
                        Ctrl:   Enable- ID=0 ArbSelect=Fixed TC/VC=00
                        Status: NegoPending- InProgress-
        Capabilities: [180 v1] Root Complex Link
                Desc:   PortNumber=03 ComponentID=02 EltType=Config
                Link0:  Desc:   TargetPort=00 TargetComponent=02
AssocRCRB- LinkType=MemMapped LinkValid+
                        Addr:   00000000fed1c001
        Kernel driver in use: pcieport

00:1d.0 USB controller: Intel Corporation N10/ICH 7 Family USB UHCI
Controller #1 (rev 02) (prog-if 00 [UHCI])
        Subsystem: ASUSTeK Computer Inc. Device 1317
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 23
        Region 4: I/O ports at e880 [size=32]
        Kernel driver in use: uhci_hcd

00:1d.1 USB controller: Intel Corporation N10/ICH 7 Family USB UHCI
Controller #2 (rev 02) (prog-if 00 [UHCI])
        Subsystem: ASUSTeK Computer Inc. Device 1317
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin B routed to IRQ 19
        Region 4: I/O ports at e800 [size=32]
        Kernel driver in use: uhci_hcd

00:1d.2 USB controller: Intel Corporation N10/ICH 7 Family USB UHCI
Controller #3 (rev 02) (prog-if 00 [UHCI])
        Subsystem: ASUSTeK Computer Inc. Device 1317
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin C routed to IRQ 18
        Region 4: I/O ports at e480 [size=32]
        Kernel driver in use: uhci_hcd

00:1d.3 USB controller: Intel Corporation N10/ICH 7 Family USB UHCI
Controller #4 (rev 02) (prog-if 00 [UHCI])
        Subsystem: ASUSTeK Computer Inc. Device 1317
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin D routed to IRQ 16
        Region 4: I/O ports at e400 [size=32]
        Kernel driver in use: uhci_hcd

00:1d.7 USB controller: Intel Corporation N10/ICH 7 Family USB2 EHCI
Controller (rev 02) (prog-if 20 [EHCI])
        Subsystem: ASUSTeK Computer Inc. Device 1317
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 23
        Region 0: Memory at feb3bc00 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] Debug port: BAR=1 offset=00a0
        Kernel driver in use: ehci_hcd

00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev e2)
(prog-if 01 [Subtractive decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Bus: primary=00, secondary=05, subordinate=05, sec-latency=32
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: fe800000-fe8fffff
        Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
        Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [50] Subsystem: ASUSTeK Computer Inc. Device 1317

00:1f.0 ISA bridge: Intel Corporation 82801GBM (ICH7-M) LPC Interface
Bridge (rev 02)
        Subsystem: ASUSTeK Computer Inc. Device 1317
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Capabilities: [e0] Vendor Specific Information: Len=0c <?>
        Kernel driver in use: lpc_ich

00:1f.2 IDE interface: Intel Corporation 82801GBM/GHM (ICH7-M Family)
SATA Controller [IDE mode] (rev 02) (prog-if 80 [Master])
        Subsystem: ASUSTeK Computer Inc. Device 1317
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx+
        Latency: 0
        Interrupt: pin B routed to IRQ 19
        Region 0: I/O ports at 01f0 [size=8]
        Region 1: I/O ports at 03f4 [size=1]
        Region 2: I/O ports at 0170 [size=8]
        Region 3: I/O ports at 0374 [size=1]
        Region 4: I/O ports at ffa0 [size=16]
        Capabilities: [70] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot+,D3cold-)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Kernel driver in use: ata_piix

00:1f.3 SMBus: Intel Corporation N10/ICH 7 Family SMBus Controller (rev 02)
        Subsystem: ASUSTeK Computer Inc. Device 1317
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Interrupt: pin B routed to IRQ 19
        Region 4: I/O ports at 0400 [size=32]

02:00.0 Network controller: Intel Corporation PRO/Wireless 3945ABG
[Golan] Network Connection (rev 02)
        Subsystem: Intel Corporation PRO/Wireless 3945ABG Network Connection
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 44
        Region 0: Memory at fdfff000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [c8] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
                Address: 00000000fee0300c  Data: 41d1
        Capabilities: [e0] Express (v1) Legacy Endpoint, MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s
<512ns, L1 unlimited
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr- UncorrErr+ FatalErr- UnsuppReq+ AuxPwr+
TransPend-
                LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1,
Latency L0 <128ns, L1 <64us
                        ClockPM+ Surprise- LLActRep- BwNot-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain-
CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
DLActive- BWMgmt- ABWMgmt-
        Capabilities: [100 v1] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt-
UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
NonFatalErr-
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
NonFatalErr-
                AERCap: First Error Pointer: 14, GenCap- CGenEn- ChkCap-
ChkEn-
        Capabilities: [140 v1] Device Serial Number 00-18-de-ff-ff-c8-c4-c6
        Kernel driver in use: iwl3945

05:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
        Subsystem: ASUSTeK Computer Inc. L8400B or L3C/S notebook
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 64 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at d800 [size=256]
        Region 1: Memory at fe8ffc00 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0-,D1+,D2+,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Kernel driver in use: 8139too

05:01.0 FireWire (IEEE 1394): Ricoh Co Ltd R5C832 IEEE 1394 Controller
(prog-if 10 [OHCI])
        Subsystem: ASUSTeK Computer Inc. Device 1317
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 32 (500ns min, 1000ns max)
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at fe8ff000 (32-bit, non-prefetchable) [size=2K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=2 PME+
        Kernel driver in use: firewire_ohci

05:01.1 SD Host controller: Ricoh Co Ltd R5C822 SD/SDIO/MMC/MS/MSPro
Host Adapter (rev 19)
        Subsystem: ASUSTeK Computer Inc. Device 1317
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 64
        Interrupt: pin B routed to IRQ 17
        Region 0: Memory at fe8ff800 (32-bit, non-prefetchable) [size=256]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=2 PME-
        Kernel driver in use: sdhci-pci

05:01.2 System peripheral: Ricoh Co Ltd R5C843 MMC Host Controller (rev 01)
        Subsystem: ASUSTeK Computer Inc. Device 1317
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin B routed to IRQ 17
        Region 0: Memory at fe8fec00 (32-bit, non-prefetchable) [size=256]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=2 PME-
        Kernel driver in use: sdhci-pci

05:01.3 System peripheral: Ricoh Co Ltd R5C592 Memory Stick Bus Host
Adapter (rev 0a)
        Subsystem: ASUSTeK Computer Inc. Device 1317
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Interrupt: pin B routed to IRQ 17
        Region 0: Memory at fe8fe800 (32-bit, non-prefetchable) [size=256]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=2 PME-
        Kernel driver in use: r592
