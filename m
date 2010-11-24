From: Thomas Kahle <tomka@gentoo.org>
Subject: possible regression in merge window of 2.6.36
Date: Wed, 24 Nov 2010 01:02:29 +0100
Message-ID: <20101124000229.GA2911@denkmatte.mittag-leffler.se>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6447870400483754651=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org


--===============6447870400483754651==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SkvwRMAIpAhPCcCJ"
Content-Disposition: inline


--SkvwRMAIpAhPCcCJ
Content-Type: multipart/mixed; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I'm trying to debug freezes upon resume from suspend-to-RAM on my
Thinkpad X61s.  The userland is a mostly stable x86 Gentoo Linux with
recent X stack.  The freeze does not occur always, but it is
reproducable after a few successful suspend-resume cycles.  I can
reproduce it because affected kernels will not complete 10
suspend-resume cycles, so this has been my criterion for all the tests I
have done.  When the freeze occurs I have seen various things happening.
In most instances the X screen comes up in the state before the resume
works for a few milliseconds and then freezes.  In this state the
computer is not reachable by ssh and the only option is to reboot.  In
other instances I have also seen X crashing, dropping me to a console
and then freezing.  In one inctance (still with gentoo-sources, before I
started testing with mainline) I was able to ssh into the system and
found spurious things in the log.  Please see the attachad file
'messages'.  On 12:08:33 I connect via ssh as root.  I see the process X
occupying 100% CPU and it cannot be killed (kill -9 has no effect).  I
tried to reboot the machine with init 6, but this failed.

These problems appear to me as a regression since everything is
reproducibly fine with kernels <=3D2.6.34, and 2.6.35 seems to be fine too
(although I have tested that less).  I started a bisect, see below.

I hope this is the correct mailing list to report this bug.  Since I am
not subsribed, please CC me on reply.  This is also my first kernel bug
report, I'm happy to provide any additional information.  I'm attaching
the following information in the hope that it is useful:

-) Output of dmidecode
-) Output of lspci -vvv
-) Messages=20
-) log of a bisect I started.  I will take some days to finish probably
 and I'm running into 'skips' now.

Regards,=20
Thomas


--=20
Thomas Kahle
http://dev.gentoo.org/~tomka/

--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=bisect-log

git bisect start
# bad: [3561d43fd289f590fdae672e5eb831b8d5cf0bf6] Linux 2.6.37-rc3
git bisect bad 3561d43fd289f590fdae672e5eb831b8d5cf0bf6
# good: [9fe6206f400646a2322096b56c59891d530e8d51] Linux 2.6.35
git bisect good 9fe6206f400646a2322096b56c59891d530e8d51
# bad: [a126681810a327bee60a58ac5ad77f4518cf7a5f] [media] staging/lirc: ioctl portability fixups
git bisect bad a126681810a327bee60a58ac5ad77f4518cf7a5f
# skip: [faa38b5e0e092914764cdba9f83d31a3f794d182] Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6
git bisect skip faa38b5e0e092914764cdba9f83d31a3f794d182
# good: [0aa094331b19e54f928e2ac083285ff68d91c69b] [SCSI] be2iscsi: Remove debug print in IO path
git bisect good 0aa094331b19e54f928e2ac083285ff68d91c69b
# good: [c14c643b3d91cc741425c058968672228c310927] e1000e: update driver version number
git bisect good c14c643b3d91cc741425c058968672228c310927
# skip: [d71048e22f47725a5808ea2e4e1e72fa36c1a788] Merge branch 'omap-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6
git bisect skip d71048e22f47725a5808ea2e4e1e72fa36c1a788
# bad: [06c10884486a63a1e4ff657aaa51e848e64b9dc3] ARM: relax ioremap prohibition (309caa9) for -final and -stable
git bisect bad 06c10884486a63a1e4ff657aaa51e848e64b9dc3
# bad: [625c94df22fb4247c8ccd54635a8ec77cb60d651] [S390] dasd: fix format string types
git bisect bad 625c94df22fb4247c8ccd54635a8ec77cb60d651
# good: [ab69bcd66fb4be64edfc767365cb9eb084961246] Merge git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core-2.6
git bisect good ab69bcd66fb4be64edfc767365cb9eb084961246
# skip: [9e0ba741aabdf129d561e62d207c75146adef5e8] drivers/char/vt.c:vc_do_resize(): local var `end' should be unsigned long
git bisect skip 9e0ba741aabdf129d561e62d207c75146adef5e8
# skip: [6b8e8282611ea35845dcff0cb321a7d735fc3155] drivers/hwmon/coretemp.c: remove unneeded #ifdef CONFIG_HOTPLUG_CPU
git bisect skip 6b8e8282611ea35845dcff0cb321a7d735fc3155

--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dmidecode

# dmidecode 2.10
SMBIOS 2.4 present.
63 structures occupying 2129 bytes.
Table at 0x000E0010.

Handle 0x0000, DMI type 0, 24 bytes
BIOS Information
	Vendor: LENOVO
	Version: 7NETC0WW (2.20 )
	Release Date: 03/12/2009
	Address: 0xE0000
	Runtime Size: 128 kB
	ROM Size: 4096 kB
	Characteristics:
		PCI is supported
		PC Card (PCMCIA) is supported
		PNP is supported
		BIOS is upgradeable
		BIOS shadowing is allowed
		ESCD support is available
		Boot from CD is supported
		Selectable boot is supported
		BIOS ROM is socketed
		EDD is supported
		ACPI is supported
		USB legacy is supported
		BIOS boot specification is supported
		Targeted content distribution is supported
	BIOS Revision: 2.32
	Firmware Revision: 1.3

Handle 0x0001, DMI type 1, 27 bytes
System Information
	Manufacturer: LENOVO
	Product Name: 7667WHE
	Version: ThinkPad X61s
	Serial Number: L3G0259
	UUID: 462B9181-49C0-11CB-A388-BB419BD5D6E6
	Wake-up Type: Power Switch
	SKU Number: Not Specified
	Family: ThinkPad X61s

Handle 0x0002, DMI type 2, 8 bytes
Base Board Information
	Manufacturer: LENOVO
	Product Name: 7667WHE
	Version: Not Available
	Serial Number: 1ZF3Z88A3N3

Handle 0x0003, DMI type 3, 13 bytes
Chassis Information
	Manufacturer: LENOVO
	Type: Notebook
	Lock: Not Present
	Version: Not Available
	Serial Number: Not Available
	Asset Tag: No Asset Information
	Boot-up State: Unknown
	Power Supply State: Unknown
	Thermal State: Unknown
	Security Status: Unknown

