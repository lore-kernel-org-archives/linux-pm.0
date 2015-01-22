From: Javi Merino <javi.merino@arm.com>
Subject: [PATCH 1/5] thermal: of: fix cooling device weights in device tree
Date: Thu, 22 Jan 2015 17:27:01 +0000
Message-ID: <1421947625-19708-2-git-send-email-javi.merino@arm.com>
References: <1421947625-19708-1-git-send-email-javi.merino@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:41129 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753727AbbAVR1y (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 22 Jan 2015 12:27:54 -0500
In-Reply-To: <1421947625-19708-1-git-send-email-javi.merino@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Punit.Agrawal@arm.com, Kapileshwar.Singh@arm.com, Kapileshwar Singh <kapileshwar.singh@arm.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Kukjin Kim <kgene@kernel.org>

From: Kapileshwar Singh <kapileshwar.singh@arm.com>

Currently you can specify the weight of the cooling device in the device
tree but that information is not populated to the
thermal_bind_params where the fair share governor expects it to
be.  The of thermal zone device doesn't have a thermal_bind_params
structure and arguably it's better to pass the weight inside the
thermal_instance as it is specific to the bind of a cooling device to a
thermal zone parameter.

Core thermal code is fixed to populate the weight in the instance from
the thermal_bind_params, so platform code that was passing the weight
inside the thermal_bind_params continue to work seamlessly.

While we are at it, create a default value for the weight parameter for
those thermal zones that currently don't define it and remove the
hardcoded default in of-thermal.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Kukjin Kim <kgene@kernel.org>
Signed-off-by: Kapileshwar Singh <kapileshwar.singh@arm.com>
---

This patch was previously suggested here[0].  During the discussion,
Eduardo suggested that dropping the bind op for of-thermal and using
tbps and their .match() function was preferrable.  We sent a series
that did that in [1].  However, looking at the code we think that this
patch is preferrable as it is simpler and enables the rest of the
patches in these series, specially the simplification in patch 2.
That's why we are reposting it, now properly asking for inclusion.

[0] http://thread.gmane.org/gmane.linux.power-management.general/54622
[1] http://thread.gmane.org/gmane.linux.power-management.general/55339

 Documentation/thermal/sysfs-api.txt                |  4 +++-
 drivers/thermal/db8500_thermal.c                   |  2 +-
 drivers/thermal/fair_share.c                       |  2 +-
 drivers/thermal/imx_thermal.c                      |  3 ++-
 drivers/thermal/of-thermal.c                       |  5 +++--
 drivers/thermal/samsung/exynos_thermal_common.c    |  3 ++-
 drivers/thermal/thermal_core.c                     | 22 ++++++++++++++++------
 drivers/thermal/thermal_core.h                     |  1 +
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c |  3 ++-
 include/linux/thermal.h                            |  6 +++++-
 10 files changed, 36 insertions(+), 15 deletions(-)

diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/thermal/sysfs-api.txt
index 87519cb379ee..7ec632ed9769 100644
--- a/Documentation/thermal/sysfs-api.txt
+++ b/Documentation/thermal/sysfs-api.txt
@@ -95,7 +95,7 @@ temperature) and throttle appropriate devices.
 1.3 interface for binding a thermal zone device with a thermal cooling device
 1.3.1 int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
 	int trip, struct thermal_cooling_device *cdev,
-	unsigned long upper, unsigned long lower);
+	unsigned long upper, unsigned long lower, unsigned int weight);
 
     This interface function bind a thermal cooling device to the certain trip
     point of a thermal zone device.
@@ -110,6 +110,8 @@ temperature) and throttle appropriate devices.
     lower:the Minimum cooling state can be used for this trip point.
           THERMAL_NO_LIMIT means no lower limit,
 	  and the cooling device can be in cooling state 0.
+    weight: the influence of this cooling device in this thermal
+            zone.  See 1.4.1 below for more information.
 
 1.3.2 int thermal_zone_unbind_cooling_device(struct thermal_zone_device *tz,
 		int trip, struct thermal_cooling_device *cdev);
