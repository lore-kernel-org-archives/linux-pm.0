From: Mark Oteiza <mvoteiza@udel.edu>
Subject: Re: PROBLEM: cpuidle: Quickly notice prediction failure for repeat
 mode
Date: Thu, 19 Dec 2013 14:58:24 -0500
Message-ID: <20131219195824.GA17341@holos>
References: <20131219195159.GB16912@holos>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="BXVAT5kNtrzKuDFl"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qe0-f49.google.com ([209.85.128.49]:50507 "EHLO
	mail-qe0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755085Ab3LST51 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 Dec 2013 14:57:27 -0500
Received: by mail-qe0-f49.google.com with SMTP id w7so1490018qeb.8
        for <linux-pm@vger.kernel.org>; Thu, 19 Dec 2013 11:57:26 -0800 (PST)
Received: from localhost (c-68-55-201-85.hsd1.md.comcast.net. [68.55.201.85])
        by mx.google.com with ESMTPSA id f12sm2313968qaa.18.2013.12.19.11.57.24
        for <linux-pm@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Dec 2013 11:57:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20131219195159.GB16912@holos>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 19/12/13 at 02:51pm, Mark Oteiza wrote:
> I attached some info I hope will be helpful.

and it seems to have been corrupt
-- 
Mark Oteiza

--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cpuidle.log"
Content-Transfer-Encoding: quoted-printable

# 1. software
# 2. scripts/ver_linux
# 3. /proc/cpuinfo
# 4. dmidecode
# 5. lspci -vk

# 1.
pulseaudio-alsa 2-2
pulseaudio-git 4.0+332+g6f954c7-1
mpd 0.18.5-1

# 2.
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
=20
Linux holos 3.12.4-1-ARCH #1 SMP PREEMPT Sun Dec 8 21:18:00 CET 2013 x86_64=
 GNU/Linux
=20
Gnu C                  4.8.2
Gnu make               4.0
binutils               2.23.2
util-linux             2.24
mount                  assert
module-init-tools      15
e2fsprogs              1.42.8
jfsutils               1.1.15
xfsprogs               3.1.11
PPP                    2.4.5
Linux C Library        2.18
Dynamic linker (ldd)   2.18
Linux C++ Library      6.0.18
Procps                 3.3.9
Kbd                    2.0.1
Sh-utils               8.21
wireless-tools         29
Modules Loaded         nls_cp437 vfat fat usb_storage uvcvideo videobuf2_vm=
alloc videobuf2_memops videobuf2_core videodev media btusb bluetooth ipt_RE=
JECT xt_LOG xt_tcpudp xt_multiport xt_recent xt_conntrack iptable_filter ip=
t_MASQUERADE iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 nf_na=
t nf_conntrack ip_tables x_tables dm_crypt blowfish_generic blowfish_x86_64=
 blowfish_common ecb des_generic cast5_avx_x86_64 cast5_generic cast_common=
 cbc twofish_generic twofish_avx_x86_64 twofish_x86_64_3way twofish_x86_64 =
twofish_common serpent_avx_x86_64 serpent_sse2_x86_64 serpent_generic xts a=
lgif_skcipher af_alg x86_pkg_temp_thermal intel_powerclamp coretemp kvm_int=
el kvm crct10dif_pclmul crct10dif_common crc32_pclmul crc32c_intel ghash_cl=
mulni_intel aesni_intel aes_x86_64 lrw gf128mul glue_helper ablk_helper cry=
ptd arc4 tpm_infineon rtsx_pci_sdmmc dm_mod iwldvm mmc_core rtsx_pci_ms mem=
stick mac80211 fuse iTCO_wdt iTCO_vendor_support microcode psmouse serio_ra=
w iwlwifi sr_mod cdrom pcspkr snd_hda_codec_realtek radeon cfg80211 r8169 x=
hci_hcd rtsx_pci mii ttm thermal snd_hda_intel sony_laptop battery rfkill s=
nd_hda_codec tpm_tis tpm tpm_bios snd_hwdep evdev ehci_pci snd_pcm ac ehci_=
hcd snd_page_alloc snd_timer usbcore i2c_i801 snd soundcore mei_me usb_comm=
on mei shpchp lpc_ich processor loop ext4 crc16 mbcache jbd2 ahci libahci l=
ibata sd_mod scsi_mod i915 video button i2c_algo_bit intel_agp intel_gtt dr=
m_kms_helper drm i2c_core

# 3.
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 42
model name	: Intel(R) Core(TM) i5-2450M CPU @ 2.50GHz
stepping	: 7
microcode	: 0x14
cpu MHz		: 1232.421
cache size	: 3072 KB
physical id	: 0
siblings	: 4
core id		: 0
cpu cores	: 2
apicid		: 0
initial apicid	: 0
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat =
pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm =
constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aper=
fmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16 =
xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx=
 lahf_lm ida arat epb xsaveopt pln pts dtherm tpr_shadow vnmi flexpriority =
ept vpid
bogomips	: 4990.58
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:

# 4.
# dmidecode 2.12
SMBIOS 2.6 present.
21 structures occupying 864 bytes.
Table at 0x000E6020.

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
	Vendor: INSYDE
	Version: R2087H4
	Release Date: 06/15/2012
	ROM Size: 2560 kB
	Characteristics:
		PNP is supported
		BIOS is upgradeable
		BIOS shadowing is allowed
		Boot from CD is supported
		Selectable boot is supported
		EDD is supported
		8042 keyboard services are supported (int 9h)
		CGA/mono video services are supported (int 10h)
		ACPI is supported
		USB legacy is supported
		Smart battery is supported
		BIOS boot specification is supported
		Function key-initiated network boot is supported
		Targeted content distribution is supported
	BIOS Revision: 20.87
	Firmware Revision: 20.87

Handle 0x0001, DMI type 1, 27 bytes
System Information
	Manufacturer: Sony Corporation
	Product Name: VPCSA490X
	Version: C60A9X59
	Serial Number: 54249525-0000468
	UUID: 658D7E60-7C15-11E1-863F-1DD8385A413C
	Wake-up Type: Power Switch
	SKU Number: N/A
	Family: VAIO

Handle 0x0002, DMI type 2, 10 bytes
Base Board Information
	Manufacturer: Sony Corporation
	Product Name: VAIO
	Version: N/A
	Serial Number: N/A
	Asset Tag: N/A
	Features:
		Board is a hosting board

Handle 0x0003, DMI type 3, 17 bytes
Chassis Information
	Manufacturer: Sony Corporation
	Type: Notebook
	Lock: Not Present
	Version: N/A
	Serial Number: N/A
	Asset Tag: N/A
	Boot-up State: Safe
	Power Supply State: Safe
	Thermal State: Safe
	Security Status: None
	OEM Information: 0x00000000

Handle 0x0004, DMI type 11, 5 bytes
OEM Strings
	String 1: 1057772965A
	String 2: FNC-EXTB
	String 3: ARWB3Ea_4JQZQRrA2S7Yqj89mU7YqWd1mUBI2Wd1ujBI2S7Xv_
	String 4: Reserved
	String 5: 7.1.13.1088

Handle 0x0005, DMI type 13, 22 bytes
BIOS Language Information
	Language Description Format: Long
	Installable Languages: 1
		en|US|iso8859-1
	Currently Installed Language: en|US|iso8859-1

Handle 0x0006, DMI type 32, 20 bytes
System Boot Information
	Status: No errors detected

Handle 0x0007, DMI type 136, 11 bytes
OEM-specific Type
	Header and Data:
		88 0B 07 00 01 44 49 52 53 09 05
	Strings:
		SRID

Handle 0x0008, DMI type 129, 8 bytes
OEM-specific Type
	Header and Data:
		81 08 08 00 01 01 02 01
	Strings:
		Intel_ASF
		Intel_ASF_001

Handle 0x0009, DMI type 130, 20 bytes
OEM-specific Type
	Header and Data:
		82 14 09 00 24 41 4D 54 01 01 01 01 01 A5 1F 02
		00 00 00 00

Handle 0x000A, DMI type 131, 64 bytes
OEM-specific Type
	Header and Data:
		83 40 0A 00 31 00 00 00 07 00 00 00 00 00 35 00
		F8 00 4B 1C FF FF FF FF 19 00 00 00 01 00 07 00
		40 04 0D 00 80 00 C2 9A C8 00 FF FF 00 00 00 05
		91 00 00 00 76 00 00 00 76 50 72 6F 00 00 00 00

Handle 0x000B, DMI type 16, 15 bytes
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: None
	Maximum Capacity: Unknown
	Error Information Handle: Not Provided
	Number Of Devices: 2

Handle 0x000C, DMI type 17, 21 bytes
Memory Device
	Array Handle: 0x000B
	Error Information Handle: Not Provided
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 4096 MB
	Form Factor: SODIMM
	Set: None
	Locator: SODIMM1
	Bank Locator: Bank 0
	Type: DDR3
	Type Detail: Unknown

Handle 0x000D, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x000FFFFFFFF
	Range Size: 4 GB
	Physical Device Handle: 0x000C
	Memory Array Mapped Address Handle: 0x000F
	Partition Row Position: Unknown
	Interleave Position: Unknown
	Interleaved Data Depth: Unknown

Handle 0x000E, DMI type 17, 21 bytes
Memory Device
	Array Handle: 0x000B
	Error Information Handle: Not Provided
	Total Width: Unknown
	Data Width: Unknown
	Size: No Module Installed
	Form Factor: SODIMM
	Set: None
	Locator: SODIMM2
	Bank Locator: Bank 1
	Type: Unknown
	Type Detail: Unknown

Handle 0x000F, DMI type 19, 15 bytes
Memory Array Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x000FFFFFFFF
	Range Size: 4 GB
	Physical Array Handle: 0x000B
	Partition Width: 2

Handle 0x0010, DMI type 4, 40 bytes
Processor Information
	Socket Designation: N/A
	Type: Central Processor
	Family: Core i5
	Manufacturer: GenuineIntel
	ID: A7 06 02 00 FF FB EB BF
	Signature: Type 0, Family 6, Model 42, Stepping 7
	Flags:
		FPU (Floating-point unit on-chip)
		VME (Virtual mode extension)
		DE (Debugging extension)
		PSE (Page size extension)
		TSC (Time stamp counter)
		MSR (Model specific registers)
		PAE (Physical address extension)
		MCE (Machine check exception)
		CX8 (CMPXCHG8 instruction supported)
		APIC (On-chip APIC hardware supported)
		SEP (Fast system call)
		MTRR (Memory type range registers)
		PGE (Page global enable)
		MCA (Machine check architecture)
		CMOV (Conditional move instruction supported)
		PAT (Page attribute table)
		PSE-36 (36-bit page size extension)
		CLFSH (CLFLUSH instruction supported)
		DS (Debug store)
		ACPI (ACPI supported)
		MMX (MMX technology supported)
		FXSR (FXSAVE and FXSTOR instructions supported)
		SSE (Streaming SIMD extensions)
		SSE2 (Streaming SIMD extensions 2)
		SS (Self-snoop)
		HTT (Multi-threading)
		TM (Thermal monitor supported)
		PBE (Pending break enabled)
	Version: Intel(R) Core(TM) i5-2450M CPU @ 2.50GHz
	Voltage: 1.4 V
	External Clock: 100 MHz
	Max Speed: 2500 MHz
	Current Speed: 2500 MHz
	Status: Populated, Enabled
	Upgrade: None
	L1 Cache Handle: 0x0011
	L2 Cache Handle: 0x0012
	L3 Cache Handle: 0x0013
	Serial Number: N/A
	Asset Tag: N/A
	Part Number: N/A
	Core Count: 2
	Core Enabled: 2
	Thread Count: 4
	Characteristics:
		64-bit capable

Handle 0x0011, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L1 Cache
	Configuration: Enabled, Not Socketed, Level 1
	Operational Mode: Write Through
	Location: Internal
	Installed Size: 128 kB
	Maximum Size: 128 kB
	Supported SRAM Types:
		Unknown
	Installed SRAM Type: Unknown
	Speed: Unknown
	Error Correction Type: Parity
	System Type: Unknown
	Associativity: Unknown

Handle 0x0012, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L2 Cache
	Configuration: Enabled, Not Socketed, Level 2
	Operational Mode: Write Through
	Location: Internal
	Installed Size: 512 kB
	Maximum Size: 512 kB
	Supported SRAM Types:
		Unknown
	Installed SRAM Type: Unknown
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Unified
	Associativity: 8-way Set-associative

Handle 0x0013, DMI type 7, 19 bytes
Cache Information
	Socket Designation: L3 Cache
	Configuration: Enabled, Not Socketed, Level 3
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 3072 kB
	Maximum Size: 3072 kB
	Supported SRAM Types:
		Unknown
	Installed SRAM Type: Unknown
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Unified
	Associativity: 12-way Set-associative

Handle 0x0014, DMI type 127, 4 bytes
End Of Table

# 5. lspci -vk
00:00.0 Host bridge: Intel Corporation 2nd Generation Core Processor Family=
 DRAM Controller (rev 09)
	Subsystem: Sony Corporation Device 907b
	Flags: bus master, fast devsel, latency 0
	Capabilities: [e0] Vendor Specific Information: Len=3D0c <?>

00:01.0 PCI bridge: Intel Corporation Xeon E3-1200/2nd Generation Core Proc=
essor Family PCI Express Root Port (rev 09) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D0
	I/O behind bridge: 00007000-00007fff
	Memory behind bridge: c8400000-c93fffff
	Prefetchable memory behind bridge: 00000000a0000000-00000000afffffff
	Capabilities: [88] Subsystem: Sony Corporation Device 907b
	Capabilities: [80] Power Management version 3
	Capabilities: [90] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
	Capabilities: [a0] Express Root Port (Slot+), MSI 00
	Capabilities: [100] Virtual Channel
	Capabilities: [140] Root Complex Link
	Kernel driver in use: pcieport
	Kernel modules: shpchp

00:02.0 VGA compatible controller: Intel Corporation 2nd Generation Core Pr=
ocessor Family Integrated Graphics Controller (rev 09) (prog-if 00 [VGA con=
troller])
	Subsystem: Sony Corporation Device 907b
	Flags: bus master, fast devsel, latency 0, IRQ 41
	Memory at c0000000 (64-bit, non-prefetchable) [size=3D4M]
	Memory at b0000000 (64-bit, prefetchable) [size=3D256M]
	I/O ports at 8000 [size=3D64]
	Expansion ROM at <unassigned> [disabled]
	Capabilities: [90] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
	Capabilities: [d0] Power Management version 2
	Capabilities: [a4] PCI Advanced Features
	Kernel driver in use: i915
	Kernel modules: i915

00:16.0 Communication controller: Intel Corporation 6 Series/C200 Series Ch=
ipset Family MEI Controller #1 (rev 04)
	Subsystem: Sony Corporation Device 907b
	Flags: bus master, fast devsel, latency 0, IRQ 44
	Memory at c9404000 (64-bit, non-prefetchable) [size=3D16]
	Capabilities: [50] Power Management version 3
	Capabilities: [8c] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
	Kernel driver in use: mei
	Kernel modules: mei

00:1a.0 USB controller: Intel Corporation 6 Series/C200 Series Chipset Fami=
ly USB Enhanced Host Controller #2 (rev 04) (prog-if 20 [EHCI])
	Subsystem: Sony Corporation Device 907b
	Flags: medium devsel, IRQ 23
	Memory at c9409000 (32-bit, non-prefetchable) [size=3D1K]
	Capabilities: [50] Power Management version 2
	Capabilities: [58] Debug port: BAR=3D1 offset=3D00a0
	Capabilities: [98] PCI Advanced Features
	Kernel driver in use: ehci_hcd
	Kernel modules: ehci_hcd

00:1b.0 Audio device: Intel Corporation 6 Series/C200 Series Chipset Family=
 High Definition Audio Controller (rev 04)
	Subsystem: Sony Corporation Device 907b
	Flags: bus master, fast devsel, latency 0, IRQ 45
	Memory at c9400000 (64-bit, non-prefetchable) [size=3D16K]
	Capabilities: [50] Power Management version 2
	Capabilities: [60] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
	Capabilities: [70] Express Root Complex Integrated Endpoint, MSI 00
	Capabilities: [100] Virtual Channel
	Capabilities: [130] Root Complex Link
	Kernel driver in use: snd_hda_intel
	Kernel modules: snd_hda_intel

00:1c.0 PCI bridge: Intel Corporation 6 Series/C200 Series Chipset Family P=
CI Express Root Port 1 (rev b4) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=3D00, secondary=3D02, subordinate=3D02, sec-latency=3D0
	I/O behind bridge: 00006000-00006fff
	Memory behind bridge: c7400000-c83fffff
	Prefetchable memory behind bridge: 00000000c0400000-00000000c13fffff
	Capabilities: [40] Express Root Port (Slot+), MSI 00
	Capabilities: [80] MSI: Enable- Count=3D1/1 Maskable- 64bit-
	Capabilities: [90] Subsystem: Sony Corporation Device 907b
	Capabilities: [a0] Power Management version 2
	Kernel driver in use: pcieport
	Kernel modules: shpchp

00:1c.1 PCI bridge: Intel Corporation 6 Series/C200 Series Chipset Family P=
CI Express Root Port 2 (rev b4) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=3D00, secondary=3D03, subordinate=3D03, sec-latency=3D0
	I/O behind bridge: 00005000-00005fff
	Memory behind bridge: c6400000-c73fffff
	Prefetchable memory behind bridge: 00000000c1400000-00000000c23fffff
	Capabilities: [40] Express Root Port (Slot+), MSI 00
	Capabilities: [80] MSI: Enable- Count=3D1/1 Maskable- 64bit-
	Capabilities: [90] Subsystem: Sony Corporation Device 907b
	Capabilities: [a0] Power Management version 2
	Kernel driver in use: pcieport
	Kernel modules: shpchp

00:1c.2 PCI bridge: Intel Corporation 6 Series/C200 Series Chipset Family P=
CI Express Root Port 3 (rev b4) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=3D00, secondary=3D04, subordinate=3D04, sec-latency=3D0
	I/O behind bridge: 00004000-00004fff
	Memory behind bridge: c5400000-c63fffff
	Prefetchable memory behind bridge: 00000000c2400000-00000000c33fffff
	Capabilities: [40] Express Root Port (Slot+), MSI 00
	Capabilities: [80] MSI: Enable- Count=3D1/1 Maskable- 64bit-
	Capabilities: [90] Subsystem: Sony Corporation Device 907b
	Capabilities: [a0] Power Management version 2
	Kernel driver in use: pcieport
	Kernel modules: shpchp

00:1c.3 PCI bridge: Intel Corporation 6 Series/C200 Series Chipset Family P=
CI Express Root Port 4 (rev b4) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=3D00, secondary=3D05, subordinate=3D05, sec-latency=3D0
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: c4400000-c53fffff
	Prefetchable memory behind bridge: 00000000c3400000-00000000c43fffff
	Capabilities: [40] Express Root Port (Slot+), MSI 00
	Capabilities: [80] MSI: Enable- Count=3D1/1 Maskable- 64bit-
	Capabilities: [90] Subsystem: Sony Corporation Device 907b
	Capabilities: [a0] Power Management version 2
	Kernel driver in use: pcieport
	Kernel modules: shpchp

00:1d.0 USB controller: Intel Corporation 6 Series/C200 Series Chipset Fami=
ly USB Enhanced Host Controller #1 (rev 04) (prog-if 20 [EHCI])
	Subsystem: Sony Corporation Device 907b
	Flags: medium devsel, IRQ 20
	Memory at c9408000 (32-bit, non-prefetchable) [size=3D1K]
	Capabilities: [50] Power Management version 2
	Capabilities: [58] Debug port: BAR=3D1 offset=3D00a0
	Capabilities: [98] PCI Advanced Features
	Kernel driver in use: ehci_hcd
	Kernel modules: ehci_hcd

00:1f.0 ISA bridge: Intel Corporation HM67 Express Chipset Family LPC Contr=
oller (rev 04)
	Subsystem: Sony Corporation Device 907b
	Flags: bus master, medium devsel, latency 0
	Capabilities: [e0] Vendor Specific Information: Len=3D0c <?>
	Kernel driver in use: lpc_ich
	Kernel modules: lpc_ich

00:1f.2 RAID bus controller: Intel Corporation 82801 Mobile SATA Controller=
 [RAID mode] (rev 04)
	Subsystem: Sony Corporation Device 907b
	Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 42
	I/O ports at 8088 [size=3D8]
	I/O ports at 8094 [size=3D4]
	I/O ports at 8080 [size=3D8]
	I/O ports at 8090 [size=3D4]
	I/O ports at 8060 [size=3D32]
	Memory at c9407000 (32-bit, non-prefetchable) [size=3D2K]
	Capabilities: [80] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
	Capabilities: [70] Power Management version 3
	Capabilities: [a8] SATA HBA v1.0
	Capabilities: [b0] PCI Advanced Features
	Kernel driver in use: ahci
	Kernel modules: ahci

00:1f.3 SMBus: Intel Corporation 6 Series/C200 Series Chipset Family SMBus =
Controller (rev 04)
	Subsystem: Sony Corporation Device 907b
	Flags: medium devsel, IRQ 22
	Memory at c9405000 (64-bit, non-prefetchable) [size=3D256]
	I/O ports at 8040 [size=3D32]
	Kernel modules: i2c_i801

01:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] W=
histler [Radeon HD 6630M/6650M/6750M/7670M/7690M] (rev ff) (prog-if ff)
	!!! Unknown header type 7f
	Kernel driver in use: radeon
	Kernel modules: radeon

