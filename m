From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v3 5/8] PM / ACPI: Split acpi_lpss_suspend_late|resume_early()
Date: Tue, 29 Aug 2017 16:56:47 +0200
Message-ID: <1504018610-10822-6-git-send-email-ulf.hansson@linaro.org>
References: <1504018610-10822-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f53.google.com ([209.85.215.53]:35500 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751664AbdH2O5K (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Aug 2017 10:57:10 -0400
Received: by mail-lf0-f53.google.com with SMTP id k186so14377664lfe.2
        for <linux-pm@vger.kernel.org>; Tue, 29 Aug 2017 07:57:09 -0700 (PDT)
In-Reply-To: <1504018610-10822-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Kevin Hilman <khilman@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, Johannes Stezenbach <js@sig21.net>, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

Move the code which is special to ACPI LPSS into separate functions. This
may clarify the code a bit, but the main purpose of this change, is instead
to prepare for additional changes on top. Ideally the following changes
should then become easier to review.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v3:
	- None.

---
 drivers/acpi/acpi_lpss.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index 0c84d15..e726173 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -717,22 +717,28 @@ static void acpi_lpss_dismiss(struct device *dev)
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
@@ -746,6 +752,17 @@ static int acpi_lpss_resume_early(struct device *dev)
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
