From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCHv3 03/48] thermal: core: group device_create_file() calls that are always created
Date: Mon, 30 May 2016 15:15:39 -0700
Message-ID: <1464646584-14322-4-git-send-email-edubezval@gmail.com>
References: <1464646584-14322-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464646584-14322-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

Simple code reorganization to group files that are always created
when registering a thermal zone.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/thermal_core.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 956e7e1..3ce7882 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1858,14 +1858,6 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
 	}
 
 	/* sys I/F */
-	result = device_create_file(&tz->device, &dev_attr_type);
-	if (result)
-		goto unregister;
-
-	result = device_create_file(&tz->device, &dev_attr_temp);
-	if (result)
-		goto unregister;
-
 	if (ops->get_mode) {
 		result = device_create_file(&tz->device, &dev_attr_mode);
 		if (result)
@@ -1900,13 +1892,16 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
 			goto unregister;
 	}
 
-	/* Create policy attribute */
-	result = device_create_file(&tz->device, &dev_attr_policy);
+	result = device_create_file(&tz->device, &dev_attr_type);
 	if (result)
 		goto unregister;
 
-	/* Add thermal zone params */
-	result = create_tzp_attrs(&tz->device);
+	result = device_create_file(&tz->device, &dev_attr_temp);
+	if (result)
+		goto unregister;
+
+	/* Create policy attribute */
+	result = device_create_file(&tz->device, &dev_attr_policy);
 	if (result)
 		goto unregister;
 
@@ -1915,6 +1910,11 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
 	if (result)
 		goto unregister;
 
+	/* Add thermal zone params */
+	result = create_tzp_attrs(&tz->device);
+	if (result)
+		goto unregister;
+
 	/* Update 'this' zone's governor information */
 	mutex_lock(&thermal_governor_lock);
 
-- 
2.1.4
