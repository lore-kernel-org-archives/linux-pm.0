From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: ehci_hcd causes box to resume immediately
	after suspend to RAM
Date: Thu, 14 Jun 2007 00:01:14 +0200
Message-ID: <200706140001.15354.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0706111536330.2749-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-bounces@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44L0.0706111536330.2749-100000@iolanthe.rowland.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-usb-devel>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-usb-devel-bounces@lists.sourceforge.net
Errors-To: linux-usb-devel-bounces@lists.sourceforge.net
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm <linux-pm@lists.osdl.org>, USB development list <linux-usb-devel@lists.sourceforge.net>
List-Id: linux-pm@vger.kernel.org

On Monday, 11 June 2007 22:10, Alan Stern wrote:
> On Mon, 11 Jun 2007, Rafael J. Wysocki wrote:
> 
> > > At that point, does "lspci -vv" show that the controller is trying to 
> > > signal a wakeup event?  That is, is the PME# signal asserted?
> > > 
> > > (Not that knowing this will help very much -- I'm not sure what we 
> > > could do with that information, and in any case there are other ways 
> > > besides PME# for on-board devices to report wakeup requests.  I ask 
> > > mainly out of curiousity.)
> > 
> > It shows this literally:
> > 
> > 00:1d.7 USB Controller: Intel Corporation 82801DB/DBM (ICH4/ICH4-M) USB2 EHCI Controller (rev 02) (prog-if 20 [EHCI])
> > 	Subsystem: ASUSTeK Computer Inc. Unknown device 8089
> > 	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
> > 	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> > 	Interrupt: pin D routed to IRQ 20
> > 	Region 0: Memory at febffc00 (32-bit, non-prefetchable) [size=1K]
> > 	Capabilities: [50] Power Management version 2
> > 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
> > 		Status: D3 PME-Enable+ DSel=0 DScale=0 PME-
> > 	Capabilities: [58] Debug port
> 
> Which means that the controller is in D3 and it supports PME#, but PME#
> isn't turned on.  But as I said, Intel controllers may signal wakeup
> requests in a different way (UHCI controllers definitely do, but maybe
> not EHCI).
> 
> > > The simplest workaround should be to disable remote wakeup for that 
> > > controller:
> > > 
> > > 	echo disable >/sys/bus/pci/devices/.../power/wakeup
> > 
> > I tried that but it didn't help.  Namely, the box resumed right after
> > suspending as it had done before.
> > 
> > The only way to prevent it from resuming immediately after the suspend is to
> > 'rmmod ehci_hcd' before the suspend.
> 
> Hmmm...  If you turn on CONFIG_USB_DEBUG, what shows up in 
> /sys/class/usb_host/usb_hostN/registers where N is the bus number of 
> the controller?

bus pci, device 0000:00:1d.7 (driver 10 Dec 2004)
EHCI Host Controller
EHCI 1.00, hcd state 4
ownership 00000001
SMI sts/enable 0x80080000
structural params 0x00103206
capability params 0x00006871
status 1008 Halt FLR
command 010000 (park)=0 ithresh=1 period=1024 HALT
intrenable 37 IAA FATAL PCD ERR INT
uframe 36f1
port 1 status 701000 POWER sig=se0
port 2 status 701000 POWER sig=se0
port 3 status 701000 POWER sig=se0
port 4 status 701000 POWER sig=se0
port 5 status 701000 POWER sig=se0
port 6 status 701000 POWER sig=se0
irq normal 0 err 0 reclaim 0 (lost 0)
complete 0 unlink 0

> Also, can you post a dmesg log (with CONFIG_USB_DEBUG enabled) showing 
> what happens during the suspend and immediate resume?

