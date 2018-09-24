From: Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH 2/2] cpufreq: ap806: add cpufreq driver for Armada 8K
Date: Mon, 24 Sep 2018 17:12:49 +0200
Message-ID: <20180924151249.32328-3-gregory.clement@bootlin.com>
References: <20180924151249.32328-1-gregory.clement@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180924151249.32328-1-gregory.clement@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Baruch Siach <baruch@tkos.co.il>, Jason Cooper <jason@lakedaemon.net>, Antoine Tenart <antoine.tenart@bootlin.com>, Gregory CLEMENT <gregory.clement@bootlin.com>, Omri Itach <omrii@marvell.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, Nadav Haklai <nadavh@marvell.com>, Shadi Ammouri <shadi@marvell.com>, Igal Liberman <igall@marvell.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>, Marcin Wojtas <mw@semihalf.com>, Hanna Hawa <hannah@marvell.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-pm@vger.kernel.org

Add cpufreq driver for Marvell AP-806 found on Aramda 8K.
The AP-806 has DFS (Dynamic Frequency Scaling) with coupled
clock domain for two clusters, so this driver will directly
use generic cpufreq-dt driver as backend.

Based on the work of Omri Itach <omrii@marvell.com>.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 drivers/cpufreq/Kconfig.arm         |  11 +++
 drivers/cpufreq/Makefile            |   1 +
 drivers/cpufreq/armada-8k-cpufreq.c | 148 ++++++++++++++++++++++++++++
 3 files changed, 160 insertions(+)
 create mode 100644 drivers/cpufreq/armada-8k-cpufreq.c

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 0cd8eb76ad59..fd34095743a7 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -25,6 +25,17 @@ config ARM_ARMADA_37XX_CPUFREQ
 	  This adds the CPUFreq driver support for Marvell Armada 37xx SoCs.
 	  The Armada 37xx PMU supports 4 frequency and VDD levels.
 
+config ARM_ARMADA_8K_CPUFREQ
+	tristate "Armada 8K CPUFreq driver"
+	depends on ARCH_MVEBU && CPUFREQ_DT
+	help
+	  This enables the CPUFreq driver support for Marvell
+	  Armada8k SOCs.
+	  Armada8K device has the AP806 which supports scaling
+	  to any full integer divider.
+
+	  If in doubt, say N.
+
 # big LITTLE core layer and glue drivers
 config ARM_BIG_LITTLE_CPUFREQ
 	tristate "Generic ARM big LITTLE CPUfreq driver"
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index c1ffeabe4ecf..21f4f56229db 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -53,6 +53,7 @@ obj-$(CONFIG_ARM_BIG_LITTLE_CPUFREQ)	+= arm_big_little.o
 obj-$(CONFIG_ARM_DT_BL_CPUFREQ)		+= arm_big_little_dt.o
 
 obj-$(CONFIG_ARM_ARMADA_37XX_CPUFREQ)	+= armada-37xx-cpufreq.o
+obj-$(CONFIG_ARM_ARMADA_8K_CPUFREQ)	+= armada-8k-cpufreq.o
 obj-$(CONFIG_ARM_BRCMSTB_AVS_CPUFREQ)	+= brcmstb-avs-cpufreq.o
 obj-$(CONFIG_ACPI_CPPC_CPUFREQ)		+= cppc_cpufreq.o
 obj-$(CONFIG_ARCH_DAVINCI)		+= davinci-cpufreq.o
