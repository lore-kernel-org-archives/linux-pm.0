From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 9/9] PCI PM: Introduce pci_prepare_to_sleep
	and pci_back_from_sleep
Date: Fri, 20 Jun 2008 01:57:11 +0200
Message-ID: <200806200157.12094.rjw__10691.940240986$1213920733$gmane$org@sisk.pl>
References: <200806200145.33053.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200806200145.33053.rjw@sisk.pl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

PCI PM: Introduce pci_prepare_to_sleep and pci_back_from_sleep

Introduce functions pci_prepare_to_sleep() and pci_back_from_sleep(),
to be used by the PCI drivers that want to place their devices into
the lowest power state appropiate for them (PCI_D3hot, if the device
is not supposed to wake up the system, or the deepest state from
which the wake-up is possible, otherwise) while the system is being
prepared to go into a sleeping state and to put them back into D0
during the subsequent transition to the working state.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/pci/pci.c   |   83 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h |    2 +
 2 files changed, 85 insertions(+)

Index: linux-next/drivers/pci/pci.c
===================================================================
--- linux-next.orig/drivers/pci/pci.c
+++ linux-next/drivers/pci/pci.c
@@ -1112,6 +1112,87 @@ int pci_enable_wake(struct pci_dev *dev,
 }
 
 /**
+ * pci_prepare_to_sleep - prepare PCI device for system-wide transition into
+ *                        a sleep state
+ * @dev: Device to handle.
+ *
+ * Choose the power state appropriate for the device depending on whether
+ * it can wake-up the system and/or is power manageable by the platform
+ * (PCI_D3hot is the default) and put the device into that state.
+ */
+int pci_prepare_to_sleep(struct pci_dev *dev)
+{
+	pci_power_t target_state = PCI_D3hot;
+	int pm = pci_find_capability(dev, PCI_CAP_ID_PM);
+	int error;
+
+	if (platform_pci_power_manageable(dev)) {
+		/*
+		 * Call the platform to choose the target state of the device
+		 * and enable wake-up from this state if supported.
+		 */
+		pci_power_t state = platform_pci_choose_state(dev);
+
+		switch (state) {
+		case PCI_POWER_ERROR:
+		case PCI_UNKNOWN:
+			break;
+		case PCI_D1:
+		case PCI_D2:
+			if (pci_no_d1d2(dev))
+				break;
+		default:
+			target_state = state;
+			pci_enable_wake(dev, target_state, true);
+		}
+	} else if (device_may_wakeup(&dev->dev)) {
+		/*
+		 * Find the deepest state from which the device can generate
+		 * wake-up events, make it the target state and enable device
+		 * to generate PME#.
+		 */
+		u16 pmc;
+
+		if (!pm)
+			return -EIO;
+
+		pci_read_config_word(dev, pm + PCI_PM_PMC, &pmc);
+		if (pmc & PCI_PM_CAP_PME_MASK) {
+			if (!(pmc & PCI_PM_CAP_PME_D3)) {
+				/* Device cannot generate PME# from D3_hot */
+				if (pmc & PCI_PM_CAP_PME_D2)
+					target_state = PCI_D2;
+				else if (pmc & PCI_PM_CAP_PME_D1)
+					target_state = PCI_D1;
+				else
+					target_state = PCI_D0;
+			}
+			pci_pme_active(dev, pm, true);
+		}
+	}
+
+	error = pci_set_power_state(dev, target_state);
+
+	if (error)
+		pci_enable_wake(dev, target_state, false);
+
+	return error;
+}
+
+/**
+ * pci_back_from_sleep - turn PCI device on during system-wide transition into
+ *                       the working state a sleep state
+ * @dev: Device to handle.
+ *
+ * Disable device's sytem wake-up capability and put it into D0.
+ */
+int pci_back_from_sleep(struct pci_dev *dev)
+{
+	pci_enable_wake(dev, PCI_D0, false);
+	return pci_set_power_state(dev, PCI_D0);
+}
+
+/**
  * pci_pm_init - Initialize PM functions of given PCI device
  * @dev: PCI device to handle.
  */
@@ -1809,5 +1890,7 @@ EXPORT_SYMBOL(pci_set_power_state);
 EXPORT_SYMBOL(pci_save_state);
 EXPORT_SYMBOL(pci_restore_state);
 EXPORT_SYMBOL(pci_enable_wake);
+EXPORT_SYMBOL(pci_prepare_to_sleep);
+EXPORT_SYMBOL(pci_back_from_sleep);
 EXPORT_SYMBOL_GPL(pci_set_pcie_reset_state);
 
Index: linux-next/include/linux/pci.h
===================================================================
--- linux-next.orig/include/linux/pci.h
+++ linux-next/include/linux/pci.h
@@ -633,6 +633,8 @@ int pci_restore_state(struct pci_dev *de
 int pci_set_power_state(struct pci_dev *dev, pci_power_t state);
 pci_power_t pci_choose_state(struct pci_dev *dev, pm_message_t state);
 int pci_enable_wake(struct pci_dev *dev, pci_power_t state, int enable);
+int pci_prepare_to_sleep(struct pci_dev *dev);
+int pci_back_from_sleep(struct pci_dev *dev);
 
 /* Functions for PCI Hotplug drivers to use */
 int pci_bus_find_capability(struct pci_bus *bus, unsigned int devfn, int cap);
