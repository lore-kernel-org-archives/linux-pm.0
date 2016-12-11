From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 2/2] iio: misc: add support for GPIO power switches
Date: Sun, 11 Dec 2016 23:21:45 +0100
Message-ID: <1481494905-18037-3-git-send-email-bgolaszewski@baylibre.com>
References: <1481494905-18037-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1481494905-18037-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>, Patrick Titiano <ptitiano@baylibre.com>, Neil Armstrong <narmstrong@baylibre.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-pm@vger.kernel.org

Some power-measuring ADCs work together with power load switches which
allow to power-cycle measured devices.

An example use case would be measuring the power consumption of a
development board during boot using a power monitor such as TI INA226
and power-cycling the board remotely using a TPS229* power switch.

Add an iio driver for simple GPIO power switches and expose a sysfs
attribute allowing to toggle their state.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/iio/Kconfig                  |   1 +
 drivers/iio/Makefile                 |   1 +
 drivers/iio/misc/Kconfig             |  17 +++++
 drivers/iio/misc/Makefile            |   6 ++
 drivers/iio/misc/gpio-power-switch.c | 127 +++++++++++++++++++++++++++++++++++
 5 files changed, 152 insertions(+)
 create mode 100644 drivers/iio/misc/Kconfig
 create mode 100644 drivers/iio/misc/Makefile
 create mode 100644 drivers/iio/misc/gpio-power-switch.c

diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
index 6743b18..2e896e0 100644
--- a/drivers/iio/Kconfig
+++ b/drivers/iio/Kconfig
@@ -80,6 +80,7 @@ source "drivers/iio/gyro/Kconfig"
 source "drivers/iio/health/Kconfig"
 source "drivers/iio/humidity/Kconfig"
 source "drivers/iio/imu/Kconfig"
+source "drivers/iio/misc/Kconfig"
 source "drivers/iio/light/Kconfig"
 source "drivers/iio/magnetometer/Kconfig"
 source "drivers/iio/orientation/Kconfig"
diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
index 87e4c43..4008d5a 100644
--- a/drivers/iio/Makefile
+++ b/drivers/iio/Makefile
@@ -25,6 +25,7 @@ obj-y += frequency/
 obj-y += health/
 obj-y += humidity/
 obj-y += imu/
+obj-y += misc/
 obj-y += light/
 obj-y += magnetometer/
 obj-y += orientation/
