From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [PATCH 1/2] handle wakeup event in PCI
Date: Tue, 25 Aug 2009 09:58:38 +0800
Message-ID: <20090825015838.GB27590__20338.547617621$1251165698$gmane$org@sli10-desk.sh.intel.com>
References: <1251101493.22288.53.camel@sli10-desk.sh.intel.com>
	<200908242302.27131.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200908242302.27131.rjw@sisk.pl>
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
Cc: linux-pci <linux-pci@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Aug 25, 2009 at 05:02:27AM +0800, Rafael J. Wysocki wrote:
> On Monday 24 August 2009, Shaohua Li wrote:
> > Add an implementation how to detect wakeup event for PCI. PCI device can
> > invoke PME, platform or PCIe native approach can collect the event and
> > report to OS. OS should identify exactly which device invokes PME as
> > several devices can share PME pin.
> > 
> > In platform approach (ACPI in this case), some BIOS give exact device which
> > invokes PME but others doesn't. 
> 
> I don't think the BIOS can reliably say which device signals PME# in the PCI
> (non-PCIe) case, unless the PME# is routed separately from each device to the
> chipset.  Also, two or more devices may signal PME# at the same time.
> 
> So, in this case we generally need to scan the entire hierarchy each time
> we get a PME#.
The thing isn't that simple. Some BIOS in its AML code clear PME status before
sending notification to OS, which will make the 'scan the entire hierarchy each
time' broken.

So my assumption here is BIOS sent notification to a specific device only when
it makes sure the device signals PME#. Otherwise, BIOS should send notification
to a bridge.

Or do you have better solution?
> > In PCIe native approach, if PME source device is a pcie endpoint, the device
> > is the exact PME source. If the device is root port or pcie-to-pci bridge,
> > we need scan the hierarchy under the device.
> 
> Why do we have to scan if the source is a root port itself?
The spec says legacy pci PME can directly route to root port, so this is similar
with the pcie-to-pci bridge case.

> > To identify PME source, the patch does:
> > 1. if the source is a pci device, the device is the only source for PME
> 
> That need not be true in the non-PCIe case IMO.
See my first comment.

> > 2. if the source is a bridge, scan the hierarchy under the bridge. Several
> > devices under the bridge could be the sources.
> 
> I think we need a function that will scan the hierarchy below a bridge
> (that may be the root bridge in the non-PCIe case or a PCIe-to-PCI
> bridge in the PCIe case) and if a device has PME_Status set, it will
> (a) clear it and (b) call pm_request_resume() for the device.
Even the PCIe device can work like a legacy PCI device to send PME and ACPI GPE
fires when this happens. I'd like we have a general solution for both PCIe case
and non-PCIe case.

