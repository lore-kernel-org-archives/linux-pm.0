From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: [PATCH v2] power: Add ltc3651-charger driver
Date: Fri,  5 May 2017 08:42:22 +0200
Message-ID: <1493966542-15947-1-git-send-email-mike.looijmans@topic.nl>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atl4mhob20.registeredsite.com ([209.17.115.114]:47566 "EHLO
        atl4mhob20.registeredsite.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755440AbdEEGma (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 May 2017 02:42:30 -0400
Received: from mailpod.hostingplatform.com ([10.30.71.207])
        by atl4mhob20.registeredsite.com (8.14.4/8.14.4) with ESMTP id v456gRda003721
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
        for <linux-pm@vger.kernel.org>; Fri, 5 May 2017 02:42:27 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: sre@kernel.org, linux-kernel@vger.kernel.org, Mike Looijmans <mike.looijmans@topic.nl>

The LTC3651 reports its status via GPIO lines. This driver translates
the GPIO levels to battery charger status information via sysfs.
It relies on devicetree to supply the IO configuration.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---
v2: Remove unused include
    Remove last part of license text
    Use devm_power_supply_register
    Use "lltc" vendor prefix

 drivers/power/supply/Kconfig           |   7 ++
 drivers/power/supply/Makefile          |   1 +
 drivers/power/supply/ltc3651-charger.c | 210 +++++++++++++++++++++++++++++++++
 3 files changed, 218 insertions(+)
 create mode 100644 drivers/power/supply/ltc3651-charger.c

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index da92275..77b34e7 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -388,6 +388,13 @@ config CHARGER_MANAGER
           runtime and in suspend-to-RAM by waking up the system periodically
           with help of suspend_again support.
 
+config CHARGER_LTC3651
+	tristate "LTC3651 charger"
+	depends on GPIOLIB
+	help
+	  Say Y to include support for the LTC3651 battery charger which reports
+	  its status via GPIO lines.
+
 config CHARGER_MAX14577
 	tristate "Maxim MAX14577/77836 battery charger driver"
 	depends on MFD_MAX14577
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index 39fc733..973c386 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -60,6 +60,7 @@ obj-$(CONFIG_CHARGER_LP8727)	+= lp8727_charger.o
 obj-$(CONFIG_CHARGER_LP8788)	+= lp8788-charger.o
 obj-$(CONFIG_CHARGER_GPIO)	+= gpio-charger.o
 obj-$(CONFIG_CHARGER_MANAGER)	+= charger-manager.o
+obj-$(CONFIG_CHARGER_LTC3651)	+= ltc3651-charger.o
 obj-$(CONFIG_CHARGER_MAX14577)	+= max14577_charger.o
 obj-$(CONFIG_CHARGER_DETECTOR_MAX14656)	+= max14656_charger_detector.o
 obj-$(CONFIG_CHARGER_MAX77693)	+= max77693_charger.o
diff --git a/drivers/power/supply/ltc3651-charger.c b/drivers/power/supply/ltc3651-charger.c
new file mode 100644
index 0000000..e667b29
--- /dev/null
+++ b/drivers/power/supply/ltc3651-charger.c
@@ -0,0 +1,210 @@
+/*
+ *  Copyright (C) 2017, Topic Embedded Products
+ *  Driver for LTC3651 charger IC.
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under  the terms of the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the License, or (at your
+ *  option) any later version.
+ */
+
+#include <linux/device.h>
+#include <linux/gpio/consumer.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/power_supply.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+
+struct ltc3651_charger {
+	struct power_supply *charger;
+	struct power_supply_desc charger_desc;
+	struct gpio_desc *acpr_gpio;
+	struct gpio_desc *fault_gpio;
+	struct gpio_desc *chrg_gpio;
+};
+
+static irqreturn_t ltc3651_charger_irq(int irq, void *devid)
+{
+	struct power_supply *charger = devid;
+
+	power_supply_changed(charger);
+
+	return IRQ_HANDLED;
+}
+
+static inline struct ltc3651_charger *psy_to_ltc3651_charger(
+	struct power_supply *psy)
+{
+	return power_supply_get_drvdata(psy);
+}
+
+static int ltc3651_charger_get_property(struct power_supply *psy,
+		enum power_supply_property psp, union power_supply_propval *val)
+{
+	struct ltc3651_charger *ltc3651_charger = psy_to_ltc3651_charger(psy);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
+		if (!ltc3651_charger->chrg_gpio) {
+			val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
+			break;
+		}
+		if (gpiod_get_value(ltc3651_charger->chrg_gpio))
+			val->intval = POWER_SUPPLY_STATUS_CHARGING;
+		else
+			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
+		break;
+	case POWER_SUPPLY_PROP_ONLINE:
+		val->intval = gpiod_get_value(ltc3651_charger->acpr_gpio);
+		break;
+	case POWER_SUPPLY_PROP_HEALTH:
+		if (!ltc3651_charger->fault_gpio) {
+			val->intval = POWER_SUPPLY_HEALTH_UNKNOWN;
+			break;
+		}
+		if (!gpiod_get_value(ltc3651_charger->fault_gpio)) {
+			val->intval = POWER_SUPPLY_HEALTH_GOOD;
+			break;
+		}
+		/*
+		 * If the fault pin is active, the chrg pin explains the type
+		 * of failure.
+		 */
+		if (!ltc3651_charger->chrg_gpio) {
+			val->intval = POWER_SUPPLY_HEALTH_UNSPEC_FAILURE;
+			break;
+		}
+		val->intval = gpiod_get_value(ltc3651_charger->chrg_gpio) ?
+				POWER_SUPPLY_HEALTH_OVERHEAT :
+				POWER_SUPPLY_HEALTH_DEAD;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static enum power_supply_property ltc3651_charger_properties[] = {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_HEALTH,
+};
+
+static int ltc3651_charger_probe(struct platform_device *pdev)
+{
+	struct power_supply_config psy_cfg = {};
+	struct ltc3651_charger *ltc3651_charger;
+	struct power_supply_desc *charger_desc;
+	int ret;
+
+	ltc3651_charger = devm_kzalloc(&pdev->dev, sizeof(*ltc3651_charger),
+					GFP_KERNEL);
+	if (!ltc3651_charger)
+		return -ENOMEM;
+
+	ltc3651_charger->acpr_gpio = devm_gpiod_get(&pdev->dev,
+					"acpr", GPIOD_IN);
+	if (IS_ERR(ltc3651_charger->acpr_gpio)) {
+		ret = PTR_ERR(ltc3651_charger->charger);
+		dev_err(&pdev->dev, "Failed to acquire acpr GPIO: %d\n", ret);
+		return ret;
+	}
+	ltc3651_charger->fault_gpio = devm_gpiod_get_optional(&pdev->dev,
+					"fault", GPIOD_IN);
+	if (IS_ERR(ltc3651_charger->fault_gpio)) {
+		ret = PTR_ERR(ltc3651_charger->charger);
+		dev_err(&pdev->dev, "Failed to acquire fault GPIO: %d\n", ret);
+		return ret;
+	}
+	ltc3651_charger->chrg_gpio = devm_gpiod_get_optional(&pdev->dev,
+					"chrg", GPIOD_IN);
+	if (IS_ERR(ltc3651_charger->chrg_gpio)) {
+		ret = PTR_ERR(ltc3651_charger->charger);
+		dev_err(&pdev->dev, "Failed to acquire chrg GPIO: %d\n", ret);
+		return ret;
+	}
+
+	charger_desc = &ltc3651_charger->charger_desc;
+	charger_desc->name = pdev->dev.of_node->name;
+	charger_desc->type = POWER_SUPPLY_TYPE_MAINS;
+	charger_desc->properties = ltc3651_charger_properties;
+	charger_desc->num_properties = ARRAY_SIZE(ltc3651_charger_properties);
+	charger_desc->get_property = ltc3651_charger_get_property;
+	psy_cfg.of_node = pdev->dev.of_node;
+	psy_cfg.drv_data = ltc3651_charger;
+
+	ltc3651_charger->charger = devm_power_supply_register(&pdev->dev,
+						      charger_desc, &psy_cfg);
+	if (IS_ERR(ltc3651_charger->charger)) {
+		ret = PTR_ERR(ltc3651_charger->charger);
+		dev_err(&pdev->dev, "Failed to register power supply: %d\n",
+			ret);
+		return ret;
+	}
+
+	/*
+	 * Acquire IRQs for the GPIO pins if possible. If the system does not
+	 * support IRQs on these pins, userspace will have to poll the sysfs
+	 * files manually.
+	 */
+	if (ltc3651_charger->acpr_gpio) {
+		ret = gpiod_to_irq(ltc3651_charger->acpr_gpio);
+		if (ret >= 0)
+			ret = devm_request_any_context_irq(&pdev->dev, ret,
+				ltc3651_charger_irq,
+				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
+				dev_name(&pdev->dev), ltc3651_charger->charger);
+		if (ret < 0)
+			dev_warn(&pdev->dev, "Failed to request acpr irq\n");
+	}
+	if (ltc3651_charger->fault_gpio) {
+		ret = gpiod_to_irq(ltc3651_charger->fault_gpio);
+		if (ret >= 0)
+			ret = devm_request_any_context_irq(&pdev->dev, ret,
+				ltc3651_charger_irq,
+				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
+				dev_name(&pdev->dev), ltc3651_charger->charger);
+		if (ret < 0)
+			dev_warn(&pdev->dev, "Failed to request fault irq\n");
+	}
+	if (ltc3651_charger->chrg_gpio) {
+		ret = gpiod_to_irq(ltc3651_charger->chrg_gpio);
+		if (ret >= 0)
+			ret = devm_request_any_context_irq(&pdev->dev, ret,
+				ltc3651_charger_irq,
+				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
+				dev_name(&pdev->dev), ltc3651_charger->charger);
+		if (ret < 0)
+			dev_warn(&pdev->dev, "Failed to request chrg irq\n");
+	}
+
+	platform_set_drvdata(pdev, ltc3651_charger);
+
+	return 0;
+}
+
+static const struct of_device_id ltc3651_charger_match[] = {
+	{ .compatible = "lltc,ltc3651-charger" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ltc3651_charger_match);
+
+static struct platform_driver ltc3651_charger_driver = {
+	.probe = ltc3651_charger_probe,
+	.driver = {
+		.name = "ltc3651-charger",
+		.of_match_table = ltc3651_charger_match,
+	},
+};
+
+module_platform_driver(ltc3651_charger_driver);
+
+MODULE_AUTHOR("Mike Looijmans <mike.looijmans@topic.nl>");
+MODULE_DESCRIPTION("Driver for LTC3651 charger");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:ltc3651-charger");
-- 
1.9.1
