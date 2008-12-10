From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: USB suspend and resume for PCI host controllers
Date: Wed, 10 Dec 2008 22:03:34 +0100
Message-ID: <200812102203.35218.rjw__15415.9620557495$1228943226$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0812101127030.2175-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0812101127030.2175-100000@iolanthe.rowland.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: pm list <linux-pm@lists.linux-foundation.org>, USB list <linux-usb@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, 10 of December 2008, Alan Stern wrote:
> On Tue, 9 Dec 2008, Rafael J. Wysocki wrote:
> 
> > Hi,
> >  
> > > Here's the current version of my patch.  All of the PCI stuff has been 
> > > moved to the suspend_late and resume_early routines.
> > > 
> > > Now maybe that's not the right thing to do, or at least not until some 
> > > further fixes have been added.  All I can tell you is that this looks 
> > > right to me, but it doesn't work.  When I tried it, all the I/O and 
> > > MMIO accesses after resume_early returned nothing but 0xffffffff.
> > 
> > Well, it would be good to understand why this happens.
> 
> Probably because the state being restored is totally bogus, as you 
> noticed.
> 
> > > Here's a sample extracted from the log:
> > > 
> > > [  472.248029] ehci_hcd 0000:00:1d.7: resume from previous PCI D3: 0
> > > [  472.248139] ehci_hcd 0000:00:1d.7: restoring config space at offset 0xf (was 0x400, writing 0x0)
> > > [  472.248283] ehci_hcd 0000:00:1d.7: restoring config space at offset 0xd (was 0x50, writing 0x0)
> > > [  472.248430] ehci_hcd 0000:00:1d.7: restoring config space at offset 0xb (was 0x52478086, writing 0x0)
> > > [  472.248591] ehci_hcd 0000:00:1d.7: restoring config space at offset 0x2 (was 0xc032002, writing 0x0)
> > > [  472.248735] ehci_hcd 0000:00:1d.7: restoring config space at offset 0x1 (was 0x2900000, writing 0x0)
> > > [  472.248878] ehci_hcd 0000:00:1d.7: restoring config space at offset 0x0 (was 0x24cd8086, writing 0x0)
> > > [  472.249037] ehci_hcd 0000:00:1d.7: enabling device (0000 -> 0002)
> > > [  472.249136] ehci_hcd 0000:00:1d.7: PCI INT D -> GSI 23 (level, low) -> IRQ 23
> > > [  472.249237] ehci_hcd 0000:00:1d.7: setting latency timer to 64
> > > [  472.264026] ohci_hcd 0000:01:00.0: resume from previous PCI D3: 0
> > > [  472.264130] ohci_hcd 0000:01:00.0: restoring config space at offset 0xf (was 0x2a01010b, writing 0x0)
> > > [  472.264275] ohci_hcd 0000:01:00.0: restoring config space at offset 0xd (was 0x40, writing 0x0)
> > > [  472.264418] ohci_hcd 0000:01:00.0: restoring config space at offset 0xb (was 0x351033, writing 0x0)
> > > [  472.264571] ohci_hcd 0000:01:00.0: restoring config space at offset 0x4 (was 0xff8fd000, writing 0x0)
> > > [  472.264713] ohci_hcd 0000:01:00.0: restoring config space at offset 0x3 (was 0x802008, writing 0x0)
> > > [  472.264855] ohci_hcd 0000:01:00.0: restoring config space at offset 0x2 (was 0xc031043, writing 0x0)
> > > [  472.264997] ohci_hcd 0000:01:00.0: restoring config space at offset 0x1 (was 0x2100000, writing 0x0)
> > > [  472.265139] ohci_hcd 0000:01:00.0: restoring config space at offset 0x0 (was 0x351033, writing 0x0)
> > 
> > All of the above writes don't look good.  Only zeros were written, looks like
> > the saved state was bogus.
> 
> Just so.
> 
> > > +int usb_hcd_pci_suspend_late(struct pci_dev *dev, pm_message_t message)
> > > +{
> > > +	int			retval = 0;
> > > +	int			has_pci_pm;
> > > +	struct usb_hcd		*hcd = pci_get_drvdata(dev);
> > > +	int			wake;
> > > +
> > > +	/* We might already be suspended (runtime PM -- not yet written) */
> > > +	if (dev->current_state != PCI_D0)
> > > +		goto done;
> > > +
> > > +	/* Don't change state if we don't need to */
> > > +	if (message.event == PM_EVENT_FREEZE ||
> > > +			message.event == PM_EVENT_PRETHAW) {
> > > +		dev_dbg(&dev->dev, "--> no state change\n");
> > > +		goto done;
> > > +	}
> > >  
> > > -	/* even when the PCI layer rejects some of the PCI calls
> > > -	 * below, HCs can try global suspend and reduce DMA traffic.
> > > -	 * PM-sensitive HCDs may already have done this.
> > > -	 */
> > >  	has_pci_pm = pci_find_capability(dev, PCI_CAP_ID_PM);
> > > +	if (!has_pci_pm) {
> > > +		dev_dbg(&dev->dev, "--> PCI D0/legacy\n");
> > > +		goto done;
> > > +	}
> > > +
> > > +	/* Ignore these return values.  We rely on pci code to
> > > +	 * reject requests the hardware can't implement, rather
> > > +	 * than coding the same thing.
> > > +	 */
> > > +	wake = (hcd->state == HC_STATE_SUSPENDED &&
> > > +			device_may_wakeup(&dev->dev));
> > > +	(void) pci_enable_wake(dev, PCI_D3hot, wake);
> > > +	(void) pci_enable_wake(dev, PCI_D3cold, wake);
> > 
> > I'm not sure if this is safe to call these with interrupts disabled.
> 
> Then which calls should be made in the suspend method and which in the
> suspend_late method?

Please see below.

> >  Also,
> > there is pci_wake_from_d3() to call in such a context.
> 
> Okay, good.
> 
> > >  	/* Downstream ports from this root hub should already be quiesced, so
> > >  	 * there will be no DMA activity.  Now we can shut down the upstream
> > >  	 * link (except maybe for PME# resume signaling) and enter some PCI
> > >  	 * low power state, if the hardware allows.
> > >  	 */
> > > -	if (hcd->state == HC_STATE_SUSPENDED) {
> > > -
> > > -		/* no DMA or IRQs except when HC is active */
> > > -		if (dev->current_state == PCI_D0) {
> > > -			pci_save_state(dev);
> > > -			pci_disable_device(dev);
> > > -		}
> > > -
> > > -		if (message.event == PM_EVENT_FREEZE ||
> > > -				message.event == PM_EVENT_PRETHAW) {
> > > -			dev_dbg(hcd->self.controller, "--> no state change\n");
> > > -			goto done;
> > > -		}
> > > -
> > > -		if (!has_pci_pm) {
> > > -			dev_dbg(hcd->self.controller, "--> PCI D0/legacy\n");
> > > -			goto done;
> > > -		}
> > > +	pci_disable_device(dev);
> > >  
> > > -		/* NOTE:  dev->current_state becomes nonzero only here, and
> > > -		 * only for devices that support PCI PM.  Also, exiting
> > > -		 * PCI_D3 (but not PCI_D1 or PCI_D2) is allowed to reset
> > > -		 * some device state (e.g. as part of clock reinit).
> > > -		 */
> > > -		retval = pci_set_power_state(dev, PCI_D3hot);
> > > -		suspend_report_result(pci_set_power_state, retval);
> > > -		if (retval == 0) {
> > > -			int wake = device_can_wakeup(&hcd->self.root_hub->dev);
> > > -
> > > -			wake = wake && device_may_wakeup(hcd->self.controller);
> > > -
> > > -			dev_dbg(hcd->self.controller, "--> PCI D3%s\n",
> > > -					wake ? "/wakeup" : "");
> > > -
> > > -			/* Ignore these return values.  We rely on pci code to
> > > -			 * reject requests the hardware can't implement, rather
> > > -			 * than coding the same thing.
> > > -			 */
> > > -			(void) pci_enable_wake(dev, PCI_D3hot, wake);
> > > -			(void) pci_enable_wake(dev, PCI_D3cold, wake);
> > > -		} else {
> > > -			dev_dbg(&dev->dev, "PCI D3 suspend fail, %d\n",
> > > -					retval);
> > > -			(void) usb_hcd_pci_resume(dev);
> > > -		}
> > > -
> > > -	} else if (hcd->state != HC_STATE_HALT) {
> > > -		dev_dbg(hcd->self.controller, "hcd state %d; not suspended\n",
> > > -			hcd->state);
> > > -		WARN_ON(1);
> > > -		retval = -EINVAL;
> > > +	/* NOTE:  dev->current_state becomes nonzero only here, and
> > > +	 * only for devices that support PCI PM.  Also, exiting
> > > +	 * PCI_D3 (but not PCI_D1 or PCI_D2) is allowed to reset
> > > +	 * some device state (e.g. as part of clock reinit).
> > > +	 */
> > > +	retval = pci_set_power_state(dev, PCI_D3hot);
> > 
> > I'm not sure if it's safe to call this with interrupts disabled too.  It
> > invokes some ACPI callbacks that in turn use the AML interpreter, so I guess
> > it is not, in general.
> 
> You and Linus agreed in
> 
> 	http://marc.info/?l=linux-kernel&m=122851530232679&w=2
> 
> that pci_{save|restore}_state should be called with interrupts off (and
> presumably everything else with interrupts enabled).  But the example
> code shows pci_set_power_state called _after_ pci_save_state during
> suspend and _before_ pci_restore_state during resume.
> 
> So then how can pci_set_power_state be called with interrupts enabled?  
> Is the order in the code examples wrong?

Well, I'm not sure if calling pci_save_state() after pci_set_power_state()
is going to work in all cases.  For example, in theory ACPI may decide to
switch some power resources required by the device off and then the device's
registers will not be available after pci_set_power_state().

That said, I've never seen anything like this happening.

It would be most convenient to call pci_save_state() and pci_set_power_state()
right after it with interrupts disabled (on suspend) for all devices.  I'm
going to discuss this with the ACPI people.

pci_enable_wake() (or equivalent function) can be called at the end of
->suspend(), with interrupts enabled.

IMO pci_restore_state() ought to be called with interrupts disabled, at
least for devices for which it isn't known  to cause problems.
pci_enable_device() - I'm not sure.  I _think_ calling it with interrupts
enabled is fine.

> > > +	suspend_report_result(pci_set_power_state, retval);
> > > +	if (retval == 0) {
> > > +		dev_dbg(hcd->self.controller, "--> PCI D3%s\n",
> > > +				wake ? "/wakeup" : "");
> > > +	} else {
> > > +		dev_dbg(&dev->dev, "PCI D3 suspend fail, %d\n", retval);
> > > +		(void) usb_hcd_pci_resume(dev);
> > >  	}
> > >  
> > > -done:
> > > -	if (retval == 0) {
> > > + done:
> > >  #ifdef CONFIG_PPC_PMAC
> > > +	if (retval == 0) {
> > >  		/* Disable ASIC clocks for USB */
> > >  		if (machine_is(powermac)) {
> > >  			struct device_node	*of_node;
> > > @@ -311,30 +299,23 @@ done:
> > >  				pmac_call_feature(PMAC_FTR_USB_ENABLE,
> > >  							of_node, 0, 0);
> > >  		}
> > > -#endif
> > >  	}
> > > +#endif
> > >  
> > >  	return retval;
> > >  }
> > > -EXPORT_SYMBOL_GPL(usb_hcd_pci_suspend);
> > > +EXPORT_SYMBOL_GPL(usb_hcd_pci_suspend_late);
> > 
> > Well, it looks like you forgot to actually call pci_save_power_state(). :-)
> 
> I didn't forget it -- in my tree there is no such function!  :-)

That should have been pci_save_state(). [Note to self: don't send email when
you're too tired.]

Thanks,
Rafael
