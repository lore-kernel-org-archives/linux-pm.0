From: James Courtier-Dutton <James@superbug.co.uk>
Subject: suspend-to-ram fails resume.
Date: Sun, 12 Feb 2006 00:33:15 +0000
Message-ID: <43EE824B.20609@superbug.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090903070007060504020301"
Return-path: <linux-pm-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

This is a multi-part message in MIME format.
--------------090903070007060504020301
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

"hibernate" and restore to/from disk works fine.
I have been trying to resume after running a "hibernate-ram" script.
Just using a text console, no X.

I attach a log with comments in it.
I have a Nvidia FX5200 video card.

After resume the display is blank. ping works from a remote machine, but
ssh does not work.

What can I do to help diagnose this problem?

James

--------------090903070007060504020301
Content-Type: text/plain;
 name="suspend-ram.txt"
Content-Disposition: inline;
 filename="suspend-ram.txt"
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by smtp.osdl.org id k1C0XODZ027553

  Running  "hibernate-ram"
Feb 11 23:05:38 localhost kernel: ehci_hcd 0000:00:1d.7: remove, state 1
Feb 11 23:05:38 localhost kernel: usb usb1: USB disconnect, address 1
Feb 11 23:05:38 localhost kernel: usb 1-3: USB disconnect, address 2
Feb 11 23:05:38 localhost kernel: usb 1-3.4: USB disconnect, address 3
Feb 11 23:05:38 localhost kernel: ehci_hcd 0000:00:1d.7: USB bus 1 deregi=
stered
Feb 11 23:05:38 localhost kernel: ACPI: PCI interrupt for device 0000:00:=
1d.7 disabled
Feb 11 23:05:39 localhost kernel: Freezing cpus ...
Feb 11 23:05:39 localhost kernel: CPU 1 is now offline
Feb 11 23:05:39 localhost kernel: CPU1 is down
  System powered down.

  Resumming after runing "hibernate-ram"
Feb 11 23:06:39 localhost kernel: ACPI: PCI interrupt for device 0000:02:=
01.0 disabled
Feb 11 23:06:39 localhost kernel: ACPI: PCI interrupt for device 0000:00:=
1f.2 disabled
Feb 11 23:06:39 localhost kernel: Intel machine check architecture suppor=
ted.
Feb 11 23:06:39 localhost kernel: Intel machine check reporting enabled o=
n CPU#0.
Feb 11 23:06:39 localhost kernel: CPU0: Intel P4/Xeon Extended MCE MSRs (=
12) available
Feb 11 23:06:39 localhost kernel: CPU0: Thermal monitoring enabled
Feb 11 23:06:39 localhost kernel: Back to C!
Feb 11 23:06:39 localhost kernel: PCI: Setting latency timer of device 00=
00:00:1e.0 to 64
Feb 11 23:06:39 localhost kernel: ACPI: PCI Interrupt 0000:00:1f.2[A] -> =
GSI 18 (level, low) -> IRQ 169
Feb 11 23:06:39 localhost kernel: PCI: Setting latency timer of device 00=
00:00:1f.2 to 64
Feb 11 23:06:39 localhost kernel: ACPI: PCI Interrupt 0000:02:01.0[A] -> =
GSI 18 (level, low) -> IRQ 169
Feb 11 23:06:39 localhost kernel: PCI: Setting latency timer of device 00=
00:02:01.0 to 64
Feb 11 23:06:39 localhost kernel: ACPI: PCI Interrupt 0000:03:02.0[A] -> =
GSI 18 (level, low) -> IRQ 169
Feb 11 23:06:39 localhost kernel: ACPI: PCI Interrupt 0000:03:03.0[A] -> =
GSI 19 (level, low) -> IRQ 177
Feb 11 23:06:39 localhost kernel: ata1: dev 0 configured for UDMA/33
Feb 11 23:06:39 localhost kernel: ata1: dev 1 configured for UDMA/33
Feb 11 23:06:39 localhost kernel: ATA: abnormal status 0x80 on port 0x177
Feb 11 23:06:39 localhost last message repeated 2 times
Feb 11 23:06:39 localhost kernel: e1000: eth0: e1000_watchdog_task: NIC L=
ink is Up 100 Mbps Full Duplex
Feb 11 23:06:39 localhost kernel: ata2: slow completion (cmd ef)
Feb 11 23:06:39 localhost kernel: ata2: dev 0 configured for UDMA/133
Feb 11 23:06:39 localhost kernel: ata2: dev 1 configured for UDMA/133
Feb 11 23:06:39 localhost kernel: Thawing cpus ...
Feb 11 23:06:39 localhost kernel: Booting processor 1/1 eip 3000
Feb 11 23:06:39 localhost kernel: Initializing CPU#1
Feb 11 23:06:39 localhost kernel: Calibrating delay using timer specific =
routine.. 5613.12 BogoMIPS (lpj=3D11226242)
Feb 11 23:06:39 localhost kernel: CPU: After generic identify, caps: bfeb=
fbff 00000000 00000000 00000000 00004400 00000000 00000000
Feb 11 23:06:39 localhost kernel: CPU: After vendor identify, caps: bfebf=
bff 00000000 00000000 00000000 00004400 00000000 00000000
Feb 11 23:06:39 localhost kernel: CPU: Trace cache: 12K uops, L1 D cache:=
 8K
