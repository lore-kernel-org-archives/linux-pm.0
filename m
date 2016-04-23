From: Eduardo Valentin <edubezval@gmail.com>
Subject: [RFC PATCH 01/11] thermal: prevent zones with no types to be registered
Date: Sat, 23 Apr 2016 16:34:20 -0700
Message-ID: <1461454470-27714-2-git-send-email-edubezval@gmail.com>
References: <1461454470-27714-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:36860 "EHLO
	mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752408AbcDWXeq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 23 Apr 2016 19:34:46 -0400
In-Reply-To: <1461454470-27714-1-git-send-email-edubezval@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>

There are APIs that rely on tz->type. This patch
prevent thermal zones without it to be registered.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/thermal_core.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index d4b5465..650e5fa 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1810,6 +1810,9 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
 	int passive = 0;
 	struct thermal_governor *governor;
 
+	if (!type || strlen(type) == 0)
+		return ERR_PTR(-EINVAL);
+
 	if (type && strlen(type) >= THERMAL_NAME_LENGTH)
 		return ERR_PTR(-EINVAL);
 
@@ -1835,7 +1838,7 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
 		return ERR_PTR(result);
 	}
 
-	strlcpy(tz->type, type ? : "", sizeof(tz->type));
+	strlcpy(tz->type, type, sizeof(tz->type));
 	tz->ops = ops;
 	tz->tzp = tzp;
 	tz->device.class = &thermal_class;
@@ -1855,11 +1858,9 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
 	}
 
 	/* sys I/F */
-	if (type) {
-		result = device_create_file(&tz->device, &dev_attr_type);
-		if (result)
-			goto unregister;
-	}
+	result = device_create_file(&tz->device, &dev_attr_type);
+	if (result)
+		goto unregister;
 
 	result = device_create_file(&tz->device, &dev_attr_temp);
 	if (result)
@@ -2008,8 +2009,7 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 
 	thermal_zone_device_set_polling(tz, 0);
 
-	if (tz->type[0])
-		device_remove_file(&tz->device, &dev_attr_type);
+	device_remove_file(&tz->device, &dev_attr_type);
 	device_remove_file(&tz->device, &dev_attr_temp);
 	if (tz->ops->get_mode)
 		device_remove_file(&tz->device, &dev_attr_mode);
-- 
2.1.4

