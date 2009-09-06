From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 1 update] PCI PM: PCIe PME root port service
	driver
Date: Sun, 6 Sep 2009 19:01:14 +0200
Message-ID: <200909061901.14979.rjw__27851.7480277971$1252256516$gmane$org@sisk.pl>
References: <1251101495.22288.54.camel@sli10-desk.sh.intel.com>
	<20090901023549.GB3695@sli10-desk.sh.intel.com>
	<200909061434.24870.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200909061434.24870.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: linux-pci <linux-pci@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sunday 06 September 2009, Rafael J. Wysocki wrote:
> On Tuesday 01 September 2009, Shaohua Li wrote:
> ...
> > Updated patch.
> 
> I looked at it and thought I would do it differently in many places, so
> below is my version.

One refinement.  We can avoid using pci_get_bus_and_slot(), which essentially
is a loop over all PCI devices, and instead use pci_find_bus() to find the bus
the device is on and then look for the device in bus->devices.

Thanks,
Rafael

---
Subject: PCI PM: PCIe PME root port service driver

PCIe native PME detection mechanism is based on interrupts generated
by root ports or event collectors every time a PCIe device sends a
PME message upstream.

Once a PME message has been sent by an endpoint device and received
by its root port (or event collector in the case of root complex
integrated endpoints), the Requester ID from the message header is
registered in the root port's Root Status register.  At the same
time, the PME Status bit of the Root Status register is set to
indicate that there's a PME to handle.  If PCIe PME interrupt is
enabled for the root port, it generates the interrupt once the PME
Status has been set.  After receiving the interrupt, the kernel can
identify the PCIe device that generated the PME using the Requester
ID from the root port's Root Status register. [For details, see PCI
Express Base Specification, Rev. 2.0.]

Implement a driver for the PCIe PME root port service working in
accordance with the above description.

Based on a patch from Shaohua Li <shaohua.li@intel.com>.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/pci/pcie/Kconfig    |    4 
 drivers/pci/pcie/Makefile   |    2 
 drivers/pci/pcie/pcie_pme.c |  428 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 434 insertions(+)

Index: linux-2.6/drivers/pci/pcie/Kconfig
===================================================================
--- linux-2.6.orig/drivers/pci/pcie/Kconfig
+++ linux-2.6/drivers/pci/pcie/Kconfig
@@ -46,3 +46,7 @@ config PCIEASPM_DEBUG
 	help
 	  This enables PCI Express ASPM debug support. It will add per-device
 	  interface to control ASPM.
+
+config PCIE_PME
+	def_bool y
+	depends on PCIEPORTBUS && PM_RUNTIME && EXPERIMENTAL
Index: linux-2.6/drivers/pci/pcie/Makefile
===================================================================
--- linux-2.6.orig/drivers/pci/pcie/Makefile
+++ linux-2.6/drivers/pci/pcie/Makefile
@@ -11,3 +11,5 @@ obj-$(CONFIG_PCIEPORTBUS)	+= pcieportdrv
 
 # Build PCI Express AER if needed
 obj-$(CONFIG_PCIEAER)		+= aer/
