From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [RFC 4/5] PCIe native PME detection
Date: Wed, 22 Oct 2008 13:49:07 +0800
Message-ID: <20081022054907.GD15271__6936.05339988625$1224654695$gmane$org@sli10-desk.sh.intel.com>
References: <20080911063037.698427944@sli10-desk.sh.intel.com>
	<20080911063823.312142224@sli10-desk.sh.intel.com>
	<200810192230.02762.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200810192230.02762.rjw@sisk.pl>
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
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "dbrownell@users.sourceforge.net" <dbrownell@users.sourceforge.net>
List-Id: linux-pm@vger.kernel.org

On Mon, Oct 20, 2008 at 04:30:02AM +0800, Rafael J. Wysocki wrote:
> On Thursday, 11 of September 2008, Shaohua Li wrote:
> > PCIe defines a native PME detection mechanism. When a PCIe endpoint invokes PME, PCIe root port has a set of regisets to detect the endpoint's bus/device/function number and root port will send out interrupt when PME is received. See PCIe spec for detail. This patch implements this feature.
> 
> Any details of the implementation?
> 
> > ---
> >  drivers/pci/pcie/Kconfig  |    7 +
> >  drivers/pci/pcie/Makefile |    2
> >  drivers/pci/pcie/npme.c   |  312 ++++++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/pci_regs.h  |    1
> >  4 files changed, 322 insertions(+)
> >
> > Index: linux/drivers/pci/pcie/Kconfig
> > ===================================================================
> > --- linux.orig/drivers/pci/pcie/Kconfig       2008-09-11 11:27:44.000000000 +0800
> > +++ linux/drivers/pci/pcie/Kconfig    2008-09-11 11:28:39.000000000 +0800
> > @@ -46,3 +46,10 @@ config PCIEASPM_DEBUG
> >       help
> >         This enables PCI Express ASPM debug support. It will add per-device
> >         interface to control ASPM.
> > +
> > +config PCIENPME
> > +     bool "PCIE Native PME support(Experimental)"
> > +     depends on PCIEPORTBUS && EXPERIMENTAL
> > +     help
> > +       This enables PCI Express Native PME Reporting.
> > +
> > Index: linux/drivers/pci/pcie/Makefile
> > ===================================================================
> > --- linux.orig/drivers/pci/pcie/Makefile      2008-09-11 11:27:44.000000000 +0800
> > +++ linux/drivers/pci/pcie/Makefile   2008-09-11 11:28:39.000000000 +0800
> > @@ -11,3 +11,5 @@ obj-$(CONFIG_PCIEPORTBUS)   += pcieportdrv
> >
> >  # Build PCI Express AER if needed
> >  obj-$(CONFIG_PCIEAER)                += aer/
> > +
> > +obj-$(CONFIG_PCIENPME) += npme.o
> > Index: linux/drivers/pci/pcie/npme.c
> > ===================================================================
> > --- /dev/null 1970-01-01 00:00:00.000000000 +0000
> > +++ linux/drivers/pci/pcie/npme.c     2008-09-11 11:30:26.000000000 +0800
> > @@ -0,0 +1,312 @@
> > +/*
> > + * PCIE Native PME support
> > + *
> > + * Copyright (C) 2007 - 2008 Intel Corp
> > + *  Shaohua Li <shaohua.li@intel.com>
> > + *
> > + * This file is subject to the terms and conditions of the GNU General Public
> > + * License.  See the file "COPYING" in the main directory of this archive
> > + * for more details.
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/pci.h>
> > +#include <linux/kernel.h>
> > +#include <linux/errno.h>
> > +#include <linux/init.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/device.h>
> > +#include <linux/pcieport_if.h>
> > +#include <linux/acpi.h>
> > +#include <linux/pci-acpi.h>
> > +
> > +static int disabled;
> > +module_param(disabled, bool, 0);
> > +static int force = 1;
> > +module_param(force, bool, 0);
> > +
> > +static struct pcie_port_service_id npme_id[] = {
> > +     {
> > +     .vendor         = PCI_ANY_ID,
> > +     .device         = PCI_ANY_ID,
> > +     .port_type      = PCIE_RC_PORT,
> > +     .service_type   = PCIE_PORT_SERVICE_PME,
> > +     },
> > +     { /* end: all zeroes */ }
> > +};
> > +
> > +struct npme_data {
> > +     spinlock_t lock;
> > +     struct pcie_device *dev;
> > +     struct work_struct work;
> > +     u16 bdf; /* device which invokes PME */
> > +     int exit;
> > +};
> > +
> > +static inline void npme_enable_pme(struct pci_dev *pdev, bool enable)
> 
> This works in analogy with pci_pme_active(), so it would seem reasonable to
> call it npme_pme_active(), although pcie_npme_active() would be even better
> IMO.
ok, I'll change the name of the function and blow as you suggested.
  
