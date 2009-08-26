From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/2] handle wakeup event in PCI
Date: Wed, 26 Aug 2009 02:16:24 +0200
Message-ID: <200908260216.24606.rjw@sisk.pl>
References: <1251101493.22288.53.camel@sli10-desk.sh.intel.com>
	<20090825015838.GB27590@sli10-desk.sh.intel.com>
	<20090825070226.GA21913@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090825070226.GA21913@sli10-desk.sh.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux-pci <linux-pci@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday 25 August 2009, Shaohua Li wrote:
> On Tue, Aug 25, 2009 at 09:58:38AM +0800, Shaohua Li wrote:
> > On Tue, Aug 25, 2009 at 05:02:27AM +0800, Rafael J. Wysocki wrote:
> > > On Monday 24 August 2009, Shaohua Li wrote:
> > > > Add an implementation how to detect wakeup event for PCI. PCI device can
> > > > invoke PME, platform or PCIe native approach can collect the event and
> > > > report to OS. OS should identify exactly which device invokes PME as
> > > > several devices can share PME pin.
> > > > 
> > > > In platform approach (ACPI in this case), some BIOS give exact device which
> > > > invokes PME but others doesn't. 
> > > 
> > > I don't think the BIOS can reliably say which device signals PME# in the PCI
> > > (non-PCIe) case, unless the PME# is routed separately from each device to the
> > > chipset.  Also, two or more devices may signal PME# at the same time.
> > > 
> > > So, in this case we generally need to scan the entire hierarchy each time
> > > we get a PME#.
> > The thing isn't that simple. Some BIOS in its AML code clear PME status before
> > sending notification to OS, which will make the 'scan the entire hierarchy each
> > time' broken.
> > 
> > So my assumption here is BIOS sent notification to a specific device only when
> > it makes sure the device signals PME#. Otherwise, BIOS should send notification
> > to a bridge.
> > 
> > Or do you have better solution?
> > > > In PCIe native approach, if PME source device is a pcie endpoint, the device
> > > > is the exact PME source. If the device is root port or pcie-to-pci bridge,
> > > > we need scan the hierarchy under the device.
> > > 
> > > Why do we have to scan if the source is a root port itself?
> > The spec says legacy pci PME can directly route to root port, so this is similar
> > with the pcie-to-pci bridge case.
> > 
> > > > To identify PME source, the patch does:
> > > > 1. if the source is a pci device, the device is the only source for PME
> > > 
> > > That need not be true in the non-PCIe case IMO.
> > See my first comment.
> > 
> > > > 2. if the source is a bridge, scan the hierarchy under the bridge. Several
> > > > devices under the bridge could be the sources.
> > > 
> > > I think we need a function that will scan the hierarchy below a bridge
> > > (that may be the root bridge in the non-PCIe case or a PCIe-to-PCI
> > > bridge in the PCIe case) and if a device has PME_Status set, it will
> > > (a) clear it and (b) call pm_request_resume() for the device.
> > Even the PCIe device can work like a legacy PCI device to send PME and ACPI GPE
> > fires when this happens. I'd like we have a general solution for both PCIe case
> > and non-PCIe case.
> Rafael,
> how about the updated patch? I separate the wakeup event handling for ACPI and pcie.

Hmm.  It seems we can do that more elegantly, so to speak, but I need to
think about it when I'm less tired.