Feb 11 23:06:39 localhost kernel: CPU: L2 cache: 512K
Feb 11 23:06:39 localhost kernel: CPU: Physical Processor ID: 0
Feb 11 23:06:39 localhost kernel: CPU: After all inits, caps: bfebfbff 00=
000000 00000000 00000080 00004400 00000000 00000000
Feb 11 23:06:39 localhost kernel: Intel machine check architecture suppor=
ted.
Feb 11 23:06:39 localhost kernel: Intel machine check reporting enabled o=
n CPU#1.
Feb 11 23:06:39 localhost kernel: CPU1: Intel P4/Xeon Extended MCE MSRs (=
12) available
Feb 11 23:06:39 localhost kernel: CPU1: Thermal monitoring enabled
Feb 11 23:06:39 localhost kernel: CPU1: Intel(R) Pentium(R) 4 CPU 2.80GHz=
 stepping 09
Feb 11 23:06:39 localhost kernel: APIC error on CPU1: 00(40)
Feb 11 23:06:39 localhost kernel: CPU1 is up

  Something bad happens here. pings work up to this point.
Feb 11 23:06:45 localhost kernel: Kernel logging (proc) stopped.
Feb 11 23:06:45 localhost kernel: Kernel log daemon terminating.
  System switches itself off.

Manual power on, boots normally via BIOS etc.
Feb 11 23:07:51 localhost kernel: klogd 1.4.1, log source =3D /proc/kmsg =
started.
Feb 11 23:07:51 localhost kernel: Cannot find map file.
Feb 11 23:07:51 localhost kernel: Error querying loaded modules - Functio=
n not implemented=20
Feb 11 23:07:51 localhost kernel: Linux version 2.6.15-suspend2-r6 (root@=
localhost) (gcc version 3.4.5 (Gentoo 3.4.5, ssp-3.4.5-1.0, pie-8.7.9)) #=
3 SMP PREEMPT Sat Feb 11 20:08:38 GMT 2006
Feb 11 23:07:51 localhost kernel: BIOS-provided physical RAM map:
Feb 11 23:07:51 localhost kernel:  BIOS-e820: 0000000000000000 - 00000000=
0009f400 (usable)
Feb 11 23:07:51 localhost kernel:  BIOS-e820: 000000000009f400 - 00000000=
000a0000 (reserved)
Feb 11 23:07:51 localhost kernel:  BIOS-e820: 00000000000f0000 - 00000000=
00100000 (reserved)
Feb 11 23:07:51 localhost kernel:  BIOS-e820: 0000000000100000 - 00000000=
3fff0000 (usable)
Feb 11 23:07:51 localhost kernel:  BIOS-e820: 000000003fff0000 - 00000000=
3fff3000 (ACPI NVS)
Feb 11 23:07:51 localhost kernel:  BIOS-e820: 000000003fff3000 - 00000000=
40000000 (ACPI data)
Feb 11 23:07:51 localhost kernel:  BIOS-e820: 00000000fec00000 - 00000001=
00000000 (reserved)
Feb 11 23:07:51 localhost kernel: Warning only 896MB will be used.
Feb 11 23:07:51 localhost kernel: Use a HIGHMEM enabled kernel.
Feb 11 23:07:51 localhost kernel: 896MB LOWMEM available.
Feb 11 23:07:51 localhost kernel: found SMP MP-table at 000f5d50
Feb 11 23:07:51 localhost kernel: On node 0 totalpages: 229376
Feb 11 23:07:51 localhost kernel:   DMA zone: 4096 pages, LIFO batch:0
Feb 11 23:07:51 localhost kernel:   DMA32 zone: 0 pages, LIFO batch:0
Feb 11 23:07:51 localhost kernel:   Normal zone: 225280 pages, LIFO batch=
:31
Feb 11 23:07:51 localhost kernel:   HighMem zone: 0 pages, LIFO batch:0
Feb 11 23:07:51 localhost kernel: DMI 2.2 present.
Feb 11 23:07:51 localhost kernel: ACPI: RSDP (v000 IntelR                =
                ) @ 0x000f77e0
Feb 11 23:07:51 localhost kernel: ACPI: RSDT (v001 IntelR AWRDACPI 0x4230=
2e31 AWRD 0x00000000) @ 0x3fff3000
Feb 11 23:07:51 localhost kernel: ACPI: FADT (v001 IntelR AWRDACPI 0x4230=
2e31 AWRD 0x00000000) @ 0x3fff3040
Feb 11 23:07:51 localhost kernel: ACPI: MADT (v001 IntelR AWRDACPI 0x4230=
2e31 AWRD 0x00000000) @ 0x3fff7a40
Feb 11 23:07:51 localhost kernel: ACPI: DSDT (v001 INTELR AWRDACPI 0x0000=
1000 MSFT 0x0100000e) @ 0x00000000
Feb 11 23:07:51 localhost kernel: ACPI: PM-Timer IO Port: 0x408
Feb 11 23:07:51 localhost kernel: ACPI: Local APIC address 0xfee00000
Feb 11 23:07:51 localhost kernel: ACPI: LAPIC (acpi_id[0x00] lapic_id[0x0=
0] enabled)
Feb 11 23:07:51 localhost kernel: Processor #0 15:2 APIC version 20
Feb 11 23:07:51 localhost kernel: ACPI: LAPIC (acpi_id[0x01] lapic_id[0x0=
1] enabled)
Feb 11 23:07:51 localhost kernel: Processor #1 15:2 APIC version 20
Feb 11 23:07:51 localhost kernel: ACPI: LAPIC_NMI (acpi_id[0x00] high edg=
e lint[0x1])
Feb 11 23:07:51 localhost kernel: ACPI: LAPIC_NMI (acpi_id[0x01] high edg=
e lint[0x1])
Feb 11 23:07:51 localhost kernel: ACPI: IOAPIC (id[0x02] address[0xfec000=
00] gsi_base[0])
Feb 11 23:07:51 localhost kernel: IOAPIC[0]: apic_id 2, version 32, addre=
ss 0xfec00000, GSI 0-23
Feb 11 23:07:51 localhost kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 glob=
al_irq 2 dfl dfl)
Feb 11 23:07:51 localhost kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 glob=
al_irq 9 high level)
Feb 11 23:07:51 localhost kernel: ACPI: IRQ0 used by override.
Feb 11 23:07:51 localhost kernel: ACPI: IRQ2 used by override.
Feb 11 23:07:51 localhost kernel: ACPI: IRQ9 used by override.
Feb 11 23:07:51 localhost kernel: Enabling APIC mode:  Flat.  Using 1 I/O=
 APICs
