From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 084/123] USB: fix up suspend and resume for
 PCI host controllers
Date: Fri, 16 Jan 2009 11:04:39 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0901161039530.2417-100000__2585.68713111362$1232122034$gmane$org@iolanthe.rowland.org>
References: <200901132150.33201.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200901132150.33201.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, USB list <linux-usb@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 13 Jan 2009, Rafael J. Wysocki wrote:

> On Tuesday 13 January 2009, Alan Stern wrote:
> > On Wed, 7 Jan 2009, Rafael J. Wysocki wrote:
> > 
> > > Hi,
> > > 
> > > Sorry for being late, but ->
> > > 
> > > On Wednesday 07 January 2009, Greg Kroah-Hartman wrote:
> > > > From: Alan Stern <stern@rowland.harvard.edu>
> > > > 
> > > > This patch (as1192) rearranges the USB PCI host controller suspend and
> > > > resume and resume routines:
> > > > 
> > > > 	Use pci_wake_from_d3() for enabling and disabling wakeup,
> > > > 	instead of pci_enable_wake().
> > > > 
> > > > 	Carry out the actual state change while interrupts are
> > > > 	disabled.
> > > > 
> > > > 	Change the order of the preparations to agree with the
> > > > 	general recommendation for PCI devices, instead of
> > > > 	messing around with the wakeup settings while the device
> > > > 	is in D3.
> > > > 
> > > > 		In .suspend:
> > > > 			Call the underlying driver to disable IRQ
> > > > 				generation;
> > > > 			pci_wake_from_d3(device_may_wakeup());
> > > > 			pci_disable_device();
> > > > 
> > > > 		In .suspend_late:
> > > > 			pci_save_state();
> > > > 			pci_set_power_state(D3hot);
> > > 
> > > ->
> > > pci_set_power_state() does things that shouldn't be done with interrupts off,
> > > so I'd move the above two into .suspend.
> > > 
> > > > 			(for PPC_PMAC) Disable ASIC clocks
> > > 
> > > > 		In .resume_early:
> > > > 			(for PPC_PMAC) Enable ASIC clocks
> > > > 			pci_set_power_state(D0);
> > > 
> > > the pci_set_power_state(D0) is not necessary here IMO.  If the device is
> > > accessible at all, its config space is accessible too, even in D3.
> > > 
> > > pci_enable_device() does pci_set_power_state(D0) anyway.
> > > 
> > > > 			pci_restore_state();
> > > > 
> > > > 		In .resume:
> > > > 			pci_enable_device();
> > > > 			pci_set_master();
> > > > 			pci_wake_from_d3(0);
> > > > 			Call the underlying driver to reenable IRQ
> > > > 				generation
> > 
> > You are basically suggesting that everything except the PPC_PMAC stuff
> > be moved out of the interrupts-off region.  Is there in fact any
> > remaining reason for us to use suspend_late or resume_early?  It
> > doesn't seem like it.
> 
> Yes, it is.  Please have a look at the new PCI PM callbacks in
> drivers/pci/pci-driver.c .  Basically, IMO the standard config spaces should be
> restored with interrupts off if possible.
> 
> BTW, I think USB might benefit from implementing the new framework. ;-)

Agreed, but for now we'll stick with what we've got.

Anyway, going over your suggested change in

	http://marc.info/?l=linux-kernel&m=123184641714487&w=2

there are still several things I don't understand:

	Why the asymmetry between running pci_save_state() with
	interrupts on and pci_restore_state() with interrupts
	off?

	Why call pci_set_master() during resume without calling
	pci_clear_master() during suspend?

	Why did you move pci_wake_from_d3() after
	pci_disable_device() and pci_save_state()?

	Does pci_restore_state() restore the PME#-enable setting
	along with the power setting?  If so, why call
	pci_enable_wake() during resume at all?  If not, why change
	the wakeup settings after pci_save_state() in the suspend 
	routine but not before pci_restore_state() in the resume 
	routine?

	Why call pci_enable_wake() during resume instead of 
	pci_enable_wake_from_d3()?

	Is it really smart for pci_save_state() to save the
	power setting and pci_restore_state() to restore it?
	Would it make things simpler if these routines didn't
	alter the power setting?

Ben, we need to check with you on this also.  These patches we have
been throwing around move the code to disable and enable the PPC_PMAC
ASIC clocks for USB.  Can that code execute safely at any time while
the host controller isn't running?  Is it okay to execute the code
with interrupts disabled?

Alan Stern
