From: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Subject: Re: xHCI and suspend/resume
Date: Tue, 17 May 2011 08:38:36 -0700
Message-ID: <20110517153836.GA4142__29082.7456083663$1305742487$gmane$org@xanatos>
References: <Pine.LNX.4.44L0.1105121733370.1917-100000@iolanthe.rowland.org>
	<201105142310.29314.rjw@sisk.pl>
	<BANLkTik=qXDHj9Qv=c3S657SqEBAC9+1jw@mail.gmail.com>
	<201105150038.24493.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201105150038.24493.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: dschauer@ti.com, linux-pm@lists.linux-foundation.org, USB list <linux-usb@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sun, May 15, 2011 at 12:38:24AM +0200, Rafael J. Wysocki wrote:
> On Saturday, May 14, 2011, Dwight Schauer wrote:
> > 2011/5/14 Rafael J. Wysocki <rjw@sisk.pl>:
> > > On Saturday, May 14, 2011, Dwight Schauer wrote:
> > >> On Fri, May 13, 2011 at 3:37 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > >> > On Friday, May 13, 2011, Dwight Schauer wrote:
> > >> >> On Fri, May 13, 2011 at 3:04 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > >> >> > On Friday, May 13, 2011, Dwight Schauer wrote:
> > >> >> >> On Thu, May 12, 2011 at 5:29 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > >> >> >> > On Thursday, May 12, 2011, Rafael J. Wysocki wrote:
> > >> >> >> >> On Thursday, May 12, 2011, Alan Stern wrote:
> > 
> > >> >> >> >> > For new readers: The problem is that an xHCI USB host controller does
> > >> >> >> >> > not wake up a suspended system properly.
> > ...
> > >> > So, clearly, you don't get any PCIe PME interrupts from root ports
> > >> > when the keyboard is plugged in.  Without those interrupts the runtime
> > >> > resume of xhci won't work.
> > >> >
> > >> > Please attach the output of "lspci -vv" with "auto" in the (suspended) xhci's
> > >> > power/control file before and after you've plugged in the keyboard.
> > >> >
> > >> > Thanks,
> > >> > Rafael
> > >>
> > >> The lspci -vv before, after, and diff are attached.
> > >
> > > This means that the PME signaled by the xHCI doesn't cause the PMEStatus bit
> > > in its root port to be set, which is why the root port doesn't generate
> > > interrupts.  This seriously looks like a hardware bug and the only thing
> > > we could do to work around it would be to poll the xHCI for the PME status
> > > periodically (while suspended).
> > >
> > > Can you see if the feature works after booting with pcie_ports=compat in
> > > the kernel command line?
> > >
> > > Rafael
> > >
> > 
> > I'll try that on Monday (the pcie_ports=compat kernel option).
> > 
> > Well, I've got 2 different systems (one Intel and one AMD based, both
> > exhibit the same behavior).
> 
> Are both xHCI controllers from NEC?
> 
> > I have a few other systems I can try it on as well on Monday.
> 
> Please do if possible.

If pcie_ports=compat doesn't help, does it help if you use pci=nomsi?
I'm wondering if the hardware bug shows up only when MSI or MSI-X is
enabled for the NEC hardware.  Also, if you turn on
CONFIG_USB_XHCI_HCD_DEBUGGING, what NEC firmware version do you see in
dmesg?

Sarah Sharp