Handle 0x0004, DMI type 126, 13 bytes
Inactive

Handle 0x0005, DMI type 126, 13 bytes
Inactive

Handle 0x0006, DMI type 4, 35 bytes
Processor Information
	Socket Designation: None
	Type: Central Processor
	Family: Other
	Manufacturer: GenuineIntel
	ID: FB 06 00 00 FF FB EB BF
	Signature: Type 0, Family 6, Model 15, Stepping 11
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
		FXSR (Fast floating-point save and restore)
		SSE (Streaming SIMD extensions)
		SSE2 (Streaming SIMD extensions 2)
		SS (Self-snoop)
		HTT (Hyper-threading technology)
		TM (Thermal monitor supported)
		PBE (Pending break enabled)
	Version: Intel(R) Core(TM)2 Duo CPU     L7500  @ 1.60GHz
	Voltage: 1.1 V
	External Clock: 200 MHz
	Max Speed: 1600 MHz
	Current Speed: 1600 MHz
	Status: Populated, Enabled
	Upgrade: None
	L1 Cache Handle: 0x000A
	L2 Cache Handle: 0x000C
	L3 Cache Handle: Not Provided
	Serial Number: Not Specified
	Asset Tag: Not Specified
	Part Number: Not Specified

Handle 0x0007, DMI type 5, 20 bytes
Memory Controller Information
	Error Detecting Method: None
	Error Correcting Capabilities:
		None
	Supported Interleave: One-way Interleave
	Current Interleave: One-way Interleave
	Maximum Memory Module Size: 4096 MB
	Maximum Total Memory Size: 8192 MB
	Supported Speeds:
		Other
	Supported Memory Types:
		DIMM
		SDRAM
	Memory Module Voltage: 2.9 V
	Associated Memory Slots: 2
		0x0008
		0x0009
	Enabled Error Correcting Capabilities:
		Unknown

Handle 0x0008, DMI type 6, 12 bytes
Memory Module Information
	Socket Designation: DIMM Slot 1
	Bank Connections: 0 1
	Current Speed: 155 ns
	Type: DIMM SDRAM
	Installed Size: 1024 MB (Double-bank Connection)
	Enabled Size: 1024 MB (Double-bank Connection)
	Error Status: OK

Handle 0x0009, DMI type 6, 12 bytes
Memory Module Information
	Socket Designation: DIMM Slot 2
	Bank Connections: 2 3
	Current Speed: 155 ns
	Type: DIMM SDRAM
	Installed Size: 2048 MB (Double-bank Connection)
	Enabled Size: 2048 MB (Double-bank Connection)
	Error Status: OK

Handle 0x000A, DMI type 7, 19 bytes
Cache Information
	Socket Designation: Internal L1 Cache
	Configuration: Enabled, Socketed, Level 1
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 64 kB
	Maximum Size: 64 kB
	Supported SRAM Types:
		Synchronous
	Installed SRAM Type: Synchronous
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Instruction
	Associativity: 8-way Set-associative

Handle 0x000B, DMI type 7, 19 bytes
Cache Information
	Socket Designation: Internal L1 Cache
	Configuration: Enabled, Socketed, Level 1
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 64 kB
	Maximum Size: 64 kB
	Supported SRAM Types:
		Synchronous
	Installed SRAM Type: Synchronous
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Data
	Associativity: 8-way Set-associative

Handle 0x000C, DMI type 7, 19 bytes
Cache Information
	Socket Designation: Internal L2 Cache
	Configuration: Enabled, Socketed, Level 2
	Operational Mode: Write Back
	Location: Internal
	Installed Size: 4096 kB
	Maximum Size: 4096 kB
	Supported SRAM Types:
		Burst
	Installed SRAM Type: Burst
	Speed: Unknown
	Error Correction Type: Single-bit ECC
	System Type: Unified
	Associativity: 8-way Set-associative

Handle 0x000D, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: Not Available
	Internal Connector Type: None
	External Reference Designator: External Monitor
	External Connector Type: DB-15 female
	Port Type: Video Port

Handle 0x000E, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: Not Available
	Internal Connector Type: None
	External Reference Designator: Microphone Jack
	External Connector Type: Mini Jack (headphones)
	Port Type: Audio Port

Handle 0x000F, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: Not Available
	Internal Connector Type: None
	External Reference Designator: Headphone Jack
	External Connector Type: Mini Jack (headphones)
	Port Type: Audio Port

Handle 0x0010, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: Not Available
	Internal Connector Type: None
	External Reference Designator: Modem
	External Connector Type: RJ-11
	Port Type: Modem Port

Handle 0x0011, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: Not Available
	Internal Connector Type: None
	External Reference Designator: Ethernet
	External Connector Type: RJ-45
	Port Type: Network Port

Handle 0x0012, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: Not Available
	Internal Connector Type: None
	External Reference Designator: USB 1
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x0013, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: Not Available
	Internal Connector Type: None
	External Reference Designator: USB 2
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x0014, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: Not Available
	Internal Connector Type: None
	External Reference Designator: USB 3
	External Connector Type: Access Bus (USB)
	Port Type: USB

Handle 0x0015, DMI type 126, 9 bytes
Inactive

Handle 0x0016, DMI type 126, 9 bytes
Inactive

Handle 0x0017, DMI type 126, 9 bytes
Inactive

Handle 0x0018, DMI type 126, 9 bytes
Inactive

Handle 0x0019, DMI type 126, 9 bytes
Inactive

Handle 0x001A, DMI type 126, 9 bytes
Inactive

Handle 0x001B, DMI type 8, 9 bytes
Port Connector Information
	Internal Reference Designator: Not Available
	Internal Connector Type: None
	External Reference Designator: IEEE1394
	External Connector Type: IEEE 1394
	Port Type: Firewire (IEEE P1394)

Handle 0x001C, DMI type 9, 13 bytes
System Slot Information
	Designation: CardBus Slot 1
	Type: 32-bit PC Card (PCMCIA)
	Current Usage: Available
	Length: Other
	ID: Adapter 0, Socket 0
	Characteristics:
		5.0 V is provided
		3.3 V is provided
		PC Card-16 is supported
		Cardbus is supported
		Zoom Video is supported
		Modem ring resume is supported
		PME signal is supported
		Hot-plug devices are supported

