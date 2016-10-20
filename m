From: Steve Twiss <stwiss.opensource@diasemi.com>
Subject: [RFC V1] thermal: da9062/61: Thermal junction temperature
 monitoring driver
Date: Thu, 20 Oct 2016 16:22:08 +0100
Message-ID: <20161020153711.A1AD53FB80@swsrvapps-01.diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail1.bemta6.messagelabs.com ([193.109.254.110]:28922 "EHLO
        mail1.bemta6.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1030385AbcJTPh3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Oct 2016 11:37:29 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, LINUX-KERNEL <linux-kernel@vger.kernel.org>, LINUX-PM <linux-pm@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>
Cc: Keerthy <a0393675@ti.com>, Support Opensource <support.opensource@diasemi.com>

From: Steve Twiss <stwiss.opensource@diasemi.com>

Add junction temperature monitoring supervisor device driver, compatible
with the DA9062 and DA9061 PMICs.

If the PMIC's internal junction temperature rises above TEMP_WARN (125
degC) an interrupt is issued. This TEMP_WARN level is defined as the
THERMAL_TRIP_HOT trip-wire inside the device driver.

The thermal triggering mechanism is interrupt based and happens when the
temperature rises above a given threshold level. The component cannot
return an exact temperature, it only has knowledge if the temperature is
above or below a given threshold value. A status bit must be polled to
detect when the temperature falls below that threshold level again. The
thermal core is reconfigured during an over-temperature event to
repeatedly poll and detect when the temperature falls below this trip-wire
by altering the polling_delay variable and activating the repetitive calls
to get_temp().

This first level of temperature supervision is intended for non-invasive
temperature control, where the necessary measures for cooling the system
down are left to the host software. In this case, through the notify
framework of the thermal core.

Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>

---
This patch applies against linux-next and v4.8

Hi,

My previous patch contained a work-queue when I needed to poll for a
temperature change. The problem is that for the majority of the time I do
not need to poll anything, only after an IRQ driven over-temperature event
has happened

- https://patchwork.kernel.org/patch/9364267/
 
The thermal triggering mechanism is event based to start with. An interrupt
happens when the temperature rises above a given threshold level. However,
this event based system gives way to a polling operation to detect when the
temperature falls below the trip-wire.

When over-temperature is reached, the interrupt from the DA9061/2 will be
repeatedly triggered: i.e. if the event is not masked, this will issue
another interrupt. For this reason, the IRQ is disabled when the first
trigger happens and the status bit is polled until it becomes false. After
that, the IRQ is re-enabled again so a new over-temperature trigger can be
detected

During an over-temperature event, it is possible to activate the thermal
core's polling_delay functionality and request repeated calls to get_temp()
every x milliseconds. The status bit is tested to decide if the temperature
has dropped below the threshold, and the interrupt is re-enabled
accordingly.

The DA9062/1 component cannot return an exact temperature, it only has
knowledge if the temperature is above or below a given threshold value. So
the get_temp() function provided by the device driver will never return a
real temperature. In this case its primary function will be to provide a
two level status (either 125degC or 0degC) and to re-enable the IRQ if
necessary and turn off thermal core polling when it is no longer needed.

I have looked through thermal core, and there doesn't seem to be a formal
way of toggling on/off thermal core polling when I need to poll the
temperature through get_temp(). But, it seems I can hijack the
polling_delay value and turn the polling on and off from my device driver.

I'm not certain if this is acceptable, accessing the thermal core like this
to get the polling capability.

If this is acceptible, please do not apply this patch. I will re-submit
it as part of my original patch set. This is intended as RFC only.

Regards,
Steve Twiss, Dialog Semiconductor Ltd.


 drivers/thermal/Kconfig          |  10 ++
 drivers/thermal/Makefile         |   1 +
 drivers/thermal/da9062-thermal.c | 292 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 303 insertions(+)
 create mode 100644 drivers/thermal/da9062-thermal.c

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 2d702ca..da58e54 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -272,6 +272,16 @@ config DB8500_CPUFREQ_COOLING
 	  bound cpufreq cooling device turns active to set CPU frequency low to
 	  cool down the CPU.
 
+config DA9062_THERMAL
+	tristate "DA9062/DA9061 Dialog Semiconductor thermal driver"
+	depends on MFD_DA9062
+	depends on OF
+	help
+	  Enable this for the Dialog Semiconductor thermal sensor driver.
+	  This will report PMIC junction over-temperature for one thermal trip
+	  zone.
+	  Compatible with the DA9062 and DA9061 PMICs.
+
 config INTEL_POWERCLAMP
 	tristate "Intel PowerClamp idle injection driver"
 	depends on THERMAL
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 10b07c1..0a2b3f2 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -38,6 +38,7 @@ obj-$(CONFIG_ARMADA_THERMAL)	+= armada_thermal.o
 obj-$(CONFIG_TANGO_THERMAL)	+= tango_thermal.o
 obj-$(CONFIG_IMX_THERMAL)	+= imx_thermal.o
 obj-$(CONFIG_DB8500_CPUFREQ_COOLING)	+= db8500_cpufreq_cooling.o
