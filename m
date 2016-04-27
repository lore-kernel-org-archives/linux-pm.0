From: Aaron Lu <aaron.lu@intel.com>
Subject: [PATCH v3 3/4] ACPI/video: export acpi_video_get_levels
Date: Wed, 27 Apr 2016 20:45:04 +0800
Message-ID: <1461761105-5961-4-git-send-email-aaron.lu@intel.com>
References: <1461761105-5961-1-git-send-email-aaron.lu@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1461761105-5961-1-git-send-email-aaron.lu@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Zhang Rui <rui.zhang@intel.com>, Jingoo Han <jingoohan1@gmail.com>
Cc: linux-fbdev@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@intel.com>
List-Id: linux-pm@vger.kernel.org

The acpi_video_get_levels is useful for other drivers, i.e. the
to-be-added int3406 thermal driver, so export it.

Signed-off-by: Aaron Lu <aaron.lu@intel.com>
---
 drivers/acpi/acpi_video.c | 83 +++++++++++++++++++++++++----------------------
 include/acpi/video.h      | 20 ++++++++++++
 2 files changed, 65 insertions(+), 38 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 4361bc98ef4c..3d5b8a099351 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -191,19 +191,6 @@ struct acpi_video_device_cap {
 	u8 _DDC:1;		/* Return the EDID for this device */
 };
 
-struct acpi_video_brightness_flags {
-	u8 _BCL_no_ac_battery_levels:1;	/* no AC/Battery levels in _BCL */
-	u8 _BCL_reversed:1;		/* _BCL package is in a reversed order */
-	u8 _BQC_use_index:1;		/* _BQC returns an index value */
-};
-
-struct acpi_video_device_brightness {
-	int curr;
-	int count;
-	int *levels;
-	struct acpi_video_brightness_flags flags;
-};
-
 struct acpi_video_device {
 	unsigned long device_id;
 	struct acpi_video_device_flags flags;
@@ -325,7 +312,7 @@ static const struct thermal_cooling_device_ops video_cooling_ops = {
  */
 
 static int
-acpi_video_device_lcd_query_levels(struct acpi_video_device *device,
+acpi_video_device_lcd_query_levels(acpi_handle handle,
 				   union acpi_object **levels)
 {
 	int status;
@@ -335,7 +322,7 @@ acpi_video_device_lcd_query_levels(struct acpi_video_device *device,
 
 	*levels = NULL;
 
-	status = acpi_evaluate_object(device->dev->handle, "_BCL", NULL, &buffer);
+	status = acpi_evaluate_object(handle, "_BCL", NULL, &buffer);
 	if (!ACPI_SUCCESS(status))
 		return status;
 	obj = (union acpi_object *)buffer.pointer;
@@ -766,36 +753,28 @@ static int acpi_video_bqc_quirk(struct acpi_video_device *device,
 	return 0;
 }
 
-
-/*
- *  Arg:
- *	device	: video output device (LCD, CRT, ..)
- *
- *  Return Value:
- *	Maximum brightness level
- *
- *  Allocate and initialize device->brightness.
- */
-
-static int
-acpi_video_init_brightness(struct acpi_video_device *device)
+int acpi_video_get_levels(struct acpi_device *device,
+			  struct acpi_video_device_brightness **dev_br)
 {
 	union acpi_object *obj = NULL;
 	int i, max_level = 0, count = 0, level_ac_battery = 0;
-	unsigned long long level, level_old;
 	union acpi_object *o;
 	struct acpi_video_device_brightness *br = NULL;
-	int result = -EINVAL;
+	int result = 0;
 	u32 value;
 
-	if (!ACPI_SUCCESS(acpi_video_device_lcd_query_levels(device, &obj))) {
+	if (!ACPI_SUCCESS(acpi_video_device_lcd_query_levels(device->handle,
+								&obj))) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Could not query available "
 						"LCD brightness level\n"));
+		result = -ENODEV;
 		goto out;
 	}
 
-	if (obj->package.count < 2)
+	if (obj->package.count < 2) {
+		result = -EINVAL;
 		goto out;
+	}
 
 	br = kzalloc(sizeof(*br), GFP_KERNEL);
 	if (!br) {
@@ -861,6 +840,38 @@ acpi_video_init_brightness(struct acpi_video_device *device)
 			    "Found unordered _BCL package"));
 
 	br->count = count;
+	*dev_br = br;
+
+out:
+	kfree(obj);
+	return result;
+out_free:
+	kfree(br);
+	goto out;
+}
+EXPORT_SYMBOL(acpi_video_get_levels);
+
+/*
+ *  Arg:
+ *	device	: video output device (LCD, CRT, ..)
+ *
+ *  Return Value:
+ *	Maximum brightness level
+ *
+ *  Allocate and initialize device->brightness.
+ */
+
+static int
+acpi_video_init_brightness(struct acpi_video_device *device)
+{
+	int i, max_level = 0;
+	unsigned long long level, level_old;
+	struct acpi_video_device_brightness *br = NULL;
+	int result = -EINVAL;
+
+	result = acpi_video_get_levels(device->dev, &br);
+	if (result)
+		return result;
 	device->brightness = br;
 
 	/* _BQC uses INDEX while _BCL uses VALUE in some laptops */
@@ -903,17 +914,13 @@ set_level:
 		goto out_free_levels;
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-			  "found %d brightness levels\n", count - 2));
-	kfree(obj);
-	return result;
+			  "found %d brightness levels\n", br->count - 2));
+	return 0;
 
 out_free_levels:
 	kfree(br->levels);
-out_free:
 	kfree(br);
-out:
 	device->brightness = NULL;
-	kfree(obj);
 	return result;
 }
 
diff --git a/include/acpi/video.h b/include/acpi/video.h
index 5ca2f2c16458..a4b96c971564 100644
--- a/include/acpi/video.h
+++ b/include/acpi/video.h
@@ -4,6 +4,19 @@
 #include <linux/errno.h> /* for ENODEV */
 #include <linux/types.h> /* for bool */
 
+struct acpi_video_brightness_flags {
+	u8 _BCL_no_ac_battery_levels:1;	/* no AC/Battery levels in _BCL */
+	u8 _BCL_reversed:1;		/* _BCL package is in a reversed order */
+	u8 _BQC_use_index:1;		/* _BQC returns an index value */
+};
+
+struct acpi_video_device_brightness {
+	int curr;
+	int count;
+	int *levels;
+	struct acpi_video_brightness_flags flags;
+};
+
 struct acpi_device;
 
 #define ACPI_VIDEO_CLASS	"video"
@@ -37,6 +50,8 @@ extern void acpi_video_set_dmi_backlight_type(enum acpi_backlight_type type);
  * may change over time and should not be cached.
  */
 extern bool acpi_video_handles_brightness_key_presses(void);
+extern int acpi_video_get_levels(struct acpi_device *device,
+				 struct acpi_video_device_brightness **dev_br);
 #else
 static inline int acpi_video_register(void) { return 0; }
 static inline void acpi_video_unregister(void) { return; }
@@ -56,6 +71,11 @@ static inline bool acpi_video_handles_brightness_key_presses(void)
 {
 	return false;
 }
+static int acpi_video_get_levels(struct acpi_device *device,
+			struct acpi_video_device_brightness **dev_br)
+{
+	return -ENODEV;
+}
 #endif
 
 #endif
-- 
2.5.5

