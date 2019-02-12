From: Virendra Kakade <virendra.kakade@ni.com>
Subject: [RFC 2/6] mfd: Support for Ettus Research E31x devices PMU
Date: Mon, 11 Feb 2019 19:01:39 -0600
Message-ID: <20190212010143.3729-3-virendra.kakade@ni.com>
References: <20190212010143.3729-1-virendra.kakade@ni.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190212010143.3729-1-virendra.kakade@ni.com>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, sre@kernel.org, moritz.fischer@ettus.com, Virendra Kakade <virendra.kakade@ni.com>
List-Id: linux-pm@vger.kernel.org

Signed-off-by: Virendra Kakade <virendra.kakade@ni.com>
---
 drivers/mfd/Kconfig          |  7 +++
 drivers/mfd/Makefile         |  2 +-
 drivers/mfd/e31x-pmu.c       | 89 ++++++++++++++++++++++++++++++++++++
 include/linux/mfd/e31x-pmu.h | 20 ++++++++
 4 files changed, 117 insertions(+), 1 deletion(-)
 create mode 100644 drivers/mfd/e31x-pmu.c
 create mode 100644 include/linux/mfd/e31x-pmu.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 8c5dfdce4326..6c4c0747f2a5 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1916,4 +1916,11 @@ config RAVE_SP_CORE
 	  device found on several devices in RAVE line of hardware.
 
 endmenu
+
+config MFD_E31X_PMU
+	tristate "E31X PMU driver"
+	select MFD_SYSCON
+	help
+	 Select this to get support for the Ettus Research E31x devices.
+
 endif
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 12980a4ad460..e37c2057134b 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -241,4 +241,4 @@ obj-$(CONFIG_MFD_MXS_LRADC)     += mxs-lradc.o
 obj-$(CONFIG_MFD_SC27XX_PMIC)	+= sprd-sc27xx-spi.o
 obj-$(CONFIG_RAVE_SP_CORE)	+= rave-sp.o
 obj-$(CONFIG_MFD_ROHM_BD718XX)	+= rohm-bd718x7.o
-
+obj-$(CONFIG_MFD_E31X_PMU)      += e31x-pmu.o
diff --git a/drivers/mfd/e31x-pmu.c b/drivers/mfd/e31x-pmu.c
new file mode 100644
index 000000000000..383df68a538f
--- /dev/null
+++ b/drivers/mfd/e31x-pmu.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018 National Instruments Corp
+ * Author: Virendra Kakade <virendra.kakade@ni.com>
+ *
+ * Ettus Research E31x PMU MFD driver
+ */
+
+#include <linux/err.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/mfd/core.h>
+#include <linux/of_device.h>
+#include <linux/mfd/e31x-pmu.h>
+#include <linux/platform_device.h>
+
+#define E31X_PMU_MISC_IRQ_MASK		BIT(8)
+#define E31X_PMU_MISC_IRQ_SHIFT		8
+#define E31X_PMU_MISC_VERSION_MIN_MASK	GENMASK(3, 0)
+#define E31X_PMU_MISC_VERSION_MIN_SHIFT	0
+#define E31X_PMU_MISC_VERSION_MAJ_MASK	GENMASK(7, 4)
+#define E31X_PMU_MISC_VERSION_MAJ_SHIFT	4
+
+struct e31x_pmu {
+	struct regmap *regmap;
+};
+
+static int e31x_pmu_check_version(struct e31x_pmu *pmu)
+{
+	int timeout = 100;
+	u32 misc, maj;
+	int err;
+	/* we need to wait a bit for firmware to populate the fields */
+	while (timeout--) {
+		err = regmap_read(pmu->regmap, E31X_PMU_REG_MISC, &misc);
+		if (err)
+			return err;
+		if (misc)
+			break;
+
+	usleep_range(2500, 5000);
+	}
+
+	/* only firmware versions above 2.0 are supported */
+	maj = E31X_PMU_GET_FIELD(MISC_VERSION_MAJ, misc);
+	if (maj < 2)
+		return -ENOTSUPP;
+	return 0;
+}
+
+static int e31x_pmu_probe(struct platform_device *pdev)
+{
+	struct e31x_pmu *pmu;
+
+	pmu = devm_kzalloc(&pdev->dev, sizeof(*pmu), GFP_KERNEL);
+	if (!pmu)
+		return -ENOMEM;
+	pmu->regmap = syscon_regmap_lookup_by_phandle(\
+			pdev->dev.of_node, "regmap");
+
+	if (IS_ERR(pmu->regmap))
+		return PTR_ERR(pmu->regmap);
+	if (e31x_pmu_check_version(pmu))
+		return -ENOTSUPP;
+	return devm_of_platform_populate(&pdev->dev);
+}
+
+static const struct of_device_id e31x_pmu_id[] = {
+	{ .compatible = "ni,e31x-pmu" },
+	{},
+};
+
+static struct platform_driver e31x_pmu_driver = {
+	.driver = {
+	.name = "e31x-pmu",
+	.of_match_table = e31x_pmu_id,
+	},
+	.probe = e31x_pmu_probe,
+};
+module_platform_driver(e31x_pmu_driver);
+
+MODULE_DESCRIPTION("E31x PMU driver");
+MODULE_AUTHOR("Virendra Kakade <virendra.kakade@ni.com>");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/mfd/e31x-pmu.h b/include/linux/mfd/e31x-pmu.h
new file mode 100644
index 000000000000..c57d5a8c1aad
--- /dev/null
+++ b/include/linux/mfd/e31x-pmu.h
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018 National Instruments Corp
+ * Author: Virendra Kakade <virendra.kakade@ni.com>
+ *
+ * Ettus Research E31x PMU constants
+ */
+
+#ifndef MFD_E31X_PMU_H
+#define MFD_E31X_PMU_H
+
+#include <linux/bitops.h>
+
+#define E31X_PMU_REG_MISC      0x04
+
+#define E31X_PMU_GET_FIELD(name, reg) \
+	(((reg) & E31X_PMU_## name ##_MASK) >> \
+	E31X_PMU_## name ##_SHIFT)
+
+#endif /* MFD_E31X_PMU_H */
-- 
2.17.1