> > +{
> > +     int pos;
> > +     u16 rtctl;
> > +
> > +     pos = pci_find_capability(pdev, PCI_CAP_ID_EXP);
> > +
> 
> The result of this call seems to be a good candidate for caching in
> 'struct pci_dev'.
this isn't frequently called, doesn't need cache.

> > +{
> > +     int pos;
> > +     u32 rtsta;
> > +
> > +     pos = pci_find_capability(pdev, PCI_CAP_ID_EXP);
> 
> Check if we found it?
this is a pcie root port, so it always has the PCI_CAP_ID_EXP 

> > +static bool npme_pme_target(struct pci_dev *target)
> > +{
> > +     bool ret = false;
> > +     if (target->dev.bus->pm && target->dev.bus->pm->base.wakeup_event)
> > +             ret = target->dev.bus->pm->base.wakeup_event(&target->dev);
> > +     return ret;
> > +}
> 
> This apparently only calls the device bus type's wakeup_event() method, so
> perhaps give it a better name (pcie_npme_bus_callback() maybe?).
ok 
> > +
> > +static void npme_work_handle(struct work_struct *work)
> > +{
> > +     struct npme_data *data = container_of(work, struct npme_data, work);
> 
> Is 'data' guaranteed to be not NULL?
should be
> > +     struct pcie_device *dev = data->dev;
> > +     unsigned long flags;
> > +     struct pci_dev *target;
> > +     bool has_dev = false;
> > +
> > +     target = pci_get_bus_and_slot(data->bdf >> 8, data->bdf & 0xff);
> > +     /* PCIe-PCI bridge might change bdf to (secondary bus numer, 0, 0) */
> > +     if (!target && (data->bdf & 0xff) == 0) {
> > +             struct pci_bus *bus;
> > +
> > +             bus = pci_find_bus(pci_domain_nr(dev->port->bus),
> > +                     data->bdf >> 8);
> 
> Is 'dev' guaranteed to be not NULL?
should be
> > +             if (bus) {
> > +                     target = bus->self;
> > +                     if (!target->is_pcie || target->pcie_type !=
> > +                                     PCI_EXP_TYPE_PCI_BRIDGE)
> > +                             target = NULL;
> > +             }
> > +             if (target)
> > +                     pci_dev_get(target);
> > +     }
> > +
> > +     if (target)
> > +             has_dev = npme_pme_target(target);
> 
> What's the meaning of 'has_dev'?  It seems to be the result of the bus type
> callback.
maybe I should rename it as found_dev
> > +     else
> > +             printk(KERN_ERR"Can't find device %02d:%d.%d which invokes PME\n",
> > +                     data->bdf >> 8, PCI_SLOT(data->bdf),
> > +                     PCI_FUNC(data->bdf));
> > +
> > +     spin_lock_irqsave(&data->lock, flags);
> > +     /* clear pending PME */
> > +     npme_clear_pme(dev->port);
> > +     /* reenable native PME */
> > +     if (!data->exit)
> > +             npme_enable_pme(dev->port, true);
> 
> What does data->exit different from zero mean at this point?
the driver is exitting. I'll rename it

> > +static irqreturn_t npme_irq(int irq, void *context)
> > +{
> > +     int pos;
> > +     struct pci_dev *pdev;
> > +     u32 rtsta;
> > +     struct npme_data *data;
> > +     unsigned long flags;
> > +
> > +     pdev = ((struct pcie_device *)context)->port;
> > +     data = get_service_data((struct pcie_device *)context);
> > +
> > +     pos = pci_find_capability(pdev, PCI_CAP_ID_EXP);
> > +
> > +     spin_lock_irqsave(&data->lock, flags);
> > +     pci_read_config_dword(pdev, pos + PCI_EXP_RTSTA, &rtsta);
> > +     if (!(rtsta & PCI_EXP_RTSTA_PME)) {
> > +             spin_unlock_irqrestore(&data->lock, flags);
> > +             return IRQ_NONE;
> > +     }
> > +
> > +     data->bdf = (u16)rtsta;
> 
> Hm, couldn't we use pci_read_config_word() above instead?
but it actually is a dword. 
> > +
> > +     /* disable PME to avoid interrupt flood */
> > +     npme_enable_pme(pdev, false);
> > +     spin_unlock_irqrestore(&data->lock, flags);
> > +
> > +     schedule_work(&data->work);
> 
> I'm not sure if the workqueue is exactly suitable for that.  Have you
> considered using anything else?
we will call driver's .wakeup_event(), which might call into .resume() from device_receive_wakeup_event()
so workqueue is best fit here.
> > +     /* clear pending PME */
> > +     npme_clear_pme(pdev);
> > +
> > +     status = request_irq(dev->irq, npme_irq, IRQF_SHARED, "npme", dev);
> 
> Who's going to set dev->irq?
the pcie port driver.
> > +static int npme_suspend(struct pcie_device *dev, pm_message_t state)
> > +{
> > +     struct pci_dev *pdev;
> > +     struct npme_data *data;
> > +     unsigned long flags;
> > +
> > +     pdev = dev->port;
> > +     data = get_service_data(dev);
> > +
> > +     spin_lock_irqsave(&data->lock, flags);
> > +     /* disable PME to avoid further interrupt */
> > +     npme_enable_pme(pdev, false);
> 
> Won't this cause a regression on systems that use the native PME mechanism
> for wake-up (I have one of these)?
good point. currently I don't know if a npme interrupt can wakeup system from
suspend/resume, because npme interrupt looks like usual device interrupt.
Need more invistigation here.

Thanks,
Shaohua
