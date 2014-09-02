From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 1/8 v2] leds: add a driver for syscon-based LEDs
Date: Tue,  2 Sep 2014 14:02:27 +0200
Message-ID: <1409659354-23553-2-git-send-email-linus.walleij@linaro.org>
References: <1409659354-23553-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <1409659354-23553-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-leds-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Will Deacon <will.deacon@arm.com>, Rob Herring <robh@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>
List-Id: linux-pm@vger.kernel.org

This makes it possible to create a set of LEDs from a syscon
MFD instance, which is lean mean and clean on the ARM
reference designs and can replace the Versatile LEDs driver
in the long run, as well as other custom syscon LEDs drivers.

Cc: Bryan Wu <cooloney@gmail.com>
Cc: Richard Purdie <rpurdie@rpsys.net>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Augment driver to probe all nodes of a syscon to see if they
  are "register-bit-led"s, and then allocate them under the syscon
  if that is the case.
- Switch compatible string from "syscon-leds" to "register-bit-led"
---
 drivers/leds/Kconfig       |  10 +++
 drivers/leds/Makefile      |   1 +
 drivers/leds/leds-syscon.c | 165 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 176 insertions(+)
 create mode 100644 drivers/leds/leds-syscon.c

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 8c96e2ddf43b..ea05b6e2ea58 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -478,6 +478,16 @@ config LEDS_BLINKM
 	  This option enables support for the BlinkM RGB LED connected
 	  through I2C. Say Y to enable support for the BlinkM LED.
 
+config LEDS_SYSCON
+	bool "LED support for LEDs on system controllers"
+	depends on LEDS_CLASS
+	depends on MFD_SYSCON
+	depends on OF
+	help
+	  This option enabled support for the LEDs on syscon type
+	  devices. This will only work with device tree enabled
+	  devices.
+
 config LEDS_VERSATILE
 	tristate "LED support for the ARM Versatile and RealView"
 	depends on ARCH_REALVIEW || ARCH_VERSATILE
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index d8cc5f2777de..822dd83ef97a 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -53,6 +53,7 @@ obj-$(CONFIG_LEDS_ASIC3)		+= leds-asic3.o
 obj-$(CONFIG_LEDS_MAX8997)		+= leds-max8997.o
 obj-$(CONFIG_LEDS_LM355x)		+= leds-lm355x.o
 obj-$(CONFIG_LEDS_BLINKM)		+= leds-blinkm.o
+obj-$(CONFIG_LEDS_SYSCON)		+= leds-syscon.o
 obj-$(CONFIG_LEDS_VERSATILE)		+= leds-versatile.o
 
 # LED SPI Drivers
diff --git a/drivers/leds/leds-syscon.c b/drivers/leds/leds-syscon.c
new file mode 100644
index 000000000000..b6174f421ef2
--- /dev/null
+++ b/drivers/leds/leds-syscon.c
@@ -0,0 +1,165 @@
+/*
+ * Generic Syscon LEDs Driver
+ *
+ * Copyright (c) 2014, Linaro Limited
+ * Author: Linus Walleij <linus.walleij@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
+ * MA 02111-1307 USA
+ *
+ * This driver provides system reboot functionality for APM X-Gene SoC.
+ * For system shutdown, this is board specify. If a board designer
+ * implements GPIO shutdown, use the gpio-poweroff.c driver.
+ */
+#include <linux/io.h>
+#include <linux/of_device.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/stat.h>
+#include <linux/slab.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
+#include <linux/leds.h>
+
+/**
+ * struct syscon_led - state container for syscon based LEDs
+ * @cdev: LED class device for this LED
+ * @map: regmap to access the syscon device backing this LED
+ * @offset: the offset into the syscon regmap for the LED register
+ * @mask: the bit in the register corresponding to the LED
+ * @state: current state of the LED
+ */
+struct syscon_led {
+	struct led_classdev cdev;
+	struct regmap *map;
+	u32 offset;
+	u32 mask;
+	bool state;
+};
+
+static void syscon_led_set(struct led_classdev *led_cdev,
+	enum led_brightness value)
+{
+	struct syscon_led *sled =
+		container_of(led_cdev, struct syscon_led, cdev);
+	u32 val;
+	int ret;
+
+	if (value == LED_OFF) {
+		val = 0;
+		sled->state = false;
+	} else {
+		val = sled->mask;
+		sled->state = true;
+	}
+
+	ret = regmap_update_bits(sled->map, sled->offset, sled->mask, val);
+	if (ret < 0)
+		dev_err(sled->cdev.dev, "error updating LED status\n");
+}
+
+static const struct of_device_id syscon_match[] = {
+	{ .compatible = "syscon", },
+};
+
+static int __init syscon_leds_init(void)
+{
+	const struct of_device_id *devid;
+	struct device_node *np;
+	struct device_node *child;
+	struct regmap *map;
+	struct platform_device *pdev;
+	struct device *dev;
+	int ret;
+
+	np = of_find_matching_node_and_match(NULL, syscon_match,
+					     &devid);
+	if (!np)
+		return -ENODEV;
+
+	map = syscon_node_to_regmap(np);
+	if (IS_ERR(map))
+		return PTR_ERR(map);
+
+	/*
+	 * If the map is there, the device should be there, we allocate
+	 * memory on the syscon device's behalf here.
+	 */
+	pdev = of_find_device_by_node(np);
+	if (!pdev)
+		return -ENODEV;
+	dev = &pdev->dev;
+
+	for_each_available_child_of_node(np, child) {
+		struct syscon_led *sled;
+		const char *state;
+
+		/* Only check for register-bit-leds */
+		if (of_property_match_string(child, "compatible",
+					     "register-bit-led") < 0)
+			continue;
+
+		sled = devm_kzalloc(dev, sizeof(*sled), GFP_KERNEL);
+		if (!sled)
+			return -ENOMEM;
+
+		sled->map = map;
+
+		if (of_property_read_u32(child, "offset", &sled->offset))
+			return -EINVAL;
+		if (of_property_read_u32(child, "mask", &sled->mask))
+			return -EINVAL;
+		sled->cdev.name =
+			of_get_property(child, "label", NULL) ? : child->name;
+		sled->cdev.default_trigger =
+			of_get_property(child, "linux,default-trigger", NULL);
+
+		state = of_get_property(child, "default-state", NULL);
+		if (state) {
+			if (!strcmp(state, "keep")) {
+				u32 val;
+
+				ret = regmap_read(map, sled->offset, &val);
+				if (ret < 0)
+					return ret;
+				sled->state = !!(val & sled->mask);
+			} else if (!strcmp(state, "on")) {
+				sled->state = true;
+				ret = regmap_update_bits(map, sled->offset,
+							 sled->mask,
+							 sled->mask);
+				if (ret < 0)
+					return ret;
+			} else {
+				sled->state = false;
+				ret = regmap_update_bits(map, sled->offset,
+							 sled->mask, 0);
+				if (ret < 0)
+					return ret;
+			}
+
+		}
+		sled->cdev.brightness_set = syscon_led_set;
+
+		ret = led_classdev_register(dev, &sled->cdev);
+		if (ret < 0)
+			return ret;
+
+		dev_info(dev, "registered LED %s\n", sled->cdev.name);
+	}
+
+       return 0;
+}
+device_initcall(syscon_leds_init);
-- 
1.9.3
