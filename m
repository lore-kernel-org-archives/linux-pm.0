From: shaohua.li@intel.com
Subject: [RFC 4/5] PCIe native PME detection
Date: Mon, 08 Sep 2008 17:19:30 +0800
Message-ID: <20080908092305.546278414__42774.4805733257$1220866407$gmane$org@sli10-desk.sh.intel.com>
References: <20080908091926.785882370@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=pcie-native-pme.patch
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org, linux-acpi@vger.kernel.org
Cc: dbrownell@users.sourceforge.net
List-Id: linux-pm@vger.kernel.org

This implements PCIe native PME detection.

---
 drivers/pci/pcie/Kconfig  |    7 
 drivers/pci/pcie/Makefile |    2 
 drivers/pci/pcie/npme.c   |  341 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci_regs.h  |    1 
 4 files changed, 351 insertions(+)

Index: linux/drivers/pci/pcie/Kconfig
===================================================================
--- linux.orig/drivers/pci/pcie/Kconfig	2008-09-08 13:55:55.000000000 +0800
+++ linux/drivers/pci/pcie/Kconfig	2008-09-08 14:26:13.000000000 +0800
@@ -46,3 +46,10 @@ config PCIEASPM_DEBUG
 	help
 	  This enables PCI Express ASPM debug support. It will add per-device
 	  interface to control ASPM.
+
+config PCIENPME
+	bool "PCIE Native PME support(Experimental)"
+	depends on PCIEPORTBUS && EXPERIMENTAL
+	help
+	  This enables PCI Express Native PME Reporting.
+
Index: linux/drivers/pci/pcie/Makefile
===================================================================
--- linux.orig/drivers/pci/pcie/Makefile	2008-09-08 13:55:55.000000000 +0800
+++ linux/drivers/pci/pcie/Makefile	2008-09-08 14:26:13.000000000 +0800
@@ -11,3 +11,5 @@ obj-$(CONFIG_PCIEPORTBUS)	+= pcieportdrv
 
 # Build PCI Express AER if needed
 obj-$(CONFIG_PCIEAER)		+= aer/
