From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 3/10] PCI PM: Power-manage devices without
	drivers during suspend-resume
Date: Wed, 7 Jan 2009 13:05:05 +0100
Message-ID: <200901071305.06095.rjw__25151.7294710085$1231330687$gmane$org@sisk.pl>
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

PCI devices without drivers can be put into low power states during
suspend with the help of pci_prepare_to_sleep() and prevented from
generating wake-up events during resume with the help of
pci_enable_wake().  However, it's better not to put bridges into
low power states during suspend, because that might result in entire
bus segments being powered off.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Pavel Machek <pavel@suse.cz>
---
 drivers/pci/pci-driver.c |   33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

Index: linux-2.6/drivers/pci/pci-driver.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci-driver.c
+++ linux-2.6/drivers/pci/pci-driver.c
@@ -435,6 +435,31 @@ static int pci_legacy_resume_early(struc
 	return error;
 }
 
+/* Auxiliary functions used by the new power management framework */
+
+static bool pci_is_bridge(struct pci_dev *pci_dev)
+{
+	return !!(pci_dev->subordinate);
+}
+
+static int pci_pm_default_resume(struct pci_dev *pci_dev)
+{
+	if (!pci_is_bridge(pci_dev))
+		pci_enable_wake(pci_dev, PCI_D0, false);
+
+	return pci_default_pm_resume_late(pci_dev);
+}
+
+static void pci_pm_default_suspend(struct pci_dev *pci_dev)
+{
+	pci_default_pm_suspend_early(pci_dev);
+
+	if (!pci_is_bridge(pci_dev))
+		pci_prepare_to_sleep(pci_dev);
+}
+
+/* New power management framework */
+
 static int pci_pm_prepare(struct device *dev)
 {
 	struct device_driver *drv = dev->driver;
@@ -470,7 +495,7 @@ static int pci_pm_suspend(struct device 
 	} else if (pci_has_legacy_pm_support(pci_dev)) {
 		error = pci_legacy_suspend(dev, PMSG_SUSPEND);
 	} else {
-		pci_default_pm_suspend_early(pci_dev);
+		pci_pm_default_suspend(pci_dev);
 	}
 
 	pci_fixup_device(pci_fixup_suspend, pci_dev);
@@ -512,7 +537,7 @@ static int pci_pm_resume(struct device *
 	} else if (pci_has_legacy_pm_support(pci_dev)) {
 		error = pci_legacy_resume(dev);
 	} else {
-		error = pci_default_pm_resume_late(pci_dev);
+		error = pci_pm_default_resume(pci_dev);
 	}
 
 	return error;
@@ -642,7 +667,7 @@ static int pci_pm_poweroff(struct device
 	} else if (pci_has_legacy_pm_support(pci_dev)) {
 		error = pci_legacy_suspend(dev, PMSG_HIBERNATE);
 	} else {
-		pci_default_pm_suspend_early(pci_dev);
+		pci_pm_default_suspend(pci_dev);
 	}
 
 	pci_fixup_device(pci_fixup_suspend, pci_dev);
@@ -681,7 +706,7 @@ static int pci_pm_restore(struct device 
 	} else if (pci_has_legacy_pm_support(pci_dev)) {
 		error = pci_legacy_resume(dev);
 	} else {
-		error = pci_default_pm_resume_late(pci_dev);
+		error = pci_pm_default_resume(pci_dev);
 	}
 
 	return error;
