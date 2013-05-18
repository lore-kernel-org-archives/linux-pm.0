From: Jonghwa Lee <jonghwa3.lee@samsung.com>
Subject: [PATCH 2/3] Thermal: core: Modify temp_crit_show() to use proper
 callback function.
Date: Sat, 18 May 2013 18:50:56 +0900
Message-ID: <1368870656-1183-1-git-send-email-jonghwa3.lee@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:22507 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752974Ab3ERJvE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 18 May 2013 05:51:04 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, Amit Dinel Kachhap <amit.kachhap@linaro.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>

This patch modifies temp_crit_show() which is used to create hwmon's sysfs
node to use .get_crit_temp callback function of thermal zone device rather
than .get_trip_temp.

Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
---
 drivers/thermal/thermal_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index f753f48..ce4384a 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -924,7 +924,7 @@ temp_crit_show(struct device *dev, struct device_attribute *attr,
 	long temperature;
 	int ret;
 
-	ret = tz->ops->get_trip_temp(tz, 0, &temperature);
+	ret = tz->ops->get_crit_temp(tz, &temperature);
 	if (ret)
 		return ret;
 
-- 
1.7.9.5

