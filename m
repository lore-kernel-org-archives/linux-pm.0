From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 1/4] PCI PM: Simplify PCI wake-up code
Date: Fri, 4 Sep 2009 00:03:36 +0200
Message-ID: <200909040003.36917.rjw__42822.9315708906$1252015956$gmane$org@sisk.pl>
References: <200908300041.14541.rjw@sisk.pl> <200909020041.57754.rjw@sisk.pl>
	<200909040002.02562.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200909040002.02562.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Linux PCI <linux-pci@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Rework the PCI wake-up code so that it's easier to read without
changing the functionality.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/pci/pci-acpi.c |   10 +++++++---
 drivers/pci/pci.c      |   25 ++++++++++++++-----------
 2 files changed, 21 insertions(+), 14 deletions(-)

Index: linux-2.6/drivers/pci/pci.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci.c
+++ linux-2.6/drivers/pci/pci.c
@@ -1218,8 +1218,7 @@ void pci_pme_active(struct pci_dev *dev,
  */
 int pci_enable_wake(struct pci_dev *dev, pci_power_t state, bool enable)
 {
-	int error = 0;
-	bool pme_done = false;
+	int ret = 0;
 
 	if (enable && !device_may_wakeup(&dev->dev))
 		return -EINVAL;
@@ -1230,18 +1229,22 @@ int pci_enable_wake(struct pci_dev *dev,
 	 * enable.  To disable wake-up we call the platform first, for symmetry.
 	 */
 
-	if (!enable && platform_pci_can_wakeup(dev))
-		error = platform_pci_sleep_wake(dev, false);
-
-	if (!enable || pci_pme_capable(dev, state)) {
-		pci_pme_active(dev, enable);
-		pme_done = true;
-	}
+	if (enable) {
+		int error;
 
-	if (enable && platform_pci_can_wakeup(dev))
+		if (pci_pme_capable(dev, state))
+			pci_pme_active(dev, true);
+		else
+			ret = 1;
 		error = platform_pci_sleep_wake(dev, true);
+		if (ret)
+			ret = error;
+	} else {
+		platform_pci_sleep_wake(dev, false);
+		pci_pme_active(dev, false);
+	}
 
-	return pme_done ? 0 : error;
+	return ret;
 }
 
 /**
Index: linux-2.6/drivers/pci/pci-acpi.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci-acpi.c
+++ linux-2.6/drivers/pci/pci-acpi.c
@@ -111,12 +111,16 @@ static bool acpi_pci_can_wakeup(struct p
 
 static int acpi_pci_sleep_wake(struct pci_dev *dev, bool enable)
 {
-	int error = acpi_pm_device_sleep_wake(&dev->dev, enable);
+	int error;
 
+	if (!acpi_pci_can_wakeup(dev))
+		return 0;
+
+	error = acpi_pm_device_sleep_wake(&dev->dev, enable);
 	if (!error)
-		dev_printk(KERN_INFO, &dev->dev,
-				"wake-up capability %s by ACPI\n",
+		dev_info(&dev->dev, "wake-up capability %s by ACPI\n",
 				enable ? "enabled" : "disabled");
+
 	return error;
 }
 
