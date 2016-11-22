From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] thermal: hwmon: Properly report critical temperature in sysfs
Date: Tue, 22 Nov 2016 19:22:44 +0200
Message-ID: <1479835364-27914-1-git-send-email-krzk@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:49296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753755AbcKVRZS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 22 Nov 2016 12:25:18 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>, stable@vger.kernel.org

In the critical sysfs entry the thermal hwmon was returning wrong
temperature to the user-space.  It was reporting the temperature of the
first trip point instead of the temperature of critical trip point.

For example:
	/sys/class/hwmon/hwmon0/temp1_crit:50000
	/sys/class/thermal/thermal_zone0/trip_point_0_temp:50000
	/sys/class/thermal/thermal_zone0/trip_point_0_type:active
	/sys/class/thermal/thermal_zone0/trip_point_3_temp:120000
	/sys/class/thermal/thermal_zone0/trip_point_3_type:critical

Since commit e68b16abd91d ("thermal: add hwmon sysfs I/F") the driver
have been registering a sysfs entry if get_crit_temp() callback was
provided.  However when accessed, it was calling get_trip_temp() instead
of the get_crit_temp().

Fixes: e68b16abd91d ("thermal: add hwmon sysfs I/F")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/thermal/thermal_hwmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_hwmon.c
index c41c7742903a..2dcd4194d103 100644
--- a/drivers/thermal/thermal_hwmon.c
+++ b/drivers/thermal/thermal_hwmon.c
@@ -98,7 +98,7 @@ temp_crit_show(struct device *dev, struct device_attribute *attr, char *buf)
 	int temperature;
 	int ret;
 
-	ret = tz->ops->get_trip_temp(tz, 0, &temperature);
+	ret = tz->ops->get_crit_temp(tz, &temperature);
 	if (ret)
 		return ret;
 
-- 
2.7.4

