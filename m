From: "Thomas Moestl" <tmoestl@gmx.net>
Subject: PROBLEM: random hard freezes under X on Intel BayTrail-based
 machines unless intel_idle.max_cstate=1 is set
Date: Sat, 9 Jan 2016 23:32:16 +0100
Message-ID: <trinity-3d24d306-219d-4b10-96ca-3a982f0c5123-1452378736841@3capp-gmx-bs03>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.19]:51620 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756068AbcAIWcZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 9 Jan 2016 17:32:25 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: len.brown@intel.com
Cc: linux-pm@vger.kernel.org

[1.] One line summary of the problem:
Intel BayTrail-based machine experience hard freezes, as reported at e.g. https://bugzilla.kernel.org/show_bug.cgi?id=109051

[2.] Full description of the problem/report:
In my case, the machine in question is an ASUS R752MA laptop, but many other people
seem to be experiencing similar problems on a variety of BayTrail-based hardware
(see below).

System freezes hard when working under X, sometimes after minutes, sometimes after
hours. Usually, but not always, graphics-intensive applications like viewing videos
will trigger the hangs after a while, but they can also (much more rarely) occur when
e.g. only an xterm is opened and being worked in under.
The MagicSysReq keys are not functional any more once the hang has occurred, there
is no information in the logs, and no crash dump can be obtained by using the soft or
nmi watchdogs, panic_on_oops etc.

Some research has led me to https://bugzilla.kernel.org/show_bug.cgi?id=109051 ,
and I believe that it describes the exact problem I am experiencing. As you
can see from that bug report, the intel-drm team believes that the graphics
drivers are not to blame, and merely trigger the issue.
https://bugs.freedesktop.org/show_bug.cgi?id=88012 gives an overview of the
history of the drm-intel team's efforts regarding this issue.

As described in that report, adding intel_idle.max_cstate=1 seems to eliminate
the problem completely, and I am experiencing no freezes or other kernel problems
at all with it.

[3.] Keywords (i.e., modules, networking, kernel):

[4.] Kernel version (from /proc/version):
> cat /proc/version
Linux version 4.4.0-040400rc8-generic (kernel@gloin) (gcc version 5.2.1 20151010 (Ubuntu 5.2.1-22ubuntu2) ) #201601051225 SMP Tue Jan 5 17:27:39 UTC 2016

[5.] Output of Oops.. message with symbolic information resolved

n/a

[6.] A small shell script or example program which triggers the
     problem (if possible)

n/a

[7.] Environment
[7.1.] Software

Linux iain 4.4.0-040400rc8-generic #201601051225 SMP Tue Jan 5 17:27:39 UTC 2016 x86_64 x86_64 x86_64 GNU/Linux
 
GNU C			5.2.1
GNU Make		4.0
Binutils		2.25.1
Util-linux		2.26.2
Mount			2.26.2
Module-init-tools	21
E2fsprogs		1.42.12
Pcmciautils		018
PPP			2.4.6
Linux C Library		2.21
Dynamic linker (ldd)	2.21
Linux C++ Library	6.0.21
Procps			3.3.9
Net-tools		1.60
Kbd			1.15.5
Console-tools		1.15.5
Sh-utils		8.23
Udev			225
Wireless-tools		30
Modules Loaded		8250_dw ac97_bus ahci ansi_cprng arc4 asus_nb_wmi asus_wmi ath ath9k ath9k_common ath9k_hw autofs4 ccm cfg80211 coretemp crc32_pclmul crc_itu_t crct10dif_pclmul cryptd ctr drbg drm drm_kms_helper dvb_core dw_dmac dw_dmac_core fb_sys_fops fjes hid hid_generic i2c_algo_bit i2c_designware_core i2c_designware_platform i2c_hid i915 input_leds intel_powerclamp intel_rapl intel_soc_dts_iosf libahci lp lpc_ich mac80211 mac_hid media mei mei_txe memstick mii nls_iso8859_1 nls_utf8 parport parport_pc ppdev psmouse pwm_lpss pwm_lpss_platform r8169 rc_core rfkill_gpio rtsx_pci rtsx_pci_ms rtsx_pci_sdmmc sdhci sdhci_acpi serio_raw shpchp smsdvb smsmdtv smsusb snd snd_compress snd_hda_codec snd_hda_codec_generic snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_core snd_hda_intel snd_hwde
 p snd_intel_sst_acpi snd_intel_sst_core snd_pcm snd_pcm_dmaengine snd_rawmidi snd_seq snd_seq_device snd_seq_midi snd_seq_midi_event snd_soc_core snd_soc_rl6231 snd_soc_rt5640 snd_soc_sst_acpi snd_soc_sst_mfld_platform snd_timer soundcore sparse_keymap spi_pxa2xx_platform syscopyarea sysfillrect sysimgblt uas udf usbhid usb_storage uvcvideo v4l2_common video videobuf2_core videobuf2_memops videobuf2_v4l2 videobuf2_vmalloc videodev wmi

