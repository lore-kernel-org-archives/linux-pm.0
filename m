From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH][7/8] PCI PM: Move
	pci_restore_standard_config to pci-driver.c
Date: Sat, 7 Mar 2009 11:26:10 +0100
Message-ID: <200903071126.11408.rjw__32224.5791009211$1236423995$gmane$org@sisk.pl>
References: <200902221837.49396.rjw@sisk.pl> <200903071119.16651.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200903071119.16651.rjw@sisk.pl>
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
Cc: Arve@smtp1.linux-foundation.org, Jeremy Fitzhardinge <jeremy@goop.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Move pci_restore_standard_config() from pci.c to pci-driver.c and
make it static.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/pci/pci-driver.c |   17 +++++++++++++++++
 drivers/pci/pci.c        |   21 ---------------------
 drivers/pci/pci.h        |    1 -
 3 files changed, 17 insertions(+), 22 deletions(-)

Index: linux-2.6/drivers/pci/pci-driver.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci-driver.c
+++ linux-2.6/drivers/pci/pci-driver.c
@@ -423,6 +423,23 @@ static int pci_legacy_resume(struct devi
 
 /* Auxiliary functions used by the new power management framework */
 
+/**
+ * pci_restore_standard_config - restore standard config registers of PCI device
+ * @pci_dev: PCI device to handle
+ */
+static int pci_restore_standard_config(struct pci_dev *pci_dev)
+{
+	pci_update_current_state(pci_dev, PCI_UNKNOWN);
+
+	if (pci_dev->current_state != PCI_D0) {
+		int error = pci_set_power_state(pci_dev, PCI_D0);
+		if (error)
+			return error;
+	}
+
+	return pci_dev->state_saved ? pci_restore_state(pci_dev) : 0;
+}
+
 static void pci_pm_default_resume_noirq(struct pci_dev *pci_dev)
 {
 	pci_restore_standard_config(pci_dev);
Index: linux-2.6/drivers/pci/pci.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci.c
+++ linux-2.6/drivers/pci/pci.c
@@ -1374,27 +1374,6 @@ void pci_allocate_cap_save_buffers(struc
 }
 
 /**
- * pci_restore_standard_config - restore standard config registers of PCI device
- * @dev: PCI device to handle
- *
- * This function assumes that the device's configuration space is accessible.
- * If the device needs to be powered up, the function will wait for it to
- * change the state.
- */
-int pci_restore_standard_config(struct pci_dev *dev)
-{
-	pci_update_current_state(dev, PCI_UNKNOWN);
-
-	if (dev->current_state != PCI_D0) {
-		int error = pci_set_power_state(dev, PCI_D0);
-		if (error)
-			return error;
-	}
-
-	return dev->state_saved ? pci_restore_state(dev) : 0;
-}
-
-/**
  * pci_enable_ari - enable ARI forwarding if hardware support it
  * @dev: the PCI device
  */
Index: linux-2.6/drivers/pci/pci.h
===================================================================
--- linux-2.6.orig/drivers/pci/pci.h
+++ linux-2.6/drivers/pci/pci.h
@@ -49,7 +49,6 @@ extern void pci_disable_enabled_device(s
 extern void pci_pm_init(struct pci_dev *dev);
 extern void platform_pci_wakeup_init(struct pci_dev *dev);
 extern void pci_allocate_cap_save_buffers(struct pci_dev *dev);
-extern int pci_restore_standard_config(struct pci_dev *dev);
 
 static inline bool pci_is_bridge(struct pci_dev *pci_dev)
 {