Feb 11 23:07:51 localhost kernel: Using ACPI (MADT) for SMP configuration=
 information
Feb 11 23:07:51 localhost kernel: Allocating PCI resources starting at 50=
000000 (gap: 40000000:bec00000)
Feb 11 23:07:51 localhost kernel: Built 1 zonelists
Feb 11 23:07:51 localhost kernel: Kernel command line: root=3D/dev/sda5 l=
ibata.atapi_enabled=3D1 resume2=3Dfile:/dev/sda5:0x34010
Feb 11 23:07:51 localhost kernel: mapped APIC to ffffd000 (fee00000)
Feb 11 23:07:51 localhost kernel: mapped IOAPIC to ffffc000 (fec00000)
Feb 11 23:07:51 localhost kernel: Initializing CPU#0
Feb 11 23:07:51 localhost kernel: PID hash table entries: 4096 (order: 12=
, 65536 bytes)
Feb 11 23:07:51 localhost kernel: Detected 2806.887 MHz processor.
Feb 11 23:07:51 localhost kernel: Using pmtmr for high-res timesource
Feb 11 23:07:51 localhost kernel: Console: colour VGA+ 80x25
Feb 11 23:07:51 localhost kernel: Dentry cache hash table entries: 131072=
 (order: 7, 524288 bytes)
Feb 11 23:07:51 localhost kernel: Inode-cache hash table entries: 65536 (=
order: 6, 262144 bytes)
Feb 11 23:07:51 localhost kernel: Memory: 904036k/917504k available (2401=
k kernel code, 13044k reserved, 935k data, 192k init, 0k highmem)
Feb 11 23:07:51 localhost kernel: Checking if this processor honours the =
WP bit even in supervisor mode... Ok.
Feb 11 23:07:51 localhost kernel: Calibrating delay using timer specific =
routine.. 5618.39 BogoMIPS (lpj=3D11236784)
Feb 11 23:07:51 localhost kernel: Mount-cache hash table entries: 512
Feb 11 23:07:51 localhost kernel: CPU: After generic identify, caps: bfeb=
fbff 00000000 00000000 00000000 00004400 00000000 00000000
Feb 11 23:07:51 localhost kernel: CPU: After vendor identify, caps: bfebf=
bff 00000000 00000000 00000000 00004400 00000000 00000000
Feb 11 23:07:51 localhost kernel: CPU: Trace cache: 12K uops, L1 D cache:=
 8K
Feb 11 23:07:51 localhost kernel: CPU: L2 cache: 512K
Feb 11 23:07:51 localhost kernel: CPU: Physical Processor ID: 0
Feb 11 23:07:51 localhost kernel: CPU: After all inits, caps: bfebfbff 00=
000000 00000000 00000080 00004400 00000000 00000000
Feb 11 23:07:51 localhost kernel: Intel machine check architecture suppor=
ted.
Feb 11 23:07:51 localhost kernel: Intel machine check reporting enabled o=
n CPU#0.
Feb 11 23:07:51 localhost kernel: CPU0: Intel P4/Xeon Extended MCE MSRs (=
12) available
Feb 11 23:07:51 localhost kernel: CPU0: Thermal monitoring enabled
Feb 11 23:07:51 localhost kernel: mtrr: v2.0 (20020519)
Feb 11 23:07:51 localhost kernel: Enabling fast FPU save and restore... d=
one.
Feb 11 23:07:51 localhost kernel: Enabling unmasked SIMD FPU exception su=
pport... done.
Feb 11 23:07:51 localhost kernel: Checking 'hlt' instruction... OK.
Feb 11 23:07:51 localhost kernel: CPU0: Intel(R) Pentium(R) 4 CPU 2.80GHz=
 stepping 09
Feb 11 23:07:51 localhost kernel: Booting processor 1/1 eip 3000
Feb 11 23:07:51 localhost kernel: Initializing CPU#1
Feb 11 23:07:51 localhost kernel: Calibrating delay using timer specific =
routine.. 5613.16 BogoMIPS (lpj=3D11226328)
Feb 11 23:07:51 localhost kernel: CPU: After generic identify, caps: bfeb=
fbff 00000000 00000000 00000000 00004400 00000000 00000000
Feb 11 23:07:51 localhost kernel: CPU: After vendor identify, caps: bfebf=
bff 00000000 00000000 00000000 00004400 00000000 00000000
Feb 11 23:07:51 localhost kernel: CPU: Trace cache: 12K uops, L1 D cache:=
 8K
