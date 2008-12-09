From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: USB suspend and resume for PCI host controllers
Date: Tue, 9 Dec 2008 23:16:09 +0100
Message-ID: <200812092316.09973.rjw__23606.1869808056$1228866350$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0812081705020.2434-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0812081705020.2434-100000@iolanthe.rowland.org>
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

On Monday, 8 of December 2008, Alan Stern wrote:
> Rafael:

Hi,
 
> Here's the current version of my patch.  All of the PCI stuff has been 
> moved to the suspend_late and resume_early routines.
> 
> Now maybe that's not the right thing to do, or at least not until some 
> further fixes have been added.  All I can tell you is that this looks 
> right to me, but it doesn't work.  When I tried it, all the I/O and 
> MMIO accesses after resume_early returned nothing but 0xffffffff.

Well, it would be good to understand why this happens.

> Here's a sample extracted from the log:
> 
> [  472.248029] ehci_hcd 0000:00:1d.7: resume from previous PCI D3: 0
> [  472.248139] ehci_hcd 0000:00:1d.7: restoring config space at offset 0xf (was 0x400, writing 0x0)
> [  472.248283] ehci_hcd 0000:00:1d.7: restoring config space at offset 0xd (was 0x50, writing 0x0)
> [  472.248430] ehci_hcd 0000:00:1d.7: restoring config space at offset 0xb (was 0x52478086, writing 0x0)
> [  472.248591] ehci_hcd 0000:00:1d.7: restoring config space at offset 0x2 (was 0xc032002, writing 0x0)
> [  472.248735] ehci_hcd 0000:00:1d.7: restoring config space at offset 0x1 (was 0x2900000, writing 0x0)
> [  472.248878] ehci_hcd 0000:00:1d.7: restoring config space at offset 0x0 (was 0x24cd8086, writing 0x0)
> [  472.249037] ehci_hcd 0000:00:1d.7: enabling device (0000 -> 0002)
> [  472.249136] ehci_hcd 0000:00:1d.7: PCI INT D -> GSI 23 (level, low) -> IRQ 23
> [  472.249237] ehci_hcd 0000:00:1d.7: setting latency timer to 64
> [  472.264026] ohci_hcd 0000:01:00.0: resume from previous PCI D3: 0
> [  472.264130] ohci_hcd 0000:01:00.0: restoring config space at offset 0xf (was 0x2a01010b, writing 0x0)
> [  472.264275] ohci_hcd 0000:01:00.0: restoring config space at offset 0xd (was 0x40, writing 0x0)
> [  472.264418] ohci_hcd 0000:01:00.0: restoring config space at offset 0xb (was 0x351033, writing 0x0)
> [  472.264571] ohci_hcd 0000:01:00.0: restoring config space at offset 0x4 (was 0xff8fd000, writing 0x0)
> [  472.264713] ohci_hcd 0000:01:00.0: restoring config space at offset 0x3 (was 0x802008, writing 0x0)
> [  472.264855] ohci_hcd 0000:01:00.0: restoring config space at offset 0x2 (was 0xc031043, writing 0x0)
> [  472.264997] ohci_hcd 0000:01:00.0: restoring config space at offset 0x1 (was 0x2100000, writing 0x0)
> [  472.265139] ohci_hcd 0000:01:00.0: restoring config space at offset 0x0 (was 0x351033, writing 0x0)

All of the above writes don't look good.  Only zeros were written, looks like
the saved state was bogus.

