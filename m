From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 6/9] hwmon: (core) Add energy and humidity attribute support to new API
Date: Sat, 16 Jul 2016 22:30:29 -0700
Message-ID: <1468733432-15730-7-git-send-email-linux@roeck-us.net>
References: <1468733432-15730-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1468733432-15730-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Punit Agrawal <punit.agrawal@arm.com>, linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-pm@vger.kernel.org

Acked-by: Punit Agrawal <punit.agrawal@arm.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: No change

 drivers/hwmon/hwmon.c | 20 ++++++++++++++++++++
 include/linux/hwmon.h | 29 +++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index 7a5c8bba7dc2..f5de80a8bd1e 100644
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -349,12 +349,30 @@ static const char * const hwmon_power_attr_templates[] = {
 	[hwmon_power_crit_alarm] = "power%d_crit_alarm",
 };
 
+static const char * const hwmon_energy_attr_templates[] = {
+	[hwmon_energy_input] = "energy%d_input",
+	[hwmon_energy_label] = "energy%d_label",
+};
+
+static const char * const hwmon_humidity_attr_templates[] = {
+	[hwmon_humidity_input] = "humidity%d_input",
+	[hwmon_humidity_label] = "humidity%d_label",
+	[hwmon_humidity_min] = "humidity%d_min",
+	[hwmon_humidity_min_hyst] = "humidity%d_min_hyst",
+	[hwmon_humidity_max] = "humidity%d_max",
+	[hwmon_humidity_max_hyst] = "humidity%d_max_hyst",
+	[hwmon_humidity_alarm] = "humidity%d_alarm",
+	[hwmon_humidity_fault] = "humidity%d_fault",
+};
+
 static const char * const *__templates[] = {
 	[hwmon_chip] = hwmon_chip_attr_templates,
 	[hwmon_temp] = hwmon_temp_attr_templates,
 	[hwmon_in] = hwmon_in_attr_templates,
 	[hwmon_curr] = hwmon_curr_attr_templates,
 	[hwmon_power] = hwmon_power_attr_templates,
+	[hwmon_energy] = hwmon_energy_attr_templates,
+	[hwmon_humidity] = hwmon_humidity_attr_templates,
 };
 
 static const int __templates_size[] = {
@@ -363,6 +381,8 @@ static const int __templates_size[] = {
 	[hwmon_in] = ARRAY_SIZE(hwmon_in_attr_templates),
 	[hwmon_curr] = ARRAY_SIZE(hwmon_curr_attr_templates),
 	[hwmon_power] = ARRAY_SIZE(hwmon_power_attr_templates),
+	[hwmon_energy] = ARRAY_SIZE(hwmon_energy_attr_templates),
+	[hwmon_humidity] = ARRAY_SIZE(hwmon_humidity_attr_templates),
 };
 
 static int hwmon_num_channel_attrs(const struct hwmon_channel_info *info)
diff --git a/include/linux/hwmon.h b/include/linux/hwmon.h
index d7e432ef7c2a..57d92f1d779b 100644
--- a/include/linux/hwmon.h
+++ b/include/linux/hwmon.h
@@ -26,6 +26,7 @@ enum hwmon_sensor_types {
 	hwmon_curr,
 	hwmon_power,
 	hwmon_energy,
+	hwmon_humidity,
 };
 
 enum hwmon_chip_attributes {
@@ -216,6 +217,34 @@ enum hwmon_power_attributes {
 #define HWMON_P_MAX_ALARM		BIT(hwmon_power_max_alarm)
 #define HWMON_P_CRIT_ALARM		BIT(hwmon_power_crit_alarm)
 
+enum hwmon_energy_attributes {
+	hwmon_energy_input,
+	hwmon_energy_label,
+};
+
+#define HWMON_E_INPUT			BIT(hwmon_energy_input)
+#define HWMON_E_LABEL			BIT(hwmon_energy_label)
+
+enum hwmon_humidity_attributes {
+	hwmon_humidity_input,
+	hwmon_humidity_label,
+	hwmon_humidity_min,
+	hwmon_humidity_min_hyst,
+	hwmon_humidity_max,
+	hwmon_humidity_max_hyst,
+	hwmon_humidity_alarm,
+	hwmon_humidity_fault,
+};
+
+#define HWMON_H_INPUT			BIT(hwmon_humidity_input)
+#define HWMON_H_LABEL			BIT(hwmon_humidity_label)
+#define HWMON_H_MIN			BIT(hwmon_humidity_min)
+#define HWMON_H_MIN_HYST		BIT(hwmon_humidity_min_hyst)
+#define HWMON_H_MAX			BIT(hwmon_humidity_max)
+#define HWMON_H_MAX_HYST		BIT(hwmon_humidity_max_hyst)
+#define HWMON_H_ALARM			BIT(hwmon_humidity_alarm)
+#define HWMON_H_FAULT			BIT(hwmon_humidity_fault)
+
 /**
  * struct hwmon_ops - hwmon device operations
  * @is_visible: Callback to return attribute visibility. Mandatory.
-- 
2.5.0
