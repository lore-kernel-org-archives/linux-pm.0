From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 7/7] cpufreq: mvebu: Move cpufreq code into drivers/cpufreq/
Date: Wed, 27 Apr 2016 08:52:27 +0530
Message-ID: <8bac5a9dfb9280051d9f5dc3773106c253ad16d2.1461727086.git.viresh.kumar@linaro.org>
References: <cover.1461727086.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1461727086.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1461727086.git.viresh.kumar@linaro.org>
References: <cover.1461727086.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com, sboyd@codeaurora.org, arnd.bergmann@linaro.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Move cpufreq bits for mvebu into drivers/cpufreq/ directory, that's
where they really belong to.

Compiled tested only.

Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 MAINTAINERS                     |   1 +
 arch/arm/mach-mvebu/pmsu.c      |  85 -------------------------------
 drivers/cpufreq/Makefile        |   1 +
 drivers/cpufreq/mvebu-cpufreq.c | 107 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 109 insertions(+), 85 deletions(-)
 create mode 100644 drivers/cpufreq/mvebu-cpufreq.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 1d5b4becab6f..0bb566e7df9b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1322,6 +1322,7 @@ F:	drivers/rtc/rtc-armada38x.c
 F:	arch/arm/boot/dts/armada*
 F:	arch/arm/boot/dts/kirkwood*
 F:	arch/arm64/boot/dts/marvell/armada*
+F:	drivers/cpufreq/mvebu-cpufreq.c
 
 
 ARM/Marvell Berlin SoC support
diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index 8928f7caaf70..b44442338e4e 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -28,7 +28,6 @@
 #include <linux/of_address.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
-#include <linux/pm_opp.h>
 #include <linux/resource.h>
 #include <linux/slab.h>
 #include <linux/smp.h>
@@ -607,87 +606,3 @@ int mvebu_pmsu_dfs_request(int cpu)
 
 	return 0;
 }
-
-static int __init armada_xp_pmsu_cpufreq_init(void)
-{
-	struct device_node *np;
-	struct resource res;
-	int ret, cpu;
-
-	if (!of_machine_is_compatible("marvell,armadaxp"))
-		return 0;
-
-	/*
-	 * In order to have proper cpufreq handling, we need to ensure
-	 * that the Device Tree description of the CPU clock includes
-	 * the definition of the PMU DFS registers. If not, we do not
-	 * register the clock notifier and the cpufreq driver. This
-	 * piece of code is only for compatibility with old Device
-	 * Trees.
-	 */
-	np = of_find_compatible_node(NULL, NULL, "marvell,armada-xp-cpu-clock");
-	if (!np)
-		return 0;
-
-	ret = of_address_to_resource(np, 1, &res);
-	if (ret) {
-		pr_warn(FW_WARN "not enabling cpufreq, deprecated armada-xp-cpu-clock binding\n");
-		of_node_put(np);
-		return 0;
-	}
-
-	of_node_put(np);
-
-	/*
-	 * For each CPU, this loop registers the operating points
-	 * supported (which are the nominal CPU frequency and half of
-	 * it), and registers the clock notifier that will take care
-	 * of doing the PMSU part of a frequency transition.
-	 */
-	for_each_possible_cpu(cpu) {
-		struct device *cpu_dev;
-		struct clk *clk;
-		int ret;
-
-		cpu_dev = get_cpu_device(cpu);
-		if (!cpu_dev) {
-			pr_err("Cannot get CPU %d\n", cpu);
-			continue;
-		}
-
-		clk = clk_get(cpu_dev, 0);
-		if (IS_ERR(clk)) {
-			pr_err("Cannot get clock for CPU %d\n", cpu);
-			return PTR_ERR(clk);
-		}
-
-		/*
-		 * In case of a failure of dev_pm_opp_add(), we don't
-		 * bother with cleaning up the registered OPP (there's
-		 * no function to do so), and simply cancel the
-		 * registration of the cpufreq device.
-		 */
-		ret = dev_pm_opp_add(cpu_dev, clk_get_rate(clk), 0);
-		if (ret) {
-			clk_put(clk);
-			return ret;
-		}
-
-		ret = dev_pm_opp_add(cpu_dev, clk_get_rate(clk) / 2, 0);
-		if (ret) {
-			clk_put(clk);
-			return ret;
-		}
-
-		ret = dev_pm_opp_set_sharing_cpus(cpu_dev,
-						  cpumask_of(cpu_dev->id));
-		if (ret)
-			dev_err(cpu_dev, "%s: failed to mark OPPs as shared: %d\n",
-				__func__, ret);
-	}
-
-	platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
-	return 0;
-}
-
-device_initcall(armada_xp_pmsu_cpufreq_init);
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 2cce2cd400f9..e1eb11ee3570 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -79,6 +79,7 @@ obj-$(CONFIG_ARM_TEGRA20_CPUFREQ)	+= tegra20-cpufreq.o
 obj-$(CONFIG_ARM_TEGRA124_CPUFREQ)	+= tegra124-cpufreq.o
 obj-$(CONFIG_ARM_VEXPRESS_SPC_CPUFREQ)	+= vexpress-spc-cpufreq.o
 obj-$(CONFIG_ACPI_CPPC_CPUFREQ) += cppc_cpufreq.o
