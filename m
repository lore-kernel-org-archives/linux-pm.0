From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 4/10] PCI PM: Move pci_has_legacy_pm_support
Date: Wed, 7 Jan 2009 13:06:10 +0100
Message-ID: <200901071306.11422.rjw__26148.6816489652$1231330666$gmane$org@sisk.pl>
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

Move pci_has_legacy_pm_support() closer to the functions that
call it.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Pavel Machek <pavel@suse.cz>
---
 drivers/pci/pci-driver.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

Index: linux-2.6/drivers/pci/pci-driver.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci-driver.c
+++ linux-2.6/drivers/pci/pci-driver.c
@@ -314,14 +314,6 @@ static void pci_device_shutdown(struct d
 
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
@@ -458,6 +450,14 @@ static void pci_pm_default_suspend(struc
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