+
+obj-$(CONFIG_PCIENPME) += npme.o
Index: linux/drivers/pci/pcie/npme.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux/drivers/pci/pcie/npme.c	2008-09-08 14:26:13.000000000 +0800
@@ -0,0 +1,341 @@
+/*
+ * PCIE Native PME support
+ *
+ * Copyright (C) 2007 - 2008 Intel Corp
+ *  Shaohua Li <shaohua.li@intel.com>
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/device.h>
+#include <linux/pcieport_if.h>
+#include <linux/acpi.h>
+#include <linux/pci-acpi.h>
+
+static int disabled;
+module_param(disabled, bool, 0);
+static int force = 1;
+module_param(force, bool, 0);
+
+static struct pcie_port_service_id npme_id[] = {
+	{
+	.vendor 	= PCI_ANY_ID,
+	.device 	= PCI_ANY_ID,
+	.port_type 	= PCIE_RC_PORT,
+	.service_type 	= PCIE_PORT_SERVICE_PME,
+	},
+	{ /* end: all zeroes */ }
+};
+
+struct npme_data {
+	spinlock_t lock;
+	struct pcie_device *dev;
+	struct work_struct work;
+	u16 bdf; /* device which invokes PME */
+	int exit;
+};
+
+static inline void npme_set_pme(struct pci_dev *pdev, int enable)
+{
+	int pos;
+	u16 reg16;
+
+	pos = pci_find_capability(pdev, PCI_CAP_ID_EXP);
+
+	pci_read_config_word(pdev, pos + PCI_EXP_RTCTL, &reg16);
+	if (!enable)
+		reg16 &= ~PCI_EXP_RTCTL_PMEIE;
+	else
+		reg16 |= PCI_EXP_RTCTL_PMEIE;
+	pci_write_config_word(pdev, pos + PCI_EXP_RTCTL, reg16);
+}
+
+static inline void npme_clear_pme(struct pci_dev *pdev)
+{
+	int pos;
+	u32 reg32;
+
+	pos = pci_find_capability(pdev, PCI_CAP_ID_EXP);
+
+	pci_read_config_dword(pdev, pos + PCI_EXP_RTSTA, &reg32);
+	reg32 |= PCI_EXP_RTSTA_PME;
+	pci_write_config_dword(pdev, pos + PCI_EXP_RTSTA, reg32);
+}
+
+static int npme_pme_target_one(struct pci_dev *target)
+{
+	int ret = -ENODEV;
+	if (target->dev.bus->pm && target->dev.bus->pm->base.wakeup_event)
+		ret = target->dev.bus->pm->base.wakeup_event(&target->dev);
+	if (!ret)
+		device_receive_wakeup_event(&target->dev);
+	return ret;
+}
+
+static int npme_pme_target(struct pci_dev *target)
+{
+	int ret;
+	struct pci_dev *tmp = NULL;
+	int domain_nr, bus_start, bus_end;
+
+	ret = npme_pme_target_one(target);
+	/*
+	 * Because PCIe-PCI bridge or pci root port can take ownership, legacy
+	 * devices under the bridges might share a BDF. The BDF can be root
+	 * port's BDF or (PCIe-PCI bridge's secondary bus number, 0, 0)
+	 */
+	if (!target->subordinate || !target->is_pcie ||
+		(target->pcie_type != PCI_EXP_TYPE_ROOT_PORT &&
+		target->pcie_type != PCI_EXP_TYPE_PCI_BRIDGE))
+		return ret;
+
+	/* check all legacy devices under bridge */
+	domain_nr = pci_domain_nr(target->bus);
+	bus_start = target->subordinate->secondary;
+	bus_end = target->subordinate->subordinate;
+	while ((tmp = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, tmp)) != NULL) {
+		if (!tmp->is_pcie && pci_domain_nr(tmp->bus) == domain_nr &&
+		   tmp->bus->number >= bus_start &&
+		   tmp->bus->number <= bus_end)
+			ret &= npme_pme_target_one(tmp);
+	}
+	if (ret)
+		ret = -ENODEV;
+	return ret;
+}
+
+static void npme_work_handle(struct work_struct *work)
+{
+	struct npme_data *data = container_of(work, struct npme_data, work);
+	struct pcie_device *dev = data->dev;
+	unsigned long flags;
+	struct pci_dev *target;
+	int ret = -ENODEV;
+
+	target = pci_get_bus_and_slot(data->bdf >> 8, data->bdf & 0xff);
+	/* PCIe-PCI bridge might change bdf to (secondary bus numer, 0, 0) */
+	if (!target && (data->bdf & 0xff) == 0) {
+		struct pci_bus *bus;
+
+		bus = pci_find_bus(pci_domain_nr(dev->port->bus),
+			data->bdf >> 8);
+		if (bus) {
+			target = bus->self;
+			if (!target->is_pcie || target->pcie_type !=
+					PCI_EXP_TYPE_PCI_BRIDGE)
+				target = NULL;
+		}
+		if (target)
+			pci_dev_get(target);
+	}
+
+	if (target)
+		ret = npme_pme_target(target);
+	else
+		printk(KERN_ERR"Can't find device %02d:%d.%d which invokes PME\n",
+			data->bdf >> 8, PCI_SLOT(data->bdf), PCI_FUNC(data->bdf));
+
+	spin_lock_irqsave(&data->lock, flags);
+	/* clear pending PME */
+	npme_clear_pme(dev->port);
+	/* reenable native PME */
+	if (!data->exit)
+		npme_set_pme(dev->port, 1);
+
+	spin_unlock_irqrestore(&data->lock, flags);
+
+	if (ret)
+		printk(KERN_ERR"Spurious Native PME interrupt %d received\n", dev->irq);
+
+	if (target)
+		pci_dev_put(target);
+}
+
+static irqreturn_t npme_irq(int irq, void *context)
+{
+	int pos;
+	struct pci_dev *pdev;
+	u32 reg32;
+	struct npme_data *data;
+	unsigned long flags;
+
+	pdev = ((struct pcie_device *)context)->port;
+	data = get_service_data((struct pcie_device *)context);
+
+	pos = pci_find_capability(pdev, PCI_CAP_ID_EXP);
+
+	spin_lock_irqsave(&data->lock, flags);
+	pci_read_config_dword(pdev, pos + PCI_EXP_RTSTA, &reg32);
+	if (!(reg32 & PCI_EXP_RTSTA_PME)) {
+		spin_unlock_irqrestore(&data->lock, flags);
+		return IRQ_NONE;
+	}
+
+	data->bdf = reg32;
+
+	/* disable PME to avoid interrupt flood */
+	npme_set_pme(pdev, 0);
+	spin_unlock_irqrestore(&data->lock, flags);
+
+	schedule_work(&data->work);
+
+	return IRQ_HANDLED;
+}
+
+#ifdef CONFIG_ACPI
+static int npme_osc_setup(struct pcie_device *pciedev)
+{
+	acpi_status status = AE_NOT_FOUND;
+	struct pci_dev *pdev = pciedev->port;
+	acpi_handle handle = DEVICE_ACPI_HANDLE(&pdev->dev);
+
+	if (!handle)
+		return -EINVAL;
+	pcie_osc_support_set(OSC_EXT_PCI_CONFIG_SUPPORT);
+	status = pci_osc_control_set(handle,
+			OSC_PCI_EXPRESS_NATIVE_HP_CONTROL |
+			OSC_PCI_EXPRESS_CAP_STRUCTURE_CONTROL);
+
+	if (ACPI_FAILURE(status)) {
+		printk(KERN_DEBUG "Native PME service couldn't init device "
+			"%s - %s\n", pciedev->device.bus_id,
+			(status == AE_SUPPORT || status == AE_NOT_FOUND) ?
+			"no _OSC support" : "Run ACPI _OSC fails");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+#else
+#define npme_osc_setup(e) (0)
+#endif
+
+static int __devinit npme_probe (struct pcie_device *dev,
+				const struct pcie_port_service_id *id )
+{
+	struct pci_dev *pdev;
+	int status;
+	struct npme_data *data;
+
+	if (npme_osc_setup(dev) && !force)
+		return -EINVAL;
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+	spin_lock_init(&data->lock);
+	INIT_WORK(&data->work, npme_work_handle);
+	data->dev = dev;
+
+	pdev = dev->port;
+
+	/* clear pending PME */
+	npme_clear_pme(pdev);
+
+	status = request_irq(dev->irq, npme_irq, IRQF_SHARED, "npme", dev);
+	if (status) {
+		kfree(data);
+		return status;
+	}
+
+	/* enable PME interrupt */
+	npme_set_pme(pdev, 1);
+
+	set_service_data(dev, data);
+	return 0;
+}
+
+static void npme_remove(struct pcie_device *dev)
+{
+	struct pci_dev *pdev;
+	unsigned long flags;
+	struct npme_data *data = get_service_data(dev);
+
+	pdev = dev->port;
+
+	/* disable PME interrupt */
+	spin_lock_irqsave(&data->lock, flags);
+	data->exit = 1;
+	npme_set_pme(pdev, 0);
+	spin_unlock_irqrestore(&data->lock, flags);
+
+	flush_scheduled_work();
+	free_irq(dev->irq, dev);
+
+	/* clear pending PME */
+	npme_clear_pme(pdev);
+
+	set_service_data(dev, NULL);
+	kfree(data);
+}
+
+static int npme_suspend(struct pcie_device *dev, pm_message_t state)
+{
+	struct pci_dev *pdev;
+	struct npme_data *data;
+	unsigned long flags;
+
+	pdev = dev->port;
+	data = get_service_data(dev);
+
+	spin_lock_irqsave(&data->lock, flags);
+	/* disable PME to avoid further interrupt */
+	npme_set_pme(pdev, 0);
+
+	/* clear pending PME */
+	npme_clear_pme(pdev);
+	spin_unlock_irqrestore(&data->lock, flags);
+
+	return 0;
+}
+
+static int npme_resume(struct pcie_device *dev)
+{
+	struct pci_dev *pdev = dev->port;
+	unsigned long flags;
+	struct npme_data *data = get_service_data(dev);
+
+	spin_lock_irqsave(&data->lock, flags);
+	npme_clear_pme(pdev);
+	npme_set_pme(pdev, 1);
+	spin_unlock_irqrestore(&data->lock, flags);
+
+	return 0;
+}
+
+static struct pcie_port_service_driver npme_driver = {
+	.name		= "npme",
+	.id_table	= &npme_id[0],
+
+	.probe		= npme_probe,
+	.remove		= npme_remove,
+	.suspend	= npme_suspend,
+	.resume		= npme_resume,
+};
+
+
+static int __init npme_service_init(void)
+{
+	if (disabled)
+		return -EINVAL;
+	return pcie_port_service_register(&npme_driver);
+}
+
+static void __exit npme_service_exit(void)
+{
+	pcie_port_service_unregister(&npme_driver);
+}
+
+module_init(npme_service_init);
+module_exit(npme_service_exit);
+
+MODULE_AUTHOR("Shaohua Li<shaohua.li@intel.com>");
+MODULE_LICENSE("GPL");
Index: linux/include/linux/pci_regs.h
===================================================================
--- linux.orig/include/linux/pci_regs.h	2008-09-08 13:55:55.000000000 +0800
+++ linux/include/linux/pci_regs.h	2008-09-08 14:26:13.000000000 +0800
@@ -419,6 +419,7 @@
 #define  PCI_EXP_RTCTL_CRSSVE	0x10	/* CRS Software Visibility Enable */
 #define PCI_EXP_RTCAP		30	/* Root Capabilities */
 #define PCI_EXP_RTSTA		32	/* Root Status */
+#define  PCI_EXP_RTSTA_PME	0x10000	/* PME status */
 
 /* Extended Capabilities (PCI-X 2.0 and Express) */
 #define PCI_EXT_CAP_ID(header)		(header & 0x0000ffff)

-- 
