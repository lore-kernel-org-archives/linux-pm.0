From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH 5/8] ARM: mvebu: extend PMSU code to support dynamic frequency scaling
Date: Fri,  4 Jul 2014 11:45:00 +0200
Message-ID: <1404467103-29644-6-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1404467103-29644-1-git-send-email-thomas.petazzoni@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:56890 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755353AbaGDJpZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 4 Jul 2014 05:45:25 -0400
In-Reply-To: <1404467103-29644-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

This commit adds the necessary code in the Marvell EBU PMSU driver to
support dynamic frequency scaling. In essence, what this new code does
is that it registers a clock notifier of the CPU clocks. The notifier
function listens to the newly introduced APPLY_RATE_CHANGE event, and
uses that to finalize the frequency transition by doing the part of
the procedure that involves the PMSU.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/pmsu.c | 168 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 168 insertions(+)

diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index 53a55c8..a114e4a 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -18,20 +18,25 @@
 
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
 
@@ -57,6 +62,10 @@ static void __iomem *pmsu_mp_base;
 #define PMSU_STATUS_AND_MASK_IRQ_MASK		BIT(24)
 #define PMSU_STATUS_AND_MASK_FIQ_MASK		BIT(25)
 
+#define PMSU_EVENT_STATUS_AND_MASK(cpu)     ((cpu * 0x100) + 0x120)
+#define PMSU_EVENT_STATUS_AND_MASK_DFS_DONE        BIT(1)
+#define PMSU_EVENT_STATUS_AND_MASK_DFS_DONE_MASK   BIT(17)
+
 #define PMSU_BOOT_ADDR_REDIRECT_OFFSET(cpu) ((cpu * 0x100) + 0x124)
 
 /* PMSU fabric registers */
@@ -296,3 +305,162 @@ int __init armada_370_xp_cpu_pm_init(void)
 
 arch_initcall(armada_370_xp_cpu_pm_init);
 early_initcall(armada_370_xp_pmsu_init);
+
+static void armada_xp_cpufreq_clk_set_local(void *data)
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
+struct armada_xp_cpufreq_notifier_block {
+	struct notifier_block nb;
+	int cpu;
+};
+
+static int armada_xp_cpufreq_clk_notify(struct notifier_block *self,
+					unsigned long action, void *data)
+{
+	struct armada_xp_cpufreq_notifier_block *nb =
+		container_of(self, struct armada_xp_cpufreq_notifier_block, nb);
+	unsigned long timeout;
+	int cpu = nb->cpu;
+	u32 reg;
+
+	if (action != APPLY_RATE_CHANGE)
+		return 0;
+
+	/* Clear any previous DFS DONE event */
+	reg = readl(pmsu_mp_base + PMSU_EVENT_STATUS_AND_MASK(cpu));
+	reg &= ~PMSU_EVENT_STATUS_AND_MASK_DFS_DONE;
+	writel(reg, pmsu_mp_base + PMSU_EVENT_STATUS_AND_MASK(cpu));
+
+	/* Mask the DFS done interrupt, since we are going to poll */
+	reg = readl(pmsu_mp_base + PMSU_EVENT_STATUS_AND_MASK(cpu));
+	reg |= PMSU_EVENT_STATUS_AND_MASK_DFS_DONE_MASK;
+	writel(reg, pmsu_mp_base + PMSU_EVENT_STATUS_AND_MASK(cpu));
+
+	/* Trigger the DFS on the appropriate CPU */
+	smp_call_function_single(get_logical_index(cpu),
+				 armada_xp_cpufreq_clk_set_local, NULL, false);
+
+	/* Poll until the DFS done event is generated */
+	timeout = jiffies + HZ;
+	while (time_before(jiffies, timeout)) {
+		reg = readl(pmsu_mp_base + PMSU_EVENT_STATUS_AND_MASK(cpu));
+		if (reg & PMSU_EVENT_STATUS_AND_MASK_DFS_DONE)
+			break;
+		udelay(10);
+	}
+
+	/* Restore the DFS mask to its original state */
+	reg = readl(pmsu_mp_base + PMSU_EVENT_STATUS_AND_MASK(cpu));
+	reg &= ~BIT(17);
+	writel(reg, pmsu_mp_base + PMSU_EVENT_STATUS_AND_MASK(cpu));
+
+	return NOTIFY_DONE;
+}
+
+static int __init armada_xp_pmsu_cpufreq_init(void)
+{
+	struct device_node *np;
+	struct resource res;
+	int i, ret;
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
+	for (i = 0; i < ARMADA_XP_MAX_CPUS; i++) {
+		struct clk *clk;
+		struct armada_xp_cpufreq_notifier_block *nbs;
+		struct device_node *np;
+		int ret;
+
+		np = of_get_cpu_node(i, NULL);
+		if (!np)
+			return -ENODEV;
+
+		clk = of_clk_get(np, 0);
+		if (!clk) {
+			pr_err("Cannot get clock for CPU %d\n", i);
+			of_node_put(np);
+			return -ENODEV;
+		}
+
+		nbs = kzalloc(sizeof(struct armada_xp_cpufreq_notifier_block),
+			      GFP_KERNEL);
+		if (!nbs) {
+			pr_err("Cannot allocate memory for cpufreq notifier\n");
+			clk_put(clk);
+			of_node_put(np);
+			return -ENOMEM;
+		}
+
+		nbs->nb.notifier_call = armada_xp_cpufreq_clk_notify;
+		nbs->cpu = i;
+
+		ret = clk_notifier_register(clk, &nbs->nb);
+		if (ret) {
+			pr_err("Cannot register clock notifier\n");
+			kfree(nbs);
+			clk_put(clk);
+			of_node_put(np);
+			return ret;
+		}
+
+		of_node_put(np);
+	}
+
+	platform_device_register_simple("armadaxp-cpufreq", -1, NULL, 0);
+	return 0;
+}
+
+arch_initcall(armada_xp_pmsu_cpufreq_init);
-- 
2.0.0

