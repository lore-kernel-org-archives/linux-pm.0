From: Leo Yan <leo.yan@linaro.org>
Subject: [RESEND PATCH] thermal: use %d to print S32 parameters
Date: Tue, 29 Mar 2016 19:24:15 +0800
Message-ID: <1459250655-22857-1-git-send-email-leo.yan@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vk0-f44.google.com ([209.85.213.44]:36105 "EHLO
	mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756825AbcC2LYg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 29 Mar 2016 07:24:36 -0400
Received: by mail-vk0-f44.google.com with SMTP id z68so14077585vkg.3
        for <linux-pm@vger.kernel.org>; Tue, 29 Mar 2016 04:24:36 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Leo Yan <leo.yan@linaro.org>

Power allocator's parameters are S32 type, so use %d to print them.

Acked-by: Javi Merino <javi.merino@arm.com>
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

