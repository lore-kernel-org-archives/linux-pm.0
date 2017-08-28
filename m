From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH] Thermal: int3406_thermal: fix thermal sysfs I/F
Date: Mon, 28 Aug 2017 10:56:24 +0800
Message-ID: <1503888984-7961-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:21770 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751824AbdH1C43 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 27 Aug 2017 22:56:29 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: aaron.lu@intel.com, srinivas.pandruvada@linux.intel.com, rui.zhang@intel.com

there are three concepts represent backlight in int3406_thermal driver.
1. the raw brightness value from native graphics driver.
2. the percentage numbers from ACPI _BCL control method.
3. the consecutive numbers represent cooling states.

int3406_thermal driver
1. uses value from DDDL/DDPC as the lower/upper limit, which is consistent
   with ACPI _BCL control methods.
2. reads current and maximum brightness from the native graphics driver.
3. expose them to thermal sysfs I/F

This patch fixes the code that switches between the raw brightness value
and the cooling state, which results in bogus value in thermal sysfs I/F.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/int340x_thermal/int3406_thermal.c | 95 +++++++++--------------
 1 file changed, 37 insertions(+), 58 deletions(-)

diff --git a/drivers/thermal/int340x_thermal/int3406_thermal.c b/drivers/thermal/int340x_thermal/int3406_thermal.c
index 1891f34..e31509e 100644
--- a/drivers/thermal/int340x_thermal/int3406_thermal.c
+++ b/drivers/thermal/int340x_thermal/int3406_thermal.c
@@ -21,39 +21,33 @@
 
 struct int3406_thermal_data {
 	int upper_limit;
-	int upper_limit_index;
 	int lower_limit;
-	int lower_limit_index;
 	acpi_handle handle;
 	struct acpi_video_device_brightness *br;
 	struct backlight_device *raw_bd;
 	struct thermal_cooling_device *cooling_dev;
 };
 
-static int int3406_thermal_to_raw(int level, struct int3406_thermal_data *d)
-{
-	int max_level = d->br->levels[d->br->count - 1];
-	int raw_max = d->raw_bd->props.max_brightness;
-
-	return level * raw_max / max_level;
-}
-
-static int int3406_thermal_to_acpi(int level, struct int3406_thermal_data *d)
-{
-	int raw_max = d->raw_bd->props.max_brightness;
-	int max_level = d->br->levels[d->br->count - 1];
-
-	return level * max_level / raw_max;
-}
+/*
+ * According to the ACPI spec,
+ * "Each brightness level is represented by a number between 0 and 100,
+ * and can be thought of as a percentage. For example, 50 can be 50%
+ * power consumption or 50% brightness, as defined by the OEM."
+ *
+ * As int3406 device uses this value to communicate with the native
+ * graphics driver, we make the assumption that it represents
+ * the percentage of brightness only
+ */
+#define ACPI_TO_RAW(v, d) (d->raw_bd->props.max_brightness * v / 100)
+#define RAW_TO_ACPI(v, d) (v * 100 / d->raw_bd->props.max_brightness)
 
 static int
 int3406_thermal_get_max_state(struct thermal_cooling_device *cooling_dev,
 			      unsigned long *state)
 {
 	struct int3406_thermal_data *d = cooling_dev->devdata;
-	int index = d->lower_limit_index ? d->lower_limit_index : 2;
 
-	*state = d->br->count - 1 - index;
+	*state = d->upper_limit - d->lower_limit;
 	return 0;
 }
 
@@ -62,19 +56,15 @@ int3406_thermal_set_cur_state(struct thermal_cooling_device *cooling_dev,
 			      unsigned long state)
 {
 	struct int3406_thermal_data *d = cooling_dev->devdata;
-	int level, raw_level;
+	int acpi_level, raw_level;
 
-	if (state > d->br->count - 3)
+	if (state > d->upper_limit - d->lower_limit)
 		return -EINVAL;
 
-	state = d->br->count - 1 - state;
-	level = d->br->levels[state];
+	acpi_level = d->br->levels[d->upper_limit - state];
 
-	if ((d->upper_limit && level > d->upper_limit) ||
-	    (d->lower_limit && level < d->lower_limit))
-		return -EINVAL;
+	raw_level = ACPI_TO_RAW(acpi_level, d);
 
-	raw_level = int3406_thermal_to_raw(level, d);
 	return backlight_device_set_brightness(d->raw_bd, raw_level);
 }
 
@@ -83,27 +73,22 @@ int3406_thermal_get_cur_state(struct thermal_cooling_device *cooling_dev,
 			      unsigned long *state)
 {
 	struct int3406_thermal_data *d = cooling_dev->devdata;
-	int raw_level, level, i;
-	int *levels = d->br->levels;
+	int acpi_level;
+	int index;
 
-	raw_level = d->raw_bd->props.brightness;
-	level = int3406_thermal_to_acpi(raw_level, d);
+	acpi_level = RAW_TO_ACPI(d->raw_bd->props.brightness, d);
 
 	/*
-	 * There is no 1:1 mapping between the firmware interface level with the
-	 * raw interface level, we will have to find one that is close enough.
+	 * There is no 1:1 mapping between the firmware interface level
+	 * with the raw interface level, we will have to find one that is
+	 * right above it.
 	 */
-	for (i = 2; i < d->br->count; i++) {
-		if (level < levels[i]) {
-			if (i == 2)
-				break;
-			if ((level - levels[i - 1]) < (levels[i] - level))
-				i--;
+	for (index = d->lower_limit; index < d->upper_limit; index++) {
+		if (acpi_level <= d->br->levels[index])
 			break;
-		}
 	}
 
-	*state = d->br->count - 1 - i;
+	*state = d->upper_limit - index;
 	return 0;
 }
 
@@ -117,7 +102,7 @@ static int int3406_thermal_get_index(int *array, int nr, int value)
 {
 	int i;
 
-	for (i = 0; i < nr; i++) {
+	for (i = 2; i < nr; i++) {
 		if (array[i] == value)
 			break;
 	}
@@ -131,24 +116,18 @@ static void int3406_thermal_get_limit(struct int3406_thermal_data *d)
 	int index;
 
 	status = acpi_evaluate_integer(d->handle, "DDDL", NULL, &lower_limit);
-	if (ACPI_SUCCESS(status)) {
-		index = int3406_thermal_get_index(d->br->levels, d->br->count,
-						  lower_limit);
-		if (index > 0) {
-			d->lower_limit = (int)lower_limit;
-			d->lower_limit_index = index;
-		}
-	}
+	if (ACPI_SUCCESS(status))
+		d->lower_limit = int3406_thermal_get_index(d->br->levels,
+					d->br->count, lower_limit);
 
 	status = acpi_evaluate_integer(d->handle, "DDPC", NULL, &upper_limit);
-	if (ACPI_SUCCESS(status)) {
-		index = int3406_thermal_get_index(d->br->levels, d->br->count,
-						  upper_limit);
-		if (index > 0) {
-			d->upper_limit = (int)upper_limit;
-			d->upper_limit_index = index;
-		}
-	}
+	if (ACPI_SUCCESS(status))
+		d->upper_limit = int3406_thermal_get_index(d->br->levels,
+					d->br->count, upper_limit);
+
+	/* lower_limit and upper_limit should be always set */
+	d->lower_limit = d->lower_limit > 0 ? d->lower_limit : 2;
+	d->upper_limit = d->upper_limit > 0 ? d->upper_limit : d->br->count - 1;
 }
 
 static void int3406_notify(acpi_handle handle, u32 event, void *data)
-- 
2.7.4