+
+obj-$(CONFIG_PCIE_PME) += pcie_pme.o
Index: linux-2.6/drivers/pci/pcie/pcie_pme.c
===================================================================
--- /dev/null
+++ linux-2.6/drivers/pci/pcie/pcie_pme.c
@@ -0,0 +1,428 @@
+/*
+ * PCIe Native PME support
+ *
+ * Copyright (C) 2007 - 2009 Intel Corp
+ * Copyright (C) 2007 - 2009 Shaohua Li <shaohua.li@intel.com>
+ * Copyright (C) 2009 Rafael J. Wysocki <rjw@sisk.pl>, Novell Inc.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License V2.  See the file "COPYING" in the main directory of this archive
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
+#include <linux/pm_runtime.h>
+
+#include "../pci.h"
+
+#define PCI_EXP_RTSTA_PME	0x10000 /* PME status */
+#define PCI_EXP_RTSTA_PENDING	0x20000 /* PME pending */
+
+static bool pcie_pme_enabled = true;
+
+/*
+ * Apparently, many BIOSes don't implement ACPI _OSC correctly, so let's not use
+ * it by default.
+ */
+static bool use_acpi_osc;
+
+static int __init pcie_pme_setup(char *str)
+{
+	if (!strcmp(str, "off"))
+		pcie_pme_enabled = false;
+	else if (!strcmp(str, "acpi"))
+		use_acpi_osc = true;
+	return 1;
+}
+__setup("pcie_pme=", pcie_pme_setup);
+
+struct pcie_pme_service_data {
+	spinlock_t lock;
+	struct pcie_device *srv;
+	struct work_struct work;
+	bool noirq; /* Don't enable the PME interrupt used by this service. */
+};
+
+/**
+ * pcie_pme_interrupt_enable - Enable/disable PCIe PME interrupt generation.
+ * @dev: PCIe root port or event collector.
+ * @enable: Enable or disable the interrupt.
+ */
+static void pcie_pme_interrupt_enable(struct pci_dev *dev, bool enable)
+{
+	int rtctl_pos;
+	u16 rtctl;
+
+	rtctl_pos = pci_find_capability(dev, PCI_CAP_ID_EXP) + PCI_EXP_RTCTL;
+
+	pci_read_config_word(dev, rtctl_pos, &rtctl);
+	if (enable)
+		rtctl |= PCI_EXP_RTCTL_PMEIE;
+	else
+		rtctl &= ~PCI_EXP_RTCTL_PMEIE;
+	pci_write_config_word(dev, rtctl_pos, rtctl);
+}
+
+/**
+ * pcie_pme_clear_status - Clear root port PME interrupt status.
+ * @dev: PCIe root port or event collector.
+ */
+static void pcie_pme_clear_status(struct pci_dev *dev)
+{
+	int rtsta_pos;
+	u32 rtsta;
+
+	rtsta_pos = pci_find_capability(dev, PCI_CAP_ID_EXP) + PCI_EXP_RTSTA;
+
+	pci_read_config_dword(dev, rtsta_pos, &rtsta);
+	rtsta |= PCI_EXP_RTSTA_PME;
+	pci_write_config_dword(dev, rtsta_pos, rtsta);
+}
+
+/**
+ * pcie_pme_handle_bus - Scan a PCI bus for devices asserting PME#.
+ * @bus: PCI bus to scan.
+ *
+ * Scan given PCI bus and all buses under it for devices asserting PME#.
+ */
+static bool pcie_pme_handle_bus(struct pci_bus *bus)
+{
+	struct pci_dev *dev;
+	bool ret = false;
+
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		/* Skip PCIe devices in case we started from a root port. */
+		if (!dev->is_pcie && pci_check_pme_status(dev)) {
+			pm_request_resume(&dev->dev);
+			ret = true;
+		}
+
+		if (dev->subordinate && pcie_pme_handle_bus(dev->subordinate))
+			ret = true;
+	}
+
+	return ret;
+}
+
+/**
+ * pcie_pme_handle_request - Find device that generated PME and handle it.
+ * @port: Root port or event collector that generated the PME interrupt.
+ * @req_id: PCIe Requester ID of the device that generated the PME.
+ */
+static void pcie_pme_handle_request(struct pci_dev *port, u16 req_id)
+{
+	u8 busnr = req_id >> 8, devfn = req_id & 0xff;
+	struct pci_bus *bus;
+	struct pci_dev *dev;
+	bool found = false;
+
+	bus = pci_find_bus(pci_domain_nr(port->bus), busnr);
+	if (!bus)
+		goto out;
+
+	down_read(&pci_bus_sem);
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		pci_dev_get(dev);
+		if (dev->devfn == devfn) {
+			found = true;
+			break;
+		}
+		pci_dev_put(dev);
+	}
+	up_read(&pci_bus_sem);
+
+	if (found) {
+		pm_request_resume(&dev->dev);
+	} else {
+		if (devfn)
+			dev_dbg(&port->dev, "PME interrupt generated for "
+				"non-existent device %02x:%02x.%d\n",
+				busnr, PCI_SLOT(devfn), PCI_FUNC(devfn));
+		/*
+		 * PME from PCI devices under a PCIe-PCI bridge may be converted
+		 * to a PCIe in-band PME message.  In such that case the bridge
+		 * will use the Requester ID of device/function number 0 on its
+		 * secondary bus.
+		 */
+		dev = pci_dev_get(bus->self);
+		if (!dev->is_pcie || dev->pcie_type != PCI_EXP_TYPE_PCI_BRIDGE)
+			goto out_dev;
+	}
+
+	/*
+	 * PME may be generated by a PCIe-PCI bridge or a root port on behalf
+	 * of a non-PCIe device downstream.  If this is done by a root port, its
+	 * Requester ID field may contain either the root port's or the source
+	 * device's information (PCI Express Base Specification, Rev. 2.0,
+	 * Section 6.1.9).
+	 */
+	if (dev->subordinate && dev->is_pcie
+	    && ((!found && dev->pcie_type == PCI_EXP_TYPE_ROOT_PORT)
+	    || dev->pcie_type == PCI_EXP_TYPE_PCI_BRIDGE)) {
+		down_read(&pci_bus_sem);
+		if (pcie_pme_handle_bus(dev->subordinate))
+			found = true;
+		up_read(&pci_bus_sem);
+	}
+
+ out_dev:
+	pci_dev_put(dev);
+
+ out:
+	if (!found)
+		dev_dbg(&port->dev, "Spurious native PME interrupt!\n");
+}
+
+/**
+ * pcie_pme_work_fn - Work handler for PCIe PME interrupt.
+ * @work: Work structure giving access to service data.
+ */
+static void pcie_pme_work_fn(struct work_struct *work)
+{
+	struct pcie_pme_service_data *data =
+			container_of(work, struct pcie_pme_service_data, work);
+	struct pci_dev *port = data->srv->port;
+	int rtsta_pos;
+	u32 rtsta;
+
+	rtsta_pos = pci_find_capability(port, PCI_CAP_ID_EXP) + PCI_EXP_RTSTA;
+
+	spin_lock_irq(&data->lock);
+
+	for (;;) {
+		if (data->noirq)
+			break;
+
+		pci_read_config_dword(port, rtsta_pos, &rtsta);
+		if (rtsta & PCI_EXP_RTSTA_PME) {
+			/*
+			 * Clear PME status of the port.  If there are other
+			 * pending PMEs, the status will be set again.
+			 */
+			pcie_pme_clear_status(port);
+
+			spin_unlock_irq(&data->lock);
+			pcie_pme_handle_request(port, rtsta & 0xffff);
+			spin_lock_irq(&data->lock);
+
+			continue;
+		}
+
+		/* No need to loop if there are no more PMEs pending. */
+		if (!(rtsta & PCI_EXP_RTSTA_PENDING))
+			break;
+
+		spin_unlock_irq(&data->lock);
+		cpu_relax();
+		spin_lock_irq(&data->lock);
+	}
+
+	if (!data->noirq)
+		pcie_pme_interrupt_enable(port, true);
+
+	spin_unlock_irq(&data->lock);
+}
+
+/**
+ * pcie_pme_irq - Interrupt handler for PCIe root port PME interrupt.
+ * @irq: Interrupt vector.
+ * @context: Interrupt context pointer.
+ */
+static irqreturn_t pcie_pme_irq(int irq, void *context)
+{
+	struct pci_dev *port;
+	struct pcie_pme_service_data *data;
+	int rtsta_pos;
+	u32 rtsta;
+	unsigned long flags;
+
+	port = ((struct pcie_device *)context)->port;
+	data = get_service_data((struct pcie_device *)context);
+
+	rtsta_pos = pci_find_capability(port, PCI_CAP_ID_EXP) + PCI_EXP_RTSTA;
+
+	spin_lock_irqsave(&data->lock, flags);
+	pci_read_config_dword(port, rtsta_pos, &rtsta);
+
+	if (!(rtsta & PCI_EXP_RTSTA_PME)) {
+		spin_unlock_irqrestore(&data->lock, flags);
+		return IRQ_NONE;
+	}
+
+	pcie_pme_interrupt_enable(port, false);
+	spin_unlock_irqrestore(&data->lock, flags);
+
+	queue_work(pm_wq, &data->work);
+
+	return IRQ_HANDLED;
+}
+
+#ifdef CONFIG_ACPI
+/**
+ * pcie_pme_osc_setup - Declare native PCIe PME support to the ACPI BIOS.
+ * @srv - PCIe PME service for a root port or event collector.
+ */
+static int pcie_pme_osc_setup(struct pcie_device *srv)
+{
+	acpi_status status = AE_NOT_FOUND;
+	struct pci_dev *port = srv->port;
+	acpi_handle handle = DEVICE_ACPI_HANDLE(&port->dev);
+
+	if (!handle)
+		return -EINVAL;
+
+	status = acpi_pci_osc_control_set(handle,
+			OSC_PCI_EXPRESS_PME_CONTROL |
+			OSC_PCI_EXPRESS_CAP_STRUCTURE_CONTROL);
+	if (ACPI_FAILURE(status)) {
+		dev_dbg(&srv->device,
+			"ACPI couldn't initialize PME service: %s\n",
+			(status == AE_SUPPORT || status == AE_NOT_FOUND) ?
+			"no _OSC support" : "ACPI _OSC failed");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+#else /* !CONFIG_ACPI */
+static inline int pcie_pme_osc_setup(struct pcie_device *pciedev)
+{
+	return 0;
+}
+#endif /* !CONFIG_ACPI */
+
+/**
+ * pcie_pme_probe - Initialize PCIe PME service for given root port.
+ * @srv - PCIe service to initialize.
+ */
+static int pcie_pme_probe(struct pcie_device *srv)
+{
+	struct pci_dev *port;
+	struct pcie_pme_service_data *data;
+	int ret;
+
+	if (use_acpi_osc) {
+		ret = pcie_pme_osc_setup(srv);
+		if (ret)
+			return ret;
+	}
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	spin_lock_init(&data->lock);
+	INIT_WORK(&data->work, pcie_pme_work_fn);
+	data->srv = srv;
+	set_service_data(srv, data);
+
+	port = srv->port;
+	pcie_pme_interrupt_enable(port, false);
+	pcie_pme_clear_status(port);
+
+	ret = request_irq(srv->irq, pcie_pme_irq, IRQF_SHARED, "PCIe PME", srv);
+	if (ret)
+		kfree(data);
+	else
+		pcie_pme_interrupt_enable(port, true);
+
+	return ret;
+}
+
+/**
+ * pcie_pme_remove - Prepare PCIe PME service device for removal.
+ * @srv - PCIe service device to be removed.
+ */
+static void pcie_pme_remove(struct pcie_device *srv)
+{
+	struct pcie_pme_service_data *data = get_service_data(srv);
+	struct pci_dev *port = srv->port;
+
+	spin_lock_irq(&data->lock);
+	pcie_pme_interrupt_enable(port, false);
+	pcie_pme_clear_status(port);
+	data->noirq = true;
+	spin_unlock_irq(&data->lock);
+
+	flush_work(&data->work);
+	free_irq(srv->irq, srv);
+
+	set_service_data(srv, NULL);
+	kfree(data);
+}
+
+/**
+ * pcie_pme_suspend - Suspend PCIe PME service device.
+ * @srv - PCIe service device to suspend.
+ */
+static int pcie_pme_suspend(struct pcie_device *srv)
+{
+	struct pcie_pme_service_data *data = get_service_data(srv);
+	struct pci_dev *port = srv->port;
+
+	spin_lock_irq(&data->lock);
+	pcie_pme_interrupt_enable(port, false);
+	pcie_pme_clear_status(port);
+	data->noirq = true;
+	spin_unlock_irq(&data->lock);
+
+	return 0;
+}
+
+/**
+ * pcie_pme_resume - Resume PCIe PME service device.
+ * @srv - PCIe service device to resume.
+ */
+static int pcie_pme_resume(struct pcie_device *srv)
+{
+	struct pcie_pme_service_data *data = get_service_data(srv);
+	struct pci_dev *port = srv->port;
+
+	spin_lock_irq(&data->lock);
+	data->noirq = false;
+	pcie_pme_clear_status(port);
+	pcie_pme_interrupt_enable(port, true);
+	spin_unlock_irq(&data->lock);
+
+	return 0;
+}
+
+static struct pcie_port_service_driver pcie_pme_driver = {
+	.name		= "pcie_pme",
+	.port_type 	= PCIE_RC_PORT,
+	.service 	= PCIE_PORT_SERVICE_PME,
+
+	.probe		= pcie_pme_probe,
+	.remove		= pcie_pme_remove,
+	.suspend	= pcie_pme_suspend,
+	.resume		= pcie_pme_resume,
+};
+
+/**
+ * pcie_pme_service_init - Register the PCIe PME service driver.
+ */
+static int __init pcie_pme_service_init(void)
+{
+	return pcie_pme_enabled ?
+		pcie_port_service_register(&pcie_pme_driver) : -ENODEV;
+}
+
+/**
+ * pcie_pme_service_exit - Unregister the PCIe PME service driver.
+ */
+static void __exit pcie_pme_service_exit(void)
+{
+	pcie_port_service_unregister(&pcie_pme_driver);
+}
+
+module_init(pcie_pme_service_init);
+module_exit(pcie_pme_service_exit);
