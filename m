From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: [PATCH v3 4/9] hwmon: (core) Add current attribute support to new API
Date: Sun, 24 Jul 2016 20:32:27 -0700
Message-ID: <1469417552-9749-5-git-send-email-linux@roeck-us.net>
References: <1469417552-9749-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1469417552-9749-1-git-send-email-linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>
Cc: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Punit Agrawal <punit.agrawal-5wv7dgnIgG8@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-hwmon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Acked-by: Punit Agrawal <punit.agrawal-5wv7dgnIgG8@public.gmane.org>
Reviewed-by: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
---
v3: No change
v2: No change

 drivers/hwmon/hwmon.c | 21 +++++++++++++++++++++
 include/linux/hwmon.h | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index 7697dfa92558..9229229a99a5 100644
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -260,6 +260,7 @@ static struct attribute *hwmon_genattr(struct device *dev,
 static const char * const hwmon_chip_attr_templates[] = {
 	[hwmon_chip_temp_reset_history] = "temp_reset_history",
 	[hwmon_chip_in_reset_history] = "in_reset_history",
+	[hwmon_chip_curr_reset_history] = "curr_reset_history",
 	[hwmon_chip_update_interval] = "update_interval",
 	[hwmon_chip_alarms] = "alarms",
 };
@@ -309,16 +310,36 @@ static const char * const hwmon_in_attr_templates[] = {
 	[hwmon_in_crit_alarm] = "in%d_crit_alarm",
 };
 
+static const char * const hwmon_curr_attr_templates[] = {
+	[hwmon_curr_input] = "curr%d_input",
+	[hwmon_curr_min] = "curr%d_min",
+	[hwmon_curr_max] = "curr%d_max",
+	[hwmon_curr_lcrit] = "curr%d_lcrit",
+	[hwmon_curr_crit] = "curr%d_crit",
+	[hwmon_curr_average] = "curr%d_average",
+	[hwmon_curr_lowest] = "curr%d_lowest",
+	[hwmon_curr_highest] = "curr%d_highest",
+	[hwmon_curr_reset_history] = "curr%d_reset_history",
+	[hwmon_curr_label] = "curr%d_label",
+	[hwmon_curr_alarm] = "curr%d_alarm",
+	[hwmon_curr_min_alarm] = "curr%d_min_alarm",
+	[hwmon_curr_max_alarm] = "curr%d_max_alarm",
+	[hwmon_curr_lcrit_alarm] = "curr%d_lcrit_alarm",
+	[hwmon_curr_crit_alarm] = "curr%d_crit_alarm",
+};
+
 static const char * const *__templates[] = {
 	[hwmon_chip] = hwmon_chip_attr_templates,
 	[hwmon_temp] = hwmon_temp_attr_templates,
 	[hwmon_in] = hwmon_in_attr_templates,
+	[hwmon_curr] = hwmon_curr_attr_templates,
 };
 
 static const int __templates_size[] = {
 	[hwmon_chip] = ARRAY_SIZE(hwmon_chip_attr_templates),
 	[hwmon_temp] = ARRAY_SIZE(hwmon_temp_attr_templates),
 	[hwmon_in] = ARRAY_SIZE(hwmon_in_attr_templates),
+	[hwmon_curr] = ARRAY_SIZE(hwmon_curr_attr_templates),
 };
 
 static int hwmon_num_channel_attrs(const struct hwmon_channel_info *info)
diff --git a/include/linux/hwmon.h b/include/linux/hwmon.h
index a01b8e3fc6f3..8781c2253b1d 100644
--- a/include/linux/hwmon.h
+++ b/include/linux/hwmon.h
@@ -31,6 +31,7 @@ enum hwmon_sensor_types {
 enum hwmon_chip_attributes {
 	hwmon_chip_temp_reset_history,
 	hwmon_chip_in_reset_history,
+	hwmon_chip_curr_reset_history,
 	hwmon_chip_register_tz,
 	hwmon_chip_update_interval,
 	hwmon_chip_alarms,
@@ -38,6 +39,7 @@ enum hwmon_chip_attributes {
 
 #define HWMON_C_TEMP_RESET_HISTORY	BIT(hwmon_chip_temp_reset_history)
 #define HWMON_C_IN_RESET_HISTORY	BIT(hwmon_chip_in_reset_history)
+#define HWMON_C_CURR_RESET_HISTORY	BIT(hwmon_chip_curr_reset_history)
 #define HWMON_C_REGISTER_TZ		BIT(hwmon_chip_register_tz)
 #define HWMON_C_UPDATE_INTERVAL		BIT(hwmon_chip_update_interval)
 #define HWMON_C_ALARMS			BIT(hwmon_chip_alarms)
@@ -126,6 +128,40 @@ enum hwmon_in_attributes {
 #define HWMON_I_LCRIT_ALARM	BIT(hwmon_in_lcrit_alarm)
 #define HWMON_I_CRIT_ALARM	BIT(hwmon_in_crit_alarm)
 
+enum hwmon_curr_attributes {
+	hwmon_curr_input,
+	hwmon_curr_min,
+	hwmon_curr_max,
+	hwmon_curr_lcrit,
+	hwmon_curr_crit,
+	hwmon_curr_average,
+	hwmon_curr_lowest,
+	hwmon_curr_highest,
+	hwmon_curr_reset_history,
+	hwmon_curr_label,
+	hwmon_curr_alarm,
+	hwmon_curr_min_alarm,
+	hwmon_curr_max_alarm,
+	hwmon_curr_lcrit_alarm,
+	hwmon_curr_crit_alarm,
+};
+
+#define HWMON_C_INPUT		BIT(hwmon_curr_input)
+#define HWMON_C_MIN		BIT(hwmon_curr_min)
+#define HWMON_C_MAX		BIT(hwmon_curr_max)
+#define HWMON_C_LCRIT		BIT(hwmon_curr_lcrit)
+#define HWMON_C_CRIT		BIT(hwmon_curr_crit)
+#define HWMON_C_AVERAGE		BIT(hwmon_curr_average)
+#define HWMON_C_LOWEST		BIT(hwmon_curr_lowest)
+#define HWMON_C_HIGHEST		BIT(hwmon_curr_highest)
+#define HWMON_C_RESET_HISTORY	BIT(hwmon_curr_reset_history)
+#define HWMON_C_LABEL		BIT(hwmon_curr_label)
+#define HWMON_C_ALARM		BIT(hwmon_curr_alarm)
+#define HWMON_C_MIN_ALARM	BIT(hwmon_curr_min_alarm)
+#define HWMON_C_MAX_ALARM	BIT(hwmon_curr_max_alarm)
+#define HWMON_C_LCRIT_ALARM	BIT(hwmon_curr_lcrit_alarm)
+#define HWMON_C_CRIT_ALARM	BIT(hwmon_curr_crit_alarm)
+
 /**
  * struct hwmon_ops - hwmon device operations
  * @is_visible: Callback to return attribute visibility. Mandatory.
-- 
2.5.0
