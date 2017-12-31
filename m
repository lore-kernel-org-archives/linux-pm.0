From: Ognjen Galic <smclt30p@gmail.com>
Subject: [PATCH v11 3/5] thinkpad_acpi: Add support for battery thresholds
Date: Sun, 31 Dec 2017 15:17:27 +0100
Message-ID: <20171231141727.GA4643@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
Sender: platform-driver-x86-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Ognjen =?utf-8?B?R2FsacSH?= <smclt30p@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, devel@acpica.org, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Sebastian Reichel <sre@kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, ibm-acpi-devel@lists.sourceforge.net, Linux PM <linux-pm@vger.kernel.org>, Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph@boehmwalder.at>, Kevin Locke <kevin@kevinlocke.name>
List-Id: linux-pm@vger.kernel.org

thinkpad_acpi registers two new attributes for each battery:

1) Charge start threshold
/sys/class/power_supply/BATN/charge_start_threshold

Valid values are [0, 99]. A value of 0 turns off the
start threshold wear control.

2) Charge stop threshold
/sys/class/power_supply/BATN/charge_stop_threshold

Valid values are [1, 100]. A value of 100 turns off
the stop threshold wear control. This must be
configured first.

This patch depends on the following patches:

"battery: Add the battery hooking API"

Signed-off-by: Ognjen Galic <smclt30p@gmail.com>

v2:
* Re-write the patch to make the changes in
battery.c generic as suggested by Rafael

v3:
* Fixed a bug where you could not set the stop
threshold to 100% when the start threshold is 0%
* Fixed the "Not Charging" quirk to match Lenovo's
BIOS Firmware specification

v4:
* Fixed a bug where you could not set the start
threshold to >stop if stop was 100%

v5:
* Migrated from symbol_get to native linking,
to fix module dependencies
* Fixed a bug where unloading the module would
cause a BUG inside battery
* Fixed a bug where you could unload battery
before unloading thinkpad_acpi

v6:
* Fixed all the style and naming issues pointed
out by Andy Shevchenko

v7:
* No changes in this patch in v7

v8:
* No changes in this patch in v8

v9:
* Use DEVICE_ATTR_RW instead of DEVICE_ATTR
* Use bitopts.h instead of raw operators
* Remove redundant whitespaces
* Remove redundant comments
* Move the power_supply changes to separate patch
* Fix other various styling issues pointed out by
Andy Shevchenko

v10:
* Fix a pasting error from v6 that prevents the setting
of the start threshold with EINVAL

v11:
* Fix formatting of changelog
---
 drivers/platform/x86/Kconfig         |   1 +
 drivers/platform/x86/thinkpad_acpi.c | 440 ++++++++++++++++++++++++++++++++++-
 2 files changed, 440 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 2c745e8..d705c62 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -399,6 +399,7 @@ config SURFACE3_WMI
 config THINKPAD_ACPI
 	tristate "ThinkPad ACPI Laptop Extras"
 	depends on ACPI
+	depends on ACPI_BATTERY
 	depends on INPUT
 	depends on RFKILL || RFKILL = n
 	depends on ACPI_VIDEO || ACPI_VIDEO = n
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 117be48..f8291aa 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -23,7 +23,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#define TPACPI_VERSION "0.25"
+#define TPACPI_VERSION "0.26"
 #define TPACPI_SYSFS_VERSION 0x030000
 
 /*
@@ -66,6 +66,7 @@
 #include <linux/seq_file.h>
 #include <linux/sysfs.h>
 #include <linux/backlight.h>
+#include <linux/bitops.h>
 #include <linux/fb.h>
 #include <linux/platform_device.h>
 #include <linux/hwmon.h>
@@ -78,11 +79,13 @@
 #include <linux/workqueue.h>
 #include <linux/acpi.h>
 #include <linux/pci_ids.h>
+#include <linux/power_supply.h>
 #include <linux/thinkpad_acpi.h>
 #include <sound/core.h>
 #include <sound/control.h>
 #include <sound/initval.h>
 #include <linux/uaccess.h>
+#include <acpi/battery.h>
 #include <acpi/video.h>
 
 /* ThinkPad CMOS commands */
