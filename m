From: Bai Ping <b51503@freescale.com>
Subject: [PATCH v2] cpufreq: imx: update the clock switch flow to support imx6ul
Date: Fri, 11 Sep 2015 23:41:05 +0800
Message-ID: <1441986065-8821-1-git-send-email-b51503@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bn1bn0108.outbound.protection.outlook.com ([157.56.110.108]:15968
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751296AbbIKHhl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 11 Sep 2015 03:37:41 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: viresh.kumar@linaro.org
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

For i.MX6UL, the clock switch flow is slightly different from
other i.MX6 SOCs. It has a 'secondary_sel' clk that will be used
when the CPU freq is higher than 396MHz. So the clock switch flow in
'set_target' callback need to update to support i.MX6UL in the common
i.MX6 SOC cpufreq driver.

Signed-off-by: Bai Ping <b51503@freescale.com>
---

change for v2:
  add the missed 'clk_put' in imx6q_cpufreq_remove().

 drivers/cpufreq/imx6q-cpufreq.c | 50 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 45 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index 380a90d..9b4a7bd 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -30,6 +30,10 @@ static struct clk *pll1_sw_clk;
 static struct clk *step_clk;
 static struct clk *pll2_pfd2_396m_clk;
 
+/* clk used by i.MX6UL */
+static struct clk *pll2_bus_clk;
+static struct clk *secondary_sel_clk;
+
 static struct device *cpu_dev;
 static bool free_opp;
 static struct cpufreq_frequency_table *freq_table;
@@ -91,16 +95,36 @@ static int imx6q_set_target(struct cpufreq_policy *policy, unsigned int index)
 	 * The setpoints are selected per PLL/PDF frequencies, so we need to
 	 * reprogram PLL for frequency scaling.  The procedure of reprogramming
 	 * PLL1 is as below.
-	 *
+	 * For i.MX6UL, it has a secondary clk mux, the cpu frequency change
+	 * flow is slightly different from other i.MX6 OSC.
+	 * The cpu frequeny change flow for i.MX6(except i.MX6UL) is as below:
 	 *  - Enable pll2_pfd2_396m_clk and reparent pll1_sw_clk to it
 	 *  - Reprogram pll1_sys_clk and reparent pll1_sw_clk back to it
 	 *  - Disable pll2_pfd2_396m_clk
 	 */
-	clk_set_parent(step_clk, pll2_pfd2_396m_clk);
-	clk_set_parent(pll1_sw_clk, step_clk);
-	if (freq_hz > clk_get_rate(pll2_pfd2_396m_clk)) {
-		clk_set_rate(pll1_sys_clk, new_freq * 1000);
+	if (of_machine_is_compatible("fsl,imx6ul")) {
+		/*
+		 * When changing pll1_sw_clk's parent to pll1_sys_clk,
+		 * CPU may run at higher than 528MHz, this will lead to
+		 * the system unstable if the voltage is lower than the
+		 * voltage of 528MHz, so lower the CPU frequency to one
+		 * half before changing CPU frequency.
+		 */
+		clk_set_rate(arm_clk, (old_freq >> 1) * 1000);
 		clk_set_parent(pll1_sw_clk, pll1_sys_clk);
+		if (freq_hz > clk_get_rate(pll2_pfd2_396m_clk))
+			clk_set_parent(secondary_sel_clk, pll2_bus_clk);
+		else
+			clk_set_parent(secondary_sel_clk, pll2_pfd2_396m_clk);
+		clk_set_parent(step_clk, secondary_sel_clk);
+		clk_set_parent(pll1_sw_clk, step_clk);
+	} else {
+		clk_set_parent(step_clk, pll2_pfd2_396m_clk);
+		clk_set_parent(pll1_sw_clk, step_clk);
+		if (freq_hz > clk_get_rate(pll2_pfd2_396m_clk)) {
+			clk_set_rate(pll1_sys_clk, new_freq * 1000);
+			clk_set_parent(pll1_sw_clk, pll1_sys_clk);
+		}
 	}
 
 	/* Ensure the arm clock divider is what we expect */
@@ -186,6 +210,16 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
 		goto put_clk;
 	}
 
+	if (of_machine_is_compatible("fsl,imx6ul")) {
+		pll2_bus_clk = clk_get(cpu_dev, "pll2_bus");
+		secondary_sel_clk = clk_get(cpu_dev, "secondary_sel");
+		if (IS_ERR(pll2_bus_clk) || IS_ERR(secondary_sel_clk)) {
+			dev_err(cpu_dev, "failed to get clocks specific to imx6ul\n");
+			ret = -ENOENT;
+			goto put_clk;
+		}
+	}
+
 	arm_reg = regulator_get(cpu_dev, "arm");
 	pu_reg = regulator_get_optional(cpu_dev, "pu");
 	soc_reg = regulator_get(cpu_dev, "soc");
@@ -331,6 +365,10 @@ put_clk:
 		clk_put(step_clk);
 	if (!IS_ERR(pll2_pfd2_396m_clk))
 		clk_put(pll2_pfd2_396m_clk);
+	if (!IS_ERR(pll2_bus_clk))
+		clk_put(pll2_bus_clk);
+	if (!IS_ERR(secondary_sel_clk))
+		clk_put(secondary_sel_clk);
 	of_node_put(np);
 	return ret;
 }
@@ -350,6 +388,8 @@ static int imx6q_cpufreq_remove(struct platform_device *pdev)
 	clk_put(pll1_sw_clk);
 	clk_put(step_clk);
 	clk_put(pll2_pfd2_396m_clk);
+	clk_put(pll2_bus_clk);
+	clk_put(secondary_sel_clk);
 
 	return 0;
 }
-- 
1.9.1

