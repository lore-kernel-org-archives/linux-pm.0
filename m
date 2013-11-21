From: Benjamin Valentin <benpicco@zedat.fu-berlin.de>
Subject: PROBLEM: [regression] Corrupted low memory after resume from
 suspend, starting with 3.11-rc3
Date: Thu, 21 Nov 2013 16:09:16 +0100
Message-ID: <20131121160916.69985889@rechenknecht2k7>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:50987 "EHLO
	outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750827Ab3KUPSP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Nov 2013 10:18:15 -0500
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost1.zedat.fu-berlin.de (Exim 4.80.1)
          for linux-pm@vger.kernel.org with esmtp
          (envelope-from <benpicco@zedat.fu-berlin.de>)
          id <1VjVt0-003sgT-SC>; Thu, 21 Nov 2013 16:09:42 +0100
Received: from brln-4dbc4471.pool.mediaways.net ([77.188.68.113] helo=rechenknecht2k7)
          by inpost2.zedat.fu-berlin.de (Exim 4.80.1)
          for linux-pm@vger.kernel.org with esmtpsa
          (envelope-from <benpicco@zedat.fu-berlin.de>)
          id <1VjVt0-000aWR-BD>; Thu, 21 Nov 2013 16:09:42 +0100
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

Hello,
starting with Linux 3.11, resuming from suspend leads to corrupted low
memory on my Gigabyte 965P-DS3 board. As a result of this, the ethernet
interface won't come up again/the display doesn't turn back on after
resume.
I've used Ubuntu's mainline builds for convenience and 3.11-rc3 is the
first revision to exhibit the issue. However, 3.11-rc1 and 3.11-rc2
will fail to suspend entirely. With 3.10, no memory corruption happens
and the system suspends just fine.

The issue persists with 3.12.1:

Linux version 3.12.1-031201-generic (apw@gomeisa) (gcc version 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201311201654 SMP Wed Nov 20 21:54:49 UTC 2013

[  120.928037] Corrupted low memory at ffff88000000e4b8 (e4b8 phys) = 400000000000
[  120.928089] ------------[ cut here ]------------
[  120.928097] WARNING: CPU: 0 PID: 4 at /home/apw/COD/linux/arch/x86/kernel/check.c:140 check_for_bios_corruption+0x10e/0x120()
[  120.928099] Memory corruption detected in low memory
[  120.928138] Modules linked in: snd_hrtimer cuse ipt_MASQUERADE iptable_nat nf_nat_ipv4 nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_conntrack ipt_REJECT xt_CHECKSUM iptable_mangle xt_tcpudp bridge stp llc ip6table_filter ip6_tables iptable_filter ip_tables ebtable_nat ebtables x_tables hid_generic usbhid hid rfcomm bnep bluetooth binfmt_misc joydev xpad ff_memless kvm_intel kvm usb_storage gpio_ich ppdev ir_lirc_codec lirc_dev ir_sony_decoder ir_mce_kbd_decoder ir_jvc_decoder ir_sanyo_decoder ir_rc6_decoder ir_nec_decoder ir_rc5_decoder e4000 rtl2832 uvcvideo videobuf2_vmalloc videobuf2_memops videobuf2_core snd_usb_audio videodev snd_usbmidi_lib dvb_usb_rtl28xxu rtl2830 dvb_usb_v2 dvb_core rc_core snd_hda_codec_realtek snd_hda_intel snd_hda_codec snd_hwdep microcode snd_pcm 
 snd_page_alloc snd_seq_midi snd_seq_midi_event serio_raw pcspkr snd_rawmidi lpc_ich snd_seq parport_pc snd_seq_device snd_timer snd mac_hid soundcore it87 hwmon_vid coretemp lp parport pata_acpi pata_jmicron ahci sky2 libahci
[  120.928226] CPU: 0 PID: 4 Comm: kworker/0:0 Not tainted 3.12.1-031201-generic #201311201654
[  120.928227] Hardware name: Gigabyte Technology Co., Ltd. 965P-DS3/965P-DS3, BIOS F14d 12/18/2008
[  120.928230] Workqueue: events check_corruption
[  120.928231]  000000000000008c ffff880196907ce8 ffffffff81743072 0000000000000007
[  120.928234]  ffff880196907d38 ffff880196907d28 ffffffff8106783c 0000000000000000
[  120.928237]  0000000000000000 ffff880000010000 ffffffff81eaa550 0000000000000001
[  120.928239] Call Trace:
[  120.928245]  [<ffffffff81743072>] dump_stack+0x46/0x58
[  120.928248]  [<ffffffff8106783c>] warn_slowpath_common+0x8c/0xc0
[  120.928250]  [<ffffffff81067926>] warn_slowpath_fmt+0x46/0x50
[  120.928253]  [<ffffffff8105392e>] check_for_bios_corruption+0x10e/0x120
[  120.928255]  [<ffffffff8105394e>] check_corruption+0xe/0x40
[  120.928258]  [<ffffffff8108430f>] process_one_work+0x17f/0x4d0
[  120.928260]  [<ffffffff8108556b>] worker_thread+0x11b/0x3d0
[  120.928263]  [<ffffffff81085450>] ? manage_workers.isra.21+0x1b0/0x1b0
[  120.928266]  [<ffffffff8108c730>] kthread+0xc0/0xd0
[  120.928268]  [<ffffffff8108c670>] ? flush_kthread_worker+0xb0/0xb0
[  120.928271]  [<ffffffff817589bc>] ret_from_fork+0x7c/0xb0
[  120.928274]  [<ffffffff8108c670>] ? flush_kthread_worker+0xb0/0xb0
[  120.928275] ---[ end trace 8e59943a75dd09ae ]---

[6.] A small shell script or example program which triggers the problem (if possible)

 echo mem > /sys/power/state

[7.1.] Software (add the output of the ver_linux script here)

Linux rechenknecht2k7 3.12.1-031201-generic #201311201654 SMP Wed Nov 20 21:54:49 UTC 2013 x86_64 x86_64 x86_64 GNU/Linux
 
Gnu C                  4.8
Gnu make               3.81
binutils               2.23.52.20130913
util-linux             2.20.1
mount                  support
module-init-tools      9
e2fsprogs              1.42.8
pcmciautils            018
Linux C Library        2.17
Dynamic linker (ldd)   2.17
Procps                 3.3.3
Net-tools              1.60
Kbd                    1.15.5
Sh-utils               8.20
wireless-tools         30
Modules Loaded         snd_hrtimer cuse ipt_MASQUERADE iptable_nat nf_nat_ipv4 nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_conntrack ipt_REJECT xt_CHECKSUM iptable_mangle xt_tcpudp bridge stp llc ip6table_filter ip6_tables iptable_filter ip_tables ebtable_nat ebtables x_tables hid_generic usbhid hid rfcomm bnep bluetooth binfmt_misc joydev xpad ff_memless kvm_intel kvm usb_storage gpio_ich ppdev ir_lirc_codec lirc_dev ir_sony_decoder ir_mce_kbd_decoder ir_jvc_decoder ir_sanyo_decoder ir_rc6_decoder ir_nec_decoder ir_rc5_decoder e4000 rtl2832 uvcvideo videobuf2_vmalloc videobuf2_memops videobuf2_core snd_usb_audio videodev snd_usbmidi_lib dvb_usb_rtl28xxu rtl2830 dvb_usb_v2 dvb_core rc_core snd_hda_codec_realtek snd_hda_intel snd_hda_codec snd_hwdep microcode snd_pcm snd_page_al
 loc snd_seq_midi snd_seq_midi_event serio_raw pcspkr snd_rawmidi lpc_ich snd_seq parport_pc snd_seq_device snd_timer snd mac_hid soundcore it87 hwmon_vid coretemp lp parport pata_acpi pata_jmicron ahci sky2 libahci

[7.2.] Processor information (from /proc/cpuinfo):

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 23
model name	: Intel(R) Core(TM)2 Duo CPU     E7500  @ 2.93GHz
stepping	: 10
microcode	: 0xa07
cpu MHz		: 1600.000
cache size	: 3072 KB
physical id	: 0
siblings	: 2
core id		: 0
cpu cores	: 2
apicid		: 0
initial apicid	: 0
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx lm constant_tsc arch_perfmon pebs bts rep_good nopl aperfmperf pni dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm sse4_1 xsave lahf_lm dtherm tpr_shadow vnmi flexpriority
bogomips	: 5867.08
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 23
model name	: Intel(R) Core(TM)2 CPU         E7500  @ 2.93GHz
stepping	: 10
cpu MHz		: 1600.000
cache size	: 3072 KB
physical id	: 0
siblings	: 2
core id		: 1
cpu cores	: 2
apicid		: 1
initial apicid	: 1
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx lm constant_tsc arch_perfmon pebs bts rep_good nopl aperfmperf pni dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm sse4_1 xsave lahf_lm dtherm tpr_shadow vnmi flexpriority
bogomips	: 5867.08
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:

[7.3.] Module information (from /proc/modules):

snd_hrtimer 12744 1 - Live 0x0000000000000000
cuse 13566 3 - Live 0x0000000000000000
ipt_MASQUERADE 12880 3 - Live 0x0000000000000000
iptable_nat 13151 1 - Live 0x0000000000000000
nf_nat_ipv4 13316 1 iptable_nat, Live 0x0000000000000000
nf_nat 21722 3 ipt_MASQUERADE,iptable_nat,nf_nat_ipv4, Live 0x0000000000000000
nf_conntrack_ipv4 15063 2 - Live 0x0000000000000000
nf_defrag_ipv4 12758 1 nf_conntrack_ipv4, Live 0x0000000000000000
xt_conntrack 12760 1 - Live 0x0000000000000000
nf_conntrack 97489 6 ipt_MASQUERADE,iptable_nat,nf_nat_ipv4,nf_nat,nf_conntrack_ipv4,xt_conntrack, Live 0x0000000000000000
ipt_REJECT 12576 2 - Live 0x0000000000000000
xt_CHECKSUM 12549 1 - Live 0x0000000000000000
iptable_mangle 12734 1 - Live 0x0000000000000000
xt_tcpudp 12924 5 - Live 0x0000000000000000
bridge 112035 0 - Live 0x0000000000000000
stp 12976 1 bridge, Live 0x0000000000000000
llc 14597 2 bridge,stp, Live 0x0000000000000000
ip6table_filter 12815 0 - Live 0x0000000000000000
ip6_tables 27502 1 ip6table_filter, Live 0x0000000000000000
iptable_filter 12810 1 - Live 0x0000000000000000
ip_tables 27716 3 iptable_nat,iptable_mangle,iptable_filter, Live 0x0000000000000000
ebtable_nat 12807 0 - Live 0x0000000000000000
ebtables 31209 1 ebtable_nat, Live 0x0000000000000000
x_tables 34194 11 ipt_MASQUERADE,xt_conntrack,ipt_REJECT,xt_CHECKSUM,iptable_mangle,xt_tcpudp,ip6table_filter,ip6_tables,iptable_filter,ip_tables,ebtables, Live 0x0000000000000000
hid_generic 12548 0 - Live 0x0000000000000000
usbhid 53067 0 - Live 0x0000000000000000
hid 106254 2 hid_generic,usbhid, Live 0x0000000000000000
rfcomm 74748 0 - Live 0x0000000000000000
bnep 24107 2 - Live 0x0000000000000000
bluetooth 391788 10 rfcomm,bnep, Live 0x0000000000000000
binfmt_misc 17508 1 - Live 0x0000000000000000
joydev 17575 0 - Live 0x0000000000000000
xpad 18546 0 - Live 0x0000000000000000
ff_memless 13704 1 xpad, Live 0x0000000000000000
kvm_intel 144079 0 - Live 0x0000000000000000
kvm 458033 1 kvm_intel, Live 0x0000000000000000
usb_storage 66714 0 - Live 0x0000000000000000
gpio_ich 13526 0 - Live 0x0000000000000000
ppdev 17711 0 - Live 0x0000000000000000
ir_lirc_codec 13021 0 - Live 0x0000000000000000
lirc_dev 20018 1 ir_lirc_codec, Live 0x0000000000000000
ir_sony_decoder 12713 0 - Live 0x0000000000000000
ir_mce_kbd_decoder 13359 0 - Live 0x0000000000000000
ir_jvc_decoder 12751 0 - Live 0x0000000000000000
ir_sanyo_decoder 12839 0 - Live 0x0000000000000000
ir_rc6_decoder 12874 0 - Live 0x0000000000000000
ir_nec_decoder 12915 0 - Live 0x0000000000000000
ir_rc5_decoder 12710 0 - Live 0x0000000000000000
e4000 13729 1 - Live 0x0000000000000000
rtl2832 19248 1 - Live 0x0000000000000000
uvcvideo 82247 0 - Live 0x0000000000000000
videobuf2_vmalloc 13216 1 uvcvideo, Live 0x0000000000000000
videobuf2_memops 13362 1 videobuf2_vmalloc, Live 0x0000000000000000
videobuf2_core 40933 1 uvcvideo, Live 0x0000000000000000
snd_usb_audio 155972 0 - Live 0x0000000000000000
videodev 139263 2 uvcvideo,videobuf2_core, Live 0x0000000000000000
snd_usbmidi_lib 29576 1 snd_usb_audio, Live 0x0000000000000000
dvb_usb_rtl28xxu 29951 0 - Live 0x0000000000000000
rtl2830 18755 1 dvb_usb_rtl28xxu, Live 0x0000000000000000
dvb_usb_v2 36503 1 dvb_usb_rtl28xxu, Live 0x0000000000000000
dvb_core 122621 3 rtl2832,rtl2830,dvb_usb_v2, Live 0x0000000000000000
rc_core 28163 12 ir_lirc_codec,lirc_dev,ir_sony_decoder,ir_mce_kbd_decoder,ir_jvc_decoder,ir_sanyo_decoder,ir_rc6_decoder,ir_nec_decoder,ir_rc5_decoder,dvb_usb_rtl28xxu,dvb_usb_v2, Live 0x0000000000000000
snd_hda_codec_realtek 56888 1 - Live 0x0000000000000000
snd_hda_intel 57183 0 - Live 0x0000000000000000
snd_hda_codec 194881 2 snd_hda_codec_realtek,snd_hda_intel, Live 0x0000000000000000
snd_hwdep 13613 2 snd_usb_audio,snd_hda_codec, Live 0x0000000000000000
microcode 23708 0 - Live 0x0000000000000000
snd_pcm 107140 3 snd_usb_audio,snd_hda_intel,snd_hda_codec, Live 0x0000000000000000
snd_page_alloc 18798 2 snd_hda_intel,snd_pcm, Live 0x0000000000000000
snd_seq_midi 13324 0 - Live 0x0000000000000000
snd_seq_midi_event 14899 1 snd_seq_midi, Live 0x0000000000000000
serio_raw 13462 0 - Live 0x0000000000000000
pcspkr 12718 0 - Live 0x0000000000000000
snd_rawmidi 30465 2 snd_usbmidi_lib,snd_seq_midi, Live 0x0000000000000000
lpc_ich 21163 0 - Live 0x0000000000000000
snd_seq 66061 3 snd_seq_midi,snd_seq_midi_event, Live 0x0000000000000000
parport_pc 32866 1 - Live 0x0000000000000000
snd_seq_device 14497 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 0x0000000000000000
snd_timer 30038 3 snd_hrtimer,snd_pcm,snd_seq, Live 0x0000000000000000
snd 73802 14 snd_hrtimer,snd_usb_audio,snd_usbmidi_lib,snd_hda_codec_realtek,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_seq_midi,snd_rawmidi,snd_seq,snd_seq_device,snd_timer, Live 0x0000000000000000
mac_hid 13253 0 - Live 0x0000000000000000
soundcore 12680 1 snd, Live 0x0000000000000000
it87 47334 0 - Live 0x0000000000000000
hwmon_vid 12827 1 it87, Live 0x0000000000000000
coretemp 17728 0 - Live 0x0000000000000000
lp 17799 0 - Live 0x0000000000000000
parport 42481 3 ppdev,parport_pc,lp, Live 0x0000000000000000
pata_acpi 13038 0 - Live 0x0000000000000000
pata_jmicron 12758 0 - Live 0x0000000000000000
ahci 30063 9 - Live 0x0000000000000000
sky2 63205 0 - Live 0x0000000000000000
libahci 32118 1 ahci, Live 0x0000000000000000

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

0000-0cf7 : PCI Bus 0000:00
  0000-001f : dma1
  0020-0021 : pic1
  0040-0043 : timer0
  0050-0053 : timer1
  0060-0060 : keyboard
  0064-0064 : keyboard
  0070-0073 : rtc0
  0080-008f : dma page reg
  00a0-00a1 : pic2
  00c0-00df : dma2
  00f0-00ff : fpu
  0290-029f : pnp 00:00
    0290-0294 : pnp 00:00
    0295-0296 : it87
      0295-0296 : it87
  0378-037a : parport0
  03c0-03df : vga+
  03f8-03ff : serial
  0400-0403 : ACPI PM1a_EVT_BLK
  0404-0405 : ACPI PM1a_CNT_BLK
  0408-040b : ACPI PM_TMR
  0410-0415 : ACPI CPU throttle
  0428-042f : ACPI GPE0_BLK
  0430-0433 : iTCO_wdt
  0460-047f : iTCO_wdt
  0480-04bf : gpio_ich
    0480-04bf : 0000:00:1f.0
      0480-04af : gpio_ich
      04b0-04bf : gpio_ich
  04d0-04d1 : pnp 00:00
  0500-051f : 0000:00:1f.3
  0800-087f : pnp 00:00
  0880-088f : pnp 00:00
0cf8-0cff : PCI conf1
0d00-ffff : PCI Bus 0000:00
  6000-6fff : PCI Bus 0000:05
  7000-7fff : PCI Bus 0000:02
  8000-8fff : PCI Bus 0000:01
    8000-807f : 0000:01:00.0
  9000-afff : PCI Bus 0000:03
    9000-9007 : 0000:03:00.1
      9000-9007 : pata_jmicron
    9400-9403 : 0000:03:00.1
      9400-9403 : pata_jmicron
    9800-9807 : 0000:03:00.1
      9800-9807 : pata_jmicron
    9c00-9c03 : 0000:03:00.1
      9c00-9c03 : pata_jmicron
    a000-a00f : 0000:03:00.1
      a000-a00f : pata_jmicron
  b000-bfff : PCI Bus 0000:04
    b000-b0ff : 0000:04:00.0
      b000-b0ff : sky2
  c000-c01f : 0000:00:1a.0
    c000-c01f : uhci_hcd
  c400-c41f : 0000:00:1a.1
    c400-c41f : uhci_hcd
  c800-c81f : 0000:00:1d.0
    c800-c81f : uhci_hcd
  cc00-cc1f : 0000:00:1d.1
    cc00-cc1f : uhci_hcd
  d000-d01f : 0000:00:1d.2
    d000-d01f : uhci_hcd
  d400-d407 : 0000:00:1f.2
    d400-d407 : ahci
  d800-d803 : 0000:00:1f.2
    d800-d803 : ahci
  dc00-dc07 : 0000:00:1f.2
    dc00-dc07 : ahci
  e000-e003 : 0000:00:1f.2
    e000-e003 : ahci
  e400-e41f : 0000:00:1f.2
    e400-e41f : ahci

00000000-00000fff : reserved
00001000-0009e7ff : System RAM
0009e800-0009f7ff : RAM buffer
0009f800-0009ffff : reserved
000a0000-000bffff : PCI Bus 0000:00
000c0000-000dffff : PCI Bus 0000:00
  000c0000-000cd1ff : Video ROM
  000d5000-000d7fff : pnp 00:0c
000e0000-000effff : pnp 00:0c
000f0000-000fffff : reserved
  000f0000-000fffff : System ROM
00100000-dfedffff : System RAM
  01000000-0175d0e4 : Kernel code
  0175d0e5-01d17a3f : Kernel data
  01e70000-01fd1fff : Kernel bss
dfee0000-dfee2fff : ACPI Non-volatile Storage
dfee3000-dfeeffff : ACPI Tables
dfef0000-dfefffff : reserved
dff00000-febfffff : PCI Bus 0000:00
  e0000000-efffffff : PCI Bus 0000:01
    e0000000-efffffff : 0000:01:00.0
  f0000000-f3ffffff : PCI MMCONFIG 0000 [bus 00-3f]
    f0000000-f3ffffff : reserved
      f0000000-f3ffffff : pnp 00:0b
  f4000000-f7ffffff : PCI Bus 0000:01
    f4000000-f5ffffff : 0000:01:00.0
    f6000000-f6ffffff : 0000:01:00.0
    f7000000-f701ffff : 0000:01:00.0
  f8000000-f9ffffff : PCI Bus 0000:04
    f9000000-f9003fff : 0000:04:00.0
      f9000000-f9003fff : sky2
  fa000000-fa0fffff : PCI Bus 0000:03
    fa000000-fa001fff : 0000:03:00.0
      fa000000-fa001fff : ahci
  fa100000-fa103fff : 0000:00:1b.0
    fa100000-fa103fff : ICH HD audio
  fa104000-fa1043ff : 0000:00:1a.7
    fa104000-fa1043ff : ehci_hcd
  fa105000-fa1053ff : 0000:00:1d.7
    fa105000-fa1053ff : ehci_hcd
  fa106000-fa1067ff : 0000:00:1f.2
    fa106000-fa1067ff : ahci
  fa107000-fa1070ff : 0000:00:1f.3
  fa200000-fa3fffff : PCI Bus 0000:02
  fa400000-fa5fffff : PCI Bus 0000:02
  fa600000-fa7fffff : PCI Bus 0000:03
  fa800000-faafffff : PCI Bus 0000:04
    fa800000-fa81ffff : 0000:04:00.0
fec00000-ffffffff : reserved
  fec00000-fec003ff : IOAPIC 0
  fed00000-fed003ff : HPET 0
  fed10000-fed1dfff : pnp 00:0c
  fed1f410-fed1f414 : iTCO_wdt
  fed20000-fed8ffff : pnp 00:0c
  fee00000-fee00fff : Local APIC
    fee00000-fee00fff : pnp 00:0c
  ffb00000-ffb7ffff : pnp 00:0c
  fff00000-ffffffff : pnp 00:0c
100000000-19fffffff : System RAM

[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: Intel Corporation 82P965/G965 Memory Controller Hub (rev 02)
	Subsystem: Gigabyte Technology Co., Ltd Device 5000
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR- INTx-
	Latency: 0
	Capabilities: [e0] Vendor Specific Information: Len=09 <?>

00:01.0 PCI bridge: Intel Corporation 82P965/G965 PCI Express Root Port (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 32 bytes
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 00008000-00008fff
	Memory behind bridge: f4000000-f7ffffff
	Prefetchable memory behind bridge: 00000000e0000000-00000000efffffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [88] Subsystem: Gigabyte Technology Co., Ltd Device 5000
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee0300c  Data: 4191
	Capabilities: [a0] Express (v1) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #2, Speed 2.5GT/s, Width x16, ASPM L0s, Latency L0 <256ns, L1 <4us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x16, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #32, PowerLimit 75.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Off, PwrInd On, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet+ LinkState-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
	Capabilities: [100 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=01
			Status:	NegoPending- InProgress-
	Capabilities: [140 v1] Root Complex Link
		Desc:	PortNumber=02 ComponentID=01 EltType=Config
		Link0:	Desc:	TargetPort=00 TargetComponent=01 AssocRCRB- LinkType=MemMapped LinkValid+
			Addr:	00000000fed19000
	Kernel driver in use: pcieport

00:1a.0 USB controller: Intel Corporation 82801H (ICH8 Family) USB UHCI Controller #4 (rev 02) (prog-if 00 [UHCI])
	Subsystem: Gigabyte Technology Co., Ltd Device 5004
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	Region 4: I/O ports at c000 [size=32]
	Kernel driver in use: uhci_hcd

00:1a.1 USB controller: Intel Corporation 82801H (ICH8 Family) USB UHCI Controller #5 (rev 02) (prog-if 00 [UHCI])
	Subsystem: Gigabyte Technology Co., Ltd Device 5004
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin B routed to IRQ 21
	Region 4: I/O ports at c400 [size=32]
	Kernel driver in use: uhci_hcd

00:1a.7 USB controller: Intel Corporation 82801H (ICH8 Family) USB2 EHCI Controller #2 (rev 02) (prog-if 20 [EHCI])
	Subsystem: Gigabyte Technology Co., Ltd Device 5006
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin C routed to IRQ 18
	Region 0: Memory at fa104000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Debug port: BAR=1 offset=00a0
	Kernel driver in use: ehci-pci

00:1b.0 Audio device: Intel Corporation 82801H (ICH8 Family) HD Audio Controller (rev 02)
	Subsystem: Gigabyte Technology Co., Ltd Device a002
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 46
	Region 0: Memory at fa100000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee0300c  Data: 4152
	Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed unknown, Width x0, ASPM unknown, Latency L0 <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed unknown, Width x0, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
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
		Link0:	Desc:	TargetPort=00 TargetComponent=02 AssocRCRB- LinkType=MemMapped LinkValid+
			Addr:	00000000fed1c000
	Kernel driver in use: snd_hda_intel

00:1c.0 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express Port 1 (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 32 bytes
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	I/O behind bridge: 00007000-00007fff
	Memory behind bridge: fa200000-fa3fffff
	Prefetchable memory behind bridge: 00000000fa400000-00000000fa5fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #1, Speed 2.5GT/s, Width x1, ASPM L0s, Latency L0 <1us, L1 <4us
			ClockPM- Surprise- LLActRep+ BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
			Slot #16, PowerLimit 10.000W; Interlock- NoCompl-
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
			Changed: MRL- PresDet- LinkState-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
	Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee0300c  Data: 41a1
	Capabilities: [90] Subsystem: Gigabyte Technology Co., Ltd Device 5001
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
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
		Link0:	Desc:	TargetPort=00 TargetComponent=02 AssocRCRB- LinkType=MemMapped LinkValid+
			Addr:	00000000fed1c001
	Kernel driver in use: pcieport

00:1c.3 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express Port 4 (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 32 bytes
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
	I/O behind bridge: 00009000-0000afff
	Memory behind bridge: fa000000-fa0fffff
	Prefetchable memory behind bridge: 00000000fa600000-00000000fa7fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #4, Speed 2.5GT/s, Width x1, ASPM L0s, Latency L0 <256ns, L1 <4us
			ClockPM- Surprise- LLActRep+ BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
			Slot #19, PowerLimit 10.000W; Interlock- NoCompl-
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet- LinkState-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
	Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee0300c  Data: 41b1
	Capabilities: [90] Subsystem: Gigabyte Technology Co., Ltd Device 5001
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
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
		Desc:	PortNumber=04 ComponentID=02 EltType=Config
		Link0:	Desc:	TargetPort=00 TargetComponent=02 AssocRCRB- LinkType=MemMapped LinkValid+
			Addr:	00000000fed1c001
	Kernel driver in use: pcieport

00:1c.4 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express Port 5 (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 32 bytes
	Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
	I/O behind bridge: 0000b000-0000bfff
	Memory behind bridge: f8000000-f9ffffff
	Prefetchable memory behind bridge: 00000000fa800000-00000000faafffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #5, Speed 2.5GT/s, Width x1, ASPM L0s, Latency L0 <256ns, L1 <4us
			ClockPM- Surprise- LLActRep+ BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
			Slot #20, PowerLimit 10.000W; Interlock- NoCompl-
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet- LinkState-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
	Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee0300c  Data: 41c1
	Capabilities: [90] Subsystem: Gigabyte Technology Co., Ltd Device 5001
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
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
		Desc:	PortNumber=05 ComponentID=02 EltType=Config
		Link0:	Desc:	TargetPort=00 TargetComponent=02 AssocRCRB- LinkType=MemMapped LinkValid+
			Addr:	00000000fed1c001
	Kernel driver in use: pcieport

00:1d.0 USB controller: Intel Corporation 82801H (ICH8 Family) USB UHCI Controller #1 (rev 02) (prog-if 00 [UHCI])
	Subsystem: Gigabyte Technology Co., Ltd Device 5004
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 23
	Region 4: I/O ports at c800 [size=32]
	Kernel driver in use: uhci_hcd

00:1d.1 USB controller: Intel Corporation 82801H (ICH8 Family) USB UHCI Controller #2 (rev 02) (prog-if 00 [UHCI])
	Subsystem: Gigabyte Technology Co., Ltd Device 5004
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin B routed to IRQ 19
	Region 4: I/O ports at cc00 [size=32]
	Kernel driver in use: uhci_hcd

00:1d.2 USB controller: Intel Corporation 82801H (ICH8 Family) USB UHCI Controller #3 (rev 02) (prog-if 00 [UHCI])
	Subsystem: Gigabyte Technology Co., Ltd Device 5004
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin C routed to IRQ 18
	Region 4: I/O ports at d000 [size=32]
	Kernel driver in use: uhci_hcd

00:1d.7 USB controller: Intel Corporation 82801H (ICH8 Family) USB2 EHCI Controller #1 (rev 02) (prog-if 20 [EHCI])
	Subsystem: Gigabyte Technology Co., Ltd Device 5006
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 23
	Region 0: Memory at fa105000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Debug port: BAR=1 offset=00a0
	Kernel driver in use: ehci-pci

00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev f2) (prog-if 01 [Subtractive decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Bus: primary=00, secondary=05, subordinate=05, sec-latency=64
	I/O behind bridge: 00006000-00006fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [50] Subsystem: Gigabyte Technology Co., Ltd Motherboard

00:1f.0 ISA bridge: Intel Corporation 82801HB/HR (ICH8/R) LPC Interface Controller (rev 02)
	Subsystem: Gigabyte Technology Co., Ltd Device 5001
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Capabilities: [e0] Vendor Specific Information: Len=0c <?>
	Kernel driver in use: lpc_ich

00:1f.2 SATA controller: Intel Corporation 82801HB (ICH8) 4 port SATA Controller [AHCI mode] (rev 02) (prog-if 01 [AHCI 1.0])
	Subsystem: Gigabyte Technology Co., Ltd Device b005
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin B routed to IRQ 45
	Region 0: I/O ports at d400 [size=8]
	Region 1: I/O ports at d800 [size=4]
	Region 2: I/O ports at dc00 [size=8]
	Region 3: I/O ports at e000 [size=4]
	Region 4: I/O ports at e400 [size=32]
	Region 5: Memory at fa106000 (32-bit, non-prefetchable) [size=2K]
	Capabilities: [80] MSI: Enable+ Count=1/16 Maskable- 64bit-
		Address: fee0100c  Data: 41e1
	Capabilities: [70] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=00000004
	Kernel driver in use: ahci

00:1f.3 SMBus: Intel Corporation 82801H (ICH8 Family) SMBus Controller (rev 02)
	Subsystem: Gigabyte Technology Co., Ltd Device 5001
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin C routed to IRQ 14
	Region 0: Memory at fa107000 (32-bit, non-prefetchable) [size=256]
	Region 4: I/O ports at 0500 [size=32]

01:00.0 VGA compatible controller: NVIDIA Corporation G92 [GeForce 9800 GT] (rev a2) (prog-if 00 [VGA controller])
	Subsystem: Elitegroup Computer Systems Device 1a08
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 15
	Region 0: Memory at f6000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at e0000000 (64-bit, prefetchable) [size=256M]
	Region 3: Memory at f4000000 (64-bit, non-prefetchable) [size=32M]
	Region 5: I/O ports at 8000 [size=128]
	[virtual] Expansion ROM at f7000000 [disabled] [size=128K]
	Capabilities: [60] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [68] MSI: Enable- Count=1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [78] Express (v1) Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 <4us
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x16, ASPM L0s L1, Latency L0 <512ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 128 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x16, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
	Capabilities: [100 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=01
			Status:	NegoPending- InProgress-
	Capabilities: [128 v1] Power Budgeting <?>
	Capabilities: [600 v1] Vendor Specific Information: ID=0001 Rev=1 Len=024 <?>

03:00.0 SATA controller: JMicron Technology Corp. JMB363 SATA/IDE Controller (rev 02) (prog-if 01 [AHCI 1.0])
	Subsystem: Gigabyte Technology Co., Ltd Motherboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 19
	Region 5: Memory at fa000000 (32-bit, non-prefetchable) [size=8K]
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] Express (v1) Legacy Endpoint, MSI 01
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #1, Speed 2.5GT/s, Width x1, ASPM L0s, Latency L0 unlimited, L1 unlimited
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
	Kernel driver in use: ahci

03:00.1 IDE interface: JMicron Technology Corp. JMB363 SATA/IDE Controller (rev 02) (prog-if 85 [Master SecO PriO])
	Subsystem: Gigabyte Technology Co., Ltd Motherboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 32 bytes
	Interrupt: pin B routed to IRQ 16
	Region 0: I/O ports at 9000 [size=8]
	Region 1: I/O ports at 9400 [size=4]
	Region 2: I/O ports at 9800 [size=8]
	Region 3: I/O ports at 9c00 [size=4]
	Region 4: I/O ports at a000 [size=16]
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: pata_jmicron

04:00.0 Ethernet controller: Marvell Technology Group Ltd. 88E8053 PCI-E Gigabit Ethernet Controller (rev 22)
	Subsystem: Gigabyte Technology Co., Ltd Marvell 88E8053 Gigabit Ethernet Controller (Gigabyte)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 44
	Region 0: Memory at f9000000 (64-bit, non-prefetchable) [size=16K]
	Region 2: I/O ports at b000 [size=256]
	[virtual] Expansion ROM at fa800000 [disabled] [size=128K]
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] Vital Product Data
		Product Name: Marvell Yukon 88E8053 Gigabit Ethernet Controller
		Read-only fields:
			[PN] Part number: Yukon 88E8053
			[EC] Engineering changes: Rev. 2.2
			[MN] Manufacture ID: 4d 61 72 76 65 6c 6c
			[SN] Serial number: AbCdEfG8D454A
			[CP] Extended capability: 01 10 cc 03
			[RV] Reserved: checksum good, 9 byte(s) reserved
		Read/write fields:
			[RW] Read-write area: 121 byte(s) free
		End
	Capabilities: [5c] MSI: Enable+ Count=1/2 Maskable- 64bit+
		Address: 00000000fee0100c  Data: 41d1
	Capabilities: [e0] Express (v1) Legacy Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s, Latency L0 <256ns, L1 unlimited
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 128 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr+ BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		AERCap:	First Error Pointer: 1f, GenCap- CGenEn- ChkCap- ChkEn-
	Kernel driver in use: sky2


[7.6.] SCSI information (from /proc/scsi/scsi)

Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: HL-DT-ST Model: DVDRAM GSA-H12N  Rev: UL02
  Type:   CD-ROM                           ANSI  SCSI revision: 05
Host: scsi2 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: M4-CT128M4SSD2   Rev: 0309
  Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi3 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: SAMSUNG HD501LJ  Rev: CR10
  Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi6 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: SAMSUNG HD154UI  Rev: 1AG0
  Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi7 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: SAMSUNG HD204UI  Rev: 1AQ1
  Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi8 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: SAMSUNG HD103UJ  Rev: 1AA0
  Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi10 Channel: 00 Id: 00 Lun: 00
  Vendor:          Model: Android Adapter  Rev: 0100
  Type:   Direct-Access                    ANSI  SCSI revision: 02
Host: scsi10 Channel: 00 Id: 00 Lun: 01
  Vendor:          Model: Android Adapter  Rev: 0100
  Type:   CD-ROM                           ANSI  SCSI revision: 02
Host: scsi10 Channel: 00 Id: 00 Lun: 02
  Vendor:          Model: Android Adapter  Rev: 0100
  Type:   Direct-Access                    ANSI  SCSI revision: 02
Host: scsi11 Channel: 00 Id: 00 Lun: 00
  Vendor: Generic- Model: Compact Flash    Rev: 1.00
  Type:   Direct-Access                    ANSI  SCSI revision: 00
Host: scsi11 Channel: 00 Id: 00 Lun: 01
  Vendor: Generic- Model: SM/xD-Picture    Rev: 1.00
  Type:   Direct-Access                    ANSI  SCSI revision: 00
Host: scsi11 Channel: 00 Id: 00 Lun: 02
  Vendor: Generic- Model: SD/MMC           Rev: 1.00
  Type:   Direct-Access                    ANSI  SCSI revision: 00
Host: scsi11 Channel: 00 Id: 00 Lun: 03
  Vendor: Generic- Model: MS/MS-Pro        Rev: 1.00
  Type:   Direct-Access                    ANSI  SCSI revision: 00

The corresponding ubuntu-bug is https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1252266
