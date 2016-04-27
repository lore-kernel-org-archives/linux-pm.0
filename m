From: Aaron Lu <aaron.lu@intel.com>
Subject: [PATCH v3 4/4] Thermal: add INT3406 thermal driver
Date: Wed, 27 Apr 2016 20:45:05 +0800
Message-ID: <1461761105-5961-5-git-send-email-aaron.lu@intel.com>
References: <1461761105-5961-1-git-send-email-aaron.lu@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:60594 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752647AbcD0Mpk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 27 Apr 2016 08:45:40 -0400
In-Reply-To: <1461761105-5961-1-git-send-email-aaron.lu@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Zhang Rui <rui.zhang@intel.com>, Jingoo Han <jingoohan1@gmail.com>
Cc: linux-fbdev@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@intel.com>

INT3406 ACPI device object resembles an ACPI video output device, but its
_BCM is said to be deprecated and should not be used. So we will make
use of the raw interface to do the actual cooling.

Signed-off-by: Aaron Lu <aaron.lu@intel.com>
---
 drivers/thermal/Kconfig                           |  28 +--
 drivers/thermal/int340x_thermal/Kconfig           |  42 ++++
 drivers/thermal/int340x_thermal/Makefile          |   1 +
 drivers/thermal/int340x_thermal/int3406_thermal.c | 236 ++++++++++++++++++++++
 4 files changed, 282 insertions(+), 25 deletions(-)
 create mode 100644 drivers/thermal/int340x_thermal/Kconfig
 create mode 100644 drivers/thermal/int340x_thermal/int3406_thermal.c

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index c37eedc35a24..cb1ba70ceaa7 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -338,31 +338,9 @@ config INTEL_QUARK_DTS_THERMAL
 	  hot & critical. The critical trip point default value is set by
 	  underlying BIOS/Firmware.
 
-config INT340X_THERMAL
-	tristate "ACPI INT340X thermal drivers"
-	depends on X86 && ACPI
-	select THERMAL_GOV_USER_SPACE
-	select ACPI_THERMAL_REL
-	select ACPI_FAN
-	select INTEL_SOC_DTS_IOSF_CORE
-	select THERMAL_WRITABLE_TRIPS
-	help
-	  Newer laptops and tablets that use ACPI may have thermal sensors and
-	  other devices with thermal control capabilities outside the core
-	  CPU/SOC, for thermal safety reasons.
-	  They are exposed for the OS to use via the INT3400 ACPI device object
-	  as the master, and INT3401~INT340B ACPI device objects as the slaves.
-	  Enable this to expose the temperature information and cooling ability
-	  from these objects to userspace via the normal thermal framework.
-	  This means that a wide range of applications and GUI widgets can show
-	  the information to the user or use this information for making
-	  decisions. For example, the Intel Thermal Daemon can use this
-	  information to allow the user to select his laptop to run without
-	  turning on the fans.
-
-config ACPI_THERMAL_REL
-	tristate
-	depends on ACPI
+menu "ACPI INT340X thermal drivers"
+source drivers/thermal/int340x_thermal/Kconfig
+endmenu
 
 config INTEL_PCH_THERMAL
 	tristate "Intel PCH Thermal Reporting Driver"
diff --git a/drivers/thermal/int340x_thermal/Kconfig b/drivers/thermal/int340x_thermal/Kconfig
new file mode 100644
index 000000000000..0582bd12a239
--- /dev/null
+++ b/drivers/thermal/int340x_thermal/Kconfig
@@ -0,0 +1,42 @@
+#
+# ACPI INT340x thermal drivers configuration
+#
+
+config INT340X_THERMAL
+	tristate "ACPI INT340X thermal drivers"
+	depends on X86 && ACPI
+	select THERMAL_GOV_USER_SPACE
+	select ACPI_THERMAL_REL
+	select ACPI_FAN
+	select INTEL_SOC_DTS_IOSF_CORE
+	help
+	  Newer laptops and tablets that use ACPI may have thermal sensors and
+	  other devices with thermal control capabilities outside the core
+	  CPU/SOC, for thermal safety reasons.
+	  They are exposed for the OS to use via the INT3400 ACPI device object
+	  as the master, and INT3401~INT340B ACPI device objects as the slaves.
+	  Enable this to expose the temperature information and cooling ability
+	  from these objects to userspace via the normal thermal framework.
+	  This means that a wide range of applications and GUI widgets can show
+	  the information to the user or use this information for making
+	  decisions. For example, the Intel Thermal Daemon can use this
+	  information to allow the user to select his laptop to run without
+	  turning on the fans.
+
+config ACPI_THERMAL_REL
+	tristate
+	depends on ACPI
+
+if INT340X_THERMAL
+
+config INT3406_THERMAL
+	tristate "ACPI INT3406 display thermal driver"
+	depends on ACPI_VIDEO
+	help
+	  The display thermal device represents the LED/LCD display panel
+	  that may or may not include touch support. The main function of
+	  the display thermal device is to allow control of the display
+	  brightness in order to address a thermal condition or to reduce
+	  power consumed by display device.
+
+endif
diff --git a/drivers/thermal/int340x_thermal/Makefile b/drivers/thermal/int340x_thermal/Makefile
index ba77a34f659f..df0df055e7ff 100644
--- a/drivers/thermal/int340x_thermal/Makefile
+++ b/drivers/thermal/int340x_thermal/Makefile
@@ -3,4 +3,5 @@ obj-$(CONFIG_INT340X_THERMAL)	+= int340x_thermal_zone.o
 obj-$(CONFIG_INT340X_THERMAL)	+= int3402_thermal.o
 obj-$(CONFIG_INT340X_THERMAL)	+= int3403_thermal.o
 obj-$(CONFIG_INT340X_THERMAL)	+= processor_thermal_device.o
