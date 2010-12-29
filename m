From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 1/2] PCI / PM: Use pm_wakeup_event() directly for
	reporting wakeup events
Date: Wed, 29 Dec 2010 13:21:23 +0100
Message-ID: <201012291321.23899.rjw__16095.0475292795$1293625498$gmane$org@sisk.pl>
References: <201012291320.22777.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201012291320.22777.rjw@sisk.pl>
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
Cc: linux-pci@vger.kernel.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

After recent changes related to wakeup events pm_wakeup_event()
automatically checks if the given device is configured to signal
wakeup, so pci_wakeup_event() may be a static inline function
calling pm_wakeup_event() directly.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/pci/pci.c   |   16 ----------------
 drivers/pci/pci.h   |    6 ++++++
 include/linux/pci.h |    1 -
 3 files changed, 6 insertions(+), 17 deletions(-)

Index: linux-2.6/drivers/pci/pci.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci.c
+++ linux-2.6/drivers/pci/pci.c
@@ -1300,22 +1300,6 @@ bool pci_check_pme_status(struct pci_dev
 	return ret;
 }
 
-/*
- * Time to wait before the system can be put into a sleep state after reporting
- * a wakeup event signaled by a PCI device.
- */
-#define PCI_WAKEUP_COOLDOWN	100
-
-/**
- * pci_wakeup_event - Report a wakeup event related to a given PCI device.
- * @dev: Device to report the wakeup event for.
- */
-void pci_wakeup_event(struct pci_dev *dev)
-{
-	if (device_may_wakeup(&dev->dev))
-		pm_wakeup_event(&dev->dev, PCI_WAKEUP_COOLDOWN);
-}
-
 /**
  * pci_pme_wakeup - Wake up a PCI device if its PME Status bit is set.
  * @dev: Device to handle.
Index: linux-2.6/drivers/pci/pci.h
===================================================================
--- linux-2.6.orig/drivers/pci/pci.h
+++ linux-2.6/drivers/pci/pci.h
@@ -74,6 +74,12 @@ extern void pci_pm_init(struct pci_dev *
 extern void platform_pci_wakeup_init(struct pci_dev *dev);
 extern void pci_allocate_cap_save_buffers(struct pci_dev *dev);
 
+static inline void pci_wakeup_event(struct pci_dev *dev)
+{
+	/* Wait 100 ms before the system can be put into a sleep state. */
+	pm_wakeup_event(&dev->dev, 100);
+}
+
 static inline bool pci_is_bridge(struct pci_dev *pci_dev)
 {
 	return !!(pci_dev->subordinate);
Index: linux-2.6/include/linux/pci.h
===================================================================
--- linux-2.6.orig/include/linux/pci.h
+++ linux-2.6/include/linux/pci.h
@@ -820,7 +820,6 @@ int pci_prepare_to_sleep(struct pci_dev 
 int pci_back_from_sleep(struct pci_dev *dev);
 bool pci_dev_run_wake(struct pci_dev *dev);
 bool pci_check_pme_status(struct pci_dev *dev);
-void pci_wakeup_event(struct pci_dev *dev);
 void pci_pme_wakeup_bus(struct pci_bus *bus);
 
 static inline int pci_enable_wake(struct pci_dev *dev, pci_power_t state,