Feb 11 23:07:51 localhost kernel: CPU: L2 cache: 512K
Feb 11 23:07:51 localhost kernel: CPU: Physical Processor ID: 0
Feb 11 23:07:51 localhost kernel: CPU: After all inits, caps: bfebfbff 00=
000000 00000000 00000080 00004400 00000000 00000000
Feb 11 23:07:51 localhost kernel: Intel machine check architecture suppor=
ted.
Feb 11 23:07:51 localhost kernel: Intel machine check reporting enabled o=
n CPU#1.
Feb 11 23:07:51 localhost kernel: CPU1: Intel P4/Xeon Extended MCE MSRs (=
12) available
Feb 11 23:07:51 localhost kernel: CPU1: Thermal monitoring enabled
Feb 11 23:07:51 localhost kernel: CPU1: Intel(R) Pentium(R) 4 CPU 2.80GHz=
 stepping 09
Feb 11 23:07:51 localhost kernel: Total of 2 processors activated (11231.=
55 BogoMIPS).
Feb 11 23:07:51 localhost kernel: ENABLING IO-APIC IRQs
Feb 11 23:07:51 localhost kernel: ..TIMER: vector=3D0x31 apic1=3D0 pin1=3D=
2 apic2=3D-1 pin2=3D-1
Feb 11 23:07:51 localhost kernel: checking TSC synchronization across 2 C=
PUs: passed.
Feb 11 23:07:51 localhost kernel: Brought up 2 CPUs
Feb 11 23:07:51 localhost kernel: NET: Registered protocol family 16
Feb 11 23:07:51 localhost kernel: ACPI: bus type pci registered
Feb 11 23:07:51 localhost kernel: PCI: PCI BIOS revision 2.10 entry at 0x=
fba10, last bus=3D3
Feb 11 23:07:51 localhost kernel: PCI: Using configuration type 1
Feb 11 23:07:51 localhost kernel: ACPI: Subsystem revision 20050902
Feb 11 23:07:51 localhost kernel: ACPI: Interpreter enabled
Feb 11 23:07:51 localhost kernel: ACPI: Using IOAPIC for interrupt routin=
g
Feb 11 23:07:51 localhost kernel: ACPI: PCI Root Bridge [PCI0] (0000:00)
Feb 11 23:07:51 localhost kernel: PCI: Probing PCI hardware (bus 00)
Feb 11 23:07:51 localhost kernel: PCI quirk: region 0400-047f claimed by =
ICH4 ACPI/GPIO/TCO
Feb 11 23:07:51 localhost kernel: PCI quirk: region 0480-04bf claimed by =
ICH4 GPIO
Feb 11 23:07:51 localhost kernel: PCI: Ignoring BAR0-3 of IDE controller =
0000:00:1f.2
Feb 11 23:07:51 localhost kernel: Boot video device is 0000:01:00.0
Feb 11 23:07:51 localhost kernel: PCI: Transparent bridge - 0000:00:1e.0
Feb 11 23:07:51 localhost kernel: ACPI: PCI Interrupt Routing Table [\_SB=
_.PCI0._PRT]
Feb 11 23:07:51 localhost kernel: ACPI: PCI Interrupt Routing Table [\_SB=
_.PCI0.HUB0._PRT]
Feb 11 23:07:51 localhost kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3=
 4 5 7 9 10 11 *12 14 15)
Feb 11 23:07:51 localhost kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3=
 4 *5 7 9 10 11 12 14 15)
Feb 11 23:07:51 localhost kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3=
 4 5 7 9 10 *11 12 14 15)
Feb 11 23:07:51 localhost kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 3=
 4 5 7 9 *10 11 12 14 15)
Feb 11 23:07:51 localhost kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 3=
 4 5 7 9 10 11 12 14 15) *0, disabled.
Feb 11 23:07:51 localhost kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 3=
 4 5 7 9 10 11 12 14 15) *0, disabled.
Feb 11 23:07:51 localhost kernel: ACPI: PCI Interrupt Link [LNK0] (IRQs 3=
 4 5 7 9 10 11 12 14 15) *0, disabled.
