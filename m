From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Wed, 14 Jun 2006 11:29:30 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606141121040.5498@g5.osdl.org>
References: <Pine.LNX.4.64.0606131418580.5498@g5.osdl.org>
	<Pine.LNX.4.64.0606131435400.5498@g5.osdl.org>
	<20060614103404.GC28536@elf.ucw.cz>
	<Pine.LNX.4.64.0606140820420.5498@g5.osdl.org>
	<Pine.LNX.4.64.0606141042260.5498@g5.osdl.org>
	<20060614180959.GD13105@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060614180959.GD13105@redhat.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Dave Jones <davej@redhat.com>
Cc: Power management list <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org



On Wed, 14 Jun 2006, Dave Jones wrote:
> =

> I bet you're not using slab debug are you? :)

Actually, I am:

	..
	CONFIG_DEBUG_SLAB=3Dy  =

	CONFIG_DEBUG_SLAB_LEAK=3Dy =

	CONFIG_DEBUG_MUTEXES=3Dy
	CONFIG_DEBUG_SPINLOCK=3Dy
	CONFIG_DEBUG_SPINLOCK_SLEEP=3Dy
	..

> Peter is hitting this with his mini on resume...

I'm not sure why I'm not, but we probably have different configurations in =

other respects.

I have trouble on the _second_ suspend/resume event (the SATA controller =

is unhappy - the machine comes back, and everythign else works, but any
disk IO will result in IO errors). But the first one is fine apart from =

it disabling irq9):

	PM: Preparing system for mem sleep
	Freezing cpus ...
	Breaking affinity for irq 14
	Breaking affinity for irq 17
	CPU 1 is now offline
	SMP alternatives: switching to UP code
	migration_cost=3D4000
	CPU1 is down
	Stopping tasks: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D|
	hci_usb 5-1:1.1: no suspend for driver hci_usb?
	hci_usb 5-1:1.0: no suspend for driver hci_usb?
	sky2 eth0: disabling interface
	PM: Entering mem sleep
	Intel machine check architecture supported.
	Intel machine check reporting enabled on CPU#0.
	Back to C!
	PM: Finishing wakeup.

	ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 16
	PCI: Setting latency timer of device 0000:00:1c.0 to 64
	ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 16 (level, low) -> IRQ 17
	PCI: Setting latency timer of device 0000:00:1c.1 to 64
	PCI: Enabling device 0000:00:1d.0 (0000 -> 0001)
	ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 21 (level, low) -> IRQ 20
	PCI: Setting latency timer of device 0000:00:1d.0 to 64
	usb usb2: root hub lost power or was reset
	PCI: Enabling device 0000:00:1d.1 (0000 -> 0001)
	ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
	PCI: Setting latency timer of device 0000:00:1d.1 to 64
	usb usb3: root hub lost power or was reset
	PCI: Enabling device 0000:00:1d.2 (0000 -> 0001)
	ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
	PCI: Setting latency timer of device 0000:00:1d.2 to 64
	usb usb4: root hub lost power or was reset
	PCI: Enabling device 0000:00:1d.3 (0000 -> 0001)
	ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 16 (level, low) -> IRQ 17
	PCI: Setting latency timer of device 0000:00:1d.3 to 64
	usb usb5: root hub lost power or was reset
	PCI: Enabling device 0000:00:1d.7 (0000 -> 0002)
	ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 21 (level, low) -> IRQ 20
	PCI: Setting latency timer of device 0000:00:1d.7 to 64
	PCI: Setting latency timer of device 0000:00:1e.0 to 64
	ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
	ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 19
	PCI: Setting latency timer of device 0000:00:1f.2 to 64
	sky2 eth0: enabling interface
	PCI: Enabling device 0000:03:03.0 (0000 -> 0002)
	ACPI: PCI Interrupt 0000:03:03.0[A] -> GSI 19 (level, low) -> IRQ 19

	irq 9: nobody cared (try booting with the "irqpoll" option)
	 <c0103c86> show_trace+0xd/0xf  <c010426b> dump_stack+0x17/0x19
	 <c0141022> __report_bad_irq+0x2e/0x6f  <c01411e5> note_interrupt+0x182/0x=
1ad
	 <c0140bb0> __do_IRQ+0xae/0xe2  <c01051d5> do_IRQ+0x63/0x82
	 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	 <c0103642> common_interrupt+0x1a/0x20  <c01dacfc> __delay+0xc/0xe
	 <c01dad22> __const_udelay+0x24/0x26  <c027315d> ata_device_resume+0x20/0x=
