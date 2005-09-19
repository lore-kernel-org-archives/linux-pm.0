From: "Brown, Len" <len.brown@intel.com>
Subject: RE: 2 different acpi bugs.
Date: Sun, 18 Sep 2005 23:15:08 -0400
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3004A13DD9@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============11485150049604975=="
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-class: urn:content-classes:message
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: patrizio.bassi@gmail.com
Cc: acpi-devel@lists.sourceforge.net, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============11485150049604975==
Content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="iso-8859-15"
Content-Transfer-Encoding: 8bit

(please forgive me for top-posting:-)

Patrizio,
acpi-devel@lists.sourceforge.net is a good place for this
type of issue, as is linux-pm@lists.osdl.org -- particularly
for your suspend-to-disk issue.

The IRQ14 is certainly an IDE suspend/resume issue.
IDE suspend/resume works by luck on most systems.
There are some experimental IDE suspend/resume
patches floating around out there, however.

> echo shutdown > /sys/power/disk
> echo disk > /sys/power/state

See if STD works if you first unload USB before suspend
and then re-load the module on resume.

cheers,
-Len

------------

hi Len,

i wrote in kernel ml, but got no answers.
i have 2 different bugs, on my 2 machines.

both using 2.6.14-rc1.

i've separated the 2 bugs in 2 sections.

Ready to test any patch/fix suggestion.

Thanks for help.



1)
On my notebook acpi suspend works perfectly but i get:

Stopping tasks: =================|
Freeing memory... done (41592 pages freed)
ACPI: PCI interrupt for device 0000:00:01.4 disabled
ACPI: PCI interrupt for device 0000:00:01.3 disabled
ACPI: PCI interrupt for device 0000:00:01.2 disabled
swsusp: Need to copy 24667 pages
ACPI: PCI Interrupt 0000:00:00.1[A]: no GSI - using IRQ 14
eth0: Media Link Off
ACPI: PCI Interrupt 0000:00:01.2[D] -> Link [LNKD] -> GSI 5 (level, low) 
-> IRQ 5
ACPI: PCI Interrupt 0000:00:01.2[D] -> Link [LNKD] -> GSI 5 (level, low) 
-> IRQ 5
ACPI: PCI Interrupt 0000:00:01.3[D] -> Link [LNKD] -> GSI 5 (level, low) 
-> IRQ 5
ACPI: PCI Interrupt 0000:00:01.3[D] -> Link [LNKD] -> GSI 5 (level, low) 
-> IRQ 5
ACPI: PCI Interrupt 0000:00:01.4[B] -> Link [LNKB] -> GSI 5 (level, low) 
-> IRQ 5
PCI: Setting latency timer of device 0000:00:02.0 to 64
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LNKA] -> GSI 11 (level, 
low) -> IRQ 11
ACPI: PCI Interrupt 0000:00:0a.1[B] -> Link [LNKC] -> GSI 5 (level, low) 
-> IRQ 5
irq 14: nobody cared (try booting with the "irqpoll" option)
[<c013926a>] __report_bad_irq+0x2a/0x90
[<c0139390>] note_interrupt+0xa0/0x100
[<c0138d09>] __do_IRQ+0xa9/0xc0
[<c0105139>] do_IRQ+0x19/0x30
[<c0103a76>] common_interrupt+0x1a/0x20
[<c011e5ce>] __do_softirq+0x2e/0xa0
[<c011e666>] do_softirq+0x26/0x30
[<c010513e>] do_IRQ+0x1e/0x30
[<c0103a76>] common_interrupt+0x1a/0x20
[<c0236ee7>] acpi_processor_idle+0x11d/0x27f
[<c01010e2>] cpu_idle+0x42/0x60
[<c045c89d>] start_kernel+0x17d/0x1c0
[<c045c3b0>] unknown_bootoption+0x0/0x1f0
handlers:
[<c0294a50>] (ide_intr+0x0/0x170)
Disabling IRQ #14

i have the "irqpoll" option as suggested.

problems:
a) seems that before writing data to disk it waits for:
hda: dma_timer_expiry: dma status == 0x24
this lasts some seconds..

b) compared to 2.6.12 it seems working a bit slower.
on suspend...probably due to the timeout
on resume console is painted, but if i press keys i get nothing on 
console tty.
i have to wait some random seconds...
seems strange because i can switch from consoles...so that's not a real 
freeze.


2)
after:

echo shutdown > /sys/power/disk
echo disk > /sys/power/state

i get:

Could not suspend device 0000:00:0a.2: error -22

0000:00:0a.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 
1.1 Controller (rev 50)
0000:00:0a.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 
1.1 Controller (rev 50)
0000:00:0a.2 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 51)

it's a pci usb 2.0 card. no active device plugged there.

the bad thing is that i can't suspend.
the good thing is that kernel is safe, i can still work with it, without 
panic or other troubles.

i attach part of log.

