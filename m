From: Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2] thermal: re-calculate k_po/k_pu when update sustainable power
Date: Wed, 30 Dec 2015 18:38:40 +0800
Message-ID: <1451471920-2148-1-git-send-email-leo.yan@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:36573 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754019AbbL3Kit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 30 Dec 2015 05:38:49 -0500
Received: by mail-pf0-f176.google.com with SMTP id 65so95848168pff.3
        for <linux-pm@vger.kernel.org>; Wed, 30 Dec 2015 02:38:49 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, javi.merino@arm.com
Cc: Leo Yan <leo.yan@linaro.org>

k_po/k_pu are in essence ratio values compared with sustainable power.
So when update sustainable power, we can recalculate k_po/k_pu simply
with below formula:

               sustainable_power(new)
    k_p(new) = ---------------------- * k_p(old)
               sustainable_power(old)

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/thermal/thermal_core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index d9e525c..223f8df 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -908,7 +908,7 @@ sustainable_power_store(struct device *dev, struct device_attribute *devattr,
 			const char *buf, size_t count)
 {
 	struct thermal_zone_device *tz = to_thermal_zone(dev);
-	u32 sustainable_power;
+	u32 sustainable_power, old_val;
 
 	if (!tz->tzp)
 		return -EIO;
@@ -916,8 +916,12 @@ sustainable_power_store(struct device *dev, struct device_attribute *devattr,
 	if (kstrtou32(buf, 10, &sustainable_power))
 		return -EINVAL;
 
+	old_val = tz->tzp->sustainable_power;
+
 	tz->tzp->sustainable_power = sustainable_power;
 
+	tz->tzp->k_po = (tz->tzp->k_po * sustainable_power) / old_val;
+	tz->tzp->k_pu = (tz->tzp->k_pu * sustainable_power) / old_val;
 	return count;
 }
 static DEVICE_ATTR(sustainable_power, S_IWUSR | S_IRUGO, sustainable_power_show,
-- 
1.9.1

