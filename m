From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 6/10] PCI PM: Rearrange code in pci-driver.c
	(rev. 2)
Date: Wed, 7 Jan 2009 13:08:45 +0100
Message-ID: <200901071308.46185.rjw__4957.24215074933$1231330649$gmane$org@sisk.pl>
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

Rename two functions and rearrange code in drivers/pci/pci-driver.c
so that it's easier to follow.  In particular, separate invocations
of the legacy callbacks from the rest of the new callbacks' code.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/pci/pci-driver.c |  118 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 77 insertions(+), 41 deletions(-)

Index: linux-2.6/drivers/pci/pci-driver.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci-driver.c
+++ linux-2.6/drivers/pci/pci-driver.c
@@ -318,7 +318,7 @@ static void pci_device_shutdown(struct d
  * Default "suspend" method for devices that have no driver provided suspend,
  * or not even a driver at all (second part).
  */
-static void pci_default_pm_suspend_late(struct pci_dev *pci_dev)
+static void pci_pm_set_unknown_state(struct pci_dev *pci_dev)
 {
 	/*
 	 * mark its power state as "unknown", since we don't know if
@@ -332,7 +332,7 @@ static void pci_default_pm_suspend_late(
  * Default "resume" method for devices that have no driver provided resume,
  * or not even a driver at all (second part).
  */
-static int pci_default_pm_resume_late(struct pci_dev *pci_dev)
+static int pci_pm_reenable_device(struct pci_dev *pci_dev)
 {
 	int retval;
 
@@ -363,7 +363,7 @@ static int pci_legacy_suspend(struct dev
 		 * This is for compatibility with existing code with legacy PM
 		 * support.
 		 */
-		pci_default_pm_suspend_late(pci_dev);
+		pci_pm_set_unknown_state(pci_dev);
 	}
 	return i;
 }
@@ -392,7 +392,7 @@ static int pci_legacy_resume(struct devi
 	} else {
 		/* restore the PCI config space */
 		pci_restore_state(pci_dev);
-		error = pci_default_pm_resume_late(pci_dev);
+		error = pci_pm_reenable_device(pci_dev);
 	}
 	return error;
 }
@@ -459,7 +459,7 @@ static int pci_pm_default_resume(struct 
 	if (!pci_is_bridge(pci_dev))
 		pci_enable_wake(pci_dev, PCI_D0, false);
 
-	return pci_default_pm_resume_late(pci_dev);
+	return pci_pm_reenable_device(pci_dev);
 }
 
 static void pci_pm_default_suspend_generic(struct pci_dev *pci_dev)
@@ -485,8 +485,18 @@ static bool pci_has_legacy_pm_support(st
 {
 	struct pci_driver *drv = pci_dev->driver;
 
-	return drv && (drv->suspend || drv->suspend_late || drv->resume
-		|| drv->resume_early);
+	if (!drv)
+		return false;
+
+	/*
+	 * Legacy PM support is used by default, so warn if the new framework is
+	 * supported as well.  Drivers are supposed to support either the
+	 * former, or the latter, but not both at the same time.
+	 */
+	WARN_ON(drv->driver.pm);
+
+	return drv->suspend || drv->suspend_late || drv->resume
+		|| drv->resume_early;
 }
 
 /* New power management framework */
@@ -518,17 +528,21 @@ static int pci_pm_suspend(struct device 
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
@@ -540,15 +554,16 @@ static int pci_pm_suspend_noirq(struct d
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
@@ -560,14 +575,16 @@ static int pci_pm_resume(struct device *
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
@@ -581,14 +598,16 @@ static int pci_pm_resume_noirq(struct de
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
@@ -613,14 +632,17 @@ static int pci_pm_freeze(struct device *
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
@@ -634,15 +656,16 @@ static int pci_pm_freeze_noirq(struct de
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
@@ -654,14 +677,16 @@ static int pci_pm_thaw(struct device *de
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
@@ -673,12 +698,14 @@ static int pci_pm_thaw_noirq(struct devi
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
@@ -692,17 +719,21 @@ static int pci_pm_poweroff(struct device
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
@@ -713,13 +744,14 @@ static int pci_pm_poweroff_noirq(struct 
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
@@ -731,14 +763,16 @@ static int pci_pm_restore(struct device 
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
@@ -752,14 +786,16 @@ static int pci_pm_restore_noirq(struct d
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
