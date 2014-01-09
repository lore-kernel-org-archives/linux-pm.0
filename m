From: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 2/2] thermal: use device node to get thermal zone
Date: Thu, 9 Jan 2014 18:37:59 +0800
Message-ID: <1389263879-10483-3-git-send-email-wni@nvidia.com>
References: <1389263879-10483-1-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1389263879-10483-1-git-send-email-wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: eduardo.valentin-l0cyMroinI0@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, durgadoss.r-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

The thermal fw support same name for different thermal zones.
If use name to get the thermal zone, sometimes it can't get
the unique thermal zone. And the of-thermal driver is used
to parse DT for thermal fw, so it's better to use device node
to lookup and get thermal zone.

Change-Id: I6c690902a9535915b2f49f9921779fbcd5ecd88c
Signed-off-by: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/thermal/of-thermal.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index 53f2d3a..97c12cf 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -330,7 +330,7 @@ thermal_zone_of_add_sensor(struct device_node *zone,
 	struct thermal_zone_device *tzd;
 	struct __thermal_zone *tz;
 
-	tzd = thermal_zone_get_zone_by_name(zone->name);
+	tzd = thermal_zone_get_zone_by_node(zone);
 	if (IS_ERR(tzd))
 		return ERR_PTR(-EPROBE_DEFER);
 
@@ -839,7 +839,7 @@ void of_thermal_destroy_zones(void)
 	for_each_child_of_node(np, child) {
 		struct thermal_zone_device *zone;
 
-		zone = thermal_zone_get_zone_by_name(child->name);
+		zone = thermal_zone_get_zone_by_node(child);
 		if (IS_ERR(zone))
 			continue;
 
-- 
1.7.9.5