> [  472.265289] ohci_hcd 0000:01:00.0: enabling device (0000 -> 0002)
> [  472.265385] ohci_hcd 0000:01:00.0: PCI INT A -> GSI 21 (level, low) -> IRQ 21
> [  472.265484] ohci_hcd 0000:01:00.0: setting latency timer to 64
> ...
> [  472.350778] ehci_hcd 0000:00:1d.7: lost power, restarting
> [  472.350869] usb usb6: root hub lost power or was reset
> [  472.350964] ehci_hcd 0000:00:1d.7: reset command ffffffff park=3 ithresh=63 LReset IAAD Async Periodic period=?? R
> [  472.351120] ehci_hcd 0000:00:1d.7: debug port 1 IN USE
> [  472.351216] ehci_hcd 0000:00:1d.7: cache line size of 128 is not supported
> [  472.352143] ohci_hcd 0000:01:00.0: BIOS/SMM active, control ffffffff
> [  472.352237] ohci_hcd 0000:01:00.0: USB HC TakeOver from BIOS/SMM
> [  480.352022] ohci_hcd 0000:01:00.0: USB HC takeover failed!  (BIOS/SMM bug)
> [  480.368072] ohci_hcd 0000:01:00.0: USB HC reset timed out!
> [  480.368165] ohci_hcd 0000:01:00.0: can't restart, -1
> [  480.368253] usb usb9: root hub lost power or was reset
> [  480.368343] ohci_hcd 0000:01:00.0: already suspended
> 
> Alan Stern
> 
> 
> 
> Index: usb-2.6/drivers/usb/core/hcd.h
> ===================================================================
> --- usb-2.6.orig/drivers/usb/core/hcd.h
> +++ usb-2.6/drivers/usb/core/hcd.h
> @@ -256,7 +256,9 @@ extern int usb_hcd_pci_probe(struct pci_
>  extern void usb_hcd_pci_remove(struct pci_dev *dev);
>  
>  #ifdef CONFIG_PM
> -extern int usb_hcd_pci_suspend(struct pci_dev *dev, pm_message_t state);
> +extern int usb_hcd_pci_suspend(struct pci_dev *dev, pm_message_t msg);
> +extern int usb_hcd_pci_suspend_late(struct pci_dev *dev, pm_message_t msg);
> +extern int usb_hcd_pci_resume_early(struct pci_dev *dev);
>  extern int usb_hcd_pci_resume(struct pci_dev *dev);
>  #endif /* CONFIG_PM */
>  
> Index: usb-2.6/drivers/usb/core/hcd-pci.c
> ===================================================================
> --- usb-2.6.orig/drivers/usb/core/hcd-pci.c
> +++ usb-2.6/drivers/usb/core/hcd-pci.c
> @@ -191,17 +191,15 @@ EXPORT_SYMBOL_GPL(usb_hcd_pci_remove);
>  /**
>   * usb_hcd_pci_suspend - power management suspend of a PCI-based HCD
>   * @dev: USB Host Controller being suspended
> - * @message: semantics in flux
> + * @message: Power Management message describing this state transition
>   *
> - * Store this function in the HCD's struct pci_driver as suspend().
> + * Store this function in the HCD's struct pci_driver as .suspend.
>   */
>  int usb_hcd_pci_suspend(struct pci_dev *dev, pm_message_t message)
>  {
> -	struct usb_hcd		*hcd;
> +	struct usb_hcd		*hcd = pci_get_drvdata(dev);
>  	int			retval = 0;
> -	int			has_pci_pm;
>  
> -	hcd = pci_get_drvdata(dev);
>  
>  	/* Root hub suspend should have stopped all downstream traffic,
>  	 * and all bus master traffic.  And done so for both the interface
> @@ -212,96 +210,86 @@ int usb_hcd_pci_suspend(struct pci_dev *
>  	 * otherwise the swsusp will save (and restore) garbage state.
>  	 */
>  	if (!(hcd->state == HC_STATE_SUSPENDED ||
> -			hcd->state == HC_STATE_HALT))
> -		return -EBUSY;
> +			hcd->state == HC_STATE_HALT)) {
> +		dev_warn(&dev->dev, "Root hub is not suspended\n");
> +		retval = -EBUSY;
>  
> -	if (hcd->driver->pci_suspend) {
> +	} else if (hcd->driver->pci_suspend) {
>  		retval = hcd->driver->pci_suspend(hcd, message);
>  		suspend_report_result(hcd->driver->pci_suspend, retval);
> -		if (retval)
> -			goto done;
>  	}
> -	synchronize_irq(dev->irq);
>  
> -	/* FIXME until the generic PM interfaces change a lot more, this
> -	 * can't use PCI D1 and D2 states.  For example, the confusion
> -	 * between messages and states will need to vanish, and messages
> -	 * will need to provide a target system state again.
> -	 *
> -	 * It'll be important to learn characteristics of the target state,
> -	 * especially on embedded hardware where the HCD will often be in
> -	 * charge of an external VBUS power supply and one or more clocks.
> -	 * Some target system states will leave them active; others won't.
> -	 * (With PCI, that's often handled by platform BIOS code.)
> -	 */
> +	if (retval == 0)
> +		synchronize_irq(dev->irq);
> +	return retval;
> +}
> +EXPORT_SYMBOL_GPL(usb_hcd_pci_suspend);
> +
> +/**
> + * usb_hcd_pci_suspend_late - suspend a PCI-based HCD after IRQs are disabled
> + * @dev: USB Host Controller being suspended
> + * @message: Power Management message describing this state transition
> + *
> + * Store this function in the HCD's struct pci_driver as .suspend_late.
> + */
> +int usb_hcd_pci_suspend_late(struct pci_dev *dev, pm_message_t message)
> +{
> +	int			retval = 0;
> +	int			has_pci_pm;
> +	struct usb_hcd		*hcd = pci_get_drvdata(dev);
> +	int			wake;
> +
> +	/* We might already be suspended (runtime PM -- not yet written) */
> +	if (dev->current_state != PCI_D0)
> +		goto done;
> +
> +	/* Don't change state if we don't need to */
> +	if (message.event == PM_EVENT_FREEZE ||
> +			message.event == PM_EVENT_PRETHAW) {
> +		dev_dbg(&dev->dev, "--> no state change\n");
> +		goto done;
> +	}
>  
> -	/* even when the PCI layer rejects some of the PCI calls
> -	 * below, HCs can try global suspend and reduce DMA traffic.
> -	 * PM-sensitive HCDs may already have done this.
> -	 */
>  	has_pci_pm = pci_find_capability(dev, PCI_CAP_ID_PM);
> +	if (!has_pci_pm) {
> +		dev_dbg(&dev->dev, "--> PCI D0/legacy\n");
> +		goto done;
> +	}
> +
> +	/* Ignore these return values.  We rely on pci code to
> +	 * reject requests the hardware can't implement, rather
> +	 * than coding the same thing.
> +	 */
> +	wake = (hcd->state == HC_STATE_SUSPENDED &&
> +			device_may_wakeup(&dev->dev));
> +	(void) pci_enable_wake(dev, PCI_D3hot, wake);
> +	(void) pci_enable_wake(dev, PCI_D3cold, wake);

I'm not sure if this is safe to call these with interrupts disabled.  Also,
there is pci_wake_from_d3() to call in such a context.

>  	/* Downstream ports from this root hub should already be quiesced, so
>  	 * there will be no DMA activity.  Now we can shut down the upstream
>  	 * link (except maybe for PME# resume signaling) and enter some PCI
>  	 * low power state, if the hardware allows.
>  	 */
> -	if (hcd->state == HC_STATE_SUSPENDED) {
> -
> -		/* no DMA or IRQs except when HC is active */
> -		if (dev->current_state == PCI_D0) {
> -			pci_save_state(dev);
> -			pci_disable_device(dev);
> -		}
> -
> -		if (message.event == PM_EVENT_FREEZE ||
> -				message.event == PM_EVENT_PRETHAW) {
> -			dev_dbg(hcd->self.controller, "--> no state change\n");
> -			goto done;
> -		}
> -
> -		if (!has_pci_pm) {
> -			dev_dbg(hcd->self.controller, "--> PCI D0/legacy\n");
> -			goto done;
> -		}
> +	pci_disable_device(dev);
>  
> -		/* NOTE:  dev->current_state becomes nonzero only here, and
> -		 * only for devices that support PCI PM.  Also, exiting
> -		 * PCI_D3 (but not PCI_D1 or PCI_D2) is allowed to reset
> -		 * some device state (e.g. as part of clock reinit).
> -		 */
> -		retval = pci_set_power_state(dev, PCI_D3hot);
> -		suspend_report_result(pci_set_power_state, retval);
> -		if (retval == 0) {
> -			int wake = device_can_wakeup(&hcd->self.root_hub->dev);
> -
> -			wake = wake && device_may_wakeup(hcd->self.controller);
> -
> -			dev_dbg(hcd->self.controller, "--> PCI D3%s\n",
> -					wake ? "/wakeup" : "");
> -
> -			/* Ignore these return values.  We rely on pci code to
> -			 * reject requests the hardware can't implement, rather
> -			 * than coding the same thing.
> -			 */
> -			(void) pci_enable_wake(dev, PCI_D3hot, wake);
> -			(void) pci_enable_wake(dev, PCI_D3cold, wake);
> -		} else {
> -			dev_dbg(&dev->dev, "PCI D3 suspend fail, %d\n",
> -					retval);
> -			(void) usb_hcd_pci_resume(dev);
> -		}
> -
> -	} else if (hcd->state != HC_STATE_HALT) {
> -		dev_dbg(hcd->self.controller, "hcd state %d; not suspended\n",
> -			hcd->state);
> -		WARN_ON(1);
> -		retval = -EINVAL;
> +	/* NOTE:  dev->current_state becomes nonzero only here, and
> +	 * only for devices that support PCI PM.  Also, exiting
> +	 * PCI_D3 (but not PCI_D1 or PCI_D2) is allowed to reset
> +	 * some device state (e.g. as part of clock reinit).
> +	 */
> +	retval = pci_set_power_state(dev, PCI_D3hot);

I'm not sure if it's safe to call this with interrupts disabled too.  It
invokes some ACPI callbacks that in turn use the AML interpreter, so I guess
it is not, in general.

> +	suspend_report_result(pci_set_power_state, retval);
> +	if (retval == 0) {
> +		dev_dbg(hcd->self.controller, "--> PCI D3%s\n",
> +				wake ? "/wakeup" : "");
> +	} else {
> +		dev_dbg(&dev->dev, "PCI D3 suspend fail, %d\n", retval);
> +		(void) usb_hcd_pci_resume(dev);
>  	}
>  
> -done:
> -	if (retval == 0) {
> + done:
>  #ifdef CONFIG_PPC_PMAC
> +	if (retval == 0) {
>  		/* Disable ASIC clocks for USB */
>  		if (machine_is(powermac)) {
>  			struct device_node	*of_node;
> @@ -311,30 +299,23 @@ done:
>  				pmac_call_feature(PMAC_FTR_USB_ENABLE,
>  							of_node, 0, 0);
>  		}
> -#endif
>  	}
> +#endif
>  
>  	return retval;
>  }
> -EXPORT_SYMBOL_GPL(usb_hcd_pci_suspend);
> +EXPORT_SYMBOL_GPL(usb_hcd_pci_suspend_late);

Well, it looks like you forgot to actually call pci_save_power_state(). :-)

Thanks,
Rafael
