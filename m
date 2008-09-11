From: Shaohua Li <shaohua.li@intel.com>
Subject: [RFC 4/5] PCIe native PME detection
Date: Thu, 11 Sep 2008 14:30:41 +0800
Message-ID: <20080911063823.312142224__18045.1787812219$1221115925$gmane$org@sli10-desk.sh.intel.com>
References: <20080911063037.698427944@sli10-desk.sh.intel.com>
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

PCIe defines a native PME detection mechanism. When a PCIe endpoint invokes PME, PCIe root port has a set of regisets to detect the endpoint's bus/device/function number and root port will send out interrupt when PME is received. See PCIe spec for detail. This patch implements this feature.

---
 drivers/pci/pcie/Kconfig  |    7 +
 drivers/pci/pcie/Makefile |    2 
 drivers/pci/pcie/npme.c   |  312 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci_regs.h  |    1 
 4 files changed, 322 insertions(+)

Index: linux/drivers/pci/pcie/Kconfig
===================================================================
--- linux.orig/drivers/pci/pcie/Kconfig	2008-09-11 11:27:44.000000000 +0800
+++ linux/drivers/pci/pcie/Kconfig	2008-09-11 11:28:39.000000000 +0800
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
--- linux.orig/drivers/pci/pcie/Makefile	2008-09-11 11:27:44.000000000 +0800
+++ linux/drivers/pci/pcie/Makefile	2008-09-11 11:28:39.000000000 +0800
@@ -11,3 +11,5 @@ obj-$(CONFIG_PCIEPORTBUS)	+= pcieportdrv
 
 # Build PCI Express AER if needed
 obj-$(CONFIG_PCIEAER)		+= aer/
+
+obj-$(CONFIG_PCIENPME) += npme.o
Index: linux/drivers/pci/pcie/npme.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux/drivers/pci/pcie/npme.c	2008-09-11 11:30:26.000000000 +0800
@@ -0,0 +1,312 @@
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
+static inline void npme_enable_pme(struct pci_dev *pdev, bool enable)
+{
+	int pos;
+	u16 rtctl;
+
+	pos = pci_find_capability(pdev, PCI_CAP_ID_EXP);
+
+	pci_read_config_word(pdev, pos + PCI_EXP_RTCTL, &rtctl);
+	if (!enable)
+		rtctl &= ~PCI_EXP_RTCTL_PMEIE;
+	else
+		rtctl |= PCI_EXP_RTCTL_PMEIE;
+	pci_write_config_word(pdev, pos + PCI_EXP_RTCTL, rtctl);
+}
+
+static inline void npme_clear_pme(struct pci_dev *pdev)
+{
+	int pos;
+	u32 rtsta;
+
+	pos = pci_find_capability(pdev, PCI_CAP_ID_EXP);
+
+	pci_read_config_dword(pdev, pos + PCI_EXP_RTSTA, &rtsta);
+	rtsta |= PCI_EXP_RTSTA_PME;
+	pci_write_config_dword(pdev, pos + PCI_EXP_RTSTA, rtsta);
+}
+
+static bool npme_pme_target(struct pci_dev *target)
+{
+	bool ret = false;
+	if (target->dev.bus->pm && target->dev.bus->pm->base.wakeup_event)
+		ret = target->dev.bus->pm->base.wakeup_event(&target->dev);
+	return ret;
+}
+
+static void npme_work_handle(struct work_struct *work)
+{
+	struct npme_data *data = container_of(work, struct npme_data, work);
+	struct pcie_device *dev = data->dev;
+	unsigned long flags;
+	struct pci_dev *target;
+	bool has_dev = false;
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
+		has_dev = npme_pme_target(target);
+	else
+		printk(KERN_ERR"Can't find device %02d:%d.%d which invokes PME\n",
+			data->bdf >> 8, PCI_SLOT(data->bdf),
+			PCI_FUNC(data->bdf));
+
+	spin_lock_irqsave(&data->lock, flags);
+	/* clear pending PME */
+	npme_clear_pme(dev->port);
+	/* reenable native PME */
+	if (!data->exit)
+		npme_enable_pme(dev->port, true);
+
+	spin_unlock_irqrestore(&data->lock, flags);
+
+	if (!has_dev)
+		printk(KERN_ERR"Spurious Native PME interrupt %d received\n",
+			dev->irq);
+
+	if (target)
+		pci_dev_put(target);
+}
+
+static irqreturn_t npme_irq(int irq, void *context)
+{
+	int pos;
+	struct pci_dev *pdev;
+	u32 rtsta;
+	struct npme_data *data;
+	unsigned long flags;
+
+	pdev = ((struct pcie_device *)context)->port;
+	data = get_service_data((struct pcie_device *)context);
+
+	pos = pci_find_capability(pdev, PCI_CAP_ID_EXP);
+
+	spin_lock_irqsave(&data->lock, flags);
+	pci_read_config_dword(pdev, pos + PCI_EXP_RTSTA, &rtsta);
+	if (!(rtsta & PCI_EXP_RTSTA_PME)) {
+		spin_unlock_irqrestore(&data->lock, flags);
+		return IRQ_NONE;
+	}
+
+	data->bdf = (u16)rtsta;
+
+	/* disable PME to avoid interrupt flood */
+	npme_enable_pme(pdev, false);
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
+static inline int npme_osc_setup(struct pcie_device *pciedev)
+{
+	return 0;
+}
+#endif
+
+static int __devinit npme_probe(struct pcie_device *dev,
+				const struct pcie_port_service_id *id)
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
+	set_service_data(dev, data);
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
+	npme_enable_pme(pdev, true);
+
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
+	npme_enable_pme(pdev, false);
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
+	npme_enable_pme(pdev, false);
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
+	npme_enable_pme(pdev, true);
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
--- linux.orig/include/linux/pci_regs.h	2008-09-11 11:27:44.000000000 +0800
+++ linux/include/linux/pci_regs.h	2008-09-11 11:28:39.000000000 +0800
@@ -419,6 +419,7 @@
 #define  PCI_EXP_RTCTL_CRSSVE	0x10	/* CRS Software Visibility Enable */
 #define PCI_EXP_RTCAP		30	/* Root Capabilities */
 #define PCI_EXP_RTSTA		32	/* Root Status */
+#define  PCI_EXP_RTSTA_PME	0x10000	/* PME status */
 
 /* Extended Capabilities (PCI-X 2.0 and Express) */
 #define PCI_EXT_CAP_ID(header)		(header & 0x0000ffff)

-- 
