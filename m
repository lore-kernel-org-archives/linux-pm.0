From: Daniels Bruvers <dbruvers@yahoo.de>
Subject: PROBLEM: [DP35DP] Ubuntu 13.04 fails to resume from suspend
Date: Fri, 09 Aug 2013 19:26:02 +0300
Message-ID: <5205181A.4040209@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from nm8-vm1.bullet.mail.ird.yahoo.com ([77.238.189.198]:36326 "HELO
	nm8-vm1.bullet.mail.ird.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S968049Ab3HIQ0L (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 9 Aug 2013 12:26:11 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

[1.] One line summary of the problem
[DP35DP] Ubuntu 13.04 fails to resume from suspend

[2.] Full description of the problem/report
When I suspend the PC everything seems Ok. The computer goes to sleep, 
screen turns off. When I try to resume the computers seems to get stuck 
in the first seconds of waking from suspend and doesn't resume. The fans 
start to spin and the screen turns on but stays black. Nothing else 
happens and the only way to start the computer is by pressing the Reset 
button.

Using Ubuntu 13.04 64bit, Kernel 3.11.0-031100rc4-generic, Motherboard: 
Intel DP35DP, Graphics: ATI 1950Pro (Gallium 0.4 on ATI RV570).

Launchpad bug report: 
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1204512

[3.] Keywords
3.11.0 suspend

[4.] Kernel version
Linux version 3.11.0-031100rc4-generic (apw@gomeisa) (gcc version 4.6.3 
(Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201308041735 SMP Sun Aug 4 21:36:46 
UTC 2013

[7.] Environment
Description:    Ubuntu 13.04
Release:    13.04

[7.1.] Software
Linux danis-desktop 3.11.0-031100rc4-generic #201308041735 SMP Sun Aug 4 
21:36:46 UTC 2013 x86_64 x86_64 x86_64 GNU/Linux

Gnu C                  4.7
Gnu make               3.81
binutils               2.23.2
util-linux             2.20.1
mount                  support
module-init-tools      9
e2fsprogs              1.42.5
pcmciautils            018
PPP                    2.4.5
Linux C Library        2.17
Dynamic linker (ldd)   2.17
Procps                 3.3.3
Net-tools              1.60
Kbd                    1.15.5
Sh-utils               8.20
wireless-tools         30
Modules Loaded         parport_pc ppdev rfcomm bnep bluetooth 
binfmt_misc snd_usb_audio snd_usbmidi_lib snd_hda_codec_idt 
snd_hda_intel snd_hda_codec radeon snd_hwdep snd_pcm snd_page_alloc 
snd_seq_midi snd_seq_midi_event snd_rawmidi snd_seq ttm snd_seq_device 
snd_timer drm_kms_helper drm snd soundcore gspca_zc3xx i2c_algo_bit 
gspca_main videodev psmouse mei_me gpio_ich mei joydev serio_raw lp 
mac_hid lpc_ich parport hid_logitech_dj usbhid hid pata_acpi 
firewire_ohci firewire_core crc_itu_t e1000e pata_marvell ptp pps_core

[7.2.] Processor information
processor    : 0
vendor_id    : GenuineIntel
cpu family    : 6
model        : 23
model name    : Intel(R) Core(TM)2 Duo CPU     E8400  @ 3.00GHz
stepping    : 6
microcode    : 0x60c
cpu MHz        : 2999.852
cache size    : 6144 KB
physical id    : 0
siblings    : 2
core id        : 0
cpu cores    : 2
apicid        : 0
initial apicid    : 0
fpu        : yes
fpu_exception    : yes
cpuid level    : 10
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall 
nx lm constant_tsc arch_perfmon pebs bts rep_good nopl aperfmperf pni 
dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm sse4_1 
lahf_lm dtherm tpr_shadow vnmi flexpriority
bogomips    : 5999.70
clflush size    : 64
cache_alignment    : 64
address sizes    : 36 bits physical, 48 bits virtual
power management:

processor    : 1
vendor_id    : GenuineIntel
cpu family    : 6
model        : 23
model name    : Intel(R) Core(TM)2 Duo CPU     E8400  @ 3.00GHz
stepping    : 6
microcode    : 0x60c
cpu MHz        : 2999.852
cache size    : 6144 KB
physical id    : 0
siblings    : 2
core id        : 1
cpu cores    : 2
apicid        : 1
initial apicid    : 1
fpu        : yes
fpu_exception    : yes
cpuid level    : 10
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall 
nx lm constant_tsc arch_perfmon pebs bts rep_good nopl aperfmperf pni 
dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm sse4_1 
lahf_lm dtherm tpr_shadow vnmi flexpriority
bogomips    : 5999.70
clflush size    : 64
cache_alignment    : 64
address sizes    : 36 bits physical, 48 bits virtual
power management:

[7.3.] Module information
parport_pc 32866 0 - Live 0x0000000000000000
ppdev 17711 0 - Live 0x0000000000000000
rfcomm 74589 0 - Live 0x0000000000000000
bnep 23966 2 - Live 0x0000000000000000
bluetooth 391564 10 rfcomm,bnep, Live 0x0000000000000000
binfmt_misc 17508 1 - Live 0x0000000000000000
snd_usb_audio 155828 1 - Live 0x0000000000000000
snd_usbmidi_lib 29527 1 snd_usb_audio, Live 0x0000000000000000
snd_hda_codec_idt 55053 1 - Live 0x0000000000000000
snd_hda_intel 48717 3 - Live 0x0000000000000000
snd_hda_codec 194727 2 snd_hda_codec_idt,snd_hda_intel, Live 
0x0000000000000000
radeon 1437836 4 - Live 0x0000000000000000
snd_hwdep 13613 2 snd_usb_audio,snd_hda_codec, Live 0x0000000000000000
snd_pcm 107140 3 snd_usb_audio,snd_hda_intel,snd_hda_codec, Live 
0x0000000000000000
snd_page_alloc 18798 2 snd_hda_intel,snd_pcm, Live 0x0000000000000000
snd_seq_midi 13324 0 - Live 0x0000000000000000
snd_seq_midi_event 14899 1 snd_seq_midi, Live 0x0000000000000000
snd_rawmidi 30416 2 snd_usbmidi_lib,snd_seq_midi, Live 0x0000000000000000
snd_seq 66061 2 snd_seq_midi,snd_seq_midi_event, Live 0x0000000000000000
ttm 84705 1 radeon, Live 0x0000000000000000
snd_seq_device 14497 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 
0x0000000000000000
snd_timer 29989 2 snd_pcm,snd_seq, Live 0x0000000000000000
drm_kms_helper 53178 1 radeon, Live 0x0000000000000000
drm 298236 6 radeon,ttm,drm_kms_helper, Live 0x0000000000000000
snd 69657 20 
snd_usb_audio,snd_usbmidi_lib,snd_hda_codec_idt,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_seq_midi,snd_rawmidi,snd_seq,snd_seq_device,snd_timer, 
Live 0x0000000000000000
soundcore 12680 1 snd, Live 0x0000000000000000
gspca_zc3xx 56743 0 - Live 0x0000000000000000
i2c_algo_bit 13564 1 radeon, Live 0x0000000000000000
gspca_main 37053 1 gspca_zc3xx, Live 0x0000000000000000
videodev 138443 2 gspca_zc3xx,gspca_main, Live 0x0000000000000000
psmouse 104015 0 - Live 0x0000000000000000
mei_me 18539 0 - Live 0x0000000000000000
gpio_ich 13526 0 - Live 0x0000000000000000
mei 78448 1 mei_me, Live 0x0000000000000000
joydev 17613 0 - Live 0x0000000000000000
serio_raw 13413 0 - Live 0x0000000000000000
lp 17799 0 - Live 0x0000000000000000
mac_hid 13253 0 - Live 0x0000000000000000
lpc_ich 21163 0 - Live 0x0000000000000000
parport 42466 3 parport_pc,ppdev,lp, Live 0x0000000000000000
hid_logitech_dj 18767 0 - Live 0x0000000000000000
usbhid 53329 0 - Live 0x0000000000000000
hid 105557 2 hid_logitech_dj,usbhid, Live 0x0000000000000000
pata_acpi 13038 0 - Live 0x0000000000000000
firewire_ohci 44856 0 - Live 0x0000000000000000
firewire_core 65110 1 firewire_ohci, Live 0x0000000000000000
crc_itu_t 12707 1 firewire_core, Live 0x0000000000000000
e1000e 257364 0 - Live 0x0000000000000000
pata_marvell 12894 0 - Live 0x0000000000000000
ptp 18627 1 e1000e, Live 0x0000000000000000
pps_core 19027 1 ptp, Live 0x0000000000000000

[7.4.] Loaded driver and hardware information
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
   02f8-02ff : serial
   03f8-03ff : serial
   0400-047f : 0000:00:1f.0
     0400-047f : pnp 00:05
       0400-0403 : ACPI PM1a_EVT_BLK
       0404-0405 : ACPI PM1a_CNT_BLK
       0408-040b : ACPI PM_TMR
       0420-042f : ACPI GPE0_BLK
         0428-042f : gpio_ich
       0430-0433 : iTCO_wdt
       0450-0450 : ACPI PM2_CNT_BLK
       0460-047f : iTCO_wdt
   0500-053f : gpio_ich
     0500-053f : 0000:00:1f.0
       0500-053f : pnp 00:05
         0530-053f : gpio_ich
   0680-06ff : pnp 00:05
0cf8-0cff : PCI conf1
0d00-ffff : PCI Bus 0000:00
   1000-1fff : PCI Bus 0000:03
     1000-100f : 0000:03:00.0
       1000-100f : pata_marvell
     1010-1017 : 0000:03:00.0
     1018-101f : 0000:03:00.0
       1018-101f : pata_marvell
     1020-1023 : 0000:03:00.0
     1024-1027 : 0000:03:00.0
       1024-1027 : pata_marvell
   2000-2fff : PCI Bus 0000:01
     2000-20ff : 0000:01:00.0
   3000-301f : 0000:00:1f.3
   3020-303f : 0000:00:1d.2
     3020-303f : uhci_hcd
   3040-305f : 0000:00:1d.1
     3040-305f : uhci_hcd
   3060-307f : 0000:00:1d.0
     3060-307f : uhci_hcd
   3080-309f : 0000:00:1a.2
     3080-309f : uhci_hcd
   30a0-30bf : 0000:00:1a.1
     30a0-30bf : uhci_hcd
   30c0-30df : 0000:00:1a.0
     30c0-30df : uhci_hcd
   30e0-30ff : 0000:00:19.0
   3400-340f : 0000:00:1f.5
     3400-340f : ata_piix
   3410-341f : 0000:00:1f.5
     3410-341f : ata_piix
   3420-342f : 0000:00:1f.2
     3420-342f : ata_piix
   3430-343f : 0000:00:1f.2
     3430-343f : ata_piix
   3440-3447 : 0000:00:1f.5
     3440-3447 : ata_piix
   3448-344f : 0000:00:1f.5
     3448-344f : ata_piix
   3450-3457 : 0000:00:1f.2
     3450-3457 : ata_piix
   3458-345f : 0000:00:1f.2
     3458-345f : ata_piix
   3460-3463 : 0000:00:1f.5
     3460-3463 : ata_piix
   3464-3467 : 0000:00:1f.5
     3464-3467 : ata_piix
   3468-346b : 0000:00:1f.2
     3468-346b : ata_piix
   346c-346f : 0000:00:1f.2
     346c-346f : ata_piix
   4000-4fff : PCI Bus 0000:02
   5000-5fff : PCI Bus 0000:04
   6000-6fff : PCI Bus 0000:05
   7000-7fff : PCI Bus 0000:06

00000000-00000fff : reserved
00001000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : PCI Bus 0000:00
000c0000-000cffff : Video ROM
000d0000-000d0fff : Adapter ROM
000d1000-000d1fff : Adapter ROM
000e0000-000fffff : reserved
   000e0000-000effff : PCI Bus 0000:00
   000f0000-000fffff : System ROM
00100000-ceacdfff : System RAM
   01000000-01737753 : Kernel code
   01737754-01d0eabf : Kernel data
   01e70000-01fe2fff : Kernel bss
ceace000-ceb93fff : ACPI Non-volatile Storage
ceb94000-cfd9dfff : System RAM
cfd9e000-cfd9ffff : reserved
cfda0000-cfe8dfff : System RAM
cfe8e000-cfee4fff : ACPI Non-volatile Storage
cfee5000-cfeebfff : System RAM
cfeec000-cfef2fff : ACPI Tables
cfef3000-cfef3fff : System RAM
cfef4000-cfefefff : ACPI Tables
cfeff000-cfefffff : System RAM
cff00000-cfffffff : reserved
d0000000-efffffff : PCI Bus 0000:00
   d0000000-dfffffff : PCI Bus 0000:01
     d0000000-dfffffff : 0000:01:00.0
   e0000000-e00fffff : PCI Bus 0000:07
     e0000000-e0003fff : 0000:07:03.0
     e0004000-e00047ff : 0000:07:03.0
       e0004000-e00047ff : firewire_ohci
   e0100000-e01fffff : PCI Bus 0000:03
     e0100000-e01001ff : 0000:03:00.0
   e0200000-e02fffff : PCI Bus 0000:01
     e0200000-e020ffff : 0000:01:00.0
     e0210000-e021ffff : 0000:01:00.1
     e0220000-e023ffff : 0000:01:00.0
   e0300000-e031ffff : 0000:00:19.0
     e0300000-e031ffff : e1000e
   e0320000-e0323fff : 0000:00:1b.0
     e0320000-e0323fff : ICH HD audio
   e0324000-e0324fff : 0000:00:19.0
     e0324000-e0324fff : e1000e
   e0325000-e03253ff : 0000:00:1d.7
     e0325000-e03253ff : ehci_hcd
   e0325400-e03257ff : 0000:00:1a.7
     e0325400-e03257ff : ehci_hcd
   e0325800-e03258ff : 0000:00:1f.3
   e0325900-e032590f : 0000:00:03.0
     e0325900-e032590f : mei_me
f0000000-f7ffffff : PCI MMCONFIG 0000 [bus 00-7f]
   f0000000-f7ffffff : reserved
     f0000000-f7ffffff : pnp 00:00
f8000000-feafffff : PCI Bus 0000:00
   f8000000-f81fffff : PCI Bus 0000:02
   f8200000-f83fffff : PCI Bus 0000:02
   f8400000-f85fffff : PCI Bus 0000:03
   f8600000-f87fffff : PCI Bus 0000:04
   f8800000-f89fffff : PCI Bus 0000:04
   f8a00000-f8bfffff : PCI Bus 0000:05
   f8c00000-f8dfffff : PCI Bus 0000:05
   f8e00000-f8ffffff : PCI Bus 0000:06
   f9000000-f91fffff : PCI Bus 0000:06
feb00000-feb03fff : pnp 00:00
fec00000-fec003ff : IOAPIC 0
fed13000-fed13fff : pnp 00:00
fed14000-fed17fff : pnp 00:00
fed18000-fed18fff : pnp 00:00
fed19000-fed19fff : pnp 00:00
fed1c000-fed1ffff : pnp 00:00
   fed1f410-fed1f414 : iTCO_wdt
fed20000-fed3ffff : pnp 00:00
fed45000-fed99fff : pnp 00:00
fee00000-fee00fff : Local APIC
fff00000-ffffffff : reserved
100000000-22bffffff : System RAM

[7.5.] PCI information
00:00.0 Host bridge: Intel Corporation 82G33/G31/P35/P31 Express DRAM 
Controller (rev 02)
     Subsystem: Intel Corporation Desktop Board DP35DP
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR- INTx-
     Latency: 0
     Capabilities: [e0] Vendor Specific Information: Len=0b <?>

00:01.0 PCI bridge: Intel Corporation 82G33/G31/P35/P31 Express PCI 
Express Root Port (rev 02) (prog-if 00 [Normal decode])
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
     I/O behind bridge: 00002000-00002fff
     Memory behind bridge: e0200000-e02fffff
     Prefetchable memory behind bridge: 00000000d0000000-00000000dfffffff
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
     BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [88] Subsystem: Intel Corporation Device 5044
     Capabilities: [80] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
         Address: fee0300c  Data: 41b1
     Capabilities: [a0] Express (v1) Root Port (Slot+), MSI 00
         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s 
<64ns, L1 <1us
             ExtTag- RBE+ FLReset-
         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- 
TransPend-
         LnkCap:    Port #2, Speed 2.5GT/s, Width x16, ASPM L0s, Latency 
L0 <256ns, L1 <4us
             ClockPM- Surprise- LLActRep- BwNot-
         LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 2.5GT/s, Width x16, TrErr- Train- SlotClk+ 
DLActive- BWMgmt- ABWMgmt-
         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- 
Surprise-
             Slot #0, PowerLimit 242.000W; Interlock- NoCompl+
         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- 
HPIrq- LinkChg-
             Control: AttnInd Off, PwrInd On, Power- Interlock-
         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ 
Interlock-
             Changed: MRL- PresDet+ LinkState-
         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- 
CRSVisible-
         RootCap: CRSVisible-
         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
     Capabilities: [100 v1] Virtual Channel
         Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
         Arb:    Fixed- WRR32- WRR64- WRR128-
         Ctrl:    ArbSelect=Fixed
         Status:    InProgress-
         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=01
             Status:    NegoPending- InProgress-
     Capabilities: [140 v1] Root Complex Link
         Desc:    PortNumber=02 ComponentID=01 EltType=Config
         Link0:    Desc:    TargetPort=00 TargetComponent=01 AssocRCRB- 
LinkType=MemMapped LinkValid+
             Addr:    00000000fed19000
     Kernel driver in use: pcieport

00:03.0 Communication controller: Intel Corporation 82G33/G31/P35/P31 
Express MEI Controller (rev 02)
     Subsystem: Intel Corporation Desktop Board DP35DP
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 47
     Region 0: Memory at e0325900 (64-bit, non-prefetchable) [size=16]
     Capabilities: [50] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [8c] MSI: Enable+ Count=1/1 Maskable- 64bit+
         Address: 00000000fee0300c  Data: 4162
     Kernel driver in use: mei_me

00:19.0 Ethernet controller: Intel Corporation 82566DC-2 Gigabit Network 
Connection (rev 02)
     Subsystem: Intel Corporation Device 0001
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 46
     Region 0: Memory at e0300000 (32-bit, non-prefetchable) [size=128K]
     Region 1: Memory at e0324000 (32-bit, non-prefetchable) [size=4K]
     Region 2: I/O ports at 30e0 [size=32]
     Capabilities: [c8] Power Management version 2
         Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
     Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
         Address: 00000000fee0100c  Data: 41b2
     Capabilities: [e0] Vendor Specific Information: Len=06 <?>
     Kernel driver in use: e1000e

00:1a.0 USB controller: Intel Corporation 82801I (ICH9 Family) USB UHCI 
Controller #4 (rev 02) (prog-if 00 [UHCI])
     Subsystem: Intel Corporation Desktop Board DP35DP
     Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 18
     Region 4: I/O ports at 30c0 [size=32]
     Capabilities: [50] Vendor Specific Information: Len=06 <?>
     Kernel driver in use: uhci_hcd

00:1a.1 USB controller: Intel Corporation 82801I (ICH9 Family) USB UHCI 
Controller #5 (rev 02) (prog-if 00 [UHCI])
     Subsystem: Intel Corporation Desktop Board DP35DP
     Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin B routed to IRQ 21
     Region 4: I/O ports at 30a0 [size=32]
     Capabilities: [50] Vendor Specific Information: Len=06 <?>
     Kernel driver in use: uhci_hcd

00:1a.2 USB controller: Intel Corporation 82801I (ICH9 Family) USB UHCI 
Controller #6 (rev 02) (prog-if 00 [UHCI])
     Subsystem: Intel Corporation Desktop Board DP35DP
     Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin C routed to IRQ 17
     Region 4: I/O ports at 3080 [size=32]
     Capabilities: [50] Vendor Specific Information: Len=06 <?>
     Kernel driver in use: uhci_hcd

00:1a.7 USB controller: Intel Corporation 82801I (ICH9 Family) USB2 EHCI 
Controller #2 (rev 02) (prog-if 20 [EHCI])
     Subsystem: Intel Corporation Desktop Board DP35DP
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin C routed to IRQ 17
     Region 0: Memory at e0325400 (32-bit, non-prefetchable) [size=1K]
     Capabilities: [50] Power Management version 2
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [58] Debug port: BAR=1 offset=00a0
     Capabilities: [98] Vendor Specific Information: Len=06 <?>
     Kernel driver in use: ehci-pci

00:1b.0 Audio device: Intel Corporation 82801I (ICH9 Family) HD Audio 
Controller (rev 02)
     Subsystem: Intel Corporation Device 3001
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin A routed to IRQ 49
     Region 0: Memory at e0320000 (64-bit, non-prefetchable) [size=16K]
     Capabilities: [50] Power Management version 2
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
         Address: 00000000fee0300c  Data: 4192
     Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, 
MSI 00
         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s 
<64ns, L1 <1us
             ExtTag- RBE- FLReset+
         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ 
TransPend-
         LnkCap:    Port #0, Speed unknown, Width x0, ASPM unknown, 
Latency L0 <64ns, L1 <1us
             ClockPM- Surprise- LLActRep- BwNot-
         LnkCtl:    ASPM Disabled; Disabled- Retrain- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed unknown, Width x0, TrErr- Train- SlotClk- 
DLActive- BWMgmt- ABWMgmt-
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
             Ctrl:    Enable+ ID=1 ArbSelect=Fixed TC/VC=80
             Status:    NegoPending- InProgress-
     Capabilities: [130 v1] Root Complex Link
         Desc:    PortNumber=0f ComponentID=02 EltType=Config
         Link0:    Desc:    TargetPort=00 TargetComponent=02 AssocRCRB- 
LinkType=MemMapped LinkValid+
             Addr:    00000000fed1c000
     Kernel driver in use: snd_hda_intel

00:1c.0 PCI bridge: Intel Corporation 82801I (ICH9 Family) PCI Express 
Port 1 (rev 02) (prog-if 00 [Normal decode])
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
     I/O behind bridge: 00004000-00004fff
     Memory behind bridge: f8000000-f81fffff
     Prefetchable memory behind bridge: 00000000f8200000-00000000f83fffff
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
     BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s 
<64ns, L1 <1us
             ExtTag- RBE+ FLReset-
         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ 
TransPend-
         LnkCap:    Port #1, Speed 2.5GT/s, Width x1, ASPM L0s L1, 
Latency L0 <1us, L1 <4us
             ClockPM- Surprise- LLActRep+ BwNot-
         LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ 
DLActive- BWMgmt- ABWMgmt-
         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ 
Surprise+
             Slot #1, PowerLimit 10.000W; Interlock- NoCompl-
         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- 
HPIrq- LinkChg-
             Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- 
Interlock-
             Changed: MRL- PresDet- LinkState-
         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- 
CRSVisible-
         RootCap: CRSVisible-
         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
     Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
         Address: fee0300c  Data: 41c1
     Capabilities: [90] Subsystem: Intel Corporation Optiplex 755
     Capabilities: [a0] Power Management version 2
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [100 v1] Virtual Channel
         Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
         Arb:    Fixed+ WRR32- WRR64- WRR128-
         Ctrl:    ArbSelect=Fixed
         Status:    InProgress-
         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=01
             Status:    NegoPending- InProgress-
     Capabilities: [180 v1] Root Complex Link
         Desc:    PortNumber=01 ComponentID=02 EltType=Config
         Link0:    Desc:    TargetPort=00 TargetComponent=02 AssocRCRB- 
LinkType=MemMapped LinkValid+
             Addr:    00000000fed1c000
     Kernel driver in use: pcieport

00:1c.1 PCI bridge: Intel Corporation 82801I (ICH9 Family) PCI Express 
Port 2 (rev 02) (prog-if 00 [Normal decode])
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
     I/O behind bridge: 00001000-00001fff
     Memory behind bridge: e0100000-e01fffff
     Prefetchable memory behind bridge: 00000000f8400000-00000000f85fffff
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
     BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s 
<64ns, L1 <1us
             ExtTag- RBE+ FLReset-
         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ 
TransPend-
         LnkCap:    Port #2, Speed 2.5GT/s, Width x1, ASPM L0s L1, 
Latency L0 <256ns, L1 <4us
             ClockPM- Surprise- LLActRep+ BwNot-
         LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ 
DLActive+ BWMgmt- ABWMgmt-
         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ 
Surprise+
             Slot #2, PowerLimit 10.000W; Interlock- NoCompl-
         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- 
HPIrq- LinkChg-
             Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ 
Interlock-
             Changed: MRL- PresDet+ LinkState+
         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- 
CRSVisible-
         RootCap: CRSVisible-
         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
     Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
         Address: fee0300c  Data: 41d1
     Capabilities: [90] Subsystem: Intel Corporation 82801I (ICH9 
Family) PCI Express Port 2
     Capabilities: [a0] Power Management version 2
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [100 v1] Virtual Channel
         Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
         Arb:    Fixed+ WRR32- WRR64- WRR128-
         Ctrl:    ArbSelect=Fixed
         Status:    InProgress-
         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=01
             Status:    NegoPending- InProgress-
     Capabilities: [180 v1] Root Complex Link
         Desc:    PortNumber=02 ComponentID=02 EltType=Config
         Link0:    Desc:    TargetPort=00 TargetComponent=02 AssocRCRB- 
LinkType=MemMapped LinkValid+
             Addr:    00000000fed1c000
     Kernel driver in use: pcieport

00:1c.2 PCI bridge: Intel Corporation 82801I (ICH9 Family) PCI Express 
Port 3 (rev 02) (prog-if 00 [Normal decode])
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
     I/O behind bridge: 00005000-00005fff
     Memory behind bridge: f8600000-f87fffff
     Prefetchable memory behind bridge: 00000000f8800000-00000000f89fffff
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
     BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s 
<64ns, L1 <1us
             ExtTag- RBE+ FLReset-
         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ 
TransPend-
         LnkCap:    Port #3, Speed 2.5GT/s, Width x1, ASPM L0s L1, 
Latency L0 <1us, L1 <4us
             ClockPM- Surprise- LLActRep+ BwNot-
         LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ 
DLActive- BWMgmt- ABWMgmt-
         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ 
Surprise+
             Slot #3, PowerLimit 10.000W; Interlock- NoCompl-
         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- 
HPIrq- LinkChg-
             Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- 
Interlock-
             Changed: MRL- PresDet- LinkState-
         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- 
CRSVisible-
         RootCap: CRSVisible-
         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
     Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
         Address: fee0300c  Data: 41e1
     Capabilities: [90] Subsystem: Intel Corporation 82801I (ICH9 
Family) PCI Express Port 3
     Capabilities: [a0] Power Management version 2
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [100 v1] Virtual Channel
         Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
         Arb:    Fixed+ WRR32- WRR64- WRR128-
         Ctrl:    ArbSelect=Fixed
         Status:    InProgress-
         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=01
             Status:    NegoPending- InProgress-
     Capabilities: [180 v1] Root Complex Link
         Desc:    PortNumber=03 ComponentID=02 EltType=Config
         Link0:    Desc:    TargetPort=00 TargetComponent=02 AssocRCRB- 
LinkType=MemMapped LinkValid+
             Addr:    00000000fed1c000
     Kernel driver in use: pcieport

00:1c.3 PCI bridge: Intel Corporation 82801I (ICH9 Family) PCI Express 
Port 4 (rev 02) (prog-if 00 [Normal decode])
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Bus: primary=00, secondary=05, subordinate=05, sec-latency=0
     I/O behind bridge: 00006000-00006fff
     Memory behind bridge: f8a00000-f8bfffff
     Prefetchable memory behind bridge: 00000000f8c00000-00000000f8dfffff
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
     BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s 
<64ns, L1 <1us
             ExtTag- RBE+ FLReset-
         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ 
TransPend-
         LnkCap:    Port #4, Speed 2.5GT/s, Width x1, ASPM L0s L1, 
Latency L0 <1us, L1 <4us
             ClockPM- Surprise- LLActRep+ BwNot-
         LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ 
DLActive- BWMgmt- ABWMgmt-
         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ 
Surprise+
             Slot #4, PowerLimit 10.000W; Interlock- NoCompl-
         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- 
HPIrq- LinkChg-
             Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- 
Interlock-
             Changed: MRL- PresDet- LinkState-
         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- 
CRSVisible-
         RootCap: CRSVisible-
         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
     Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
         Address: fee0300c  Data: 4122
     Capabilities: [90] Subsystem: Intel Corporation 82801I (ICH9 
Family) PCI Express Port 4
     Capabilities: [a0] Power Management version 2
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [100 v1] Virtual Channel
         Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
         Arb:    Fixed+ WRR32- WRR64- WRR128-
         Ctrl:    ArbSelect=Fixed
         Status:    InProgress-
         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=01
             Status:    NegoPending- InProgress-
     Capabilities: [180 v1] Root Complex Link
         Desc:    PortNumber=04 ComponentID=02 EltType=Config
         Link0:    Desc:    TargetPort=00 TargetComponent=02 AssocRCRB- 
LinkType=MemMapped LinkValid+
             Addr:    00000000fed1c000
     Kernel driver in use: pcieport

00:1c.4 PCI bridge: Intel Corporation 82801I (ICH9 Family) PCI Express 
Port 5 (rev 02) (prog-if 00 [Normal decode])
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Bus: primary=00, secondary=06, subordinate=06, sec-latency=0
     I/O behind bridge: 00007000-00007fff
     Memory behind bridge: f8e00000-f8ffffff
     Prefetchable memory behind bridge: 00000000f9000000-00000000f91fffff
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
     BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s 
<64ns, L1 <1us
             ExtTag- RBE+ FLReset-
         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ 
TransPend-
         LnkCap:    Port #5, Speed 2.5GT/s, Width x1, ASPM L0s L1, 
Latency L0 <1us, L1 <4us
             ClockPM- Surprise- LLActRep+ BwNot-
         LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ 
DLActive- BWMgmt- ABWMgmt-
         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ 
Surprise+
             Slot #5, PowerLimit 10.000W; Interlock- NoCompl-
         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- 
HPIrq- LinkChg-
             Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- 
Interlock-
             Changed: MRL- PresDet- LinkState-
         RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- 
CRSVisible-
         RootCap: CRSVisible-
         RootSta: PME ReqID 0000, PMEStatus- PMEPending-
     Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
         Address: fee0300c  Data: 4142
     Capabilities: [90] Subsystem: Intel Corporation 82801I (ICH9 
Family) PCI Express Port 5
     Capabilities: [a0] Power Management version 2
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [100 v1] Virtual Channel
         Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
         Arb:    Fixed+ WRR32- WRR64- WRR128-
         Ctrl:    ArbSelect=Fixed
         Status:    InProgress-
         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=01
             Status:    NegoPending- InProgress-
     Capabilities: [180 v1] Root Complex Link
         Desc:    PortNumber=05 ComponentID=02 EltType=Config
         Link0:    Desc:    TargetPort=00 TargetComponent=02 AssocRCRB- 
LinkType=MemMapped LinkValid+
             Addr:    00000000fed1c000
     Kernel driver in use: pcieport

00:1d.0 USB controller: Intel Corporation 82801I (ICH9 Family) USB UHCI 
Controller #1 (rev 02) (prog-if 00 [UHCI])
     Subsystem: Intel Corporation Desktop Board DP35DP
     Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 23
     Region 4: I/O ports at 3060 [size=32]
     Capabilities: [50] Vendor Specific Information: Len=06 <?>
     Kernel driver in use: uhci_hcd

00:1d.1 USB controller: Intel Corporation 82801I (ICH9 Family) USB UHCI 
Controller #2 (rev 02) (prog-if 00 [UHCI])
     Subsystem: Intel Corporation Desktop Board DP35DP
     Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin B routed to IRQ 19
     Region 4: I/O ports at 3040 [size=32]
     Capabilities: [50] Vendor Specific Information: Len=06 <?>
     Kernel driver in use: uhci_hcd

00:1d.2 USB controller: Intel Corporation 82801I (ICH9 Family) USB UHCI 
Controller #3 (rev 02) (prog-if 00 [UHCI])
     Subsystem: Intel Corporation Desktop Board DP35DP
     Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin C routed to IRQ 18
     Region 4: I/O ports at 3020 [size=32]
     Capabilities: [50] Vendor Specific Information: Len=06 <?>
     Kernel driver in use: uhci_hcd

00:1d.7 USB controller: Intel Corporation 82801I (ICH9 Family) USB2 EHCI 
Controller #1 (rev 02) (prog-if 20 [EHCI])
     Subsystem: Intel Corporation Desktop Board DP35DP
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 23
     Region 0: Memory at e0325000 (32-bit, non-prefetchable) [size=1K]
     Capabilities: [50] Power Management version 2
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [58] Debug port: BAR=1 offset=00a0
     Capabilities: [98] Vendor Specific Information: Len=06 <?>
     Kernel driver in use: ehci-pci

00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev 92) (prog-if 
01 [Subtractive decode])
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Bus: primary=00, secondary=07, subordinate=07, sec-latency=32
     I/O behind bridge: 0000f000-00000fff
     Memory behind bridge: e0000000-e00fffff
     Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
     Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ <SERR- <PERR-
     BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [50] Subsystem: Intel Corporation Device 5044

00:1f.0 ISA bridge: Intel Corporation 82801IR (ICH9R) LPC Interface 
Controller (rev 02)
     Subsystem: Intel Corporation Desktop Board DP35DP
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Capabilities: [e0] Vendor Specific Information: Len=0c <?>
     Kernel driver in use: lpc_ich

00:1f.2 IDE interface: Intel Corporation 82801IR/IO/IH (ICH9R/DO/DH) 4 
port SATA Controller [IDE mode] (rev 02) (prog-if 8f [Master SecP SecO 
PriP PriO])
     Subsystem: Intel Corporation Device 5044
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 21
     Region 0: I/O ports at 3458 [size=8]
     Region 1: I/O ports at 346c [size=4]
     Region 2: I/O ports at 3450 [size=8]
     Region 3: I/O ports at 3468 [size=4]
     Region 4: I/O ports at 3430 [size=16]
     Region 5: I/O ports at 3420 [size=16]
     Capabilities: [70] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [b0] Vendor Specific Information: Len=06 <?>
     Kernel driver in use: ata_piix

00:1f.3 SMBus: Intel Corporation 82801I (ICH9 Family) SMBus Controller 
(rev 02)
     Subsystem: Intel Corporation Desktop Board DP35DP
     Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Interrupt: pin B routed to IRQ 10
     Region 0: Memory at e0325800 (64-bit, non-prefetchable) [size=256]
     Region 4: I/O ports at 3000 [size=32]

00:1f.5 IDE interface: Intel Corporation 82801I (ICH9 Family) 2 port 
SATA Controller [IDE mode] (rev 02) (prog-if 85 [Master SecO PriO])
     Subsystem: Intel Corporation Device 5044
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0
     Interrupt: pin A routed to IRQ 21
     Region 0: I/O ports at 3448 [size=8]
     Region 1: I/O ports at 3464 [size=4]
     Region 2: I/O ports at 3440 [size=8]
     Region 3: I/O ports at 3460 [size=4]
     Region 4: I/O ports at 3410 [size=16]
     Region 5: I/O ports at 3400 [size=16]
     Capabilities: [70] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [b0] Vendor Specific Information: Len=06 <?>
     Kernel driver in use: ata_piix

01:00.0 VGA compatible controller: Advanced Micro Devices [AMD] nee ATI 
RV570 [Radeon X1950 PRO] (prog-if 00 [VGA controller])
     Subsystem: ASUSTeK Computer Inc. Device 0182
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin A routed to IRQ 48
     Region 0: Memory at d0000000 (64-bit, prefetchable) [size=256M]
     Region 2: Memory at e0200000 (64-bit, non-prefetchable) [size=64K]
     Region 4: I/O ports at 2000 [size=256]
     Expansion ROM at e0220000 [disabled] [size=128K]
     Capabilities: [50] Power Management version 2
         Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [58] Express (v1) Endpoint, MSI 00
         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4us, 
L1 unlimited
             ExtTag+ AttnBtn- AttnInd- PwrInd- RBE- FLReset-
         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
             RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- 
TransPend-
         LnkCap:    Port #0, Speed 2.5GT/s, Width x16, ASPM L0s L1, 
Latency L0 <64ns, L1 <1us
             ClockPM- Surprise- LLActRep- BwNot-
         LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 2.5GT/s, Width x16, TrErr- Train- SlotClk+ 
DLActive- BWMgmt- ABWMgmt-
     Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit+
         Address: 00000000fee0300c  Data: 4172
     Kernel driver in use: radeon

01:00.1 Display controller: Advanced Micro Devices [AMD] nee ATI RV570 
[Radeon X1950 PRO] (Secondary)
     Subsystem: ASUSTeK Computer Inc. Device 0183
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Region 0: Memory at e0210000 (64-bit, non-prefetchable) [size=64K]
     Capabilities: [50] Power Management version 2
         Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [58] Express (v1) Endpoint, MSI 00
         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4us, 
L1 unlimited
             ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
             RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- 
TransPend-
         LnkCap:    Port #0, Speed 2.5GT/s, Width x16, ASPM L0s L1, 
Latency L0 <64ns, L1 <1us
             ClockPM- Surprise- LLActRep- BwNot-
         LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 2.5GT/s, Width x16, TrErr- Train- SlotClk+ 
DLActive- BWMgmt- ABWMgmt-

03:00.0 IDE interface: Marvell Technology Group Ltd. 88SE6101/6102 
single-port PATA133 interface (rev b2) (prog-if 8f [Master SecP SecO 
PriP PriO])
     Subsystem: Marvell Technology Group Ltd. 88SE6101/6102 single-port 
PATA133 interface
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 64 bytes
     Interrupt: pin A routed to IRQ 17
     Region 0: I/O ports at 1018 [size=8]
     Region 1: I/O ports at 1024 [size=4]
     Region 2: I/O ports at 1010 [size=8]
     Region 3: I/O ports at 1020 [size=4]
     Region 4: I/O ports at 1000 [size=16]
     Region 5: Memory at e0100000 (32-bit, non-prefetchable) [size=512]
     Capabilities: [48] Power Management version 2
         Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA 
PME(D0+,D1+,D2-,D3hot+,D3cold-)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
     Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit-
         Address: 00000000  Data: 0000
     Capabilities: [e0] Express (v1) Legacy Endpoint, MSI 00
         DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s 
unlimited, L1 unlimited
             ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
             RlxdOrd- ExtTag- PhantFunc- AuxPwr+ NoSnoop-
             MaxPayload 128 bytes, MaxReadReq 512 bytes
         DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- 
TransPend-
         LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s, Latency 
L0 <256ns, L1 unlimited
             ClockPM- Surprise- LLActRep- BwNot-
         LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ 
DLActive- BWMgmt- ABWMgmt-
     Capabilities: [100 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
         UESvrt:    DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
         AERCap:    First Error Pointer: 1f, GenCap- CGenEn- ChkCap- ChkEn-
     Kernel driver in use: pata_marvell

07:03.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22A 
IEEE-1394a-2000 Controller (PHY/Link) [iOHCI-Lynx] (prog-if 10 [OHCI])
     Subsystem: Intel Corporation Desktop Board DP35DP
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 32 (500ns min, 1000ns max), Cache Line Size: 64 bytes
     Interrupt: pin A routed to IRQ 19
     Region 0: Memory at e0004000 (32-bit, non-prefetchable) [size=2K]
     Region 1: Memory at e0000000 (32-bit, non-prefetchable) [size=16K]
     Capabilities: [44] Power Management version 2
         Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold-)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME+
     Kernel driver in use: firewire_ohci

[7.6.] SCSI information
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: SAMSUNG HD160JJ/ Rev: ZM10
   Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi0 Channel: 00 Id: 01 Lun: 00
   Vendor: ATA      Model: Hitachi HDT72101 Rev: ST6O
   Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi1 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: HDS725050KLA360  Rev: K2AO
   Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi1 Channel: 00 Id: 01 Lun: 00
   Vendor: ATA      Model: SAMSUNG HD502HJ  Rev: 1AJ1
   Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi4 Channel: 00 Id: 00 Lun: 00
   Vendor: HL-DT-ST Model: DVDRAM GSA-4167B Rev: DL13
   Type:   CD-ROM                           ANSI  SCSI revision: 05

[7.7.] Other information that might be relevant to the problem
1
10
1031
1032
1042
1082
1083
1086
11
1104
1108
1114
1118
1128
1129
1133
12
1292
1299
13
1306
1307
1309
1332
1335
1348
1355
1357
14
15
1552
1554
1564
1578
1584
159
16
1699
17
18
19
1916
1971
2
205
2055
2065
209
21
2111
2114
2115
2125
2129
2132
2146
2152
2160
2164
2178
2189
2193
2194
2195
22
2201
2202
2203
2204
2206
2209
2224
2250
2255
2259
2266
2283
2288
2297
23
2302
2312
2333
2338
2339
2343
2345
2370
2380
2381
2382
2383
2384
2385
2386
24
2441
246
2471
2495
25
2501
2517
2518
2524
2532
2540
2553
2556
2569
2577
2579
2581
2583
2585
2587
26
2641
2643
2662
2664
2669
2670
2692
27
2714
2715
2752
279
2791
28
280
281
2847
2891
29
2988
3
30
3040
31
3138
3164
3168
3169
32
3293
3294
3300
3302
34
3417
3428
3429
3455
3463
3467
347
3470
3471
35
3528
3545
3546
36
37
374
378
38
3811
39
3954
40
4015
41
5
52
525
54
548
55
57
58
61
689
7
8
81
815
817
82
83
84
86
868
87
870
9
944
949
956
960
985
acpi
asound
buddyinfo
bus
cgroups
cmdline
consoles
cpuinfo
crypto
devices
diskstats
dma
dri
driver
execdomains
fb
filesystems
fs
interrupts
iomem
ioports
irq
kallsyms
kcore
key-users
kmsg
kpagecount
kpageflags
latency_stats
loadavg
locks
mdstat
meminfo
misc
modules
mounts
mtrr
net
pagetypeinfo
partitions
sched_debug
schedstat
scsi
self
slabinfo
softirqs
stat
swaps
sys
sysrq-trigger
sysvipc
timer_list
timer_stats
tty
uptime
version
vmallocinfo
vmstat
zoneinfo

[X.] Other notes, patches, fixes, workarounds
There is no pm_trace available on this system.
