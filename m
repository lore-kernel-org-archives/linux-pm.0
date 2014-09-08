From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 4/7 v6] soc: add driver for the ARM RealView
Date: Mon,  8 Sep 2014 13:38:03 +0200
Message-ID: <1410176286-32533-5-git-send-email-linus.walleij@linaro.org>
References: <1410176286-32533-1-git-send-email-linus.walleij@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1410176286-32533-1-git-send-email-linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

This adds a SoC driver to be used by the ARM RealView
reference boards. We create the "versatile" directory to hold
the different ARM reference designs as per the pattern of the
clk directory layout. The driver utilze the syscon to get to
the register needed. After this we can use sysfs to get at
some SoC properties on RealView DT variants like this:

> cd /sysbus/soc/devices/soc0
> ls
board         family        machine       power         subsystem
build         fpga          manufacturer  soc_id        uevent
> cat family
Versatile
> cat fpga
Multi-layer AXI
> cat board
HBI-0147
> cat build
03

Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/soc/Kconfig                  |   1 +
 drivers/soc/Makefile                 |   1 +
 drivers/soc/versatile/Kconfig        |  10 +++
 drivers/soc/versatile/Makefile       |   1 +
 drivers/soc/versatile/soc-realview.c | 144 +++++++++++++++++++++++++++++++++++
 5 files changed, 157 insertions(+)
 create mode 100644 drivers/soc/versatile/Kconfig
 create mode 100644 drivers/soc/versatile/Makefile
 create mode 100644 drivers/soc/versatile/soc-realview.c

diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
index c8543855aa82..6ed3590253cf 100644
--- a/drivers/soc/Kconfig
+++ b/drivers/soc/Kconfig
@@ -1,5 +1,6 @@
 menu "SOC (System On Chip) specific Drivers"
 
 source "drivers/soc/qcom/Kconfig"
+source "drivers/soc/versatile/Kconfig"
 
 endmenu
diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 3b1b95d932d1..d20d8f625732 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -4,3 +4,4 @@
 
 obj-$(CONFIG_ARCH_QCOM)		+= qcom/
 obj-$(CONFIG_ARCH_TEGRA)	+= tegra/
