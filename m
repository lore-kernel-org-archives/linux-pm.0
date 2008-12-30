From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 4/10] PCI PM: Move pci_has_legacy_pm_support
Date: Tue, 30 Dec 2008 23:40:06 +0100
Message-ID: <200812302340.07249.rjw__31634.3891005547$1230677560$gmane$org@sisk.pl>
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


Move pci_has_legacy_pm_support() closer to the functions that
call it.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/pci/pci-driver.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

Index: linux-2.6/drivers/pci/pci-driver.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci-driver.c
+++ linux-2.6/drivers/pci/pci-driver.c
@@ -300,14 +300,6 @@ static void pci_device_shutdown(struct d
 
 #ifdef CONFIG_PM_SLEEP
 
-static bool pci_has_legacy_pm_support(struct pci_dev *pci_dev)
-{
-	struct pci_driver *drv = pci_dev->driver;
-
-	return drv && (drv->suspend || drv->suspend_late || drv->resume
-		|| drv->resume_early);
-}
-
 /*
  * Default "suspend" method for devices that have no driver provided suspend,
  * or not even a driver at all (first part).
@@ -444,6 +436,14 @@ static void pci_pm_default_suspend(struc
 		pci_prepare_to_sleep(pci_dev);
 }
 
+static bool pci_has_legacy_pm_support(struct pci_dev *pci_dev)
+{
+	struct pci_driver *drv = pci_dev->driver;
+
+	return drv && (drv->suspend || drv->suspend_late || drv->resume
+		|| drv->resume_early);
+}
+
 /* New power management framework */
 
 static int pci_pm_prepare(struct device *dev)
