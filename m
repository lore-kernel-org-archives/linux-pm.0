From: Len Brown <lenb@kernel.org>
Subject: [PATCH 19/52] drivers/thermal/spear_thermal.c: add Device Tree probing capability
Date: Tue, 24 Jul 2012 23:41:15 -0400
Message-ID: <b9c7aff481f19dd655ae3ce6513817d625e2d47c.1343187617.git.len.brown@intel.com>
References: <1343187708-19532-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1343187708-19532-1-git-send-email-lenb@kernel.org>
In-Reply-To: <6af1c4fc5227af65092ebc848989693562bfa3e8.1343187617.git.len.brown@intel.com>
References: <6af1c4fc5227af65092ebc848989693562bfa3e8.1343187617.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Viresh Kumar <viresh.linux@gmail.com>, Viresh Kumar <viresh.kumar@st.com>, Dan Carpenter <dan.carpenter@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Viresh Kumar <viresh.linux@gmail.com>

SPEAr platforms now support DT and so must convert all drivers to support
DT.  This patch adds DT probing support for SPEAr thermal sensor driver
and updates its documentation too.

Also, as SPEAr is the only user of this driver and is only available with
DT, make this an only DT driver.  So, platform_data is completely removed
and passed via DT now.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Vincenzo Frascino <vincenzo.frascino@st.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 .../devicetree/bindings/thermal/spear-thermal.txt  | 14 ++++++++++++
 drivers/thermal/Kconfig                            |  1 +
 drivers/thermal/spear_thermal.c                    | 26 +++++++++++++---------
 include/linux/platform_data/spear_thermal.h        | 26 ----------------------
 4 files changed, 31 insertions(+), 36 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/spear-thermal.txt
 delete mode 100644 include/linux/platform_data/spear_thermal.h

diff --git a/Documentation/devicetree/bindings/thermal/spear-thermal.txt b/Documentation/devicetree/bindings/thermal/spear-thermal.txt
new file mode 100644
index 0000000..93e3b67
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/spear-thermal.txt
@@ -0,0 +1,14 @@
+* SPEAr Thermal
+
+Required properties:
+- compatible : "st,thermal-spear1340"
+- reg : Address range of the thermal registers
+- st,thermal-flags: flags used to enable thermal sensor
+
+Example:
+
+	thermal@fc000000 {
+		compatible = "st,thermal-spear1340";
+		reg = <0xfc000000 0x1000>;
+		st,thermal-flags = <0x7000>;
+	};
diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 514a691..3ab2bd5 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -23,6 +23,7 @@ config SPEAR_THERMAL
 	bool "SPEAr thermal sensor driver"
 	depends on THERMAL
 	depends on PLAT_SPEAR
+	depends on OF
 	help
 	  Enable this to plug the SPEAr thermal sensor driver into the Linux
 	  thermal framework
diff --git a/drivers/thermal/spear_thermal.c b/drivers/thermal/spear_thermal.c
index c2e32df..ca40d36 100644
--- a/drivers/thermal/spear_thermal.c
+++ b/drivers/thermal/spear_thermal.c
@@ -20,9 +20,9 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/of.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
-#include <linux/platform_data/spear_thermal.h>
 #include <linux/thermal.h>
 
 #define MD_FACTOR	1000
@@ -103,21 +103,20 @@ static int spear_thermal_probe(struct platform_device *pdev)
 {
 	struct thermal_zone_device *spear_thermal = NULL;
 	struct spear_thermal_dev *stdev;
-	struct spear_thermal_pdata *pdata;
-	int ret = 0;
+	struct device_node *np = pdev->dev.of_node;
 	struct resource *stres = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	int ret = 0, val;
+
+	if (!np || !of_property_read_u32(np, "st,thermal-flags", &val)) {
+		dev_err(&pdev->dev, "Failed: DT Pdata not passed\n");
+		return -EINVAL;
+	}
 
 	if (!stres) {
 		dev_err(&pdev->dev, "memory resource missing\n");
 		return -ENODEV;
 	}
 
-	pdata = dev_get_platdata(&pdev->dev);
-	if (!pdata) {
-		dev_err(&pdev->dev, "platform data is NULL\n");
-		return -EINVAL;
-	}
-
 	stdev = devm_kzalloc(&pdev->dev, sizeof(*stdev), GFP_KERNEL);
 	if (!stdev) {
 		dev_err(&pdev->dev, "kzalloc fail\n");
@@ -144,7 +143,7 @@ static int spear_thermal_probe(struct platform_device *pdev)
 		goto put_clk;
 	}
 
-	stdev->flags = pdata->thermal_flags;
+	stdev->flags = val;
 	writel_relaxed(stdev->flags, stdev->thermal_base);
 
 	spear_thermal = thermal_zone_device_register("spear_thermal", 0,
@@ -189,6 +188,12 @@ static int spear_thermal_exit(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id spear_thermal_id_table[] = {
+	{ .compatible = "st,thermal-spear1340" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, spear_thermal_id_table);
+
 static struct platform_driver spear_thermal_driver = {
 	.probe = spear_thermal_probe,
 	.remove = spear_thermal_exit,
@@ -196,6 +201,7 @@ static struct platform_driver spear_thermal_driver = {
 		.name = "spear_thermal",
 		.owner = THIS_MODULE,
 		.pm = &spear_thermal_pm_ops,
+		.of_match_table = of_match_ptr(spear_thermal_id_table),
 	},
 };
 
diff --git a/include/linux/platform_data/spear_thermal.h b/include/linux/platform_data/spear_thermal.h
deleted file mode 100644
index 724f2e1..0000000
--- a/include/linux/platform_data/spear_thermal.h
+++ /dev/null
@@ -1,26 +0,0 @@
-/*
- * SPEAr thermal driver platform data.
- *
- * Copyright (C) 2011-2012 ST Microelectronics
- * Author: Vincenzo Frascino <vincenzo.frascino@st.com>
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- */
-#ifndef SPEAR_THERMAL_H
-#define SPEAR_THERMAL_H
-
-/* SPEAr Thermal Sensor Platform Data */
-struct spear_thermal_pdata {
-	/* flags used to enable thermal sensor */
-	unsigned int thermal_flags;
-};
-
-#endif /* SPEAR_THERMAL_H */
-- 
1.7.12.rc0
