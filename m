From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 04/11] thermal: rename get_thermal_instance to thermal_instance_get
Date: Fri, 22 Mar 2013 17:00:47 -0400
Message-ID: <1363986054-24637-5-git-send-email-eduardo.valentin@ti.com>
References: <1363986054-24637-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1363986054-24637-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>
List-Id: linux-pm@vger.kernel.org

To follow the prefix names used by the thermal exported functions,
this patch renames get_thermal_instance to thermal_instance_get.

Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 Documentation/thermal/sysfs-api.txt |    2 +-
 drivers/thermal/fair_share.c        |    2 +-
 drivers/thermal/thermal_sys.c       |    4 ++--
 include/linux/thermal.h             |    2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/thermal/sysfs-api.txt
index 4b23190..059b3bf 100644
--- a/Documentation/thermal/sysfs-api.txt
+++ b/Documentation/thermal/sysfs-api.txt
@@ -358,7 +358,7 @@ are supposed to implement the callback. If they don't, the thermal
 framework calculated the trend by comparing the previous and the current
 temperature values.
 
-5.2:get_thermal_instance:
+5.2:thermal_instance_get:
 This function returns the thermal_instance corresponding to a given
 {thermal_zone, cooling_device, trip_point} combination. Returns NULL
 if such an instance does not exist.
diff --git a/drivers/thermal/fair_share.c b/drivers/thermal/fair_share.c
index 792479f..f629446 100644
--- a/drivers/thermal/fair_share.c
+++ b/drivers/thermal/fair_share.c
@@ -95,7 +95,7 @@ static int fair_share_throttle(struct thermal_zone_device *tz, int trip)
 			continue;
 
 		cdev = tzp->tbp[i].cdev;
-		instance = get_thermal_instance(tz, cdev, trip);
+		instance = thermal_instance_get(tz, cdev, trip);
 		if (!instance)
 			continue;
 
diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index ffaf6d3..44e89c0 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -170,7 +170,7 @@ int get_tz_trend(struct thermal_zone_device *tz, int trip)
 }
 EXPORT_SYMBOL(get_tz_trend);
 
-struct thermal_instance *get_thermal_instance(struct thermal_zone_device *tz,
+struct thermal_instance *thermal_instance_get(struct thermal_zone_device *tz,
 			struct thermal_cooling_device *cdev, int trip)
 {
 	struct thermal_instance *pos = NULL;
@@ -191,7 +191,7 @@ struct thermal_instance *get_thermal_instance(struct thermal_zone_device *tz,
 
 	return target_instance;
 }
-EXPORT_SYMBOL(get_thermal_instance);
+EXPORT_SYMBOL(thermal_instance_get);
 
 static void print_bind_err_msg(struct thermal_zone_device *tz,
 			struct thermal_cooling_device *cdev, int ret)
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index e8ec9d8..e2a49e1 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -239,7 +239,7 @@ struct thermal_cooling_device *thermal_cooling_device_register(char *, void *,
 void thermal_cooling_device_unregister(struct thermal_cooling_device *);
 
 int get_tz_trend(struct thermal_zone_device *, int);
-struct thermal_instance *get_thermal_instance(struct thermal_zone_device *,
+struct thermal_instance *thermal_instance_get(struct thermal_zone_device *,
 		struct thermal_cooling_device *, int);
 void thermal_cdev_update(struct thermal_cooling_device *);
 void thermal_notify_framework(struct thermal_zone_device *, int);
-- 
1.7.7.1.488.ge8e1c
