From: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [RFC PATCH v2 4/4] thermal: x86_pkg_temp: Register threshold callbacks
Date: Thu, 17 Sep 2015 15:30:54 -0700
Message-ID: <1442529054-25803-5-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1442529054-25803-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1442529054-25803-1-git-send-email-srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Register callbacks to get/set temperature thresholds.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/thermal/x86_pkg_temp_thermal.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/thermal/x86_pkg_temp_thermal.c b/drivers/thermal/x86_pkg_temp_thermal.c
index 849f682..58d0770 100644
--- a/drivers/thermal/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/x86_pkg_temp_thermal.c
@@ -273,12 +273,20 @@ static int sys_get_trip_type(struct thermal_zone_device *thermal,
 	return 0;
 }
 
+static bool sys_check_notify_support(struct thermal_zone_device *tz)
+{
+	return true;
+}
+
 /* Thermal zone callback registry */
 static struct thermal_zone_device_ops tzone_ops = {
 	.get_temp = sys_get_curr_temp,
 	.get_trip_temp = sys_get_trip_temp,
 	.get_trip_type = sys_get_trip_type,
 	.set_trip_temp = sys_set_trip_temp,
+	.get_threshold_temp = sys_get_trip_temp,
+	.set_threshold_temp = sys_set_trip_temp,
+	.check_notification_support = sys_check_notify_support,
 };
 
 static bool pkg_temp_thermal_platform_thermal_rate_control(void)
-- 
1.9.3
