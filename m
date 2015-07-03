From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH RFC 3/5] ARM: mvebu: Made the dynamic frequency scaling support more generic
Date: Fri,  3 Jul 2015 08:11:55 +0200
Message-ID: <1435903917-20486-4-git-send-email-gregory.clement@free-electrons.com>
References: <1435903917-20486-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:55198 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752981AbbGCGMO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 3 Jul 2015 02:12:14 -0400
In-Reply-To: <1435903917-20486-1-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Mike Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Boris BREZILLON <boris.brezillon@free-electrons.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>

In preparation to support cpufreq for Armada 38x:

- rename the function to be more generic.

- move masking interrupt to the _dfs_request_local function in order
  to be use by both SoCs.

- add stubs allowing registering the support for a new SoC

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mach-mvebu/pmsu.c | 48 +++++++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index d207f5fc13a6..f19be0ac0068 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -105,6 +105,7 @@ static phys_addr_t pmsu_mp_phys_base;
 static void __iomem *pmsu_mp_base;
 
 static void *mvebu_cpu_resume;
+static int (*mvebu_pmsu_dfs_request_ptr)(int cpu);
 
 static const struct of_device_id of_pmsu_table[] = {
 	{ .compatible = "marvell,armada-370-pmsu", },
@@ -522,6 +523,14 @@ static void mvebu_pmsu_dfs_request_local(void *data)
 
 	local_irq_save(flags);
 
+	/* Clear any previous DFS DONE event */
+	reg = readl(pmsu_mp_base + PMSU_EVENT_STATUS_MSK(cpu));
+	reg &= ~PMSU_EVENT_STATUS_MSK_DFS_DONE;
+
+	/* Mask the DFS done interrupt, since we are going to poll */
+	reg |= PMSU_EVENT_STATUS_MSK_DFS_DONE_MASK;
+	writel(reg, pmsu_mp_base + PMSU_EVENT_STATUS_MSK(cpu));
+
 	/* Prepare to enter idle */
 	reg = readl(pmsu_mp_base + PMSU_STATUS_MSK(cpu));
 	reg |= PMSU_STATUS_MSK_CPU_IDLE_WAIT |
@@ -545,25 +554,20 @@ static void mvebu_pmsu_dfs_request_local(void *data)
 	reg &= ~PMSU_STATUS_MSK_CPU_IDLE_WAIT;
 	writel(reg, pmsu_mp_base + PMSU_STATUS_MSK(cpu));
 
+	/* Restore the DFS mask to its original state */
+	reg = readl(pmsu_mp_base + PMSU_EVENT_STATUS_MSK(cpu));
+	reg &= ~PMSU_EVENT_STATUS_MSK_DFS_DONE_MASK;
+	writel(reg, pmsu_mp_base + PMSU_EVENT_STATUS_MSK(cpu));
+
 	local_irq_restore(flags);
 }
 
-int mvebu_pmsu_dfs_request(int cpu)
+int armada_xp_pmsu_dfs_request(int cpu)
 {
 	unsigned long timeout;
 	int hwcpu = cpu_logical_map(cpu);
 	u32 reg;
 
-	/* Clear any previous DFS DONE event */
-	reg = readl(pmsu_mp_base + PMSU_EVENT_STATUS_AND_MASK(hwcpu));
-	reg &= ~PMSU_EVENT_STATUS_AND_MASK_DFS_DONE;
-	writel(reg, pmsu_mp_base + PMSU_EVENT_STATUS_AND_MASK(hwcpu));
-
-	/* Mask the DFS done interrupt, since we are going to poll */
-	reg = readl(pmsu_mp_base + PMSU_EVENT_STATUS_AND_MASK(hwcpu));
-	reg |= PMSU_EVENT_STATUS_AND_MASK_DFS_DONE_MASK;
-	writel(reg, pmsu_mp_base + PMSU_EVENT_STATUS_AND_MASK(hwcpu));
-
 	/* Trigger the DFS on the appropriate CPU */
 	smp_call_function_single(cpu, mvebu_pmsu_dfs_request_local,
 				 NULL, false);
@@ -579,20 +583,19 @@ int mvebu_pmsu_dfs_request(int cpu)
 
 	if (time_after(jiffies, timeout))
 		return -ETIME;
-
-	/* Restore the DFS mask to its original state */
-	reg = readl(pmsu_mp_base + PMSU_EVENT_STATUS_AND_MASK(hwcpu));
-	reg &= ~PMSU_EVENT_STATUS_AND_MASK_DFS_DONE_MASK;
-	writel(reg, pmsu_mp_base + PMSU_EVENT_STATUS_AND_MASK(hwcpu));
-
 	return 0;
 }
 
-struct cpufreq_dt_platform_data cpufreq_dt_pd = {
+int mvebu_pmsu_dfs_request(int cpu)
+{
+	return mvebu_pmsu_dfs_request_ptr(cpu);
+}
+
+struct cpufreq_dt_platform_data armada_xp_cpufreq_dt_pd = {
 	.independent_clocks = true,
 };
 
-static int __init armada_xp_pmsu_cpufreq_init(void)
+static int __init mvebu_pmsu_cpufreq_init(void)
 {
 	struct device_node *np;
 	struct resource res;
@@ -663,10 +666,11 @@ static int __init armada_xp_pmsu_cpufreq_init(void)
 			return ret;
 		}
 	}
-
+	mvebu_pmsu_dfs_request_ptr = armada_xp_pmsu_dfs_request;
 	platform_device_register_data(NULL, "cpufreq-dt", -1,
-				      &cpufreq_dt_pd, sizeof(cpufreq_dt_pd));
+				      &armada_xp_cpufreq_dt_pd,
+				      sizeof(armada_xp_cpufreq_dt_pd));
 	return 0;
 }
 
-device_initcall(armada_xp_pmsu_cpufreq_init);
+device_initcall(mvebu_pmsu_cpufreq_init);
-- 
2.1.0

