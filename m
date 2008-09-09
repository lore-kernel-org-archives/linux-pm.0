From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC 3/5] pci wakeup handler
Date: Mon, 8 Sep 2008 19:56:42 -0700
Message-ID: <200809081956.42663.david-b__35679.0073834874$1220929668$gmane$org@pacbell.net>
References: <20080908091926.785882370@sli10-desk.sh.intel.com>
	<20080908092305.438330804@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080908092305.438330804@sli10-desk.sh.intel.com>
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
To: shaohua.li@intel.com
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Monday 08 September 2008, shaohua.li@intel.com wrote:
> --- linux.orig/drivers/pci/pci-driver.c	2008-09-08 13:55:56.000000000 +0800
> +++ linux/drivers/pci/pci-driver.c	2008-09-08 14:24:42.000000000 +0800
> @@ -472,12 +472,57 @@ static int pci_pm_resume_noirq(struct de
>  	return error;
>  }
>  
> +/*
> + * Called when dev is suspected to invoke a wakeup event, return 0 if yes
> + * */
> +static int pci_pm_wakeup_event(struct device *dev)

If wakeup notifications were bus-specific this would
take "struct pci_dev *pdev" ... and we're missing a
key part of this stuff, namely the code to sort out
which devices get this call.

I think you're assuming ACPI can just use its event
notification scheme to map from GPE through AML to
the particular device.  That's partly OK; except, see
below about bridge nodes.


> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	int pme_pos = pci_find_capability(pdev, PCI_CAP_ID_PM);

Yes, use the cached value here (like Rafael said)...


> +	struct pci_driver *drv = pdev->driver;
> +	u16 reg16;
> +	int spurious = 0;
> +	int ret = -ENODEV;
> +
> +	if (pme_pos == 0) {
> +		/*
> +		 * Some USB devices haven't PME, but have specific registers to
> +		 * control wakeup

The PCI PM spec has words some like:  "Some PCI devices support legacy
wakeup mechanisms instead of supporting PCI PM capabilities."  Today
the best example of that is Intel's UHCI controllers, but it's not
restricted to USB at all.

I suspect that this particular path won't often need to handle anything
other than those Intel controllers, however.  And so I hope that they
never share GPEs.  ;)

Another rather important case is bridges.  I observe that with ACPI
the way PME# is handled for add-in cards _seems_ to be that the bridge
for that PCI bus segment gets a GPE (presumably matching the PME#
signal for that bus segment, and maybe for its subsidiaries).  That
suggests the bridge will need to scan its children to find out which
one(s) issued PME#.  You didn't include such code here, where that
notification will be received...


> +		 */
> +		goto out;
> +	}
> +
> +	/* clear PME status and disable PME to avoid interrupt flood */
> +	pci_read_config_word(pdev, pme_pos + PCI_PM_CTRL, &reg16);
> +	if (!(reg16 & PCI_PM_CTRL_PME_STATUS))
> +		return -ENODEV;

Whitespace between paragraphs please ...

> +	/* I see spurious GPE here, just ignore it for now */

Comments about GPEs shouldn't be included here; they're ACPI-specific.
This is PCI-generic code!

But if you're going by GPEs, remember that several different
PCI devices could be hanging off the same GPE, with only one
of them issuing a wake event.  Maybe the "spurious" bit is an
artifact of an AML bug, issuing extra device notifications.


> +	if (!(reg16 & PCI_PM_CTRL_PME_ENABLE))
> +		spurious = 1;
> +	reg16 &= ~PCI_PM_CTRL_PME_ENABLE;
> +	reg16 |= PCI_PM_CTRL_PME_STATUS;
> +	pci_write_config_word(pdev, pme_pos + PCI_PM_CTRL, reg16);

If this device didn't issue PME, then don't clear PME_ENABLE.

By doing that you'd be preventing runtime power management
from working as effectively as it could.  (Example, several
PCI devices could enable PME and enter D3hot to shrink their
power demands while the system as a whole is in some G0/active
state rather than a G1/sleeping ACPI state.  If one issues a
wake event, that shouldn't disable PME on any others...


> +
> +	if (spurious)
> +		return -ENODEV;
> +	ret = 0;
> +	/* This device invokes PME, gives driver a chance to do something */
> +out:
> +	if (drv && drv->pm && drv->pm->base.wakeup_event) {
> +		if (!ret) /* ignore return value in this case */
> +			drv->pm->base.wakeup_event(&pdev->dev);
> +		else
> +			return drv->pm->base.wakeup_event(&pdev->dev);

I'm also puzzled why you want the legacy PM case (UHCI etc)
to work differently from the "normal" one.

And style-wise I'd really prefer to see

	return pdev->driver->wakeup(pdev);

Or perhaps more generically -- since I still have yet to
hear an argument why resume() shouldn't suffice to handle
the wakeup event processing, at least for PCI -- just

	if (pdev->driver->wakeup)
		return pdev->driver->wakeup(pdev);
	if (pdev->driver->resume)
		return pdev->driver->resume(pdev);

Although I don't know what the return value here should
be interpreted to mean.  Would it be better to return
void, and just log all "interesting"/error cases?


> +	}
> +	return ret;
> +}
>  #else /* !CONFIG_SUSPEND */
>  
>  #define pci_pm_suspend		NULL
>  #define pci_pm_suspend_noirq	NULL
>  #define pci_pm_resume		NULL
>  #define pci_pm_resume_noirq	NULL
> +#define pci_pm_wakeup_event	NULL
>  
>  #endif /* !CONFIG_SUSPEND */
>  
> @@ -651,6 +696,7 @@ struct pm_ext_ops pci_pm_ops = {
>  		.thaw = pci_pm_thaw,
>  		.poweroff = pci_pm_poweroff,
>  		.restore = pci_pm_restore,
> +		.wakeup_event = pci_pm_wakeup_event,
>  	},
>  	.suspend_noirq = pci_pm_suspend_noirq,
>  	.resume_noirq = pci_pm_resume_noirq,
> 
> -- 
> 
> 
