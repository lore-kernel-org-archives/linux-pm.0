From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 1/2] PM / Runtime: Extend the scope for pm_runtime_remove()
Date: Tue, 17 Nov 2015 15:35:28 +0100
Message-ID: <1447770929-16652-2-git-send-email-ulf.hansson@linaro.org>
References: <1447770929-16652-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:35397 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752317AbbKQOfu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 Nov 2015 09:35:50 -0500
Received: by lbbsy6 with SMTP id sy6so6626297lbb.2
        for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2015 06:35:49 -0800 (PST)
In-Reply-To: <1447770929-16652-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org
Cc: Alan Stern <stern@rowland.harvard.edu>, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert@linux-m68k.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Eduardo Valentin <edubezval@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>

There are additional execution paths besides the device removal, which
needs to be able to restore initial states of runtime PM.

To prepare for these changes, provide a parameter to pm_runtime_remove()
to allow optional disabling of runtime PM and reset the irq_safe flag.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/main.c    |  2 +-
 drivers/base/power/power.h   |  6 +++---
 drivers/base/power/runtime.c | 21 +++++++++++++--------
 3 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 1710c26..6b6c79b 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -146,7 +146,7 @@ void device_pm_remove(struct device *dev)
 	list_del_init(&dev->power.entry);
 	mutex_unlock(&dpm_list_mtx);
 	device_wakeup_disable(dev);
-	pm_runtime_remove(dev);
+	pm_runtime_remove(dev, true);
 }
 
 /**
diff --git a/drivers/base/power/power.h b/drivers/base/power/power.h
index 998fa6b..5057a21 100644
--- a/drivers/base/power/power.h
+++ b/drivers/base/power/power.h
@@ -18,7 +18,7 @@ static inline void pm_runtime_early_init(struct device *dev)
 }
 
 extern void pm_runtime_init(struct device *dev);
-extern void pm_runtime_remove(struct device *dev);
+extern void pm_runtime_remove(struct device *dev, bool disable);
 
 struct wake_irq {
 	struct device *dev;
@@ -84,7 +84,7 @@ static inline void pm_runtime_early_init(struct device *dev)
 }
 
 static inline void pm_runtime_init(struct device *dev) {}
-static inline void pm_runtime_remove(struct device *dev) {}
+static inline void pm_runtime_remove(struct device *dev, bool disable) {}
 
 static inline int dpm_sysfs_add(struct device *dev) { return 0; }
 static inline void dpm_sysfs_remove(struct device *dev) {}
@@ -132,7 +132,7 @@ static inline void device_pm_add(struct device *dev) {}
 
 static inline void device_pm_remove(struct device *dev)
 {
-	pm_runtime_remove(dev);
+	pm_runtime_remove(dev, true);
 }
 
 static inline void device_pm_move_before(struct device *deva,
diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index e1a10a0..d3031ef 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1393,15 +1393,20 @@ void pm_runtime_init(struct device *dev)
  * pm_runtime_remove - Prepare for removing a device from device hierarchy.
  * @dev: Device object being removed from device hierarchy.
  */
-void pm_runtime_remove(struct device *dev)
+void pm_runtime_remove(struct device *dev, bool disable)
 {
-	__pm_runtime_disable(dev, false);
-
-	/* Change the status back to 'suspended' to match the initial status. */
-	if (dev->power.runtime_status == RPM_ACTIVE)
-		pm_runtime_set_suspended(dev);
-	if (dev->power.irq_safe && dev->parent)
-		pm_runtime_put(dev->parent);
+	if (disable)
+		__pm_runtime_disable(dev, false);
+
+	if (!pm_runtime_enabled(dev)) {
+		/* Restore initial runtime PM states. */
+		if (dev->power.runtime_status == RPM_ACTIVE)
+			pm_runtime_set_suspended(dev);
+		if (dev->power.irq_safe && dev->parent) {
+			pm_runtime_put(dev->parent);
+			dev->power.irq_safe = 0;
+		}
+	}
 }
 
 /**
-- 
1.9.1

