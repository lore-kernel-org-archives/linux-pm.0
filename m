From: Kurtis R <kurtis@excalibur.bc.ca>
Subject: suspend/resume failure
Date: Thu, 20 Mar 2014 23:13:46 -0700
Message-ID: <6aac497ac6c00b399ee425679e95c232@excalibur.bc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smarthost3.zenutech.com ([173.209.58.42]:58415 "EHLO
	smarthost3.zenutech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750987AbaCUGUa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 21 Mar 2014 02:20:30 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

Hi all,

This report has, hopefully, enough info to help solve an issue I've 
been having with suspending and resume. There's a summary before the 
full description of the problem, and then misc after that.

Summary:
Annotation: This occured during a previous suspend and prevented it 
from resuming properly.
Architecture: amd64
Failure: suspend/resume
HibernationDevice: RESUME=UUID=65785f04-0c40-4d44-89d3-4222678a90db
InstallationDate: Installed on 2014-02-06 (41 days ago)
InterpreterPath: /usr/bin/python3.4
MachineType: Acer Extensa 4620
PccardctlIdent:
  Socket 0:
    no product info available
PccardctlStatus:
  Socket 0:
    no card
ProcCmdline: /usr/bin/python3 /usr/share/apport/apportcheckresume
ProcEnviron:
  TERM=linux
  PATH=(custom, no user)
ProcFB: 0 inteldrmfb
ProcKernelCmdLine: BOOT_IMAGE=/boot/vmlinuz-3.13.0-17-generic 
root=UUID=95f56ed6-00cf-4594-85ec-400b6986fd7a ro quiet splash 
vt.handoff=7
PulseList: Error: command ['pacmd', 'list'] failed with exit code 1: No 
PulseAudio daemon running, or not running as session daemon.
SourcePackage: linux
Title: [Acer Extensa 4620] suspend/resume failure
UserGroups:

dmi.bios.date: 03/21/2008
dmi.bios.vendor: Phoenix Technologies LTD
dmi.bios.version: V1.33
dmi.board.name: Biwa
dmi.board.vendor: Acer
dmi.board.version: Rev
dmi.chassis.asset.tag: None
dmi.chassis.type: 10
dmi.chassis.vendor: Acer
dmi.chassis.version: N/A
dmi.modalias: 
dmi:bvnPhoenixTechnologiesLTD:bvrV1.33:bd03/21/2008:svnAcer:pnExtensa4620:pvr0100:rvnAcer:rnBiwa:rvrRev:cvnAcer:ct10:cvrN/A:
dmi.product.name: Extensa 4620
dmi.product.version: 0100
dmi.sys.vendor: Acer

Full description of the problem:
Using 'pm-suspend' or 'systemctl suspend' suspends the computer, but 
the computer will fail to resume and instead reboot. There are cases, 
though, where the computer suspends, about 1 in 10 chance.

Kernel Version:
Linux version 3.14.0-031400rc7-generic (apw@gomeisa) (gcc version 4.6.3 
(Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201403162235 SMP Mon Mar 17 02:36:19 
UTC 2014

Enviroment:
Description:	Ubuntu Trusty Tahr (development branch)
Release:	14.04

Software:
Linux integral 3.14.0-031400rc7-generic #201403162235 SMP Mon Mar 17 
02:36:19 UTC 2014 x86_64 x86_64 x86_64 GNU/Linux

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
Modules Loaded         ctr ccm cuse dm_crypt snd_hda_codec_hdmi joydev 
snd_hda_codec_realtek snd_hda_codec_generic snd_hda_intel snd_hda_codec 
snd_hwdep snd_pcm acer_wmi sparse_keymap snd_seq_midi snd_seq_midi_event 
snd_rawmidi arc4 snd_seq coretemp iwl3945 snd_seq_device microcode 
snd_timer pcmcia iwlegacy uvcvideo videobuf2_vmalloc videobuf2_memops 
psmouse serio_raw videobuf2_core mac80211 rfcomm bnep yenta_socket 
pcmcia_rsrc tifm_7xx1 videodev bluetooth snd pcmcia_core tifm_core 
6lowpan_iphc cfg80211 lpc_ich soundcore nsc_ircc irda crc_ccitt mac_hid 
lp parport firewire_ohci ahci libahci sdhci_pci sdhci firewire_core 
crc_itu_t tg3 i915 ptp wmi video i2c_algo_bit drm_kms_helper pps_core 
drm

Processor Info:
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 15
model name	: Intel(R) Core(TM)2 Duo CPU     T5550  @ 1.83GHz
stepping	: 13
microcode	: 0xa3
cpu MHz		: 1000.000
cache size	: 2048 KB
physical id	: 0
siblings	: 2
core id		: 0
cpu cores	: 2
apicid		: 0
initial apicid	: 0
fpu		: yes
fpu_exception	: yes
cpuid level	: 10
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx lm 
constant_tsc arch_perfmon pebs bts rep_good nopl aperfmperf pni dtes64 
monitor ds_cpl est tm2 ssse3 cx16 xtpr pdcm lahf_lm dtherm
bogomips	: 3657.21
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 15
model name	: Intel(R) Core(TM)2 Duo CPU     T5550  @ 1.83GHz
stepping	: 13
microcode	: 0xa3
cpu MHz		: 1000.000
cache size	: 2048 KB
physical id	: 0
siblings	: 2
core id		: 1
cpu cores	: 2
apicid		: 1
initial apicid	: 1
fpu		: yes
fpu_exception	: yes
cpuid level	: 10
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx lm 
constant_tsc arch_perfmon pebs bts rep_good nopl aperfmperf pni dtes64 
monitor ds_cpl est tm2 ssse3 cx16 xtpr pdcm lahf_lm dtherm
bogomips	: 3657.21
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:

Module Info:
ctr 13193 1 - Live 0x0000000000000000
ccm 17856 1 - Live 0x0000000000000000
cuse 13566 3 - Live 0x0000000000000000
dm_crypt 23456 0 - Live 0x0000000000000000
snd_hda_codec_hdmi 47124 1 - Live 0x0000000000000000
joydev 17575 0 - Live 0x0000000000000000
snd_hda_codec_realtek 66644 1 - Live 0x0000000000000000
snd_hda_codec_generic 69424 1 snd_hda_codec_realtek, Live 
0x0000000000000000
snd_hda_intel 57222 5 - Live 0x0000000000000000
snd_hda_codec 142651 4 
snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel, 
Live 0x0000000000000000
snd_hwdep 13613 1 snd_hda_codec, Live 0x0000000000000000
snd_pcm 108860 4 snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec, Live 
0x0000000000000000
acer_wmi 32938 0 - Live 0x0000000000000000
sparse_keymap 13890 1 acer_wmi, Live 0x0000000000000000
snd_seq_midi 13324 0 - Live 0x0000000000000000
snd_seq_midi_event 14899 1 snd_seq_midi, Live 0x0000000000000000
snd_rawmidi 30465 1 snd_seq_midi, Live 0x0000000000000000
arc4 12573 2 - Live 0x0000000000000000
snd_seq 66061 2 snd_seq_midi,snd_seq_midi_event, Live 
0x0000000000000000
coretemp 17768 0 - Live 0x0000000000000000
iwl3945 74499 0 - Live 0x0000000000000000
snd_seq_device 14497 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 
0x0000000000000000
microcode 24391 0 - Live 0x0000000000000000
snd_timer 30038 2 snd_pcm,snd_seq, Live 0x0000000000000000
pcmcia 62760 0 - Live 0x0000000000000000
iwlegacy 105053 1 iwl3945, Live 0x0000000000000000
uvcvideo 82247 0 - Live 0x0000000000000000
videobuf2_vmalloc 13216 1 uvcvideo, Live 0x0000000000000000
videobuf2_memops 13362 1 videobuf2_vmalloc, Live 0x0000000000000000
psmouse 108621 0 - Live 0x0000000000000000
serio_raw 13462 0 - Live 0x0000000000000000
videobuf2_core 45465 1 uvcvideo, Live 0x0000000000000000
mac80211 676864 2 iwl3945,iwlegacy, Live 0x0000000000000000
rfcomm 74734 0 - Live 0x0000000000000000
bnep 19884 2 - Live 0x0000000000000000
yenta_socket 45434 0 - Live 0x0000000000000000
pcmcia_rsrc 18591 1 yenta_socket, Live 0x0000000000000000
tifm_7xx1 13418 0 - Live 0x0000000000000000
videodev 149340 2 uvcvideo,videobuf2_core, Live 0x0000000000000000
bluetooth 426845 10 rfcomm,bnep, Live 0x0000000000000000
snd 73979 21 
snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_seq_midi,snd_rawmidi,snd_seq,snd_seq_device,snd_timer, 
Live 0x0000000000000000
pcmcia_core 23715 3 pcmcia,yenta_socket,pcmcia_rsrc, Live 
0x0000000000000000
tifm_core 15771 1 tifm_7xx1, Live 0x0000000000000000
6lowpan_iphc 18968 1 bluetooth, Live 0x0000000000000000
cfg80211 531467 3 iwl3945,iwlegacy,mac80211, Live 0x0000000000000000
lpc_ich 21163 0 - Live 0x0000000000000000
soundcore 12680 1 snd, Live 0x0000000000000000
nsc_ircc 23151 0 - Live 0x0000000000000000
irda 130085 1 nsc_ircc, Live 0x0000000000000000
crc_ccitt 12707 1 irda, Live 0x0000000000000000
mac_hid 13253 0 - Live 0x0000000000000000
lp 17799 0 - Live 0x0000000000000000
parport 42481 1 lp, Live 0x0000000000000000
firewire_ohci 45289 0 - Live 0x0000000000000000
ahci 30066 1 - Live 0x0000000000000000
libahci 32191 1 ahci, Live 0x0000000000000000
sdhci_pci 23263 0 - Live 0x0000000000000000
sdhci 43409 1 sdhci_pci, Live 0x0000000000000000
firewire_core 69403 1 firewire_ohci, Live 0x0000000000000000
crc_itu_t 12707 1 firewire_core, Live 0x0000000000000000
tg3 179110 0 - Live 0x0000000000000000
i915 826584 5 - Live 0x0000000000000000
ptp 18980 1 tg3, Live 0x0000000000000000
wmi 19363 1 acer_wmi, Live 0x0000000000000000
video 19914 2 acer_wmi,i915, Live 0x0000000000000000
i2c_algo_bit 13564 1 i915, Live 0x0000000000000000
drm_kms_helper 53224 1 i915, Live 0x0000000000000000
pps_core 19381 1 ptp, Live 0x0000000000000000
drm 308197 6 i915,drm_kms_helper, Live 0x0000000000000000
kurtisr@integral:/usr/src/linux-headers-3.14.0-031400rc7/scripts$ cat 
/proc/modules
ctr 13193 1 - Live 0x0000000000000000
ccm 17856 1 - Live 0x0000000000000000
cuse 13566 3 - Live 0x0000000000000000
dm_crypt 23456 0 - Live 0x0000000000000000
snd_hda_codec_hdmi 47124 1 - Live 0x0000000000000000
joydev 17575 0 - Live 0x0000000000000000
snd_hda_codec_realtek 66644 1 - Live 0x0000000000000000
snd_hda_codec_generic 69424 1 snd_hda_codec_realtek, Live 
0x0000000000000000
snd_hda_intel 57222 5 - Live 0x0000000000000000
snd_hda_codec 142651 4 
snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel, 
Live 0x0000000000000000
snd_hwdep 13613 1 snd_hda_codec, Live 0x0000000000000000
snd_pcm 108860 4 snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec, Live 
0x0000000000000000
acer_wmi 32938 0 - Live 0x0000000000000000
sparse_keymap 13890 1 acer_wmi, Live 0x0000000000000000
snd_seq_midi 13324 0 - Live 0x0000000000000000
snd_seq_midi_event 14899 1 snd_seq_midi, Live 0x0000000000000000
snd_rawmidi 30465 1 snd_seq_midi, Live 0x0000000000000000
arc4 12573 2 - Live 0x0000000000000000
snd_seq 66061 2 snd_seq_midi,snd_seq_midi_event, Live 
0x0000000000000000
coretemp 17768 0 - Live 0x0000000000000000
iwl3945 74499 0 - Live 0x0000000000000000
snd_seq_device 14497 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 
0x0000000000000000
microcode 24391 0 - Live 0x0000000000000000
snd_timer 30038 2 snd_pcm,snd_seq, Live 0x0000000000000000
pcmcia 62760 0 - Live 0x0000000000000000
iwlegacy 105053 1 iwl3945, Live 0x0000000000000000
uvcvideo 82247 0 - Live 0x0000000000000000
videobuf2_vmalloc 13216 1 uvcvideo, Live 0x0000000000000000
videobuf2_memops 13362 1 videobuf2_vmalloc, Live 0x0000000000000000
psmouse 108621 0 - Live 0x0000000000000000
serio_raw 13462 0 - Live 0x0000000000000000
videobuf2_core 45465 1 uvcvideo, Live 0x0000000000000000
mac80211 676864 2 iwl3945,iwlegacy, Live 0x0000000000000000
rfcomm 74734 0 - Live 0x0000000000000000
bnep 19884 2 - Live 0x0000000000000000
yenta_socket 45434 0 - Live 0x0000000000000000
pcmcia_rsrc 18591 1 yenta_socket, Live 0x0000000000000000
tifm_7xx1 13418 0 - Live 0x0000000000000000
videodev 149340 2 uvcvideo,videobuf2_core, Live 0x0000000000000000
bluetooth 426845 10 rfcomm,bnep, Live 0x0000000000000000
snd 73979 21 
snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_seq_midi,snd_rawmidi,snd_seq,snd_seq_device,snd_timer, 
Live 0x0000000000000000
pcmcia_core 23715 3 pcmcia,yenta_socket,pcmcia_rsrc, Live 
0x0000000000000000
tifm_core 15771 1 tifm_7xx1, Live 0x0000000000000000
6lowpan_iphc 18968 1 bluetooth, Live 0x0000000000000000
cfg80211 531467 3 iwl3945,iwlegacy,mac80211, Live 0x0000000000000000
lpc_ich 21163 0 - Live 0x0000000000000000
soundcore 12680 1 snd, Live 0x0000000000000000
nsc_ircc 23151 0 - Live 0x0000000000000000
irda 130085 1 nsc_ircc, Live 0x0000000000000000
crc_ccitt 12707 1 irda, Live 0x0000000000000000
mac_hid 13253 0 - Live 0x0000000000000000
lp 17799 0 - Live 0x0000000000000000
parport 42481 1 lp, Live 0x0000000000000000
firewire_ohci 45289 0 - Live 0x0000000000000000
ahci 30066 1 - Live 0x0000000000000000
libahci 32191 1 ahci, Live 0x0000000000000000
sdhci_pci 23263 0 - Live 0x0000000000000000
sdhci 43409 1 sdhci_pci, Live 0x0000000000000000
firewire_core 69403 1 firewire_ohci, Live 0x0000000000000000
crc_itu_t 12707 1 firewire_core, Live 0x0000000000000000
tg3 179110 0 - Live 0x0000000000000000
i915 826584 5 - Live 0x0000000000000000
ptp 18980 1 tg3, Live 0x0000000000000000
wmi 19363 1 acer_wmi, Live 0x0000000000000000
video 19914 2 acer_wmi,i915, Live 0x0000000000000000
i2c_algo_bit 13564 1 i915, Live 0x0000000000000000
drm_kms_helper 53224 1 i915, Live 0x0000000000000000
pps_core 19381 1 ptp, Live 0x0000000000000000
drm 308197 6 i915,drm_kms_helper, Live 0x0000000000000000

Loaded driver and hardware info:
0000-0cf7 : PCI Bus 0000:00
   0000-001f : dma1
   0020-0021 : pic1
   0040-0043 : timer0
   0050-0053 : timer1
   0060-0060 : keyboard
   0062-0062 : EC data
   0064-0064 : keyboard
   0066-0066 : EC cmd
   0070-0077 : rtc0
   0080-008f : dma page reg
   00a0-00a1 : pic2
   00c0-00df : dma2
   00f0-00ff : fpu
   0170-0177 : 0000:00:1f.1
     0170-0177 : ata_piix
   01f0-01f7 : 0000:00:1f.1
     01f0-01f7 : ata_piix
   02f8-02ff : nsc-ircc
   0376-0376 : 0000:00:1f.1
     0376-0376 : ata_piix
   03c0-03df : vesafb
   03f6-03f6 : 0000:00:1f.1
     03f6-03f6 : ata_piix
   0800-080f : pnp 00:07
0cf8-0cff : PCI conf1
0d00-ffff : PCI Bus 0000:00
   1000-1003 : ACPI PM1a_EVT_BLK
   1004-1005 : ACPI PM1a_CNT_BLK
   1008-100b : ACPI PM_TMR
   1010-1015 : ACPI CPU throttle
   1020-1020 : ACPI PM2_CNT_BLK
   1028-102f : ACPI GPE0_BLK
   1030-1033 : iTCO_wdt
   1060-107f : iTCO_wdt
   1180-11bf : 0000:00:1f.0
     1180-11bf : pnp 00:07
   1800-1807 : 0000:00:02.0
   1810-181f : 0000:00:1f.1
     1810-181f : ata_piix
   1820-183f : 0000:00:1a.0
     1820-183f : uhci_hcd
   1840-185f : 0000:00:1a.1
     1840-185f : uhci_hcd
   1860-187f : 0000:00:1d.0
     1860-187f : uhci_hcd
   1880-189f : 0000:00:1d.1
     1880-189f : uhci_hcd
   18a0-18bf : 0000:00:1d.2
     18a0-18bf : uhci_hcd
   18d0-18d3 : 0000:00:1f.2
     18d0-18d3 : ahci
   18d4-18d7 : 0000:00:1f.2
     18d4-18d7 : ahci
   18d8-18df : 0000:00:1f.2
     18d8-18df : ahci
   18e0-18ff : 0000:00:1f.2
     18e0-18ff : ahci
   1c00-1c07 : 0000:00:1f.2
     1c00-1c07 : ahci
   1c20-1c3f : 0000:00:1f.3
   2000-2fff : PCI Bus 0000:02
   3000-3fff : PCI Bus 0000:04
   4000-4fff : PCI Bus 0000:06
   5000-5fff : PCI Bus 0000:0f
     5000-50ff : PCI CardBus 0000:10
     5400-54ff : PCI CardBus 0000:10
   fe00-fe00 : pnp 00:07

00000000-00000fff : reserved
00001000-0009f7ff : System RAM
0009f800-0009ffff : reserved
000a0000-000bffff : PCI Bus 0000:00
000c0000-000c7fff : Video ROM
000cf000-000cffff : Adapter ROM
000d0000-000d3fff : PCI Bus 0000:00
000d4000-000d7fff : PCI Bus 0000:00
000d8000-000dbfff : PCI Bus 0000:00
000dc000-000dffff : PCI Bus 0000:00
000e0000-000fffff : reserved
   000f0000-000fffff : System ROM
00100000-bf6cffff : System RAM
   01000000-01776085 : Kernel code
   01776086-01d157bf : Kernel data
   01e73000-01fd8fff : Kernel bss
bf6d0000-bf6defff : ACPI Non-volatile Storage
bf6df000-bfffffff : reserved
   bf800000-bfffffff : Graphics Stolen Memory
c0000000-dfffffff : PCI Bus 0000:00
   c0000000-c3ffffff : PCI Bus 0000:0f
     c0000000-c3ffffff : PCI CardBus 0000:10
   c4000000-c40000ff : 0000:00:1f.3
   c4001000-c4001fff : Intel Flush Page
   c8000000-cbffffff : PCI CardBus 0000:10
   d0000000-dfffffff : 0000:00:02.0
e0000000-efffffff : PCI MMCONFIG 0000 [bus 00-ff]
   e0000000-efffffff : reserved
     e0000000-efffffff : pnp 00:00
f0000000-febfffff : PCI Bus 0000:00
   f0000000-f1ffffff : PCI Bus 0000:02
   f2000000-f3ffffff : PCI Bus 0000:04
   f4000000-f5ffffff : PCI Bus 0000:06
   f6000000-f7ffffff : PCI Bus 0000:02
     f6000000-f600ffff : 0000:02:00.0
       f6000000-f600ffff : tg3
   f8000000-f9ffffff : PCI Bus 0000:04
     f8000000-f8000fff : 0000:04:00.0
       f8000000-f8000fff : iwl3945
   fa000000-fbffffff : PCI Bus 0000:06
   fc000000-fc0fffff : 0000:00:02.0
   fc100000-fc1fffff : 0000:00:02.1
   fc200000-fc2fffff : PCI Bus 0000:0f
     fc200000-fc203fff : 0000:0f:06.1
     fc204000-fc204fff : 0000:0f:06.0
       fc204000-fc204fff : yenta_socket
     fc205000-fc205fff : 0000:0f:06.2
       fc205000-fc205fff : tifm_7xx1
     fc206000-fc2067ff : 0000:0f:06.1
       fc206000-fc2067ff : firewire_ohci
     fc206800-fc2068ff : 0000:0f:06.3
       fc206800-fc2068ff : mmc0
   fc300000-fc303fff : 0000:00:1b.0
     fc300000-fc303fff : ICH HD audio
   fc504000-fc5047ff : 0000:00:1f.2
     fc504000-fc5047ff : ahci
   fc504800-fc504bff : 0000:00:1a.7
     fc504800-fc504bff : ehci_hcd
   fc504c00-fc504fff : 0000:00:1d.7
     fc504c00-fc504fff : ehci_hcd
fec00000-fec0ffff : reserved
   fec00000-fec003ff : IOAPIC 0
fed00000-fed003ff : HPET 0
   fed00000-fed003ff : reserved
     fed00000-fed003ff : pnp 00:05
fed14000-fed19fff : reserved
   fed14000-fed17fff : pnp 00:00
   fed18000-fed18fff : pnp 00:00
   fed19000-fed19fff : pnp 00:00
fed1c000-fed8ffff : reserved
   fed1c000-fed1ffff : pnp 00:00
     fed1f410-fed1f414 : iTCO_wdt
   fed20000-fed3ffff : pnp 00:00
   fed45000-fed8ffff : pnp 00:00
fee00000-fee00fff : Local APIC
   fee00000-fee00fff : reserved
ff000000-ffffffff : reserved
   ff800000-ff800fff : pnp 00:07

PCI info:
00:00.0 Host bridge: Intel Corporation Mobile PM965/GM965/GL960 Memory 
Controller Hub (rev 03)
	Subsystem: Acer Incorporated [ALI] Device 011c
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR- INTx-
	Latency: 0
	Capabilities: [e0] Vendor Specific Information: Len=0a <?>
	Kernel driver in use: agpgart-intel

00:02.0 VGA compatible controller: Intel Corporation Mobile GM965/GL960 
Integrated Graphics Controller (primary) (rev 03) (prog-if 00 [VGA 
controller])
	Subsystem: Acer Incorporated [ALI] Device 011c
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 43
	Region 0: Memory at fc000000 (64-bit, non-prefetchable) [size=1M]
	Region 2: Memory at d0000000 (64-bit, prefetchable) [size=256M]
	Region 4: I/O ports at 1800 [size=8]
	Expansion ROM at <unassigned> [disabled]
	Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee0300c  Data: 4122
	Capabilities: [d0] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
		Bridge: PM- B3+
	Kernel driver in use: i915

00:02.1 Display controller: Intel Corporation Mobile GM965/GL960 
Integrated Graphics Controller (secondary) (rev 03)
	Subsystem: Acer Incorporated [ALI] Device 011c
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Region 0: Memory at fc100000 (64-bit, non-prefetchable) [size=1M]
	Capabilities: [d0] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
		Bridge: PM- B3+

00:1a.0 USB controller: Intel Corporation 82801H (ICH8 Family) USB UHCI 
Controller #4 (rev 03) (prog-if 00 [UHCI])
	Subsystem: Acer Incorporated [ALI] Device 011c
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 20
	Region 4: I/O ports at 1820 [size=32]
	Kernel driver in use: uhci_hcd

00:1a.1 USB controller: Intel Corporation 82801H (ICH8 Family) USB UHCI 
Controller #5 (rev 03) (prog-if 00 [UHCI])
	Subsystem: Acer Incorporated [ALI] Device 011c
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin B routed to IRQ 21
	Region 4: I/O ports at 1840 [size=32]
	Kernel driver in use: uhci_hcd

00:1a.7 USB controller: Intel Corporation 82801H (ICH8 Family) USB2 
EHCI Controller #2 (rev 03) (prog-if 20 [EHCI])
	Subsystem: Acer Incorporated [ALI] Device 011c
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin C routed to IRQ 20
	Region 0: Memory at fc504800 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Debug port: BAR=1 offset=00a0
	Kernel driver in use: ehci-pci

00:1b.0 Audio device: Intel Corporation 82801H (ICH8 Family) HD Audio 
Controller (rev 03)
	Subsystem: Acer Incorporated [ALI] Device 011c
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 46
	Region 0: Memory at fc300000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee0300c  Data: 4162
	Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI 
00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
	Capabilities: [100 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=01
			Status:	NegoPending- InProgress-
		VC1:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=1 ArbSelect=Fixed TC/VC=80
			Status:	NegoPending- InProgress-
	Capabilities: [130 v1] Root Complex Link
		Desc:	PortNumber=0f ComponentID=02 EltType=Config
		Link0:	Desc:	TargetPort=00 TargetComponent=02 AssocRCRB- 
LinkType=MemMapped LinkValid+
			Addr:	00000000fed1c000
	Kernel driver in use: snd_hda_intel

00:1c.0 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express 
Port 1 (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=02, subordinate=03, sec-latency=0
	I/O behind bridge: 00002000-00002fff
	Memory behind bridge: f6000000-f7ffffff
	Prefetchable memory behind bridge: 00000000f0000000-00000000f1ffffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ <SERR+ <PERR-
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #1, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency 
L0s <256ns, L1 <4us
			ClockPM- Surprise- LLActRep+ BwNot-
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ 
BWMgmt- ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
			Slot #2, PowerLimit 6.500W; Interlock- NoCompl-
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq- 
LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet- LinkState-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- 
CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
	Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee0300c  Data: 41a1
	Capabilities: [90] Subsystem: Acer Incorporated [ALI] Device 011c
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed+ WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=01
			Status:	NegoPending- InProgress-
	Capabilities: [180 v1] Root Complex Link
		Desc:	PortNumber=01 ComponentID=02 EltType=Config
		Link0:	Desc:	TargetPort=00 TargetComponent=02 AssocRCRB- 
LinkType=MemMapped LinkValid+
			Addr:	00000000fed1c001
	Kernel driver in use: pcieport

00:1c.1 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express 
Port 2 (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=04, subordinate=05, sec-latency=0
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: f8000000-f9ffffff
	Prefetchable memory behind bridge: 00000000f2000000-00000000f3ffffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #2, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency 
L0s <256ns, L1 <4us
			ClockPM- Surprise- LLActRep+ BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ 
BWMgmt- ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
			Slot #3, PowerLimit 6.500W; Interlock- NoCompl-
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq- 
LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet- LinkState-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- 
CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
	Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee0300c  Data: 41b1
	Capabilities: [90] Subsystem: Acer Incorporated [ALI] Device 011c
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed+ WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=01
			Status:	NegoPending- InProgress-
	Capabilities: [180 v1] Root Complex Link
		Desc:	PortNumber=02 ComponentID=02 EltType=Config
		Link0:	Desc:	TargetPort=00 TargetComponent=02 AssocRCRB- 
LinkType=MemMapped LinkValid+
			Addr:	00000000fed1c001
	Kernel driver in use: pcieport

00:1c.2 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express 
Port 3 (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=06, subordinate=07, sec-latency=0
	I/O behind bridge: 00004000-00004fff
	Memory behind bridge: fa000000-fbffffff
	Prefetchable memory behind bridge: 00000000f4000000-00000000f5ffffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #3, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency 
L0s <1us, L1 <4us
			ClockPM- Surprise- LLActRep+ BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ DLActive- 
BWMgmt- ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
			Slot #4, PowerLimit 6.500W; Interlock- NoCompl-
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq- 
LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
			Changed: MRL- PresDet- LinkState-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- 
CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
	Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee0300c  Data: 41c1
	Capabilities: [90] Subsystem: Acer Incorporated [ALI] Device 011c
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed+ WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
	Capabilities: [180 v1] Root Complex Link
		Desc:	PortNumber=03 ComponentID=02 EltType=Config
		Link0:	Desc:	TargetPort=00 TargetComponent=02 AssocRCRB- 
LinkType=MemMapped LinkValid+
			Addr:	00000000fed1c001
	Kernel driver in use: pcieport

00:1d.0 USB controller: Intel Corporation 82801H (ICH8 Family) USB UHCI 
Controller #1 (rev 03) (prog-if 00 [UHCI])
	Subsystem: Acer Incorporated [ALI] Device 011c
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 23
	Region 4: I/O ports at 1860 [size=32]
	Kernel driver in use: uhci_hcd

00:1d.1 USB controller: Intel Corporation 82801H (ICH8 Family) USB UHCI 
Controller #2 (rev 03) (prog-if 00 [UHCI])
	Subsystem: Acer Incorporated [ALI] Device 011c
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin B routed to IRQ 17
	Region 4: I/O ports at 1880 [size=32]
	Kernel driver in use: uhci_hcd

00:1d.2 USB controller: Intel Corporation 82801H (ICH8 Family) USB UHCI 
Controller #3 (rev 03) (prog-if 00 [UHCI])
	Subsystem: Acer Incorporated [ALI] Device 011c
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin C routed to IRQ 18
	Region 4: I/O ports at 18a0 [size=32]
	Kernel driver in use: uhci_hcd

00:1d.7 USB controller: Intel Corporation 82801H (ICH8 Family) USB2 
EHCI Controller #1 (rev 03) (prog-if 20 [EHCI])
	Subsystem: Acer Incorporated [ALI] Device 011c
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 23
	Region 0: Memory at fc504c00 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Debug port: BAR=1 offset=00a0
	Kernel driver in use: ehci-pci

00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev f3) 
(prog-if 01 [Subtractive decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Bus: primary=00, secondary=0f, subordinate=13, sec-latency=32
	I/O behind bridge: 00005000-00005fff
	Memory behind bridge: fc200000-fc2fffff
	Prefetchable memory behind bridge: 00000000c0000000-00000000c3ffffff
	Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [50] Subsystem: Device 0000:0000

00:1f.0 ISA bridge: Intel Corporation 82801HM (ICH8M) LPC Interface 
Controller (rev 03)
	Subsystem: Acer Incorporated [ALI] Device 011c
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Capabilities: [e0] Vendor Specific Information: Len=0c <?>
	Kernel driver in use: lpc_ich

00:1f.1 IDE interface: Intel Corporation 82801HM/HEM (ICH8M/ICH8M-E) 
IDE Controller (rev 03) (prog-if 8a [Master SecP PriP])
	Subsystem: Acer Incorporated [ALI] Device 011c
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 19
	Region 0: I/O ports at 01f0 [size=8]
	Region 1: I/O ports at 03f4
	Region 2: I/O ports at 0170 [size=8]
	Region 3: I/O ports at 0374
	Region 4: I/O ports at 1810 [size=16]
	Kernel driver in use: ata_piix

00:1f.2 SATA controller: Intel Corporation 82801HM/HEM (ICH8M/ICH8M-E) 
SATA Controller [AHCI mode] (rev 03) (prog-if 01 [AHCI 1.0])
	Subsystem: Acer Incorporated [ALI] Device 011c
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin B routed to IRQ 44
	Region 0: I/O ports at 1c00 [size=8]
	Region 1: I/O ports at 18d4 [size=4]
	Region 2: I/O ports at 18d8 [size=8]
	Region 3: I/O ports at 18d0 [size=4]
	Region 4: I/O ports at 18e0 [size=32]
	Region 5: Memory at fc504000 (32-bit, non-prefetchable) [size=2K]
	Capabilities: [80] MSI: Enable+ Count=1/4 Maskable- 64bit-
		Address: fee0300c  Data: 4142
	Capabilities: [70] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot+,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=00000004
	Kernel driver in use: ahci

00:1f.3 SMBus: Intel Corporation 82801H (ICH8 Family) SMBus Controller 
(rev 03)
	Subsystem: Acer Incorporated [ALI] Device 011c
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin C routed to IRQ 11
	Region 0: Memory at c4000000 (32-bit, non-prefetchable) [size=256]
	Region 4: I/O ports at 1c20 [size=32]

02:00.0 Ethernet controller: Broadcom Corporation NetLink BCM5787M 
Gigabit Ethernet PCI Express (rev 02)
	Subsystem: Acer Incorporated [ALI] Device 011c
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR+ <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 47
	Region 0: Memory at f6000000 (64-bit, non-prefetchable) [size=64K]
	Expansion ROM at <ignored> [disabled]
	Capabilities: [48] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] Vital Product Data
		Product Name: Broadcom NetLink Gigabit Ethernet Controller
		Read-only fields:
			[PN] Part number: BCM95787m
			[EC] Engineering changes: 106679-15
			[SN] Serial number: 0123456789
			[MN] Manufacture ID: 31 34 65 34
			[RV] Reserved: checksum good, 29 byte(s) reserved
		Read/write fields:
			[YA] Asset tag: XYZ01234567
			[RW] Read-write area: 107 byte(s) free
		End
	Capabilities: [58] Vendor Specific Information: Len=78 <?>
	Capabilities: [e8] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee0300c  Data: 4172
	Capabilities: [d0] Express (v1) Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4us, L1 
unlimited
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency 
L0s <4us, L1 <64us
			ClockPM+ Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- 
BWMgmt- ABWMgmt-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- 
MalfTLP- ECRC- UnsupReq+ ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- 
MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ 
MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr+ BadTLP- BadDLLP+ Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 14, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [13c v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=01
			Status:	NegoPending- InProgress-
	Capabilities: [160 v1] Device Serial Number 00-1d-72-ff-fe-2e-a1-e2
	Kernel driver in use: tg3

04:00.0 Network controller: Intel Corporation PRO/Wireless 3945ABG 
[Golan] Network Connection (rev 02)
	Subsystem: Intel Corporation PRO/Wireless 3945ABG Network Connection
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 45
	Region 0: Memory at f8000000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [c8] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee0100c  Data: 4152
	Capabilities: [e0] Express (v1) Legacy Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 
unlimited
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr+ FatalErr- UnsuppReq+ AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency 
L0s <128ns, L1 <64us
			ClockPM+ Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- 
BWMgmt- ABWMgmt-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- 
MalfTLP- ECRC- UnsupReq+ ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- 
MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ 
MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 14, GenCap- CGenEn- ChkCap- ChkEn-
	Capabilities: [140 v1] Device Serial Number 00-1f-3c-ff-ff-46-ff-50
	Kernel driver in use: iwl3945

0f:06.0 CardBus bridge: Texas Instruments PCIxx12 Cardbus Controller
	Subsystem: Acer Incorporated [ALI] Device 011c
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 168, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 22
	Region 0: Memory at fc204000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=0f, secondary=10, subordinate=13, sec-latency=176
	Memory window 0: c0000000-c3ffffff (prefetchable)
	Memory window 1: c8000000-cbffffff
	I/O window 0: 00005000-000050ff
	I/O window 1: 00005400-000054ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
		Bridge: PM- B3+
	Kernel driver in use: yenta_cardbus

0f:06.1 FireWire (IEEE 1394): Texas Instruments PCIxx12 OHCI Compliant 
IEEE 1394 Host Controller (prog-if 10 [OHCI])
	Subsystem: Acer Incorporated [ALI] Device 011c
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 32 (500ns min, 1000ns max), Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 22
	Region 0: Memory at fc206000 (32-bit, non-prefetchable) [size=2K]
	Region 1: Memory at fc200000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME+
	Kernel driver in use: firewire_ohci

0f:06.2 Mass storage controller: Texas Instruments 5-in-1 Multimedia 
Card Reader (SD/MMC/MS/MS PRO/xD)
	Subsystem: Acer Incorporated [ALI] Device 011c
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 57 (1750ns min, 1000ns max), Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 22
	Region 0: Memory at fc205000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: tifm_7xx1

0f:06.3 SD Host controller: Texas Instruments PCIxx12 SDA Standard 
Compliant SD Host Controller
	Subsystem: Acer Incorporated [ALI] Device 011c
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 57 (1750ns min, 1000ns max), Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 22
	Region 0: Memory at fc206800 (32-bit, non-prefetchable) [size=256]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: sdhci-pci

SCSI info:
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
   Vendor: Optiarc  Model: DVD RW AD-7560A  Rev: DX06
   Type:   CD-ROM                           ANSI  SCSI revision: 05
Host: scsi2 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: M4-CT064M4SSD2   Rev: 070H
   Type:   Direct-Access                    ANSI  SCSI revision: 05
