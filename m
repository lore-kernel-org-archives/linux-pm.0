From: Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH RESEND 1/1] cpufreq: imx6q: switch to Use clk_bulk_get to refine clk operations
Date: Thu, 31 Aug 2017 19:43:57 +0800
Message-ID: <1504179837-18842-1-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-co1nam03on0059.outbound.protection.outlook.com ([104.47.40.59]:13167
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751074AbdHaLoO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 31 Aug 2017 07:44:14 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, vireshk@kernel.org, rjw@rjwysocki.net, shawnguo@kernel.org, Anson.Huang@nxp.com, Dong Aisheng <aisheng.dong@nxp.com>, Viresh Kumar <viresh.kumar@linaro.org>, Anson Huang <anson.huang@nxp.com>, Leonard Crestez <leonard.crestez@nxp.com>

Use clk_bulk_get to ease the driver clocks handling.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Anson Huang <anson.huang@nxp.com>
Cc: Leonard Crestez <leonard.crestez@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
--
The original one is here which depends on clk_bulk APIs.
https://patchwork.kernel.org/patch/9737337/
Now the clk_bulk APIs are already in kernel, so resend the patch.
(Patch title changed a bit to be more specific.)
---
 drivers/cpufreq/imx6q-cpufreq.c | 125 ++++++++++++++++++----------------------
 1 file changed, 56 insertions(+), 69 deletions(-)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index 14466a9..c5c0af3 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -24,15 +24,29 @@ static struct regulator *arm_reg;
 static struct regulator *pu_reg;
 static struct regulator *soc_reg;
 
-static struct clk *arm_clk;
-static struct clk *pll1_sys_clk;
-static struct clk *pll1_sw_clk;
-static struct clk *step_clk;
-static struct clk *pll2_pfd2_396m_clk;
-
-/* clk used by i.MX6UL */
-static struct clk *pll2_bus_clk;
-static struct clk *secondary_sel_clk;
+enum IMX6_CPUFREQ_CLKS {
+	ARM,
+	PLL1_SYS,
+	STEP,
+	PLL1_SW,
+	PLL2_PFD2_396M,
+	/* MX6UL requires two more clks */
+	PLL2_BUS,
+	SECONDARY_SEL,
+};
+#define IMX6Q_CPUFREQ_CLK_NUM		5
+#define IMX6UL_CPUFREQ_CLK_NUM		7
+
+static int num_clks;
+static struct clk_bulk_data clks[] = {
+	{ .id = "arm" },
+	{ .id = "pll1_sys" },
+	{ .id = "step" },
+	{ .id = "pll1_sw" },
+	{ .id = "pll2_pfd2_396m" },
+	{ .id = "pll2_bus" },
+	{ .id = "secondary_sel" },
+};
 
 static struct device *cpu_dev;
 static bool free_opp;
@@ -52,7 +66,7 @@ static int imx6q_set_target(struct cpufreq_policy *policy, unsigned int index)
 
 	new_freq = freq_table[index].frequency;
 	freq_hz = new_freq * 1000;
-	old_freq = clk_get_rate(arm_clk) / 1000;
+	old_freq = clk_get_rate(clks[ARM].clk) / 1000;
 
 	opp = dev_pm_opp_find_freq_ceil(cpu_dev, &freq_hz);
 	if (IS_ERR(opp)) {
@@ -111,29 +125,31 @@ static int imx6q_set_target(struct cpufreq_policy *policy, unsigned int index)
 		 * voltage of 528MHz, so lower the CPU frequency to one
 		 * half before changing CPU frequency.
 		 */
-		clk_set_rate(arm_clk, (old_freq >> 1) * 1000);
-		clk_set_parent(pll1_sw_clk, pll1_sys_clk);
-		if (freq_hz > clk_get_rate(pll2_pfd2_396m_clk))
-			clk_set_parent(secondary_sel_clk, pll2_bus_clk);
+		clk_set_rate(clks[ARM].clk, (old_freq >> 1) * 1000);
+		clk_set_parent(clks[PLL1_SW].clk, clks[PLL1_SYS].clk);
+		if (freq_hz > clk_get_rate(clks[PLL2_PFD2_396M].clk))
+			clk_set_parent(clks[SECONDARY_SEL].clk,
+				       clks[PLL2_BUS].clk);
 		else
-			clk_set_parent(secondary_sel_clk, pll2_pfd2_396m_clk);
-		clk_set_parent(step_clk, secondary_sel_clk);
-		clk_set_parent(pll1_sw_clk, step_clk);
+			clk_set_parent(clks[SECONDARY_SEL].clk,
+				       clks[PLL2_PFD2_396M].clk);
+		clk_set_parent(clks[STEP].clk, clks[SECONDARY_SEL].clk);
+		clk_set_parent(clks[PLL1_SW].clk, clks[STEP].clk);
 	} else {
-		clk_set_parent(step_clk, pll2_pfd2_396m_clk);
-		clk_set_parent(pll1_sw_clk, step_clk);
-		if (freq_hz > clk_get_rate(pll2_pfd2_396m_clk)) {
-			clk_set_rate(pll1_sys_clk, new_freq * 1000);
-			clk_set_parent(pll1_sw_clk, pll1_sys_clk);
+		clk_set_parent(clks[STEP].clk, clks[PLL2_PFD2_396M].clk);
+		clk_set_parent(clks[PLL1_SW].clk, clks[STEP].clk);
+		if (freq_hz > clk_get_rate(clks[PLL2_PFD2_396M].clk)) {
+			clk_set_rate(clks[PLL1_SYS].clk, new_freq * 1000);
+			clk_set_parent(clks[PLL1_SW].clk, clks[PLL1_SYS].clk);
 		} else {
 			/* pll1_sys needs to be enabled for divider rate change to work. */
 			pll1_sys_temp_enabled = true;
-			clk_prepare_enable(pll1_sys_clk);
+			clk_prepare_enable(clks[PLL1_SYS].clk);
 		}
 	}
 
 	/* Ensure the arm clock divider is what we expect */
-	ret = clk_set_rate(arm_clk, new_freq * 1000);
+	ret = clk_set_rate(clks[ARM].clk, new_freq * 1000);
 	if (ret) {
 		dev_err(cpu_dev, "failed to set clock rate: %d\n", ret);
 		regulator_set_voltage_tol(arm_reg, volt_old, 0);
@@ -142,7 +158,7 @@ static int imx6q_set_target(struct cpufreq_policy *policy, unsigned int index)
 
 	/* PLL1 is only needed until after ARM-PODF is set. */
 	if (pll1_sys_temp_enabled)
-		clk_disable_unprepare(pll1_sys_clk);
+		clk_disable_unprepare(clks[PLL1_SYS].clk);
 
 	/* scaling down?  scale voltage after frequency */
 	if (new_freq < old_freq) {
@@ -173,7 +189,7 @@ static int imx6q_cpufreq_init(struct cpufreq_policy *policy)
 {
 	int ret;
 
-	policy->clk = arm_clk;
+	policy->clk = clks[ARM].clk;
 	ret = cpufreq_generic_init(policy, freq_table, transition_latency);
 	policy->suspend_freq = policy->max;
 
@@ -213,28 +229,15 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
 		return -ENOENT;
 	}
 
-	arm_clk = clk_get(cpu_dev, "arm");
-	pll1_sys_clk = clk_get(cpu_dev, "pll1_sys");
-	pll1_sw_clk = clk_get(cpu_dev, "pll1_sw");
-	step_clk = clk_get(cpu_dev, "step");
-	pll2_pfd2_396m_clk = clk_get(cpu_dev, "pll2_pfd2_396m");
-	if (IS_ERR(arm_clk) || IS_ERR(pll1_sys_clk) || IS_ERR(pll1_sw_clk) ||
-	    IS_ERR(step_clk) || IS_ERR(pll2_pfd2_396m_clk)) {
-		dev_err(cpu_dev, "failed to get clocks\n");
-		ret = -ENOENT;
-		goto put_clk;
-	}
-
 	if (of_machine_is_compatible("fsl,imx6ul") ||
-	    of_machine_is_compatible("fsl,imx6ull")) {
-		pll2_bus_clk = clk_get(cpu_dev, "pll2_bus");
-		secondary_sel_clk = clk_get(cpu_dev, "secondary_sel");
-		if (IS_ERR(pll2_bus_clk) || IS_ERR(secondary_sel_clk)) {
-			dev_err(cpu_dev, "failed to get clocks specific to imx6ul\n");
-			ret = -ENOENT;
-			goto put_clk;
-		}
-	}
+	    of_machine_is_compatible("fsl,imx6ull"))
+		num_clks = IMX6UL_CPUFREQ_CLK_NUM;
+	else
+		num_clks = IMX6Q_CPUFREQ_CLK_NUM;
+
+	ret = clk_bulk_get(cpu_dev, num_clks, clks);
+	if (ret)
+		goto put_node;
 
 	arm_reg = regulator_get(cpu_dev, "arm");
 	pu_reg = regulator_get_optional(cpu_dev, "pu");
@@ -378,22 +381,11 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
 		regulator_put(pu_reg);
 	if (!IS_ERR(soc_reg))
 		regulator_put(soc_reg);
-put_clk:
-	if (!IS_ERR(arm_clk))
-		clk_put(arm_clk);
-	if (!IS_ERR(pll1_sys_clk))
-		clk_put(pll1_sys_clk);
-	if (!IS_ERR(pll1_sw_clk))
-		clk_put(pll1_sw_clk);
-	if (!IS_ERR(step_clk))
-		clk_put(step_clk);
-	if (!IS_ERR(pll2_pfd2_396m_clk))
-		clk_put(pll2_pfd2_396m_clk);
-	if (!IS_ERR(pll2_bus_clk))
-		clk_put(pll2_bus_clk);
-	if (!IS_ERR(secondary_sel_clk))
-		clk_put(secondary_sel_clk);
+
+	clk_bulk_put(num_clks, clks);
+put_node:
 	of_node_put(np);
+
 	return ret;
 }
 
@@ -407,13 +399,8 @@ static int imx6q_cpufreq_remove(struct platform_device *pdev)
 	if (!IS_ERR(pu_reg))
 		regulator_put(pu_reg);
 	regulator_put(soc_reg);
-	clk_put(arm_clk);
-	clk_put(pll1_sys_clk);
-	clk_put(pll1_sw_clk);
-	clk_put(step_clk);
-	clk_put(pll2_pfd2_396m_clk);
-	clk_put(pll2_bus_clk);
-	clk_put(secondary_sel_clk);
+
+	clk_bulk_put(num_clks, clks);
 
 	return 0;
 }
-- 
2.7.4
