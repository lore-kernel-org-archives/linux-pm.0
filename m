From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/2] PCIe native PME support
Date: Tue, 25 Aug 2009 00:13:32 +0200
Message-ID: <200908250013.32462.rjw__1085.83087935603$1251152260$gmane$org@sisk.pl>
References: <1251101495.22288.54.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1251101495.22288.54.camel@sli10-desk.sh.intel.com>
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

On Monday 24 August 2009, Shaohua Li wrote:
> 
> PCIe defines a native PME detection mechanism. When a PCIe endpoint
> invokes PME, PCIe root port has a set of regisets to detect the
> endpoint's bus/device/function number and root port will send out
> interrupt when PME is received. After getting interrupt, OS can identify
> which device invokes PME according to such information. See PCIe
> spec for detail. This patch implements this feature.
> 
> Signed-off-by: Shaohua Li <shaohua.li@intel.com>
> ---
>  drivers/pci/pcie/Kconfig     |    8 +
>  drivers/pci/pcie/Makefile    |    2 
>  drivers/pci/pcie/pcie_npme.c |  327 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 337 insertions(+)
> 
> Index: linux/drivers/pci/pcie/Kconfig
> ===================================================================
> --- linux.orig/drivers/pci/pcie/Kconfig	2009-08-24 15:38:46.000000000 +0800
> +++ linux/drivers/pci/pcie/Kconfig	2009-08-24 15:47:09.000000000 +0800
> @@ -46,3 +46,11 @@ config PCIEASPM_DEBUG
>  	help
>  	  This enables PCI Express ASPM debug support. It will add per-device
>  	  interface to control ASPM.
> +
> +config PCIE_NPME
> +	bool "PCIe Native PME reporint(Experimental)"
> +	depends on PCIEPORTBUS && PM_RUNTIME && EXPERIMENTAL
> +	help
> +	  This enables PCI Express Native PME Reporting. When device invokes
> +	  PME, root port or root complex event collector can report the PME
> +	  events to OS.

Well, I think we can just drop the CONFIG option and make the whole thing
depend on PM_RUNTIME && PCIEPORTBUS.  So make it

+config PCIE_PME
+	def_bool y
+	depends on PCIEPORTBUS && PM_RUNTIME && EXPERIMENTAL

Ah, please drop the 'N' as I've just done.  It doesn't carry any substantial
information and is confusing IMO.  Please also drop it from the function names
below.

> Index: linux/drivers/pci/pcie/Makefile
> ===================================================================
> --- linux.orig/drivers/pci/pcie/Makefile	2009-08-24 15:38:46.000000000 +0800
> +++ linux/drivers/pci/pcie/Makefile	2009-08-24 15:47:09.000000000 +0800
> @@ -11,3 +11,5 @@ obj-$(CONFIG_PCIEPORTBUS)	+= pcieportdrv
>  
>  # Build PCI Express AER if needed
>  obj-$(CONFIG_PCIEAER)		+= aer/
> +
> +obj-$(CONFIG_PCIE_NPME) += pcie_npme.o

Call that pcie_pme.o

> Index: linux/drivers/pci/pcie/pcie_npme.c

pcie_pme.c, please.

> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux/drivers/pci/pcie/pcie_npme.c	2009-08-24 15:47:09.000000000 +0800
> @@ -0,0 +1,327 @@
> +/*
> + * PCIe Native PME support
> + *
> + * Copyright (C) 2007 - 2009 Intel Corp
> + *  Shaohua Li <shaohua.li@intel.com>
> + *
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/kernel.h>
> +#include <linux/errno.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/device.h>
> +#include <linux/pcieport_if.h>
> +#include <linux/acpi.h>
> +#include <linux/pci-acpi.h>
> +#include <linux/pm_runtime.h>
> +#include "../pci.h"
> +
> +#define PCI_EXP_RTSTA_PME 0x10000 /* PME status */
> +
> +static int disabled;
> +module_param(disabled, bool, 0);
> +static int force = 1;
> +module_param(force, bool, 0);

Why would anyone want to force it or disable it at this level?

