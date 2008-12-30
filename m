From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 6/10] PCI PM: Rearrange code in pci-driver.c
Date: Tue, 30 Dec 2008 23:43:06 +0100
Message-ID: <200812302343.07164.rjw__33208.7769326337$1230677604$gmane$org@sisk.pl>
References: <200812190049.34343.rjw@sisk.pl> <200812281607.28007.rjw@sisk.pl>
	<200812302333.45560.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200812302333.45560.rjw@sisk.pl>
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
To: Len Brown <lenb@kernel.org>
Cc: Matthew Wilcox <matthew@wil.cx>, Greg KH <greg@kroah.com>, Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Pavel Machek <pavel@suse.cz>, "H. Peter Anvin" <hpa@zytor.com>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


Rename two functions and rearrange code in drivers/pci/pci-driver.c
so that it's easier to follow.  In particular, separate invocations
of the legacy callbacks from the rest of the new callbacks' code.

No functional changes should result from this.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/pci/pci-driver.c |  104 +++++++++++++++++++++++++++++------------------
 1 file changed, 65 insertions(+), 39 deletions(-)

Index: linux-2.6/drivers/pci/pci-driver.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci-driver.c
+++ linux-2.6/drivers/pci/pci-driver.c
@@ -304,7 +304,7 @@ static void pci_device_shutdown(struct d
  * Default "suspend" method for devices that have no driver provided suspend,
  * or not even a driver at all (second part).
  */
-static void pci_default_pm_suspend_late(struct pci_dev *pci_dev)
+static void pci_pm_set_unknown_state(struct pci_dev *pci_dev)
 {
 	/*
 	 * mark its power state as "unknown", since we don't know if
@@ -318,7 +318,7 @@ static void pci_default_pm_suspend_late(
  * Default "resume" method for devices that have no driver provided resume,
  * or not even a driver at all (second part).
  */
-static int pci_default_pm_resume_late(struct pci_dev *pci_dev)
+static int pci_pm_reenable_device(struct pci_dev *pci_dev)
 {
 	int retval;
 
@@ -349,7 +349,7 @@ static int pci_legacy_suspend(struct dev
 		 * This is for compatibility with existing code with legacy PM
 		 * support.
 		 */
-		pci_default_pm_suspend_late(pci_dev);
+		pci_pm_set_unknown_state(pci_dev);
 	}
 	return i;
 }
@@ -378,7 +378,7 @@ static int pci_legacy_resume(struct devi
 	} else {
 		/* restore the PCI config space */
 		pci_restore_state(pci_dev);
-		error = pci_default_pm_resume_late(pci_dev);
+		error = pci_pm_reenable_device(pci_dev);
 	}
 	return error;
 }
@@ -445,7 +445,7 @@ static int pci_pm_default_resume(struct 
 	if (!pci_is_bridge(pci_dev))
 		pci_enable_wake(pci_dev, PCI_D0, false);
 
-	return pci_default_pm_resume_late(pci_dev);
+	return pci_pm_reenable_device(pci_dev);
 }
 
 static void pci_pm_default_suspend_generic(struct pci_dev *pci_dev)
@@ -504,17 +504,21 @@ static int pci_pm_suspend(struct device 
 	struct device_driver *drv = dev->driver;
 	int error = 0;
 
+	if (pci_has_legacy_pm_support(pci_dev)) {
+		error = pci_legacy_suspend(dev, PMSG_SUSPEND);
+		goto Exit;
+	}
+
 	if (drv && drv->pm) {
 		if (drv->pm->suspend) {
 			error = drv->pm->suspend(dev);
 			suspend_report_result(drv->pm->suspend, error);
 		}
-	} else if (pci_has_legacy_pm_support(pci_dev)) {
-		error = pci_legacy_suspend(dev, PMSG_SUSPEND);
 	} else {
 		pci_pm_default_suspend(pci_dev);
 	}
 
+ Exit:
 	pci_fixup_device(pci_fixup_suspend, pci_dev);
 
 	return error;
@@ -526,15 +530,16 @@ static int pci_pm_suspend_noirq(struct d
 	struct device_driver *drv = dev->driver;
 	int error = 0;
 
+	if (pci_has_legacy_pm_support(pci_dev))
+		return pci_legacy_suspend_late(dev, PMSG_SUSPEND);
+
 	if (drv && drv->pm) {
 		if (drv->pm->suspend_noirq) {
 			error = drv->pm->suspend_noirq(dev);
 			suspend_report_result(drv->pm->suspend_noirq, error);
 		}
-	} else if (pci_has_legacy_pm_support(pci_dev)) {
-		error = pci_legacy_suspend_late(dev, PMSG_SUSPEND);
 	} else {
-		pci_default_pm_suspend_late(pci_dev);
+		pci_pm_set_unknown_state(pci_dev);
 	}
 
 	return error;
@@ -546,14 +551,16 @@ static int pci_pm_resume(struct device *
 	struct device_driver *drv = dev->driver;
 	int error = 0;
 
+	if (pci_has_legacy_pm_support(pci_dev)) {
+		pci_fixup_device(pci_fixup_resume, pci_dev);
+		return pci_legacy_resume(dev);
+	}
+
 	if (drv && drv->pm) {
 		pci_fixup_device(pci_fixup_resume, pci_dev);
 
 		if (drv->pm->resume)
 			error = drv->pm->resume(dev);
-	} else if (pci_has_legacy_pm_support(pci_dev)) {
-		pci_fixup_device(pci_fixup_resume, pci_dev);
-		error = pci_legacy_resume(dev);
 	} else {
 		error = pci_pm_default_resume(pci_dev);
 	}
@@ -567,14 +574,16 @@ static int pci_pm_resume_noirq(struct de
 	struct device_driver *drv = dev->driver;
 	int error = 0;
 
+	if (pci_has_legacy_pm_support(pci_dev)) {
+		pci_fixup_device(pci_fixup_resume_early, pci_dev);
+		return pci_legacy_resume_early(dev);
+	}
+
 	if (drv && drv->pm) {
 		pci_fixup_device(pci_fixup_resume_early, pci_dev);
 
 		if (drv->pm->resume_noirq)
 			error = drv->pm->resume_noirq(dev);
-	} else if (pci_has_legacy_pm_support(pci_dev)) {
-		pci_fixup_device(pci_fixup_resume_early, pci_dev);
-		error = pci_legacy_resume_early(dev);
 	} else {
 		pci_pm_default_resume_noirq(pci_dev);
 	}
@@ -599,14 +608,17 @@ static int pci_pm_freeze(struct device *
 	struct device_driver *drv = dev->driver;
 	int error = 0;
 
+	if (pci_has_legacy_pm_support(pci_dev)) {
+		error = pci_legacy_suspend(dev, PMSG_FREEZE);
+		pci_fixup_device(pci_fixup_suspend, pci_dev);
+		return error;
+	}
+
 	if (drv && drv->pm) {
 		if (drv->pm->freeze) {
 			error = drv->pm->freeze(dev);
 			suspend_report_result(drv->pm->freeze, error);
 		}
-	} else if (pci_has_legacy_pm_support(pci_dev)) {
-		error = pci_legacy_suspend(dev, PMSG_FREEZE);
-		pci_fixup_device(pci_fixup_suspend, pci_dev);
 	} else {
 		pci_pm_default_suspend_generic(pci_dev);
 	}
@@ -620,15 +632,16 @@ static int pci_pm_freeze_noirq(struct de
 	struct device_driver *drv = dev->driver;
 	int error = 0;
 
+	if (pci_has_legacy_pm_support(pci_dev))
+		return pci_legacy_suspend_late(dev, PMSG_FREEZE);
+
 	if (drv && drv->pm) {
 		if (drv->pm->freeze_noirq) {
 			error = drv->pm->freeze_noirq(dev);
 			suspend_report_result(drv->pm->freeze_noirq, error);
 		}
-	} else if (pci_has_legacy_pm_support(pci_dev)) {
-		error = pci_legacy_suspend_late(dev, PMSG_FREEZE);
 	} else {
-		pci_default_pm_suspend_late(pci_dev);
+		pci_pm_set_unknown_state(pci_dev);
 	}
 
 	return error;
@@ -640,14 +653,16 @@ static int pci_pm_thaw(struct device *de
 	struct device_driver *drv = dev->driver;
 	int error = 0;
 
+	if (pci_has_legacy_pm_support(pci_dev)) {
+		pci_fixup_device(pci_fixup_resume, pci_dev);
+		return pci_legacy_resume(dev);
+	}
+
 	if (drv && drv->pm) {
 		if (drv->pm->thaw)
 			error =  drv->pm->thaw(dev);
-	} else if (pci_has_legacy_pm_support(pci_dev)) {
-		pci_fixup_device(pci_fixup_resume, pci_dev);
-		error = pci_legacy_resume(dev);
 	} else {
-		pci_default_pm_resume_late(pci_dev);
+		pci_pm_reenable_device(pci_dev);
 	}
 
 	return error;
@@ -659,12 +674,14 @@ static int pci_pm_thaw_noirq(struct devi
 	struct device_driver *drv = dev->driver;
 	int error = 0;
 
+	if (pci_has_legacy_pm_support(pci_dev)) {
+		pci_fixup_device(pci_fixup_resume_early, to_pci_dev(dev));
+		return pci_legacy_resume_early(dev);
+	}
+
 	if (drv && drv->pm) {
 		if (drv->pm->thaw_noirq)
 			error = drv->pm->thaw_noirq(dev);
-	} else if (pci_has_legacy_pm_support(pci_dev)) {
-		pci_fixup_device(pci_fixup_resume_early, to_pci_dev(dev));
-		error = pci_legacy_resume_early(dev);
 	} else {
 		pci_update_current_state(pci_dev, PCI_D0);
 	}
@@ -678,17 +695,21 @@ static int pci_pm_poweroff(struct device
 	struct device_driver *drv = dev->driver;
 	int error = 0;
 
+	if (pci_has_legacy_pm_support(pci_dev)) {
+		error = pci_legacy_suspend(dev, PMSG_HIBERNATE);
+		goto Exit;
+	}
+
 	if (drv && drv->pm) {
 		if (drv->pm->poweroff) {
 			error = drv->pm->poweroff(dev);
 			suspend_report_result(drv->pm->poweroff, error);
 		}
-	} else if (pci_has_legacy_pm_support(pci_dev)) {
-		error = pci_legacy_suspend(dev, PMSG_HIBERNATE);
 	} else {
 		pci_pm_default_suspend(pci_dev);
 	}
 
+ Exit:
 	pci_fixup_device(pci_fixup_suspend, pci_dev);
 
 	return error;
@@ -699,13 +720,14 @@ static int pci_pm_poweroff_noirq(struct 
 	struct device_driver *drv = dev->driver;
 	int error = 0;
 
+	if (pci_has_legacy_pm_support(to_pci_dev(dev)))
+		return pci_legacy_suspend_late(dev, PMSG_HIBERNATE);
+
 	if (drv && drv->pm) {
 		if (drv->pm->poweroff_noirq) {
 			error = drv->pm->poweroff_noirq(dev);
 			suspend_report_result(drv->pm->poweroff_noirq, error);
 		}
-	} else if (pci_has_legacy_pm_support(to_pci_dev(dev))) {
-		error = pci_legacy_suspend_late(dev, PMSG_HIBERNATE);
 	}
 
 	return error;
@@ -717,14 +739,16 @@ static int pci_pm_restore(struct device 
 	struct device_driver *drv = dev->driver;
 	int error = 0;
 
+	if (pci_has_legacy_pm_support(pci_dev)) {
+		pci_fixup_device(pci_fixup_resume, pci_dev);
+		return pci_legacy_resume(dev);
+	}
+
 	if (drv && drv->pm) {
 		pci_fixup_device(pci_fixup_resume, pci_dev);
 
 		if (drv->pm->restore)
 			error = drv->pm->restore(dev);
-	} else if (pci_has_legacy_pm_support(pci_dev)) {
-		pci_fixup_device(pci_fixup_resume, pci_dev);
-		error = pci_legacy_resume(dev);
 	} else {
 		error = pci_pm_default_resume(pci_dev);
 	}
@@ -738,14 +762,16 @@ static int pci_pm_restore_noirq(struct d
 	struct device_driver *drv = dev->driver;
 	int error = 0;
 
+	if (pci_has_legacy_pm_support(pci_dev)) {
+		pci_fixup_device(pci_fixup_resume_early, pci_dev);
+		return pci_legacy_resume_early(dev);
+	}
+
 	if (drv && drv->pm) {
 		pci_fixup_device(pci_fixup_resume_early, pci_dev);
 
 		if (drv->pm->restore_noirq)
 			error = drv->pm->restore_noirq(dev);
-	} else if (pci_has_legacy_pm_support(pci_dev)) {
-		pci_fixup_device(pci_fixup_resume_early, pci_dev);
-		error = pci_legacy_resume_early(dev);
 	} else {
 		pci_pm_default_resume_noirq(pci_dev);
 	}
