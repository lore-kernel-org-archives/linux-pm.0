From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 10/31] thermal: core: create tz->device.groups dynamically
Date: Tue,  3 May 2016 23:02:24 -0700
Message-ID: <1462341765-13268-11-git-send-email-edubezval@gmail.com>
References: <1462341765-13268-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462341765-13268-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

This is a patch to allow adding groups created dynamically. For now we
create only the existing group. However, this is a preparation to allow
creating trip groups, which are determined only when the number of trips
are known at runtime.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/thermal_core.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index b1b2945..13a85d7 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1169,7 +1169,7 @@ static const struct attribute_group *thermal_zone_attribute_groups[] = {
 	&thermal_zone_attribute_group,
 	&thermal_zone_mode_attribute_group,
 	&thermal_zone_passive_attribute_group,
-	NULL
+	/* This is not NULL terminated as we create the group dynamically */
 };
 
 /**
@@ -1281,6 +1281,25 @@ static void remove_trip_attrs(struct thermal_zone_device *tz)
 	kfree(tz->trip_hyst_attrs);
 }
 
+static int thermal_zone_create_device_groups(struct thermal_zone_device *tz)
+{
+	const struct attribute_group **groups;
+	int i, size;
+
+	size = ARRAY_SIZE(thermal_zone_attribute_groups) + 1;
+	/* This also takes care of API requirement to be NULL terminated */
+	groups = kzalloc(size * sizeof(*groups), GFP_KERNEL);
+	if (!groups)
+		return -ENOMEM;
+
+	for (i = 0; i < size - 1; i++)
+		groups[i] = thermal_zone_attribute_groups[i];
+
+	tz->device.groups = groups;
+
+	return 0;
+}
+
 /* sys I/F for cooling device */
 #define to_cooling_device(_dev)	\
 	container_of(_dev, struct thermal_cooling_device, device)
@@ -1913,7 +1932,7 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
 	tz->polling_delay = polling_delay;
 
 	/* Add nodes that are always present via .groups */
-	tz->device.groups = thermal_zone_attribute_groups;
+	thermal_zone_create_device_groups(tz);
 	/* A new thermal zone needs to be updated anyway. */
 	atomic_set(&tz->need_update, 1);
 
@@ -2042,7 +2061,7 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 	idr_destroy(&tz->idr);
 	mutex_destroy(&tz->lock);
 	device_unregister(&tz->device);
-	return;
+	kfree(tz->device.groups);
 }
 EXPORT_SYMBOL_GPL(thermal_zone_device_unregister);
 
-- 
2.1.4