[7.2.] Processor information (from /proc/cpuinfo):
> cat /proc/cpuinfo
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 55
model name	: Intel(R) Celeron(R) CPU  N2940  @ 1.83GHz
stepping	: 8
microcode	: 0x815
cpu MHz		: 797.968
cache size	: 1024 KB
physical id	: 0
siblings	: 4
core id		: 0
cpu cores	: 4
apicid		: 0
initial apicid	: 0
fpu		: yes
fpu_exception	: yes
cpuid level	: 11
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm sse4_1 sse4_2 movbe popcnt tsc_deadline_timer rdrand lahf_lm 3dnowprefetch ida arat epb dtherm tpr_shadow vnmi flexpriority ept vpid tsc_adjust smep erms
bugs		:
bogomips	: 3660.80
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 55
model name	: Intel(R) Celeron(R) CPU  N2940  @ 1.83GHz
stepping	: 8
microcode	: 0x815
cpu MHz		: 573.260
cache size	: 1024 KB
physical id	: 0
siblings	: 4
core id		: 1
cpu cores	: 4
apicid		: 2
initial apicid	: 2
fpu		: yes
fpu_exception	: yes
cpuid level	: 11
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm sse4_1 sse4_2 movbe popcnt tsc_deadline_timer rdrand lahf_lm 3dnowprefetch ida arat epb dtherm tpr_shadow vnmi flexpriority ept vpid tsc_adjust smep erms
bugs		:
bogomips	: 3660.80
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:

processor	: 2
vendor_id	: GenuineIntel
cpu family	: 6
model		: 55
model name	: Intel(R) Celeron(R) CPU  N2940  @ 1.83GHz
stepping	: 8
microcode	: 0x815
cpu MHz		: 499.741
cache size	: 1024 KB
physical id	: 0
siblings	: 4
core id		: 2
cpu cores	: 4
apicid		: 4
initial apicid	: 4
fpu		: yes
fpu_exception	: yes
cpuid level	: 11
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm sse4_1 sse4_2 movbe popcnt tsc_deadline_timer rdrand lahf_lm 3dnowprefetch ida arat epb dtherm tpr_shadow vnmi flexpriority ept vpid tsc_adjust smep erms
bugs		:
bogomips	: 3660.80
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:

processor	: 3
vendor_id	: GenuineIntel
cpu family	: 6
model		: 55
model name	: Intel(R) Celeron(R) CPU  N2940  @ 1.83GHz
stepping	: 8
microcode	: 0x815
cpu MHz		: 499.741
cache size	: 1024 KB
physical id	: 0
siblings	: 4
core id		: 3
cpu cores	: 4
apicid		: 6
initial apicid	: 6
fpu		: yes
fpu_exception	: yes
cpuid level	: 11
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm sse4_1 sse4_2 movbe popcnt tsc_deadline_timer rdrand lahf_lm 3dnowprefetch ida arat epb dtherm tpr_shadow vnmi flexpriority ept vpid tsc_adjust smep erms
bugs		:
bogomips	: 3660.80
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:


