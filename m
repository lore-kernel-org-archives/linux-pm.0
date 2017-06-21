From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 5/9] PM / ACPI: Split acpi_lpss_suspend_late|resume_early()
Date: Wed, 21 Jun 2017 21:21:24 +0200
Message-ID: <1498072888-14782-6-git-send-email-ulf.hansson@linaro.org>
References: <1498072888-14782-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1498072888-14782-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Kevin Hilman <khilman@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

Move the code which is special to ACPI LPSS into separate functions. This
may clarify the code a bit, but the main purpose of this change, is instead
to prepare for additional changes on top. Ideally the following changes
should then become easier to review.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/acpi/acpi_lpss.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index d7b6778..12bc5c7 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -702,22 +702,28 @@ static void acpi_lpss_dismiss(struct device *dev)
 }
 
 #ifdef CONFIG_PM_SLEEP
-static int acpi_lpss_suspend_late(struct device *dev)
+static int lpss_suspend_late(struct device *dev)
 {
 	struct lpss_private_data *pdata = acpi_driver_data(ACPI_COMPANION(dev));
+
+	if (pdata->dev_desc->flags & LPSS_SAVE_CTX)
+		acpi_lpss_save_ctx(dev, pdata);
+
+	return acpi_dev_suspend_late(dev);
+}
+
+static int acpi_lpss_suspend_late(struct device *dev)
+{
 	int ret;
 
 	ret = pm_generic_suspend_late(dev);
 	if (ret)
 		return ret;
 
-	if (pdata->dev_desc->flags & LPSS_SAVE_CTX)
-		acpi_lpss_save_ctx(dev, pdata);
-
-	return acpi_dev_suspend_late(dev);
+	return lpss_suspend_late(dev);
 }
 
-static int acpi_lpss_resume_early(struct device *dev)
+static int lpss_resume_early(struct device *dev)
 {
 	struct lpss_private_data *pdata = acpi_driver_data(ACPI_COMPANION(dev));
 	int ret;
@@ -731,6 +737,17 @@ static int acpi_lpss_resume_early(struct device *dev)
 	if (pdata->dev_desc->flags & LPSS_SAVE_CTX)
 		acpi_lpss_restore_ctx(dev, pdata);
 
+	return 0;
+}
+
+static int acpi_lpss_resume_early(struct device *dev)
+{
+	int ret;
+
+	ret = lpss_resume_early(dev);
+	if (ret)
+		return ret;
+
 	return pm_generic_resume_early(dev);
 }
 #endif /* CONFIG_PM_SLEEP */
-- 
2.7.4

