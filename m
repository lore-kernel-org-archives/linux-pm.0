From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 7/10] PCI PM: Call pci_fixup_device from
	legacy routines
Date: Tue, 30 Dec 2008 23:44:30 +0100
Message-ID: <200812302344.31719.rjw__12342.594881966$1230677635$gmane$org@sisk.pl>
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


The size of drivers/pci/pci-driver.c can be reduced quite a bit
if pci_fixup_device() is called from the legacy PM callbacks, so make
it happen.

No functional changes should result from this.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/pci/pci-driver.c |   52 +++++++++++++++++------------------------------
 1 file changed, 19 insertions(+), 33 deletions(-)

Index: linux-2.6/drivers/pci/pci-driver.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci-driver.c
+++ linux-2.6/drivers/pci/pci-driver.c
@@ -351,6 +351,9 @@ static int pci_legacy_suspend(struct dev
 		 */
 		pci_pm_set_unknown_state(pci_dev);
 	}
+
+	pci_fixup_device(pci_fixup_suspend, pci_dev);
+
 	return i;
 }
 
@@ -373,6 +376,8 @@ static int pci_legacy_resume(struct devi
 	struct pci_dev * pci_dev = to_pci_dev(dev);
 	struct pci_driver * drv = pci_dev->driver;
 
+	pci_fixup_device(pci_fixup_resume, pci_dev);
+
 	if (drv && drv->resume) {
 		error = drv->resume(pci_dev);
 	} else {
@@ -389,6 +394,8 @@ static int pci_legacy_resume_early(struc
 	struct pci_dev * pci_dev = to_pci_dev(dev);
 	struct pci_driver * drv = pci_dev->driver;
 
+	pci_fixup_device(pci_fixup_resume_early, pci_dev);
+
 	if (drv && drv->resume_early)
 		error = drv->resume_early(pci_dev);
 	return error;
@@ -504,10 +511,8 @@ static int pci_pm_suspend(struct device 
 	struct device_driver *drv = dev->driver;
 	int error = 0;
 
-	if (pci_has_legacy_pm_support(pci_dev)) {
-		error = pci_legacy_suspend(dev, PMSG_SUSPEND);
-		goto Exit;
-	}
+	if (pci_has_legacy_pm_support(pci_dev))
+		return pci_legacy_suspend(dev, PMSG_SUSPEND);
 
 	if (drv && drv->pm) {
 		if (drv->pm->suspend) {
@@ -518,7 +523,6 @@ static int pci_pm_suspend(struct device 
 		pci_pm_default_suspend(pci_dev);
 	}
 
- Exit:
 	pci_fixup_device(pci_fixup_suspend, pci_dev);
 
 	return error;
@@ -551,10 +555,8 @@ static int pci_pm_resume(struct device *
 	struct device_driver *drv = dev->driver;
 	int error = 0;
 
-	if (pci_has_legacy_pm_support(pci_dev)) {
-		pci_fixup_device(pci_fixup_resume, pci_dev);
+	if (pci_has_legacy_pm_support(pci_dev))
 		return pci_legacy_resume(dev);
-	}
 
 	if (drv && drv->pm) {
 		pci_fixup_device(pci_fixup_resume, pci_dev);
@@ -574,10 +576,8 @@ static int pci_pm_resume_noirq(struct de
 	struct device_driver *drv = dev->driver;
 	int error = 0;
 
-	if (pci_has_legacy_pm_support(pci_dev)) {
-		pci_fixup_device(pci_fixup_resume_early, pci_dev);
+	if (pci_has_legacy_pm_support(pci_dev))
 		return pci_legacy_resume_early(dev);
-	}
 
 	if (drv && drv->pm) {
 		pci_fixup_device(pci_fixup_resume_early, pci_dev);
@@ -608,11 +608,8 @@ static int pci_pm_freeze(struct device *
 	struct device_driver *drv = dev->driver;
 	int error = 0;
 
-	if (pci_has_legacy_pm_support(pci_dev)) {
-		error = pci_legacy_suspend(dev, PMSG_FREEZE);
-		pci_fixup_device(pci_fixup_suspend, pci_dev);
-		return error;
-	}
+	if (pci_has_legacy_pm_support(pci_dev))
+		return pci_legacy_suspend(dev, PMSG_FREEZE);
 
 	if (drv && drv->pm) {
 		if (drv->pm->freeze) {
@@ -653,10 +650,8 @@ static int pci_pm_thaw(struct device *de
 	struct device_driver *drv = dev->driver;
 	int error = 0;
 
-	if (pci_has_legacy_pm_support(pci_dev)) {
-		pci_fixup_device(pci_fixup_resume, pci_dev);
+	if (pci_has_legacy_pm_support(pci_dev))
 		return pci_legacy_resume(dev);
-	}
 
 	if (drv && drv->pm) {
 		if (drv->pm->thaw)
@@ -674,10 +669,8 @@ static int pci_pm_thaw_noirq(struct devi
 	struct device_driver *drv = dev->driver;
 	int error = 0;
 
-	if (pci_has_legacy_pm_support(pci_dev)) {
-		pci_fixup_device(pci_fixup_resume_early, to_pci_dev(dev));
+	if (pci_has_legacy_pm_support(pci_dev))
 		return pci_legacy_resume_early(dev);
-	}
 
 	if (drv && drv->pm) {
 		if (drv->pm->thaw_noirq)
@@ -695,10 +688,8 @@ static int pci_pm_poweroff(struct device
 	struct device_driver *drv = dev->driver;
 	int error = 0;
 
-	if (pci_has_legacy_pm_support(pci_dev)) {
-		error = pci_legacy_suspend(dev, PMSG_HIBERNATE);
-		goto Exit;
-	}
+	if (pci_has_legacy_pm_support(pci_dev))
+		return pci_legacy_suspend(dev, PMSG_HIBERNATE);
 
 	if (drv && drv->pm) {
 		if (drv->pm->poweroff) {
@@ -709,7 +700,6 @@ static int pci_pm_poweroff(struct device
 		pci_pm_default_suspend(pci_dev);
 	}
 
- Exit:
 	pci_fixup_device(pci_fixup_suspend, pci_dev);
 
 	return error;
@@ -739,10 +729,8 @@ static int pci_pm_restore(struct device 
 	struct device_driver *drv = dev->driver;
 	int error = 0;
 
-	if (pci_has_legacy_pm_support(pci_dev)) {
-		pci_fixup_device(pci_fixup_resume, pci_dev);
+	if (pci_has_legacy_pm_support(pci_dev))
 		return pci_legacy_resume(dev);
-	}
 
 	if (drv && drv->pm) {
 		pci_fixup_device(pci_fixup_resume, pci_dev);
@@ -762,10 +750,8 @@ static int pci_pm_restore_noirq(struct d
 	struct device_driver *drv = dev->driver;
 	int error = 0;
 
-	if (pci_has_legacy_pm_support(pci_dev)) {
-		pci_fixup_device(pci_fixup_resume_early, pci_dev);
+	if (pci_has_legacy_pm_support(pci_dev))
 		return pci_legacy_resume_early(dev);
-	}
 
 	if (drv && drv->pm) {
 		pci_fixup_device(pci_fixup_resume_early, pci_dev);
