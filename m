From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Subject: [PATCH v2 3/5] ARM: vexpress/TC2: add cpu clock support
Date: Mon, 21 Oct 2013 10:58:52 +0100
Message-ID: <1382349534-31502-4-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1382349534-31502-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:36425 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753082Ab3JUJ7F (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Oct 2013 05:59:05 -0400
In-Reply-To: <1382349534-31502-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Sudeep.KarkadaNagesha@arm.com, Pawel Moll <pawel.moll@arm.com>, Nicolas Pitre <nico@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>, Pawel Moll <Pawel.Moll@arm.com>

From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

On TC2, the cpu clocks are controlled by the external M3 microcontroller
and SPC provides the interface between the CPU and the power controller.

The generic cpufreq drivers use the clock APIs to get the cpu clocks.
This patch add virtual spc clocks for all the cpus to control the cpu
operating frequency via the clock framework.

Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
Acked-by: Nicolas Pitre <nico@linaro.org>
Cc: Pawel Moll <Pawel.Moll@arm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/mach-vexpress/spc.c | 102 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/arch/arm/mach-vexpress/spc.c b/arch/arm/mach-vexpress/spc.c
index 0b027dc..bd7c2ea 100644
--- a/arch/arm/mach-vexpress/spc.c
+++ b/arch/arm/mach-vexpress/spc.c
@@ -17,6 +17,9 @@
  * GNU General Public License for more details.
  */
 
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
+#include <linux/cpu.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
@@ -438,3 +441,102 @@ int __init ve_spc_init(void __iomem *baseaddr, u32 a15_clusid, int irq)
 
 	return 0;
 }
+
+struct clk_spc {
+	struct clk_hw hw;
+	int cluster;
+};
+
+#define to_clk_spc(spc) container_of(spc, struct clk_spc, hw)
+static unsigned long spc_recalc_rate(struct clk_hw *hw,
+		unsigned long parent_rate)
+{
+	struct clk_spc *spc = to_clk_spc(hw);
+	u32 freq;
+
+	if (ve_spc_get_performance(spc->cluster, &freq))
+		return -EIO;
+
+	return freq * 1000;
+}
+
+static long spc_round_rate(struct clk_hw *hw, unsigned long drate,
+		unsigned long *parent_rate)
+{
+	struct clk_spc *spc = to_clk_spc(hw);
+
+	return ve_spc_round_performance(spc->cluster, drate);
+}
+
+static int spc_set_rate(struct clk_hw *hw, unsigned long rate,
+		unsigned long parent_rate)
+{
+	struct clk_spc *spc = to_clk_spc(hw);
+
+	return ve_spc_set_performance(spc->cluster, rate / 1000);
+}
+
+static struct clk_ops clk_spc_ops = {
+	.recalc_rate = spc_recalc_rate,
+	.round_rate = spc_round_rate,
+	.set_rate = spc_set_rate,
+};
+
+static struct clk *ve_spc_clk_register(struct device *cpu_dev)
+{
+	struct clk_init_data init;
+	struct clk_spc *spc;
+
+	spc = kzalloc(sizeof(*spc), GFP_KERNEL);
+	if (!spc) {
+		pr_err("could not allocate spc clk\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	spc->hw.init = &init;
+	spc->cluster = topology_physical_package_id(cpu_dev->id);
+
+	init.name = dev_name(cpu_dev);
+	init.ops = &clk_spc_ops;
+	init.flags = CLK_IS_ROOT | CLK_GET_RATE_NOCACHE;
+	init.num_parents = 0;
+
+	return devm_clk_register(cpu_dev, &spc->hw);
+}
+
+static int __init ve_spc_clk_init(void)
+{
+	int cpu;
+	struct clk *clk;
+
+	if (!info)
+		return 0; /* Continue only if SPC is initialised */
+
+	if (ve_spc_populate_opps(0) || ve_spc_populate_opps(1)) {
+		pr_err("failed to build OPP table\n");
+		return -ENODEV;
+	}
+
+	for_each_possible_cpu(cpu) {
+		struct device *cpu_dev = get_cpu_device(cpu);
+		if (!cpu_dev) {
+			pr_warn("failed to get cpu%d device\n", cpu);
+			continue;
+		}
+		clk = ve_spc_clk_register(cpu_dev);
+		if (IS_ERR(clk)) {
+			pr_warn("failed to register cpu%d clock\n", cpu);
+			continue;
+		}
+		if (clk_register_clkdev(clk, NULL, dev_name(cpu_dev))) {
+			pr_warn("failed to register cpu%d clock lookup\n", cpu);
+			continue;
+		}
+
+		if (ve_init_opp_table(cpu_dev))
+			pr_warn("failed to initialise cpu%d opp table\n", cpu);
+	}
+
+	return 0;
+}
+module_init(ve_spc_clk_init);
-- 
1.8.1.2