+obj-$(CONFIG_INT3406_THERMAL)	+= int3406_thermal.o
 obj-$(CONFIG_ACPI_THERMAL_REL)	+= acpi_thermal_rel.o
diff --git a/drivers/thermal/int340x_thermal/int3406_thermal.c b/drivers/thermal/int340x_thermal/int3406_thermal.c
new file mode 100644
index 000000000000..1c9b7590f098
--- /dev/null
+++ b/drivers/thermal/int340x_thermal/int3406_thermal.c
@@ -0,0 +1,236 @@
+/*
+ * INT3406 thermal driver for display participant device
+ *
+ * Copyright (C) 2014, Intel Corporation
+ * Authors: Aaron Lu <aaron.lu@intel.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/acpi.h>
+#include <linux/backlight.h>
+#include <linux/thermal.h>
+#include <acpi/video.h>
+
+#define INT3406_BRIGHTNESS_LIMITS_CHANGED	0x80
+
+struct int3406_thermal_data {
+	int upper_limit;
+	int upper_limit_index;
+	int lower_limit;
+	int lower_limit_index;
+	acpi_handle handle;
+	struct acpi_video_device_brightness *br;
+	struct backlight_device *raw_bd;
+	struct thermal_cooling_device *cooling_dev;
+};
+
+static int int3406_thermal_to_raw(int level, struct int3406_thermal_data *d)
+{
+	int max_level = d->br->levels[d->br->count - 1];
+	int raw_max = d->raw_bd->props.max_brightness;
+
+	return level * raw_max / max_level;
+}
+
+static int int3406_thermal_to_acpi(int level, struct int3406_thermal_data *d)
+{
+	int raw_max = d->raw_bd->props.max_brightness;
+	int max_level = d->br->levels[d->br->count - 1];
+
+	return level * max_level / raw_max;
+}
+
+static int
+int3406_thermal_get_max_state(struct thermal_cooling_device *cooling_dev,
+			      unsigned long *state)
+{
+	struct int3406_thermal_data *d = cooling_dev->devdata;
+	int index = d->lower_limit_index ? d->lower_limit_index : 2;
+
+	*state = d->br->count - 1 - index;
+	return 0;
+}
+
+static int
+int3406_thermal_set_cur_state(struct thermal_cooling_device *cooling_dev,
+			      unsigned long state)
+{
+	struct int3406_thermal_data *d = cooling_dev->devdata;
+	int level, raw_level;
+
+	if (state > d->br->count - 3)
+		return -EINVAL;
+
+	state = d->br->count - 1 - state;
+	level = d->br->levels[state];
+
+	if ((d->upper_limit && level > d->upper_limit) ||
+	    (d->lower_limit && level < d->lower_limit))
+		return -EINVAL;
+
+	raw_level = int3406_thermal_to_raw(level, d);
+	return backlight_device_set_brightness(d->raw_bd, raw_level);
+}
+
+static int
+int3406_thermal_get_cur_state(struct thermal_cooling_device *cooling_dev,
+			      unsigned long *state)
+{
+	struct int3406_thermal_data *d = cooling_dev->devdata;
+	int raw_level, level, i;
+	int *levels = d->br->levels;
+
+	raw_level = d->raw_bd->props.brightness;
+	level = int3406_thermal_to_acpi(raw_level, d);
+
+	/*
+	 * There is no 1:1 mapping between the firmware interface level with the
+	 * raw interface level, we will have to find one that is close enough.
+	 */
+	for (i = 2; i < d->br->count; i++) {
+		if (level < levels[i]) {
+			if (i == 2)
+				break;
+			if ((level - levels[i - 1]) < (levels[i] - level))
+				i--;
+			break;
+		}
+	}
+
+	*state = d->br->count - 1 - i;
+	return 0;
+}
+
+static const struct thermal_cooling_device_ops video_cooling_ops = {
+	.get_max_state = int3406_thermal_get_max_state,
+	.get_cur_state = int3406_thermal_get_cur_state,
+	.set_cur_state = int3406_thermal_set_cur_state,
+};
+
+static int int3406_thermal_get_index(int *array, int nr, int value)
+{
+	int i;
+
+	for (i = 0; i < nr; i++) {
+		if (array[i] == value)
+			break;
+	}
+	return i == nr ? -ENOENT : i;
+}
+
+static void int3406_thermal_get_limit(struct int3406_thermal_data *d)
+{
+	acpi_status status;
+	unsigned long long lower_limit, upper_limit;
+	int index;
+
+	status = acpi_evaluate_integer(d->handle, "DDDL", NULL, &lower_limit);
+	if (ACPI_SUCCESS(status)) {
+		index = int3406_thermal_get_index(d->br->levels, d->br->count,
+						  lower_limit);
+		if (index > 0) {
+			d->lower_limit = (int)lower_limit;
+			d->lower_limit_index = index;
+		}
+	}
+
+	status = acpi_evaluate_integer(d->handle, "DDPC", NULL, &upper_limit);
+	if (ACPI_SUCCESS(status)) {
+		index = int3406_thermal_get_index(d->br->levels, d->br->count,
+						  upper_limit);
+		if (index > 0) {
+			d->upper_limit = (int)upper_limit;
+			d->upper_limit_index = index;
+		}
+	}
+}
+
+static void int3406_notify(acpi_handle handle, u32 event, void *data)
+{
+	if (event == INT3406_BRIGHTNESS_LIMITS_CHANGED)
+		int3406_thermal_get_limit(data);
+}
+
+static int int3406_thermal_probe(struct platform_device *pdev)
+{
+	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
+	struct int3406_thermal_data *d;
+	struct backlight_device *bd;
+	int ret;
+
+	if (!ACPI_HANDLE(&pdev->dev))
+		return -ENODEV;
+
+	d = devm_kzalloc(&pdev->dev, sizeof(*d), GFP_KERNEL);
+	if (!d)
+		return -ENOMEM;
+	d->handle = ACPI_HANDLE(&pdev->dev);
+
+	bd = backlight_device_get_by_type(BACKLIGHT_RAW);
+	if (!bd)
+		return -ENODEV;
+	d->raw_bd = bd;
+
+	ret = acpi_video_get_levels(ACPI_COMPANION(&pdev->dev), &d->br);
+	if (ret)
+		return ret;
+
+	int3406_thermal_get_limit(d);
+
+	d->cooling_dev = thermal_cooling_device_register(acpi_device_bid(adev),
+							 d, &video_cooling_ops);
+	if (IS_ERR(d->cooling_dev))
+		goto err;
+
+	ret = acpi_install_notify_handler(adev->handle, ACPI_DEVICE_NOTIFY,
+					  int3406_notify, d);
+	if (ret)
+		goto err_cdev;
+
+	platform_set_drvdata(pdev, d);
+
+	return 0;
+
+err_cdev:
+	thermal_cooling_device_unregister(d->cooling_dev);
+err:
+	kfree(d->br);
+	return -ENODEV;
+}
+
+static int int3406_thermal_remove(struct platform_device *pdev)
+{
+	struct int3406_thermal_data *d = platform_get_drvdata(pdev);
+
+	thermal_cooling_device_unregister(d->cooling_dev);
+	kfree(d->br);
+	return 0;
+}
+
+static const struct acpi_device_id int3406_thermal_match[] = {
+	{"INT3406", 0},
+	{}
+};
+
+MODULE_DEVICE_TABLE(acpi, int3406_thermal_match);
+
+static struct platform_driver int3406_thermal_driver = {
+	.probe = int3406_thermal_probe,
+	.remove = int3406_thermal_remove,
+	.driver = {
+		   .name = "int3406 thermal",
+		   .owner = THIS_MODULE,
+		   .acpi_match_table = int3406_thermal_match,
+		   },
+};
+
+module_platform_driver(int3406_thermal_driver);
+
+MODULE_DESCRIPTION("INT3406 Thermal driver");
+MODULE_LICENSE("GPL");
-- 
2.5.5