+obj-$(CONFIG_DA9062_THERMAL)	+= da9062-thermal.o
 obj-$(CONFIG_INTEL_POWERCLAMP)	+= intel_powerclamp.o
 obj-$(CONFIG_X86_PKG_TEMP_THERMAL)	+= x86_pkg_temp_thermal.o
 obj-$(CONFIG_INTEL_SOC_DTS_IOSF_CORE)	+= intel_soc_dts_iosf.o
diff --git a/drivers/thermal/da9062-thermal.c b/drivers/thermal/da9062-thermal.c
new file mode 100644
index 0000000..59e04b2
--- /dev/null
+++ b/drivers/thermal/da9062-thermal.c
@@ -0,0 +1,292 @@
+/*
+ * Thermal device driver for DA9062 and DA9061
+ * Copyright (C) 2016  Dialog Semiconductor Ltd.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/errno.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/thermal.h>
+
+#include <linux/mfd/da9062/core.h>
+#include <linux/mfd/da9062/registers.h>
+
+#define DA9062_DEFAULT_POLLING_MS_PERIOD	3000
+#define DA9062_MAX_POLLING_MS_PERIOD		10000
+#define DA9062_MIN_POLLING_MS_PERIOD		1000
+
+#define DA9062_MILLI_CELSIUS(t)			((t)*1000)
+
+struct da9062_thermal_config {
+	const char *name;
+};
+
+struct da9062_thermal {
+	struct da9062 *hw;
+	struct thermal_zone_device *zone;
+	enum thermal_device_mode mode;
+	int irq;
+	bool disabled;
+	int polling_delay;
+	const struct da9062_thermal_config *config;
+	struct device *dev;
+};
+
+static irqreturn_t da9062_thermal_irq_handler(int irq, void *data)
+{
+	struct da9062_thermal *thermal = data;
+
+	disable_irq_nosync(thermal->irq);
+	thermal->disabled = true;
+	thermal->zone->polling_delay = thermal->polling_delay;
+	thermal_zone_device_update(thermal->zone);
+	return IRQ_HANDLED;
+}
+
+static int da9062_thermal_get_mode(struct thermal_zone_device *z,
+				   enum thermal_device_mode *mode)
+{
+	struct da9062_thermal *thermal = z->devdata;
+	*mode = thermal->mode;
+	return 0;
+}
+
+static int da9062_thermal_get_trip_type(struct thermal_zone_device *z,
+				int trip,
+				enum thermal_trip_type *type)
+{
+	struct da9062_thermal *thermal = z->devdata;
+
+	switch (trip) {
+	case 0:
+		*type = THERMAL_TRIP_HOT;
+		break;
+	default:
+		dev_err(thermal->dev,
+			"Driver does not support more than 1 trip-wire\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int da9062_thermal_get_trip_temp(struct thermal_zone_device *z,
+					int trip,
+					int *temp)
+{
+	struct da9062_thermal *thermal = z->devdata;
+
+	switch (trip) {
+	case 0:
+		*temp = DA9062_MILLI_CELSIUS(125);
+		break;
+	default:
+		dev_err(thermal->dev,
+			"Driver does not support more than 1 trip-wire\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int da9062_thermal_notify(struct thermal_zone_device *z,
+				 int trip,
+				 enum thermal_trip_type type)
+{
+	struct da9062_thermal *thermal = z->devdata;
+
+	switch (type) {
+	case THERMAL_TRIP_HOT:
+		dev_warn(thermal->dev, "Reached HOT (125degC) temperature\n");
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+
+static int da9062_thermal_get_temp(struct thermal_zone_device *z,
+				   int *temp)
+{
+	struct da9062_thermal *thermal = z->devdata;
+	unsigned int val;
+	bool reenable = false;
+	int ret = 0;
+
+	/* clear E_TEMP */
+	ret = regmap_write(thermal->hw->regmap,
+			   DA9062AA_EVENT_B,
+			   DA9062AA_E_TEMP_MASK);
+	if (ret < 0) {
+		dev_err(thermal->dev,
+			"Cannot clear the TJUNC temperature status\n");
+		goto err_enable_irq;
+	}
+
+	/* Now read E_TEMP again: it is acting like a status bit.
+	 * If over-temperature, then this status will be true.
+	 * If not over-temperature, this status will be false.
+	 */
+	ret = regmap_read(thermal->hw->regmap,
+			  DA9062AA_EVENT_B,
+			  &val);
+	if (ret < 0) {
+		dev_err(thermal->dev,
+			"Cannot check the TJUNC temperature status\n");
+		goto err_enable_irq;
+	} else {
+		if (val & DA9062AA_E_TEMP_MASK) {
+			*temp = DA9062_MILLI_CELSIUS(125);
+			return ret;
+		} else {
+			*temp = DA9062_MILLI_CELSIUS(0);
+			/* only re-enable the IRQ if temperature has fallen */
+			reenable = true;
+		}
+	}
+
+err_enable_irq:
+	/* only reenable the IRQ again if it was previously disabled and
+	 * if it should be re-enabled because the temperature has now fallen
+	 */
+	if (thermal->disabled && reenable) {
+		thermal->zone->polling_delay = 0;
+		enable_irq(thermal->irq);
+		thermal->disabled = false;
+	}
+	return ret;
+}
+
+static struct thermal_zone_device_ops da9062_thermal_ops = {
+	.get_temp	= da9062_thermal_get_temp,
+	.get_mode	= da9062_thermal_get_mode,
+	.get_trip_type	= da9062_thermal_get_trip_type,
+	.get_trip_temp	= da9062_thermal_get_trip_temp,
+	.notify		= da9062_thermal_notify,
+};
+
+static const struct da9062_thermal_config da9062_config = {
+	.name = "da9062-thermal",
+};
+
+static const struct of_device_id da9062_compatible_reg_id_table[] = {
+	{ .compatible = "dlg,da9062-thermal", .data = &da9062_config },
+	{ },
+};
+
+static int da9062_thermal_probe(struct platform_device *pdev)
+{
+	struct da9062 *chip = dev_get_drvdata(pdev->dev.parent);
+	struct da9062_thermal *thermal;
+	unsigned int pp_tmp = DA9062_DEFAULT_POLLING_MS_PERIOD;
+	const struct of_device_id *match;
+	int ret = 0;
+
+	match = of_match_node(da9062_compatible_reg_id_table,
+			      pdev->dev.of_node);
+	if (!match)
+		return -ENXIO;
+
+	if (pdev->dev.of_node) {
+		if (!of_property_read_u32(pdev->dev.of_node,
+					"dlg,tjunc-temp-polling-period-ms",
+					&pp_tmp)) {
+			if (pp_tmp < DA9062_MIN_POLLING_MS_PERIOD ||
+				pp_tmp > DA9062_MAX_POLLING_MS_PERIOD)
+				pp_tmp = DA9062_DEFAULT_POLLING_MS_PERIOD;
+		}
+
+		dev_dbg(&pdev->dev,
+			 "TJUNC temp polling period set at %d ms\n",
+			 pp_tmp);
+	}
+
+	thermal = devm_kzalloc(&pdev->dev, sizeof(struct da9062_thermal),
+			     GFP_KERNEL);
+	if (!thermal) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	thermal->config = match->data;
+	thermal->hw = chip;
+	thermal->mode = THERMAL_DEVICE_ENABLED;
+	thermal->dev = &pdev->dev;
+	thermal->disabled = false;
+	thermal->polling_delay = pp_tmp;
+
+	thermal->zone = thermal_zone_device_register(thermal->config->name,
+					1, 0, thermal,
+					&da9062_thermal_ops, NULL, 0,
+					0);
+	if (IS_ERR(thermal->zone)) {
+		dev_err(&pdev->dev, "Cannot register thermal zone device\n");
+		ret = PTR_ERR(thermal->zone);
+		goto err;
+	}
+
+	ret = platform_get_irq_byname(pdev, "THERMAL");
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to get platform IRQ.\n");
+		goto err_zone;
+	}
+	thermal->irq = ret;
+
+	ret = request_threaded_irq(thermal->irq, NULL,
+				   da9062_thermal_irq_handler,
+				   IRQF_TRIGGER_LOW | IRQF_ONESHOT,
+				   "THERMAL", thermal);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"Failed to request thermal device IRQ.\n");
+		goto err_zone;
+	}
+
+	platform_set_drvdata(pdev, thermal);
+	return 0;
+
+err_zone:
+	thermal_zone_device_unregister(thermal->zone);
+err:
+	return ret;
+}
+
+static int da9062_thermal_remove(struct platform_device *pdev)
+{
+	struct	da9062_thermal *thermal = platform_get_drvdata(pdev);
+
+	free_irq(thermal->irq, thermal);
+	thermal_zone_device_unregister(thermal->zone);
+	return 0;
+}
+
+static struct platform_driver da9062_thermal_driver = {
+	.probe	= da9062_thermal_probe,
+	.remove	= da9062_thermal_remove,
+	.driver	= {
+		.name	= "da9062-thermal",
+		.of_match_table = da9062_compatible_reg_id_table,
+	},
+};
+
+module_platform_driver(da9062_thermal_driver);
+
+MODULE_AUTHOR("Steve Twiss");
+MODULE_DESCRIPTION("Thermal TJUNC device driver for Dialog DA9062 and DA9061");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:da9062-thermal");
-- 
end-of-patch for PATCH RFC V1