[That's after I have disabled the wakeup on the EHCI  controller.]

PM: Preparing system for mem sleep
Stopping tasks ... done.
Suspending console(s)
pnp: Device 00:07 disabled.
pnp: Device 00:05 disabled.
ehci_hcd 0000:00:1d.7: --> PCI D3
uhci_hcd 0000:00:1d.2: uhci_suspend
uhci_hcd 0000:00:1d.2: --> PCI D0/legacy
uhci_hcd 0000:00:1d.1: uhci_suspend
uhci_hcd 0000:00:1d.1: --> PCI D0/legacy
uhci_hcd 0000:00:1d.0: uhci_suspend
uhci_hcd 0000:00:1d.0: --> PCI D0/legacy
PM: Entering mem sleep
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
Back to C!
PM: Finishing wakeup.
uhci_hcd 0000:00:1d.0: PCI legacy resume
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: uhci_resume
uhci_hcd 0000:00:1d.0: uhci_check_and_reset_hc: legsup = 0x2f00
uhci_hcd 0000:00:1d.0: Performing full reset
usb usb2: root hub lost power or was reset
usb usb2: suspend_rh
uhci_hcd 0000:00:1d.1: PCI legacy resume
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: uhci_resume
uhci_hcd 0000:00:1d.1: uhci_check_and_reset_hc: legsup = 0x2000
uhci_hcd 0000:00:1d.1: Performing full reset
usb usb3: root hub lost power or was reset
usb usb3: suspend_rh
uhci_hcd 0000:00:1d.2: PCI legacy resume
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: uhci_resume
uhci_hcd 0000:00:1d.2: uhci_check_and_reset_hc: legsup = 0x2000
uhci_hcd 0000:00:1d.2: Performing full reset
usb usb4: root hub lost power or was reset
usb usb4: suspend_rh
ehci_hcd 0000:00:1d.7: PCI D0, from previous PCI D3
ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1d.7 to 64
PM: Writing back config space on device 0000:00:1e.0 at offset 7 (was 2280d0d0, writing 280d0d0)
PCI: Setting latency timer of device 0000:00:1e.0 to 64
PM: Writing back config space on device 0000:00:1f.1 at offset 9 (was 0, writing 30000000)
PM: Writing back config space on device 0000:00:1f.1 at offset 1 (was 2800005, writing 2800007)
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 16
PM: Writing back config space on device 0000:00:1f.5 at offset 1 (was 2900007, writing 2900003)
ACPI: PCI Interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 21
PCI: Setting latency timer of device 0000:00:1f.5 to 64
eth0: link down
pnp: Device 00:05 activated.
pnp: Device 00:07 activated.
pnp: Failed to activate device 00:0b.
pnp: Failed to activate device 00:0c.
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
hda: selected mode 0x42
hdb: selected mode 0x42
hdc: selected mode 0x42
usb usb1: usb resume
usb usb1: finish resume
hub 1-0:1.0: hub_resume
ehci_hcd 0000:00:1d.7: resume root hub
usb usb2: usb resume
usb usb2: finish resume
hub 2-0:1.0: hub_resume
usb usb2: wakeup_rh
usb usb3: usb resume
usb usb3: finish resume
hub 3-0:1.0: hub_resume
usb usb3: wakeup_rh
usb usb4: usb resume
usb usb4: finish resume
hub 4-0:1.0: hub_resume
usb usb4: wakeup_rh
Restarting tasks ... <7>hub 1-0:1.0: state 7 ports 6 chg 0000 evt 0000
ehci_hcd 0000:00:1d.7: GetStatus port 3 status 001020 POWER sig=se0 OCC
hub 1-0:1.0: over-current change on port 3
hub 1-0:1.0: trying to enable port power on non-switchable hub
done.
ehci_hcd 0000:00:1d.7: GetStatus port 4 status 001020 POWER sig=se0 OCC
hub 1-0:1.0: over-current change on port 4
hub 1-0:1.0: trying to enable port power on non-switchable hub
ehci_hcd 0000:00:1d.7: GetStatus port 5 status 001020 POWER sig=se0 OCC
hub 1-0:1.0: over-current change on port 5
hub 1-0:1.0: trying to enable port power on non-switchable hub
ehci_hcd 0000:00:1d.7: GetStatus port 6 status 001020 POWER sig=se0 OCC
hub 1-0:1.0: over-current change on port 6
hub 1-0:1.0: trying to enable port power on non-switchable hub
hub 2-0:1.0: state 7 ports 2 chg 0000 evt 0000
hub 3-0:1.0: state 7 ports 2 chg 0000 evt 0000
hub 4-0:1.0: state 7 ports 2 chg 0000 evt 0000
usb usb2: suspend_rh (auto-stop)
usb usb3: suspend_rh (auto-stop)
usb usb4: suspend_rh (auto-stop)
hub 1-0:1.0: hub_suspend
ehci_hcd 0000:00:1d.7: suspend root hub
usb usb1: usb auto-suspend
hub 2-0:1.0: hub_suspend
usb usb2: suspend_rh
usb usb2: usb auto-suspend
hub 3-0:1.0: hub_suspend
usb usb3: suspend_rh
usb usb3: usb auto-suspend
hub 4-0:1.0: hub_suspend
usb usb4: suspend_rh
usb usb4: usb auto-suspend

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