> Add an implementation how to detect wakeup event for PCI. PCI device can
> invoke PME, platform or PCIe native approach can collect the event and
> report to OS. OS should identify exactly which device invokes PME as
> several devices can share PME pin.
> 
> In platform approach (ACPI in this case), some BIOS give exact device which
> invokes PME but others doesn't. In either case, we always scan all devices
> to check which one is the wakeup source. In the meantime, if the device isn't a
> bridge, we trust the device is wakeup source even its PME status isn't set,
> because BIOS can clear PME status before OS gets notification and we have no
> reliable method to check if the device is the wakeup source.
> 
> In PCIe native approach, if PME source device is a pcie endpoint, the device
> is the exact PME source. If the device is root port or pcie-to-pci bridge,
> we need scan legacy devices in the hierarchy under the root port or bridge.
> 
> Signed-off-by: Shaohua Li <shaohua.li@intel.com>
> ---
>  drivers/pci/pci-driver.c |  100 +++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/pci/pci.h        |    3 +
>  2 files changed, 103 insertions(+)
> 
> Index: linux/drivers/pci/pci-driver.c
> ===================================================================
> --- linux.orig/drivers/pci/pci-driver.c	2009-08-25 13:30:47.000000000 +0800
> +++ linux/drivers/pci/pci-driver.c	2009-08-25 14:37:57.000000000 +0800
> @@ -17,6 +17,7 @@
>  #include <linux/slab.h>
>  #include <linux/sched.h>
>  #include <linux/cpu.h>
> +#include <linux/pm_runtime.h>
>  #include "pci.h"
>  
>  /*
> @@ -570,6 +571,105 @@ static void pci_pm_complete(struct devic
>  		drv->pm->complete(dev);
>  }
>  
> +/*
> + * pci_pm_check_wakeup_event - pdev is suspected to invoke a wakeup event
> + * @pdev: the suspected pci device
> + *
> + * Clear PME status and disable PME, return if the pci device @pdev really
> + * invokes PME
> + **/
> +static bool pci_pm_check_wakeup_event(struct pci_dev *pdev)
> +{
> +	int pme_pos = pdev->pm_cap;
> +	u16 pmcsr;
> +	bool spurious_pme = false;
> +
> +	if (!pme_pos)
> +		return false;
> +
> +	/* clear PME status and disable PME to avoid interrupt flood */
> +	pci_read_config_word(pdev, pme_pos + PCI_PM_CTRL, &pmcsr);
> +	if (!(pmcsr & PCI_PM_CTRL_PME_STATUS))
> +		return false;
> +	/* I see spurious PME here, just ignore it for now */
> +	if (pmcsr & PCI_PM_CTRL_PME_ENABLE)
> +		pmcsr &= ~PCI_PM_CTRL_PME_ENABLE;
> +	else
> +		spurious_pme = true;
> +	pmcsr |= PCI_PM_CTRL_PME_STATUS;
> +	pci_write_config_word(pdev, pme_pos + PCI_PM_CTRL, pmcsr);
> +
> +	return !spurious_pme;
> +}

This looks good, although I'm still thinking that "return something" is a bit
more natural to read than "return !something".  The code just means we return
'false' if there's a spurious PME and the name of the temp variable doesn't
really matter.  Well, whatever.

> +
> +/*
> + * pci_pm_handle_wakeup_event_native - handle PCIe native PME event
> + * @target is suspected to invoke a wakeup event (PME)
> + * Note @target should be a PCIe device
> + */
> +bool pci_pm_handle_wakeup_event_native(struct pci_dev *target)
> +{
> +	bool ret;
> +	struct pci_dev *tmp = NULL;
> +	int domain_nr, bus_start, bus_end;
> +
> +	BUG_ON(!target->is_pcie);
> +
> +	/* For PCIe PME, if the target isn't the source, do nothing */
> +	ret = pci_pm_check_wakeup_event(target);
> +	if (ret)
> +		pm_request_resume(&target->dev);
> +

This needs some more work IMO.  Namely, if we're sure that the device is not
a bridge that forwards the PME (BTW, the spec 2.0 says the PME Status won't
be set for the bridge itself in that case), we can just call

pm_runtime_resume(&target->dev);

and return, because there's no need to delay the execution of
->runtime_resume() by putting it into a separate work item.  So, IMO we should
do something like this:

* check if 'target' is a bridge forwarding the PME
* if not, execute pm_runtime_resume(&target->dev) and return
* otherwise, look for device(s) that assert PME# under the bridge, clear PME
  Status and execute pm_request_resume() for each of them

Thanks,
Rafael
