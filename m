From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCHv3 2/7] ARM: mvebu: extend PMSU code to support dynamic frequency scaling
Date: Wed,  9 Jul 2014 17:45:10 +0200
Message-ID: <1404920715-19834-3-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1404920715-19834-1-git-send-email-thomas.petazzoni@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:49256 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756142AbaGIPpW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Jul 2014 11:45:22 -0400
In-Reply-To: <1404920715-19834-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

This commit adds the necessary code in the Marvell EBU PMSU driver to
support dynamic frequency scaling. In essence, what this new code does
is that it:

 * registers the frequency operating points supported by the CPU;

 * registers a clock notifier of the CPU clocks. The notifier function
   listens to the newly introduced APPLY_RATE_CHANGE event, and uses
   that to finalize the frequency transition by doing the part of the
   procedure that involves the PMSU;

 * registers a platform device for the cpufreq-generic driver, which
   will take care of the CPU frequency transitions.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/pmsu.c | 162 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mvebu-pmsu.h |  20 ++++++
 2 files changed, 182 insertions(+)
 create mode 100644 include/linux/mvebu-pmsu.h

diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index 53a55c8..db7d9ab 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -18,20 +18,26 @@
 
 #define pr_fmt(fmt) "mvebu-pmsu: " fmt
 
+#include <linux/clk.h>
 #include <linux/cpu_pm.h>
+#include <linux/delay.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/of_address.h>
+#include <linux/of_device.h>
 #include <linux/io.h>
 #include <linux/platform_device.h>
+#include <linux/pm_opp.h>
 #include <linux/smp.h>
 #include <linux/resource.h>
+#include <linux/slab.h>
 #include <asm/cacheflush.h>
 #include <asm/cp15.h>
 #include <asm/smp_plat.h>
 #include <asm/suspend.h>
 #include <asm/tlbflush.h>
 #include "common.h"
+#include "armada-370-xp.h"
 
 static void __iomem *pmsu_mp_base;
 
@@ -57,6 +63,10 @@ static void __iomem *pmsu_mp_base;
 #define PMSU_STATUS_AND_MASK_IRQ_MASK		BIT(24)
 #define PMSU_STATUS_AND_MASK_FIQ_MASK		BIT(25)
 
+#define PMSU_EVENT_STATUS_AND_MASK(cpu)     ((cpu * 0x100) + 0x120)
+#define PMSU_EVENT_STATUS_AND_MASK_DFS_DONE        BIT(1)
+#define PMSU_EVENT_STATUS_AND_MASK_DFS_DONE_MASK   BIT(17)
+
 #define PMSU_BOOT_ADDR_REDIRECT_OFFSET(cpu) ((cpu * 0x100) + 0x124)
 
 /* PMSU fabric registers */
@@ -296,3 +306,155 @@ int __init armada_370_xp_cpu_pm_init(void)
 
 arch_initcall(armada_370_xp_cpu_pm_init);
 early_initcall(armada_370_xp_pmsu_init);
+
+static void mvebu_pmsu_dfs_request_local(void *data)
+{
+	u32 reg;
+	u32 cpu = smp_processor_id();
+	unsigned long flags;
+
+	local_irq_save(flags);
+
+	/* Prepare to enter idle */
+	reg = readl(pmsu_mp_base + PMSU_STATUS_AND_MASK(cpu));
+	reg |= PMSU_STATUS_AND_MASK_CPU_IDLE_WAIT |
+	       PMSU_STATUS_AND_MASK_IRQ_MASK     |
+	       PMSU_STATUS_AND_MASK_FIQ_MASK;
+	writel(reg, pmsu_mp_base + PMSU_STATUS_AND_MASK(cpu));
+
+	/* Request the DFS transition */
+	reg = readl(pmsu_mp_base + PMSU_CONTROL_AND_CONFIG(cpu));
+	reg |= PMSU_CONTROL_AND_CONFIG_DFS_REQ;
+	writel(reg, pmsu_mp_base + PMSU_CONTROL_AND_CONFIG(cpu));
+
+	/* The fact of entering idle will trigger the DFS transition */
+	wfi();
+
+	/*
+	 * We're back from idle, the DFS transition has completed,
+	 * clear the idle wait indication.
+	 */
+	reg = readl(pmsu_mp_base + PMSU_STATUS_AND_MASK(cpu));
+	reg &= ~PMSU_STATUS_AND_MASK_CPU_IDLE_WAIT;
+	writel(reg, pmsu_mp_base + PMSU_STATUS_AND_MASK(cpu));
+
+	local_irq_restore(flags);
+}
+
+int mvebu_pmsu_dfs_request(int cpu)
+{
+	unsigned long timeout;
+	int hwcpu = cpu_logical_map(cpu);
+	u32 reg;
+
+	/* Clear any previous DFS DONE event */
+	reg = readl(pmsu_mp_base + PMSU_EVENT_STATUS_AND_MASK(hwcpu));
+	reg &= ~PMSU_EVENT_STATUS_AND_MASK_DFS_DONE;
+	writel(reg, pmsu_mp_base + PMSU_EVENT_STATUS_AND_MASK(hwcpu));
+
+	/* Mask the DFS done interrupt, since we are going to poll */
+	reg = readl(pmsu_mp_base + PMSU_EVENT_STATUS_AND_MASK(hwcpu));
+	reg |= PMSU_EVENT_STATUS_AND_MASK_DFS_DONE_MASK;
+	writel(reg, pmsu_mp_base + PMSU_EVENT_STATUS_AND_MASK(hwcpu));
+
+	/* Trigger the DFS on the appropriate CPU */
+	smp_call_function_single(cpu, mvebu_pmsu_dfs_request_local,
+				 NULL, false);
+
+	/* Poll until the DFS done event is generated */
+	timeout = jiffies + HZ;
+	while (time_before(jiffies, timeout)) {
+		reg = readl(pmsu_mp_base + PMSU_EVENT_STATUS_AND_MASK(hwcpu));
+		if (reg & PMSU_EVENT_STATUS_AND_MASK_DFS_DONE)
+			break;
+		udelay(10);
+	}
+
+	if (time_after(jiffies, timeout))
+		return -ETIME;
+
+	/* Restore the DFS mask to its original state */
+	reg = readl(pmsu_mp_base + PMSU_EVENT_STATUS_AND_MASK(hwcpu));
+	reg &= ~PMSU_EVENT_STATUS_AND_MASK_DFS_DONE_MASK;
+	writel(reg, pmsu_mp_base + PMSU_EVENT_STATUS_AND_MASK(hwcpu));
+
+	return 0;
+}
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
+		if (!clk) {
+			pr_err("Cannot get clock for CPU %d\n", cpu);
+			return -ENODEV;
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
+	}
+
+	platform_device_register_simple("cpufreq-generic", -1, NULL, 0);
+	return 0;
+}
+
+device_initcall(armada_xp_pmsu_cpufreq_init);
diff --git a/include/linux/mvebu-pmsu.h b/include/linux/mvebu-pmsu.h
new file mode 100644
index 0000000..b918d07
--- /dev/null
+++ b/include/linux/mvebu-pmsu.h
@@ -0,0 +1,20 @@
+/*
+ * Copyright (C) 2012 Marvell
+ *
+ * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __MVEBU_PMSU_H__
+#define __MVEBU_PMSU_H__
+
+#ifdef CONFIG_MACH_MVEBU_V7
+int mvebu_pmsu_dfs_request(int cpu);
+#else
+static inline int mvebu_pmsu_dfs_request(int cpu) { return -ENODEV; }
+#endif
+
+#endif /* __MVEBU_PMSU_H__ */
-- 
2.0.0

