From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 3/10] PCI PM: Power-manage devices without
	drivers during suspend-resume
Date: Tue, 30 Dec 2008 23:38:41 +0100
Message-ID: <200812302338.42915.rjw__15063.6758575731$1230677564$gmane$org@sisk.pl>
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


PCI devices without drivers can be put into low power states during
suspend with the help of pci_prepare_to_sleep() and prevented from
generating wake-up events during resume with the help of
pci_enable_wake().  However, it's better not to put bridges into
low power states during suspend, because that might result in entire
bus segments being powered off.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/pci/pci-driver.c |   33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

Index: linux-2.6/drivers/pci/pci-driver.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci-driver.c
+++ linux-2.6/drivers/pci/pci-driver.c
@@ -421,6 +421,31 @@ static int pci_legacy_resume_early(struc
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
@@ -456,7 +481,7 @@ static int pci_pm_suspend(struct device 
 	} else if (pci_has_legacy_pm_support(pci_dev)) {
 		error = pci_legacy_suspend(dev, PMSG_SUSPEND);
 	} else {
-		pci_default_pm_suspend_early(pci_dev);
+		pci_pm_default_suspend(pci_dev);
 	}
 
 	pci_fixup_device(pci_fixup_suspend, pci_dev);
@@ -498,7 +523,7 @@ static int pci_pm_resume(struct device *
 	} else if (pci_has_legacy_pm_support(pci_dev)) {
 		error = pci_legacy_resume(dev);
 	} else {
-		error = pci_default_pm_resume_late(pci_dev);
+		error = pci_pm_default_resume(pci_dev);
 	}
 
 	return error;
@@ -628,7 +653,7 @@ static int pci_pm_poweroff(struct device
 	} else if (pci_has_legacy_pm_support(pci_dev)) {
 		error = pci_legacy_suspend(dev, PMSG_HIBERNATE);
 	} else {
-		pci_default_pm_suspend_early(pci_dev);
+		pci_pm_default_suspend(pci_dev);
 	}
 
 	pci_fixup_device(pci_fixup_suspend, pci_dev);
@@ -667,7 +692,7 @@ static int pci_pm_restore(struct device 
 	} else if (pci_has_legacy_pm_support(pci_dev)) {
 		error = pci_legacy_resume(dev);
 	} else {
-		error = pci_default_pm_resume_late(pci_dev);
+		error = pci_pm_default_resume(pci_dev);
 	}
 
 	return error;
