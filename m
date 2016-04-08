From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] PM / Runtime: Move ignore_children flag under CONFIG_PM
Date: Fri,  8 Apr 2016 12:44:36 +0200
Message-ID: <1460112276-5897-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:33351 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758110AbcDHKqF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 8 Apr 2016 06:46:05 -0400
Received: by mail-lb0-f169.google.com with SMTP id u8so66900078lbk.0
        for <linux-pm@vger.kernel.org>; Fri, 08 Apr 2016 03:46:04 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Linus Walleij <linus.walleij@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>

The ignore_children flag is used only when CONFIG_PM is set, so let's move
it into that section within the struct dev_pm_info.

Move also the corresponding pm_suspend_ignore_children() API out of
device.h into pm_runtime.h, to be consistent with similar APIs.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 include/linux/device.h     | 5 -----
 include/linux/pm.h         | 2 +-
 include/linux/pm_runtime.h | 6 ++++++
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/linux/device.h b/include/linux/device.h
index 002c597..b130304 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -956,11 +956,6 @@ static inline bool device_async_suspend_enabled(struct device *dev)
 	return !!dev->power.async_suspend;
 }
 
-static inline void pm_suspend_ignore_children(struct device *dev, bool enable)
-{
-	dev->power.ignore_children = enable;
-}
-
 static inline void dev_pm_syscore_device(struct device *dev, bool val)
 {
 #ifdef CONFIG_PM_SLEEP
diff --git a/include/linux/pm.h b/include/linux/pm.h
index 6a5d654..06eb353 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -563,7 +563,6 @@ struct dev_pm_info {
 	bool			is_suspended:1;	/* Ditto */
 	bool			is_noirq_suspended:1;
 	bool			is_late_suspended:1;
-	bool			ignore_children:1;
 	bool			early_init:1;	/* Owned by the PM core */
 	bool			direct_complete:1;	/* Owned by the PM core */
 	spinlock_t		lock;
@@ -591,6 +590,7 @@ struct dev_pm_info {
 	unsigned int		deferred_resume:1;
 	unsigned int		run_wake:1;
 	unsigned int		runtime_auto:1;
+	bool			ignore_children:1;
 	unsigned int		no_callbacks:1;
 	unsigned int		irq_safe:1;
 	unsigned int		use_autosuspend:1;
diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index 7af093d..2e14d26 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -56,6 +56,11 @@ extern void pm_runtime_update_max_time_suspended(struct device *dev,
 						 s64 delta_ns);
 extern void pm_runtime_set_memalloc_noio(struct device *dev, bool enable);
 
+static inline void pm_suspend_ignore_children(struct device *dev, bool enable)
+{
+	dev->power.ignore_children = enable;
+}
+
 static inline bool pm_children_suspended(struct device *dev)
 {
 	return dev->power.ignore_children
@@ -156,6 +161,7 @@ static inline void __pm_runtime_disable(struct device *dev, bool c) {}
 static inline void pm_runtime_allow(struct device *dev) {}
 static inline void pm_runtime_forbid(struct device *dev) {}
 
+static inline void pm_suspend_ignore_children(struct device *dev, bool enable) {}
 static inline bool pm_children_suspended(struct device *dev) { return false; }
 static inline void pm_runtime_get_noresume(struct device *dev) {}
 static inline void pm_runtime_put_noidle(struct device *dev) {}
-- 
1.9.1

