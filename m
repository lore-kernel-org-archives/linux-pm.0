From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 1/2] PCI PM: Export
	platform_pci_set_power_state()
Date: Mon, 23 Mar 2009 22:31:49 +0100
Message-ID: <200903232231.50477.rjw__42248.2291739017$1237844553$gmane$org@sisk.pl>
References: <200903210003.55161.rjw@sisk.pl> <200903222208.22434.rjw@sisk.pl>
	<200903232230.10831.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200903232230.10831.rjw@sisk.pl>
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
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

The radeonfb driver needs to program the device's PMCSR directly due
to some quirky hardware it has to handle (see
http://bugzilla.kernel.org/show_bug.cgi?id=12846 for details) and
after doing that it needs to call the platform (usually ACPI) to
finish the power transition of the device.  Currently it uses
pci_set_power_state() for this purpose, however making a specific
assumption about the internal behavior of this function, which has
changed recently so that this assumption is no longer satisfied.
For this reason, change platform_pci_set_power_state() into an
exported function so that the radeonfb driver can use it directly
instead of calling it via pci_set_power_state().

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/pci/pci.c   |   68 +++++++++++++++++++++++++++++-----------------------
 include/linux/pci.h |    1 
 2 files changed, 40 insertions(+), 29 deletions(-)

Index: linux-2.6/drivers/pci/pci.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci.c
+++ linux-2.6/drivers/pci/pci.c
@@ -398,12 +398,6 @@ static inline bool platform_pci_power_ma
 	return pci_platform_pm ? pci_platform_pm->is_manageable(dev) : false;
 }
 
-static inline int platform_pci_set_power_state(struct pci_dev *dev,
-                                                pci_power_t t)
-{
-	return pci_platform_pm ? pci_platform_pm->set_state(dev, t) : -ENOSYS;
-}
-
 static inline pci_power_t platform_pci_choose_state(struct pci_dev *dev)
 {
 	return pci_platform_pm ?
@@ -540,6 +534,31 @@ void pci_update_current_state(struct pci
 }
 
 /**
+ * platform_pci_set_power_state - Call platform to change device power state
+ * @dev: PCI device to handle
+ * @state: State to put the device into
+ *
+ * Allow the platform to change the power state of the device, for example via
+ * ACPI _PR0, _PS0 or some such.
+ */
+int platform_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
+{
+	int error = 0;
+
+	if (!pci_platform_pm)
+		return -ENOSYS;
+
+	if (pci_platform_pm->is_manageable(dev))
+		error = pci_platform_pm->set_state(dev, state);
+
+	if (!error)
+		pci_update_current_state(dev, state);
+
+	return error;
+}
+EXPORT_SYMBOL_GPL(platform_pci_set_power_state);
+
+/**
  * pci_set_power_state - Set the power state of a PCI device
  * @dev: PCI device to handle.
  * @state: PCI power state (D0, D1, D2, D3hot) to put the device into.
@@ -556,7 +575,7 @@ void pci_update_current_state(struct pci
  */
 int pci_set_power_state(struct pci_dev *dev, pci_power_t state)
 {
-	int error;
+	int error, platform_error = -ENODEV;
 
 	/* bound the state we're entering */
 	if (state > PCI_D3hot)
@@ -570,36 +589,27 @@ int pci_set_power_state(struct pci_dev *
 		 * it into D0 (which would only happen on boot).
 		 */
 		return 0;
+	else if (state == PCI_D3hot && (dev->dev_flags & PCI_DEV_FLAGS_NO_D3))
+		/*
+		 * This device is quirked not to be put into D3, so don't put it
+		 * in D3
+		 */
+		return 0;
 
 	/* Check if we're already there */
 	if (dev->current_state == state)
 		return 0;
 
-	if (state == PCI_D0) {
-		/*
-		 * Allow the platform to change the state, for example via ACPI
-		 * _PR0, _PS0 and some such, but do not trust it.
-		 */
-		int ret = platform_pci_power_manageable(dev) ?
-			platform_pci_set_power_state(dev, PCI_D0) : 0;
-		if (!ret)
-			pci_update_current_state(dev, PCI_D0);
-	}
-	/* This device is quirked not to be put into D3, so
-	   don't put it in D3 */
-	if (state == PCI_D3hot && (dev->dev_flags & PCI_DEV_FLAGS_NO_D3))
-		return 0;
+	if (state == PCI_D0)
+		platform_error = platform_pci_set_power_state(dev, PCI_D0);
 
 	error = pci_raw_set_power_state(dev, state);
 
-	if (state > PCI_D0 && platform_pci_power_manageable(dev)) {
-		/* Allow the platform to finalize the transition */
-		int ret = platform_pci_set_power_state(dev, state);
-		if (!ret) {
-			pci_update_current_state(dev, state);
-			error = 0;
-		}
-	}
+	if (state > PCI_D0)
+		platform_error = platform_pci_set_power_state(dev, state);
+
+	if (!platform_error)
+		error = 0;
 
 	return error;
 }
Index: linux-2.6/include/linux/pci.h
===================================================================
--- linux-2.6.orig/include/linux/pci.h
+++ linux-2.6/include/linux/pci.h
@@ -689,6 +689,7 @@ size_t pci_get_rom_size(struct pci_dev *
 /* Power management related routines */
 int pci_save_state(struct pci_dev *dev);
 int pci_restore_state(struct pci_dev *dev);
+int platform_pci_set_power_state(struct pci_dev *dev, pci_power_t state);
 int pci_set_power_state(struct pci_dev *dev, pci_power_t state);
 pci_power_t pci_choose_state(struct pci_dev *dev, pm_message_t state);
 bool pci_pme_capable(struct pci_dev *dev, pci_power_t state);
