From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] PCI PM: Introduce function pci_wake_from_d3
	(rev. 2)
Date: Mon, 18 Aug 2008 21:38:00 +0200
Message-ID: <200808182138.00989.rjw__5605.21157826788$1219088343$gmane$org@sisk.pl>
References: <200808182057.22501.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200808182057.22501.rjw@sisk.pl>
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
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

[Sorry, it is more useful to define the function so that it takes a second
argument indicating whether to enable or disable wake-up.]
---
From: Rafael J. Wysocki <rjw@sisk.pl>

PCI PM: Introduce function pci_wake_from_d3 (rev. 2)

Many device drivers use the following sequence of statements to
enable the device to wake up the system while being in the D3_hot
or D3_cold low power state:

	pci_enable_wake(pdev, PCI_D3hot, 1);
	pci_enable_wake(pdev, PCI_D3cold, 1);

However, the second call is not necessary if the first one succeeds
(the ordering of the statements above doesn't matter here) and it
may even be harmful, because we are not supposed to enable PME#
after the wake-up power has been enabled for the device.

To allow drivers to overcome this problem, introduce function
pci_wake_from_d3() that will enable the device to wake up the system
from any of D3_hot and D3_cold as long as the wake-up from at least
one of them is supported.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/pci/pci.c   |   22 ++++++++++++++++++++++
 include/linux/pci.h |    1 +
 2 files changed, 23 insertions(+)

Index: linux-2.6/drivers/pci/pci.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci.c
+++ linux-2.6/drivers/pci/pci.c
@@ -1127,6 +1127,27 @@ int pci_enable_wake(struct pci_dev *dev,
 }
 
 /**
+ * pci_wake_from_d3 - enable/disable device to wake up from D3_hot or D3_cold
+ * @dev: PCI device to prepare
+ * @enable: True to enable wake-up event generation; false to disable
+ *
+ * Many drivers want the device to wake up the system from D3_hot or D3_cold
+ * and this function allows them to set that up cleanly - pci_enable_wake()
+ * should not be called twice in a row to enable wake-up due to PCI PM vs ACPI
+ * ordering constraints.
+ *
+ * This function only returns error code if the device is not capable of
+ * generating PME# from both D3_hot and D3_cold, and the platform is unable to
+ * enable wake-up power for it.
+ */
+int pci_wake_from_d3(struct pci_dev *dev, bool enable)
+{
+	return pci_pme_capable(dev, PCI_D3cold) ?
+			pci_enable_wake(dev, PCI_D3cold, enable) :
+			pci_enable_wake(dev, PCI_D3hot, enable);
+}
+
+/**
  * pci_target_state - find an appropriate low power state for a given PCI dev
  * @dev: PCI device
  *
@@ -1943,6 +1964,7 @@ EXPORT_SYMBOL(pci_restore_state);
 EXPORT_SYMBOL(pci_pme_capable);
 EXPORT_SYMBOL(pci_pme_active);
 EXPORT_SYMBOL(pci_enable_wake);
+EXPORT_SYMBOL(pci_wake_from_d3);
 EXPORT_SYMBOL(pci_target_state);
 EXPORT_SYMBOL(pci_prepare_to_sleep);
 EXPORT_SYMBOL(pci_back_from_sleep);
Index: linux-2.6/include/linux/pci.h
===================================================================
--- linux-2.6.orig/include/linux/pci.h
+++ linux-2.6/include/linux/pci.h
@@ -643,6 +643,7 @@ pci_power_t pci_choose_state(struct pci_
 bool pci_pme_capable(struct pci_dev *dev, pci_power_t state);
 void pci_pme_active(struct pci_dev *dev, bool enable);
 int pci_enable_wake(struct pci_dev *dev, pci_power_t state, int enable);
+int pci_wake_from_d3(struct pci_dev *dev, bool enable);
 pci_power_t pci_target_state(struct pci_dev *dev);
 int pci_prepare_to_sleep(struct pci_dev *dev);
 int pci_back_from_sleep(struct pci_dev *dev);
