From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 2/3] thermal: exynos: Fix potential NULL pointer dereference
Date: Mon, 19 Aug 2013 11:58:42 +0530
Message-ID: <1376893723-22138-2-git-send-email-sachin.kamat@linaro.org>
References: <1376893723-22138-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f47.google.com ([209.85.160.47]:48462 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751006Ab3HSGqA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 19 Aug 2013 02:46:00 -0400
Received: by mail-pb0-f47.google.com with SMTP id rr4so4587661pbb.20
        for <linux-pm@vger.kernel.org>; Sun, 18 Aug 2013 23:46:00 -0700 (PDT)
In-Reply-To: <1376893723-22138-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: jonghwa3.lee@samsung.com, eduardo.valentin@ti.com, rui.zhang@intel.com, amit.daniel@samsung.com, sachin.kamat@linaro.org, patches@linaro.org

NULL pointer was being dereferenced in its own error message.
Changed it to the correct device pointer.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/thermal/samsung/exynos_thermal_common.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_thermal_common.c b/drivers/thermal/samsung/exynos_thermal_common.c
index 4d8e444..f10a6ad 100644
--- a/drivers/thermal/samsung/exynos_thermal_common.c
+++ b/drivers/thermal/samsung/exynos_thermal_common.c
@@ -53,7 +53,7 @@ static int exynos_set_mode(struct thermal_zone_device *thermal,
 {
 	struct exynos_thermal_zone *th_zone = thermal->devdata;
 	if (!th_zone) {
-		dev_err(th_zone->sensor_conf->dev,
+		dev_err(&thermal->device,
 			"thermal zone not registered\n");
 		return 0;
 	}
@@ -231,7 +231,7 @@ static int exynos_get_temp(struct thermal_zone_device *thermal,
 	void *data;
 
 	if (!th_zone->sensor_conf) {
-		dev_err(th_zone->sensor_conf->dev,
+		dev_err(&thermal->device,
 			"Temperature sensor not initialised\n");
 		return -EINVAL;
 	}
@@ -251,7 +251,7 @@ static int exynos_set_emul_temp(struct thermal_zone_device *thermal,
 	struct exynos_thermal_zone *th_zone = thermal->devdata;
 
 	if (!th_zone->sensor_conf) {
-		dev_err(th_zone->sensor_conf->dev,
+		dev_err(&thermal->device,
 			"Temperature sensor not initialised\n");
 		return -EINVAL;
 	}
-- 
1.7.9.5

