From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 10/10] PCI PM: Put PM callbacks in the order of
	execution
Date: Wed, 7 Jan 2009 13:12:22 +0100
Message-ID: <200901071312.23056.rjw__22237.0387441062$1231330661$gmane$org@sisk.pl>
References: <200901071301.00139.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200901071301.00139.rjw@sisk.pl>
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
Cc: Greg KH <greg@kroah.com>, pm list <linux-pm@lists.linux-foundation.org>, Linux PCI <linux-pci@vger.kernel.org>, Pavel Machek <pavel@suse.cz>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Put PM callbacks in drivers/pci/pci-driver.c in the order in which
they are executed which makes it much easier to follow the code.

No functional changes should result from this.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Pavel Machek <pavel@suse.cz>
---
 drivers/pci/pci-driver.c |   86 +++++++++++++++++++++++------------------------
 1 file changed, 43 insertions(+), 43 deletions(-)

Index: linux-2.6/drivers/pci/pci-driver.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci-driver.c
+++ linux-2.6/drivers/pci/pci-driver.c
@@ -384,6 +384,19 @@ static int pci_legacy_suspend_late(struc
 	return i;
 }
 
+static int pci_legacy_resume_early(struct device *dev)
+{
+	int error = 0;
+	struct pci_dev * pci_dev = to_pci_dev(dev);
+	struct pci_driver * drv = pci_dev->driver;
+
+	pci_fixup_device(pci_fixup_resume_early, pci_dev);
+
+	if (drv && drv->resume_early)
+		error = drv->resume_early(pci_dev);
+	return error;
+}
+
 static int pci_legacy_resume(struct device *dev)
 {
 	int error;
@@ -402,19 +415,6 @@ static int pci_legacy_resume(struct devi
 	return error;
 }
 
-static int pci_legacy_resume_early(struct device *dev)
-{
-	int error = 0;
-	struct pci_dev * pci_dev = to_pci_dev(dev);
-	struct pci_driver * drv = pci_dev->driver;
-
-	pci_fixup_device(pci_fixup_resume_early, pci_dev);
-
-	if (drv && drv->resume_early)
-		error = drv->resume_early(pci_dev);
-	return error;
-}
-
 /* Auxiliary functions used by the new power management framework */
 
 static int pci_restore_standard_config(struct pci_dev *pci_dev)
@@ -571,36 +571,36 @@ static int pci_pm_suspend_noirq(struct d
 	return error;
 }
 
-static int pci_pm_resume(struct device *dev)
+static int pci_pm_resume_noirq(struct device *dev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	struct device_driver *drv = dev->driver;
 	int error = 0;
 
 	if (pci_has_legacy_pm_support(pci_dev))
-		return pci_legacy_resume(dev);
+		return pci_legacy_resume_early(dev);
 
-	error = pci_pm_default_resume(pci_dev);
+	pci_pm_default_resume_noirq(pci_dev);
 
-	if (!error && drv && drv->pm && drv->pm->resume)
-		error = drv->pm->resume(dev);
+	if (drv && drv->pm && drv->pm->resume_noirq)
+		error = drv->pm->resume_noirq(dev);
 
 	return error;
 }
 
-static int pci_pm_resume_noirq(struct device *dev)
+static int pci_pm_resume(struct device *dev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	struct device_driver *drv = dev->driver;
 	int error = 0;
 
 	if (pci_has_legacy_pm_support(pci_dev))
-		return pci_legacy_resume_early(dev);
+		return pci_legacy_resume(dev);
 
-	pci_pm_default_resume_noirq(pci_dev);
+	error = pci_pm_default_resume(pci_dev);
 
-	if (drv && drv->pm && drv->pm->resume_noirq)
-		error = drv->pm->resume_noirq(dev);
+	if (!error && drv && drv->pm && drv->pm->resume)
+		error = drv->pm->resume(dev);
 
 	return error;
 }
@@ -656,36 +656,36 @@ static int pci_pm_freeze_noirq(struct de
 	return error;
 }
 
-static int pci_pm_thaw(struct device *dev)
+static int pci_pm_thaw_noirq(struct device *dev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	struct device_driver *drv = dev->driver;
 	int error = 0;
 
 	if (pci_has_legacy_pm_support(pci_dev))
-		return pci_legacy_resume(dev);
+		return pci_legacy_resume_early(dev);
 
-	pci_pm_reenable_device(pci_dev);
+	pci_update_current_state(pci_dev, PCI_D0);
 
-	if (drv && drv->pm && drv->pm->thaw)
-		error =  drv->pm->thaw(dev);
+	if (drv && drv->pm && drv->pm->thaw_noirq)
+		error = drv->pm->thaw_noirq(dev);
 
 	return error;
 }
 
-static int pci_pm_thaw_noirq(struct device *dev)
+static int pci_pm_thaw(struct device *dev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	struct device_driver *drv = dev->driver;
 	int error = 0;
 
 	if (pci_has_legacy_pm_support(pci_dev))
-		return pci_legacy_resume_early(dev);
+		return pci_legacy_resume(dev);
 
-	pci_update_current_state(pci_dev, PCI_D0);
+	pci_pm_reenable_device(pci_dev);
 
-	if (drv && drv->pm && drv->pm->thaw_noirq)
-		error = drv->pm->thaw_noirq(dev);
+	if (drv && drv->pm && drv->pm->thaw)
+		error =  drv->pm->thaw(dev);
 
 	return error;
 }
@@ -726,36 +726,36 @@ static int pci_pm_poweroff_noirq(struct 
 	return error;
 }
 
-static int pci_pm_restore(struct device *dev)
+static int pci_pm_restore_noirq(struct device *dev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	struct device_driver *drv = dev->driver;
 	int error = 0;
 
 	if (pci_has_legacy_pm_support(pci_dev))
-		return pci_legacy_resume(dev);
+		return pci_legacy_resume_early(dev);
 
-	error = pci_pm_default_resume(pci_dev);
+	pci_pm_default_resume_noirq(pci_dev);
 
-	if (!error && drv && drv->pm && drv->pm->restore)
-		error = drv->pm->restore(dev);
+	if (drv && drv->pm && drv->pm->restore_noirq)
+		error = drv->pm->restore_noirq(dev);
 
 	return error;
 }
 
-static int pci_pm_restore_noirq(struct device *dev)
+static int pci_pm_restore(struct device *dev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	struct device_driver *drv = dev->driver;
 	int error = 0;
 
 	if (pci_has_legacy_pm_support(pci_dev))
-		return pci_legacy_resume_early(dev);
+		return pci_legacy_resume(dev);
 
-	pci_pm_default_resume_noirq(pci_dev);
+	error = pci_pm_default_resume(pci_dev);
 
-	if (drv && drv->pm && drv->pm->restore_noirq)
-		error = drv->pm->restore_noirq(dev);
+	if (!error && drv && drv->pm && drv->pm->restore)
+		error = drv->pm->restore(dev);
 
 	return error;
 }
