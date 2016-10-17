From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 1/4] PM / Runtime: Remove the exported function pm_children_suspended()
Date: Mon, 17 Oct 2016 20:16:58 +0200
Message-ID: <1476728221-26530-2-git-send-email-ulf.hansson@linaro.org>
References: <1476728221-26530-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f54.google.com ([209.85.215.54]:33336 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755183AbcJQSRN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Oct 2016 14:17:13 -0400
Received: by mail-lf0-f54.google.com with SMTP id x79so307615347lff.0
        for <linux-pm@vger.kernel.org>; Mon, 17 Oct 2016 11:17:13 -0700 (PDT)
In-Reply-To: <1476728221-26530-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Lina Iyer <lina.iyer@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Linus Walleij <linus.walleij@linaro.org>

The exported function pm_children_suspended() has only one caller, which is
the runtime PM internal function, rpm_check_suspend_allowed().

Let's clean-up this code, by removing pm_children_suspended() altogether
and instead do the one-liner check directly in rpm_check_suspend_allowed().

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/runtime.c | 3 ++-
 include/linux/pm_runtime.h   | 7 -------
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index f662267..5e4e5ec 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -241,7 +241,8 @@ static int rpm_check_suspend_allowed(struct device *dev)
 		retval = -EACCES;
 	else if (atomic_read(&dev->power.usage_count) > 0)
 		retval = -EAGAIN;
-	else if (!pm_children_suspended(dev))
+	else if (!dev->power.ignore_children &&
+			atomic_read(&dev->power.child_count))
 		retval = -EBUSY;
 
 	/* Pending resume requests take precedence over suspends. */
diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index 2e14d26..61ea566 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -61,12 +61,6 @@ static inline void pm_suspend_ignore_children(struct device *dev, bool enable)
 	dev->power.ignore_children = enable;
 }
 
-static inline bool pm_children_suspended(struct device *dev)
-{
-	return dev->power.ignore_children
-		|| !atomic_read(&dev->power.child_count);
-}
-
 static inline void pm_runtime_get_noresume(struct device *dev)
 {
 	atomic_inc(&dev->power.usage_count);
@@ -162,7 +156,6 @@ static inline void pm_runtime_allow(struct device *dev) {}
 static inline void pm_runtime_forbid(struct device *dev) {}
 
 static inline void pm_suspend_ignore_children(struct device *dev, bool enable) {}
-static inline bool pm_children_suspended(struct device *dev) { return false; }
 static inline void pm_runtime_get_noresume(struct device *dev) {}
 static inline void pm_runtime_put_noidle(struct device *dev) {}
 static inline bool device_run_wake(struct device *dev) { return false; }
-- 
1.9.1

