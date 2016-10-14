From: Xiaogang Cui <xiaogang@codeaurora.org>
Subject: [PATCH 1/2] power: reset: Add qcom reboot mode driver
Date: Fri, 14 Oct 2016 10:02:27 +0800
Message-ID: <1476410823-8912-1-git-send-email-xiaogang@codeaurora.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:39206 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752376AbcJNCQj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Oct 2016 22:16:39 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: andy.gross@linaro.org
Cc: Xiaogang Cui <xiaogang@codeaurora.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Krzysztof Kozlowski <krzk@kernel.org>, Andy Yan <andy.yan@rock-chips.com>, John Stultz <john.stultz@linaro.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Chris Brand <chris.brand@broadcom.com>, Richard Weinberger <richard@nod.at>, Moritz Fischer <moritz.fischer@ettus.com>, Florian Fainelli <f.fainelli@gmail.com>, "open list:POWER SUPPLY CLASS/SUBSYSTEM and
        DRIVERS" <linux-pm@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED" <devicetree@vger.kernel.org>

This is a initial version so it's very similar with syscon
reboot mode driver. We will add more functionalities in the
further after dependency is ready.

Signed-off-by: Xiaogang Cui <xiaogang@codeaurora.org>
---
 .../bindings/power_supply/qcom-reboot-mode.txt     |  23 +++++
 drivers/power/reset/Kconfig                        |  10 ++
 drivers/power/reset/Makefile                       |   1 +
 drivers/power/reset/qcom-reboot-mode.c             | 109 +++++++++++++++++++++
 4 files changed, 143 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power_supply/qcom-reboot-mode.txt
 create mode 100644 drivers/power/reset/qcom-reboot-mode.c

diff --git a/Documentation/devicetree/bindings/power_supply/qcom-reboot-mode.txt b/Documentation/devicetree/bindings/power_supply/qcom-reboot-mode.txt
new file mode 100644
index 0000000..8b33592
--- /dev/null
+++ b/Documentation/devicetree/bindings/power_supply/qcom-reboot-mode.txt
@@ -0,0 +1,23 @@
+Qualcomm Reboot Mode Driver
+
+Qualcomm reboot mode driver based on reboot mode framework to update
+SPMI specific bits.
+
+Required Properties:
+-compatible: "qcom,reboot-mode"
+-offset: offset of the SPMI reboot mode register
+
+Optional Properties:
+-mask: mask of reboot mode
+-mode-xxx: magic of reboot mode
+
+Example:
+	qcom,reboot-mode@88f {
+		compatible = "qcom,reboot-mode";
+		offset = <0x88f>;
+		mode-normal = <0x00>;
+		mode-recovery = <0x04>;
+		mode-bootloader = <0x08>;
+		mode-rtc = <0x0C>;
+	};
+
diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index c74c3f6..bdcf6d3f 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -208,5 +208,15 @@ config SYSCON_REBOOT_MODE
 	  register, then the bootloader can read it to take different
 	  action according to the mode.
 
+config QCOM_REBOOT_MODE
+	tristate "Qualcomm reboot mode driver"
+	depends on MFD_SPMI_PMIC
+	select REBOOT_MODE
+	help
+	  Say y here will enable Qualcomm reboot mode driver. This will
+	  get reboot mode arguments and store it in SPMI PMIC register,
+	  then the bootloader can read it to take different action
+	  according to the mode.
+
 endif
 
diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
index 1be307c..06e010f 100644
--- a/drivers/power/reset/Makefile
+++ b/drivers/power/reset/Makefile
@@ -24,3 +24,4 @@ obj-$(CONFIG_POWER_RESET_RMOBILE) += rmobile-reset.o
 obj-$(CONFIG_POWER_RESET_ZX) += zx-reboot.o
 obj-$(CONFIG_REBOOT_MODE) += reboot-mode.o
 obj-$(CONFIG_SYSCON_REBOOT_MODE) += syscon-reboot-mode.o
+obj-$(CONFIG_QCOM_REBOOT_MODE) += qcom-reboot-mode.o
diff --git a/drivers/power/reset/qcom-reboot-mode.c b/drivers/power/reset/qcom-reboot-mode.c
new file mode 100644
index 0000000..37bb635
--- /dev/null
+++ b/drivers/power/reset/qcom-reboot-mode.c
@@ -0,0 +1,109 @@
+/* Copyright (c) 2016, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/reboot.h>
+#include <linux/regmap.h>
+#include "reboot-mode.h"
+
+struct qcom_reboot_mode {
+	struct regmap *map;
+	struct reboot_mode_driver reboot;
+	u32 offset;
+	u32 mask;
+};
+
+static int qcom_reboot_mode_write(struct reboot_mode_driver *reboot,
+				    unsigned int magic)
+{
+	struct qcom_reboot_mode *qrm;
+	int ret;
+
+	qrm = container_of(reboot, struct qcom_reboot_mode, reboot);
+
+	/* update reboot magic */
+	ret = regmap_update_bits(qrm->map, qrm->offset, qrm->mask, magic);
+	if (ret < 0) {
+		dev_err(reboot->dev, "Failed to update reboot mode bits\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int qcom_reboot_mode_probe(struct platform_device *pdev)
+{
+	struct qcom_reboot_mode *qrm;
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	qrm = devm_kzalloc(&pdev->dev, sizeof(*qrm), GFP_KERNEL);
+	if (!qrm)
+		return -ENOMEM;
+
+	qrm->reboot.dev = dev;
+	qrm->reboot.write = qcom_reboot_mode_write;
+	qrm->mask = 0xffffffff;
+
+	qrm->map = dev_get_regmap(dev->parent, NULL);
+	if (IS_ERR_OR_NULL(qrm->map))
+		return -EINVAL;
+
+	if (of_property_read_u32(dev->of_node, "offset", &qrm->offset))
+		return -EINVAL;
+
+	of_property_read_u32(dev->of_node, "mask", &qrm->mask);
+
+	ret = reboot_mode_register(&qrm->reboot);
+	if (ret)
+		dev_err(dev, "Failed to register reboot mode\n");
+
+	dev_set_drvdata(dev, qrm);
+	return ret;
+}
+
+static int qcom_reboot_mode_remove(struct platform_device *pdev)
+{
+	struct qcom_reboot_mode *qrm;
+
+	qrm = dev_get_drvdata(&pdev->dev);
+	return reboot_mode_unregister(&qrm->reboot);
+}
+
+static const struct of_device_id of_qcom_reboot_mode_match[] = {
+	{ .compatible = "qcom,reboot-mode" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, of_qcom_reboot_mode_match);
+
+static struct platform_driver qcom_reboot_mode_driver = {
+	.probe = qcom_reboot_mode_probe,
+	.remove = qcom_reboot_mode_remove,
+	.driver = {
+		.name = "qcom-reboot-mode",
+		.of_match_table = of_match_ptr(of_qcom_reboot_mode_match),
+	},
+};
+
+static int __init qcom_reboot_mode_init(void)
+{
+	return platform_driver_register(&qcom_reboot_mode_driver);
+}
+device_initcall(qcom_reboot_mode_init);
+
+MODULE_DESCRIPTION("QCOM Reboot Mode Driver");
+MODULE_LICENSE("GPL v2");
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

