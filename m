From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: [PATCH v3 9/9] hwmon: (core) Add basic pwm attribute support to new API
Date: Sun, 24 Jul 2016 20:32:32 -0700
Message-ID: <1469417552-9749-10-git-send-email-linux@roeck-us.net>
References: <1469417552-9749-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1469417552-9749-1-git-send-email-linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>
Cc: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Punit Agrawal <punit.agrawal-5wv7dgnIgG8@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-hwmon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Add basic pwm attribute support (no auto attributes) to new API.

Reviewed-by: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
---
v2: No change
v2: Added patch

 Documentation/hwmon/hwmon-kernel-api.txt |  2 ++
 drivers/hwmon/hwmon.c                    |  9 +++++++++
 include/linux/hwmon.h                    | 13 +++++++++++++
 3 files changed, 24 insertions(+)

diff --git a/Documentation/hwmon/hwmon-kernel-api.txt b/Documentation/hwmon/hwmon-kernel-api.txt
index f60a29ce7592..ef9d74947f5c 100644
--- a/Documentation/hwmon/hwmon-kernel-api.txt
+++ b/Documentation/hwmon/hwmon-kernel-api.txt
@@ -168,6 +168,7 @@ It contains following fields:
   * hwmon_energy	Energy sensor
   * hwmon_humidity	Humidity sensor
   * hwmon_fan		Fan speed sensor
+  * hwmon_pwm		PWM control
 
 * config: Pointer to a 0-terminated list of configuration values for each
   sensor of the given type. Each value is a combination of bit values
@@ -230,6 +231,7 @@ HWMON_P_xxxx	Power attributes, for use with hwmon_power.
 HWMON_E_xxxx	Energy attributes, for use with hwmon_energy.
 HWMON_H_xxxx	Humidity attributes, for use with hwmon_humidity.
 HWMON_F_xxxx	Fan speed attributes, for use with hwmon_fan.
+HWMON_PWM_xxxx	PWM control attributes, for use with hwmon_pwm.
 
 Driver callback functions
 -------------------------
diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index 4729d4742ab7..fade170977e8 100644
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -386,6 +386,13 @@ static const char * const hwmon_fan_attr_templates[] = {
 	[hwmon_fan_fault] = "fan%d_fault",
 };
 
+static const char * const hwmon_pwm_attr_templates[] = {
+	[hwmon_pwm_input] = "pwm%d",
+	[hwmon_pwm_enable] = "pwm%d_enable",
+	[hwmon_pwm_mode] = "pwm%d_mode",
+	[hwmon_pwm_freq] = "pwm%d_freq",
+};
+
 static const char * const *__templates[] = {
 	[hwmon_chip] = hwmon_chip_attr_templates,
 	[hwmon_temp] = hwmon_temp_attr_templates,
@@ -395,6 +402,7 @@ static const char * const *__templates[] = {
 	[hwmon_energy] = hwmon_energy_attr_templates,
 	[hwmon_humidity] = hwmon_humidity_attr_templates,
 	[hwmon_fan] = hwmon_fan_attr_templates,
+	[hwmon_pwm] = hwmon_pwm_attr_templates,
 };
 
 static const int __templates_size[] = {
@@ -406,6 +414,7 @@ static const int __templates_size[] = {
 	[hwmon_energy] = ARRAY_SIZE(hwmon_energy_attr_templates),
 	[hwmon_humidity] = ARRAY_SIZE(hwmon_humidity_attr_templates),
 	[hwmon_fan] = ARRAY_SIZE(hwmon_fan_attr_templates),
+	[hwmon_pwm] = ARRAY_SIZE(hwmon_pwm_attr_templates),
 };
 
 static int hwmon_num_channel_attrs(const struct hwmon_channel_info *info)
diff --git a/include/linux/hwmon.h b/include/linux/hwmon.h
index 74e89d45ff67..9d2f8bde7d12 100644
--- a/include/linux/hwmon.h
+++ b/include/linux/hwmon.h
@@ -28,6 +28,7 @@ enum hwmon_sensor_types {
 	hwmon_energy,
 	hwmon_humidity,
 	hwmon_fan,
+	hwmon_pwm,
 };
 
 enum hwmon_chip_attributes {
@@ -272,6 +273,18 @@ enum hwmon_fan_attributes {
 #define HWMON_F_MAX_ALARM		BIT(hwmon_fan_max_alarm)
 #define HWMON_F_FAULT			BIT(hwmon_fan_fault)
 
+enum hwmon_pwm_attributes {
+	hwmon_pwm_input,
+	hwmon_pwm_enable,
+	hwmon_pwm_mode,
+	hwmon_pwm_freq,
+};
+
+#define HWMON_PWM_INPUT			BIT(hwmon_pwm_input)
+#define HWMON_PWM_ENABLE		BIT(hwmon_pwm_enable)
+#define HWMON_PWM_MODE			BIT(hwmon_pwm_mode)
+#define HWMON_PWM_FREQ			BIT(hwmon_pwm_freq)
+
 /**
  * struct hwmon_ops - hwmon device operations
  * @is_visible: Callback to return attribute visibility. Mandatory.
-- 
2.5.0
