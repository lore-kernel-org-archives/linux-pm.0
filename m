From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 1/2] cpuidle: governors: Remove remaining old module code
Date: Wed,  5 Oct 2016 09:33:12 +0200
Message-ID: <1475652794-4486-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The governor's code use try_module_get() and put_module() to refcount
the governor's module. But the governors are not compiled as module.

The refcount does not prevent to switch the governor or unload a module
as they aren't compiled as modules. So the code is pointless, removing
it.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/governor.c         | 4 ----
 drivers/cpuidle/governors/ladder.c | 2 --
 drivers/cpuidle/governors/menu.c   | 2 --
 include/linux/cpuidle.h            | 2 --
 4 files changed, 10 deletions(-)

diff --git a/drivers/cpuidle/governor.c b/drivers/cpuidle/governor.c
index fb9f511..4e78263 100644
--- a/drivers/cpuidle/governor.c
+++ b/drivers/cpuidle/governor.c
@@ -9,7 +9,6 @@
  */
 
 #include <linux/mutex.h>
-#include <linux/module.h>
 #include <linux/cpuidle.h>
 
 #include "cpuidle.h"
@@ -53,14 +52,11 @@ int cpuidle_switch_governor(struct cpuidle_governor *gov)
 	if (cpuidle_curr_governor) {
 		list_for_each_entry(dev, &cpuidle_detected_devices, device_list)
 			cpuidle_disable_device(dev);
-		module_put(cpuidle_curr_governor->owner);
 	}
 
 	cpuidle_curr_governor = gov;
 
 	if (gov) {
-		if (!try_module_get(cpuidle_curr_governor->owner))
-			return -EINVAL;
 		list_for_each_entry(dev, &cpuidle_detected_devices, device_list)
 			cpuidle_enable_device(dev);
 		cpuidle_install_idle_handler();
diff --git a/drivers/cpuidle/governors/ladder.c b/drivers/cpuidle/governors/ladder.c
index 63bd5a4..fe8f089 100644
--- a/drivers/cpuidle/governors/ladder.c
+++ b/drivers/cpuidle/governors/ladder.c
@@ -15,7 +15,6 @@
 #include <linux/kernel.h>
 #include <linux/cpuidle.h>
 #include <linux/pm_qos.h>
-#include <linux/module.h>
 #include <linux/jiffies.h>
 #include <linux/tick.h>
 
@@ -177,7 +176,6 @@ static struct cpuidle_governor ladder_governor = {
 	.enable =	ladder_enable_device,
 	.select =	ladder_select_state,
 	.reflect =	ladder_reflect,
-	.owner =	THIS_MODULE,
 };
 
 /**
diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index 03d38c2..d9b5b93 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -19,7 +19,6 @@
 #include <linux/tick.h>
 #include <linux/sched.h>
 #include <linux/math64.h>
-#include <linux/module.h>
 
 /*
  * Please note when changing the tuning values:
@@ -484,7 +483,6 @@ static struct cpuidle_governor menu_governor = {
 	.enable =	menu_enable_device,
 	.select =	menu_select,
 	.reflect =	menu_reflect,
-	.owner =	THIS_MODULE,
 };
 
 /**
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index bb31373..15deea4 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -235,8 +235,6 @@ struct cpuidle_governor {
 	int  (*select)		(struct cpuidle_driver *drv,
 					struct cpuidle_device *dev);
 	void (*reflect)		(struct cpuidle_device *dev, int index);
-
-	struct module 		*owner;
 };
 
 #ifdef CONFIG_CPU_IDLE
-- 
1.9.1
