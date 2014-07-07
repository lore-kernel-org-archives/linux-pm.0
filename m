From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCHv2 2/8] clk: mvebu: extend clk-cpu for dynamic frequency scaling
Date: Mon,  7 Jul 2014 16:51:36 +0200
Message-ID: <1404744702-32010-3-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1404744702-32010-1-git-send-email-thomas.petazzoni@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:57784 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753443AbaGGOvt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 7 Jul 2014 10:51:49 -0400
In-Reply-To: <1404744702-32010-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, devicetree@vger.kernel.org

This commit extends the existing clk-cpu driver used on Marvell Armada
XP platforms to support the dynamic frequency scaling of the CPU
clock. Non-dynamic frequency change was already supported (and used
before secondary CPUs are started), but the dynamic frequency change
requires a completely different procedure.

In order to achieve this, the clk_cpu_set_rate() function is reworked
to handle two separate cases:

 - The case where the clock is enabled, which is the new dynamic
   frequency change code, implemented in clk_cpu_on_set_rate(). This
   part will be used for cpufreq activities.

 - The case where the clock is disabled, which is the existing
   frequency change code, moved in clk_cpu_off_set_rate(). This part
   is already used to set the clock frequency of the secondary CPUs
   before starting them.

In order to implement the dynamic frequency change function, we need
to access the PMU DFS registers, which are outside the currently
mapped "Clock Complex" registers, so a new area of registers is now
mapped. This affects the Device Tree binding, but we are careful to do
it in a backward-compatible way (by allowing the second pair of
registers to be non-existent, and in this case, ensuring
clk_cpu_on_set_rate() returns an error).

Note that technically speaking, the clk_cpu_on_set_rate() does not do
the entire procedure needed to change the frequency dynamically, as it
involves touching a number of PMSU registers. This is done through a
clock notifier registered by the PMSU driver in followup commits.

Cc: <devicetree@vger.kernel.org>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 .../devicetree/bindings/clock/mvebu-cpu-clock.txt  |  5 +-
 drivers/clk/mvebu/clk-cpu.c                        | 79 ++++++++++++++++++++--
 2 files changed, 77 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/mvebu-cpu-clock.txt b/Documentation/devicetree/bindings/clock/mvebu-cpu-clock.txt
index feb8301..99c2146 100644
--- a/Documentation/devicetree/bindings/clock/mvebu-cpu-clock.txt
+++ b/Documentation/devicetree/bindings/clock/mvebu-cpu-clock.txt
@@ -3,14 +3,15 @@ Device Tree Clock bindings for cpu clock of Marvell EBU platforms
 Required properties:
 - compatible : shall be one of the following:
 	"marvell,armada-xp-cpu-clock" - cpu clocks for Armada XP
-- reg : Address and length of the clock complex register set
+- reg : Address and length of the clock complex register set, followed
+        by address and length of the PMU DFS registers
 - #clock-cells : should be set to 1.
 - clocks : shall be the input parent clock phandle for the clock.
 
 cpuclk: clock-complex@d0018700 {
 	#clock-cells = <1>;
 	compatible = "marvell,armada-xp-cpu-clock";
-	reg = <0xd0018700 0xA0>;
+	reg = <0xd0018700 0xA0>, <0x1c054 0x10>;
 	clocks = <&coreclk 1>;
 }
 
diff --git a/drivers/clk/mvebu/clk-cpu.c b/drivers/clk/mvebu/clk-cpu.c
index 8ebf757..b931e72 100644
--- a/drivers/clk/mvebu/clk-cpu.c
+++ b/drivers/clk/mvebu/clk-cpu.c
@@ -16,10 +16,18 @@
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/delay.h>
+#include <asm/smp_plat.h>
 
