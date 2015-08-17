From: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [RFC PATCH 2/2] thermal: x86_pkg_temp: Register threshold callbacks
Date: Mon, 17 Aug 2015 16:52:57 -0700
Message-ID: <1439855577-17114-2-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1439855577-17114-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1439855577-17114-1-git-send-email-srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Register callbacks to get/set temperature thresholds.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/thermal/x86_pkg_temp_thermal.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/thermal/x86_pkg_temp_thermal.c b/drivers/thermal/x86_pkg_temp_thermal.c
index 50d1d2c..4b526b8 100644
--- a/drivers/thermal/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/x86_pkg_temp_thermal.c
@@ -279,6 +279,8 @@ static struct thermal_zone_device_ops tzone_ops = {
 	.get_trip_temp = sys_get_trip_temp,
 	.get_trip_type = sys_get_trip_type,
 	.set_trip_temp = sys_set_trip_temp,
+	.get_threshold_temp = sys_get_trip_temp,
+	.set_threshold_temp = sys_set_trip_temp,
 };
 
 static bool pkg_temp_thermal_platform_thermal_rate_control(void)
-- 
2.4.3