+obj-$(CONFIG_PLAT_VERSATILE)	+= versatile/
diff --git a/drivers/soc/versatile/Kconfig b/drivers/soc/versatile/Kconfig
new file mode 100644
index 000000000000..bf5ee9c85330
--- /dev/null
+++ b/drivers/soc/versatile/Kconfig
@@ -0,0 +1,10 @@
+#
+# ARM Versatile SoC drivers
+#
+config SOC_REALVIEW
+	bool "SoC bus device for the ARM RealView platforms"
+	depends on ARCH_REALVIEW
+	select SOC_BUS
+	help
+	  Include support for the SoC bus on the ARM RealView platforms
+	  providing some sysfs information about the ASIC variant.
diff --git a/drivers/soc/versatile/Makefile b/drivers/soc/versatile/Makefile
new file mode 100644
index 000000000000..ad547435648e
--- /dev/null
+++ b/drivers/soc/versatile/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_SOC_REALVIEW)	+= soc-realview.o
diff --git a/drivers/soc/versatile/soc-realview.c b/drivers/soc/versatile/soc-realview.c
new file mode 100644
index 000000000000..cea8ea3491d2
--- /dev/null
+++ b/drivers/soc/versatile/soc-realview.c
@@ -0,0 +1,144 @@
+/*
+ * Copyright (C) 2014 Linaro Ltd.
+ *
+ * Author: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2, as
+ * published by the Free Software Foundation.
+ *
+ */
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/slab.h>
+#include <linux/sys_soc.h>
+#include <linux/platform_device.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
+#include <linux/of.h>
+
+/* System ID in syscon */
+#define REALVIEW_SYS_ID_OFFSET 0x00
+
+static const struct of_device_id realview_soc_of_match[] = {
+	{ .compatible = "arm,realview-eb-soc",	},
+	{ .compatible = "arm,realview-pb1176-soc", },
+	{ .compatible = "arm,realview-pb11mp-soc", },
+	{ .compatible = "arm,realview-pba8-soc", },
+	{ .compatible = "arm,realview-pbx-soc", },
+};
+
+static u32 realview_coreid;
+
+static const char *realview_board_str(u32 id)
+{
+	switch ((id >> 16) & 0xfff) {
+	case 0x0147:
+		return "HBI-0147";
+	default:
+		return "Unknown";
+	}
+}
+
+static const char *realview_arch_str(u32 id)
+{
+	switch ((id >> 8) & 0xf) {
+	case 0x05:
+		return "Multi-layer AXI";
+	default:
+		return "Unknown";
+	}
+}
+
+static ssize_t realview_get_manf(struct device *dev,
+			      struct device_attribute *attr,
+			      char *buf)
+{
+	return sprintf(buf, "%02x\n", realview_coreid >> 24);
+}
+
+static struct device_attribute realview_manf_attr =
+	__ATTR(manufacturer,  S_IRUGO, realview_get_manf,  NULL);
+
+static ssize_t realview_get_board(struct device *dev,
+			      struct device_attribute *attr,
+			      char *buf)
+{
+	return sprintf(buf, "%s\n", realview_board_str(realview_coreid));
+}
+
+static struct device_attribute realview_board_attr =
+	__ATTR(board,  S_IRUGO, realview_get_board,  NULL);
+
+static ssize_t realview_get_arch(struct device *dev,
+			      struct device_attribute *attr,
+			      char *buf)
+{
+	return sprintf(buf, "%s\n", realview_arch_str(realview_coreid));
+}
+
+static struct device_attribute realview_arch_attr =
+	__ATTR(fpga,  S_IRUGO, realview_get_arch,  NULL);
+
+static ssize_t realview_get_build(struct device *dev,
+			       struct device_attribute *attr,
+			       char *buf)
+{
+	return sprintf(buf, "%02x\n", (realview_coreid & 0xFF));
+}
+
+static struct device_attribute realview_build_attr =
+	__ATTR(build,  S_IRUGO, realview_get_build,  NULL);
+
+static int realview_soc_probe(struct platform_device *pdev)
+{
+	static struct regmap *syscon_regmap;
+	struct soc_device *soc_dev;
+	struct soc_device_attribute *soc_dev_attr;
+	struct device_node *np = pdev->dev.of_node;
+	int ret;
+
+	syscon_regmap = syscon_regmap_lookup_by_phandle(np, "regmap");
+	if (IS_ERR(syscon_regmap))
+		return PTR_ERR(syscon_regmap);
+
+	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
+	if (!soc_dev_attr)
+		return -ENOMEM;
+
+	ret = of_property_read_string(np, "compatible",
+				      &soc_dev_attr->soc_id);
+	if (ret)
+		return -EINVAL;
+
+	soc_dev_attr->machine = "RealView";
+	soc_dev_attr->family = "Versatile";
+	soc_dev = soc_device_register(soc_dev_attr);
+	if (IS_ERR(soc_dev)) {
+		kfree(soc_dev_attr);
+		return -ENODEV;
+	}
+	ret = regmap_read(syscon_regmap, REALVIEW_SYS_ID_OFFSET,
+			  &realview_coreid);
+	if (ret)
+		return -ENODEV;
+
+	device_create_file(soc_device_to_device(soc_dev), &realview_manf_attr);
+	device_create_file(soc_device_to_device(soc_dev), &realview_board_attr);
+	device_create_file(soc_device_to_device(soc_dev), &realview_arch_attr);
+	device_create_file(soc_device_to_device(soc_dev), &realview_build_attr);
+
+	dev_info(&pdev->dev, "RealView Syscon Core ID: 0x%08x\n",
+		 realview_coreid);
+	/* FIXME: add attributes for SoC to sysfs */
+	return 0;
+}
+
+static struct platform_driver realview_soc_driver = {
+	.probe = realview_soc_probe,
+	.driver = {
+		.name = "realview-soc",
+		.of_match_table = realview_soc_of_match,
+	},
+};
+module_platform_driver(realview_soc_driver);
-- 
1.9.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