diff --git a/drivers/cpufreq/armada-8k-cpufreq.c b/drivers/cpufreq/armada-8k-cpufreq.c
new file mode 100644
index 000000000000..1c604f1d27d2
--- /dev/null
+++ b/drivers/cpufreq/armada-8k-cpufreq.c
@@ -0,0 +1,148 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * CPUFreq support for Armada 7K/8K
+ *
+ * Copyright (C) 2018 Marvell
+ *
+ * Omri Itach <omrii@marvell.com>
+ * Gregory Clement <gregory.clement@bootlin.com>
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/clk.h>
+#include <linux/cpu.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_opp.h>
+#include <linux/slab.h>
+
+#define MIN_FREQ 100000000
+
+/*
+ * Setup the opps list with the divider for the max frequency, that
+ * will be filled at runtime, 0 meaning 100Mhz
+ */
+static const int opps_div[] __initconst = {1, 2, 3, 0};
+
+struct opps_array {
+	struct device *cpu_dev;
+	unsigned int freq[ARRAY_SIZE(opps_div)];
+};
+
+/* If the CPUs share the same clock, then they are in the same cluster */
+static void __init armada_8k_get_sharing_cpus(struct clk *cur_clk,
+				       struct cpumask *cpumask)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		struct device *cpu_dev = get_cpu_device(cpu);
+		struct clk *clk = clk_get(cpu_dev, 0);
+
+		if (IS_ERR(clk))
+			dev_warn(cpu_dev, "Cannot get clock for CPU %d\n", cpu);
+
+		if (clk_is_match(clk, cur_clk))
+			cpumask_set_cpu(cpu, cpumask);
+	}
+
+}
+
+static int __init armada_8k_cpufreq_init(void)
+{
+	struct opps_array *opps_arrays;
+	struct platform_device *pdev;
+	int ret, cpu, opps_index = 0;
+	unsigned int cur_frequency;
+	struct device_node *node;
+
+	node = of_find_compatible_node(NULL, NULL, "marvell,ap806-cpu-clock");
+	if (!node || !of_device_is_available(node))
+		return -ENODEV;
+
+	opps_arrays = kcalloc(num_possible_cpus(), sizeof(*opps_arrays),
+			      GFP_KERNEL);
+	/*
+	 * For each CPU, this loop registers the operating points
+	 * supported (which are the nominal CPU frequency and full integer
+	 * divisions of it).
+	 */
+	for_each_possible_cpu(cpu) {
+		struct device *cpu_dev;
+		struct cpumask cpus;
+		unsigned int freq;
+		struct clk *clk;
+		int i;
+
+		cpu_dev = get_cpu_device(cpu);
+		if (!cpu_dev) {
+			dev_err(cpu_dev, "Cannot get CPU %d\n", cpu);
+			continue;
+		}
+
+		clk = clk_get(cpu_dev, 0);
+		if (IS_ERR(clk)) {
+			dev_err(cpu_dev, "Cannot get clock for CPU %d\n", cpu);
+			ret = PTR_ERR(clk);
+			goto free_opp_array;
+		}
+
+		/* Get nominal (current) CPU frequency */
+		cur_frequency = clk_get_rate(clk);
+		if (!cur_frequency) {
+			dev_err(cpu_dev,
+				"Failed to get clock rate for CPU %d\n", cpu);
+			ret = -EINVAL;
+			goto free_opp_array;
+		}
+
+		opps_arrays[opps_index].cpu_dev = cpu_dev;
+		for (i = 0; i < ARRAY_SIZE(opps_div); i++) {
+			if (opps_div[i])
+				freq = cur_frequency / opps_div[i];
+			else
+				freq = MIN_FREQ;
+
+			ret = dev_pm_opp_add(cpu_dev, freq, 0);
+			if (ret)
+				goto remove_opp;
+
+			opps_arrays[opps_index].freq[i] = freq;
+		}
+
+		cpumask_clear(&cpus);
+		armada_8k_get_sharing_cpus(clk, &cpus);
+		dev_pm_opp_set_sharing_cpus(cpu_dev, &cpus);
+	}
+
+	pdev = platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
+	ret = PTR_ERR_OR_ZERO(pdev);
+	if (ret)
+		goto remove_opp;
+	kfree(opps_arrays);
+	return 0;
+
+remove_opp:
+	for (; opps_index >= 0; opps_index--) {
+		int i = 0;
+
+		while (opps_arrays[opps_index].freq[i]) {
+			dev_pm_opp_remove(opps_arrays[opps_index].cpu_dev,
+					  opps_arrays[opps_index].freq[i]);
+			i++;
+		}
+	}
+free_opp_array:
+	kfree(opps_arrays);
+	return ret;
+}
+module_init(armada_8k_cpufreq_init);
+
+MODULE_AUTHOR("Gregory Clement <gregory.clement@bootlin.com>");
+MODULE_DESCRIPTION("Armada 8K cpufreq driver");
+MODULE_LICENSE("GPL");
-- 
2.19.0