> +
> +struct pcie_npme_service_data {
> +	spinlock_t lock;
> +	struct pcie_device *dev;
> +	struct work_struct work;
> +	int in_exiting; /* driver is exiting, don't reenable interrupt */
> +};
> +

Please add kerneldoc comments to all new functions

> +static inline void pcie_npme_enable_interrupt(struct pci_dev *pdev, bool enable)
> +{
> +	int pos;
> +	u16 rtctl;
> +
> +	pos = pci_find_capability(pdev, PCI_CAP_ID_EXP);
> +
> +	pci_read_config_word(pdev, pos + PCI_EXP_RTCTL, &rtctl);
> +	if (enable)
> +		rtctl |= PCI_EXP_RTCTL_PMEIE;
> +	else
> +		rtctl &= ~PCI_EXP_RTCTL_PMEIE;
> +	pci_write_config_word(pdev, pos + PCI_EXP_RTCTL, rtctl);
> +}
> +
> +static inline void pcie_npme_clear_status(struct pci_dev *pdev)
> +{
> +	int pos;
> +	u32 rtsta;
> +
> +	pos = pci_find_capability(pdev, PCI_CAP_ID_EXP);
> +
> +	pci_read_config_dword(pdev, pos + PCI_EXP_RTSTA, &rtsta);
> +	rtsta |= PCI_EXP_RTSTA_PME;
> +	pci_write_config_dword(pdev, pos + PCI_EXP_RTSTA, rtsta);
> +}
> +
> +static bool pcie_npme_handle_request(struct pci_dev *root_port, u16 request_id)

requester_id would be better.

