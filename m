From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/2] PCIe native PME support
Date: Sat, 29 Aug 2009 22:48:00 +0200
Message-ID: <200908292248.01079.rjw__49330.092003993$1251578887$gmane$org@sisk.pl>
References: <1251101495.22288.54.camel@sli10-desk.sh.intel.com>
	<200908260143.58580.rjw@sisk.pl>
	<20090827064907.GB9769@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090827064907.GB9769@sli10-desk.sh.intel.com>
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

Hi,

On Thursday 27 August 2009, Shaohua Li wrote:
...
> > > I have different understanding. The root port can buffer several PME requests from
> > > different devices. If the PME pending bit is set and after the status is clear,
> > > the status bit will get set soon. We can do one request one time for each interrupt,
> > > but seems not necessary. And the loop makes OS more quickly handle PME request without
> > > overflow root port buffer.
> > 
> > OK, but in that case it probably is a good idea to use the PME Pending bit as
> > well.
> Sounds not required. If the pending bit is set, the status bit will get re-set soon after
> it's cleared.

That's exactly why I'd like to check it. :-)

The whole point of the loop in pcie_pme_work_handle() is to avoid being
interrupted again after it's returned, but if the pending bit is set, we _know_
we're going to get interrupted immediately, so the loop should continue in
that case.  Otherwise there's no point in looping at all.

> If pending isn't set, the loop will exit in one circle since the status bit
> is cleared after the circle. Even we missed one PME in the loop, we will get a new interrupt
> soon after PME interrupt is reeabled. So we should be fine here in any case.
> 
> Changes since last post:
> 1. Add kerneldoc for functions/remove config option/add boot option
> 2. Handle the pcie-to-pci bridge case more robust
> 3. don't disable PME report interrupt even spurios interrupt occurs. I saw
> root port receives an extra interrupt when device resumes and sounds harmless.
> 
> 
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
>  drivers/pci/pcie/Kconfig    |    4 
>  drivers/pci/pcie/Makefile   |    2 
>  drivers/pci/pcie/pcie_pme.c |  383 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 389 insertions(+)
> 
> Index: linux/drivers/pci/pcie/Kconfig
> ===================================================================
> --- linux.orig/drivers/pci/pcie/Kconfig	2009-08-27 14:07:35.000000000 +0800
> +++ linux/drivers/pci/pcie/Kconfig	2009-08-27 14:15:41.000000000 +0800
> @@ -46,3 +46,7 @@ config PCIEASPM_DEBUG
>  	help
>  	  This enables PCI Express ASPM debug support. It will add per-device
>  	  interface to control ASPM.
> +
> +config PCIE_PME
> +	def_bool y
> +	depends on PCIEPORTBUS && PM_RUNTIME && EXPERIMENTAL
> Index: linux/drivers/pci/pcie/Makefile
> ===================================================================
> --- linux.orig/drivers/pci/pcie/Makefile	2009-08-27 14:07:35.000000000 +0800
> +++ linux/drivers/pci/pcie/Makefile	2009-08-27 14:30:20.000000000 +0800
> @@ -11,3 +11,5 @@ obj-$(CONFIG_PCIEPORTBUS)	+= pcieportdrv
>  
>  # Build PCI Express AER if needed
>  obj-$(CONFIG_PCIEAER)		+= aer/
> +
> +obj-$(CONFIG_PCIE_PME) += pcie_pme.o
> Index: linux/drivers/pci/pcie/pcie_pme.c
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux/drivers/pci/pcie/pcie_pme.c	2009-08-27 14:15:41.000000000 +0800
> @@ -0,0 +1,383 @@
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
> +/*
> + * It appears a lot of BIOS doesn't implement ACPI _OSC correctly, so let's
> + * force to enable PCIe PME by default
> + */
> +static int force = 1;
> +
> +static int __init pcie_pme_setup(char *str)
> +{
> +	if (!strcmp(str, "off"))
> +		disabled = 1;
> +	else if (!strcmp(str, "strict"))
> +		force = 0;
> +	return 1;
> +}
> +__setup("pcie_pme=", pcie_pme_setup);
> +
> +struct pcie_pme_service_data {
> +	spinlock_t lock;
> +	struct pcie_device *dev;
> +	struct work_struct work;
> +	int in_exiting; /* driver is exiting, don't reenable interrupt */

That should be bool.

> +};
> +
> +/*
> + * pcie_pme_enable_interrupt - enable/disable PCIe PME report interrupt
> + * @pdev: PCI root port
> + * @enable: enable or disable interrupt
> + */
> +static inline void pcie_pme_enable_interrupt(struct pci_dev *pdev,
> +	bool enable)
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
> +/*
> + * pcie_pme_clear_status - clear root port PME report status
> + * @pdev: the root port
> + */
> +static inline void pcie_pme_clear_status(struct pci_dev *pdev)
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
> +/*
> + * pcie_pme_handle_request - handle one PCI device's PME
> + * @root_port: the root port which gets PME report
> + * @requester_id: the device ID of PCI device which invokes PME event
> + */
> +static bool pcie_pme_handle_request(struct pci_dev *root_port,
> +	u16 requester_id)