@@ -331,6 +334,7 @@ static struct {
 	u32 sensors_pdev_attrs_registered:1;
 	u32 hotkey_poll_active:1;
 	u32 has_adaptive_kbd:1;
+	u32 battery:1;
 } tp_features;
 
 static struct {
@@ -9201,6 +9205,436 @@ static struct ibm_struct mute_led_driver_data = {
 	.resume = mute_led_resume,
 };
 
+/***************** Battery Wear Control Driver ******************/
+
+/* Metadata */
+
+#define GET_START	"BCTG"
+#define SET_START	"BCCS"
+#define GET_STOP	"BCSG"
+#define SET_STOP	"BCSS"
+
+#define START_ATTR "charge_start_threshold"
+#define STOP_ATTR  "charge_stop_threshold"
+
+enum {
+	BAT_ANY = 0,
+	BAT_PRIMARY = 1,
+	BAT_SECONDARY = 2
+};
+
+enum {
+	/* Error condition bit */
+	METHOD_ERR = BIT(31),
+};
+
+enum {
+	/* This is used in the get/set helpers */
+	THRESHOLD_START,
+	THRESHOLD_STOP,
+};
+
+struct tpacpi_battery_data {
+	int charge_start;
+	int start_support;
+	int charge_stop;
+	int stop_support;
+};
+
+struct tpacpi_battery_driver_data {
+	struct tpacpi_battery_data batteries[3];
+	int individual_addressing;
+};
+
+static struct tpacpi_battery_driver_data battery_info;
+
+/* ACPI helpers/functions/probes */
+
+/**
+ * This evaluates a ACPI method call specific to the battery
+ * ACPI extension. The specifics are that an error is marked
+ * in the 32rd bit of the response, so we just check that here.
+ *
+ * Returns 0 on success
+ */
+static int tpacpi_battery_acpi_eval(char *method, int *ret, int param)
+{
+	if (!acpi_evalf(hkey_handle, ret, method, "dd", param)) {
+		acpi_handle_err(hkey_handle, "%s: evaluate failed", method);
+		return AE_ERROR;
+	}
+
+	if (*ret & METHOD_ERR) {
+		acpi_handle_err(hkey_handle,
+				"%s evaluated but flagged as error", method);
+		return AE_ERROR;
+	}
+
+	return AE_OK;
+}
+
+static int tpacpi_battery_get(int what, int battery, int *ret)
+{
+	switch (what) {
+
+	case THRESHOLD_START:
+
+		if (tpacpi_battery_acpi_eval(GET_START, ret, battery))
+			return -ENODEV;
+
+		/* The value is in the low 8 bits of the response */
+		*ret = *ret & 0xFF;
+		return 0;
+
+	case THRESHOLD_STOP:
+
+		if (tpacpi_battery_acpi_eval(GET_STOP, ret, battery))
+			return -ENODEV;
+
+		/* Value is in lower 8 bits */
+		*ret = *ret & 0xFF;
+
+		/*
+		 * On the stop value, if we return 0 that
+		 * does not make any sense. 0 means Default, which
+		 * means that charging stops at 100%, so we return
+		 * that.
+		 */
+		if (*ret == 0)
+			*ret = 100;
+
+		return 0;
+
+	default:
+		pr_crit("wrong parameter: %d", what);
+		return -EINVAL;
+	}
+
+}
+
+static int tpacpi_battery_set(int what, int battery, int value)
+{
+	int param, ret;
+
+	/* The first 8 bits are the value of the threshold */
+	param = value;
+	/* The battery ID is in bits 8-9, 2 bits */
+	param |= battery << 8;
+
+	switch (what) {
+
+	case THRESHOLD_START:
+
+		if (tpacpi_battery_acpi_eval(SET_START, &ret, param)) {
+			pr_err("failed to set charge threshold on battery %d",
+					battery);
+			return -ENODEV;
+		}
+
+		return 0;
+
+	case THRESHOLD_STOP:
+
+		if (tpacpi_battery_acpi_eval(SET_STOP, &ret, param)) {
+			pr_err("failed to set charge stop threshold: %d", battery);
+			return -ENODEV;
+		}
+
+		return 0;
+
+	default:
+		pr_crit("wrong parameter: %d", what);
+		return -EINVAL;
+	}
+}
+
+static int tpacpi_battery_probe(int battery)
+{
+	int ret = 0;
+
+	memset(&battery_info, 0, sizeof(struct tpacpi_battery_driver_data));
+
+	/*
+	 * 1) Get the current start threshold
+	 * 2) Check for support
+	 * 3) Get the current stop threshold
+	 * 4) Check for support
+	 */
+
+	if (acpi_has_method(hkey_handle, GET_START)) {
+
+		if (tpacpi_battery_acpi_eval(GET_START, &ret, battery)) {
+			pr_err("Error probing battery %d\n", battery);
+			return -ENODEV;
+		}
+
+		/* Individual addressing is in bit 9 */
+		if (ret & BIT(9))
+			battery_info.individual_addressing = true;
+
+		/* Support is marked in bit 8 */
+		if (ret & BIT(8))
+			battery_info.batteries[battery].start_support = 1;
+		else
+			return -ENODEV;
+
+		if (tpacpi_battery_get(THRESHOLD_START, battery,
+			&battery_info.batteries[battery].charge_start)) {
+			pr_err("Error probing battery %d\n", battery);
+			return -ENODEV;
+		}
+
+	}
+
+	if (acpi_has_method(hkey_handle, GET_STOP)) {
+
+		if (tpacpi_battery_acpi_eval(GET_STOP, &ret, battery)) {
+			pr_err("Error probing battery stop; %d\n", battery);
+			return -ENODEV;
+		}
+
+		/* Support is marked in bit 8 */
+		if (ret & BIT(8))
+			battery_info.batteries[battery].stop_support = 1;
+		else
+			return -ENODEV;
+
+		if (tpacpi_battery_get(THRESHOLD_STOP, battery,
+			&battery_info.batteries[battery].charge_stop)) {
+			pr_err("Error probing battery stop: %d\n", battery);
+			return -ENODEV;
+		}
+	}
+
+	pr_info("battery %d registered (start %d, stop %d)",
+			battery,
+			battery_info.batteries[battery].charge_start,
+			battery_info.batteries[battery].charge_stop);
+
+	return 0;
+}
+
+/* General helper functions */
+
+static int tpacpi_battery_get_id(const char *battery_name)
+{
+
+	if (strcmp(battery_name, "BAT0") == 0)
+		return BAT_PRIMARY;
+	if (strcmp(battery_name, "BAT1") == 0)
+		return BAT_SECONDARY;
+
+	/*
+	 * If for some reason the battery is not BAT0 nor is it
+	 * BAT1, we will assume it's the default, first battery,
+	 * AKA primary.
+	 */
+	pr_warn("unknown battery %s, assuming primary", battery_name);
+	return BAT_PRIMARY;
+}
+
+/* sysfs interface */
+
+static ssize_t tpacpi_battery_store(int what,
+				    struct device *dev,
+				    const char *buf, size_t count)
+{
+	struct power_supply *supply = to_power_supply(dev);
+	unsigned long value;
+	int battery, errno;
+
+	/*
+	 * Some systems have support for more than
+	 * one battery. If that is the case,
+	 * tpacpi_battery_probe marked that addressing
+	 * them individually is supported, so we do that
+	 * based on the device struct.
+	 *
+	 * On systems that are not supported, we assume
+	 * the primary as most of the ACPI calls fail
+	 * with "Any Battery" as the parameter.
+	 */
+	if (battery_info.individual_addressing)
+		/* BAT_PRIMARY or BAT_SECONDARY */
+		battery = tpacpi_battery_get_id(supply->desc->name);
+	else
+		battery = BAT_PRIMARY;
+
+	errno = kstrtoul(buf, 10, &value);
+
+	if (errno)
+		return errno;
+
+	switch (what) {
+
+	case THRESHOLD_START:
+
+		if (!battery_info.batteries[battery].start_support)
+			return -ENODEV;
+
+		/* valid values are [0, 99] */
+		if (value < 0 || value > 99)
+			return -EINVAL;
+
+		if (value > battery_info.batteries[battery].charge_stop)
+			return -EINVAL;
+
+		if (tpacpi_battery_set(THRESHOLD_START, battery, value))
+			return -ENODEV;
+
+		battery_info.batteries[battery].charge_start = value;
+		return count;
+
+	case THRESHOLD_STOP:
+
+		if (!battery_info.batteries[battery].stop_support)
+			return -ENODEV;
+
+		/* valid values are [1, 100] */
+		if (value < 1 || value > 100)
+			return -EINVAL;
+
+
+		if (value < battery_info.batteries[battery].charge_start)
+			return -EINVAL;
+
+		battery_info.batteries[battery].charge_stop = value;
+
+		/*
+		 * When 100 is passed to stop, we need to flip
+		 * it to 0 as that the EC understands that as
+		 * "Default", which will charge to 100%
+		 */
+		if (value == 100)
+			value = 0;
+
+		if (tpacpi_battery_set(THRESHOLD_STOP, battery, value))
+			return -EINVAL;
+
+		return count;
+
+	default:
+		pr_crit("Wrong parameter: %d", what);
+		return -EINVAL;
+	}
+
+	return count;
+}
+
+static ssize_t tpacpi_battery_show(int what,
+				   struct device *dev,
+				   char *buf)
+{
+	struct power_supply *supply = to_power_supply(dev);
+	int ret, battery;
+
+	/*
+	 * Some systems have support for more than
+	 * one battery. If that is the case,
+	 * tpacpi_battery_probe marked that addressing
+	 * them individually is supported, so we;
+	 * based on the device struct.
+	 *
+	 * On systems that are not supported, we assume
+	 * the primary as most of the ACPI calls fail
+	 * with "Any Battery" as the parameter.
+	 */
+	if (battery_info.individual_addressing)
+		/* BAT_PRIMARY or BAT_SECONDARY */
+		battery = tpacpi_battery_get_id(supply->desc->name);
+	else
+		battery = BAT_PRIMARY;
+
+	if (tpacpi_battery_get(what, battery, &ret))
+		return -ENODEV;
+
+	return sprintf(buf, "%d\n", ret);
+}
+
+static ssize_t charge_start_threshold_show(struct device *device,
+					struct device_attribute *attr,
+					char *buf)
+{
+	return tpacpi_battery_show(THRESHOLD_START, device, buf);
+}
+
+static ssize_t charge_stop_threshold_show(struct device *device,
+					struct device_attribute *attr,
+					char *buf)
+{
+	return tpacpi_battery_show(THRESHOLD_STOP, device, buf);
+}
+
+static ssize_t charge_start_threshold_store(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf, size_t count)
+{
+	return tpacpi_battery_store(THRESHOLD_START, dev, buf, count);
+}
+
+static ssize_t charge_stop_threshold_store(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf, size_t count)
+{
+	return tpacpi_battery_store(THRESHOLD_STOP, dev, buf, count);
+}
+
+static DEVICE_ATTR_RW(charge_start_threshold);
+static DEVICE_ATTR_RW(charge_stop_threshold);
+
+static struct attribute *tpacpi_battery_attrs[] = {
+	&dev_attr_charge_start_threshold.attr,
+	&dev_attr_charge_stop_threshold.attr,
+	NULL,
+};
+
+ATTRIBUTE_GROUPS(tpacpi_battery);
+
+/* ACPI battery hooking */
+
+static int tpacpi_battery_add(struct power_supply *battery)
+{
+	int batteryid = tpacpi_battery_get_id(battery->desc->name);
+
+	if (tpacpi_battery_probe(batteryid))
+		return -ENODEV;
+
+	if (device_add_groups(&battery->dev, tpacpi_battery_groups))
+		return -ENODEV;
+
+	return 0;
+}
+
+static int tpacpi_battery_remove(struct power_supply *battery)
+{
+	device_remove_groups(&battery->dev, tpacpi_battery_groups);
+	return 0;
+}
+
+static struct acpi_battery_hook battery_hook = {
+	.add_battery = tpacpi_battery_add,
+	.remove_battery = tpacpi_battery_remove,
+	.name = "ThinkPad Battery Extension",
+};
+
+/* Subdriver init/exit */
+
+static int __init tpacpi_battery_init(struct ibm_init_struct *ibm)
+{
+	battery_hook_register(&battery_hook);
+	return 0;
+}
+
+static void tpacpi_battery_exit(void)
+{
+	battery_hook_unregister(&battery_hook);
+}
+
+static struct ibm_struct battery_driver_data = {
+	.name = "battery",
+	.exit = tpacpi_battery_exit,
+};
+
 /****************************************************************************
  ****************************************************************************
  *
@@ -9647,6 +10081,10 @@ static struct ibm_init_struct ibms_init[] __initdata = {
 		.init = mute_led_init,
 		.data = &mute_led_driver_data,
 	},
+	{
+		.init = tpacpi_battery_init,
+		.data = &battery_driver_data,
+	},
 };
 
 static int __init set_ibm_param(const char *val, const struct kernel_param *kp)
-- 
2.7.4
