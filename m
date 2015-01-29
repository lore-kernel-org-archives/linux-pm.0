From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 2/2] PM: Convert dev_pm_put_subsys_data() into a void function
Date: Thu, 29 Jan 2015 18:39:05 +0100
Message-ID: <1422553145-14798-2-git-send-email-ulf.hansson@linaro.org>
References: <1422553145-14798-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:35838 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754375AbbA2RjS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 29 Jan 2015 12:39:18 -0500
Received: by mail-lb0-f177.google.com with SMTP id p9so30739218lbv.8
        for <linux-pm@vger.kernel.org>; Thu, 29 Jan 2015 09:39:16 -0800 (PST)
In-Reply-To: <1422553145-14798-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
Cc: Kevin Hilman <khilman@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Ulf Hansson <ulf.hansson@linaro.org>

Clients using the dev_pm_put_subsys_data() API isn't interested of a
return value. They care only of decreasing a reference to the device's
pm_subsys_data. So, let's convert the API to a void function, which
anyway seems like reasonable thing to do.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/common.c | 14 ++++----------
 include/linux/pm.h          |  2 +-
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
index a1ee51d..f32b802 100644
--- a/drivers/base/power/common.c
+++ b/drivers/base/power/common.c
@@ -56,13 +56,11 @@ EXPORT_SYMBOL_GPL(dev_pm_get_subsys_data);
  * @dev: Device to handle.
  *
  * If the reference counter of power.subsys_data is zero after dropping the
- * reference, power.subsys_data is removed.  Return 1 if that happens or 0
- * otherwise.
+ * reference, power.subsys_data is removed.
  */
-int dev_pm_put_subsys_data(struct device *dev)
+void dev_pm_put_subsys_data(struct device *dev)
 {
 	struct pm_subsys_data *psd;
-	int ret = 1;
 
 	spin_lock_irq(&dev->power.lock);
 
@@ -70,18 +68,14 @@ int dev_pm_put_subsys_data(struct device *dev)
 	if (!psd)
 		goto out;
 
-	if (--psd->refcount == 0) {
+	if (--psd->refcount == 0)
 		dev->power.subsys_data = NULL;
-	} else {
+	else
 		psd = NULL;
-		ret = 0;
-	}
 
  out:
 	spin_unlock_irq(&dev->power.lock);
 	kfree(psd);
-
-	return ret;
 }
 EXPORT_SYMBOL_GPL(dev_pm_put_subsys_data);
 
diff --git a/include/linux/pm.h b/include/linux/pm.h
index 8b59763..e2f1be6 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -597,7 +597,7 @@ struct dev_pm_info {
 
 extern void update_pm_runtime_accounting(struct device *dev);
 extern int dev_pm_get_subsys_data(struct device *dev);
-extern int dev_pm_put_subsys_data(struct device *dev);
+extern void dev_pm_put_subsys_data(struct device *dev);
 
 /*
  * Power domains provide callbacks that are executed during system suspend,
-- 
1.9.1