Feb 11 23:07:51 localhost kernel: ACPI: PCI Interrupt Link [LNK1] (IRQs *=
3 4 5 7 9 10 11 12 14 15)
Feb 11 23:07:51 localhost kernel: ACPI: Power Resource [PFAN] (off)
Feb 11 23:07:51 localhost kernel: Linux Plug and Play Support v0.97 (c) A=
dam Belay
Feb 11 23:07:51 localhost kernel: pnp: PnP ACPI init
Feb 11 23:07:51 localhost kernel: pnp: PnP ACPI: found 12 devices
Feb 11 23:07:51 localhost kernel: SCSI subsystem initialized
Feb 11 23:07:51 localhost kernel: PCI: Using ACPI for IRQ routing
Feb 11 23:07:51 localhost kernel: PCI: If a device doesn't work, try "pci=
=3Drouteirq".  If it helps, post a report
Feb 11 23:07:51 localhost kernel: pnp: 00:09: ioport range 0x400-0x4bf co=
uld not be reserved
Feb 11 23:07:51 localhost kernel: PCI: Bridge: 0000:00:01.0
Feb 11 23:07:51 localhost kernel:   IO window: disabled.
Feb 11 23:07:51 localhost kernel:   MEM window: f8000000-f9ffffff
Feb 11 23:07:51 localhost kernel:   PREFETCH window: f0000000-f7ffffff
Feb 11 23:07:51 localhost kernel: PCI: Bridge: 0000:00:03.0
Feb 11 23:07:51 localhost kernel:   IO window: a000-afff
Feb 11 23:07:51 localhost kernel:   MEM window: fc000000-fc0fffff
Feb 11 23:07:51 localhost kernel:   PREFETCH window: disabled.
Feb 11 23:07:51 localhost kernel: PCI: Bridge: 0000:00:1e.0
Feb 11 23:07:51 localhost kernel:   IO window: 8000-9fff
Feb 11 23:07:51 localhost kernel:   MEM window: fa000000-fbffffff
Feb 11 23:07:51 localhost kernel:   PREFETCH window: 50000000-500fffff
Feb 11 23:07:51 localhost kernel: PCI: Setting latency timer of device 00=
00:00:1e.0 to 64
Feb 11 23:07:51 localhost kernel: Machine check exception polling timer s=
tarted.
Feb 11 23:07:51 localhost kernel: audit: initializing netlink socket (dis=
abled)
Feb 11 23:07:51 localhost kernel: audit(1139699250.072:1): initialized
Feb 11 23:07:51 localhost kernel: Installing knfsd (copyright (C) 1996 ok=
ir@monad.swb.de).
Feb 11 23:07:51 localhost kernel: Initializing Cryptographic API
Feb 11 23:07:51 localhost kernel: io scheduler noop registered
Feb 11 23:07:51 localhost kernel: io scheduler anticipatory registered
Feb 11 23:07:51 localhost kernel: io scheduler deadline registered
Feb 11 23:07:51 localhost kernel: io scheduler cfq registered
Feb 11 23:07:51 localhost kernel: lp: driver loaded but no devices found
Feb 11 23:07:51 localhost kernel: Real Time Clock Driver v1.12
Feb 11 23:07:51 localhost kernel: toshiba: not a supported Toshiba laptop
Feb 11 23:07:51 localhost kernel: Linux agpgart interface v0.101 (c) Dave=
 Jones
Feb 11 23:07:51 localhost kernel: agpgart: Detected an Intel i875 Chipset.
Feb 11 23:07:51 localhost kernel: agpgart: AGP aperture is 128M @ 0xe8000=
000
Feb 11 23:07:51 localhost kernel: [drm] Initialized drm 1.0.0 20040925
Feb 11 23:07:51 localhost kernel: ACPI: Power Button (FF) [PWRF]
Feb 11 23:07:51 localhost kernel: ACPI: Power Button (CM) [PWRB]
Feb 11 23:07:51 localhost kernel: ACPI: Fan [FAN] (off)
Feb 11 23:07:51 localhost kernel: ACPI: Thermal Zone [THRM] (51 C)
Feb 11 23:07:51 localhost kernel: ibm_acpi: ec object not found
Feb 11 23:07:51 localhost kernel: PNP: PS/2 Controller [PNP0303:PS2K] at =
0x60,0x64 irq 1
Feb 11 23:07:51 localhost kernel: PNP: PS/2 controller doesn't have AUX i=
rq; using default 12
Feb 11 23:07:51 localhost kernel: serio: i8042 AUX port at 0x60,0x64 irq =
12
Feb 11 23:07:51 localhost kernel: serio: i8042 KBD port at 0x60,0x64 irq =
1
Feb 11 23:07:51 localhost kernel: Serial: 8250/16550 driver $Revision: 1.=
90 $ 4 ports, IRQ sharing disabled
Feb 11 23:07:51 localhost kernel: serial8250: ttyS0 at I/O 0x3f8 (irq =3D=
 4) is a 16550A
Feb 11 23:07:51 localhost kernel: 00:06: ttyS0 at I/O 0x3f8 (irq =3D 4) i=
s a 16550A
Feb 11 23:07:51 localhost kernel: parport: PnPBIOS parport detected.
Feb 11 23:07:51 localhost kernel: parport0: PC-style at 0x378, irq 7 [PCS=
PP(,...)]
Feb 11 23:07:51 localhost kernel: lp0: using parport0 (interrupt-driven).
Feb 11 23:07:51 localhost kernel: mice: PS/2 mouse device common for all =
mice
Feb 11 23:07:51 localhost kernel: Floppy drive(s): fd0 is 1.44M
Feb 11 23:07:51 localhost kernel: FDC 0 is a post-1991 82077
Feb 11 23:07:51 localhost kernel: e100: Intel(R) PRO/100 Network Driver, =
3.4.14-k4-NAPI
Feb 11 23:07:51 localhost kernel: e100: Copyright(c) 1999-2005 Intel Corp=
oration
Feb 11 23:07:51 localhost kernel: libata version 1.20 loaded.
Feb 11 23:07:51 localhost kernel: ata_piix 0000:00:1f.2: version 1.05
Feb 11 23:07:51 localhost kernel: ata_piix 0000:00:1f.2: combined mode de=
tected (p=3D0, s=3D1)
Feb 11 23:07:51 localhost kernel: ACPI: PCI Interrupt 0000:00:1f.2[A] -> =
GSI 18 (level, low) -> IRQ 169
Feb 11 23:07:51 localhost kernel: PCI: Setting latency timer of device 00=
00:00:1f.2 to 64
Feb 11 23:07:51 localhost kernel: ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0=
x3F6 bmdma 0xF000 irq 14
Feb 11 23:07:51 localhost kernel: input: AT Translated Set 2 keyboard as =
/class/input/input0
Feb 11 23:07:51 localhost kernel: ata1: dev 0 cfg 49:0f00 82:0000 83:0000=
 84:0000 85:0000 86:0000 87:0000 88:0407
