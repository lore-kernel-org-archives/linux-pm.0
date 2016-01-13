From: Leo Yan <leo.yan@linaro.org>
Subject: [PATCH] thermal: use %d to print S32 parameters
Date: Wed, 13 Jan 2016 16:33:56 +0800
Message-ID: <1452674036-14907-1-git-send-email-leo.yan@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:35967 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750856AbcAMIe3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 13 Jan 2016 03:34:29 -0500
Received: by mail-pf0-f172.google.com with SMTP id n128so77671145pfn.3
        for <linux-pm@vger.kernel.org>; Wed, 13 Jan 2016 00:34:28 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Javi Merino <javi.merino@arm.com>, Punit Agrawal <punit.agrawal@arm.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@linaro.org>

Power allocator's parameters are S32 type, so use %d to print them.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/thermal/thermal_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index d9e525c..1335df2 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -931,7 +931,7 @@ static DEVICE_ATTR(sustainable_power, S_IWUSR | S_IRUGO, sustainable_power_show,
 	struct thermal_zone_device *tz = to_thermal_zone(dev);		\
 									\
 	if (tz->tzp)							\
-		return sprintf(buf, "%u\n", tz->tzp->name);		\
+		return sprintf(buf, "%d\n", tz->tzp->name);		\
 	else								\
 		return -EIO;						\
 	}								\
-- 
1.9.1