------------------------------------------------------------------------
Sep 15 08:24:17 blight kernel: device eth0 entered promiscuous mode
Sep 15 08:24:17 blight kernel: eth1: Setting promiscuous mode.
Sep 15 08:24:17 blight kernel: device eth1 entered promiscuous mode
Sep 15 08:24:29 blight kernel: agpgart: Found an AGP 1.0 compliant device at 0000:00:00.0.
Sep 15 08:24:29 blight kernel: agpgart: Putting AGP V2 device at 0000:00:00.0 into 2x mode
Sep 15 08:24:29 blight kernel: agpgart: Putting AGP V2 device at 0000:01:00.0 into 2x mode
Sep 15 08:24:56 blight kernel: device ppp0 entered promiscuous mode
Sep 15 08:25:18 blight kernel: eth1: Setting full-duplex based on MII #24 link partner capability of 05e1.
Sep 15 08:25:18 blight kernel: blight: port 2(eth1) entering learning state
Sep 15 08:25:33 blight kernel: blight: topology change detected, propagating
Sep 15 08:25:33 blight kernel: blight: port 2(eth1) entering forwarding state
Sep 15 13:31:14 blight kernel: eth0: Setting full-duplex based on MII #24 link partner capability of 01e1.
Sep 15 13:31:14 blight kernel: blight: port 1(eth0) entering learning state
Sep 15 13:31:29 blight kernel: blight: topology change detected, propagating
Sep 15 13:31:29 blight kernel: blight: port 1(eth0) entering forwarding state
Sep 15 14:21:17 blight kernel: blight: port 2(eth1) entering disabled state
Sep 15 14:26:14 blight kernel: blight: port 1(eth0) entering disabled state
Sep 15 14:28:36 blight kernel: Stopping tasks: =======================================|
Sep 15 14:28:36 blight kernel: Freeing memory...  ^H-^H\^H|^H/^H-^H\^Hdone (77270 pages freed)
Sep 15 14:28:36 blight kernel: usbfs 2-2:1.0: resume is unsafe!
Sep 15 14:28:36 blight kernel: ACPI: PCI interrupt for device 0000:00:0d.0 disabled
Sep 15 14:28:36 blight kernel: ACPI: PCI interrupt for device 0000:00:0a.2 disabled
Sep 15 14:28:36 blight kernel: Could not suspend device 0000:00:0a.2: error -22
Sep 15 14:28:36 blight kernel: ACPI: PCI Interrupt 0000:00:0b.0[A] -> Link [LNKB] -> GSI 10 (level, low) -> IRQ 10
Sep 15 14:28:36 blight kernel: ACPI: PCI Interrupt 0000:00:0d.0[A] -> Link [LNKD] -> GSI 9 (level, low) -> IRQ 9
Sep 15 14:28:37 blight kernel: ACPI: PCI Interrupt 0000:00:0d.0[A] -> Link [LNKD] -> GSI 9 (level, low) -> IRQ 9
Sep 15 14:28:37 blight kernel: eth1: Setting promiscuous mode.
Sep 15 14:28:37 blight kernel: Some devices failed to suspend
Sep 15 14:28:37 blight kernel: Restarting tasks... done
Sep 15 14:28:37 blight kernel: device ppp0 left promiscuous mode
Sep 15 14:28:52 blight kernel: usb 2-2: USB disconnect, address 4
Sep 15 14:28:59 blight kernel: Stopping tasks: =======================================|
Sep 15 14:28:59 blight kernel: Freeing memory...  ^H-^Hdone (16103 pages freed)
Sep 15 14:28:59 blight kernel: ACPI: PCI interrupt for device 0000:00:0d.0 disabled
Sep 15 14:28:59 blight kernel: Could not suspend device 0000:00:0a.2: error -22
Sep 15 14:28:59 blight kernel: ACPI: PCI Interrupt 0000:00:0b.0[A] -> Link [LNKB] -> GSI 10 (level, low) -> IRQ 10
Sep 15 14:28:59 blight kernel: ACPI: PCI Interrupt 0000:00:0d.0[A] -> Link [LNKD] -> GSI 9 (level, low) -> IRQ 9
Sep 15 14:28:59 blight kernel: ACPI: PCI Interrupt 0000:00:0d.0[A] -> Link [LNKD] -> GSI 9 (level, low) -> IRQ 9
Sep 15 14:28:59 blight kernel: eth1: Setting promiscuous mode.
Sep 15 14:28:59 blight kernel: Some devices failed to suspend
Sep 15 14:28:59 blight kernel: Restarting tasks... done
Sep 15 14:29:38 blight kernel: mtrr: no MTRR for dc000000,2000000 found
Sep 15 14:29:39 blight kernel: agpgart: Found an AGP 1.0 compliant device at 0000:00:00.0.
Sep 15 14:29:39 blight kernel: agpgart: Putting AGP V2 device at 0000:00:00.0 into 2x mode
Sep 15 14:29:39 blight kernel: agpgart: Putting AGP V2 device at 0000:01:00.0 into 2x mode
Sep 15 14:30:01 blight kernel: mtrr: no MTRR for dc000000,2000000 found
Sep 15 14:30:18 blight kernel: Stopping tasks: ===============|
Sep 15 14:30:18 blight kernel: Freeing memory...  ^H-^H\^Hdone (14408 pages freed)
Sep 15 14:30:18 blight kernel: ACPI: PCI interrupt for device 0000:00:0d.0 disabled
Sep 15 14:30:18 blight kernel: Could not suspend device 0000:00:0a.2: error -22
Sep 15 14:30:18 blight kernel: ACPI: PCI Interrupt 0000:00:0b.0[A] -> Link [LNKB] -> GSI 10 (level, low) -> IRQ 10
Sep 15 14:30:18 blight kernel: ACPI: PCI Interrupt 0000:00:0d.0[A] -> Link [LNKD] -> GSI 9 (level, low) -> IRQ 9
Sep 15 14:30:18 blight kernel: ACPI: PCI Interrupt 0000:00:0d.0[A] -> Link [LNKD] -> GSI 9 (level, low) -> IRQ 9
Sep 15 14:30:18 blight kernel: eth1: Setting promiscuous mode.
Sep 15 14:30:18 blight kernel: Some devices failed to suspend
Sep 15 14:30:18 blight kernel: Restarting tasks... done




--===============11485150049604975==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============11485150049604975==--