Feb 11 23:07:51 localhost kernel: ata1: dev 0 ATAPI, max UDMA/33
Feb 11 23:07:51 localhost kernel: ata1: dev 1 cfg 49:0b00 82:0000 83:0000=
 84:0000 85:0000 86:0000 87:0000 88:0407
Feb 11 23:07:51 localhost kernel: ata1: dev 1 ATAPI, max UDMA/33
Feb 11 23:07:51 localhost kernel: ata1: dev 0 configured for UDMA/33
Feb 11 23:07:51 localhost kernel: ata1: dev 1 configured for UDMA/33
Feb 11 23:07:51 localhost kernel: scsi0 : ata_piix
Feb 11 23:07:51 localhost kernel:   Vendor: OPTORITE  Model: DVD RW DD020=
3     Rev: 2.50
Feb 11 23:07:51 localhost kernel:   Type:   CD-ROM                       =
      ANSI SCSI revision: 05
Feb 11 23:07:51 localhost kernel:   Vendor: ATAPI     Model: DVD-ROM 16XM=
ax    Rev: 1.50
Feb 11 23:07:51 localhost kernel:   Type:   CD-ROM                       =
      ANSI SCSI revision: 05
Feb 11 23:07:51 localhost kernel: ata2: SATA max UDMA/133 cmd 0x170 ctl 0=
x376 bmdma 0xF008 irq 15
Feb 11 23:07:51 localhost kernel: ata2: dev 0 cfg 49:2f00 82:346b 83:7d01=
 84:4023 85:3469 86:3c01 87:4023 88:207f
Feb 11 23:07:51 localhost kernel: ata2: dev 0 ATA-7, max UDMA/133, 586072=
368 sectors: LBA48
Feb 11 23:07:51 localhost kernel: ata2: dev 1 cfg 49:2f00 82:346b 83:7d01=
 84:4003 85:3469 86:3c01 87:4003 88:207f
Feb 11 23:07:51 localhost kernel: ata2: dev 1 ATA-6, max UDMA/133, 312581=
808 sectors: LBA48
Feb 11 23:07:51 localhost kernel: ata2: dev 0 configured for UDMA/133
Feb 11 23:07:51 localhost kernel: ata2: dev 1 configured for UDMA/133
Feb 11 23:07:51 localhost kernel: scsi1 : ata_piix
Feb 11 23:07:51 localhost kernel:   Vendor: ATA       Model: ST3300831AS =
      Rev: 3.01
Feb 11 23:07:51 localhost kernel:   Type:   Direct-Access                =
      ANSI SCSI revision: 05
Feb 11 23:07:51 localhost kernel:   Vendor: ATA       Model: ST3160023AS =
      Rev: 3.18
Feb 11 23:07:51 localhost kernel:   Type:   Direct-Access                =
      ANSI SCSI revision: 05
Feb 11 23:07:51 localhost kernel: sata_sil 0000:03:03.0: version 0.9
Feb 11 23:07:51 localhost kernel: ACPI: PCI Interrupt 0000:03:03.0[A] -> =
GSI 19 (level, low) -> IRQ 177
Feb 11 23:07:51 localhost kernel: ata3: SATA max UDMA/100 cmd 0xF880E080 =
ctl 0xF880E08A bmdma 0xF880E000 irq 177
Feb 11 23:07:51 localhost kernel: ata4: SATA max UDMA/100 cmd 0xF880E0C0 =
ctl 0xF880E0CA bmdma 0xF880E008 irq 177
Feb 11 23:07:51 localhost kernel: ata3: dev 0 cfg 49:2f00 82:346b 83:7d01=
 84:4003 85:3469 86:3c01 87:4003 88:207f
Feb 11 23:07:51 localhost kernel: ata3: dev 0 ATA-6, max UDMA/133, 312581=
808 sectors: LBA48
Feb 11 23:07:51 localhost kernel: ata3(0): applying Seagate errata fix
Feb 11 23:07:51 localhost kernel: ata3: dev 0 configured for UDMA/100
Feb 11 23:07:51 localhost kernel: scsi2 : sata_sil
Feb 11 23:07:51 localhost kernel: ata4: no device found (phy stat 0000000=
0)
Feb 11 23:07:51 localhost kernel: scsi3 : sata_sil
Feb 11 23:07:51 localhost kernel:   Vendor: ATA       Model: ST3160023AS =
      Rev: 3.18
Feb 11 23:07:51 localhost kernel:   Type:   Direct-Access                =
      ANSI SCSI revision: 05