Handle 0x001D, DMI type 9, 13 bytes
System Slot Information
	Designation: Media Card Slot 1
	Type: Other
	Current Usage: Available
	Length: Other
	Characteristics:
		Hot-plug devices are supported

Handle 0x001E, DMI type 10, 6 bytes
On Board Device Information
	Type: Other
	Status: Enabled
	Description: IBM Embedded Security hardware

Handle 0x001F, DMI type 11, 5 bytes
OEM Strings
	String 1: IBM ThinkPad Embedded Controller -[7MHT25WW-1.03    ]-

Handle 0x0020, DMI type 13, 22 bytes
BIOS Language Information
	Installable Languages: 1
		enUS
	Currently Installed Language: enUS

Handle 0x0021, DMI type 15, 25 bytes
System Event Log
	Area Length: 0 bytes
	Header Start Offset: 0x0000
	Header Length: 16 bytes
	Data Start Offset: 0x0010
	Access Method: General-purpose non-volatile data functions
	Access Address: 0x0000
	Status: Valid, Not Full
	Change Token: 0x000000D7
	Header Format: Type 1
	Supported Log Type Descriptors: 1
	Descriptor 1: POST error
	Data Format 1: POST results bitmap

Handle 0x0022, DMI type 16, 15 bytes
Physical Memory Array
	Location: System Board Or Motherboard
	Use: System Memory
	Error Correction Type: None
	Maximum Capacity: 4 GB
	Error Information Handle: Not Provided
	Number Of Devices: 2

Handle 0x0023, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x0022
	Error Information Handle: 0xFF01
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 1024 MB
	Form Factor: SODIMM
	Set: None
	Locator: DIMM 1
	Bank Locator: Bank 0/1
	Type: DDR2
	Type Detail: Synchronous
	Speed: 667 MHz
	Manufacturer: Not Specified
	Serial Number: Not Specified
	Asset Tag: Not Specified
	Part Number: Not Specified

Handle 0x0024, DMI type 17, 27 bytes
Memory Device
	Array Handle: 0x0022
	Error Information Handle: 0xFF01
	Total Width: 64 bits
	Data Width: 64 bits
	Size: 2048 MB
	Form Factor: SODIMM
	Set: None
	Locator: DIMM 2
	Bank Locator: Bank 2/3
	Type: DDR2
	Type Detail: Synchronous
	Speed: 667 MHz
	Manufacturer: Not Specified
	Serial Number: Not Specified
	Asset Tag: Not Specified
	Part Number: Not Specified

Handle 0x0025, DMI type 18, 23 bytes
32-bit Memory Error Information
	Type: OK
	Granularity: Unknown
	Operation: Unknown
	Vendor Syndrome: Unknown
	Memory Array Address: Unknown
	Device Address: Unknown
	Resolution: Unknown

Handle 0x0026, DMI type 19, 15 bytes
Memory Array Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x000BFFFFFFF
	Range Size: 3 GB
	Physical Array Handle: 0x0022
	Partition Width: 0

Handle 0x0027, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00000000000
	Ending Address: 0x0003FFFFFFF
	Range Size: 1 GB
	Physical Device Handle: 0x0023
	Memory Array Mapped Address Handle: 0x0026
	Partition Row Position: 1

Handle 0x0028, DMI type 20, 19 bytes
Memory Device Mapped Address
	Starting Address: 0x00040000000
	Ending Address: 0x000BFFFFFFF
	Range Size: 2 GB
	Physical Device Handle: 0x0024
	Memory Array Mapped Address Handle: 0x0026
	Partition Row Position: 1

Handle 0x0029, DMI type 21, 7 bytes
Built-in Pointing Device
	Type: Track Point
	Interface: PS/2
	Buttons: 3

Handle 0x002A, DMI type 22, 26 bytes
Portable Battery
	Location: Rear
	Manufacturer: SANYO
	Name: 42T4506
	Design Capacity: 74880 mWh
	Design Voltage: 14400 mV
	SBDS Version: 03.01
	Maximum Error: Unknown
	SBDS Serial Number: 0681
	SBDS Manufacture Date: 2008-03-04
	SBDS Chemistry: LION
	OEM-specific Information: 0x00000000

Handle 0x002B, DMI type 126, 26 bytes
Inactive

Handle 0x002C, DMI type 24, 5 bytes
Hardware Security
	Power-On Password Status: Disabled
	Keyboard Password Status: Disabled
	Administrator Password Status: Disabled
	Front Panel Reset Status: Unknown

Handle 0x002D, DMI type 32, 11 bytes
System Boot Information
	Status: No errors detected

Handle 0x002E, DMI type 131, 17 bytes
OEM-specific Type
	Header and Data:
		83 11 2E 00 01 02 03 FF FF 1F 00 00 00 00 00 02
		00
	Strings:
		BOOTINF 20h
		BOOTDEV 21h
		KEYPTRS 23h

Handle 0x002F, DMI type 131, 22 bytes
OEM-specific Type
	Header and Data:
		83 16 2F 00 01 02 00 00 00 00 00 00 00 00 00 00
		00 00 00 00 00 01
	Strings:
		TVT-Enablement

Handle 0x0030, DMI type 132, 7 bytes
OEM-specific Type
	Header and Data:
		84 07 30 00 02 D8 36

Handle 0x0031, DMI type 133, 5 bytes
OEM-specific Type
	Header and Data:
		85 05 31 00 01
	Strings:
		KHOIHGIUCCHHII

Handle 0x0032, DMI type 134, 13 bytes
OEM-specific Type
	Header and Data:
		86 0D 32 00 30 08 08 20 00 00 00 00 00

Handle 0x0033, DMI type 134, 16 bytes
OEM-specific Type
	Header and Data:
		86 10 33 00 00 41 54 4D 4C 01 01 00 00 03 01 02
	Strings:
		TPM INFO
		System Reserved

Handle 0x0034, DMI type 135, 13 bytes
OEM-specific Type
	Header and Data:
		87 0D 34 00 54 50 07 00 01 00 00 00 00

Handle 0x0035, DMI type 135, 18 bytes
OEM-specific Type
	Header and Data:
		87 12 35 00 54 50 07 01 01 B2 0D 00 00 00 00 00
		00 00

Handle 0x0036, DMI type 135, 35 bytes
OEM-specific Type
	Header and Data:
		87 23 36 00 54 50 07 02 42 41 59 20 49 2F 4F 20
		01 00 02 00 00 0A 00 30 1C 26 1C 02 00 0E 00 F0
		01 F6 03

