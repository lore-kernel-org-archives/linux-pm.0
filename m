From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 7/10] PCI PM: Call pci_fixup_device from legacy
	routines
Date: Wed, 7 Jan 2009 13:09:37 +0100
Message-ID: <200901071309.38451.rjw__13402.7754924775$1231330633$gmane$org@sisk.pl>
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

The size of drivers/pci/pci-driver.c can be reduced quite a bit
if pci_fixup_device() is called from the legacy PM callbacks, so make
it happen.

No functional changes should result from this.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Pavel Machek <pavel@suse.cz>
---
 drivers/pci/pci-driver.c |   52 +++++++++++++++++------------------------------
 1 file changed, 19 insertions(+), 33 deletions(-)

Index: linux-2.6/drivers/pci/pci-driver.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci-driver.c
+++ linux-2.6/drivers/pci/pci-driver.c
@@ -365,6 +365,9 @@ static int pci_legacy_suspend(struct dev
 		 */
 		pci_pm_set_unknown_state(pci_dev);
 	}
+
+	pci_fixup_device(pci_fixup_suspend, pci_dev);
+
 	return i;
 }
 
@@ -387,6 +390,8 @@ static int pci_legacy_resume(struct devi
 	struct pci_dev * pci_dev = to_pci_dev(dev);
 	struct pci_driver * drv = pci_dev->driver;
 
+	pci_fixup_device(pci_fixup_resume, pci_dev);
+
 	if (drv && drv->resume) {
 		error = drv->resume(pci_dev);
 	} else {
@@ -403,6 +408,8 @@ static int pci_legacy_resume_early(struc
 	struct pci_dev * pci_dev = to_pci_dev(dev);
 	struct pci_driver * drv = pci_dev->driver;
 
+	pci_fixup_device(pci_fixup_resume_early, pci_dev);
+
 	if (drv && drv->resume_early)
 		error = drv->resume_early(pci_dev);
 	return error;
@@ -528,10 +535,8 @@ static int pci_pm_suspend(struct device 
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
@@ -542,7 +547,6 @@ static int pci_pm_suspend(struct device 
 		pci_pm_default_suspend(pci_dev);
 	}
 
- Exit:
 	pci_fixup_device(pci_fixup_suspend, pci_dev);
 
 	return error;
@@ -575,10 +579,8 @@ static int pci_pm_resume(struct device *
 	struct device_driver *drv = dev->driver;
 	int error = 0;
 
-	if (pci_has_legacy_pm_support(pci_dev)) {
-		pci_fixup_device(pci_fixup_resume, pci_dev);
+	if (pci_has_legacy_pm_support(pci_dev))
 		return pci_legacy_resume(dev);
-	}
 
 	if (drv && drv->pm) {
 		pci_fixup_device(pci_fixup_resume, pci_dev);
@@ -598,10 +600,8 @@ static int pci_pm_resume_noirq(struct de
 	struct device_driver *drv = dev->driver;
 	int error = 0;
 
-	if (pci_has_legacy_pm_support(pci_dev)) {
-		pci_fixup_device(pci_fixup_resume_early, pci_dev);
+	if (pci_has_legacy_pm_support(pci_dev))
 		return pci_legacy_resume_early(dev);
-	}
 
 	if (drv && drv->pm) {
 		pci_fixup_device(pci_fixup_resume_early, pci_dev);
@@ -632,11 +632,8 @@ static int pci_pm_freeze(struct device *
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
@@ -677,10 +674,8 @@ static int pci_pm_thaw(struct device *de
 	struct device_driver *drv = dev->driver;
 	int error = 0;
 
-	if (pci_has_legacy_pm_support(pci_dev)) {
-		pci_fixup_device(pci_fixup_resume, pci_dev);
+	if (pci_has_legacy_pm_support(pci_dev))
 		return pci_legacy_resume(dev);
-	}
 
 	if (drv && drv->pm) {
 		if (drv->pm->thaw)
@@ -698,10 +693,8 @@ static int pci_pm_thaw_noirq(struct devi
 	struct device_driver *drv = dev->driver;
 	int error = 0;
 
-	if (pci_has_legacy_pm_support(pci_dev)) {
-		pci_fixup_device(pci_fixup_resume_early, to_pci_dev(dev));
+	if (pci_has_legacy_pm_support(pci_dev))
 		return pci_legacy_resume_early(dev);
-	}
 
 	if (drv && drv->pm) {
 		if (drv->pm->thaw_noirq)
@@ -719,10 +712,8 @@ static int pci_pm_poweroff(struct device
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
@@ -733,7 +724,6 @@ static int pci_pm_poweroff(struct device
 		pci_pm_default_suspend(pci_dev);
 	}
 
- Exit:
 	pci_fixup_device(pci_fixup_suspend, pci_dev);
 
 	return error;
@@ -763,10 +753,8 @@ static int pci_pm_restore(struct device 
 	struct device_driver *drv = dev->driver;
 	int error = 0;
 
-	if (pci_has_legacy_pm_support(pci_dev)) {
-		pci_fixup_device(pci_fixup_resume, pci_dev);
+	if (pci_has_legacy_pm_support(pci_dev))
 		return pci_legacy_resume(dev);
-	}
 
 	if (drv && drv->pm) {
 		pci_fixup_device(pci_fixup_resume, pci_dev);
@@ -786,10 +774,8 @@ static int pci_pm_restore_noirq(struct d
 	struct device_driver *drv = dev->driver;
 	int error = 0;
 
-	if (pci_has_legacy_pm_support(pci_dev)) {
-		pci_fixup_device(pci_fixup_resume_early, pci_dev);
+	if (pci_has_legacy_pm_support(pci_dev))
 		return pci_legacy_resume_early(dev);
-	}
 
 	if (drv && drv->pm) {
 		pci_fixup_device(pci_fixup_resume_early, pci_dev);
