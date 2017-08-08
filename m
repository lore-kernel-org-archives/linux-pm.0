From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 1/3 v2] thermal: core: Add some new helper functions to free resources
Date: Tue,  8 Aug 2017 16:39:52 +0200
Message-ID: <98e96edd53ea3109ec127f82608c8d5df5437c9c.1502201798.git.christophe.jaillet@wanadoo.fr>
References: <cover.1502201798.git.christophe.jaillet@wanadoo.fr>
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <cover.1502201798.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <cover.1502201798.git.christophe.jaillet@wanadoo.fr>
References: <cover.1502201798.git.christophe.jaillet@wanadoo.fr>
Sender: kernel-janitors-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>
List-Id: linux-pm@vger.kernel.org

In order to easily free resources allocated by
'thermal_zone_create_device_groups()' we need 2 new helper functions.

The first one undoes 'thermal_zone_create_device_groups()'.
The 2nd one undoes 'create_trip_attrs()', which is a function called by
'thermal_zone_create_device_groups()'.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
These functions will be used in patch 2/3 in order to simplify
'thermal_release()'
I've tried to implement it as close a possible as the way the resources have
been allocated.
However, in 'thermal_release()', the code is simplier without some
additionnal 'if'.
No sure if we should prefer consistancy with allocation or simplicity of code.
---
 drivers/thermal/thermal_core.h  |  1 +
 drivers/thermal/thermal_sysfs.c | 29 +++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 2412b3759e16..27e3b1df7360 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -71,6 +71,7 @@ int thermal_build_list_of_policies(char *buf);
 
 /* sysfs I/F */
 int thermal_zone_create_device_groups(struct thermal_zone_device *, int);
+void thermal_zone_destroy_device_groups(struct thermal_zone_device *);
 void thermal_cooling_device_setup_sysfs(struct thermal_cooling_device *);
 /* used only at binding time */
 ssize_t
diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index a694de907a26..eb95d64b9446 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -605,6 +605,24 @@ static int create_trip_attrs(struct thermal_zone_device *tz, int mask)
 	return 0;
 }
 
+/**
+ * destroy_trip_attrs() - create attributes for trip points
+ * @tz:		the thermal zone device
+ *
+ * helper function to free resources alocated by create_trip_attrs()
+ */
+static void destroy_trip_attrs(struct thermal_zone_device *tz)
+{
+	if (!tz)
+		return;
+
+	kfree(tz->trip_type_attrs);
+	kfree(tz->trip_temp_attrs);
+	if (tz->ops->get_trip_hyst)
+		kfree(tz->trip_hyst_attrs);
+	kfree(tz->trips_attribute_group.attrs);
+}
+
 int thermal_zone_create_device_groups(struct thermal_zone_device *tz,
 				      int mask)
 {
@@ -637,6 +655,17 @@ int thermal_zone_create_device_groups(struct thermal_zone_device *tz,
 	return 0;
 }
 
+void thermal_zone_destroy_device_groups(struct thermal_zone_device *tz)
+{
+	if (!tz)
+		return;
+
+	if (tz->trips)
+		destroy_trip_attrs(tz);
+
+	kfree(tz->device.groups);
+}
+
 /* sys I/F for cooling device */
 static ssize_t
 thermal_cooling_device_type_show(struct device *dev,
-- 
2.11.0