diff --git a/drivers/iio/misc/Kconfig b/drivers/iio/misc/Kconfig
new file mode 100644
index 0000000..8d73751
--- /dev/null
+++ b/drivers/iio/misc/Kconfig
@@ -0,0 +1,17 @@
+#
+# Miscellaneous iio drivers
+#
+# When adding new entries keep the list in alphabetical order
+
+menu "Miscellaneous iio drivers"
+
+config GPIO_POWER_SWITCH
+	tristate "GPIO power switch driver"
+	depends on GPIOLIB
+	help
+	  Say yes here to build support for gpio power switches.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called gpio-power-switch.
+
+endmenu
diff --git a/drivers/iio/misc/Makefile b/drivers/iio/misc/Makefile
new file mode 100644
index 0000000..cebd0c4
--- /dev/null
+++ b/drivers/iio/misc/Makefile
@@ -0,0 +1,6 @@
+#
+# Makefile for IIO misc drivers
+#
+
+# When adding new entries keep the list in alphabetical order
+obj-$(CONFIG_GPIO_POWER_SWITCH) += gpio-power-switch.o
diff --git a/drivers/iio/misc/gpio-power-switch.c b/drivers/iio/misc/gpio-power-switch.c
new file mode 100644
index 0000000..25fbeb7
--- /dev/null
+++ b/drivers/iio/misc/gpio-power-switch.c
@@ -0,0 +1,127 @@
+/*
+ * GPIO power switch driver using the industrial IO framework.
+ *
+ * Copyright (C) 2016 BayLibre SAS
+ *
+ * Author:
+ *   Bartosz Golaszewski <bgolaszewski@baylibre.com.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/gpio/consumer.h>
+
+struct gpio_pwrsw_context {
+	struct gpio_desc *gpio;
+};
+
+static ssize_t gpio_pwrsw_enable_show(struct device *dev,
+				      struct device_attribute *attr,
+				      char *buf)
+{
+	struct gpio_pwrsw_context *ctx = iio_priv(dev_to_iio_dev(dev));
+	int val;
+
+	val = gpiod_get_value_cansleep(ctx->gpio);
+	if (val < 0)
+		return val;
+
+	return sprintf(buf, "%d\n", val);
+}
+
+static ssize_t gpio_pwrsw_enable_store(struct device *dev,
+				       struct device_attribute *attr,
+				       const char *buf, size_t len)
+{
+	struct gpio_pwrsw_context *ctx = iio_priv(dev_to_iio_dev(dev));
+	bool val;
+	int ret;
+
+	ret = strtobool(buf, &val);
+	if (ret)
+		return ret;
+
+	gpiod_set_value_cansleep(ctx->gpio, val ? 1 : 0);
+
+	return len;
+}
+
+static IIO_DEVICE_ATTR(in_active, 0644,
+		       gpio_pwrsw_enable_show,
+		       gpio_pwrsw_enable_store, 0);
+
+static struct attribute *gpio_pwrsw_attributes[] = {
+	&iio_dev_attr_in_active.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group gpio_pwrsw_attribute_group = {
+	.attrs = gpio_pwrsw_attributes,
+};
+
+static const struct iio_info gpio_pwrsw_info = {
+	.driver_module = THIS_MODULE,
+	.attrs = &gpio_pwrsw_attribute_group,
+};
+
+static int gpio_pwrsw_probe(struct platform_device *pdev)
+{
+	struct gpio_pwrsw_context *ctx;
+	struct iio_dev *iio_dev;
+	const char *name = NULL;
+	struct device *dev;
+	bool init_state;
+	int gpio_flags;
+
+	dev = &pdev->dev;
+
+	iio_dev = devm_iio_device_alloc(dev, sizeof(*ctx));
+	if (!iio_dev)
+		return -ENOMEM;
+
+	ctx = iio_priv(iio_dev);
+
+	init_state = of_property_read_bool(dev->of_node, "power-switch-on");
+	gpio_flags = init_state ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
+
+	ctx->gpio = devm_gpiod_get(dev, "power", gpio_flags);
+	if (IS_ERR(ctx->gpio)) {
+		dev_err(dev, "unable to get the power switch gpio: %ld\n",
+			PTR_ERR(ctx->gpio));
+		return PTR_ERR(ctx->gpio);
+	}
+
+	of_property_read_string(dev->of_node, "power-switch-name", &name);
+
+	iio_dev->dev.parent = dev;
+	iio_dev->dev.of_node = dev->of_node;
+	iio_dev->name = name ? name : dev->driver->name;
+	iio_dev->info = &gpio_pwrsw_info;
+
+	return devm_iio_device_register(dev, iio_dev);
+}
+
+static const struct of_device_id gpio_pwrsw_of_match[] = {
+	{ .compatible = "gpio-power-switch", },
+	{ },
+};
+
+static struct platform_driver gpio_pwrsw_platform_driver = {
+	.probe = gpio_pwrsw_probe,
+	.driver = {
+		.name = "gpio-power-switch",
+		.of_match_table = gpio_pwrsw_of_match,
+	},
+};
+module_platform_driver(gpio_pwrsw_platform_driver);
+
+MODULE_AUTHOR("Bartosz Golaszewski <bgolaszewski@baylibre.com>");
+MODULE_DESCRIPTION("GPIO power switch driver for iio");
+MODULE_LICENSE("GPL v2");
-- 
2.9.3

