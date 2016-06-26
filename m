From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 3/7] hwmon: (core) Add current attribute support to new API
Date: Sat, 25 Jun 2016 20:26:26 -0700
Message-ID: <1466911590-26296-4-git-send-email-linux@roeck-us.net>
References: <1466911590-26296-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466911590-26296-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-pm@vger.kernel.org

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/hwmon.c | 21 +++++++++++++++++++++
 include/linux/hwmon.h | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index d2916074befd..8c3c7ffe828b 100644
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -251,6 +251,7 @@ static struct attribute *hwmon_genattr(struct device *dev,
 static const char * const hwmon_chip_attr_templates[] = {
 	[hwmon_chip_temp_reset_history] = "temp_reset_history",
 	[hwmon_chip_in_reset_history] = "in_reset_history",
+	[hwmon_chip_curr_reset_history] = "curr_reset_history",
 	[hwmon_chip_update_interval] = "update_interval",
 	[hwmon_chip_alarms] = "alarms",
 };
@@ -300,16 +301,36 @@ static const char * const hwmon_in_attr_templates[] = {
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
index 5e632c0fcbf4..bac3c5dc672f 100644
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
  * @is_visible: Callback to return attribute visibility.
-- 
2.5.0