Handle 0x0037, DMI type 135, 26 bytes
OEM-specific Type
	Header and Data:
		87 1A 37 00 54 50 07 04 01 04 01 01 02 00 02 02
		02 00 03 01 02 00 04 01 02 00

Handle 0x0038, DMI type 136, 6 bytes
OEM-specific Type
	Header and Data:
		88 06 38 00 5A 5A

Handle 0x0039, DMI type 137, 28 bytes
OEM-specific Type
	Header and Data:
		89 1C 39 00 0C 02 00 01 01 00 00 01 50 57 4D 53
		20 49 6E 66 6F 72 6D 61 74 69 6F 6E

Handle 0x003A, DMI type 138, 40 bytes
OEM-specific Type
	Header and Data:
		8A 28 3A 00 14 01 02 01 40 02 01 40 02 01 40 02
		01 40 01 40 42 49 4F 53 20 50 61 73 73 77 6F 72
		64 20 46 6F 72 6D 61 74

Handle 0x003B, DMI type 139, 37 bytes
OEM-specific Type
	Header and Data:
		8B 25 3B 00 11 01 0A 00 00 00 00 00 00 00 00 00
		00 50 57 4D 53 20 4B 65 79 20 49 6E 66 6F 72 6D
		61 74 69 6F 6E

Handle 0x003C, DMI type 129, 8 bytes
OEM-specific Type
	Header and Data:
		81 08 3C 00 01 01 02 00
	Strings:
		Intel_ASF
		Intel_ASF_001

Handle 0x003D, DMI type 130, 20 bytes
OEM-specific Type
	Header and Data:
		82 14 3D 00 24 41 4D 54 01 00 00 00 00 A5 00 00
		00 00 00 00

Handle 0x003E, DMI type 127, 4 bytes
End Of Table


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=lspci-vvv

00:00.0 Host bridge: Intel Corporation Mobile PM965/GM965/GL960 Memory Controller Hub (rev 0c)
	Subsystem: Lenovo T61
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR- INTx-
	Latency: 0
	Capabilities: [e0] Vendor Specific Information <?>
	Kernel driver in use: agpgart-intel

00:02.0 VGA compatible controller: Intel Corporation Mobile GM965/GL960 Integrated Graphics Controller (rev 0c) (prog-if 00 [VGA controller])
	Subsystem: Lenovo T61
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 26
	Region 0: Memory at f8000000 (64-bit, non-prefetchable) [size=1M]
	Region 2: Memory at e0000000 (64-bit, prefetchable) [size=256M]
	Region 4: I/O ports at 1800 [size=8]
	Expansion ROM at <unassigned> [disabled]
	Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee0300c  Data: 4161
	Capabilities: [d0] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
		Bridge: PM- B3+
	Kernel driver in use: i915

00:02.1 Display controller: Intel Corporation Mobile GM965/GL960 Integrated Graphics Controller (rev 0c)
	Subsystem: Lenovo T61
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Region 0: Memory at f8100000 (64-bit, non-prefetchable) [size=1M]
	Capabilities: [d0] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
		Bridge: PM- B3+

00:19.0 Ethernet controller: Intel Corporation 82566MM Gigabit Network Connection (rev 03)
	Subsystem: Lenovo Device 20de
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 28
	Region 0: Memory at f8200000 (32-bit, non-prefetchable) [size=128K]
	Region 1: Memory at f8225000 (32-bit, non-prefetchable) [size=4K]
	Region 2: I/O ports at 1840 [size=32]
	Capabilities: [c8] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee0300c  Data: 41d1
	Kernel driver in use: e1000e
	Kernel modules: e1000e

00:1a.0 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI Controller #4 (rev 03) (prog-if 00 [UHCI])
	Subsystem: Lenovo ThinkPad T61
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 20
	Region 4: I/O ports at 1860 [size=32]
	Kernel driver in use: uhci_hcd
	Kernel modules: uhci-hcd

00:1a.1 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI Controller #5 (rev 03) (prog-if 00 [UHCI])
	Subsystem: Lenovo ThinkPad T60
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin B routed to IRQ 21
	Region 4: I/O ports at 1880 [size=32]
	Kernel driver in use: uhci_hcd
	Kernel modules: uhci-hcd

00:1a.7 USB Controller: Intel Corporation 82801H (ICH8 Family) USB2 EHCI Controller #2 (rev 03) (prog-if 20 [EHCI])
	Subsystem: Lenovo ThinkPad T61
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin C routed to IRQ 22
	Region 0: Memory at f8426c00 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: ehci_hcd
	Kernel modules: ehci-hcd

00:1b.0 Audio device: Intel Corporation 82801H (ICH8 Family) HD Audio Controller (rev 03)
	Subsystem: Lenovo ThinkPad T61
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 29
	Region 0: Memory at f8220000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee0300c  Data: 4199
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
	Capabilities: [100] Virtual Channel <?>
	Capabilities: [130] Root Complex Link <?>
	Kernel driver in use: HDA Intel
	Kernel modules: snd-hda-intel

00:1c.0 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express Port 1 (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	I/O behind bridge: 00002000-00002fff
	Memory behind bridge: f4000000-f5ffffff
	Prefetchable memory behind bridge: 00000000f8500000-00000000f85fffff
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
		LnkCap:	Port #1, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 <1us, L1 <4us
			ClockPM- Surprise- LLActRep+ BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surpise+
			Slot #  2, PowerLimit 6.500000; Interlock- NoCompl-
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
			Changed: MRL- PresDet- LinkState-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
	Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee0300c  Data: 4151
	Capabilities: [90] Subsystem: Lenovo ThinkPad T61
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100] Virtual Channel <?>
	Capabilities: [180] Root Complex Link <?>
	Kernel driver in use: pcieport

00:1c.1 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express Port 2 (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: f6000000-f7ffffff
	Prefetchable memory behind bridge: 00000000f8600000-00000000f86fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [40] Express (v1) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
			ExtTag- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #2, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 <256ns, L1 <4us
			ClockPM- Surprise- LLActRep+ BwNot-
		LnkCtl:	ASPM L0s L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surpise+
			Slot #  3, PowerLimit 6.500000; Interlock- NoCompl-
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet+ LinkState+
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
		RootCap: CRSVisible-
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
	Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
		Address: fee0300c  Data: 4159
	Capabilities: [90] Subsystem: Lenovo ThinkPad T61
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100] Virtual Channel <?>
	Capabilities: [180] Root Complex Link <?>
	Kernel driver in use: pcieport

