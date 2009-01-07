From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 1/10] PCI PM: Fix poweroff and restore callbacks
Date: Wed, 7 Jan 2009 13:02:36 +0100
Message-ID: <200901071302.36825.rjw__23668.6919154183$1231330685$gmane$org@sisk.pl>
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

pci_fixup_device() is called too early in pci_pm_poweroff() and too
late in pci_pm_restore().  Moreover, pci_pm_restore_noirq() calls
pci_fixup_device() twice and in a wrong way.  Fix that.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Pavel Machek <pavel@suse.cz>
---
 drivers/pci/pci-driver.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

Index: linux-2.6/drivers/pci/pci-driver.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci-driver.c
+++ linux-2.6/drivers/pci/pci-driver.c
@@ -611,8 +611,6 @@ static int pci_pm_poweroff(struct device
 	struct device_driver *drv = dev->driver;
 	int error = 0;
 
-	pci_fixup_device(pci_fixup_suspend, pci_dev);
-
 	if (drv && drv->pm) {
 		if (drv->pm->poweroff) {
 			error = drv->pm->poweroff(dev);
@@ -622,6 +620,8 @@ static int pci_pm_poweroff(struct device
 		error = pci_legacy_suspend(dev, PMSG_HIBERNATE);
 	}
 
+	pci_fixup_device(pci_fixup_suspend, pci_dev);
+
 	return error;
 }
 
@@ -648,6 +648,8 @@ static int pci_pm_restore(struct device 
 	struct device_driver *drv = dev->driver;
 	int error = 0;
 
+	pci_fixup_device(pci_fixup_resume, pci_dev);
+
 	if (drv && drv->pm) {
 		if (drv->pm->restore)
 			error = drv->pm->restore(dev);
@@ -656,7 +658,6 @@ static int pci_pm_restore(struct device 
 	} else {
 		error = pci_default_pm_resume_late(pci_dev);
 	}
-	pci_fixup_device(pci_fixup_resume, pci_dev);
 
 	return error;
 }
@@ -667,7 +668,7 @@ static int pci_pm_restore_noirq(struct d
 	struct device_driver *drv = dev->driver;
 	int error = 0;
 
-	pci_fixup_device(pci_fixup_resume, pci_dev);
+	pci_fixup_device(pci_fixup_resume_early, pci_dev);
 
 	if (drv && drv->pm) {
 		if (drv->pm->restore_noirq)
@@ -677,7 +678,6 @@ static int pci_pm_restore_noirq(struct d
 	} else {
 		pci_default_pm_resume_early(pci_dev);
 	}
-	pci_fixup_device(pci_fixup_resume_early, pci_dev);
 
 	return error;
 }
