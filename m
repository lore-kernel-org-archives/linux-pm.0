From: Jonghwa Lee <jonghwa3.lee@samsung.com>
Subject: [PATCH 3/3] devfreq: exynos4_bus: Support DT in exynos4 busfreq driver.
Date: Wed, 11 Jun 2014 10:17:56 +0900
Message-ID: <1402449476-6782-4-git-send-email-jonghwa3.lee@samsung.com>
References: <1402449476-6782-1-git-send-email-jonghwa3.lee@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:61587 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753119AbaFKBSP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 10 Jun 2014 21:18:15 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N6Z00HRNCY0V4C0@mailout4.samsung.com> for
 linux-pm@vger.kernel.org; Wed, 11 Jun 2014 10:18:00 +0900 (KST)
In-reply-to: <1402449476-6782-1-git-send-email-jonghwa3.lee@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, cw00.choi@samsung.com, Jonghwa Lee <jonghwa3.lee@samsung.com>

This patch makes exynos4 busfreq driver to use DeviceTree.

This patch includes creation of DT binding documentation directory for
devfreq and exynos4_bus driver's description.

Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Myungjoo Ham <myungjoo.ham@samsung.com>
---
 .../devicetree/bindings/devfreq/exynos4_bus.txt    |   19 +++++++++++++
 drivers/devfreq/exynos/exynos4_bus.c               |   30 ++++++++++++++++----
 2 files changed, 44 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/devfreq/exynos4_bus.txt

diff --git a/Documentation/devicetree/bindings/devfreq/exynos4_bus.txt b/Documentation/devicetree/bindings/devfreq/exynos4_bus.txt
new file mode 100644
index 0000000..5a65001
--- /dev/null
+++ b/Documentation/devicetree/bindings/devfreq/exynos4_bus.txt
@@ -0,0 +1,19 @@
+Exynos4 busfreq bindings
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+Require properties:
+- compatible	: "samsung,exynos4210-busfreq";
+		  "samsung,exynos4x12-busfreq";
+- reg		: Memory range for PPMU IP block's SFR region.
+- clocks	: Source clocks for PPMU blocks;
+		  Currently, driver needs two ppmu clks for dmc0, dmc1.
+- clock-names	: PPMU clock's lookup name;
+
+Examples:
+	busfreq@0 {
+		compatible = "samsung,exynos4x12-busfreq";
+		reg = <0x106A0000 0x2000>, <0x106B0000 0x2000>;
+		clocks = <&clock 412>, <&clock 413>;
+		clock-names = "ppmudmc0", "ppmudmc1";
+	};
+ };
diff --git a/drivers/devfreq/exynos/exynos4_bus.c b/drivers/devfreq/exynos/exynos4_bus.c
index 7c5e940..e2514b7 100644
--- a/drivers/devfreq/exynos/exynos4_bus.c
+++ b/drivers/devfreq/exynos/exynos4_bus.c
@@ -16,16 +16,13 @@
  */
 
 #include <linux/io.h>
-#include <linux/slab.h>
 #include <linux/mutex.h>
 #include <linux/suspend.h>
-#include <linux/pm_opp.h>
 #include <linux/devfreq.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 #include <linux/module.h>
-#include <linux/clk.h>
-#include <linux/io.h>
+#include <linux/of.h>
 
 #include "exynos_ppmu.h"
 #include "exynos4_bus.h"
@@ -895,6 +892,22 @@ unlock:
 	return NOTIFY_DONE;
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id exynos4_busfreq_match[] = {
+	{
+		.compatible = "samsung,exynos4210-busfreq",
+		.data = (void *)TYPE_BUSF_EXYNOS4210,
+	},
+	{
+		.compatible = "samsung,exynos4x12-busfreq",
+		.data = (void *)TYPE_BUSF_EXYNOS4x12,
+	},
+};
+MODULE_DEVICE_TABLE(of, exynos4_busfreq_match[]);
+#else
+#define exynos4_busfreq_match	NULL
+#endif
+
 static int exynos4_busfreq_probe(struct platform_device *pdev)
 {
 	struct busfreq_data *data;
@@ -919,7 +932,13 @@ static int exynos4_busfreq_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	data->type = pdev->id_entry->driver_data;
+	if (dev->of_node) {
+		const struct of_device_id *match;
+		match = of_match_node(exynos4_busfreq_match, dev->of_node);
+		data->type = (int) match->data;
+	} else {
+		data->type = pdev->id_entry->driver_data;
+	}
 
 	/*  Allocate MMIO region for PPMU SFRs */
 	for (i = 0; i < PPMU_END; i++) {
@@ -1075,6 +1094,7 @@ static struct platform_driver exynos4_busfreq_driver = {
 		.name	= "exynos4-busfreq",
 		.owner	= THIS_MODULE,
 		.pm	= &exynos4_busfreq_pm_ops,
+		.of_match_table = of_match_ptr(exynos4_busfreq_match),
 	},
 };
 
-- 
1.7.9.5