[7.3.] Module information (from /proc/modules):
> cat /proc/modules
crct10dif_pclmul 16384 0 - Live 0x0000000000000000
snd_soc_rl6231 16384 1 snd_soc_rt5640, Live 0x0000000000000000
snd_hda_intel 36864 3 - Live 0x0000000000000000
snd_hda_codec 135168 4 snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel, Live 0x0000000000000000
ath9k_hw 466944 2 ath9k,ath9k_common, Live 0x0000000000000000
snd_intel_sst_core 73728 1 snd_intel_sst_acpi, Live 0x0000000000000000
snd_soc_sst_mfld_platform 90112 1 snd_intel_sst_core, Live 0x0000000000000000
snd_hda_core 65536 5 snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,snd_hda_codec, Live 0x0000000000000000
snd_soc_core 212992 2 snd_soc_rt5640,snd_soc_sst_mfld_platform, Live 0x0000000000000000
snd_compress 20480 1 snd_soc_core, Live 0x0000000000000000
ac97_bus 16384 1 snd_soc_core, Live 0x0000000000000000
crc32_pclmul 16384 0 - Live 0x0000000000000000
snd_hwdep 16384 1 snd_hda_codec, Live 0x0000000000000000
snd_pcm_dmaengine 16384 1 snd_soc_core, Live 0x0000000000000000
ath 32768 3 ath9k,ath9k_common,ath9k_hw, Live 0x0000000000000000
mac80211 724992 1 ath9k, Live 0x0000000000000000
snd_pcm 102400 8 snd_hda_codec_hdmi,snd_soc_rt5640,snd_hda_intel,snd_hda_codec,snd_soc_sst_mfld_platform,snd_hda_core,snd_soc_core,snd_pcm_dmaengine, Live 0x0000000000000000
cfg80211 557056 4 ath9k,ath9k_common,ath,mac80211, Live 0x0000000000000000
snd_seq_midi 16384 0 - Live 0x0000000000000000
snd_seq_midi_event 16384 1 snd_seq_midi, Live 0x0000000000000000
cryptd 20480 0 - Live 0x0000000000000000
snd_rawmidi 32768 1 snd_seq_midi, Live 0x0000000000000000
snd_seq 69632 2 snd_seq_midi,snd_seq_midi_event, Live 0x0000000000000000
input_leds 16384 0 - Live 0x0000000000000000
serio_raw 16384 0 - Live 0x0000000000000000
snd_seq_device 16384 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 0x0000000000000000
snd_timer 32768 2 snd_pcm,snd_seq, Live 0x0000000000000000
snd 81920 20 snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,snd_hda_codec,snd_soc_sst_mfld_platform,snd_soc_core,snd_compress,snd_hwdep,snd_pcm,snd_rawmidi,snd_seq,snd_seq_device,snd_timer, Live 0x0000000000000000
rtsx_pci_ms 20480 0 - Live 0x0000000000000000
dw_dmac 16384 0 - Live 0x0000000000000000
memstick 20480 1 rtsx_pci_ms, Live 0x0000000000000000
dw_dmac_core 24576 1 dw_dmac, Live 0x0000000000000000
mei_txe 20480 0 - Live 0x0000000000000000
soundcore 16384 1 snd, Live 0x0000000000000000
mei 98304 1 mei_txe, Live 0x0000000000000000
snd_soc_sst_acpi 16384 0 - Live 0x0000000000000000
rfkill_gpio 16384 0 - Live 0x0000000000000000
shpchp 36864 0 - Live 0x0000000000000000
spi_pxa2xx_platform 24576 0 - Live 0x0000000000000000
i2c_designware_platform 16384 0 - Live 0x0000000000000000
lpc_ich 24576 0 - Live 0x0000000000000000
i2c_designware_core 20480 1 i2c_designware_platform, Live 0x0000000000000000
8250_dw 16384 0 - Live 0x0000000000000000
pwm_lpss_platform 16384 0 - Live 0x0000000000000000
pwm_lpss 16384 1 pwm_lpss_platform, Live 0x0000000000000000
mac_hid 16384 0 - Live 0x0000000000000000
parport_pc 32768 0 - Live 0x0000000000000000
ppdev 20480 0 - Live 0x0000000000000000
lp 20480 0 - Live 0x0000000000000000
parport 49152 3 parport_pc,ppdev,lp, Live 0x0000000000000000
autofs4 40960 2 - Live 0x0000000000000000
hid_generic 16384 0 - Live 0x0000000000000000
usbhid 49152 0 - Live 0x0000000000000000
uas 24576 0 - Live 0x0000000000000000
usb_storage 69632 2 uas, Live 0x0000000000000000
rtsx_pci_sdmmc 24576 0 - Live 0x0000000000000000
i915 1204224 4 - Live 0x0000000000000000
i2c_algo_bit 16384 1 i915, Live 0x0000000000000000
psmouse 126976 0 - Live 0x0000000000000000
drm_kms_helper 135168 1 i915, Live 0x0000000000000000
syscopyarea 16384 1 drm_kms_helper, Live 0x0000000000000000
sysfillrect 16384 1 drm_kms_helper, Live 0x0000000000000000
sysimgblt 16384 1 drm_kms_helper, Live 0x0000000000000000
fb_sys_fops 16384 1 drm_kms_helper, Live 0x0000000000000000
r8169 81920 0 - Live 0x0000000000000000
drm 360448 5 i915,drm_kms_helper, Live 0x0000000000000000
rtsx_pci 53248 2 rtsx_pci_ms,rtsx_pci_sdmmc, Live 0x0000000000000000
mii 16384 1 r8169, Live 0x0000000000000000
ahci 36864 4 - Live 0x0000000000000000
wmi 20480 1 asus_wmi, Live 0x0000000000000000
libahci 32768 1 ahci, Live 0x0000000000000000
video 40960 2 asus_wmi,i915, Live 0x0000000000000000
fjes 28672 0 - Live 0x0000000000000000
i2c_hid 20480 0 - Live 0x0000000000000000
hid 118784 3 hid_generic,usbhid,i2c_hid, Live 0x0000000000000000
sdhci_acpi 16384 0 - Live 0x0000000000000000
sdhci 45056 1 sdhci_acpi, Live 0x0000000000000000

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
> cat /proc/ioports
0000-006f : PCI Bus 0000:00
  0000-001f : dma1
  0020-0021 : pic1
  0040-0043 : timer0
  0050-0053 : timer1
  0060-0060 : keyboard
  0062-0062 : PNP0C09:00
    0062-0062 : EC data
  0064-0064 : keyboard
  0066-0066 : PNP0C09:00
    0066-0066 : EC cmd