+obj-$(CONFIG_MACH_MVEBU_V7)		+= mvebu-cpufreq.o
 
 
 ##################################################################################
diff --git a/drivers/cpufreq/mvebu-cpufreq.c b/drivers/cpufreq/mvebu-cpufreq.c
new file mode 100644
index 000000000000..e920889b9ac2
--- /dev/null
+++ b/drivers/cpufreq/mvebu-cpufreq.c
@@ -0,0 +1,107 @@
+/*
+ * CPUFreq support for Armada 370/XP platforms.
+ *
+ * Copyright (C) 2012-2016 Marvell
+ *
+ * Yehuda Yitschak <yehuday@marvell.com>
+ * Gregory Clement <gregory.clement@free-electrons.com>
+ * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#define pr_fmt(fmt) "mvebu-pmsu: " fmt
+
+#include <linux/clk.h>
+#include <linux/cpu.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/pm_opp.h>
+#include <linux/resource.h>
+
+static int __init armada_xp_pmsu_cpufreq_init(void)
+{
+	struct device_node *np;
+	struct resource res;
+	int ret, cpu;
+
+	if (!of_machine_is_compatible("marvell,armadaxp"))
+		return 0;
+
+	/*
+	 * In order to have proper cpufreq handling, we need to ensure
+	 * that the Device Tree description of the CPU clock includes
+	 * the definition of the PMU DFS registers. If not, we do not
+	 * register the clock notifier and the cpufreq driver. This
+	 * piece of code is only for compatibility with old Device
+	 * Trees.
+	 */
+	np = of_find_compatible_node(NULL, NULL, "marvell,armada-xp-cpu-clock");
+	if (!np)
+		return 0;
+
+	ret = of_address_to_resource(np, 1, &res);
+	if (ret) {
+		pr_warn(FW_WARN "not enabling cpufreq, deprecated armada-xp-cpu-clock binding\n");
+		of_node_put(np);
+		return 0;
+	}
+
+	of_node_put(np);
+
+	/*
+	 * For each CPU, this loop registers the operating points
+	 * supported (which are the nominal CPU frequency and half of
+	 * it), and registers the clock notifier that will take care
+	 * of doing the PMSU part of a frequency transition.
+	 */
+	for_each_possible_cpu(cpu) {
+		struct device *cpu_dev;
+		struct clk *clk;
+		int ret;
+
+		cpu_dev = get_cpu_device(cpu);
+		if (!cpu_dev) {
+			pr_err("Cannot get CPU %d\n", cpu);
+			continue;
+		}
+
+		clk = clk_get(cpu_dev, 0);
+		if (IS_ERR(clk)) {
+			pr_err("Cannot get clock for CPU %d\n", cpu);
+			return PTR_ERR(clk);
+		}
+
+		/*
+		 * In case of a failure of dev_pm_opp_add(), we don't
+		 * bother with cleaning up the registered OPP (there's
+		 * no function to do so), and simply cancel the
+		 * registration of the cpufreq device.
+		 */
+		ret = dev_pm_opp_add(cpu_dev, clk_get_rate(clk), 0);
+		if (ret) {
+			clk_put(clk);
+			return ret;
+		}
+
+		ret = dev_pm_opp_add(cpu_dev, clk_get_rate(clk) / 2, 0);
+		if (ret) {
+			clk_put(clk);
+			return ret;
+		}
+
+		ret = dev_pm_opp_set_sharing_cpus(cpu_dev,
+						  cpumask_of(cpu_dev->id));
+		if (ret)
+			dev_err(cpu_dev, "%s: failed to mark OPPs as shared: %d\n",
+				__func__, ret);
+	}
+
+	platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
+	return 0;
+}
+device_initcall(armada_xp_pmsu_cpufreq_init);
-- 
2.7.1.410.g6faf27b
