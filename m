From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 2/4] PCI PM: Make more PCI PM core functionality
	available to drivers
Date: Sat, 19 Jul 2008 14:39:24 +0200
Message-ID: <200807191439.25371.rjw__8904.03152811832$1216471455$gmane$org@sisk.pl>
References: <200807191436.40726.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200807191436.40726.rjw@sisk.pl>
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
To: LKML <linux-kernel@vger.kernel.org>
Cc: Jeff Garzik <jeff@garzik.org>, netdev@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, pm list <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Stephen Hemminger <shemminger@vyatta.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Make more PCI PM core functionality available to drivers

* Export pci_pme_capable() so that it can be called directly by
  drivers (for example, tg3 needs that).

* Move the state choosing part of pci_prepare_to_sleep() to a
  separate function, pci_target_state(), that can be called directly
  by drivers (for example, tg3 needs that).

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/pci/pci.c   |   35 +++++++++++++++++++++++++----------
 include/linux/pci.h |    2 ++
 2 files changed, 27 insertions(+), 10 deletions(-)

Index: linux-next/drivers/pci/pci.c
===================================================================
--- linux-next.orig/drivers/pci/pci.c
+++ linux-next/drivers/pci/pci.c
@@ -1040,7 +1040,7 @@ int pci_set_pcie_reset_state(struct pci_
  * @dev: PCI device to handle.
  * @state: PCI state from which device will issue PME#.
  */
-static bool pci_pme_capable(struct pci_dev *dev, pci_power_t state)
+bool pci_pme_capable(struct pci_dev *dev, pci_power_t state)
 {
 	if (!dev->pm_cap)
 		return false;
@@ -1123,18 +1123,11 @@ int pci_enable_wake(struct pci_dev *dev,
 }
 
 /**
- * pci_prepare_to_sleep - prepare PCI device for system-wide transition into
- *                        a sleep state
- * @dev: Device to handle.
  *
- * Choose the power state appropriate for the device depending on whether
- * it can wake up the system and/or is power manageable by the platform
- * (PCI_D3hot is the default) and put the device into that state.
  */
-int pci_prepare_to_sleep(struct pci_dev *dev)
+pci_power_t pci_target_state(struct pci_dev *dev)
 {
 	pci_power_t target_state = PCI_D3hot;
-	int error;
 
 	if (platform_pci_power_manageable(dev)) {
 		/*
@@ -1161,7 +1154,7 @@ int pci_prepare_to_sleep(struct pci_dev 
 		 * to generate PME#.
 		 */
 		if (!dev->pm_cap)
-			return -EIO;
+			return PCI_POWER_ERROR;
 
 		if (dev->pme_support) {
 			while (target_state
@@ -1170,6 +1163,26 @@ int pci_prepare_to_sleep(struct pci_dev 
 		}
 	}
 
+	return target_state;
+}
+
+/**
+ * pci_prepare_to_sleep - prepare PCI device for system-wide transition into
+ *                        a sleep state
+ * @dev: Device to handle.
+ *
+ * Choose the power state appropriate for the device depending on whether
+ * it can wake up the system and/or is power manageable by the platform
+ * (PCI_D3hot is the default) and put the device into that state.
+ */
+int pci_prepare_to_sleep(struct pci_dev *dev)
+{
+	pci_power_t target_state = pci_target_state(dev);
+	int error;
+
+	if (target_state == PCI_POWER_ERROR)
+		return -EIO;
+
 	pci_enable_wake(dev, target_state, true);
 
 	error = pci_set_power_state(dev, target_state);
@@ -1920,7 +1933,9 @@ EXPORT_SYMBOL(pci_select_bars);
 EXPORT_SYMBOL(pci_set_power_state);
 EXPORT_SYMBOL(pci_save_state);
 EXPORT_SYMBOL(pci_restore_state);
+EXPORT_SYMBOL(pci_pme_capable);
 EXPORT_SYMBOL(pci_enable_wake);
+EXPORT_SYMBOL(pci_target_state);
 EXPORT_SYMBOL(pci_prepare_to_sleep);
 EXPORT_SYMBOL(pci_back_from_sleep);
 EXPORT_SYMBOL_GPL(pci_set_pcie_reset_state);
Index: linux-next/include/linux/pci.h
===================================================================
--- linux-next.orig/include/linux/pci.h
+++ linux-next/include/linux/pci.h
@@ -638,7 +638,9 @@ int pci_save_state(struct pci_dev *dev);
 int pci_restore_state(struct pci_dev *dev);
 int pci_set_power_state(struct pci_dev *dev, pci_power_t state);
 pci_power_t pci_choose_state(struct pci_dev *dev, pm_message_t state);
+bool pci_pme_capable(struct pci_dev *dev, pci_power_t state);
 int pci_enable_wake(struct pci_dev *dev, pci_power_t state, int enable);
+pci_power_t pci_target_state(struct pci_dev *dev);
 int pci_prepare_to_sleep(struct pci_dev *dev);
 int pci_back_from_sleep(struct pci_dev *dev);
 
