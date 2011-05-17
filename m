From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: xHCI and suspend/resume
Date: Tue, 17 May 2011 21:18:13 +0200
Message-ID: <201105172118.13725.rjw__1735.14840794287$1305660009$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1105121733370.1917-100000@iolanthe.rowland.org>
	<20110517153836.GA4142@xanatos>
	<BANLkTikFwkbC9hHNr1UZxLtO9W5+sHUdwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <BANLkTikFwkbC9hHNr1UZxLtO9W5+sHUdwg@mail.gmail.com>
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
Cc: Sarah Sharp <sarah.a.sharp@linux.intel.com>, dschauer@ti.com, linux-pm@lists.linux-foundation.org, USB list <linux-usb@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, May 17, 2011, Dwight Schauer wrote:
> On Tue, May 17, 2011 at 10:38 AM, Sarah Sharp
> <sarah.a.sharp@linux.intel.com> wrote:
> > On Sun, May 15, 2011 at 12:38:24AM +0200, Rafael J. Wysocki wrote:
> >> On Saturday, May 14, 2011, Dwight Schauer wrote:
> >> > 2011/5/14 Rafael J. Wysocki <rjw@sisk.pl>:
> >> > > On Saturday, May 14, 2011, Dwight Schauer wrote:
> >> > >> On Fri, May 13, 2011 at 3:37 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> >> > >> > On Friday, May 13, 2011, Dwight Schauer wrote:
> >> > >> >> On Fri, May 13, 2011 at 3:04 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> >> > >> >> > On Friday, May 13, 2011, Dwight Schauer wrote:
> >> > >> >> >> On Thu, May 12, 2011 at 5:29 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> >> > >> >> >> > On Thursday, May 12, 2011, Rafael J. Wysocki wrote:
> >> > >> >> >> >> On Thursday, May 12, 2011, Alan Stern wrote:
> >> >
> >> > >> >> >> >> > For new readers: The problem is that an xHCI USB host controller does
> >> > >> >> >> >> > not wake up a suspended system properly.
> >> > ...
> >> > >> > So, clearly, you don't get any PCIe PME interrupts from root ports
> >> > >> > when the keyboard is plugged in.  Without those interrupts the runtime
> >> > >> > resume of xhci won't work.
> >> > >> >
> >> > >> > Please attach the output of "lspci -vv" with "auto" in the (suspended) xhci's
> >> > >> > power/control file before and after you've plugged in the keyboard.
> >> > >> >
> >> > >> > Thanks,
> >> > >> > Rafael
> >> > >>
> >> > >> The lspci -vv before, after, and diff are attached.
> >> > >
> >> > > This means that the PME signaled by the xHCI doesn't cause the PMEStatus bit
> >> > > in its root port to be set, which is why the root port doesn't generate
> >> > > interrupts.  This seriously looks like a hardware bug and the only thing
> >> > > we could do to work around it would be to poll the xHCI for the PME status
> >> > > periodically (while suspended).
> >> > >
> >> > > Can you see if the feature works after booting with pcie_ports=compat in
> >> > > the kernel command line?
> >> > >
> >> > > Rafael
> >> > >
> >> >
> >> > I'll try that on Monday (the pcie_ports=compat kernel option).
> >> >
> >> > Well, I've got 2 different systems (one Intel and one AMD based, both
> >> > exhibit the same behavior).
> >>
> >> Are both xHCI controllers from NEC?
> >>
> >> > I have a few other systems I can try it on as well on Monday.
> >>
> >> Please do if possible.
> >
> > If pcie_ports=compat doesn't help, does it help if you use pci=nomsi?
> > I'm wondering if the hardware bug shows up only when MSI or MSI-X is
> > enabled for the NEC hardware.  Also, if you turn on
> > CONFIG_USB_XHCI_HCD_DEBUGGING, what NEC firmware version do you see in
> > dmesg?
> >
> > Sarah Sharp
> >
> 
> pcie_ports=compat had no effect
> with pci_=nomsi I get upon boot.
> 
> xhci_hcd 0000:02:00.0: Failed to enable MSI-X
> xhci_hcd 0000:02:00.0: failed to allocate MSI entry
> xhci_hcd 0000:06:00.0: Failed to enable MSI-X
> xhci_hcd 0000:06:00.0: failed to allocate MSI entry
> 
> The 6:00.0 is for NEC device in the PCIe slot.
> 
> With pci_=nomsi the rutime power management works, I can put auto in
> power/control and the device comes back on it's own.
> 
> However, this does not address the wakeup from system suspend issue,
> enabled in power/wakeup still does not work. If the interrupt is now
> being polled, that would make sense as to why it still does not work.
> 
> For TI's xHCI device I get "xhci_hcd 0000:02:00.0: failed to allocate
> MSI entry" with pci=nomsi.
> 
> The system with TI's device in it is exhibiting the same symptoms
> (wakeup does not work and by default auto in power/control does not
> work). It is a different motherboard and chip-set than the system I
> have the NEC device in.
> 
> pci=nomsi has no effect on the system with the TI xHCI device in it.
> pcie_ports=compat had no effect either as far as making auto in
> power/control work properly.
> 
> 
> As to the NEC firmware, both the on-board and off-board NEC devices
> have the same version:
> 
> xhci_hcd 0000:02:00.0: NEC firmware version 30.21
> xhci_hcd 0000:06:00.0: NEC firmware version 30.21
> 
> Attached are the dmesg boot logs for both systems.

OK, so for the S3 issue, I think there's a problem with the PCIe link
on these devices such that the link is not present during resume
and that's why commands are not reaching the device.  I'm not sure yet
what to do about it, but I wonder if xhci_hcd does something around
PCIe links on suspend?

Rafael