Do we care about the return value?

> +{
> +	struct pci_dev *target;
> +	bool device_found = false;
> +	u8 busnr = requester_id >> 8, devfn = requester_id & 0xff;
> +
> +	target = pci_get_bus_and_slot(busnr, devfn);
> +
> +	/* the PCIe-to-PCI bridge case, see below comment */
> +	if (!target->is_pcie) {
> +		pci_dev_put(target);
> +		target = NULL;
> +		WARN_ON(devfn); /* devfn should be zero */

Perhaps reset devfn after printing the warning?

> +	}

You shouldn't dereference target before checking it's not NULL.

> +	if (target) {
> +		device_found = pci_pm_handle_wakeup_event_native(target);
> +		pci_dev_put(target);
> +		return device_found;
> +	}
> +
> +	/*
> +	 * PME from PCI devices under a PCIe-to-PCI bridge may be converted to
> +	 * a PCIe in-band PME message. In such case, bridge will assign the
> +	 * message a new request id using bridge's secondary bus numer and
> +	 * device number/function number 0
> +	 */
> +	if (!target && !devfn) {
> +		struct pci_bus *bus;
> +
> +		bus = pci_find_bus(pci_domain_nr(root_port->bus), busnr);
> +		if (bus) {
> +			target = bus->self;
> +			if (!target->is_pcie || target->pcie_type !=
> +					PCI_EXP_TYPE_PCI_BRIDGE)

Please don't break the line like this.  Is it necessary to break it at all?

> +				target = NULL;
> +		}
> +	}
> +
> +	if (target)
> +		device_found = pci_pm_handle_wakeup_event_native(target);
> +	else
> +		printk(KERN_ERR"Can't find device %02d:%d.%d which invokes PME\n",
> +			busnr, PCI_SLOT(devfn), PCI_FUNC(devfn));

If you print the message about the spurious interrupt here, the return value
won't be necessary any more and you'll be able to simplify the next function.

> +
> +	return device_found;
> +}
> +
> +/* pcie_pme_work_handle - work handler for root port PME report interrupt */
> +static void pcie_pme_work_handle(struct work_struct *work)
> +{
> +	struct pcie_pme_service_data *data =
> +			container_of(work, struct pcie_pme_service_data, work);
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

As I said above, I'd check PME_Pending here as well.

> +		/* clear PME, if there are other pending PME, the status will
> +		 * get set again
> +		 */
> +		pcie_pme_clear_status(root_port);
> +		spin_unlock_irqrestore(&data->lock, flags);
> +
> +		if (pcie_pme_handle_request(root_port, rtsta & 0xffff))
> +			spurious = false;
> +	}
> +
> +	if (!data->in_exiting) {

Perhaps

+	if (!data->in_exiting)
+		return;

and save an indentation level?

Also data->in_exiting should be checked under the spinlock, shouldn't it?

> +		spin_lock_irqsave(&data->lock, flags);
> +		/* reenable native PME */
> +		pcie_pme_enable_interrupt(root_port, true);
> +		spin_unlock_irqrestore(&data->lock, flags);
> +	}
> +
> +	if (spurious)
> +		printk(KERN_ERR"Spurious Native PME interrupt %d received\n",
> +			root_port->irq);
> +}
> +
> +/* pcie_pme_irq - interrupt handler for root port PME report interrupt */
> +static irqreturn_t pcie_pme_irq(int irq, void *context)
> +{
> +	int pos;
> +	struct pci_dev *pdev;
> +	u32 rtsta;
> +	struct pcie_pme_service_data *data;
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
> +	pcie_pme_enable_interrupt(pdev, false);
> +	spin_unlock_irqrestore(&data->lock, flags);
> +
> +	queue_work(pm_wq, &data->work);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +#ifdef CONFIG_ACPI
> +/*
> + * pcie_pme_osc_setup - declare OS support PCIe native PME feature to BIOS
> + * @pciedev - pcie device struct for root port
> + */
> +static int pcie_pme_osc_setup(struct pcie_device *pciedev)
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
> +static inline int pcie_pme_osc_setup(struct pcie_device *pciedev)
> +{
> +	return 0;
> +}
> +#endif
> +
> +/*
> + * pcie_pme_probe - initialize PCIe PME report for a root port
> + * @dev - pcie device struct for root port
> + */
> +static int pcie_pme_probe(struct pcie_device *dev)
> +{
> +	struct pci_dev *pdev;
> +	int status;
> +	struct pcie_pme_service_data *data;
> +
> +	if (pcie_pme_osc_setup(dev) && !force)
> +		return -EINVAL;
> +
> +	data = kzalloc(sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +	spin_lock_init(&data->lock);
> +	INIT_WORK(&data->work, pcie_pme_work_handle);
> +	data->dev = dev;
> +	set_service_data(dev, data);
> +
> +	pdev = dev->port;
> +
> +	/* clear pending PME */
> +	pcie_pme_clear_status(pdev);
> +
> +	status = request_irq(dev->irq, pcie_pme_irq, IRQF_SHARED,
> +		"pcie_pme", dev);
> +	if (status) {
> +		kfree(data);
> +		return status;
> +	}
> +
> +	/* enable PME interrupt */
> +	pcie_pme_enable_interrupt(pdev, true);
> +
> +	return 0;
> +}
> +
> +/*
> + * pcie_pme_remove - finialize PCIe PME report for a root port
> + * @dev - pcie device struct for root port
> + */
> +static void pcie_pme_remove(struct pcie_device *dev)
> +{
> +	struct pci_dev *pdev;
> +	unsigned long flags;
> +	struct pcie_pme_service_data *data = get_service_data(dev);
> +
> +	pdev = dev->port;
> +
> +	/* disable PME interrupt */
> +	spin_lock_irqsave(&data->lock, flags);
> +	data->in_exiting = 1;
> +	pcie_pme_enable_interrupt(pdev, false);
> +	spin_unlock_irqrestore(&data->lock, flags);
> +
> +	flush_scheduled_work();
> +	free_irq(dev->irq, dev);
> +
> +	/* clear pending PME */
> +	pcie_pme_clear_status(pdev);
> +
> +	set_service_data(dev, NULL);
> +	kfree(data);
> +}
> +
> +/*
> + * pcie_pme_suspend - suspend PCIe PME report for a root port
> + * @dev - pcie device struct for root port
> + */
> +static int pcie_pme_suspend(struct pcie_device *dev)
> +{
> +	struct pci_dev *pdev;
> +	struct pcie_pme_service_data *data;
> +	unsigned long flags;
> +
> +	pdev = dev->port;
> +	data = get_service_data(dev);
> +
> +	spin_lock_irqsave(&data->lock, flags);
> +	/* disable PME to avoid further interrupt */
> +	pcie_pme_enable_interrupt(pdev, false);
> +
> +	/* clear pending PME */
> +	pcie_pme_clear_status(pdev);
> +	spin_unlock_irqrestore(&data->lock, flags);
> +
> +	return 0;
> +}
> +
> +/*
> + * pcie_pme_resume - resume PCIe PME report for a root port
> + * @dev - pcie device struct for root port
> + */
> +static int pcie_pme_resume(struct pcie_device *dev)
> +{
> +	struct pci_dev *pdev = dev->port;
> +	unsigned long flags;
> +	struct pcie_pme_service_data *data = get_service_data(dev);
> +
> +	spin_lock_irqsave(&data->lock, flags);
> +	pcie_pme_clear_status(pdev);
> +	pcie_pme_enable_interrupt(pdev, true);
> +	spin_unlock_irqrestore(&data->lock, flags);
> +
> +	return 0;
> +}
> +
> +static struct pcie_port_service_driver pcie_pme_driver = {
> +	.name		= "pcie_pme",
> +	.port_type 	= PCIE_RC_PORT,
> +	.service 	= PCIE_PORT_SERVICE_PME,
> +
> +	.probe		= pcie_pme_probe,
> +	.remove		= pcie_pme_remove,
> +	.suspend	= pcie_pme_suspend,
> +	.resume		= pcie_pme_resume,
> +};
> +
> +static int __init pcie_pme_service_init(void)
> +{
> +	if (disabled)
> +		return -EINVAL;
> +	return pcie_port_service_register(&pcie_pme_driver);
> +}
> +
> +static void __exit pcie_pme_service_exit(void)
> +{
> +	pcie_port_service_unregister(&pcie_pme_driver);
> +}
> +
> +module_init(pcie_pme_service_init);
> +module_exit(pcie_pme_service_exit);

Thanks,
Rafael