0070-0077 : PCI Bus 0000:00
  0070-0077 : rtc0
0078-0cf7 : PCI Bus 0000:00
  0080-008f : dma page reg
  00a0-00a1 : pic2
  00c0-00df : dma2
  00f0-00ff : fpu
  03f8-03ff : serial
  0400-047f : pnp 00:01
    0400-0403 : ACPI PM1a_EVT_BLK
    0404-0405 : ACPI PM1a_CNT_BLK
    0408-040b : ACPI PM_TMR
    0420-042f : ACPI GPE0_BLK
    0430-0433 : iTCO_wdt.0.auto
    0450-0450 : ACPI PM2_CNT_BLK
    0460-047f : iTCO_wdt.0.auto
  0500-05fe : pnp 00:01
  0600-061f : pnp 00:01
  0680-069f : pnp 00:01
0cf8-0cff : PCI conf1
0d00-ffff : PCI Bus 0000:00
  e000-efff : PCI Bus 0000:03
    e000-e0ff : 0000:03:00.1
      e000-e0ff : r8169
  f000-f01f : 0000:00:1f.3
  f020-f03f : 0000:00:13.0
    f020-f03f : ahci
  f040-f043 : 0000:00:13.0
    f040-f043 : ahci
  f050-f057 : 0000:00:13.0
    f050-f057 : ahci
  f060-f063 : 0000:00:13.0
    f060-f063 : ahci
  f070-f077 : 0000:00:13.0
    f070-f077 : ahci
  f080-f087 : 0000:00:02.0

