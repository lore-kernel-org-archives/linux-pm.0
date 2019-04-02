From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 2/7] thermal/drivers/core: Remove module unload code
Date: Tue,  2 Apr 2019 18:12:45 +0200
Message-ID: <20190402161256.11044-2-daniel.lezcano@linaro.org>
References: <20190402161256.11044-1-daniel.lezcano@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190402161256.11044-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Now the thermal core is no longer compiled as a module. Remove the unloading
module code and move the unregister function to the __init section.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 6590bb5cb688..28f7ece0e8fe 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -266,7 +266,7 @@ static int __init thermal_register_governors(void)
 	return thermal_gov_power_allocator_register();
 }
 
-static void thermal_unregister_governors(void)
+static void __init thermal_unregister_governors(void)
 {
 	thermal_gov_step_wise_unregister();
 	thermal_gov_fair_share_unregister();
@@ -1563,19 +1563,4 @@ static int __init thermal_init(void)
 	mutex_destroy(&poweroff_lock);
 	return result;
 }
-
-static void __exit thermal_exit(void)
-{
-	unregister_pm_notifier(&thermal_pm_nb);
-	of_thermal_destroy_zones();
-	genetlink_exit();
-	class_unregister(&thermal_class);
-	thermal_unregister_governors();
-	ida_destroy(&thermal_tz_ida);
-	ida_destroy(&thermal_cdev_ida);
-	mutex_destroy(&thermal_list_lock);
-	mutex_destroy(&thermal_governor_lock);
-}
-
 fs_initcall(thermal_init);
-module_exit(thermal_exit);
-- 
2.17.1