59
	 <c0274ad8> ata_scsi_device_resume+0x1c/0x1e  <c026de3b> scsi_bus_resume+0=
x24/0x33
	 <c024083a> resume_device+0xa6/0xd1  <c0240940> dpm_resume+0x75/0xc0
	 <c02409b0> device_resume+0x25/0x30  <c013a300> enter_state+0x172/0x1c1
	 <c013a3d5> state_store+0x86/0x9c  <c0195aac> subsys_attr_store+0x20/0x25
	 <c0195d78> sysfs_write_file+0xab/0xd1  <c015ef38> vfs_write+0xab/0x154
	 <c015f56c> sys_write+0x3b/0x60  <c0102c0f> sysenter_past_esp+0x54/0x75
	handlers:
	[<c01f6d77>] (acpi_irq+0x0/0x18)
	Disabling IRQ #9

	sky2 eth0: Link is up at 100 Mbps, full duplex, flow control both
	ata1: dev 1 configured for UDMA/133
	Restarting tasks...<6>usb 4-1: USB disconnect, address 2
	usb 4-1.1: USB disconnect, address 3
	usb 4-1.3: USB disconnect, address 4
	 done
	Thawing cpus ...
	SMP alternatives: switching to SMP code
	Booting processor 1/1 eip 3000
	CPU 1 irqstacks, hard=3Dc0589000 soft=3Dc0581000
	Initializing CPU#1
	Calibrating delay using timer specific routine.. 3333.47 BogoMIPS (lpj=3D6=
666947)
	CPU: After generic identify, caps: bfe9fbff 00100000 00000000 00000000 000=
0c1a9 00000000 00000000
	CPU: After vendor identify, caps: bfe9fbff 00100000 00000000 00000000 0000=
c1a9 00000000 00000000
	monitor/mwait feature present.
	CPU: L1 I cache: 32K, L1 D cache: 32K
	CPU: L2 cache: 2048K
	CPU: Physical Processor ID: 0
	CPU: Processor Core ID: 1
	CPU: After all inits, caps: bfe9fbff 00100000 00000000 00000140 0000c1a9 0=
0000000 00000000
	Intel machine check architecture supported.
	Intel machine check reporting enabled on CPU#1.
	CPU1: Intel Genuine Intel(R) CPU           T2300  @ 1.66GHz stepping 08
	APIC error on CPU1: 00(40)
	migration_cost=3D4000
	CPU1 is up

	usb 4-1: new full speed USB device using uhci_hcd and address 5
	usb 4-1: configuration #1 chosen from 1 choice
	hub 4-1:1.0: USB hub found
	hub 4-1:1.0: 3 ports detected
	usb 5-1: USB disconnect, address 4
	usb 5-1: new full speed USB device using uhci_hcd and address 5
	usb 5-2: USB disconnect, address 3
	usb 5-2: new full speed USB device using uhci_hcd and address 6
	usb 5-2: configuration #1 chosen from 1 choice
	hiddev96: USB HID v1.11 Device [Apple Computer, Inc. IR Receiver] on =

	usb-0000:00:1d.3-2
	usb 4-1.1: new low speed USB device using uhci_hcd and address 6
	usb 4-1.1: configuration #1 chosen from 1 choice
	input: Mitsumi Electric Apple Optical USB Mouse as /class/input/input5
	input: USB HID v1.10 Mouse [Mitsumi Electric Apple Optical USB Mouse] on u=
sb-0000:00:1d.2-1.1
	usb 4-1.3: new full speed USB device using uhci_hcd and address 7
	usb 4-1.3: configuration #1 chosen from 1 choice
	input: Mitsumi Electric Apple Extended USB Keyboard as /class/input/input6
	input: USB HID v1.10 Keyboard [Mitsumi Electric Apple Extended USB Keyboar=
d] on usb-0000:00:1d.2-1.3
	input: Mitsumi Electric Apple Extended USB Keyboard as /class/input/input7
	input: USB HID v1.10 Device [Mitsumi Electric Apple Extended USB Keyboard]=
 on usb-0000:00:1d.2-1.3
	usb 5-1: new full speed USB device using uhci_hcd and address 7
	usb 5-1: configuration #1 chosen from 1 choice
	input: HID 05ac:1000 as /class/input/input8
	input: USB HID v1.11 Keyboard [HID 05ac:1000] on usb-0000:00:1d.3-1
	input: HID 05ac:1000 as /class/input/input9
	input: USB HID v1.11 Mouse [HID 05ac:1000] on usb-0000:00:1d.3-1

So it works for me...

		Linus