> cat /proc/iomem
00000000-00000fff : reserved
00001000-0008efff : System RAM
0008f000-0008ffff : ACPI Non-volatile Storage
00090000-0009dfff : System RAM
0009e000-0009ffff : reserved
000a0000-000bffff : PCI Bus 0000:00
000c0000-000dffff : PCI Bus 0000:00
000e0000-000fffff : PCI Bus 0000:00
  000f0000-000fffff : System ROM
00100000-1fffffff : System RAM
  02000000-0280273f : Kernel code
  02802740-02f3bd3f : Kernel data
  030b2000-031f4fff : Kernel bss
20000000-200fffff : reserved
20100000-b8d21fff : System RAM
b8d22000-b8d51fff : reserved
b8d52000-b8e9bfff : System RAM
b8e9c000-b93a4fff : ACPI Non-volatile Storage
b93a5000-b9b31fff : reserved
b9b32000-b9b92fff : reserved
b9b93000-b9b93fff : System RAM
b9b94000-b9bd5fff : reserved
b9bd6000-b9d4bfff : System RAM
b9d4c000-b9ff9fff : reserved
b9ffa000-b9ffffff : System RAM
ba000000-baffffff : RAM buffer
bb000000-beffffff : reserved
  bb000000-beffffff : Graphics Stolen Memory
c0000000-d0815ffe : PCI Bus 0000:00
  c0000000-cfffffff : 0000:00:02.0
  d0000000-d03fffff : 0000:00:02.0
  d0400000-d04fffff : 0000:00:1a.0
    d0400000-d04fffff : mei_txe
  d0500000-d05fffff : 0000:00:1a.0
    d0500000-d05fffff : mei_txe
  d0600000-d06fffff : PCI Bus 0000:03
    d0600000-d0603fff : 0000:03:00.1
      d0600000-d0603fff : r8169
    d0604000-d0604fff : 0000:03:00.1
      d0604000-d0604fff : r8169
    d0605000-d0605fff : 0000:03:00.0
      d0605000-d0605fff : rtsx_pci
    d0610000-d061ffff : 0000:03:00.0
  d0700000-d07fffff : PCI Bus 0000:02
    d0700000-d077ffff : 0000:02:00.0
      d0700000-d077ffff : ath9k
    d0780000-d078ffff : 0000:02:00.0
  d0800000-d080ffff : 0000:00:14.0
    d0800000-d080ffff : xhci-hcd
  d0810000-d0813fff : 0000:00:1b.0
    d0810000-d0813fff : ICH HD audio
  d0814000-d081401f : 0000:00:1f.3
  d0815000-d08157ff : 0000:00:13.0
    d0815000-d08157ff : ahci
e0000000-efffffff : PCI MMCONFIG 0000 [bus 00-ff]
  e00000d0-e00000db : INT33BD:00
  e00f8000-e00f8fff : reserved
fec00000-fec003ff : IOAPIC 0
fed00000-fed003ff : HPET 0
  fed00000-fed003ff : PNP0103:00
fed01000-fed01fff : reserved
  fed01000-fed01fff : pnp 00:05
