From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 5/7] hwmon: (core) Add energy and humidity attribute support to new API
Date: Sat, 25 Jun 2016 20:26:28 -0700
Message-ID: <1466911590-26296-6-git-send-email-linux@roeck-us.net>
References: <1466911590-26296-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:38986 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751735AbcFZD0u (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 25 Jun 2016 23:26:50 -0400
In-Reply-To: <1466911590-26296-1-git-send-email-linux@roeck-us.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jean Delvare <jdelvare@suse.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/hwmon.c | 20 ++++++++++++++++++++
 include/linux/hwmon.h | 29 +++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index dff07e8f9509..363ec5660d0c 100644
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -347,12 +347,30 @@ static const char * const hwmon_power_attr_templates[] = {
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
@@ -361,6 +379,8 @@ static const int __templates_size[] = {
 	[hwmon_in] = ARRAY_SIZE(hwmon_in_attr_templates),
 	[hwmon_curr] = ARRAY_SIZE(hwmon_curr_attr_templates),
 	[hwmon_power] = ARRAY_SIZE(hwmon_power_attr_templates),
+	[hwmon_energy] = ARRAY_SIZE(hwmon_energy_attr_templates),
+	[hwmon_humidity] = ARRAY_SIZE(hwmon_humidity_attr_templates),
 };
 
 static int hwmon_num_channel_attrs(const struct hwmon_channel_info *info)
diff --git a/include/linux/hwmon.h b/include/linux/hwmon.h
index 4de6e2af29ea..a0b82027ae07 100644
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
  * @is_visible: Callback to return attribute visibility.
-- 
2.5.0