diff --git a/drivers/thermal/db8500_thermal.c b/drivers/thermal/db8500_thermal.c
index 20adfbe27df1..2fb273c4baa9 100644
--- a/drivers/thermal/db8500_thermal.c
+++ b/drivers/thermal/db8500_thermal.c
@@ -76,7 +76,7 @@ static int db8500_cdev_bind(struct thermal_zone_device *thermal,
 		upper = lower = i > max_state ? max_state : i;
 
 		ret = thermal_zone_bind_cooling_device(thermal, i, cdev,
-			upper, lower);
+			upper, lower, THERMAL_WEIGHT_DEFAULT);
 
 		dev_info(&cdev->device, "%s bind to %d: %d-%s\n", cdev->type,
 			i, ret, ret ? "fail" : "succeed");
diff --git a/drivers/thermal/fair_share.c b/drivers/thermal/fair_share.c
index 6e0a3fbfae86..c3b25187b467 100644
--- a/drivers/thermal/fair_share.c
+++ b/drivers/thermal/fair_share.c
@@ -109,7 +109,7 @@ static int fair_share_throttle(struct thermal_zone_device *tz, int trip)
 			continue;
 
 		instance->target = get_target_state(tz, cdev,
-					tzp->tbp[i].weight, cur_trip_level);
+					instance->weight, cur_trip_level);
 
 		instance->cdev->updated = false;
 		thermal_cdev_update(cdev);
diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index 2ccbc0788353..36579c05605f 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -306,7 +306,8 @@ static int imx_bind(struct thermal_zone_device *tz,
 
 	ret = thermal_zone_bind_cooling_device(tz, IMX_TRIP_PASSIVE, cdev,
 					       THERMAL_NO_LIMIT,
-					       THERMAL_NO_LIMIT);
+					       THERMAL_NO_LIMIT
+					       THERMAL_WEIGHT_DEFAULT);
 	if (ret) {
 		dev_err(&tz->device,
 			"binding zone %s with cdev %s failed:%d\n",
diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index d717f3dab6f1..60e3a21461e7 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -227,7 +227,8 @@ static int of_thermal_bind(struct thermal_zone_device *thermal,
 			ret = thermal_zone_bind_cooling_device(thermal,
 						tbp->trip_id, cdev,
 						tbp->max,
-						tbp->min);
+						tbp->min,
+						tbp->usage);
 			if (ret)
 				return ret;
 		}
@@ -578,7 +579,7 @@ static int thermal_of_populate_bind_params(struct device_node *np,
 	u32 prop;
 
 	/* Default weight. Usage is optional */
-	__tbp->usage = 0;
+	__tbp->usage = THERMAL_WEIGHT_DEFAULT;
 	ret = of_property_read_u32(np, "contribution", &prop);
 	if (ret == 0)
 		__tbp->usage = prop;
diff --git a/drivers/thermal/samsung/exynos_thermal_common.c b/drivers/thermal/samsung/exynos_thermal_common.c
index 6dc3815cc73f..03f2ebb1e5c3 100644
--- a/drivers/thermal/samsung/exynos_thermal_common.c
+++ b/drivers/thermal/samsung/exynos_thermal_common.c
@@ -163,7 +163,8 @@ static int exynos_bind(struct thermal_zone_device *thermal,
 		case MONITOR_ZONE:
 		case WARN_ZONE:
 			if (thermal_zone_bind_cooling_device(thermal, i, cdev,
-								level, 0)) {
+						level, 0,
+						THERMAL_WEIGHT_DEFAULT)) {
 				dev_err(data->dev,
 					"error unbinding cdev inst=%d\n", i);
 				ret = -EINVAL;
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 87e0b0782023..9a424a66c83a 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -218,7 +218,8 @@ static void print_bind_err_msg(struct thermal_zone_device *tz,
 
 static void __bind(struct thermal_zone_device *tz, int mask,
 			struct thermal_cooling_device *cdev,
-			unsigned long *limits)
+			unsigned long *limits,
+			unsigned int weight)
 {
 	int i, ret;
 
@@ -233,7 +234,8 @@ static void __bind(struct thermal_zone_device *tz, int mask,
 				upper = limits[i * 2 + 1];
 			}
 			ret = thermal_zone_bind_cooling_device(tz, i, cdev,
-							       upper, lower);
+							       upper, lower,
+							       weight);
 			if (ret)
 				print_bind_err_msg(tz, cdev, ret);
 		}
@@ -280,7 +282,8 @@ static void bind_cdev(struct thermal_cooling_device *cdev)
 				continue;
 			tzp->tbp[i].cdev = cdev;
 			__bind(pos, tzp->tbp[i].trip_mask, cdev,
-			       tzp->tbp[i].binding_limits);
+			       tzp->tbp[i].binding_limits,
+			       tzp->tbp[i].weight);
 		}
 	}
 
