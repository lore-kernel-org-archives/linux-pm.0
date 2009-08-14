From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFC] PCI: Runtime power management
Date: Fri, 14 Aug 2009 23:30:13 +0100
Message-ID: <20090814223013.GB20015__1482.87017732418$1250289071$gmane$org@srcf.ucam.org>
References: <200908081625.57333.rjw@sisk.pl> <200908092313.05541.rjw@sisk.pl>
	<20090813002925.GA2532@srcf.ucam.org>
	<200908142322.27544.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200908142322.27544.rjw@sisk.pl>
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
Cc: linux-usb@vger.kernel.org, linux-pci@vger.kernel.org, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Aug 14, 2009 at 11:22:27PM +0200, Rafael J. Wysocki wrote:

> Do you have any prototypes for that?  I started working on it some time ago,
> but then I focused on the core runtime PM framework.

The native PCIe PME code? There's some in the final patchset at 
http://bugzilla.kernel.org/show_bug.cgi?id=6892 but I haven't had time 
to look into merging that into the current kernel. I also don't have 
anything to test against, which makes life more awkward.

> > +static int acpi_pci_runtime_wake(struct pci_dev *dev, bool enable)
> > +{
> > +	acpi_status status;
> > +	acpi_handle handle = DEVICE_ACPI_HANDLE(&dev->dev);
> > +	struct acpi_device *acpi_dev;
> > +
> 
> Hm, I'd move that into ACPI as
> 
> int acp_runtime_wake_enable(acpi_handle handle, bool enable)
> 
> in which form it could also be useful to non-PCI devices.

Hm. Yeah, that's not too bad an idea.

> > +		acpi_disable_gpe(acpi_dev->wakeup.gpe_device,
> > +				 acpi_dev->wakeup.gpe_number);
> > +	}
> > +	return 0;
> > +}
> 
> Ah, that's the part I've always been missing!
> 
> How exactly do we figure out which GPE is a wake-up one for given device?
> IOW, how are the wakeup.gpe_device and wakeup.gpe_number fields populated?

There's a field in the ACPI device definition in the DSDT that defines 
the needed GPE and which runlevels it can resume from.

> > +	error = pci_pm_suspend(dev);
> 
> This has a chance to be confusing IMO.  pci_pm_suspend() calls the driver's
> ->suspend() routine, which is specific to suspend to RAM.  So, this means
> that drivers are supposed to implement ->runtime_suspend() only if they
> want to do something _in_ _addition_ to the things done by
> ->suspend() and ->suspend_noirq().

Yes, that was how I'd planned it. An alternative would be for 
runtime_suspend to return a negative value if there's an error, 0 if the 
bus code should continue or a positive value if the runtime_suspend() 
call handles all of it and the bus code should just return immediately?

> > +	disable_irq(pci_dev->irq);
> 
> I don't really think it's necessary to disable the interrupt here.  We prevent
> drivers from receiving interrupts while pci_pm_suspend_noirq() is being run
> during system-wide power transitions to protect them from receiving "alien"
> interrupts they might be unable to handle, but in the runtime case I think the
> driver should take care of protecting itself from that.

That sounds fine. I didn't want to take a risk in that respect, but if 
we should be safe here I can just drop that.

> > +	if (!enable || pci_pme_capable(dev, PCI_D3hot)) {
> > +		pci_pme_active(dev, enable);
> > +		pme_done = true;
> > +	}
> 
> I don't really follow your intention here.  The condition means that PME is
> going to be enabled unless 'enable' is set and the device is not capable
> of generating PMEs.  However, if 'enable' is unset, we're still going to try
> to enable the PME, even if the device can't generate it.  Shouldn't that
> be

Hmm. That was copied from pci_enable_wake() just above, but it does seem 
a little bit odd. I suspect that that needs some clarification as well.

> Also, that assumes the device is going to be put into D3_hot, but do we know
> that for sure?

I'd be surprised if there's any hardware that supports wakeups from D2 
but not D3hot, so I just kept the code simple for now.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