fed03000-fed03fff : pnp 00:05
  fed03008-fed0300c : iTCO_wdt.0.auto
fed04000-fed04fff : pnp 00:05
fed08000-fed08fff : pnp 00:05
fed0c000-fed0ffff : pnp 00:05
fed1c000-fed1cfff : pnp 00:05
fee00000-feefffff : pnp 00:05
  fee00000-fee00fff : Local APIC
fef00000-feffffff : pnp 00:05
ff000000-ffffffff : INT0800:00
  ffc00000-ffffffff : reserved
100000000-13fffffff : System RAM

[7.5.] PCI information ('lspci -vvv' as root)
> lspci -vvv
00:00.0 Host bridge: Intel Corporation Atom Processor Z36xxx/Z37xxx Series SoC Transaction Register (rev 0e)
	Subsystem: ASUSTeK Computer Inc. Device 16dd
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Kernel driver in use: iosf_mbi_pci

00:02.0 VGA compatible controller: Intel Corporation Atom Processor Z36xxx/Z37xxx Series Graphics & Display (rev 0e) (prog-if 00 [VGA controller])
	Subsystem: ASUSTeK Computer Inc. Device 16dd
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 91
	Region 0: Memory at d0000000 (32-bit, non-prefetchable) [size=4M]
	Region 2: Memory at c0000000 (32-bit, prefetchable) [size=256M]
	Region 4: I/O ports at f080 [size=8]
	Expansion ROM at <unassigned> [disabled]
	Capabilities: [d0] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee0f00c  Data: 41c1
	Capabilities: [b0] Vendor Specific Information: Len=07 <?>
	Kernel driver in use: i915

00:13.0 SATA controller: Intel Corporation Atom Processor E3800 Series SATA AHCI Controller (rev 0e) (prog-if 01 [AHCI 1.0])
	Subsystem: ASUSTeK Computer Inc. Device 16dd
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 88
	Region 0: I/O ports at f070 [size=8]
	Region 1: I/O ports at f060 [size=4]
	Region 2: I/O ports at f050 [size=8]
	Region 3: I/O ports at f040 [size=4]
	Region 4: I/O ports at f020 [size=32]
	Region 5: Memory at d0815000 (32-bit, non-prefetchable) [size=2K]
	Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee0300c  Data: 4191
	Capabilities: [70] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=00000004
	Kernel driver in use: ahci

00:14.0 USB controller: Intel Corporation Atom Processor Z36xxx/Z37xxx Series USB xHCI (rev 0e) (prog-if 30 [XHCI])
	Subsystem: ASUSTeK Computer Inc. Device 201f
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 87
	Region 0: Memory at d0800000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: [70] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [80] MSI: Enable+ Count=1/8 Maskable- 64bit+
		Address: 00000000fee0c00c  Data: 4181
	Kernel driver in use: xhci_hcd

00:1a.0 Encryption controller: Intel Corporation Atom Processor Z36xxx/Z37xxx Series Trusted Execution Engine (rev 0e)
	Subsystem: ASUSTeK Computer Inc. Device 16dd
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 92
	Region 0: Memory at d0500000 (32-bit, non-prefetchable) [size=1M]
	Region 1: Memory at d0400000 (32-bit, non-prefetchable) [size=1M]
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee0f00c  Data: 41d1
	Kernel driver in use: mei_txe

00:1b.0 Audio device: Intel Corporation Atom Processor Z36xxx/Z37xxx Series High Definition Audio Controller (rev 0e)
	Subsystem: ASUSTeK Computer Inc. Device 16dd
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 93
	Region 0: Memory at d0810000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee0f00c  Data: 4122
	Kernel driver in use: snd_hda_intel

