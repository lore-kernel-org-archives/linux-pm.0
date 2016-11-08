From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCHv2 43/49] thermal: core: standardize line breaking alignment
Date: Mon,  7 Nov 2016 21:09:21 -0800
Message-ID: <1478581767-7009-44-git-send-email-edubezval@gmail.com>
References: <1478581767-7009-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1478581767-7009-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

Pass through the code to remove check suggested by
checkpatch.pl (alignment to parenthesis):
CHECK: Alignment should match open parenthesis

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/thermal_core.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index f19fe03..d33b29a 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -137,10 +137,15 @@ int thermal_register_governor(struct thermal_governor *governor)
 
 	err = -EBUSY;
 	if (!__find_governor(governor->name)) {
+		bool match_default;
+
 		err = 0;
 		list_add(&governor->governor_list, &thermal_governor_list);
-		if (!def_governor && !strncmp(governor->name,
-			DEFAULT_THERMAL_GOVERNOR, THERMAL_NAME_LENGTH))
+		match_default = !strncmp(governor->name,
+					 DEFAULT_THERMAL_GOVERNOR,
+					 THERMAL_NAME_LENGTH);
+
+		if (!def_governor && match_default)
 			def_governor = governor;
 	}
 
@@ -189,7 +194,7 @@ void thermal_unregister_governor(struct thermal_governor *governor)
 
 	list_for_each_entry(pos, &thermal_tz_list, node) {
 		if (!strncasecmp(pos->governor->name, governor->name,
-						THERMAL_NAME_LENGTH))
+				 THERMAL_NAME_LENGTH))
 			thermal_set_governor(pos, NULL);
 	}
 
@@ -312,14 +317,15 @@ static void monitor_thermal_zone(struct thermal_zone_device *tz)
 }
 
 static void handle_non_critical_trips(struct thermal_zone_device *tz,
-			int trip, enum thermal_trip_type trip_type)
+				      int trip,
+				      enum thermal_trip_type trip_type)
 {
 	tz->governor ? tz->governor->throttle(tz, trip) :
 		       def_governor->throttle(tz, trip);
 }
 
 static void handle_critical_trips(struct thermal_zone_device *tz,
-				int trip, enum thermal_trip_type trip_type)
+				  int trip, enum thermal_trip_type trip_type)
 {
 	int trip_temp;
 
@@ -797,7 +803,7 @@ static void thermal_release(struct device *dev)
 		tz = to_thermal_zone(dev);
 		kfree(tz);
 	} else if(!strncmp(dev_name(dev), "cooling_device",
-			sizeof("cooling_device") - 1)){
+			   sizeof("cooling_device") - 1)) {
 		cdev = to_cooling_device(dev);
 		kfree(cdev);
 	}
@@ -1131,11 +1137,11 @@ static void bind_tz(struct thermal_zone_device *tz)
  * in case of error, an ERR_PTR. Caller must check return value with
  * IS_ERR*() helpers.
  */
-struct thermal_zone_device *thermal_zone_device_register(const char *type,
-	int trips, int mask, void *devdata,
-	struct thermal_zone_device_ops *ops,
-	struct thermal_zone_params *tzp,
-	int passive_delay, int polling_delay)
+struct thermal_zone_device *
+thermal_zone_device_register(const char *type, int trips, int mask,
+			     void *devdata, struct thermal_zone_device_ops *ops,
+			     struct thermal_zone_params *tzp, int passive_delay,
+			     int polling_delay)
 {
 	struct thermal_zone_device *tz;
 	enum thermal_trip_type trip_type;
@@ -1400,7 +1406,7 @@ static struct genl_family thermal_event_genl_family = {
 };
 
 int thermal_generate_netlink_event(struct thermal_zone_device *tz,
-					enum events event)
+				   enum events event)
 {
 	struct sk_buff *skb;
 	struct nlattr *attr;
@@ -1477,7 +1483,7 @@ static inline void genetlink_exit(void) {}
 #endif /* !CONFIG_NET */
 
 static int thermal_pm_notify(struct notifier_block *nb,
-				unsigned long mode, void *_unused)
+			     unsigned long mode, void *_unused)
 {
 	struct thermal_zone_device *tz;
 
-- 
2.1.4
