From: Jan Schmidt <ja.schm@gmail.com>
Subject: [1.] Suspend and Fn keys works only once
Date: Wed, 23 Jan 2013 22:58:13 +0100
Message-ID: <4401236.3qxTrlqV4d@kk-r950-117>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ee0-f42.google.com ([74.125.83.42]:46457 "EHLO
	mail-ee0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751345Ab3AWV6T (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 23 Jan 2013 16:58:19 -0500
Received: by mail-ee0-f42.google.com with SMTP id b47so4220759eek.15
        for <linux-pm@vger.kernel.org>; Wed, 23 Jan 2013 13:58:17 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: 1101897@bugs.launchpad.net

[2.] After first resume, next suspend don't work. System freeze and I need to 
push power button for hard turn off my computer.
After first resume, Fn keys for suspend, mute and brightness don`t work. 
However, the volume up/down Fn keys continue to work. This is with 12.10 
Quantal 64 bit installed on my Toshiba Tecra R950-117 with disabled EFI boot.
Kernel 3.3.8 from http://kernel.ubuntu.com/~kernel-ppa/mainline/v3.3.8-
quantoral/ suspend works corectly
Kernel 3.8 rc4 from http://kernel.ubuntu.com/~kernel-ppa/mainline/v3.8-rc4-
raring/ the problem persists
Ubuntu kernel 3.5.0-22-generic the problem persists
ProblemType: Bug
DistroRelease: Ubuntu 12.10
Package: linux-image-3.5.0-22-generic 3.5.0-22.34
ProcVersionSignature: Ubuntu 3.5.0-22.34-generic 3.5.7.2
Uname: Linux 3.5.0-22-generic x86_64
ApportVersion: 2.6.1-0ubuntu9
Architecture: amd64
AudioDevicesInUse:
 USER PID ACCESS COMMAND
 /dev/snd/controlC0: janschml 2950 F.... pulseaudio
Date: Sat Jan 19 21:28:54 2013
EcryptfsInUse: Yes
HibernationDevice: RESUME=UUID=30f5cea7-2ed3-4fc8-a0cf-fba7f54d8ef2
InstallationDate: Installed on 2012-09-20 (121 days ago)
InstallationMedia: Kubuntu 12.04.1 LTS "Precise Pangolin" - Release amd64 
(20120822.2)
MachineType: TOSHIBA TECRA R950
MarkForUpload: True
ProcEnviron:
 LANGUAGE=sk_SK.utf8
 TERM=xterm
 PATH=(custom, no user)
 LANG=sk_SK.UTF-8
 SHELL=/bin/bash
ProcFB: 0 inteldrmfb
ProcKernelCmdLine: BOOT_IMAGE=/boot/vmlinuz-3.5.0-22-generic 
root=UUID=a81c5873-29fe-4715-b4a0-2ca25650661d ro quiet splash acpi_osi=Linux 
acpi_backlight=vendor pcie_aspm=force i915.i915_enable_rc6=1 
i915.lvds_downclock=1 vt.handoff=7
RelatedPackageVersions:
 linux-restricted-modules-3.5.0-22-generic N/A
 linux-backports-modules-3.5.0-22-generic N/A
 linux-firmware 1.95
SourcePackage: linux
UpgradeStatus: Upgraded to quantal on 2012-10-18 (93 days ago)
dmi.bios.date: 10/01/2012
dmi.bios.vendor: TOSHIBA
dmi.bios.version: Version 6.40
dmi.board.asset.tag: 0000000000
dmi.board.name: TECRA R950
dmi.board.vendor: TOSHIBA
dmi.board.version: Version A0
dmi.chassis.asset.tag: 0000000000
dmi.chassis.type: 10
dmi.chassis.vendor: TOSHIBA
dmi.chassis.version: Version 1.0
dmi.modalias: 
dmi:bvnTOSHIBA:bvrVersion6.40:bd10/01/2012:svnTOSHIBA:pnTECRAR950:pvrPT534E-00F008CZ:rvnTOSHIBA:rnTECRAR950:rvrVersionA0:cvnTOSHIBA:ct10:cvrVersion1.0:
dmi.product.name: TECRA R950
dmi.product.version: PT534E-00F008CZ
dmi.sys.vendor: TOSHIBA

[3.] suspend resume

[4.] Linux version 3.8.0-030800rc4-generic (root@gomeisa) (gcc version 4.6.3 
(Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201301172335 SMP Fri Jan 18 04:35:51 UTC 
2013

[5.]
[6.]
[7.] Description:    Ubuntu 12.10
Release:        12.10

[7.1.]sh ver_linux 
 If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux KK-R950-117 3.8.0-030800rc4-generic #201301172335 SMP Fri Jan 18 
04:35:51 UTC 2013 x86_64 x86_64 x86_64 GNU/Linux
 
Gnu C                  4.7
Gnu make               3.81
binutils               2.22.90.20120924
util-linux             2.20.1
mount                  support
module-init-tools      3.16
e2fsprogs              1.42.5
pcmciautils            018
PPP                    2.4.5
Linux C Library        2.15
Dynamic linker (ldd)   2.15
Procps                 3.3.3
Net-tools              1.60
Kbd                    1.15.3
Sh-utils               8.13
wireless-tools         30
Modules Loaded         input_polldev parport_pc ppdev rfcomm bnep binfmt_misc 
dm_crypt joydev btusb arc4 bluetooth snd_hda_codec_hdmi coretemp 
snd_hda_codec_realtek iwldvm snd_hda_intel tpm_infineon snd_hda_codec mac80211 
snd_hwdep uvcvideo snd_pcm iwlwifi snd_seq_midi kvm_intel snd_rawmidi 
videobuf2_core videodev kvm snd_seq_midi_event snd_seq snd_timer 
videobuf2_vmalloc videobuf2_memops snd_seq_device mei cfg80211 mac_hid tpm_tis 
lp snd psmouse toshiba_acpi soundcore lpc_ich parport sparse_keymap 
snd_page_alloc serio_raw microcode toshiba_bluetooth wmi hid_generic 
ghash_clmulni_intel aesni_intel ablk_helper cryptd sdhci_pci lrw i915 sdhci 
aes_x86_64 xts gf128mul drm_kms_helper drm i2c_algo_bit video usbhid hid 
e1000e

[7.2.] cat /proc/cpuinfo 
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 58
model name      : Intel(R) Core(TM) i5-3320M CPU @ 2.60GHz
stepping        : 9
microcode       : 0x15
cpu MHz         : 1200.000
cache size      : 3072 KB
physical id     : 0
siblings        : 4
core id         : 0
cpu cores       : 2
apicid          : 0
initial apicid  : 0
fpu             : yes
fpu_exception   : yes
cpuid level     : 13
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm 
constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc 
aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 
cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave 
avx f16c rdrand lahf_lm ida arat epb xsaveopt pln pts dtherm tpr_shadow vnmi 
flexpriority ept vpid fsgsbase smep erms
bogomips        : 5188.39
clflush size    : 64
cache_alignment : 64
address sizes   : 36 bits physical, 48 bits virtual
power management:

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 58
model name      : Intel(R) Core(TM) i5-3320M CPU @ 2.60GHz
stepping        : 9
microcode       : 0x15
cpu MHz         : 1200.000
cache size      : 3072 KB
physical id     : 0
siblings        : 4
core id         : 0                                                                                                                                                                                                              
cpu cores       : 2                                                                                                                                                                                                              
apicid          : 1                                                                                                                                                                                                              
initial apicid  : 1                                                                                                                                                                                                              
fpu             : yes                                                                                                                                                                                                            
fpu_exception   : yes                                                                                                                                                                                                            
cpuid level     : 13                                                                                                                                                                                                             
wp              : yes                                                                                                                                                                                                            
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm 
constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc 
aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 
cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave 
avx f16c rdrand lahf_lm ida arat epb xsaveopt pln pts dtherm tpr_shadow vnmi 
flexpriority ept vpid fsgsbase smep erms                                                                                                                                                                             
bogomips        : 5188.39                                                                                                                                                                                                        
clflush size    : 64
cache_alignment : 64
address sizes   : 36 bits physical, 48 bits virtual
power management:

processor       : 2
vendor_id       : GenuineIntel
cpu family      : 6
model           : 58
model name      : Intel(R) Core(TM) i5-3320M CPU @ 2.60GHz
stepping        : 9
microcode       : 0x15
cpu MHz         : 1200.000
cache size      : 3072 KB
physical id     : 0
siblings        : 4
core id         : 1
cpu cores       : 2
apicid          : 2
initial apicid  : 2
fpu             : yes
fpu_exception   : yes
cpuid level     : 13
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm 
constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc 
aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 
cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave 
avx f16c rdrand lahf_lm ida arat epb xsaveopt pln pts dtherm tpr_shadow vnmi 
flexpriority ept vpid fsgsbase smep erms
bogomips        : 5188.39
clflush size    : 64
cache_alignment : 64
address sizes   : 36 bits physical, 48 bits virtual
power management:

processor       : 3
vendor_id       : GenuineIntel
cpu family      : 6
model           : 58
model name      : Intel(R) Core(TM) i5-3320M CPU @ 2.60GHz
stepping        : 9
microcode       : 0x15
cpu MHz         : 1200.000
cache size      : 3072 KB
physical id     : 0
siblings        : 4
core id         : 1
cpu cores       : 2
apicid          : 3
initial apicid  : 3
fpu             : yes
fpu_exception   : yes
cpuid level     : 13
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm 
constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc 
aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 
cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave 
avx f16c rdrand lahf_lm ida arat epb xsaveopt pln pts dtherm tpr_shadow vnmi 
flexpriority ept vpid fsgsbase smep erms
bogomips        : 5188.39
clflush size    : 64
cache_alignment : 64
address sizes   : 36 bits physical, 48 bits virtual
power management:

[7.3.]cat /proc/modules 
 input_polldev 13896 0 - Live 0x0000000000000000
parport_pc 32866 0 - Live 0x0000000000000000
ppdev 17113 0 - Live 0x0000000000000000
rfcomm 47864 16 - Live 0x0000000000000000
bnep 18258 2 - Live 0x0000000000000000
binfmt_misc 17540 1 - Live 0x0000000000000000
dm_crypt 23012 0 - Live 0x0000000000000000
joydev 17613 0 - Live 0x0000000000000000
btusb 18291 0 - Live 0x0000000000000000
arc4 12573 2 - Live 0x0000000000000000
bluetooth 246934 22 rfcomm,bnep,btusb, Live 0x0000000000000000
snd_hda_codec_hdmi 37223 1 - Live 0x0000000000000000
coretemp 13596 0 - Live 0x0000000000000000
snd_hda_codec_realtek 79916 1 - Live 0x0000000000000000
iwldvm 249055 0 - Live 0x0000000000000000
snd_hda_intel 44347 3 - Live 0x0000000000000000
tpm_infineon 17410 0 - Live 0x0000000000000000
snd_hda_codec 141461 3 snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_intel, 
Live 0x0000000000000000
mac80211 613116 1 iwldvm, Live 0x0000000000000000
snd_hwdep 17764 1 snd_hda_codec, Live 0x0000000000000000
uvcvideo 82214 0 - Live 0x0000000000000000
snd_pcm 102477 3 snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec, Live 
0x0000000000000000
iwlwifi 183399 1 iwldvm, Live 0x0000000000000000
snd_seq_midi 13324 0 - Live 0x0000000000000000
kvm_intel 137899 0 - Live 0x0000000000000000
snd_rawmidi 30749 1 snd_seq_midi, Live 0x0000000000000000
videobuf2_core 40785 1 uvcvideo, Live 0x0000000000000000
videodev 130053 2 uvcvideo,videobuf2_core, Live 0x0000000000000000
kvm 451836 1 kvm_intel, Live 0x0000000000000000
snd_seq_midi_event 14899 1 snd_seq_midi, Live 0x0000000000000000
snd_seq 61930 2 snd_seq_midi,snd_seq_midi_event, Live 0x0000000000000000
snd_timer 29989 2 snd_pcm,snd_seq, Live 0x0000000000000000
videobuf2_vmalloc 13056 1 uvcvideo, Live 0x0000000000000000
videobuf2_memops 13202 1 videobuf2_vmalloc, Live 0x0000000000000000
snd_seq_device 14497 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 
0x0000000000000000
mei 41820 0 - Live 0x0000000000000000
cfg80211 525244 3 iwldvm,mac80211,iwlwifi, Live 0x0000000000000000
mac_hid 13253 0 - Live 0x0000000000000000
tpm_tis 18761 0 - Live 0x0000000000000000
lp 17799 0 - Live 0x0000000000000000
snd 83673 16 
snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_rawmidi,snd_seq,snd_timer,snd_seq_device, 
Live 0x0000000000000000
psmouse 92375 0 - Live 0x0000000000000000
toshiba_acpi 18774 0 - Live 0x0000000000000000
soundcore 15091 1 snd, Live 0x0000000000000000
lpc_ich 17144 0 - Live 0x0000000000000000
parport 46562 3 parport_pc,ppdev,lp, Live 0x0000000000000000
sparse_keymap 13890 1 toshiba_acpi, Live 0x0000000000000000
snd_page_alloc 18798 2 snd_hda_intel,snd_pcm, Live 0x0000000000000000
serio_raw 13215 0 - Live 0x0000000000000000
microcode 23017 0 - Live 0x0000000000000000
toshiba_bluetooth 12852 0 - Live 0x0000000000000000
wmi 19256 1 toshiba_acpi, Live 0x0000000000000000
hid_generic 12540 0 - Live 0x0000000000000000
ghash_clmulni_intel 13259 0 - Live 0x0000000000000000
aesni_intel 55495 2 - Live 0x0000000000000000
ablk_helper 13597 1 aesni_intel, Live 0x0000000000000000
cryptd 20501 3 ghash_clmulni_intel,aesni_intel,ablk_helper, Live 
0x0000000000000000
sdhci_pci 18721 0 - Live 0x0000000000000000
lrw 13294 1 aesni_intel, Live 0x0000000000000000
i915 616209 2 - Live 0x0000000000000000
sdhci 33141 1 sdhci_pci, Live 0x0000000000000000
aes_x86_64 17255 1 aesni_intel, Live 0x0000000000000000
xts 12922 1 aesni_intel, Live 0x0000000000000000
gf128mul 14951 2 lrw,xts, Live 0x0000000000000000
drm_kms_helper 49597 1 i915, Live 0x0000000000000000
drm 286915 3 i915,drm_kms_helper, Live 0x0000000000000000
i2c_algo_bit 13564 1 i915, Live 0x0000000000000000
video 19467 1 i915, Live 0x0000000000000000
usbhid 47346 0 - Live 0x0000000000000000
hid 101262 2 hid_generic,usbhid, Live 0x0000000000000000
e1000e 202150 0 - Live 0x0000000000000000

[7.4.] cat /proc/ioports 
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
  01e0-01e7 : pnp 00:06
  0400-047f : pnp 00:05
    0400-0403 : ACPI PM1a_EVT_BLK
    0404-0405 : ACPI PM1a_CNT_BLK
    0408-040b : ACPI PM_TMR
    0410-0415 : ACPI CPU throttle
    0420-042f : ACPI GPE0_BLK
    0430-0433 : iTCO_wdt
    0450-0450 : ACPI PM2_CNT_BLK
    0460-047f : iTCO_wdt
  0500-053f : pnp 00:05
  0680-06ff : pnp 00:06
0cf8-0cff : PCI conf1
0d00-ffff : PCI Bus 0000:00
  1100-110f : pnp 00:05
  1110-1113 : pnp 00:05
  2000-2fff : PCI Bus 0000:02
  3000-303f : 0000:00:02.0
  3060-307f : 0000:00:1f.2
    3060-307f : ahci
  3080-309f : 0000:00:19.0
  30a0-30a7 : 0000:00:1f.2
    30a0-30a7 : ahci
  30a8-30af : 0000:00:1f.2
    30a8-30af : ahci
  30b0-30b3 : 0000:00:1f.2
    30b0-30b3 : ahci
  30b4-30b7 : 0000:00:1f.2
    30b4-30b7 : ahci
  4000-4fff : PCI Bus 0000:05
  ffff-ffff : pnp 00:05


cat /proc/iomem 
00000000-0000ffff : reserved
00010000-0009ebff : System RAM
0009ec00-0009ffff : reserved
000a0000-000bffff : PCI Bus 0000:00
000c0000-000cedff : Video ROM
000cf000-000cffff : Adapter ROM
000d0000-000d3fff : PCI Bus 0000:00
000d4000-000d7fff : PCI Bus 0000:00
000d8000-000dbfff : PCI Bus 0000:00
000dc000-000dffff : PCI Bus 0000:00
000e0000-000fffff : reserved
  000f0000-000fffff : System ROM
00100000-1fffffff : System RAM
  01000000-016f8150 : Kernel code
  016f8151-01cee73f : Kernel data
  01df3000-01f49fff : Kernel bss
20000000-201fffff : reserved
  20000000-201fffff : pnp 00:0a
20200000-40003fff : System RAM
40004000-40004fff : reserved
  40004000-40004fff : pnp 00:0a
40005000-ca28efff : System RAM
ca28f000-ca28ffff : ACPI Non-volatile Storage
ca290000-ca292fff : reserved
ca293000-ca38efff : ACPI Non-volatile Storage
ca38f000-ca3aefff : ACPI Tables
ca3af000-cf9fffff : reserved
cfa00000-feafffff : PCI Bus 0000:00
  cfa00000-cfa00fff : pnp 00:00
  cfb00000-cfcfffff : PCI Bus 0000:05
  d0000000-dfffffff : 0000:00:02.0
  e0000000-e03fffff : 0000:00:02.0
  e0400000-e23fffff : PCI Bus 0000:02
  e2400000-e24fffff : PCI Bus 0000:05
  e2500000-e25fffff : PCI Bus 0000:04
    e2500000-e2501fff : 0000:04:00.0
      e2500000-e2501fff : iwlwifi
  e2600000-e45fffff : PCI Bus 0000:02
  e4600000-e46fffff : PCI Bus 0000:01
    e4601000-e46010ff : 0000:01:00.1
    e4602000-e46020ff : 0000:01:00.0
      e4602000-e46020ff : mmc0
  e4700000-e471ffff : 0000:00:19.0
    e4700000-e471ffff : e1000e
  e4720000-e472ffff : 0000:00:14.0
    e4720000-e472ffff : xhci_hcd
  e4730000-e4733fff : 0000:00:1b.0
    e4730000-e4733fff : ICH HD audio
  e4734000-e473400f : 0000:00:16.0
    e4734000-e473400f : mei
  e4738000-e47387ff : 0000:00:1f.2
    e4738000-e47387ff : ahci
  e4739000-e47393ff : 0000:00:1d.0
    e4739000-e47393ff : ehci_hcd
  e473a000-e473a3ff : 0000:00:1a.0
    e473a000-e473a3ff : ehci_hcd
  e473b000-e473bfff : 0000:00:19.0
    e473b000-e473bfff : e1000e
  f8000000-fbffffff : PCI MMCONFIG 0000 [bus 00-3f]
    f8000000-fbffffff : reserved
      f8000000-fbffffff : pnp 00:00
fec00000-fec00fff : reserved
  fec00000-fec003ff : IOAPIC 0
fed00000-fed003ff : HPET 0
  fed00000-fed003ff : pnp 00:03
fed10000-fed19fff : reserved
  fed10000-fed17fff : pnp 00:00
  fed18000-fed18fff : pnp 00:00
  fed19000-fed19fff : pnp 00:00
fed1c000-fed1ffff : reserved
  fed1c000-fed1ffff : pnp 00:00
    fed1f410-fed1f414 : iTCO_wdt
fed20000-fed3ffff : pnp 00:00
fed45000-fed8ffff : pnp 00:00
fed90000-fed91fff : pnp 00:00
fee00000-fee00fff : Local APIC
  fee00000-fee00fff : reserved
ffc00000-ffffffff : reserved
100000000-22f5fffff : System RAM
22f600000-22fffffff : RAM buffer
[7.5.] sudo lspci -vvv 
[sudo] password for janschml: 
00:00.0 Host bridge: Intel Corporation 3rd Gen Core processor DRAM Controller 
(rev 09)
        Subsystem: Toshiba America Info Systems Device 0001
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR- INTx-
        Latency: 0
        Capabilities: [e0] Vendor Specific Information: Len=0c <?>

00:02.0 VGA compatible controller: Intel Corporation 3rd Gen Core processor 
Graphics Controller (rev 09) (prog-if 00 [VGA controller])
        Subsystem: Toshiba America Info Systems Device 0001
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 43
        Region 0: Memory at e0000000 (64-bit, non-prefetchable) [size=4M]
        Region 2: Memory at d0000000 (64-bit, prefetchable) [size=256M]
        Region 4: I/O ports at 3000 [size=64]
        Expansion ROM at <unassigned> [disabled]
        Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
                Address: fee0f00c  Data: 41d1
        Capabilities: [d0] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [a4] PCI Advanced Features
                AFCap: TP+ FLR+
                AFCtrl: FLR-
                AFStatus: TP-
        Kernel driver in use: i915
        Kernel modules: i915

00:14.0 USB controller: Intel Corporation 7 Series/C210 Series Chipset Family 
USB xHCI Host Controller (rev 04) (prog-if 30 [XHCI])
        Subsystem: Toshiba America Info Systems Device 0001
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 41
        Region 0: Memory at e4720000 (64-bit, non-prefetchable) [size=64K]
        Capabilities: [70] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [80] MSI: Enable+ Count=1/8 Maskable- 64bit+
                Address: 00000000fee0c00c  Data: 41a1
        Kernel driver in use: xhci_hcd

00:16.0 Communication controller: Intel Corporation 7 Series/C210 Series 
Chipset Family MEI Controller #1 (rev 04)
        Subsystem: Toshiba America Info Systems Device 0001
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 44
        Region 0: Memory at e4734000 (64-bit, non-prefetchable) [size=16]
        Capabilities: [50] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [8c] MSI: Enable+ Count=1/1 Maskable- 64bit+
                Address: 00000000fee0f00c  Data: 41e1
        Kernel driver in use: mei
        Kernel modules: mei

00:19.0 Ethernet controller: Intel Corporation 82579V Gigabit Network 
Connection (rev 04)
        Subsystem: Toshiba America Info Systems Device 0002
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 42
        Region 0: Memory at e4700000 (32-bit, non-prefetchable) [size=128K]
        Region 1: Memory at e473b000 (32-bit, non-prefetchable) [size=4K]
        Region 2: I/O ports at 3080 [size=32]
        Capabilities: [c8] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
                Address: 00000000fee0100c  Data: 4172
        Capabilities: [e0] PCI Advanced Features
                AFCap: TP+ FLR+
                AFCtrl: FLR-
                AFStatus: TP-
        Kernel driver in use: e1000e
        Kernel modules: e1000e

00:1a.0 USB controller: Intel Corporation 7 Series/C210 Series Chipset Family 
USB Enhanced Host Controller #2 (rev 04) (prog-if 20 [EHCI])
        Subsystem: Toshiba America Info Systems Device 0001
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at e473a000 (32-bit, non-prefetchable) [size=1K]
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

00:1b.0 Audio device: Intel Corporation 7 Series/C210 Series Chipset Family 
High Definition Audio Controller (rev 04)
        Subsystem: Toshiba America Info Systems Device 0001
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 46
        Region 0: Memory at e4730000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
                Address: 00000000fee0f00c  Data: 4152
        Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI 
00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, 
L1 <1us
                        ExtTag- RBE- FLReset+
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
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
                        Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
                        Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=01
                        Status: NegoPending- InProgress-
                VC1:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                        Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
                        Ctrl:   Enable+ ID=1 ArbSelect=Fixed TC/VC=22
                        Status: NegoPending- InProgress-
        Capabilities: [130 v1] Root Complex Link
                Desc:   PortNumber=0f ComponentID=00 EltType=Config
                Link0:  Desc:   TargetPort=00 TargetComponent=00 AssocRCRB- 
LinkType=MemMapped LinkValid+
                        Addr:   00000000fed1c000
        Kernel driver in use: snd_hda_intel
        Kernel modules: snd-hda-intel

00:1c.0 PCI bridge: Intel Corporation 7 Series/C210 Series Chipset Family PCI 
Express Root Port 1 (rev c4) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: e4600000-e46fffff
        Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, 
L1 <1us
                        ExtTag- RBE+ FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ 
TransPend-
                LnkCap: Port #1, Speed 5GT/s, Width x1, ASPM L0s L1, Latency 
L0 <512ns, L1 <16us
                        ClockPM- Surprise- LLActRep+ BwNot-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- 
CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ 
DLActive+ BWMgmt+ ABWMgmt-
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- 
Surprise-
                        Slot #0, PowerLimit 10.000W; Interlock- NoCompl+
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- 
LinkChg-
                        Control: AttnInd Unknown, PwrInd Unknown, Power- 
Interlock-
                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ 
Interlock-
                        Changed: MRL- PresDet- LinkState+
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- 
CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
                DevCap2: Completion Timeout: Range BC, TimeoutDis+ ARIFwd-
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
                LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-, 
Selectable De-emphasis: -6dB
                         Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -3.5dB, 
EqualizationComplete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-, 
LinkEqualizationRequest-
        Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
                Address: 00000000  Data: 0000
        Capabilities: [90] Subsystem: Toshiba America Info Systems Device 0001
        Capabilities: [a0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Kernel driver in use: pcieport
        Kernel modules: shpchp

00:1c.1 PCI bridge: Intel Corporation 7 Series/C210 Series Chipset Family PCI 
Express Root Port 2 (rev c4) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Bus: primary=00, secondary=02, subordinate=03, sec-latency=0
        I/O behind bridge: 00002000-00002fff
        Memory behind bridge: e2600000-e45fffff
        Prefetchable memory behind bridge: 00000000e0400000-00000000e23fffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, 
L1 <1us
                        ExtTag- RBE+ FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ 
TransPend-
                LnkCap: Port #2, Speed 5GT/s, Width x1, ASPM L0s L1, Latency 
L0 <1us, L1 <16us
                        ClockPM- Surprise- LLActRep+ BwNot-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- 
CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ 
DLActive- BWMgmt- ABWMgmt-
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ 
Surprise+
                        Slot #1, PowerLimit 10.000W; Interlock- NoCompl+
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq- 
LinkChg-
                        Control: AttnInd Unknown, PwrInd Unknown, Power- 
Interlock-
                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- 
Interlock-
                        Changed: MRL- PresDet- LinkState-
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- 
CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
                DevCap2: Completion Timeout: Range BC, TimeoutDis+ ARIFwd-
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
                LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-, 
Selectable De-emphasis: -6dB
                         Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -3.5dB, 
EqualizationComplete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-, 
LinkEqualizationRequest-
        Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
                Address: 00000000  Data: 0000
        Capabilities: [90] Subsystem: Toshiba America Info Systems Device 0001
        Capabilities: [a0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Kernel driver in use: pcieport
        Kernel modules: shpchp

00:1c.2 PCI bridge: Intel Corporation 7 Series/C210 Series Chipset Family PCI 
Express Root Port 3 (rev c4) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: e2500000-e25fffff
        Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, 
L1 <1us
                        ExtTag- RBE+ FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ 
TransPend-
                LnkCap: Port #3, Speed 5GT/s, Width x1, ASPM L0s L1, Latency 
L0 <512ns, L1 <16us
                        ClockPM- Surprise- LLActRep+ BwNot-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- 
CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ 
DLActive+ BWMgmt+ ABWMgmt-
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- 
Surprise-
                        Slot #2, PowerLimit 10.000W; Interlock- NoCompl+
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- 
LinkChg-
                        Control: AttnInd Unknown, PwrInd Unknown, Power- 
Interlock-
                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ 
Interlock-
                        Changed: MRL- PresDet- LinkState+
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- 
CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
                DevCap2: Completion Timeout: Range BC, TimeoutDis+ ARIFwd-
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
                LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-, 
Selectable De-emphasis: -6dB
                         Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -3.5dB, 
EqualizationComplete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-, 
LinkEqualizationRequest-
        Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
                Address: 00000000  Data: 0000
        Capabilities: [90] Subsystem: Toshiba America Info Systems Device 0001
        Capabilities: [a0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Kernel driver in use: pcieport
        Kernel modules: shpchp

00:1c.5 PCI bridge: Intel Corporation 7 Series/C210 Series Chipset Family PCI 
Express Root Port 6 (rev c4) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Bus: primary=00, secondary=05, subordinate=05, sec-latency=0
        I/O behind bridge: 00004000-00004fff
        Memory behind bridge: e2400000-e24fffff
        Prefetchable memory behind bridge: 00000000cfb00000-00000000cfcfffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, 
L1 <1us
                        ExtTag- RBE+ FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ 
TransPend-
                LnkCap: Port #6, Speed 5GT/s, Width x1, ASPM L0s L1, Latency 
L0 <1us, L1 <16us
                        ClockPM- Surprise- LLActRep+ BwNot-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- 
CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ 
DLActive- BWMgmt- ABWMgmt-
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ 
Surprise+
                        Slot #3, PowerLimit 10.000W; Interlock- NoCompl+
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq- 
LinkChg-
                        Control: AttnInd Unknown, PwrInd Unknown, Power- 
Interlock-
                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- 
Interlock-
                        Changed: MRL- PresDet- LinkState-
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- 
CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
                DevCap2: Completion Timeout: Range BC, TimeoutDis+ ARIFwd-
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
                LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-, 
Selectable De-emphasis: -6dB
                         Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -3.5dB, 
EqualizationComplete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-, 
LinkEqualizationRequest-
        Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
                Address: 00000000  Data: 0000
        Capabilities: [90] Subsystem: Toshiba America Info Systems Device 0001
        Capabilities: [a0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Kernel driver in use: pcieport
        Kernel modules: shpchp

00:1d.0 USB controller: Intel Corporation 7 Series/C210 Series Chipset Family 
USB Enhanced Host Controller #1 (rev 04) (prog-if 20 [EHCI])
        Subsystem: Toshiba America Info Systems Device 0001
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 23
        Region 0: Memory at e4739000 (32-bit, non-prefetchable) [size=1K]
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

00:1f.0 ISA bridge: Intel Corporation HM76 Express Chipset LPC Controller (rev 
04)
        Subsystem: Toshiba America Info Systems Device 0001
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Capabilities: [e0] Vendor Specific Information: Len=0c <?>
        Kernel driver in use: lpc_ich
        Kernel modules: lpc_ich

00:1f.2 SATA controller: Intel Corporation 7 Series Chipset Family 6-port SATA 
Controller [AHCI mode] (rev 04) (prog-if 01 [AHCI 1.0])
        Subsystem: Toshiba America Info Systems Device 0001
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin B routed to IRQ 40
        Region 0: I/O ports at 30a8 [size=8]
        Region 1: I/O ports at 30b4 [size=4]
        Region 2: I/O ports at 30a0 [size=8]
        Region 3: I/O ports at 30b0 [size=4]
        Region 4: I/O ports at 3060 [size=32]
        Region 5: Memory at e4738000 (32-bit, non-prefetchable) [size=2K]
        Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
                Address: fee0300c  Data: 4191
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

01:00.0 System peripheral: Ricoh Co Ltd PCIe SDXC/MMC Host Controller (rev 07) 
(prog-if 01)
        Subsystem: Toshiba America Info Systems Device 0001
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at e4602000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
                Address: 0000000000000000  Data: 0000
        Capabilities: [78] Power Management version 3
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=2 PME-
        Capabilities: [80] Express (v1) Endpoint, MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s 
unlimited, L1 unlimited
                        ExtTag- AttnBtn+ AttnInd+ PwrInd+ RBE+ FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- 
TransPend-
                LnkCap: Port #1, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency 
L0 <4us, L1 unlimited
                        ClockPM+ Surprise- LLActRep- BwNot-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- 
CommClk+
                        ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ 
DLActive- BWMgmt- ABWMgmt-
        Capabilities: [100 v1] Virtual Channel
                Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
                Arb:    Fixed- WRR32- WRR64- WRR128-
                Ctrl:   ArbSelect=Fixed
                Status: InProgress-
                VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                        Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
                        Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
                        Status: NegoPending- InProgress-
        Capabilities: [800 v1] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
NonFatalErr+
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
NonFatalErr+
                AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ 
ChkEn-
        Kernel driver in use: sdhci-pci
        Kernel modules: sdhci-pci

01:00.1 System peripheral: Ricoh Co Ltd Device e232 (rev 04)
        Subsystem: Toshiba America Info Systems Device 0001
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin B routed to IRQ 5
        Region 0: Memory at e4601000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
                Address: 0000000000000000  Data: 0000
        Capabilities: [78] Power Management version 3
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=2 PME-
        Capabilities: [80] Express (v1) Endpoint, MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s 
unlimited, L1 unlimited
                        ExtTag- AttnBtn+ AttnInd+ PwrInd+ RBE+ FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- 
TransPend-
                LnkCap: Port #1, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency 
L0 <4us, L1 unlimited
                        ClockPM+ Surprise- LLActRep- BwNot-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- 
CommClk+
                        ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ 
DLActive- BWMgmt- ABWMgmt-
        Capabilities: [100 v1] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
NonFatalErr+
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
NonFatalErr+
                AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ 
ChkEn-

04:00.0 Network controller: Intel Corporation Centrino Advanced-N 6235 (rev 
24)
        Subsystem: Intel Corporation Centrino Advanced-N 6235 AGN
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 45
        Region 0: Memory at e2500000 (64-bit, non-prefetchable) [size=8K]
        Capabilities: [c8] Power Management version 3
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
                Address: 00000000fee0400c  Data: 4122
        Capabilities: [e0] Express (v1) Endpoint, MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, 
L1 unlimited
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+ FLReset-
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ 
TransPend-
                LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency 
L0 <4us, L1 <32us
                        ClockPM+ Surprise- LLActRep- BwNot-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- 
CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ 
DLActive- BWMgmt- ABWMgmt-
        Capabilities: [100 v1] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
NonFatalErr+
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
NonFatalErr+
                AERCap: First Error Pointer: 00, GenCap- CGenEn- ChkCap- 
ChkEn-
        Capabilities: [140 v1] Device Serial Number c4-85-08-ff-ff-85-45-da
        Kernel driver in use: iwlwifi
        Kernel modules: iwlwifi

[7.6.] cat /proc/scsi/scsi 
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: TOSHIBA MK5061GS Rev: MH00
  Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi2 Channel: 00 Id: 00 Lun: 00
  Vendor: MATSHITA Model: DVD-RAM UJ8B2    Rev: 1.00
  Type:   CD-ROM                           ANSI  SCSI revision: 05

[7.7.] ls /proc 
acpi       devices      interrupts  kpageflags     mtrr          softirqs       
uptime       1035  1101  1211  1335  1420  22    2592  2670  2823  2887  3051  
3138  3149  3252  3426  37   45    58    6510  72    836  94
asound     diskstats    iomem       latency_stats  net           stat           
version      1061  1120  1230  1346  1553  23    26    2673  2824  2889  3052  
3139  3150  3253  3434  38   46    5841  66    7216  843  942
buddyinfo  dma          ioports     loadavg        pagetypeinfo  swaps          
vmallocinfo  1076  1126  1231  1396  1589  24    2622  2675  2826  2897  3067  
3140  32    328   35    40   4834  596   68    753   864  945
bus        dri          irq         locks          partitions    sys            
vmstat       1077  1187  1240  14    16    2453  2623  2678  2838  29    3069  
3141  3214  3282  3500  41   4835  61    687   769   866  946
cgroups    driver       kallsyms    mdstat         scsi          sysrq-trigger  
zoneinfo     1086  1193  1248  1410  17    25    2654  27    2842  2925  31    
3142  3221  329   3503  417  4913  62    6873  8     868  95
cmdline    execdomains  kcore       meminfo        self          sysvipc        
1            1087  12    1268  1411  18    2533  2655  28    2850  2929  3103  
3143  3234  33    3504  42   5     63    688   813   872  97
consoles   fb           key-users   misc           sched_debug   timer_list     
10           1088  1205  1270  1412  19    2587  2656  2815  2852  3     3109  
3144  3246  3318  3505  420  513   64    7     814   9    997
cpuinfo    filesystems  kmsg        modules        schedstat     timer_stats    
1013         1092  1207  1271  1413  2     2588  2658  2818  2883  30    3116  
3145  3248  3357  36    43   525   65    70    816   93
crypto     fs           kpagecount  mounts         slabinfo      tty            
1027         11    1208  13    1414  21    2591  2662  2822  2885  3041  3117  
3146  3250  3419  3627  44   57    6507  7064  826   937


