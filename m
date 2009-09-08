From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 2/5] PCI / ACPI PM: Rework some debug messages
Date: Tue, 8 Sep 2009 23:13:49 +0200
Message-ID: <200909082313.49427.rjw__45619.2446676598$1252444756$gmane$org@sisk.pl>
References: <200908300041.14541.rjw@sisk.pl> <200909040002.02562.rjw@sisk.pl>
	<200909082311.48366.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200909082311.48366.rjw@sisk.pl>
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
Cc: Linux PCI <linux-pci@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, ykzhao <yakui.zhao@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Move a debug message from acpi_pci_sleep_wake() to
acpi_pm_device_sleep_wake() and use the standard dev_*() macros
in there.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/sleep.c   |   10 ++++++++--
 drivers/pci/pci-acpi.c |   13 ++-----------
 2 files changed, 10 insertions(+), 13 deletions(-)

Index: linux-2.6/drivers/acpi/sleep.c
===================================================================
--- linux-2.6.orig/drivers/acpi/sleep.c
+++ linux-2.6/drivers/acpi/sleep.c
@@ -689,19 +689,25 @@ int acpi_pm_device_sleep_wake(struct dev
 {
 	acpi_handle handle;
 	struct acpi_device *adev;
+	int error;
 
 	if (!device_may_wakeup(dev))
 		return -EINVAL;
 
 	handle = DEVICE_ACPI_HANDLE(dev);
 	if (!handle || ACPI_FAILURE(acpi_bus_get_device(handle, &adev))) {
-		printk(KERN_DEBUG "ACPI handle has no context!\n");
+		dev_dbg(dev, "ACPI handle has no context in %s!\n", __func__);
 		return -ENODEV;
 	}
 
-	return enable ?
+	error = enable ?
 		acpi_enable_wakeup_device_power(adev, acpi_target_sleep_state) :
 		acpi_disable_wakeup_device_power(adev);
+	if (!error)
+		dev_info(dev, "wake-up capability %s by ACPI\n",
+				enable ? "enabled" : "disabled");
+
+	return error;
 }
 #endif
 
Index: linux-2.6/drivers/pci/pci-acpi.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci-acpi.c
+++ linux-2.6/drivers/pci/pci-acpi.c
@@ -111,17 +111,8 @@ static bool acpi_pci_can_wakeup(struct p
 
 static int acpi_pci_sleep_wake(struct pci_dev *dev, bool enable)
 {
-	int error;
-
-	if (!acpi_pci_can_wakeup(dev))
-		return 0;
-
-	error = acpi_pm_device_sleep_wake(&dev->dev, enable);
-	if (!error)
-		dev_info(&dev->dev, "wake-up capability %s by ACPI\n",
-				enable ? "enabled" : "disabled");
-
-	return error;
+	return acpi_pci_can_wakeup(dev) ?
+		acpi_pm_device_sleep_wake(&dev->dev, enable) : 0;
 }
 
 static struct pci_platform_pm_ops acpi_pci_platform_pm = {
