From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [RFC][PATCH] ACPI / LPSS: Update system sleep handling to follow runtime PM
Date: Wed, 11 Oct 2017 01:17:51 +0200
Message-ID: <6579657.vL5j0BfzvC@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Modify the system sleep callback routines of acpi_lpss,
acpi_lpss_suspend_late() and acpi_lpss_resume_early(), to follow
the runtime PM ones and take LPSS_QUIRK_ALWAYS_POWER_ON into account.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

The runtime PM and system sleep handling in acpi_lpss have diverged
which almost certainly is a bug.

At least I see no reason why LPSS_QUIRK_ALWAYS_POWER_ON should not
be taken into account during systen suspend/resume in the
suspend-to-idle case, but also I don't see why doing that will
hurt the S3 case in principle.

---
 drivers/acpi/acpi_lpss.c |   86 +++++++++++++++++++++++++++--------------------
 1 file changed, 51 insertions(+), 35 deletions(-)

Index: linux-pm/drivers/acpi/acpi_lpss.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpi_lpss.c
+++ linux-pm/drivers/acpi/acpi_lpss.c
@@ -715,41 +715,6 @@ static void acpi_lpss_dismiss(struct dev
 {
 	acpi_dev_runtime_suspend(dev);
 }
-
-#ifdef CONFIG_PM_SLEEP
-static int acpi_lpss_suspend_late(struct device *dev)
-{
-	struct lpss_private_data *pdata = acpi_driver_data(ACPI_COMPANION(dev));
-	int ret;
-
-	ret = pm_generic_suspend_late(dev);
-	if (ret)
-		return ret;
-
-	if (pdata->dev_desc->flags & LPSS_SAVE_CTX)
-		acpi_lpss_save_ctx(dev, pdata);
-
-	return acpi_dev_suspend_late(dev);
-}
-
-static int acpi_lpss_resume_early(struct device *dev)
-{
-	struct lpss_private_data *pdata = acpi_driver_data(ACPI_COMPANION(dev));
-	int ret;
-
-	ret = acpi_dev_resume_early(dev);
-	if (ret)
-		return ret;
-
-	acpi_lpss_d3_to_d0_delay(pdata);
-
-	if (pdata->dev_desc->flags & LPSS_SAVE_CTX)
-		acpi_lpss_restore_ctx(dev, pdata);
-
-	return pm_generic_resume_early(dev);
-}
-#endif /* CONFIG_PM_SLEEP */
-
 /* IOSF SB for LPSS island */
 #define LPSS_IOSF_UNIT_LPIOEP		0xA0
 #define LPSS_IOSF_UNIT_LPIO1		0xAB
@@ -835,6 +800,57 @@ static void lpss_iosf_exit_d3_state(void
 	mutex_unlock(&lpss_iosf_mutex);
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int acpi_lpss_suspend_late(struct device *dev)
+{
+	struct lpss_private_data *pdata = acpi_driver_data(ACPI_COMPANION(dev));
+	int ret;
+
+	ret = pm_generic_suspend_late(dev);
+	if (ret)
+		return ret;
+
+	if (pdata->dev_desc->flags & LPSS_SAVE_CTX)
+		acpi_lpss_save_ctx(dev, pdata);
+
+	ret = acpi_dev_suspend_late(dev);
+
+	/*
+	 * This call must be last in the sequence, otherwise PMC will return
+	 * wrong status for devices being about to be powered off. See
+	 * lpss_iosf_enter_d3_state() for further information.
+	 */
+	if (lpss_quirks & LPSS_QUIRK_ALWAYS_POWER_ON && iosf_mbi_available())
+		lpss_iosf_enter_d3_state();
+
+	return ret;
+}
+
+static int acpi_lpss_resume_early(struct device *dev)
+{
+	struct lpss_private_data *pdata = acpi_driver_data(ACPI_COMPANION(dev));
+	int ret;
+
+	/*
+	 * This call is kept first to be in symmetry with
+	 * acpi_lpss_runtime_suspend() one.
+	 */
+	if (lpss_quirks & LPSS_QUIRK_ALWAYS_POWER_ON && iosf_mbi_available())
+		lpss_iosf_exit_d3_state();
+
+	ret = acpi_dev_resume_early(dev);
+	if (ret)
+		return ret;
+
+	acpi_lpss_d3_to_d0_delay(pdata);
+
+	if (pdata->dev_desc->flags & LPSS_SAVE_CTX)
+		acpi_lpss_restore_ctx(dev, pdata);
+
+	return pm_generic_resume_early(dev);
+}
+#endif /* CONFIG_PM_SLEEP */
+
 static int acpi_lpss_runtime_suspend(struct device *dev)
 {
 	struct lpss_private_data *pdata = acpi_driver_data(ACPI_COMPANION(dev));

