From: Leo Yan <leo.yan@linaro.org>
Subject: [PATCH] thermal: fix the casting issue for long type
Date: Thu, 26 Feb 2015 14:01:32 +0800
Message-ID: <1424930492-22658-1-git-send-email-leo.yan@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:41396 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750768AbbBZGBw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 26 Feb 2015 01:01:52 -0500
Received: by padfb1 with SMTP id fb1so11332805pad.8
        for <linux-pm@vger.kernel.org>; Wed, 25 Feb 2015 22:01:51 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@linaro.org>

When enable the thermal on arm64 platform, it will report failure when
call function *thermal_zone_bind_cooling_device()*.

The failure is caused by casting. If dtb specify the minimum cooling
state and maximum cooling state as THERMAL_NO_LIMIT, then variables
"lower" and "upper" equal to 0x0000_0000_ffff_fffff after casting the
value from "unsigned int" to "unsigned long".

Finally in kernel if check the variables "lower" and "upper", it will
never equal to (-1UL), or 0xffff_ffff_ffff_fffff.

So change to use "unsigned int" type, this can be compatible for 32 bits
and 64 bits system.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/thermal/of-thermal.c   | 4 ++--
 drivers/thermal/thermal_core.c | 6 +++---
 include/linux/thermal.h        | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index 668fb1b..b50c4e1 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -49,8 +49,8 @@ struct __thermal_bind_params {
 	struct device_node *cooling_device;
 	unsigned int trip_id;
 	unsigned int usage;
-	unsigned long min;
-	unsigned long max;
+	unsigned int min;
+	unsigned int max;
 };
 
 /**
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 48491d1..04de575 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -923,7 +923,7 @@ thermal_cooling_device_trip_point_show(struct device *dev,
 int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
 				     int trip,
 				     struct thermal_cooling_device *cdev,
-				     unsigned long upper, unsigned long lower)
+				     unsigned int upper, unsigned int lower)
 {
 	struct thermal_instance *dev;
 	struct thermal_instance *pos;
@@ -952,8 +952,8 @@ int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
 		return ret;
 
 	/* lower default 0, upper default max_state */
-	lower = lower == THERMAL_NO_LIMIT ? 0 : lower;
-	upper = upper == THERMAL_NO_LIMIT ? max_state : upper;
+	lower = lower == (unsigned int)THERMAL_NO_LIMIT ? 0 : lower;
+	upper = upper == (unsigned int)THERMAL_NO_LIMIT ? max_state : upper;
 
 	if (lower > upper || upper > max_state)
 		return -EINVAL;
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index fc52e30..a2afe04 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -321,7 +321,7 @@ void thermal_zone_device_unregister(struct thermal_zone_device *);
 
 int thermal_zone_bind_cooling_device(struct thermal_zone_device *, int,
 				     struct thermal_cooling_device *,
-				     unsigned long, unsigned long);
+				     unsigned int, unsigned int);
 int thermal_zone_unbind_cooling_device(struct thermal_zone_device *, int,
 				       struct thermal_cooling_device *);
 void thermal_zone_device_update(struct thermal_zone_device *);
-- 
1.9.1

