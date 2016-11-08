From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCHv2 01/49] thermal: core: prevent zones with no types to be registered
Date: Mon,  7 Nov 2016 21:08:39 -0800
Message-ID: <1478581767-7009-2-git-send-email-edubezval@gmail.com>
References: <1478581767-7009-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1478581767-7009-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

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
index 226b0b4ac..ec0d158 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1873,6 +1873,9 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
 	int passive = 0;
 	struct thermal_governor *governor;
 
+	if (!type || strlen(type) == 0)
+		return ERR_PTR(-EINVAL);
+
 	if (type && strlen(type) >= THERMAL_NAME_LENGTH)
 		return ERR_PTR(-EINVAL);
 
@@ -1898,7 +1901,7 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
 		return ERR_PTR(result);
 	}
 
-	strlcpy(tz->type, type ? : "", sizeof(tz->type));
+	strlcpy(tz->type, type, sizeof(tz->type));
 	tz->ops = ops;
 	tz->tzp = tzp;
 	tz->device.class = &thermal_class;
@@ -1918,11 +1921,9 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
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
@@ -2071,8 +2072,7 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 
 	thermal_zone_device_set_polling(tz, 0);
 
-	if (tz->type[0])
-		device_remove_file(&tz->device, &dev_attr_type);
+	device_remove_file(&tz->device, &dev_attr_type);
 	device_remove_file(&tz->device, &dev_attr_temp);
 	if (tz->ops->get_mode)
 		device_remove_file(&tz->device, &dev_attr_mode);
-- 
2.1.4
