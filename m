From: Mikko Perttunen <mikko.perttunen-/1wQRMveznE@public.gmane.org>
Subject: [PATCH v8 07/18] clk: tegra: Add Tegra124 DFLL clocksource platform driver
Date: Sun,  1 Mar 2015 14:44:30 +0200
Message-ID: <1425213881-5262-8-git-send-email-mikko.perttunen@kapsi.fi>
References: <1425213881-5262-1-git-send-email-mikko.perttunen@kapsi.fi>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1425213881-5262-1-git-send-email-mikko.perttunen-/1wQRMveznE@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, pwalmsley-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, pgaikwad-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, tuomas.tynkkynen-X3B1VOXEql0@public.gmane.org, Tuomas Tynkkynen <ttynkkynen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mikko Perttunen <mikko.perttunen-/1wQRMveznE@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

From: Tuomas Tynkkynen <ttynkkynen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Add basic platform driver support for the fast CPU cluster DFLL
clocksource found on Tegra124 SoCs. This small driver selects the
appropriate Tegra124-specific characterization data and integration
code. It relies on the DFLL common code to do most of the work.

Signed-off-by: Tuomas Tynkkynen <ttynkkynen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Mikko Perttunen <mikko.perttunen-/1wQRMveznE@public.gmane.org>
---
v8:
- Removed non-standard dvco reset handlers

 drivers/clk/tegra/Makefile                 |   2 +
 drivers/clk/tegra/clk-tegra124-dfll-fcpu.c | 163 +++++++++++++++++++++++++++++
 2 files changed, 165 insertions(+)
 create mode 100644 drivers/clk/tegra/clk-tegra124-dfll-fcpu.c

diff --git a/drivers/clk/tegra/Makefile b/drivers/clk/tegra/Makefile
index 881c56e..f5fd226 100644
--- a/drivers/clk/tegra/Makefile
+++ b/drivers/clk/tegra/Makefile
@@ -16,4 +16,6 @@ obj-$(CONFIG_ARCH_TEGRA_2x_SOC)         += clk-tegra20.o
 obj-$(CONFIG_ARCH_TEGRA_3x_SOC)         += clk-tegra30.o
 obj-$(CONFIG_ARCH_TEGRA_114_SOC)	+= clk-tegra114.o
 obj-$(CONFIG_ARCH_TEGRA_124_SOC)	+= clk-tegra124.o
+obj-$(CONFIG_ARCH_TEGRA_124_SOC)	+= clk-tegra124-dfll-fcpu.o
 obj-$(CONFIG_ARCH_TEGRA_132_SOC)	+= clk-tegra124.o
+obj-y					+= cvb.o
diff --git a/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c b/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
new file mode 100644
index 0000000..5f95912
--- /dev/null
+++ b/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
@@ -0,0 +1,163 @@
+/*
+ * Tegra124 DFLL FCPU clock source driver
+ *
+ * Copyright (C) 2012-2014 NVIDIA Corporation.  All rights reserved.
+ *
+ * Aleksandr Frid <afrid-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
+ * Paul Walmsley <pwalmsley-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/cpu.h>
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <soc/tegra/fuse.h>
+
+#include "clk.h"
+#include "clk-dfll.h"
+#include "cvb.h"
+
+/* Maximum CPU frequency, indexed by CPU speedo id */
+static const unsigned long cpu_max_freq_table[] = {
+	[0] = 2014500000UL,
+	[1] = 2320500000UL,
+	[2] = 2116500000UL,
+	[3] = 2524500000UL,
+};
+
+static const struct cvb_table tegra124_cpu_cvb_tables[] = {
+	{
+		.speedo_id = -1,
+		.process_id = -1,
+		.min_millivolts = 900,
+		.max_millivolts = 1260,
+		.alignment = {
+			.step_uv = 10000, /* 10mV */
+		},
+		.speedo_scale = 100,
+		.voltage_scale = 1000,
+		.cvb_table = {
+			{204000000UL,   {1112619, -29295, 402} },
+			{306000000UL,	{1150460, -30585, 402} },
+			{408000000UL,	{1190122, -31865, 402} },
+			{510000000UL,	{1231606, -33155, 402} },
+			{612000000UL,	{1274912, -34435, 402} },
+			{714000000UL,	{1320040, -35725, 402} },
+			{816000000UL,	{1366990, -37005, 402} },
+			{918000000UL,	{1415762, -38295, 402} },
+			{1020000000UL,	{1466355, -39575, 402} },
+			{1122000000UL,	{1518771, -40865, 402} },
+			{1224000000UL,	{1573009, -42145, 402} },
+			{1326000000UL,	{1629068, -43435, 402} },
+			{1428000000UL,	{1686950, -44715, 402} },
+			{1530000000UL,	{1746653, -46005, 402} },
+			{1632000000UL,	{1808179, -47285, 402} },
+			{1734000000UL,	{1871526, -48575, 402} },
+			{1836000000UL,	{1936696, -49855, 402} },
+			{1938000000UL,	{2003687, -51145, 402} },
+			{2014500000UL,	{2054787, -52095, 402} },
+			{2116500000UL,	{2124957, -53385, 402} },
+			{2218500000UL,	{2196950, -54665, 402} },
+			{2320500000UL,	{2270765, -55955, 402} },
+			{2422500000UL,	{2346401, -57235, 402} },
+			{2524500000UL,	{2437299, -58535, 402} },
+			{0,		{      0,      0,   0} },
+		},
+		.cpu_dfll_data = {
+			.tune0_low = 0x005020ff,
+			.tune0_high = 0x005040ff,
+			.tune1 = 0x00000060,
+		}
+	},
+};
+
+static struct tegra_dfll_soc_data soc;
+
+static int tegra124_dfll_fcpu_probe(struct platform_device *pdev)
+{
+	return tegra_dfll_register(pdev, &soc);
+}
+
+static const struct of_device_id tegra124_dfll_fcpu_of_match[] = {
+	{ .compatible = "nvidia,tegra124-dfll", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, tegra124_dfll_fcpu_of_match);
+
+static const struct dev_pm_ops tegra124_dfll_pm_ops = {
+	SET_RUNTIME_PM_OPS(tegra_dfll_runtime_suspend,
+			   tegra_dfll_runtime_resume, NULL)
+};
+
+static struct platform_driver tegra124_dfll_fcpu_driver = {
+	.probe		= tegra124_dfll_fcpu_probe,
+	.remove		= tegra_dfll_unregister,
+	.driver		= {
+		.name		= "tegra124-dfll",
+		.owner		= THIS_MODULE,
+		.of_match_table = tegra124_dfll_fcpu_of_match,
+		.pm		= &tegra124_dfll_pm_ops,
+	},
+};
+
+static int __init tegra124_dfll_fcpu_init(void)
+{
+	int process_id, speedo_id, speedo_value;
+	const struct cvb_table *cvb;
+
+	process_id = tegra_sku_info.cpu_process_id;
+	speedo_id = tegra_sku_info.cpu_speedo_id;
+	speedo_value = tegra_sku_info.cpu_speedo_value;
+
+	if (speedo_id >= ARRAY_SIZE(cpu_max_freq_table)) {
+		pr_err("unknown max CPU freq for speedo_id=%d\n", speedo_id);
+		return -ENODEV;
+	}
+
+	soc.opp_dev = get_cpu_device(0);
+	if (!soc.opp_dev) {
+		pr_err("no CPU0 device\n");
+		return -ENODEV;
+	}
+
+	cvb = tegra_cvb_build_opp_table(tegra124_cpu_cvb_tables,
+					ARRAY_SIZE(tegra124_cpu_cvb_tables),
+					process_id, speedo_id, speedo_value,
+					cpu_max_freq_table[speedo_id],
+					soc.opp_dev);
+	if (IS_ERR(cvb)) {
+		pr_err("couldn't build OPP table: %ld\n", PTR_ERR(cvb));
+		return PTR_ERR(cvb);
+	}
+
+	soc.min_millivolts = cvb->min_millivolts;
+	soc.tune0_low = cvb->cpu_dfll_data.tune0_low;
+	soc.tune0_high = cvb->cpu_dfll_data.tune0_high;
+	soc.tune1 = cvb->cpu_dfll_data.tune1;
+
+	return platform_driver_register(&tegra124_dfll_fcpu_driver);
+}
+module_init(tegra124_dfll_fcpu_init);
+
+static void __exit tegra124_dfll_fcpu_exit(void)
+{
+	platform_driver_unregister(&tegra124_dfll_fcpu_driver);
+}
+module_exit(tegra124_dfll_fcpu_exit);
+
+MODULE_DESCRIPTION("Tegra124 DFLL clock source driver");
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Aleksandr Frid <afrid-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>");
+MODULE_AUTHOR("Paul Walmsley <pwalmsley-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>");
-- 
2.3.0