00:1d.0 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI Controller #1 (rev 03) (prog-if 00 [UHCI])
	Subsystem: Lenovo ThinkPad T61
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	Region 4: I/O ports at 18a0 [size=32]
	Kernel driver in use: uhci_hcd
	Kernel modules: uhci-hcd

00:1d.1 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI Controller #2 (rev 03) (prog-if 00 [UHCI])
	Subsystem: Lenovo ThinkPad T61
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin B routed to IRQ 17
	Region 4: I/O ports at 18c0 [size=32]
	Kernel driver in use: uhci_hcd
	Kernel modules: uhci-hcd

00:1d.7 USB Controller: Intel Corporation 82801H (ICH8 Family) USB2 EHCI Controller #1 (rev 03) (prog-if 20 [EHCI])
	Subsystem: Lenovo ThinkPad T61
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin D routed to IRQ 19
	Region 0: Memory at f8427000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Debug port: BAR=1 offset=00a0
	Kernel driver in use: ehci_hcd
	Kernel modules: ehci-hcd

00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev f3) (prog-if 01 [Subtractive decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Bus: primary=00, secondary=05, subordinate=08, sec-latency=32
	I/O behind bridge: 00004000-00007fff
	Memory behind bridge: d4000000-d7efffff
	Prefetchable memory behind bridge: 00000000d8000000-00000000dbffffff
	Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [50] Subsystem: Lenovo ThinkPad T61

00:1f.0 ISA bridge: Intel Corporation 82801HBM (ICH8M-E) LPC Interface Controller (rev 03)
	Subsystem: Lenovo T61
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Capabilities: [e0] Vendor Specific Information <?>

00:1f.1 IDE interface: Intel Corporation 82801HBM/HEM (ICH8M/ICH8M-E) IDE Controller (rev 03) (prog-if 8a [Master SecP PriP])
	Subsystem: Lenovo ThinkPad T61
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx+
	Latency: 0
	Interrupt: pin C routed to IRQ 16
	Region 0: I/O ports at 01f0 [size=8]
	Region 1: I/O ports at 03f4 [size=1]
	Region 2: I/O ports at 0170 [size=8]
	Region 3: I/O ports at 0374 [size=1]
	Region 4: I/O ports at 18e0 [size=16]
	Kernel driver in use: ata_piix

00:1f.2 SATA controller: Intel Corporation 82801HBM/HEM (ICH8M/ICH8M-E) SATA AHCI Controller (rev 03) (prog-if 01 [AHCI 1.0])
	Subsystem: Lenovo ThinkPad T61
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin B routed to IRQ 27
	Region 0: I/O ports at 1c30 [size=8]
	Region 1: I/O ports at 1c24 [size=4]
	Region 2: I/O ports at 1c28 [size=8]
	Region 3: I/O ports at 1c20 [size=4]
	Region 4: I/O ports at 1c00 [size=32]
	Region 5: Memory at f8426000 (32-bit, non-prefetchable) [size=2K]
	Capabilities: [80] MSI: Enable+ Count=1/4 Maskable- 64bit-
		Address: fee0300c  Data: 4169
	Capabilities: [70] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [a8] SATA HBA <?>
	Kernel driver in use: ahci

00:1f.3 SMBus: Intel Corporation 82801H (ICH8 Family) SMBus Controller (rev 03)
	Subsystem: Lenovo ThinkPad T61
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at f8427400 (32-bit, non-prefetchable) [size=256]
	Region 4: I/O ports at 1c40 [size=32]

03:00.0 Network controller: Intel Corporation PRO/Wireless 4965 AG or AGN [Kedron] Network Connection (rev 61)
	Subsystem: Intel Corporation Device 1011
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR+ <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 30
	Region 0: Memory at f7f00000 (64-bit, non-prefetchable) [size=8K]
	Capabilities: [c8] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee0300c  Data: 41a1
	Capabilities: [e0] Express (v1) Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 unlimited
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr+ UncorrErr+ FatalErr- UnsuppReq+ AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 <128ns, L1 <64us
			ClockPM+ Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM L0s L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
			ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
	Capabilities: [100] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr+ BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 14, GenCap- CGenEn- ChkCap- ChkEn-
	Capabilities: [140] Device Serial Number 00-1f-3b-ff-ff-29-28-a3
	Kernel driver in use: iwlagn
	Kernel modules: iwlagn

05:00.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev ba)
	Subsystem: Lenovo Device 20c6
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 168, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at d7eff000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=05, secondary=06, subordinate=07, sec-latency=176
	Memory window 0: d8000000-dbfff000 (prefetchable)
	Memory window 1: c0000000-c3fff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001
	Kernel driver in use: yenta_cardbus
	Kernel modules: yenta_socket

05:00.1 FireWire (IEEE 1394): Ricoh Co Ltd R5C832 IEEE 1394 Controller (rev 04) (prog-if 10 [OHCI])
	Subsystem: Lenovo Device 20c7
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 32 (500ns min, 1000ns max)
	Interrupt: pin B routed to IRQ 17
	Region 0: Memory at d7efe800 (32-bit, non-prefetchable) [size=2K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=2 PME+
	Kernel driver in use: ohci1394
	Kernel modules: ohci1394

05:00.2 SD Host controller: Ricoh Co Ltd R5C822 SD/SDIO/MMC/MS/MSPro Host Adapter (rev 21)
	Subsystem: Lenovo Device 20c8
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64
	Interrupt: pin C routed to IRQ 18
	Region 0: Memory at d7efe400 (32-bit, non-prefetchable) [size=256]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=2 PME-
	Kernel driver in use: sdhci-pci
	Kernel modules: sdhci-pci


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=messages

Nov 23 12:06:18 denkmatte kernel: ------------[ cut here ]------------
Nov 23 12:06:18 denkmatte kernel: WARNING: at lib/kref.c:34 0xc035563d()
Nov 23 12:06:18 denkmatte kernel: Hardware name: 7667WHE
Nov 23 12:06:18 denkmatte kernel: Modules linked in: aes_i586 aes_generic ipv6 snd_pcm_oss snd_mixer_oss snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device vboxdrv tp_smapi thinkpad_ec uinput acpi_cpufreq mperf arc4 ecb snd_hda_codec_analog sdhci_pci sdhci thinkpad_acpi mmc_core pcmcia rtc_cmos ohci1394 led_class rtc_core ieee1394 ehci_hcd sg usbcore snd_hda_intel yenta_socket firmware_class rtc_lib snd_hda_codec nvram pcmcia_rsrc pcmcia_core snd_pcm snd_timer snd snd_page_alloc processor battery thermal rfkill ac [last unloaded: e1000e]
Nov 23 12:06:18 denkmatte kernel: Pid: 827, comm: pm-suspend Not tainted 2.6.36-gentoo-r2 #2
Nov 23 12:06:18 denkmatte kernel: Call Trace:
Nov 23 12:06:18 denkmatte kernel: [<c013a4d8>] ? 0xc013a4d8
Nov 23 12:06:18 denkmatte kernel: [<c035563d>] ? 0xc035563d
Nov 23 12:06:18 denkmatte kernel: [<c035563d>] ? 0xc035563d
Nov 23 12:06:18 denkmatte kernel: [<c013a52b>] ? 0xc013a52b
Nov 23 12:06:18 denkmatte kernel: [<c035563d>] ? 0xc035563d
Nov 23 12:06:18 denkmatte kernel: [<c03544cf>] ? 0xc03544cf
Nov 23 12:06:18 denkmatte kernel: [<c0429830>] ? 0xc0429830
Nov 23 12:06:18 denkmatte kernel: [<c0431450>] ? 0xc0431450
Nov 23 12:06:18 denkmatte kernel: [<c017032c>] ? 0xc017032c
Nov 23 12:06:18 denkmatte kernel: [<c017047a>] ? 0xc017047a
Nov 23 12:06:18 denkmatte kernel: [<c016fbe2>] ? 0xc016fbe2
Nov 23 12:06:18 denkmatte kernel: [<c016fb80>] ? 0xc016fb80
Nov 23 12:06:18 denkmatte kernel: [<c0353f90>] ? 0xc0353f90
Nov 23 12:06:18 denkmatte kernel: [<c0234b39>] ? 0xc0234b39
Nov 23 12:06:18 denkmatte kernel: [<c0234aa0>] ? 0xc0234aa0
Nov 23 12:06:18 denkmatte kernel: [<c01df708>] ? 0xc01df708
Nov 23 12:06:18 denkmatte kernel: [<c01df891>] ? 0xc01df891
Nov 23 12:06:18 denkmatte kernel: [<c0102c8c>] ? 0xc0102c8c
Nov 23 12:06:18 denkmatte kernel: ---[ end trace 76b45d16583d421c ]---
Nov 23 12:06:18 denkmatte kernel: Restarting tasks ... done.
Nov 23 12:06:18 denkmatte kernel: video LNXVIDEO:00: Restoring backlight state
Nov 23 12:06:20 denkmatte kernel: e1000e: Intel(R) PRO/1000 Network Driver - 1.2.7-k2
Nov 23 12:06:20 denkmatte kernel: e1000e: Copyright (c) 1999 - 2010 Intel Corporation.
Nov 23 12:06:20 denkmatte kernel: e1000e 0000:00:19.0: PCI INT A -> GSI 20 (level, low) -> IRQ 20
Nov 23 12:06:20 denkmatte kernel: e1000e 0000:00:19.0: setting latency timer to 64
Nov 23 12:06:20 denkmatte kernel: e1000e 0000:00:19.0: irq 45 for MSI/MSI-X
Nov 23 12:06:20 denkmatte kernel: e1000e 0000:00:19.0: eth0: (PCI Express:2.5GB/s:Width x1) 00:1d:72:98:cc:b0
Nov 23 12:06:20 denkmatte kernel: e1000e 0000:00:19.0: eth0: Intel(R) PRO/1000 Network Connection
Nov 23 12:06:20 denkmatte kernel: e1000e 0000:00:19.0: eth0: MAC: 6, PHY: 6, PBA No: 1008ff-0ff
Nov 23 12:06:20 denkmatte kernel: udev: renamed network interface eth0 to eth1
Nov 23 12:06:20 denkmatte kernel: cfg80211: Calling CRDA to update world regulatory domain
Nov 23 12:06:20 denkmatte kernel: iwlagn: Intel(R) Wireless WiFi Link AGN driver for Linux, in-tree:
Nov 23 12:06:20 denkmatte kernel: iwlagn: Copyright(c) 2003-2010 Intel Corporation
Nov 23 12:06:20 denkmatte kernel: iwlagn 0000:03:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
Nov 23 12:06:20 denkmatte kernel: iwlagn 0000:03:00.0: setting latency timer to 64
Nov 23 12:06:20 denkmatte kernel: iwlagn 0000:03:00.0: Detected Intel(R) Wireless WiFi Link 4965AGN, REV=0x4
Nov 23 12:06:20 denkmatte kernel: iwlagn 0000:03:00.0: device EEPROM VER=0x36, CALIB=0x5
Nov 23 12:06:20 denkmatte kernel: iwlagn 0000:03:00.0: Tunable channels: 13 802.11bg, 19 802.11a channels
Nov 23 12:06:20 denkmatte kernel: iwlagn 0000:03:00.0: irq 46 for MSI/MSI-X
Nov 23 12:06:20 denkmatte kernel: iwlagn 0000:03:00.0: loaded firmware version 228.61.2.24
Nov 23 12:06:20 denkmatte kernel: phy0: Selected rate control algorithm 'iwl-agn-rs'
Nov 23 12:06:20 denkmatte kernel: tun: Universal TUN/TAP device driver, 1.6
Nov 23 12:06:20 denkmatte kernel: tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
Nov 23 12:06:20 denkmatte kernel: uhci_hcd: USB Universal Host Controller Interface driver
Nov 23 12:06:20 denkmatte kernel: uhci_hcd 0000:00:1a.0: PCI INT A -> GSI 20 (level, low) -> IRQ 20
Nov 23 12:06:20 denkmatte kernel: uhci_hcd 0000:00:1a.0: setting latency timer to 64
Nov 23 12:06:20 denkmatte kernel: uhci_hcd 0000:00:1a.0: UHCI Host Controller
Nov 23 12:06:20 denkmatte kernel: uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 1
Nov 23 12:06:20 denkmatte kernel: uhci_hcd 0000:00:1a.0: irq 20, io base 0x00001860
Nov 23 12:06:20 denkmatte kernel: hub 1-0:1.0: USB hub found
Nov 23 12:06:20 denkmatte kernel: hub 1-0:1.0: 2 ports detected
Nov 23 12:06:20 denkmatte kernel: uhci_hcd 0000:00:1a.1: power state changed by ACPI to D0
Nov 23 12:06:20 denkmatte kernel: uhci_hcd 0000:00:1a.1: power state changed by ACPI to D0
Nov 23 12:06:20 denkmatte kernel: uhci_hcd 0000:00:1a.1: PCI INT B -> GSI 21 (level, low) -> IRQ 21
Nov 23 12:06:20 denkmatte kernel: uhci_hcd 0000:00:1a.1: setting latency timer to 64
Nov 23 12:06:20 denkmatte kernel: uhci_hcd 0000:00:1a.1: UHCI Host Controller
Nov 23 12:06:20 denkmatte kernel: uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus number 2
Nov 23 12:06:20 denkmatte kernel: uhci_hcd 0000:00:1a.1: irq 21, io base 0x00001880
Nov 23 12:06:20 denkmatte kernel: hub 2-0:1.0: USB hub found
Nov 23 12:06:20 denkmatte kernel: hub 2-0:1.0: 2 ports detected
Nov 23 12:06:20 denkmatte kernel: uhci_hcd 0000:00:1d.0: power state changed by ACPI to D0
Nov 23 12:06:20 denkmatte kernel: uhci_hcd 0000:00:1d.0: power state changed by ACPI to D0
Nov 23 12:06:20 denkmatte kernel: uhci_hcd 0000:00:1d.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
Nov 23 12:06:20 denkmatte kernel: uhci_hcd 0000:00:1d.0: setting latency timer to 64
Nov 23 12:06:20 denkmatte kernel: uhci_hcd 0000:00:1d.0: UHCI Host Controller
Nov 23 12:06:20 denkmatte kernel: uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 3
Nov 23 12:06:20 denkmatte kernel: uhci_hcd 0000:00:1d.0: irq 16, io base 0x000018a0
Nov 23 12:06:20 denkmatte kernel: hub 3-0:1.0: USB hub found
Nov 23 12:06:20 denkmatte kernel: hub 3-0:1.0: 2 ports detected
Nov 23 12:06:20 denkmatte kernel: uhci_hcd 0000:00:1d.1: PCI INT B -> GSI 17 (level, low) -> IRQ 17
Nov 23 12:06:20 denkmatte kernel: uhci_hcd 0000:00:1d.1: setting latency timer to 64
Nov 23 12:06:20 denkmatte kernel: uhci_hcd 0000:00:1d.1: UHCI Host Controller
Nov 23 12:06:20 denkmatte kernel: uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 4
Nov 23 12:06:20 denkmatte kernel: uhci_hcd 0000:00:1d.1: irq 17, io base 0x000018c0
Nov 23 12:06:20 denkmatte kernel: hub 4-0:1.0: USB hub found
Nov 23 12:06:20 denkmatte kernel: hub 4-0:1.0: 2 ports detected
Nov 23 12:06:21 denkmatte kernel: usb 1-2: new full speed USB device using uhci_hcd and address 2
Nov 23 12:06:21 denkmatte cron[1132]: (tom) CMD (source ~/.Xdbus; /home/tom/bin/offlineimapdaemon.sh)
Nov 23 12:06:25 denkmatte kernel: e1000e 0000:00:19.0: irq 45 for MSI/MSI-X
Nov 23 12:06:25 denkmatte kernel: e1000e 0000:00:19.0: irq 45 for MSI/MSI-X
Nov 23 12:06:25 denkmatte kernel: ADDRCONF(NETDEV_UP): eth1: link is not ready
Nov 23 12:06:27 denkmatte kernel: ADDRCONF(NETDEV_UP): wlan0: link is not ready
Nov 23 12:06:29 denkmatte dhcpcd[1157]: dhcpcd not running
Nov 23 12:06:30 denkmatte kernel: ADDRCONF(NETDEV_UP): wlan0: link is not ready
Nov 23 12:06:30 denkmatte dhcpcd[1163]: dhcpcd not running
Nov 23 12:06:30 denkmatte kernel: e1000e 0000:00:19.0: irq 45 for MSI/MSI-X
Nov 23 12:06:30 denkmatte kernel: e1000e 0000:00:19.0: irq 45 for MSI/MSI-X
Nov 23 12:06:30 denkmatte kernel: ADDRCONF(NETDEV_UP): eth1: link is not ready
Nov 23 12:06:30 denkmatte dhcpcd[1177]: dhcpcd not running
Nov 23 12:06:31 denkmatte kernel: ADDRCONF(NETDEV_UP): wlan0: link is not ready
Nov 23 12:06:31 denkmatte dhcpcd[1183]: dhcpcd not running
Nov 23 12:06:32 denkmatte kernel: ADDRCONF(NETDEV_UP): wlan0: link is not ready
Nov 23 12:06:32 denkmatte dhcpcd[1189]: dhcpcd not running
Nov 23 12:06:32 denkmatte kernel: e1000e 0000:00:19.0: irq 45 for MSI/MSI-X
Nov 23 12:06:32 denkmatte kernel: e1000e 0000:00:19.0: irq 45 for MSI/MSI-X
Nov 23 12:06:32 denkmatte kernel: ADDRCONF(NETDEV_UP): eth1: link is not ready
Nov 23 12:06:35 denkmatte kernel: wlan0: authenticate with 00:25:9c:24:2e:f9 (try 1)
Nov 23 12:06:35 denkmatte kernel: wlan0: authenticated
Nov 23 12:06:35 denkmatte kernel: wlan0: associate with 00:25:9c:24:2e:f9 (try 1)
Nov 23 12:06:35 denkmatte kernel: wlan0: RX AssocResp from 00:25:9c:24:2e:f9 (capab=0x411 status=0 aid=3)
Nov 23 12:06:35 denkmatte kernel: wlan0: associated
Nov 23 12:06:35 denkmatte kernel: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
Nov 23 12:06:37 denkmatte dhcpcd[1222]: version 5.2.7 starting
Nov 23 12:06:37 denkmatte dhcpcd[1222]: wlan0: rebinding lease of 130.237.201.215
Nov 23 12:06:37 denkmatte dhcpcd[1222]: wlan0: acknowledged 130.237.201.215 from 130.237.201.195
Nov 23 12:06:37 denkmatte dhcpcd[1222]: wlan0: checking for 130.237.201.215
Nov 23 12:06:42 denkmatte dhcpcd[1222]: wlan0: leased 130.237.201.215 for 1800 seconds
Nov 23 12:06:44 denkmatte dhcpcd[1222]: forked to background, child pid 1275
Nov 23 12:08:33 denkmatte sshd[1598]: Accepted keyboard-interactive/pam for root from 130.237.201.235 port 53527 ssh2
Nov 23 12:08:33 denkmatte sshd[1598]: pam_unix(sshd:session): session opened for user root by (uid=0)
Nov 23 12:08:58 denkmatte tpfancontrol[2247]: Changing fan level: 2->4  (temps: 60 41 41 53 30 _ 29 _ , 39 40 _ , _ )
Nov 23 12:09:01 denkmatte cron[1754]: (tom) CMD (source ~/.Xdbus; /home/tom/bin/offlineimapdaemon.sh)
Nov 23 12:09:14 denkmatte kernel: INFO: task kworker/u:9:32285 blocked for more than 120 seconds.
Nov 23 12:09:14 denkmatte kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Nov 23 12:09:14 denkmatte kernel: kworker/u:9   D 00000001     0 32285      2 0x00000000
Nov 23 12:09:14 denkmatte kernel: f28c6080 00000046 f2eece68 00000001 182389c4 000001c3 d438bf28 000007b2
Nov 23 12:09:14 denkmatte kernel: f2999ac0 000001c3 d438a225 000007b2 c06e3080 c06e3080 c06dc000 f28c6210
Nov 23 12:09:14 denkmatte kernel: f28c620c c06e3080 f28c6080 00001d03 00000000 f3b4f760 ffa47280 ffffffff
Nov 23 12:09:14 denkmatte kernel: Call Trace:
Nov 23 12:09:14 denkmatte kernel: [<c055a394>] ? 0xc055a394
Nov 23 12:09:14 denkmatte kernel: [<c055a558>] ? 0xc055a558
Nov 23 12:09:14 denkmatte kernel: [<c0409e6c>] ? 0xc0409e6c
Nov 23 12:09:14 denkmatte kernel: [<c05590e4>] ? 0xc05590e4
Nov 23 12:09:14 denkmatte kernel: [<c012e0e8>] ? 0xc012e0e8
Nov 23 12:09:14 denkmatte kernel: [<c01533e3>] ? 0xc01533e3
Nov 23 12:09:14 denkmatte kernel: [<c0409e30>] ? 0xc0409e30
Nov 23 12:09:14 denkmatte kernel: [<c0153a71>] ? 0xc0153a71
Nov 23 12:09:14 denkmatte kernel: [<c0153950>] ? 0xc0153950
Nov 23 12:09:14 denkmatte kernel: [<c0156e44>] ? 0xc0156e44
Nov 23 12:09:14 denkmatte kernel: [<c0156dd0>] ? 0xc0156dd0
Nov 23 12:09:14 denkmatte kernel: [<c01031f6>] ? 0xc01031f6
Nov 23 12:10:01 denkmatte cron[2063]: (root) CMD (root^Itest -x /usr/sbin/run-crons && /usr/sbin/run-crons )
Nov 23 12:10:01 denkmatte cron[2062]: (root) CMD (test -x /usr/sbin/run-crons && /usr/sbin/run-crons )
Nov 23 12:10:01 denkmatte cron[2061]: (root) MAIL (mailed 35 bytes of output but got status 0x004e
Nov 23 12:10:01 denkmatte )
Nov 23 12:11:14 denkmatte kernel: INFO: task kworker/u:9:32285 blocked for more than 120 seconds.
Nov 23 12:11:14 denkmatte kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Nov 23 12:11:14 denkmatte kernel: kworker/u:9   D 00000001     0 32285      2 0x00000000
Nov 23 12:11:14 denkmatte kernel: f28c6080 00000046 f2eece68 00000001 182389c4 000001c3 d438bf28 000007b2
Nov 23 12:11:14 denkmatte kernel: f2999ac0 000001c3 d438a225 000007b2 c06e3080 c06e3080 c06dc000 f28c6210
Nov 23 12:11:14 denkmatte kernel: f28c620c c06e3080 f28c6080 00001d03 00000000 f3b4f760 ffa47280 ffffffff
Nov 23 12:11:14 denkmatte kernel: Call Trace:
Nov 23 12:11:14 denkmatte kernel: [<c055a394>] ? 0xc055a394
Nov 23 12:11:14 denkmatte kernel: [<c055a558>] ? 0xc055a558
Nov 23 12:11:14 denkmatte kernel: [<c0409e6c>] ? 0xc0409e6c
Nov 23 12:11:14 denkmatte kernel: [<c05590e4>] ? 0xc05590e4
Nov 23 12:11:14 denkmatte kernel: [<c012e0e8>] ? 0xc012e0e8
Nov 23 12:11:14 denkmatte kernel: [<c01533e3>] ? 0xc01533e3
Nov 23 12:11:14 denkmatte kernel: [<c0409e30>] ? 0xc0409e30
Nov 23 12:11:14 denkmatte kernel: [<c0153a71>] ? 0xc0153a71
Nov 23 12:11:14 denkmatte kernel: [<c0153950>] ? 0xc0153950
Nov 23 12:11:14 denkmatte kernel: [<c0156e44>] ? 0xc0156e44
Nov 23 12:11:14 denkmatte kernel: [<c0156dd0>] ? 0xc0156dd0
Nov 23 12:11:14 denkmatte kernel: [<c01031f6>] ? 0xc01031f6
Nov 23 12:11:39 denkmatte kdm: :0[1993]: pam_unix(kde:session): session closed for user tom
Nov 23 12:11:50 denkmatte /etc/init.d/xdm[2467]: start-stop-daemon: 1 process refused to stop
Nov 23 12:11:50 denkmatte /etc/init.d/xdm[2449]: ERROR: xdm failed to stop
Nov 23 12:12:01 denkmatte cron[2557]: (tom) CMD (source ~/.Xdbus; /home/tom/bin/offlineimapdaemon.sh)

--9jxsPFA5p3P2qPhR--

--SkvwRMAIpAhPCcCJ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iJwEAQEIAAYFAkzsVhUACgkQQYXt1pFHaaFqrgP+JXh8riiENqN255BvKZ9iMZFV
q3WLgCatYKqvWZ+8XA2znr6lCIzBhQ59i9OhHLbdeguGeQkA9OBUwrWQl97g2bJ0
pUvtkk/zPCluDz7IQeptDscUv70gZYVF/8znJg7NGo7+KPul9T0gcGa0arCBtssi
4u9njug64dmMlndl4Qs=
=EwVo
-----END PGP SIGNATURE-----

--SkvwRMAIpAhPCcCJ--

--===============6447870400483754651==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6447870400483754651==--
