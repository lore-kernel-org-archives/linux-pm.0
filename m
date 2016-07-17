From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 3/9] hwmon: (core) Add voltage attribute support to new API
Date: Sat, 16 Jul 2016 22:30:26 -0700
Message-ID: <1468733432-15730-4-git-send-email-linux@roeck-us.net>
References: <1468733432-15730-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-hwmon-owner@vger.kernel.org>
In-Reply-To: <1468733432-15730-1-git-send-email-linux@roeck-us.net>
Sender: linux-hwmon-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Punit Agrawal <punit.agrawal@arm.com>, linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-pm@vger.kernel.org

Acked-by: Punit Agrawal <punit.agrawal@arm.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: No change

 drivers/hwmon/hwmon.c | 21 +++++++++++++++++++++
 include/linux/hwmon.h | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index d780011cd063..5d88bf7f825a 100644
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -252,6 +252,7 @@ static struct attribute *hwmon_genattr(struct device *dev,
 
 static const char * const hwmon_chip_attr_templates[] = {
 	[hwmon_chip_temp_reset_history] = "temp_reset_history",
+	[hwmon_chip_in_reset_history] = "in_reset_history",
 	[hwmon_chip_update_interval] = "update_interval",
 	[hwmon_chip_alarms] = "alarms",
 };
@@ -283,14 +284,34 @@ static const char * const hwmon_temp_attr_templates[] = {
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
index 52e56d71d742..a01b8e3fc6f3 100644
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
  * @is_visible: Callback to return attribute visibility. Mandatory.
-- 
2.5.0

