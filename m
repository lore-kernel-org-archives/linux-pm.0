From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 1/9] PCI PM: Add function for checking PME status
	of devices
Date: Sun, 10 Jan 2010 14:35:18 +0100
Message-ID: <201001101435.18200.rjw__45821.0689751015$1263132526$gmane$org@sisk.pl>
References: <201001101431.38630.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201001101431.38630.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>, pm list <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Add function pci_check_pme_status() that will check the PME status
bit of given device and clear it along with the PME enable bit.  It
will be necessary for PCI run-time power management.

Based on a patch from Shaohua Li <shaohua.li@intel.com>

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/pci/pci.c |   35 +++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h |    1 +
 2 files changed, 36 insertions(+)

Index: linux-2.6/drivers/pci/pci.h
===================================================================
--- linux-2.6.orig/drivers/pci/pci.h
+++ linux-2.6/drivers/pci/pci.h
@@ -49,6 +49,7 @@ struct pci_platform_pm_ops {
 extern int pci_set_platform_pm(struct pci_platform_pm_ops *ops);
 extern void pci_update_current_state(struct pci_dev *dev, pci_power_t state);
 extern void pci_disable_enabled_device(struct pci_dev *dev);
+extern bool pci_check_pme_status(struct pci_dev *dev);
 extern void pci_pm_init(struct pci_dev *dev);
 extern void platform_pci_wakeup_init(struct pci_dev *dev);
 extern void pci_allocate_cap_save_buffers(struct pci_dev *dev);
Index: linux-2.6/drivers/pci/pci.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci.c
+++ linux-2.6/drivers/pci/pci.c
@@ -1195,6 +1195,41 @@ int pci_set_pcie_reset_state(struct pci_
 }
 
 /**
+ * pci_check_pme_status - Check if given device has generated PME.
+ * @dev: Device to check.
+ *
+ * Check the PME status of the device and if set, clear it and clear PME enable
+ * (if set).  Return 'true' if PME status and PME enable were both set or
+ * 'false' otherwise.
+ */
+bool pci_check_pme_status(struct pci_dev *dev)
+{
+	int pmcsr_pos;
+	u16 pmcsr;
+	bool ret = false;
+
+	if (!dev->pm_cap)
+		return false;
+
+	pmcsr_pos = dev->pm_cap + PCI_PM_CTRL;
+	pci_read_config_word(dev, pmcsr_pos, &pmcsr);
+	if (!(pmcsr & PCI_PM_CTRL_PME_STATUS))
+		return false;
+
+	/* Clear PME status. */
+	pmcsr |= PCI_PM_CTRL_PME_STATUS;
+	if (pmcsr & PCI_PM_CTRL_PME_ENABLE) {
+		/* Disable PME to avoid interrupt flood. */
+		pmcsr &= ~PCI_PM_CTRL_PME_ENABLE;
+		ret = true;
+	}
+
+	pci_write_config_word(dev, pmcsr_pos, pmcsr);
+
+	return ret;
+}
+
+/**
  * pci_pme_capable - check the capability of PCI device to generate PME#
  * @dev: PCI device to handle.
  * @state: PCI state from which device will issue PME#.
