From: Shaohua Li <shaohua.li@intel.com>
Subject: [PATCH 3/5] implement .wakeup_event in PCI bus level
Date: Wed, 19 Aug 2009 15:24:16 +0800
Message-ID: <1250666656.23178.118.camel__2991.62938395074$1250666877$gmane$org@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux acpi <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Add an implementation how to detect wakeup event for PCI bus level. PCI device
can invoke PME and platform or PCIe native approach can collect the PME and
reports to OS. OS should identify exactly which device invokes PME as several
devices can share interrupts.

In platform approach (ACPI in this case), some BIOS give exact device which
invokes PME but others doesn't. 
In PCIe native approach, if PME source device is a pcie endpoint, the device
is the exact PME source. If the device is root port or pcie-to-pci bridge,
we need scan the hierarchy under the device.

To identify PME source, the patch does:
1. if the source is a pci device, the device is the only source for PME
2. if the source is a bridge, scan the hierarchy under the bridge. Several
devices under the bridge could be the source.


---
 drivers/pci/pci-driver.c |   90 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

Index: linux/drivers/pci/pci-driver.c
===================================================================
--- linux.orig/drivers/pci/pci-driver.c	2009-08-19 13:43:18.000000000 +0800
+++ linux/drivers/pci/pci-driver.c	2009-08-19 13:50:29.000000000 +0800
@@ -570,6 +570,95 @@ static void pci_pm_complete(struct devic
 		drv->pm->complete(dev);
 }
 
+/*
+ * Called when dev is suspected to invoke a wakeup event
+ * */
+static bool pci_handle_one_wakeup_event(struct pci_dev *pdev)
+{
+	int pme_pos = pdev->pm_cap;
+	struct pci_driver *drv = pdev->driver;
+	u16 pmcsr;
+	bool spurious = false;
+
+	if (pme_pos == 0) {
+		/*
+		 * Some USB devices haven't PME, but have specific registers to
+		 * control wakeup
+		 */
+		goto out;
+	}
+
+	/* clear PME status and disable PME to avoid interrupt flood */
+	pci_read_config_word(pdev, pme_pos + PCI_PM_CTRL, &pmcsr);
+	if (!(pmcsr & PCI_PM_CTRL_PME_STATUS))
+		return false;
+	/* I see spurious PME here, just ignore it for now */
+	if (!(pmcsr & PCI_PM_CTRL_PME_ENABLE))
+		spurious = true;
+	else
+		pmcsr &= ~PCI_PM_CTRL_PME_ENABLE;
+	pmcsr |= PCI_PM_CTRL_PME_STATUS;
+	pci_write_config_word(pdev, pme_pos + PCI_PM_CTRL, pmcsr);
+
+	if (spurious)
+		return false;
+	return true;
+out:
+	if (drv && drv->driver.pm && drv->driver.pm->wakeup_event)
+		return drv->driver.pm->wakeup_event(&pdev->dev);
+	return false;
+}
+
+static bool pci_pm_wakeup_event(struct device *dev)
+{
+	bool ret;
+	struct pci_dev *tmp = NULL, *target = to_pci_dev(dev);
+	int domain_nr, bus_start, bus_end;
+
+	/*
+	 * @target could be a bridge or a device.
+	 * PCIe native PME case:
+	 *   @target is device - @target must be the exact device invoking PME
+	 *   @target is a root port or pcie-pci bridge - should scan legacy pci
+	 *	devices under the bridge
+	 * ACPI GPE case:
+	 *   @target is device - AML code could clear PME status before this
+	 *	routine is called, so we can't detect if @target invokes PME.
+	 *	Let's trust AML code
+	 *   @target is bridge - scan devices under the bridge
+	 * So: if target is device, trust the device invokes PME. If target is
+	 * bridge, scan devices under the bridge and only trust device invokes
+	 * PME which we can detect
+	 **/
+	ret = pci_handle_one_wakeup_event(target);
+	if (!target->subordinate || (target->is_pcie &&
+	    target->pcie_type != PCI_EXP_TYPE_ROOT_PORT &&
+	    target->pcie_type != PCI_EXP_TYPE_PCI_BRIDGE)) {
+		/* always trust the device invokes PME even we can't detect */
+		device_receive_wakeup_event(&target->dev);
+		return true;
+	}
+
+	if (ret)
+		device_receive_wakeup_event(&target->dev);
+
+	/* scan devices under the bridge */
+	domain_nr = pci_domain_nr(target->bus);
+	bus_start = target->subordinate->secondary;
+	bus_end = target->subordinate->subordinate;
+	while ((tmp = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, tmp)) != NULL) {
+		if (pci_domain_nr(tmp->bus) == domain_nr &&
+		   tmp->bus->number >= bus_start &&
+		   tmp->bus->number <= bus_end) {
+			if (pci_handle_one_wakeup_event(tmp)) {
+				ret = true;
+				device_receive_wakeup_event(&tmp->dev);
+			}
+		}
+	}
+	return ret;
+}
+
 #ifdef CONFIG_SUSPEND
 
 static int pci_pm_suspend(struct device *dev)
@@ -925,6 +1014,7 @@ struct dev_pm_ops pci_dev_pm_ops = {
 	.thaw_noirq = pci_pm_thaw_noirq,
 	.poweroff_noirq = pci_pm_poweroff_noirq,
 	.restore_noirq = pci_pm_restore_noirq,
+	.wakeup_event = pci_pm_wakeup_event,
 };
 
 #define PCI_PM_OPS_PTR	(&pci_dev_pm_ops)
