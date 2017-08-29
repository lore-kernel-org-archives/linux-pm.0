From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v3 2/8] PM / ACPI: Restore acpi_subsys_complete()
Date: Tue, 29 Aug 2017 16:56:44 +0200
Message-ID: <1504018610-10822-3-git-send-email-ulf.hansson@linaro.org>
References: <1504018610-10822-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f51.google.com ([209.85.215.51]:37905 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754661AbdH2O5F (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Aug 2017 10:57:05 -0400
Received: by mail-lf0-f51.google.com with SMTP id d202so14330128lfd.5
        for <linux-pm@vger.kernel.org>; Tue, 29 Aug 2017 07:57:04 -0700 (PDT)
In-Reply-To: <1504018610-10822-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Kevin Hilman <khilman@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, Johannes Stezenbach <js@sig21.net>, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

The commit 58a1fbbb2ee8 ("PM / PCI / ACPI: Kick devices that might have
been reset by firmware"), made PCI's and ACPI's ->complete() callbacks to
be assigned to a new API called pm_complete_with_resume_check(), which was
introduced in the same change.

Later it turned out that using pm_complete_with_resume_check() isn't good
enough for PCI, as it needs additional PCI specific checks, before deciding
whether runtime resuming the device is needed when running the ->complete()
callback.

This leaves ACPI being the only user of pm_complete_with_resume_check().
Therefore let's restore ACPI's acpi_subsys_complete(), which was dropped in
commit 58a1fbbb2ee8 ("PM / PCI / ACPI: Kick devices that might have been
reset by firmware").

This enables us to remove the pm_complete_with_resume_check() API in a
following change, but it also enables ACPI to add more ACPI specific checks
in acpi_subsys_complete() if it turns out that is needed.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v3:
	- None.

---
 drivers/acpi/acpi_lpss.c |  2 +-
 drivers/acpi/device_pm.c | 19 ++++++++++++++++++-
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index 032ae44..0c84d15 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -894,7 +894,7 @@ static struct dev_pm_domain acpi_lpss_pm_domain = {
 #ifdef CONFIG_PM
 #ifdef CONFIG_PM_SLEEP
 		.prepare = acpi_subsys_prepare,
-		.complete = pm_complete_with_resume_check,
+		.complete = acpi_subsys_complete,
 		.suspend = acpi_subsys_suspend,
 		.suspend_late = acpi_lpss_suspend_late,
 		.resume_early = acpi_lpss_resume_early,
diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index fbcc73f..632f214 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -1020,6 +1020,23 @@ int acpi_subsys_prepare(struct device *dev)
 EXPORT_SYMBOL_GPL(acpi_subsys_prepare);
 
 /**
+ * acpi_subsys_complete - Finalize device's resume during system resume.
+ * @dev: Device to handle.
+ */
+void acpi_subsys_complete(struct device *dev)
+{
+	pm_generic_complete(dev);
+	/*
+	 * If the device had been runtime-suspended before the system went into
+	 * the sleep state it is going out of and it has never been resumed till
+	 * now, resume it in case the firmware powered it up.
+	 */
+	if (dev->power.direct_complete && pm_resume_via_firmware())
+		pm_request_resume(dev);
+}
+EXPORT_SYMBOL_GPL(acpi_subsys_complete);
+
+/**
  * acpi_subsys_suspend - Run the device driver's suspend callback.
  * @dev: Device to handle.
  *
@@ -1087,7 +1104,7 @@ static struct dev_pm_domain acpi_general_pm_domain = {
 		.runtime_resume = acpi_subsys_runtime_resume,
 #ifdef CONFIG_PM_SLEEP
 		.prepare = acpi_subsys_prepare,
-		.complete = pm_complete_with_resume_check,
+		.complete = acpi_subsys_complete,
 		.suspend = acpi_subsys_suspend,
 		.suspend_late = acpi_subsys_suspend_late,
 		.resume_early = acpi_subsys_resume_early,
-- 
2.7.4