02:00.0 Network controller: Intel Corporation Centrino Advanced-N 6230 [Rai=
nbow Peak] (rev 34)
	Subsystem: Intel Corporation Centrino Advanced-N 6230 AGN
	Flags: bus master, fast devsel, latency 0, IRQ 52
	Memory at c7400000 (64-bit, non-prefetchable) [size=3D8K]
	Capabilities: [c8] Power Management version 3
	Capabilities: [d0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
	Capabilities: [e0] Express Endpoint, MSI 00
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [140] Device Serial Number 88-53-2e-ff-ff-d8-f7-43
	Kernel driver in use: iwlwifi
	Kernel modules: iwlwifi

03:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. RTS5209 PC=
I Express Card Reader (rev 01)
	Subsystem: Sony Corporation Device 907b
	Flags: bus master, fast devsel, latency 0, IRQ 17
	Memory at c6400000 (32-bit, non-prefetchable) [size=3D4K]
	Capabilities: [40] Power Management version 3
	Capabilities: [50] MSI: Enable- Count=3D1/1 Maskable- 64bit+
	Capabilities: [70] Express Endpoint, MSI 00
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [140] Device Serial Number 00-00-00-01-00-4c-e0-00
	Kernel driver in use: rts_pstor
	Kernel modules: rts_pstor

04:00.0 USB controller: NEC Corporation uPD720200 USB 3.0 Host Controller (=
rev 04) (prog-if 30 [XHCI])
	Subsystem: Sony Corporation Device 907b
	Flags: fast devsel, IRQ 18
	Memory at c5400000 (64-bit, non-prefetchable) [size=3D8K]
	Capabilities: [50] Power Management version 3
	Capabilities: [70] MSI: Enable- Count=3D1/8 Maskable- 64bit+
	Capabilities: [90] MSI-X: Enable+ Count=3D8 Masked-
	Capabilities: [a0] Express Endpoint, MSI 00
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [140] Device Serial Number ff-ff-ff-ff-ff-ff-ff-ff
	Capabilities: [150] Latency Tolerance Reporting
	Kernel driver in use: xhci_hcd
	Kernel modules: xhci_hcd

05:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168 P=
CI Express Gigabit Ethernet controller (rev 06)
	Subsystem: Sony Corporation Device 907b
	Flags: bus master, fast devsel, latency 0, IRQ 51
	I/O ports at 3000 [size=3D256]
	Memory at c3404000 (64-bit, prefetchable) [size=3D4K]
	Memory at c3400000 (64-bit, prefetchable) [size=3D16K]
	Capabilities: [40] Power Management version 3
	Capabilities: [50] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
	Capabilities: [70] Express Endpoint, MSI 01
	Capabilities: [b0] MSI-X: Enable- Count=3D4 Masked-
	Capabilities: [d0] Vital Product Data
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [140] Virtual Channel
	Capabilities: [160] Device Serial Number 01-00-00-00-68-4c-e0-00
	Kernel driver in use: r8169
	Kernel modules: r8169


--BXVAT5kNtrzKuDFl--
