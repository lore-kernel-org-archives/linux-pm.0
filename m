From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 6/6] thermal: x86_pkg_temp: Register threshold callbacks
Date: Sat, 26 Sep 2015 15:05:11 -0700
Message-ID: <1443305111-28272-7-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1443305111-28272-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:17552 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932651AbbIZWFo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 26 Sep 2015 18:05:44 -0400
In-Reply-To: <1443305111-28272-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: jic23@kernel.org, rui.zhang@intel.com, edubezval@gmail.com, linux-pm@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Register callbacks to get/set temperature thresholds.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
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
2.4.3

