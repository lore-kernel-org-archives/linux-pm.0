From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4/7] hwmon: (core) Add power attribute support to new API
Date: Sat, 25 Jun 2016 20:26:27 -0700
Message-ID: <1466911590-26296-5-git-send-email-linux@roeck-us.net>
References: <1466911590-26296-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466911590-26296-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-pm@vger.kernel.org

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/hwmon.c | 30 ++++++++++++++++++++++++++++
 include/linux/hwmon.h | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+)

diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index 8c3c7ffe828b..dff07e8f9509 100644
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -252,6 +252,7 @@ static const char * const hwmon_chip_attr_templates[] = {
 	[hwmon_chip_temp_reset_history] = "temp_reset_history",
 	[hwmon_chip_in_reset_history] = "in_reset_history",
 	[hwmon_chip_curr_reset_history] = "curr_reset_history",
+	[hwmon_chip_power_reset_history] = "power_reset_history",
 	[hwmon_chip_update_interval] = "update_interval",
 	[hwmon_chip_alarms] = "alarms",
 };
@@ -319,11 +320,39 @@ static const char * const hwmon_curr_attr_templates[] = {
 	[hwmon_curr_crit_alarm] = "curr%d_crit_alarm",
 };
 
+static const char * const hwmon_power_attr_templates[] = {
+	[hwmon_power_average] = "power%d_average",
+	[hwmon_power_average_interval] = "power%d_average_interval",
+	[hwmon_power_average_interval_max] = "power%d_interval_max",
+	[hwmon_power_average_interval_min] = "power%d_interval_min",
+	[hwmon_power_average_highest] = "power%d_average_highest",
+	[hwmon_power_average_lowest] = "power%d_average_lowest",
+	[hwmon_power_average_max] = "power%d_average_max",
+	[hwmon_power_average_min] = "power%d_average_min",
+	[hwmon_power_input] = "power%d_input",
+	[hwmon_power_input_highest] = "power%d_input_highest",
+	[hwmon_power_input_lowest] = "power%d_input_lowest",
+	[hwmon_power_reset_history] = "power%d_reset_history",
+	[hwmon_power_accuracy] = "power%d_accuracy",
+	[hwmon_power_cap] = "power%d_cap",
+	[hwmon_power_cap_hyst] = "power%d_cap_hyst",
+	[hwmon_power_cap_max] = "power%d_cap_max",
+	[hwmon_power_cap_min] = "power%d_cap_min",
+	[hwmon_power_max] = "power%d_max",
+	[hwmon_power_crit] = "power%d_crit",
+	[hwmon_power_label] = "power%d_label",
+	[hwmon_power_alarm] = "power%d_alarm",
+	[hwmon_power_cap_alarm] = "power%d_cap_alarm",
+	[hwmon_power_max_alarm] = "power%d_max_alarm",
+	[hwmon_power_crit_alarm] = "power%d_crit_alarm",
+};
+
 static const char * const *__templates[] = {
 	[hwmon_chip] = hwmon_chip_attr_templates,
 	[hwmon_temp] = hwmon_temp_attr_templates,
 	[hwmon_in] = hwmon_in_attr_templates,
 	[hwmon_curr] = hwmon_curr_attr_templates,
+	[hwmon_power] = hwmon_power_attr_templates,
 };
 
 static const int __templates_size[] = {
@@ -331,6 +360,7 @@ static const int __templates_size[] = {
 	[hwmon_temp] = ARRAY_SIZE(hwmon_temp_attr_templates),
 	[hwmon_in] = ARRAY_SIZE(hwmon_in_attr_templates),
 	[hwmon_curr] = ARRAY_SIZE(hwmon_curr_attr_templates),
+	[hwmon_power] = ARRAY_SIZE(hwmon_power_attr_templates),
 };
 
 static int hwmon_num_channel_attrs(const struct hwmon_channel_info *info)
diff --git a/include/linux/hwmon.h b/include/linux/hwmon.h
index bac3c5dc672f..4de6e2af29ea 100644
--- a/include/linux/hwmon.h
+++ b/include/linux/hwmon.h
@@ -32,6 +32,7 @@ enum hwmon_chip_attributes {
 	hwmon_chip_temp_reset_history,
 	hwmon_chip_in_reset_history,
 	hwmon_chip_curr_reset_history,
+	hwmon_chip_power_reset_history,
 	hwmon_chip_register_tz,
 	hwmon_chip_update_interval,
 	hwmon_chip_alarms,
@@ -40,6 +41,7 @@ enum hwmon_chip_attributes {
 #define HWMON_C_TEMP_RESET_HISTORY	BIT(hwmon_chip_temp_reset_history)
 #define HWMON_C_IN_RESET_HISTORY	BIT(hwmon_chip_in_reset_history)
 #define HWMON_C_CURR_RESET_HISTORY	BIT(hwmon_chip_curr_reset_history)
+#define HWMON_C_POWER_RESET_HISTORY	BIT(hwmon_chip_power_reset_history)
 #define HWMON_C_REGISTER_TZ		BIT(hwmon_chip_register_tz)
 #define HWMON_C_UPDATE_INTERVAL		BIT(hwmon_chip_update_interval)
 #define HWMON_C_ALARMS			BIT(hwmon_chip_alarms)
@@ -162,6 +164,58 @@ enum hwmon_curr_attributes {
 #define HWMON_C_LCRIT_ALARM	BIT(hwmon_curr_lcrit_alarm)
 #define HWMON_C_CRIT_ALARM	BIT(hwmon_curr_crit_alarm)
 
+enum hwmon_power_attributes {
+	hwmon_power_average,
+	hwmon_power_average_interval,
+	hwmon_power_average_interval_max,
+	hwmon_power_average_interval_min,
+	hwmon_power_average_highest,
+	hwmon_power_average_lowest,
+	hwmon_power_average_max,
+	hwmon_power_average_min,
+	hwmon_power_input,
+	hwmon_power_input_highest,
+	hwmon_power_input_lowest,
+	hwmon_power_reset_history,
+	hwmon_power_accuracy,
+	hwmon_power_cap,
+	hwmon_power_cap_hyst,
+	hwmon_power_cap_max,
+	hwmon_power_cap_min,
+	hwmon_power_max,
+	hwmon_power_crit,
+	hwmon_power_label,
+	hwmon_power_alarm,
+	hwmon_power_cap_alarm,
+	hwmon_power_max_alarm,
+	hwmon_power_crit_alarm,
+};
+
+#define HWMON_P_AVERAGE			BIT(hwmon_power_average)
+#define HWMON_P_AVERAGE_INTERVAL	BIT(hwmon_power_average_interval)
+#define HWMON_P_AVERAGE_INTERVAL_MAX	BIT(hwmon_power_average_interval_max)
+#define HWMON_P_AVERAGE_INTERVAL_MIN	BIT(hwmon_power_average_interval_min)
+#define HWMON_P_AVERAGE_HIGHEST		BIT(hwmon_power_average_highest)
+#define HWMON_P_AVERAGE_LOWEST		BIT(hwmon_power_average_lowest)
+#define HWMON_P_AVERAGE_MAX		BIT(hwmon_power_average_max)
+#define HWMON_P_AVERAGE_MIN		BIT(hwmon_power_average_min)
+#define HWMON_P_INPUT			BIT(hwmon_power_input)
+#define HWMON_P_INPUT_HIGHEST		BIT(hwmon_power_input_highest)
+#define HWMON_P_INPUT_LOWEST		BIT(hwmon_power_input_lowest)
+#define HWMON_P_RESET_HISTORY		BIT(hwmon_power_reset_history)
+#define HWMON_P_ACCURACY		BIT(hwmon_power_accuracy)
+#define HWMON_P_CAP			BIT(hwmon_power_cap)
+#define HWMON_P_CAP_HYST		BIT(hwmon_power_cap_hyst)
+#define HWMON_P_CAP_MAX			BIT(hwmon_power_cap_max)
+#define HWMON_P_CAP_MIN			BIT(hwmon_power_cap_min)
+#define HWMON_P_MAX			BIT(hwmon_power_max)
+#define HWMON_P_CRIT			BIT(hwmon_power_crit)
+#define HWMON_P_LABEL			BIT(hwmon_power_label)
+#define HWMON_P_ALARM			BIT(hwmon_power_alarm)
+#define HWMON_P_CAP_ALARM		BIT(hwmon_power_cap_alarm)
+#define HWMON_P_MAX_ALARM		BIT(hwmon_power_max_alarm)
+#define HWMON_P_CRIT_ALARM		BIT(hwmon_power_crit_alarm)
+
 /**
  * struct hwmon_ops - hwmon device operations
  * @is_visible: Callback to return attribute visibility.
-- 
2.5.0
