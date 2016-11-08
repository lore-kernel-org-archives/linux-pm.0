From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCHv2 07/49] thermal: core: move passive attr to tz->device.groups
Date: Mon,  7 Nov 2016 21:08:45 -0800
Message-ID: <1478581767-7009-8-git-send-email-edubezval@gmail.com>
References: <1478581767-7009-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1478581767-7009-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

This patch moves the passive attribute to tz->device.groups. Moving the
passive attribute also requires a .is_visible() callback implementation
for its attribute group.

The logic behind the visibility of passive attribute is kept the same.
We only expose the passive attribute if the thermal driver has exposed
at least one passive trip point.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/thermal_core.c | 45 +++++++++++++++++++++++++++++++++---------
 1 file changed, 36 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index ec8551a..f3d9fe9 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1114,9 +1114,45 @@ static struct attribute_group thermal_zone_mode_attribute_group = {
 	.is_visible = thermal_zone_mode_is_visible,
 };
 
+/* We expose passive only if passive trips are present */
+static struct attribute *thermal_zone_passive_attrs[] = {
+	&dev_attr_passive.attr,
+	NULL,
+};
+
+static umode_t thermal_zone_passive_is_visible(struct kobject *kobj,
+					       struct attribute *attr,
+					       int attrno)
+{
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct thermal_zone_device *tz;
+	enum thermal_trip_type trip_type;
+	int count, passive = 0;
+
+	tz = container_of(dev, struct thermal_zone_device, device);
+
+	for (count = 0; count < tz->trips && !passive; count++) {
+		tz->ops->get_trip_type(tz, count, &trip_type);
+
+		if (trip_type == THERMAL_TRIP_PASSIVE)
+			passive = 1;
+	}
+
+	if (!passive)
+		return attr->mode;
+
+	return 0;
+}
+
+static struct attribute_group thermal_zone_passive_attribute_group = {
+	.attrs = thermal_zone_passive_attrs,
+	.is_visible = thermal_zone_passive_is_visible,
+};
+
 static const struct attribute_group *thermal_zone_attribute_groups[] = {
 	&thermal_zone_attribute_group,
 	&thermal_zone_mode_attribute_group,
+	&thermal_zone_passive_attribute_group,
 	NULL
 };
 
@@ -1906,7 +1942,6 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
 	int trip_temp;
 	int result;
 	int count;
-	int passive = 0;
 	struct thermal_governor *governor;
 
 	if (!type || strlen(type) == 0)
@@ -1967,8 +2002,6 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
 	for (count = 0; count < trips; count++) {
 		if (tz->ops->get_trip_type(tz, count, &trip_type))
 			set_bit(count, &tz->trips_disabled);
-		if (trip_type == THERMAL_TRIP_PASSIVE)
-			passive = 1;
 		if (tz->ops->get_trip_temp(tz, count, &trip_temp))
 			set_bit(count, &tz->trips_disabled);
 		/* Check for bogus trip points */
@@ -1976,12 +2009,6 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
 			set_bit(count, &tz->trips_disabled);
 	}
 
-	if (!passive) {
-		result = device_create_file(&tz->device, &dev_attr_passive);
-		if (result)
-			goto unregister;
-	}
-
 	/* Update 'this' zone's governor information */
 	mutex_lock(&thermal_governor_lock);
 
-- 
2.1.4