00:1c.0 PCI bridge: Intel Corporation Atom Processor E3800 Series PCI Express Root Port 1 (rev 0e) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 16
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #1, Speed 5GT/s, Width x2, ASPM L0s L1, Exit Latency L0s <512ns, L1 <4us
			ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #0, PowerLimit 0.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
			Changed: MRL- PresDet- LinkState-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range BC, TimeoutDis+, LTR-, OBFF Not Supported ARIFwd-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
		LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
		Address: 00000000  Data: 0000
	Capabilities: [90] Subsystem: ASUSTeK Computer Inc. Device 16dd
	Capabilities: [a0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: pcieport

00:1c.2 PCI bridge: Intel Corporation Atom Processor E3800 Series PCI Express Root Port 3 (rev 0e) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin C routed to IRQ 18
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: d0700000-d07fffff
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #3, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <512ns, L1 <4us
			ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp-
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #2, PowerLimit 10.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet- LinkState-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range BC, TimeoutDis+, LTR-, OBFF Not Supported ARIFwd-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis+, LTR-, OBFF Disabled ARIFwd-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
		Address: 00000000  Data: 0000
	Capabilities: [90] Subsystem: ASUSTeK Computer Inc. Device 16dd
	Capabilities: [a0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: pcieport

00:1c.3 PCI bridge: Intel Corporation Atom Processor E3800 Series PCI Express Root Port 4 (rev 0e) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin D routed to IRQ 19
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
	I/O behind bridge: 0000e000-0000efff
	Memory behind bridge: d0600000-d06fffff
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #4, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <512ns, L1 <4us
			ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #3, PowerLimit 10.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet- LinkState-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range BC, TimeoutDis+, LTR-, OBFF Not Supported ARIFwd-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis+, LTR-, OBFF Disabled ARIFwd-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
		Address: 00000000  Data: 0000
	Capabilities: [90] Subsystem: ASUSTeK Computer Inc. Device 16dd
	Capabilities: [a0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: pcieport

00:1f.0 ISA bridge: Intel Corporation Atom Processor Z36xxx/Z37xxx Series Power Control Unit (rev 0e)
	Subsystem: ASUSTeK Computer Inc. Device 16dd
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Capabilities: [e0] Vendor Specific Information: Len=0c <?>
	Kernel driver in use: lpc_ich

00:1f.3 SMBus: Intel Corporation Atom Processor E3800 Series SMBus Controller (rev 0e)
	Subsystem: ASUSTeK Computer Inc. Device 16dd
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin B routed to IRQ 255
	Region 0: Memory at d0814000 (32-bit, non-prefetchable) [size=32]
	Region 4: I/O ports at f000 [size=32]
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-

02:00.0 Network controller: Qualcomm Atheros AR9485 Wireless Network Adapter (rev 01)
	Subsystem: Lite-On Communications Inc Device 6627
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 18
	Region 0: Memory at d0700000 (64-bit, non-prefetchable) [size=512K]
	Expansion ROM at d0780000 [disabled] [size=64K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] MSI: Enable- Count=1/4 Maskable+ 64bit+
		Address: 0000000000000000  Data: 0000
		Masking: 00000000  Pending: 00000000
	Capabilities: [70] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 <64us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <4us, L1 <64us
			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis+, LTR-, OBFF Not Supported
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis+, LTR-, OBFF Disabled
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
	Capabilities: [140 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=01
			Status:	NegoPending- InProgress-
	Capabilities: [160 v1] Device Serial Number 00-00-00-00-00-00-00-00
	Kernel driver in use: ath9k

03:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. Device 5287 (rev 01)
	Subsystem: ASUSTeK Computer Inc. Device 202f
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 89
	Region 0: Memory at d0605000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at d0610000 [disabled] [size=64K]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee0f00c  Data: 41a1
	Capabilities: [70] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s unlimited, L1 <64us
			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR+, OBFF Via message/WAKE#
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis+, LTR+, OBFF Disabled
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [b0] MSI-X: Enable- Count=1 Masked-
		Vector table: BAR=0 offset=00000000
		PBA: BAR=0 offset=00000000
	Capabilities: [d0] Vital Product Data
		Not readable
	Capabilities: [100 v2] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [140 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=01
			Status:	NegoPending- InProgress-
	Capabilities: [160 v1] Device Serial Number 00-00-00-00-00-00-00-00
	Capabilities: [170 v1] Latency Tolerance Reporting
		Max snoop latency: 71680ns
		Max no snoop latency: 71680ns
	Capabilities: [178 v1] L1 PM Substates
		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
			  PortCommonModeRestoreTime=150us PortTPowerOnTime=150us
	Kernel driver in use: rtsx_pci

03:00.1 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 12)
	Subsystem: ASUSTeK Computer Inc. Device 200f
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 90
	Region 0: I/O ports at e000 [size=256]
	Region 2: Memory at d0604000 (64-bit, non-prefetchable) [size=4K]
	Region 4: Memory at d0600000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee0f00c  Data: 41b1
	Capabilities: [70] Express (v2) Endpoint, MSI 01
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 4096 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s unlimited, L1 <64us
			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR+, OBFF Via message/WAKE#
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis+, LTR-, OBFF Disabled
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [b0] MSI-X: Enable- Count=4 Masked-
		Vector table: BAR=4 offset=00000000
		PBA: BAR=4 offset=00000800
	Capabilities: [d0] Vital Product Data
		Unknown small resource type 00, will not decode more.
	Capabilities: [100 v2] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [160 v1] Device Serial Number 25-38-21-13-68-4c-e0-00
	Capabilities: [170 v1] Latency Tolerance Reporting
		Max snoop latency: 71680ns
		Max no snoop latency: 71680ns
	Capabilities: [178 v1] L1 PM Substates
		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
			  PortCommonModeRestoreTime=150us PortTPowerOnTime=150us
	Kernel driver in use: r8169

[7.6.] SCSI information (from /proc/scsi/scsi)
> cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: TOSHIBA MQ01ABD1 Rev: 2J  
  Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: MATSHITA Model: DVD-RAM UJ8FBS   Rev: 1.00
  Type:   CD-ROM                           ANSI  SCSI revision: 05
Host: scsi2 Channel: 00 Id: 00 Lun: 00
  Vendor: TOSHIBA  Model: STOR.E ALU 2S    Rev: 0001
  Type:   Direct-Access                    ANSI  SCSI revision: 06

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
> cat /proc/cmdline
BOOT_IMAGE=/boot/vmlinuz-4.4.0-040400rc8-generic root=UUID=dbe91b1d-f01e-4f19-85eb-3877b67143ac ro quiet splash vt.handoff=7
> cat /sys/devices/system/cpu/cpuidle/current_driver
intel_idle
> cat /sys/devices/system/cpu/cpuidle/current_governor_ro 
menu
> cat /sys/devices/system/cpu/cpu0/cpuidle/state1/name
C1-BYT
> cat /sys/devices/system/cpu/cpu0/cpuidle/state1/desc 
MWAIT 0x00
> cat /sys/devices/system/cpu/cpu0/cpuidle/state2/name 
C6N-BYT
> cat /sys/devices/system/cpu/cpu0/cpuidle/state2/desc 
MWAIT 0x58
> cat /sys/devices/system/cpu/cpu0/cpuidle/state3/name
C6S-BYT
> cat /sys/devices/system/cpu/cpu0/cpuidle/state3/desc 
MWAIT 0x52
> cat /sys/devices/system/cpu/cpu0/cpuidle/state4/name 
C7-BYT
> cat /sys/devices/system/cpu/cpu0/cpuidle/state4/desc 
MWAIT 0x60
> cat /sys/devices/system/cpu/cpu0/cpuidle/state5/name 
C7S-BYT
> cat /sys/devices/system/cpu/cpu0/cpuidle/state5/desc 
MWAIT 0x64

[X.] Other notes, patches, fixes, workarounds:

