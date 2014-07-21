From: Tuomas Tynkkynen <ttynkkynen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 14/16] cpufreq: Add cpufreq driver for Tegra124
Date: Mon, 21 Jul 2014 18:39:00 +0300
Message-ID: <1405957142-19416-15-git-send-email-ttynkkynen@nvidia.com>
References: <1405957142-19416-1-git-send-email-ttynkkynen@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1405957142-19416-1-git-send-email-ttynkkynen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Prashant Gaikwad <pgaikwad-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Paul Walmsley <pwalmsley-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tuomas Tynkkynen <ttynkkynen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Add a new cpufreq driver for Tegra124. Instead of using the PLLX as
the CPU clocksource, switch immediately to the DFLL. It allows the use
of higher clock rates, and will automatically scale the CPU voltage as
well. Besides the CPU clocksource switch, we let the cpufreq-cpu0 driver
for all the cpufreq operations.

This driver also relies on the DFLL driver to fill the OPP table for the
CPU0 device, so that the cpufreq-cpu0 driver knows what frequencies to
use.

This driver is a completely independent of the old cpufreq driver
(tegra-cpufreq), which is only used on Tegra20.

Signed-off-by: Tuomas Tynkkynen <ttynkkynen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
v2 changes:
    - use the cpufreq-cpu0 driver

 drivers/cpufreq/Kconfig.arm        |   1 +
 drivers/cpufreq/Makefile           |   1 +
 drivers/cpufreq/tegra124-cpufreq.c | 169 +++++++++++++++++++++++++++++++++++++
 3 files changed, 171 insertions(+)
 create mode 100644 drivers/cpufreq/tegra124-cpufreq.c

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 7364a53..df3c73e 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -244,6 +244,7 @@ config ARM_SPEAR_CPUFREQ
 config ARM_TEGRA_CPUFREQ
 	bool "TEGRA CPUFreq support"
 	depends on ARCH_TEGRA
+	depends on GENERIC_CPUFREQ_CPU0
 	default y
 	help
 	  This adds the CPUFreq driver support for TEGRA SOCs.
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index db6d9a2..3437d24 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -76,6 +76,7 @@ obj-$(CONFIG_ARM_SA1100_CPUFREQ)	+= sa1100-cpufreq.o
 obj-$(CONFIG_ARM_SA1110_CPUFREQ)	+= sa1110-cpufreq.o
 obj-$(CONFIG_ARM_SPEAR_CPUFREQ)		+= spear-cpufreq.o
 obj-$(CONFIG_ARM_TEGRA_CPUFREQ)		+= tegra-cpufreq.o
+obj-$(CONFIG_ARM_TEGRA_CPUFREQ)		+= tegra124-cpufreq.o
 obj-$(CONFIG_ARM_VEXPRESS_SPC_CPUFREQ)	+= vexpress-spc-cpufreq.o
 
 ##################################################################################
diff --git a/drivers/cpufreq/tegra124-cpufreq.c b/drivers/cpufreq/tegra124-cpufreq.c
new file mode 100644
index 0000000..65ff428
--- /dev/null
+++ b/drivers/cpufreq/tegra124-cpufreq.c
@@ -0,0 +1,169 @@
+/*
+ * Tegra 124 cpufreq driver
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
+
+#include <linux/clk.h>
+#include <linux/cpufreq.h>
+#include <linux/cpu.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_opp.h>
+#include <linux/types.h>
+
+static struct cpufreq_frequency_table *freq_table;
+
+static struct device *cpu_dev;
+static struct clk *cpu_clk;
+static struct clk *pllp_clk;
+static struct clk *pllx_clk;
+static struct clk *dfll_clk;
+
+static int tegra124_cpu_switch_to_dfll(void)
+{
+	struct clk *original_cpu_clk_parent;
+	unsigned long rate;
+	struct dev_pm_opp *opp;
+	int ret;
+
+	rate = clk_get_rate(cpu_clk);
+	opp = dev_pm_opp_find_freq_ceil(cpu_dev, &rate);
+	if (IS_ERR(opp))
+		return PTR_ERR(opp);
+
+	ret = clk_set_rate(dfll_clk, rate);
+	if (ret)
+		return ret;
+
+	original_cpu_clk_parent = clk_get_parent(cpu_clk);
+	clk_set_parent(cpu_clk, pllp_clk);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(dfll_clk);
+	if (ret)
+		goto out_switch_to_original_parent;
+
+	clk_set_parent(cpu_clk, dfll_clk);
+
+	return 0;
+
+out_switch_to_original_parent:
+	clk_set_parent(cpu_clk, original_cpu_clk_parent);
+
+	return ret;
+}
+
+static struct platform_device_info cpufreq_cpu0_devinfo = {
+	.name = "cpufreq-cpu0",
+};
+
+static int tegra124_cpufreq_probe(struct platform_device *pdev)
+{
+	int ret;
+
+	cpu_dev = get_cpu_device(0);
+	if (!cpu_dev)
+		return -ENODEV;
+
+	cpu_clk = of_clk_get_by_name(cpu_dev->of_node, "cpu_g");
+	if (IS_ERR(cpu_clk))
+		return PTR_ERR(cpu_clk);
+
+	dfll_clk = of_clk_get_by_name(cpu_dev->of_node, "dfll");
+	if (IS_ERR(dfll_clk)) {
+		ret = PTR_ERR(dfll_clk);
+		goto out_put_cpu_clk;
+	}
+
+	pllx_clk = of_clk_get_by_name(cpu_dev->of_node, "pll_x");
+	if (IS_ERR(pllx_clk)) {
+		ret = PTR_ERR(pllx_clk);
+		goto out_put_dfll_clk;
+	}
+
+	pllp_clk = of_clk_get_by_name(cpu_dev->of_node, "pll_p");
+	if (IS_ERR(pllp_clk)) {
+		ret = PTR_ERR(pllp_clk);
+		goto out_put_pllx_clk;
+	}
+
+	ret = dev_pm_opp_init_cpufreq_table(cpu_dev, &freq_table);
+	if (ret)
+		goto out_put_pllp_clk;
+
+	ret = tegra124_cpu_switch_to_dfll();
+	if (ret)
+		goto out_free_table;
+
+	platform_device_register_full(&cpufreq_cpu0_devinfo);
+
+	return 0;
+
+out_free_table:
+	dev_pm_opp_free_cpufreq_table(cpu_dev, &freq_table);
+out_put_pllp_clk:
+	clk_put(pllp_clk);
+out_put_pllx_clk:
+	clk_put(pllx_clk);
+out_put_dfll_clk:
+	clk_put(dfll_clk);
+out_put_cpu_clk:
+	clk_put(cpu_clk);
+
+	return ret;
+}
+
+static struct platform_driver tegra124_cpufreq_platdrv = {
+	.driver = {
+		.name	= "cpufreq-tegra124",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= tegra124_cpufreq_probe,
+};
+
+static const struct of_device_id soc_of_matches[] = {
+	{ .compatible = "nvidia,tegra124", },
+	{}
+};
+
+static int __init tegra_cpufreq_init(void)
+{
+	int ret;
+	struct platform_device *pdev;
+
+	if (!of_find_matching_node(NULL, soc_of_matches))
+		return -ENODEV;
+
+	ret = platform_driver_register(&tegra124_cpufreq_platdrv);
+	if (ret)
+		return ret;
+
+	pdev = platform_device_register_simple("cpufreq-tegra124", -1, NULL, 0);
+	if (IS_ERR(pdev)) {
+		platform_driver_unregister(&tegra124_cpufreq_platdrv);
+		return PTR_ERR(pdev);
+	}
+
+	return 0;
+}
+
+MODULE_AUTHOR("Tuomas Tynkkynen <ttynkkynen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>");
+MODULE_DESCRIPTION("cpufreq driver for nVIDIA Tegra124");
+MODULE_LICENSE("GPLv2");
+module_init(tegra_cpufreq_init);
-- 
1.8.1.5