@@ -319,7 +322,8 @@ static void bind_tz(struct thermal_zone_device *tz)
 				continue;
 			tzp->tbp[i].cdev = pos;
 			__bind(tz, tzp->tbp[i].trip_mask, pos,
-			       tzp->tbp[i].binding_limits);
+			       tzp->tbp[i].binding_limits,
+			       tzp->tbp[i].weight);
 		}
 	}
 exit:
@@ -711,7 +715,8 @@ passive_store(struct device *dev, struct device_attribute *attr,
 				thermal_zone_bind_cooling_device(tz,
 						THERMAL_TRIPS_NONE, cdev,
 						THERMAL_NO_LIMIT,
-						THERMAL_NO_LIMIT);
+						THERMAL_NO_LIMIT,
+						THERMAL_WEIGHT_DEFAULT);
 		}
 		mutex_unlock(&thermal_list_lock);
 		if (!tz->passive_delay)
@@ -913,6 +918,9 @@ thermal_cooling_device_trip_point_show(struct device *dev,
  * @lower:	the Minimum cooling state can be used for this trip point.
  *		THERMAL_NO_LIMIT means no lower limit,
  *		and the cooling device can be in cooling state 0.
+ * @weight:	The weight of the cooling device to be bound to the
+ *		thermal zone. Use THERMAL_WEIGHT_DEFAULT for the
+ *		default value
  *
  * This interface function bind a thermal cooling device to the certain trip
  * point of a thermal zone device.
@@ -923,7 +931,8 @@ thermal_cooling_device_trip_point_show(struct device *dev,
 int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
 				     int trip,
 				     struct thermal_cooling_device *cdev,
-				     unsigned long upper, unsigned long lower)
+				     unsigned long upper, unsigned long lower,
+				     unsigned int weight)
 {
 	struct thermal_instance *dev;
 	struct thermal_instance *pos;
@@ -968,6 +977,7 @@ int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
 	dev->upper = upper;
 	dev->lower = lower;
 	dev->target = THERMAL_NO_TARGET;
+	dev->weight = weight;
 
 	result = get_idr(&tz->idr, &tz->lock, &dev->id);
 	if (result)
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 0531c752fbbb..7a465e9d456c 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -48,6 +48,7 @@ struct thermal_instance {
 	struct device_attribute attr;
 	struct list_head tz_node; /* node in tz->thermal_instances */
 	struct list_head cdev_node; /* node in cdev->thermal_instances */
+	unsigned int weight; /* The weight of the cooling device */
 };
 
 int thermal_register_governor(struct thermal_governor *);
diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
index 3fb054a10f6a..4638718fabf6 100644
--- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
+++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
@@ -146,7 +146,8 @@ static int ti_thermal_bind(struct thermal_zone_device *thermal,
 	return thermal_zone_bind_cooling_device(thermal, 0, cdev,
 	/* bind with min and max states defined by cpu_cooling */
 						THERMAL_NO_LIMIT,
-						THERMAL_NO_LIMIT);
+						THERMAL_NO_LIMIT,
+						THERMAL_WEIGHT_DEFAULT);
 }
 
 /* Unbind callback functions for thermal zone */
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index fc52e307efab..2ed7062fac1d 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -40,6 +40,9 @@
 /* No upper/lower limit requirement */
 #define THERMAL_NO_LIMIT	((u32)~0)
 
+/* Default weight of a bound cooling device */
+#define THERMAL_WEIGHT_DEFAULT 0
+
 /* Unit conversion macros */
 #define KELVIN_TO_CELSIUS(t)	(long)(((long)t-2732 >= 0) ?	\
 				((long)t-2732+5)/10 : ((long)t-2732-5)/10)
@@ -321,7 +324,8 @@ void thermal_zone_device_unregister(struct thermal_zone_device *);
 
 int thermal_zone_bind_cooling_device(struct thermal_zone_device *, int,
 				     struct thermal_cooling_device *,
-				     unsigned long, unsigned long);
+				     unsigned long, unsigned long,
+				     unsigned int);
 int thermal_zone_unbind_cooling_device(struct thermal_zone_device *, int,
 				       struct thermal_cooling_device *);
 void thermal_zone_device_update(struct thermal_zone_device *);
-- 
1.9.1