> +{
> +	struct pci_dev *target;
> +	bool device_found = false;
> +	u8 busnr = request_id >> 8, devfn = request_id & 0xff;
> +
> +	target = pci_get_bus_and_slot(busnr, devfn);
> +	/*
> +	 * PME from PCI devices under a PCIe-to-PCI bridge may be converted to
> +	 * a PCIe in-band PME message. In such case, bridge will assign the
> +	 * message a new request id using bridge's secondary bus numer and
> +	 * device number/function number 0
> +	 */
> +	if (!target && devfn == 0) {

+	if (!target && !devfn) {

Or better

+	if (target) {
+		ret = pci_pm_wakeup(target);
+		pci_dev_put(target);
+		return ret;
+	}

BTW, what we do if target is NULL, but devfn is nonzero?

> +		struct pci_bus *bus;
> +
> +		bus = pci_find_bus(pci_domain_nr(root_port->bus), busnr);
> +		if (bus) {
> +			target = bus->self;
> +			if (!target->is_pcie || target->pcie_type !=
> +					PCI_EXP_TYPE_PCI_BRIDGE)

+			if (!target->is_pcie
+			    || target->pcie_type != PCI_EXP_TYPE_PCI_BRIDGE)

> +				target = NULL;
> +		}
> +		if (target)
> +			pci_dev_get(target);

Now we don't need to do the _get().

> +	}
> +
> +	if (target)
> +		device_found = pci_pm_handle_wakeup_event(target);

Now we call the function that searches over the hierarchy below the bridge.

> +	else
> +		printk(KERN_ERR"Can't find device %02d:%d.%d which invokes PME\n",
> +			busnr, PCI_SLOT(devfn), PCI_FUNC(devfn));
> +
> +	if (target)
> +		pci_dev_put(target);

The two lines above aren't necessary any more.

> +
> +	return device_found;
> +}
> +
> +static void pcie_npme_work_handle(struct work_struct *work)
> +{
> +	struct pcie_npme_service_data *data =
> +			container_of(work, struct pcie_npme_service_data, work);
> +	struct pci_dev *root_port = data->dev->port;
> +	unsigned long flags;
> +	bool spurious = true;
> +	u32 rtsta;
> +	int pos;
> +
> +	pos = pci_find_capability(root_port, PCI_CAP_ID_EXP);
> +	while (1) {
> +		spin_lock_irqsave(&data->lock, flags);
> +		pci_read_config_dword(root_port, pos + PCI_EXP_RTSTA, &rtsta);
> +
> +		if (!(rtsta & PCI_EXP_RTSTA_PME)) {
> +			spin_unlock_irqrestore(&data->lock, flags);
> +			break;
> +		}
> +
> +		/* clear PME, if there are other pending PME, the status will
> +		 * get set again
> +		 */
> +		pcie_npme_clear_status(root_port);
> +		spin_unlock_irqrestore(&data->lock, flags);
> +
> +		if (pcie_npme_handle_request(root_port, rtsta & 0xffff))
> +			spurious = false;
> +	}

It doesn't work like this if my reading of the spec is correct.  Namely,
we should get a separate interrupt for each device that generated a PME,
so it's only necessary to clear the status without looping.

Moreover, I think we should do something like this:

* interrrupt arrives
* disable interrupt
* read the requester ID, schedule the service
* clear the status
* enable interrupt

which now will allow us to get the interrupt for another device, if any.
The spec seems to require devices not to generate PME messages continously,
but only if they are not handled within a "reasonable amount of time" (original
wording), so we should be safe from interrupt flooding.

Note that we need to create a separate work_struct for each interrupt in this
case, though.

> +
> +	if (!spurious && !data->in_exiting) {
> +		spin_lock_irqsave(&data->lock, flags);
> +		/* reenable native PME */
> +		pcie_npme_enable_interrupt(root_port, true);
> +		spin_unlock_irqrestore(&data->lock, flags);
> +	}
> +
> +	if (spurious)
> +		printk(KERN_ERR"Spurious Native PME interrupt %d received\n",
> +			root_port->irq);
> +}
> +
> +static irqreturn_t pcie_npme_irq(int irq, void *context)
> +{
> +	int pos;
> +	struct pci_dev *pdev;
> +	u32 rtsta;
> +	struct pcie_npme_service_data *data;
> +	unsigned long flags;
> +
> +	pdev = ((struct pcie_device *)context)->port;
> +	data = get_service_data((struct pcie_device *)context);
> +
> +	pos = pci_find_capability(pdev, PCI_CAP_ID_EXP);
> +
> +	spin_lock_irqsave(&data->lock, flags);
> +	pci_read_config_dword(pdev, pos + PCI_EXP_RTSTA, &rtsta);
> +
> +	if (!(rtsta & PCI_EXP_RTSTA_PME)) {
> +		spin_unlock_irqrestore(&data->lock, flags);
> +		return IRQ_NONE;
> +	}
> +
> +	/* disable PME to avoid interrupt flood */
> +	pcie_npme_enable_interrupt(pdev, false);
> +	spin_unlock_irqrestore(&data->lock, flags);
> +
> +	queue_work(pm_wq, &data->work);

IMO, we should read the requester ID here and put it into the work struct as
per the comment above.

Also, since in principle the interrupt may be shared with Hot-Plug Events,
we should be careful about returning IRQ_HANDLED.  Perhaps we should at least
check if the requester ID is nonzero?

> +
> +	return IRQ_HANDLED;
> +}
> +
> +#ifdef CONFIG_ACPI
> +static int pcie_npme_osc_setup(struct pcie_device *pciedev)
> +{
> +	acpi_status status = AE_NOT_FOUND;
> +	struct pci_dev *pdev = pciedev->port;
> +	acpi_handle handle = DEVICE_ACPI_HANDLE(&pdev->dev);
> +
> +	if (!handle)
> +		return -EINVAL;
> +	status = acpi_pci_osc_control_set(handle,
> +			OSC_PCI_EXPRESS_PME_CONTROL |
> +			OSC_PCI_EXPRESS_CAP_STRUCTURE_CONTROL);
> +
> +	if (ACPI_FAILURE(status)) {
> +		printk(KERN_DEBUG "Native PME service couldn't init device "
> +			"%s - %s\n", dev_name(&pciedev->device),
> +			(status == AE_SUPPORT || status == AE_NOT_FOUND) ?
> +			"no _OSC support" : "Run ACPI _OSC fails");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +#else
> +static inline int pcie_npme_osc_setup(struct pcie_device *pciedev)
> +{
> +	return 0;
> +}
> +#endif
> +
> +static int __devinit pcie_npme_probe(struct pcie_device *dev)
> +{
> +	struct pci_dev *pdev;
> +	int status;
> +	struct pcie_npme_service_data *data;
> +
> +	if (pcie_npme_osc_setup(dev) && !force)
> +		return -EINVAL;
> +
> +	data = kzalloc(sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +	spin_lock_init(&data->lock);
> +	INIT_WORK(&data->work, pcie_npme_work_handle);
> +	data->dev = dev;
> +	set_service_data(dev, data);
> +
> +	pdev = dev->port;
> +
> +	/* clear pending PME */
> +	pcie_npme_clear_status(pdev);
> +
> +	status = request_irq(dev->irq, pcie_npme_irq, IRQF_SHARED,
> +		"pcie_npme", dev);
> +	if (status) {
> +		kfree(data);
> +		return status;
> +	}
> +
> +	/* enable PME interrupt */
> +	pcie_npme_enable_interrupt(pdev, true);
> +
> +	return 0;
> +}
> +
> +static void pcie_npme_remove(struct pcie_device *dev)
> +{
> +	struct pci_dev *pdev;
> +	unsigned long flags;
> +	struct pcie_npme_service_data *data = get_service_data(dev);
> +
> +	pdev = dev->port;
> +
> +	/* disable PME interrupt */
> +	spin_lock_irqsave(&data->lock, flags);
> +	data->in_exiting = 1;
> +	pcie_npme_enable_interrupt(pdev, false);
> +	spin_unlock_irqrestore(&data->lock, flags);
> +
> +	flush_scheduled_work();
> +	free_irq(dev->irq, dev);
> +
> +	/* clear pending PME */
> +	pcie_npme_clear_status(pdev);
> +
> +	set_service_data(dev, NULL);
> +	kfree(data);
> +}
> +
> +static int pcie_npme_suspend(struct pcie_device *dev)
> +{
> +	struct pci_dev *pdev;
> +	struct pcie_npme_service_data *data;
> +	unsigned long flags;
> +
> +	pdev = dev->port;
> +	data = get_service_data(dev);
> +
> +	spin_lock_irqsave(&data->lock, flags);
> +	/* disable PME to avoid further interrupt */
> +	pcie_npme_enable_interrupt(pdev, false);
> +
> +	/* clear pending PME */
> +	pcie_npme_clear_status(pdev);
> +	spin_unlock_irqrestore(&data->lock, flags);
> +
> +	return 0;
> +}
> +
> +static int pcie_npme_resume(struct pcie_device *dev)
> +{
> +	struct pci_dev *pdev = dev->port;
> +	unsigned long flags;
> +	struct pcie_npme_service_data *data = get_service_data(dev);
> +
> +	spin_lock_irqsave(&data->lock, flags);
> +	pcie_npme_clear_status(pdev);
> +	pcie_npme_enable_interrupt(pdev, true);
> +	spin_unlock_irqrestore(&data->lock, flags);
> +
> +	return 0;
> +}
> +
> +static struct pcie_port_service_driver pcie_npme_driver = {
> +	.name		= "pcie_npme",
> +	.port_type 	= PCIE_RC_PORT,
> +	.service 	= PCIE_PORT_SERVICE_PME,
> +
> +	.probe		= pcie_npme_probe,
> +	.remove		= pcie_npme_remove,
> +	.suspend	= pcie_npme_suspend,
> +	.resume		= pcie_npme_resume,
> +};
> +
> +static int __init pcie_npme_service_init(void)
> +{
> +	if (disabled)
> +		return -EINVAL;
> +	return pcie_port_service_register(&pcie_npme_driver);
> +}
> +
> +static void __exit pcie_npme_service_exit(void)
> +{
> +	pcie_port_service_unregister(&pcie_npme_driver);
> +}
> +
> +module_init(pcie_npme_service_init);
> +module_exit(pcie_npme_service_exit);
> +
> +MODULE_AUTHOR("Shaohua Li<shaohua.li@intel.com>");
> +MODULE_LICENSE("GPL");

I'm not entirely sure if that should be a module.  Perhaps it sholdn't.

Thanks,
Rafael