> > Signed-off-by: Shaohua Li <shaohua.li@intel.com>
> > ---
> >  drivers/pci/pci-driver.c |   77 +++++++++++++++++++++++++++++++++++++++++++++++
> >  drivers/pci/pci.h        |    2 +
> >  2 files changed, 79 insertions(+)
> > 
> > Index: linux/drivers/pci/pci-driver.c
> > ===================================================================
> > --- linux.orig/drivers/pci/pci-driver.c	2009-08-24 10:50:12.000000000 +0800
> > +++ linux/drivers/pci/pci-driver.c	2009-08-24 15:42:49.000000000 +0800
> > @@ -17,6 +17,7 @@
> >  #include <linux/slab.h>
> >  #include <linux/sched.h>
> >  #include <linux/cpu.h>
> > +#include <linux/pm_runtime.h>
> >  #include "pci.h"
> >  
> >  /*
> > @@ -570,6 +571,82 @@ static void pci_pm_complete(struct devic
> >  		drv->pm->complete(dev);
> >  }
> >  
> > +/*
> > + * Called when dev is suspected to invoke a wakeup event
> > + * */
> 
> Please add a full kerneldoc comment.
> 
> > +static bool pci_pm_check_wakeup_event(struct pci_dev *pdev)
> > +{
> > +	int pme_pos = pdev->pm_cap;
> > +	u16 pmcsr;
> > +	bool spurious = false;
> > +
> > +	if (pme_pos == 0) {
> 
> if (!pme_pos) would be better IMO.  Also the braces are not necessary and I'd
> move the comment somewhere else (that function is going to be called for
> devices that don't have the PM capability other than the USB controllers).
> 
> > +		/*
> > +		 * Some USB devices haven't PME, but have specific registers to
> > +		 * control wakeup
> > +		 */
> > +		return false;
> > +	}
> > +
> > +	/* clear PME status and disable PME to avoid interrupt flood */
> > +	pci_read_config_word(pdev, pme_pos + PCI_PM_CTRL, &pmcsr);
> > +	if (!(pmcsr & PCI_PM_CTRL_PME_STATUS))
> > +		return false;
> > +	/* I see spurious PME here, just ignore it for now */
> > +	if (!(pmcsr & PCI_PM_CTRL_PME_ENABLE))
> > +		spurious = true;
> > +	else
> > +		pmcsr &= ~PCI_PM_CTRL_PME_ENABLE;
> > +	pmcsr |= PCI_PM_CTRL_PME_STATUS;
> > +	pci_write_config_word(pdev, pme_pos + PCI_PM_CTRL, pmcsr);
> > +
> > +	if (spurious)
> > +		return false;
> > +	return true;
> 
> Fold these three lines into one:
> 
> + return !spurious;
> 
> Thus, I wouldn't call that variable 'spurious'.  I'd rather call it 'ret' and
> make it so that we can just return its value at the end.
but it's really spurious interrupt :).

> So, the above can be rewritten as
> 
> + 	/* Check if PME status is set. */
> +	pci_read_config_word(pdev, pme_pos + PCI_PM_CTRL, &pmcsr);
> +	if (!(pmcsr & PCI_PM_CTRL_PME_STATUS))
> +		return false;
> +	/* Clear PME status and disable PME to avoid interrupt flood. */
> +	pmcsr |= PCI_PM_CTRL_PME_STATUS;
> +	if (pmcsr & PCI_PM_CTRL_PME_ENABLE)
> +		pmcsr &= ~PCI_PM_CTRL_PME_ENABLE;
> +	else
> +		ret = false;
> +	pci_write_config_word(pdev, pme_pos + PCI_PM_CTRL, pmcsr);
> +	return ret;
> 
> > +}
> > +
> > +/* @target is suspected to invoke a wakeup event. Return true if it's true */
> 
> Please add full kerneldoc comment.
> 
> > +bool pci_pm_handle_wakeup_event(struct pci_dev *target)
> > +{
> > +	bool ret;
> > +	struct pci_dev *tmp = NULL;
> > +	int domain_nr, bus_start, bus_end;
> > +
> > +	/*
> > +	 * @target could be a bridge or a device.
> > +	 * if target is device, trust the device invokes PME. If target is a
> > +	 * bridge, scan devices under the bridge and only trust device invokes
> > +	 * PME which we can detect
> > +	 **/
> > +	ret = pci_pm_check_wakeup_event(target);
> > +	if (!target->subordinate || (target->is_pcie &&
> > +	    target->pcie_type != PCI_EXP_TYPE_ROOT_PORT &&
> > +	    target->pcie_type != PCI_EXP_TYPE_PCI_BRIDGE)) {
> > +		/* always trust the device invokes PME even we can't detect */
> > +		pm_request_resume(&target->dev);
> 
> I don't think we can return here.  There may be other devices signalling
> PME.
they will invoke another interrupt, right?

> Well, perhaps move the pm_request_resume(&target->dev) to the function above
> along with the conditional?  In that case you could call the function
> pci_pm_wakeup() which would be nicer IMO.
> 
> Also I'm not sure about the conditional.  Namely, I don't think we'll need to
> call this function in the PCIe case except for PCI-to-PCIe bridges, because
> the root port will give us the requester ID of the device the interrupt was for
> if that's an endpoint.  So, perhaps we can assume we scan over non-PCIe
> devices here?
As I said, PCIe device can invoke ACPI GPE if BIOS doesn't enable PCIe native
PME, so sounds not true to only scan non-PCIe devices.

> > +		return true;
> > +	}
> > +
> > +	if (ret)
> > +		pm_request_resume(&target->dev);
> 
> Do we want to do that for bridges?
birdges can send PME too, right? Seems not harmful.

Thanks,
Shaohua
