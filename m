From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: [PATCH 2/7] hwmon: (core) Add voltage attribute support to new API
Date: Sat, 25 Jun 2016 20:26:25 -0700
Message-ID: <1466911590-26296-3-git-send-email-linux@roeck-us.net>
References: <1466911590-26296-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1466911590-26296-1-git-send-email-linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>
Cc: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-hwmon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Signed-off-by: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
---
 drivers/hwmon/hwmon.c | 21 +++++++++++++++++++++
 include/linux/hwmon.h | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index 9530644ae297..d2916074befd 100644
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -250,6 +250,7 @@ static struct attribute *hwmon_genattr(struct device *dev,
 
 static const char * const hwmon_chip_attr_templates[] = {
 	[hwmon_chip_temp_reset_history] = "temp_reset_history",
+	[hwmon_chip_in_reset_history] = "in_reset_history",
 	[hwmon_chip_update_interval] = "update_interval",
 	[hwmon_chip_alarms] = "alarms",
 };
@@ -281,14 +282,34 @@ static const char * const hwmon_temp_attr_templates[] = {
 	[hwmon_temp_reset_history] = "temp%d_reset_history",
 };
 
+static const char * const hwmon_in_attr_templates[] = {
+	[hwmon_in_input] = "in%d_input",
+	[hwmon_in_min] = "in%d_min",
+	[hwmon_in_max] = "in%d_max",
+	[hwmon_in_lcrit] = "in%d_lcrit",
+	[hwmon_in_crit] = "in%d_crit",
+	[hwmon_in_average] = "in%d_average",
+	[hwmon_in_lowest] = "in%d_lowest",
+	[hwmon_in_highest] = "in%d_highest",
+	[hwmon_in_reset_history] = "in%d_reset_history",
+	[hwmon_in_label] = "in%d_label",
+	[hwmon_in_alarm] = "in%d_alarm",
+	[hwmon_in_min_alarm] = "in%d_min_alarm",
+	[hwmon_in_max_alarm] = "in%d_max_alarm",
+	[hwmon_in_lcrit_alarm] = "in%d_lcrit_alarm",
+	[hwmon_in_crit_alarm] = "in%d_crit_alarm",
+};
+
 static const char * const *__templates[] = {
 	[hwmon_chip] = hwmon_chip_attr_templates,
 	[hwmon_temp] = hwmon_temp_attr_templates,
+	[hwmon_in] = hwmon_in_attr_templates,
 };
 
 static const int __templates_size[] = {
 	[hwmon_chip] = ARRAY_SIZE(hwmon_chip_attr_templates),
 	[hwmon_temp] = ARRAY_SIZE(hwmon_temp_attr_templates),
+	[hwmon_in] = ARRAY_SIZE(hwmon_in_attr_templates),
 };
 
 static int hwmon_num_channel_attrs(const struct hwmon_channel_info *info)
diff --git a/include/linux/hwmon.h b/include/linux/hwmon.h
index 99250ad092fd..5e632c0fcbf4 100644
--- a/include/linux/hwmon.h
+++ b/include/linux/hwmon.h
@@ -30,6 +30,7 @@ enum hwmon_sensor_types {
 
 enum hwmon_chip_attributes {
 	hwmon_chip_temp_reset_history,
+	hwmon_chip_in_reset_history,
 	hwmon_chip_register_tz,
 	hwmon_chip_update_interval,
 	hwmon_chip_alarms,
@@ -91,6 +92,40 @@ enum hwmon_temp_attributes {
 #define HWMON_T_HIGHEST		BIT(hwmon_temp_highest)
 #define HWMON_T_RESET_HISTORY	BIT(hwmon_temp_reset_history)
 
+enum hwmon_in_attributes {
+	hwmon_in_input,
+	hwmon_in_min,
+	hwmon_in_max,
+	hwmon_in_lcrit,
+	hwmon_in_crit,
+	hwmon_in_average,
+	hwmon_in_lowest,
+	hwmon_in_highest,
+	hwmon_in_reset_history,
+	hwmon_in_label,
+	hwmon_in_alarm,
+	hwmon_in_min_alarm,
+	hwmon_in_max_alarm,
+	hwmon_in_lcrit_alarm,
+	hwmon_in_crit_alarm,
+};
+
+#define HWMON_I_INPUT		BIT(hwmon_in_input)
+#define HWMON_I_MIN		BIT(hwmon_in_min)
+#define HWMON_I_MAX		BIT(hwmon_in_max)
+#define HWMON_I_LCRIT		BIT(hwmon_in_lcrit)
+#define HWMON_I_CRIT		BIT(hwmon_in_crit)
+#define HWMON_I_AVERAGE		BIT(hwmon_in_average)
+#define HWMON_I_LOWEST		BIT(hwmon_in_lowest)
+#define HWMON_I_HIGHEST		BIT(hwmon_in_highest)
+#define HWMON_I_RESET_HISTORY	BIT(hwmon_in_reset_history)
+#define HWMON_I_LABEL		BIT(hwmon_in_label)
+#define HWMON_I_ALARM		BIT(hwmon_in_alarm)
+#define HWMON_I_MIN_ALARM	BIT(hwmon_in_min_alarm)
+#define HWMON_I_MAX_ALARM	BIT(hwmon_in_max_alarm)
+#define HWMON_I_LCRIT_ALARM	BIT(hwmon_in_lcrit_alarm)
+#define HWMON_I_CRIT_ALARM	BIT(hwmon_in_crit_alarm)
+
 /**
  * struct hwmon_ops - hwmon device operations
  * @is_visible: Callback to return attribute visibility.
-- 
2.5.0