Feb 11 23:07:51 localhost kernel: SCSI device sda: 586072368 512-byte hdw=
r sectors (300069 MB)
Feb 11 23:07:51 localhost kernel: SCSI device sda: drive cache: write bac=
k
Feb 11 23:07:51 localhost kernel: SCSI device sda: 586072368 512-byte hdw=
r sectors (300069 MB)
Feb 11 23:07:51 localhost kernel: SCSI device sda: drive cache: write bac=
k
Feb 11 23:07:51 localhost kernel:  sda: sda1 sda2 < sda5 sda6 sda7 >
Feb 11 23:07:51 localhost kernel: sd 1:0:0:0: Attached scsi disk sda
Feb 11 23:07:51 localhost kernel: SCSI device sdb: 312581808 512-byte hdw=
r sectors (160042 MB)
Feb 11 23:07:51 localhost kernel: SCSI device sdb: drive cache: write bac=
k
Feb 11 23:07:51 localhost kernel: SCSI device sdb: 312581808 512-byte hdw=
r sectors (160042 MB)
Feb 11 23:07:51 localhost kernel: SCSI device sdb: drive cache: write bac=
k
Feb 11 23:07:51 localhost kernel:  sdb: sdb1 sdb2 < sdb5 sdb6 >
Feb 11 23:07:51 localhost kernel: sd 1:0:1:0: Attached scsi disk sdb
Feb 11 23:07:51 localhost kernel: SCSI device sdc: 312581808 512-byte hdw=
r sectors (160042 MB)
Feb 11 23:07:51 localhost kernel: SCSI device sdc: drive cache: write bac=
k
Feb 11 23:07:51 localhost kernel: SCSI device sdc: 312581808 512-byte hdw=
r sectors (160042 MB)
Feb 11 23:07:51 localhost kernel: SCSI device sdc: drive cache: write bac=
k
Feb 11 23:07:51 localhost kernel:  sdc: sdc1 sdc2 < sdc5 >
Feb 11 23:07:51 localhost kernel: sd 2:0:0:0: Attached scsi disk sdc
Feb 11 23:07:51 localhost kernel: sr0: scsi3-mmc drive: 40x/40x writer cd=
/rw xa/form2 cdda tray
Feb 11 23:07:51 localhost kernel: Uniform CD-ROM driver Revision: 3.20
Feb 11 23:07:51 localhost kernel: sr 0:0:0:0: Attached scsi CD-ROM sr0
Feb 11 23:07:51 localhost kernel: sr1: scsi3-mmc drive: 24x/40x cd/rw xa/=
form2 cdda tray
Feb 11 23:07:51 localhost kernel: sr 0:0:1:0: Attached scsi CD-ROM sr1
Feb 11 23:07:51 localhost kernel: sr 0:0:0:0: Attached scsi generic sg0 t=
ype 5
Feb 11 23:07:51 localhost kernel: sr 0:0:1:0: Attached scsi generic sg1 t=
ype 5
Feb 11 23:07:51 localhost kernel: sd 1:0:0:0: Attached scsi generic sg2 t=
ype 0
Feb 11 23:07:51 localhost kernel: sd 1:0:1:0: Attached scsi generic sg3 t=
ype 0
Feb 11 23:07:51 localhost kernel: sd 2:0:0:0: Attached scsi generic sg4 t=
ype 0
Feb 11 23:07:51 localhost kernel: oprofile: using NMI interrupt.
Feb 11 23:07:51 localhost kernel: NET: Registered protocol family 2
Feb 11 23:07:51 localhost kernel: IP route cache hash table entries: 3276=
8 (order: 5, 131072 bytes)
Feb 11 23:07:51 localhost kernel: TCP established hash table entries: 131=
072 (order: 8, 1572864 bytes)
Feb 11 23:07:51 localhost kernel: TCP bind hash table entries: 65536 (ord=
er: 7, 786432 bytes)
Feb 11 23:07:51 localhost kernel: TCP: Hash tables configured (establishe=
d 131072 bind 65536)
Feb 11 23:07:51 localhost kernel: TCP reno registered
Feb 11 23:07:51 localhost kernel: ip_conntrack version 2.4 (7168 buckets,=
 57344 max) - 212 bytes per conntrack
Feb 11 23:07:51 localhost kernel: ip_tables: (C) 2000-2002 Netfilter core=
 team
Feb 11 23:07:51 localhost kernel: ipt_recent v0.3.1: Stephen Frost <sfros=
t@snowman.net>.  http://snowman.net/projects/ipt_recent/
Feb 11 23:07:51 localhost kernel: arp_tables: (C) 2002 David S. Miller
Feb 11 23:07:51 localhost kernel: TCP bic registered
Feb 11 23:07:51 localhost kernel: NET: Registered protocol family 1
Feb 11 23:07:51 localhost kernel: NET: Registered protocol family 17
Feb 11 23:07:51 localhost kernel: Starting balanced_irq
Feb 11 23:07:51 localhost kernel: Using IPI No-Shortcut mode
Feb 11 23:07:51 localhost kernel: Suspend2 Core.
Feb 11 23:07:51 localhost kernel: Suspend2 Compression Driver loading.
Feb 11 23:07:51 localhost kernel: Suspend2 Encryption Driver loading.
Feb 11 23:07:51 localhost kernel: Suspend2 FileWriter loading.
Feb 11 23:07:51 localhost kernel: ACPI wakeup devices:=20
Feb 11 23:07:51 localhost kernel: PCI0 CSAD HUB0 UAR1 USB0 USB1 USB2 USB3=
 USBE MODM=20
