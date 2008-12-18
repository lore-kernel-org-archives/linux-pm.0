From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH] PCI: Make new suspend-resume callbacks
	carry out core operations
Date: Fri, 19 Dec 2008 00:49:33 +0100
Message-ID: <200812190049.34343.rjw__13856.4206580215$1229644599$gmane$org@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
Cc: Matthew Wilcox <matthew@wil.cx>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, "H. Peter Anvin" <hpa@zytor.com>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi Len,

The patch below adds the callbacks that save/restore the standard PCI config
registers, change the power state of the device etc. to the new suspend-resume
callbacks (which are not yet used by device drivers), so that the drivers don't
have to worry about these operations.

The saving and restoring of the standard PCI config registers is done with
interrupts off, the other things are done with interrupts enabled.

The patch should apply to the current linux-next tree.

Please have a look.

Thanks,
Rafael

---
 drivers/pci/pci-driver.c |   40 +++++++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 13 deletions(-)

Index: linux-2.6/drivers/pci/pci-driver.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci-driver.c
+++ linux-2.6/drivers/pci/pci-driver.c
@@ -435,10 +435,13 @@ static int pci_pm_suspend(struct device 
 	int error = 0;
 
 	if (drv && drv->pm) {
-		if (drv->pm->suspend) {
+		if (drv->pm->suspend)
 			error = drv->pm->suspend(dev);
-			suspend_report_result(drv->pm->suspend, error);
+		if (!error) {
+			pci_disable_device(pci_dev);
+			error = pci_prepare_to_sleep(pci_dev);
 		}
+		suspend_report_result(drv->pm->suspend, error);
 	} else if (pci_has_legacy_pm_support(pci_dev)) {
 		error = pci_legacy_suspend(dev, PMSG_SUSPEND);
 	}
@@ -454,10 +457,11 @@ static int pci_pm_suspend_noirq(struct d
 	int error = 0;
 
 	if (drv && drv->pm) {
-		if (drv->pm->suspend_noirq) {
+		if (drv->pm->suspend_noirq)
 			error = drv->pm->suspend_noirq(dev);
-			suspend_report_result(drv->pm->suspend_noirq, error);
-		}
+		if (!error)
+			pci_save_state(pci_dev);
+		suspend_report_result(drv->pm->suspend_noirq, error);
 	} else if (pci_has_legacy_pm_support(pci_dev)) {
 		error = pci_legacy_suspend_late(dev, PMSG_SUSPEND);
 	} else {
@@ -476,6 +480,7 @@ static int pci_pm_resume(struct device *
 	pci_fixup_device(pci_fixup_resume, pci_dev);
 
 	if (drv && drv->pm) {
+		pci_enable_device(pci_dev);
 		if (drv->pm->resume)
 			error = drv->pm->resume(dev);
 	} else if (pci_has_legacy_pm_support(pci_dev)) {
@@ -496,6 +501,7 @@ static int pci_pm_resume_noirq(struct de
 	pci_fixup_device(pci_fixup_resume_early, to_pci_dev(dev));
 
 	if (drv && drv->pm) {
+		pci_restore_state(pci_dev);
 		if (drv->pm->resume_noirq)
 			error = drv->pm->resume_noirq(dev);
 	} else if (pci_has_legacy_pm_support(pci_dev)) {
@@ -525,10 +531,11 @@ static int pci_pm_freeze(struct device *
 	int error = 0;
 
 	if (drv && drv->pm) {
-		if (drv->pm->freeze) {
+		if (drv->pm->freeze)
 			error = drv->pm->freeze(dev);
-			suspend_report_result(drv->pm->freeze, error);
-		}
+		if (!error)
+			pci_disable_device(pci_dev);
+		suspend_report_result(drv->pm->freeze, error);
 	} else if (pci_has_legacy_pm_support(pci_dev)) {
 		error = pci_legacy_suspend(dev, PMSG_FREEZE);
 		pci_fixup_device(pci_fixup_suspend, pci_dev);
@@ -544,10 +551,11 @@ static int pci_pm_freeze_noirq(struct de
 	int error = 0;
 
 	if (drv && drv->pm) {
-		if (drv->pm->freeze_noirq) {
+		if (drv->pm->freeze_noirq)
 			error = drv->pm->freeze_noirq(dev);
-			suspend_report_result(drv->pm->freeze_noirq, error);
-		}
+		if (!error)
+			pci_save_state(pci_dev);
+		suspend_report_result(drv->pm->freeze_noirq, error);
 	} else if (pci_has_legacy_pm_support(pci_dev)) {
 		error = pci_legacy_suspend_late(dev, PMSG_FREEZE);
 	} else {
@@ -564,6 +572,7 @@ static int pci_pm_thaw(struct device *de
 	int error = 0;
 
 	if (drv && drv->pm) {
+		pci_enable_device(pci_dev);
 		if (drv->pm->thaw)
 			error =  drv->pm->thaw(dev);
 	} else if (pci_has_legacy_pm_support(pci_dev)) {
@@ -600,10 +609,13 @@ static int pci_pm_poweroff(struct device
 	pci_fixup_device(pci_fixup_suspend, pci_dev);
 
 	if (drv && drv->pm) {
-		if (drv->pm->poweroff) {
+		if (drv->pm->poweroff)
 			error = drv->pm->poweroff(dev);
-			suspend_report_result(drv->pm->poweroff, error);
+		if (!error) {
+			pci_disable_device(pci_dev);
+			error = pci_prepare_to_sleep(pci_dev);
 		}
+		suspend_report_result(drv->pm->poweroff, error);
 	} else if (pci_has_legacy_pm_support(pci_dev)) {
 		error = pci_legacy_suspend(dev, PMSG_HIBERNATE);
 	}
@@ -635,6 +647,7 @@ static int pci_pm_restore(struct device 
 	int error = 0;
 
 	if (drv && drv->pm) {
+		pci_enable_device(pci_dev);
 		if (drv->pm->restore)
 			error = drv->pm->restore(dev);
 	} else if (pci_has_legacy_pm_support(pci_dev)) {
@@ -656,6 +669,7 @@ static int pci_pm_restore_noirq(struct d
 	pci_fixup_device(pci_fixup_resume, pci_dev);
 
 	if (drv && drv->pm) {
+		pci_restore_state(pci_dev);
 		if (drv->pm->restore_noirq)
 			error = drv->pm->restore_noirq(dev);
 	} else if (pci_has_legacy_pm_support(pci_dev)) {