-#define SYS_CTRL_CLK_DIVIDER_CTRL_OFFSET    0x0
-#define SYS_CTRL_CLK_DIVIDER_VALUE_OFFSET   0xC
-#define SYS_CTRL_CLK_DIVIDER_MASK	    0x3F
+#define SYS_CTRL_CLK_DIVIDER_CTRL_OFFSET               0x0
+#define   SYS_CTRL_CLK_DIVIDER_CTRL_RESET_ALL          0xff
+#define   SYS_CTRL_CLK_DIVIDER_CTRL_RESET_SHIFT        8
+#define SYS_CTRL_CLK_DIVIDER_CTRL2_OFFSET              0x8
+#define   SYS_CTRL_CLK_DIVIDER_CTRL2_NBCLK_RATIO_SHIFT 16
+#define SYS_CTRL_CLK_DIVIDER_VALUE_OFFSET              0xC
+#define SYS_CTRL_CLK_DIVIDER_MASK                      0x3F
+
+#define PMU_DFS_RATIO_SHIFT 16
+#define PMU_DFS_RATIO_MASK  0x3F
 
 #define MAX_CPU	    4
 struct cpu_clk {
@@ -28,6 +36,7 @@ struct cpu_clk {
 	const char *clk_name;
 	const char *parent_name;
 	void __iomem *reg_base;
+	void __iomem *pmu_dfs;
 };
 
 static struct clk **clks;
@@ -62,8 +71,9 @@ static long clk_cpu_round_rate(struct clk_hw *hwclk, unsigned long rate,
 	return *parent_rate / div;
 }
 
-static int clk_cpu_set_rate(struct clk_hw *hwclk, unsigned long rate,
-			    unsigned long parent_rate)
+static int clk_cpu_off_set_rate(struct clk_hw *hwclk, unsigned long rate,
+				unsigned long parent_rate)
+
 {
 	struct cpu_clk *cpuclk = to_cpu_clk(hwclk);
 	u32 reg, div;
@@ -95,6 +105,58 @@ static int clk_cpu_set_rate(struct clk_hw *hwclk, unsigned long rate,
 	return 0;
 }
 
+static int clk_cpu_on_set_rate(struct clk_hw *hwclk, unsigned long rate,
+			       unsigned long parent_rate)
+{
+	u32 reg;
+	unsigned long fabric_div, target_div, cur_rate;
+	struct cpu_clk *cpuclk = to_cpu_clk(hwclk);
+
+	/*
+	 * PMU DFS registers are not mapped, Device Tree does not
+	 * describes them. We cannot change the frequency dynamically.
+	 */
+	if (!cpuclk->pmu_dfs)
+		return -ENODEV;
+
+	cur_rate = __clk_get_rate(hwclk->clk);
+
+	reg = readl(cpuclk->reg_base + SYS_CTRL_CLK_DIVIDER_CTRL2_OFFSET);
+	fabric_div = (reg >> SYS_CTRL_CLK_DIVIDER_CTRL2_NBCLK_RATIO_SHIFT) &
+		SYS_CTRL_CLK_DIVIDER_MASK;
+
+	/* Frequency is going up */
+	if (rate == 2 * cur_rate)
+		target_div = fabric_div / 2;
+	/* Frequency is going down */
+	else
+		target_div = fabric_div;
+
+	if (target_div == 0)
+		target_div = 1;
+
+	reg = readl(cpuclk->pmu_dfs);
+	reg &= ~(PMU_DFS_RATIO_MASK << PMU_DFS_RATIO_SHIFT);
+	reg |= (target_div << PMU_DFS_RATIO_SHIFT);
+	writel(reg, cpuclk->pmu_dfs);
+
+	reg = readl(cpuclk->reg_base + SYS_CTRL_CLK_DIVIDER_CTRL_OFFSET);
+	reg |= (SYS_CTRL_CLK_DIVIDER_CTRL_RESET_ALL <<
+		SYS_CTRL_CLK_DIVIDER_CTRL_RESET_SHIFT);
+	writel(reg, cpuclk->reg_base + SYS_CTRL_CLK_DIVIDER_CTRL_OFFSET);
+
+	return 0;
+}
+
+static int clk_cpu_set_rate(struct clk_hw *hwclk, unsigned long rate,
+			    unsigned long parent_rate)
+{
+	if (__clk_is_enabled(hwclk->clk))
+		return clk_cpu_on_set_rate(hwclk, rate, parent_rate);
+	else
+		return clk_cpu_off_set_rate(hwclk, rate, parent_rate);
+}
+
 static const struct clk_ops cpu_ops = {
 	.recalc_rate = clk_cpu_recalc_rate,
 	.round_rate = clk_cpu_round_rate,
@@ -105,6 +167,7 @@ static void __init of_cpu_clk_setup(struct device_node *node)
 {
 	struct cpu_clk *cpuclk;
 	void __iomem *clock_complex_base = of_iomap(node, 0);
+	void __iomem *pmu_dfs_base = of_iomap(node, 1);
 	int ncpus = 0;
 	struct device_node *dn;
 
@@ -114,6 +177,10 @@ static void __init of_cpu_clk_setup(struct device_node *node)
 		return;
 	}
 
+	if (pmu_dfs_base == NULL)
+		pr_warn("%s: pmu-dfs base register not set, dynamic frequency scaling not available\n",
+			__func__);
+
 	for_each_node_by_type(dn, "cpu")
 		ncpus++;
 
@@ -146,6 +213,8 @@ static void __init of_cpu_clk_setup(struct device_node *node)
 		cpuclk[cpu].clk_name = clk_name;
 		cpuclk[cpu].cpu = cpu;
 		cpuclk[cpu].reg_base = clock_complex_base;
+		if (pmu_dfs_base)
+			cpuclk[cpu].pmu_dfs = pmu_dfs_base + 4 * cpu;
 		cpuclk[cpu].hw.init = &init;
 
 		init.name = cpuclk[cpu].clk_name;
-- 
2.0.0

