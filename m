From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: xHCI and suspend/resume
Date: Sat, 14 May 2011 23:10:29 +0200
Message-ID: <201105142310.29314.rjw__30089.9107628085$1305407552$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1105121733370.1917-100000@iolanthe.rowland.org>
	<201105132237.34988.rjw@sisk.pl>
	<BANLkTi=XzZsQeBR8-sm9gLjh_Tbyp5LWMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <BANLkTi=XzZsQeBR8-sm9gLjh_Tbyp5LWMg@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Dwight Schauer <dschauer@gmail.com>
Cc: dschauer@ti.com, linux-pm@lists.linux-foundation.org, USB list <linux-usb@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Saturday, May 14, 2011, Dwight Schauer wrote:
> On Fri, May 13, 2011 at 3:37 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Friday, May 13, 2011, Dwight Schauer wrote:
> >> On Fri, May 13, 2011 at 3:04 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> >> > On Friday, May 13, 2011, Dwight Schauer wrote:
> >> >> On Thu, May 12, 2011 at 5:29 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> >> >> > On Thursday, May 12, 2011, Rafael J. Wysocki wrote:
> >> >> >> On Thursday, May 12, 2011, Alan Stern wrote:
> >> >> >> > For new readers: The problem is that an xHCI USB host controller does
> >> >> >> > not wake up a suspended system properly.
> >> >> >> >
> >> >> >> > On Thu, 12 May 2011, Dwight Schauer wrote:
> >> >> >> >
> >> >> >> > > Thanks Alan.
> >> >> >> > >
> >> >> >> > > OK, this is with 2.6.39-rc7-gregkh
> >> >> >> > >
> >> >> >> > > 05:00.0 USB Controller: NEC Corporation uPD720200 USB 3.0 Host
> >> >> >> > > Controller (rev 03) (prog-if 30 [XHCI])
> >> >> >> > >         Subsystem: Melco Inc Device 0241
> >> >> >> > >         Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
> >> >> >> > > ParErr- Stepping- SERR+ FastB2B- DisINTx+
> >> >> >> > >         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> >> >> >> > > <TAbort- <MAbort- >SERR- <PERR- INTx-
> >> >> >> > >         Interrupt: pin A routed to IRQ 17
> >> >> >> > >         Region 0: Memory at fe9fe000 (64-bit, non-prefetchable) [size=8K]
> >> >> >> > >         Capabilities: [50] Power Management version 3
> >> >> >> > >                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> >> >> >> > > PME(D0+,D1-,D2-,D3hot+,D3cold-)
> >> >> >> > >                 Status: D3 NoSoftRst+ PME-Enable+ DSel=0 DScale=0 PME+
> >> >> >> >
> >> >> >> > That's the important part for power management and wakeup.  The
> >> >> >> > controller does support PCI wakeup.  In fact, at the time you ran lspci
> >> >> >> > the controller _was_ suspended and it was signalling a wakeup request!
> >> >> >> > Obviously something is wrong somewhere...
> >> >> >> >
> >> >> >> > > @@@ With "on" in power/control I get this upon plugging in a keyboard:
> >> >> >> > ...
> >> >> >> > > @@@ and upon removing it:
> >> >> >> >
> >> >> >> > All normal.
> >> >> >> >
> >> >> >> > > @@@ If I put "auto" in power/control I get this:
> >> >> >> > >
> >> >> >> > > xhci_hcd 0000:05:00.0: hcd_pci_runtime_suspend: 0
> >> >> >> > > xhci_hcd 0000:05:00.0: PME# enabled
> >> >> >> >
> >> >> >> > This means the controller was suspended with wakeup enabled, as it
> >> >> >> > should be.
> >> >> >> >
> >> >> >> > > @@@ Upon plugging in a keyboard nothing.
> >> >> >> >
> >> >> >> > Indeed, that is a problem.  Since wakeup doesn't work right at runtime,
> >> >> >> > it's not surprising that it also fails during system sleep.
> >> >> >> >
> >> >> ....
> >> >> >> >
> >> >> >> > Clearly something is wrong.  But it looks like the problem might be
> >> >> >> > somewhere else, not in the xHCI driver.  Is your BIOS up to date?
> >> >> >> >
> >> >> >> > CC-ing the linux-pm mailing list in case anybody there has some ideas.
> >> >> >>
> >> >> >> I need a boot log from 2.6.39-rc6 (or current Linus') on the affected system.
> >> >> >
> >> >> > That should have been -rc7, sorry.
> >> >> >
> >> >> > Thanks,
> >> >> > Rafael
> >> >>
> >> >> Rafael,
> >> >>
> >> >> I updated the BIOS, but the results are the same.
> >> >
> >> > I'm not really sure if that matters.
> >> >
> >> > Thanks for the boot log.
> >> >
> >> > Please send the contents of /proc/interrupts before and after you've tried
> >> > to resume the xHCI controller.
> >>
> > ...
> >>
> >> @@@ plug keyboard back in
> >>
> >> cat /proc/interrupts
> >>             CPU0       CPU1       CPU2       CPU3
> >>    0:        160          2        444     122646   IO-APIC-edge      timer
> >>    1:          0          0          1          7   IO-APIC-edge      i8042
> >>    4:          0          0          0          2   IO-APIC-edge
> >>    8:          0          0          1        112   IO-APIC-edge      rtc0
> >>    9:          0          0          0          2   IO-APIC-fasteoi   acpi
> >>   16:          0          0          0        439   IO-APIC-fasteoi   hda_intel
> >>   17:          0          0          0          4   IO-APIC-fasteoi
> >> ehci_hcd:usb1, ehci_hcd:usb3, ehci_hcd:usb6
> >>   18:          0          0          4        669   IO-APIC-fasteoi
> >> ahci, ohci_hcd:usb8, ohci_hcd:usb9, ohci_hcd:usb10, ohci_hcd:usb11,
> >> radeon
> >>   19:          0          1        385      25596   IO-APIC-fasteoi
> >> pata_jmicron, hda_intel
> >>   40:          0          0          0          0   PCI-MSI-edge      PCIe PME
> >>   41:          0          0          0          0   PCI-MSI-edge      PCIe PME
> >>   42:          0          0          0          0   PCI-MSI-edge      PCIe PME
> >>   43:          0          0          0          0   PCI-MSI-edge      PCIe PME
> >>   44:          0          0          0          1   PCI-MSI-edge      xhci_hcd
> >>   45:          0          0          0          0   PCI-MSI-edge      xhci_hcd
> >>   46:          0          0          0          0   PCI-MSI-edge      xhci_hcd
> >>   47:          0          0          0          0   PCI-MSI-edge      xhci_hcd
> >>   48:          0          0          0          0   PCI-MSI-edge      xhci_hcd
> >>   49:          0          0          1         93   PCI-MSI-edge      xhci_hcd
> >>   50:          0          0          0          0   PCI-MSI-edge      xhci_hcd
> >>   51:          0          0          0          0   PCI-MSI-edge      xhci_hcd
> >>   52:          0          0          0          0   PCI-MSI-edge      xhci_hcd
> >>   53:          0          0          0          0   PCI-MSI-edge      xhci_hcd
> >>   54:          0          0         53      10289   PCI-MSI-edge      ahci
> >>   55:          0          0        266      71934   PCI-MSI-edge      eth0
> >>  NMI:          0          0          0          0   Non-maskable interrupts
> >>  LOC:      25130      27508      14608       1864   Local timer interrupts
> >>  SPU:          0          0          0          0   Spurious interrupts
> >>  PMI:          0          0          0          0   Performance
> >> monitoring interrupts
> >>  IWI:          0          0          0          0   IRQ work interrupts
> >>  RES:      15335       8131       5912      13899   Rescheduling interrupts
> >>  CAL:         95 138 135 60   Function call interrupts
> >>  TLB:        225        475        475        194   TLB shootdowns
> >>  TRM:          0          0          0          0   Thermal event interrupts
> >>  THR:          0          0          0          0   Threshold APIC interrupts
> >>  MCE:          0          0          0          0   Machine check exceptions
> >>  MCP:         18         18         18         18   Machine check polls
> >>  ERR:          0
> >>  MIS:          0
> >
> > So, clearly, you don't get any PCIe PME interrupts from root ports
> > when the keyboard is plugged in.  Without those interrupts the runtime
> > resume of xhci won't work.
> >
> > Please attach the output of "lspci -vv" with "auto" in the (suspended) xhci's
> > power/control file before and after you've plugged in the keyboard.
> >
> > Thanks,
> > Rafael
> 
> The lspci -vv before, after, and diff are attached.

This means that the PME signaled by the xHCI doesn't cause the PMEStatus bit
in its root port to be set, which is why the root port doesn't generate
interrupts.  This seriously looks like a hardware bug and the only thing
we could do to work around it would be to poll the xHCI for the PME status
periodically (while suspended).

Can you see if the feature works after booting with pcie_ports=compat in
the kernel command line?

Rafael
