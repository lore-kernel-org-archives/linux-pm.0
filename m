From: Nicolin Chen <nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] thermal: tegra: remove forward declarations
Date: Wed, 25 Oct 2017 00:03:37 -0700
Message-ID: <1508915017-23234-1-git-send-email-nicoleotsuka@gmail.com>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, srikars-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

This patch just simply moves tegra_thermctl_set_trip_temp() behind
those function implementations so that it can remove those forward
declarations.

Signed-off-by: Nicolin Chen <nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/thermal/tegra/soctherm.c | 103 ++++++++++++++++++---------------------
 1 file changed, 47 insertions(+), 56 deletions(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index 075db1d..455b58c 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -341,62 +341,6 @@ static int tegra_thermctl_get_temp(void *data, int *out_temp)
 	return 0;
 }
 
-static int
-thermtrip_program(struct device *dev, const struct tegra_tsensor_group *sg,
-		  int trip_temp);
-static int
-throttrip_program(struct device *dev, const struct tegra_tsensor_group *sg,
-		  struct soctherm_throt_cfg *stc, int trip_temp);
-static struct soctherm_throt_cfg *
-find_throttle_cfg_by_name(struct tegra_soctherm *ts, const char *name);
-
-static int tegra_thermctl_set_trip_temp(void *data, int trip, int temp)
-{
-	struct tegra_thermctl_zone *zone = data;
-	struct thermal_zone_device *tz = zone->tz;
-	struct tegra_soctherm *ts = zone->ts;
-	const struct tegra_tsensor_group *sg = zone->sg;
-	struct device *dev = zone->dev;
-	enum thermal_trip_type type;
-	int ret;
-
-	if (!tz)
-		return -EINVAL;
-
-	ret = tz->ops->get_trip_type(tz, trip, &type);
-	if (ret)
-		return ret;
-
-	if (type == THERMAL_TRIP_CRITICAL) {
-		return thermtrip_program(dev, sg, temp);
-	} else if (type == THERMAL_TRIP_HOT) {
-		int i;
-
-		for (i = 0; i < THROTTLE_SIZE; i++) {
-			struct thermal_cooling_device *cdev;
-			struct soctherm_throt_cfg *stc;
-
-			if (!ts->throt_cfgs[i].init)
-				continue;
-
-			cdev = ts->throt_cfgs[i].cdev;
-			if (get_thermal_instance(tz, cdev, trip))
-				stc = find_throttle_cfg_by_name(ts, cdev->type);
-			else
-				continue;
-
-			return throttrip_program(dev, sg, stc, temp);
-		}
-	}
-
-	return 0;
-}
-
-static const struct thermal_zone_of_device_ops tegra_of_thermal_ops = {
-	.get_temp = tegra_thermctl_get_temp,
-	.set_trip_temp = tegra_thermctl_set_trip_temp,
-};
-
 /**
  * enforce_temp_range() - check and enforce temperature range [min, max]
  * @trip_temp: the trip temperature to check
@@ -527,6 +471,53 @@ find_throttle_cfg_by_name(struct tegra_soctherm *ts, const char *name)
 	return NULL;
 }
 
+static int tegra_thermctl_set_trip_temp(void *data, int trip, int temp)
+{
+	struct tegra_thermctl_zone *zone = data;
+	struct thermal_zone_device *tz = zone->tz;
+	struct tegra_soctherm *ts = zone->ts;
+	const struct tegra_tsensor_group *sg = zone->sg;
+	struct device *dev = zone->dev;
+	enum thermal_trip_type type;
+	int ret;
+
+	if (!tz)
+		return -EINVAL;
+
+	ret = tz->ops->get_trip_type(tz, trip, &type);
+	if (ret)
+		return ret;
+
+	if (type == THERMAL_TRIP_CRITICAL) {
+		return thermtrip_program(dev, sg, temp);
+	} else if (type == THERMAL_TRIP_HOT) {
+		int i;
+
+		for (i = 0; i < THROTTLE_SIZE; i++) {
+			struct thermal_cooling_device *cdev;
+			struct soctherm_throt_cfg *stc;
+
+			if (!ts->throt_cfgs[i].init)
+				continue;
+
+			cdev = ts->throt_cfgs[i].cdev;
+			if (get_thermal_instance(tz, cdev, trip))
+				stc = find_throttle_cfg_by_name(ts, cdev->type);
+			else
+				continue;
+
+			return throttrip_program(dev, sg, stc, temp);
+		}
+	}
+
+	return 0;
+}
+
+static const struct thermal_zone_of_device_ops tegra_of_thermal_ops = {
+	.get_temp = tegra_thermctl_get_temp,
+	.set_trip_temp = tegra_thermctl_set_trip_temp,
+};
+
 static int get_hot_temp(struct thermal_zone_device *tz, int *trip, int *temp)
 {
 	int ntrips, i, ret;
-- 
2.1.4