Feb 11 23:07:51 localhost kernel: ACPI: (supports S0 S3 S4 S5)
Feb 11 23:07:51 localhost kernel: Suspend2 2.2: Filewriter: File signatur=
e found.
Feb 11 23:07:51 localhost kernel: Suspend2 2.2: Suspending enabled.
Feb 11 23:07:51 localhost kernel: kjournald starting.  Commit interval 5 =
seconds
Feb 11 23:07:51 localhost kernel: EXT3-fs: mounted filesystem with ordere=
d data mode.
Feb 11 23:07:51 localhost kernel: VFS: Mounted root (ext3 filesystem) rea=
donly.
Feb 11 23:07:51 localhost kernel: Freeing unused kernel memory: 192k free=
d
Feb 11 23:07:51 localhost kernel: Adding 2000052k swap on /dev/sda6.  Pri=
ority:-1 extents:1 across:2000052k
Feb 11 23:07:51 localhost kernel: EXT3 FS on sda5, internal journal
Feb 11 23:07:51 localhost kernel: kjournald starting.  Commit interval 5 =
seconds
Feb 11 23:07:51 localhost kernel: EXT3 FS on sda7, internal journal
Feb 11 23:07:51 localhost kernel: EXT3-fs: mounted filesystem with ordere=
d data mode.
Feb 11 23:07:51 localhost kernel: usbcore: registered new driver usbfs
Feb 11 23:07:51 localhost kernel: usbcore: registered new driver hub
Feb 11 23:07:51 localhost kernel: ACPI: PCI Interrupt 0000:00:1d.7[D] -> =
GSI 23 (level, low) -> IRQ 185
Feb 11 23:07:51 localhost kernel: PCI: Setting latency timer of device 00=
00:00:1d.7 to 64
Feb 11 23:07:51 localhost kernel: ehci_hcd 0000:00:1d.7: EHCI Host Contro=
ller
Feb 11 23:07:51 localhost kernel: PCI: cache line size of 128 is not supp=
orted by device 0000:00:1d.7
Feb 11 23:07:51 localhost kernel: ehci_hcd 0000:00:1d.7: new USB bus regi=
stered, assigned bus number 1
Feb 11 23:07:51 localhost kernel: ehci_hcd 0000:00:1d.7: irq 185, io mem =
0xfc100000
Feb 11 23:07:51 localhost kernel: ehci_hcd 0000:00:1d.7: USB 2.0 started,=
 EHCI 1.00, driver 10 Dec 2004
Feb 11 23:07:51 localhost kernel: hub 1-0:1.0: USB hub found
Feb 11 23:07:51 localhost kernel: hub 1-0:1.0: 8 ports detected
Feb 11 23:07:51 localhost kernel: usb 1-3: new high speed USB device usin=
g ehci_hcd and address 2
Feb 11 23:07:51 localhost kernel: hub 1-3:1.0: USB hub found
Feb 11 23:07:51 localhost kernel: hub 1-3:1.0: 7 ports detected
Feb 11 23:07:51 localhost kernel: usb 1-3.4: new low speed USB device usi=
ng ehci_hcd and address 3
Feb 11 23:07:51 localhost kernel: input: Microsoft Microsoft IntelliMouse=
=AE Explorer as /class/input/input1
Feb 11 23:07:51 localhost kernel: input: USB HID v1.00 Mouse [Microsoft M=
icrosoft IntelliMouse=AE Explorer] on usb-0000:00:1d.7-3.4
Feb 11 23:07:51 localhost kernel: usbcore: registered new driver usbhid
Feb 11 23:07:51 localhost kernel: drivers/usb/input/hid-core.c: v2.6:USB =
HID core driver
Feb 11 23:07:51 localhost kernel: Uniform Multi-Platform E-IDE driver Rev=
ision: 7.00alpha2
Feb 11 23:07:51 localhost kernel: ide: Assuming 33MHz system bus speed fo=
r PIO modes; override with idebus=3Dxx
Feb 11 23:07:51 localhost kernel: ACPI: PCI Interrupt 0000:00:1f.5[B] -> =
GSI 17 (level, low) -> IRQ 193
Feb 11 23:07:51 localhost kernel: PCI: Setting latency timer of device 00=
00:00:1f.5 to 64
Feb 11 23:07:51 localhost kernel: intel8x0_measure_ac97_clock: measured 5=
6816 usecs
Feb 11 23:07:51 localhost kernel: intel8x0: clocking to 48000
Feb 11 23:07:51 localhost kernel: Intel(R) PRO/1000 Network Driver - vers=
ion 6.1.16-k2
Feb 11 23:07:51 localhost kernel: Copyright (c) 1999-2005 Intel Corporati=
on.
Feb 11 23:07:51 localhost kernel: ACPI: PCI Interrupt 0000:02:01.0[A] -> =
GSI 18 (level, low) -> IRQ 169
Feb 11 23:07:51 localhost kernel: PCI: Setting latency timer of device 00=
00:02:01.0 to 64
Feb 11 23:07:51 localhost kernel: e1000: eth0: e1000_probe: Intel(R) PRO/=
1000 Network Connection
Feb 11 23:07:51 localhost kernel: ieee1394: Initialized config rom entry =
`ip1394'
Feb 11 23:07:51 localhost kernel: ohci1394: $Rev: 1313 $ Ben Collins <bco=
llins@debian.org>
Feb 11 23:07:51 localhost kernel: ACPI: PCI Interrupt 0000:03:02.0[A] -> =
GSI 18 (level, low) -> IRQ 169
Feb 11 23:07:51 localhost kernel: ohci1394: fw-host0: OHCI-1394 1.1 (PCI)=
: IRQ=3D[169]  MMIO=3D[fb005000-fb0057ff]  Max Packet=3D[2048]
Feb 11 23:07:51 localhost kernel: ieee1394: Host added: ID:BUS[0-00:1023]=
  GUID[00508d0000fcf79e]
Feb 11 23:07:51 localhost kernel: e1000: eth0: e1000_watchdog_task: NIC L=
ink is Up 100 Mbps Full Duplex
Feb 11 23:07:51 localhost kernel: eth1394: $Rev: 1312 $ Ben Collins <bcol=
lins@debian.org>
Feb 11 23:07:51 localhost kernel: eth1394: eth1: IEEE-1394 IPv4 over 1394=
 Ethernet (fw-host0)

--------------090903070007060504020301
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


--------------090903070007060504020301--
