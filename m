From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 3/5] cpufreq: imx6q: Fix regulator/clock error handling
Date: Wed, 28 Oct 2015 08:59:12 +0100
Message-ID: <1446019154-16384-4-git-send-email-s.hauer@pengutronix.de>
References: <1446019154-16384-1-git-send-email-s.hauer@pengutronix.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:60635 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752109AbbJ1H7X (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 28 Oct 2015 03:59:23 -0400
In-Reply-To: <1446019154-16384-1-git-send-email-s.hauer@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, kernel@pengutronix.de, Heiner Kallweit <hkallweit1@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>

When one of the regulator_get/clk_get calls fails the driver just
returns -ENOENT. To properly handle the -EPROBE_DEFER case we have
to forward the actual error value instead. This patch fixes that.

Since all clocks/regulators are global static variables the IS_ERR()
check in the error path in probe() may erroneously work on the values
assigned in the previous probe run. This means we have to reinitialize
the variables between two probe runs().

The probe function already is quite overloaded, so this patch moves
the regulator and clock allocation into a separate function and the
dropping of these resourced into a corresponding cleanup function.
This is easier to review for correctness than the current mix of
reverse-cleanup and !IS_ERR checks at the end of probe().

While at it leave a comment that these resource allocations can't use
devm_* to prevent people from trying to convert it.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/cpufreq/imx6q-cpufreq.c | 170 +++++++++++++++++++++++++---------------
 1 file changed, 106 insertions(+), 64 deletions(-)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index 6fefd19..f81cf8e 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -176,6 +176,103 @@ static struct cpufreq_driver imx6q_cpufreq_driver = {
 	.attr = cpufreq_generic_attr,
 };
 
+static int imx6q_cpufreq_get_resources(void)
+{
+	/*
+	 * Do not use devm_* here. The resources are bound to the
+	 * cpu_dev and not to this drivers platform_device.
+	 */
+	arm_clk = clk_get(cpu_dev, "arm");
+	if (IS_ERR(arm_clk))
+		return PTR_ERR(arm_clk);
+
+	pll1_sys_clk = clk_get(cpu_dev, "pll1_sys");
+	if (IS_ERR(pll1_sys_clk))
+		return PTR_ERR(pll1_sys_clk);
+
+	pll1_sw_clk = clk_get(cpu_dev, "pll1_sw");
+	if (IS_ERR(pll1_sw_clk))
+		return PTR_ERR(pll1_sw_clk);
+
+	step_clk = clk_get(cpu_dev, "step");
+	if (IS_ERR(step_clk))
+		return PTR_ERR(step_clk);
+
+	pll2_pfd2_396m_clk = clk_get(cpu_dev, "pll2_pfd2_396m");
+	if (IS_ERR(pll2_pfd2_396m_clk))
+		return PTR_ERR(pll2_pfd2_396m_clk);
+
+	if (of_machine_is_compatible("fsl,imx6ul")) {
+		pll2_bus_clk = clk_get(cpu_dev, "pll2_bus");
+		if (IS_ERR(pll2_bus_clk))
+			return PTR_ERR(pll2_bus_clk);
+
+		secondary_sel_clk = clk_get(cpu_dev, "secondary_sel");
+		if (IS_ERR(secondary_sel_clk))
+			return PTR_ERR(secondary_sel_clk);
+	}
+
+	arm_reg = regulator_get(cpu_dev, "arm");
+	if (IS_ERR(arm_reg))
+		return PTR_ERR(arm_reg);
+
+	pu_reg = regulator_get_optional(cpu_dev, "pu");
+
+	soc_reg = regulator_get(cpu_dev, "soc");
+	if (IS_ERR(soc_reg))
+		return PTR_ERR(soc_reg);
+
+	return 0;
+}
+
+
+static void imx6q_cpufreq_put_resources(void)
+{
+	/*
+	 * Set all resources to NULL here so that they are correctly
+	 * initialized next time we enter probe()
+	 */
+	if (!IS_ERR_OR_NULL(arm_reg))
+		regulator_put(arm_reg);
+	arm_reg = NULL;
+
+	if (!IS_ERR_OR_NULL(pu_reg))
+		regulator_put(pu_reg);
+	pu_reg = NULL;
+
+	if (!IS_ERR_OR_NULL(soc_reg))
+		regulator_put(soc_reg);
+	soc_reg = NULL;
+
+	if (!IS_ERR_OR_NULL(arm_clk))
+		clk_put(arm_clk);
+	arm_clk = NULL;
+
+	if (!IS_ERR_OR_NULL(pll1_sys_clk))
+		clk_put(pll1_sys_clk);
+	pll1_sys_clk = NULL;
+
+	if (!IS_ERR_OR_NULL(pll1_sw_clk))
+		clk_put(pll1_sw_clk);
+	pll1_sw_clk = NULL;
+
+	if (!IS_ERR_OR_NULL(step_clk))
+		clk_put(step_clk);
+	step_clk = NULL;
+
+	if (!IS_ERR_OR_NULL(pll2_pfd2_396m_clk))
+		clk_put(pll2_pfd2_396m_clk);
+	pll2_pfd2_396m_clk = NULL;
+
+	if (!IS_ERR_OR_NULL(pll2_bus_clk))
+		clk_put(pll2_bus_clk);
+	pll2_bus_clk = NULL;
+
+	if (!IS_ERR_OR_NULL(secondary_sel_clk))
+		clk_put(secondary_sel_clk);
+	secondary_sel_clk = NULL;
+}
+
 static int imx6q_cpufreq_probe(struct platform_device *pdev)
 {
 	struct device_node *np;
@@ -198,36 +295,9 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
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
-	if (of_machine_is_compatible("fsl,imx6ul")) {
-		pll2_bus_clk = clk_get(cpu_dev, "pll2_bus");
-		secondary_sel_clk = clk_get(cpu_dev, "secondary_sel");
-		if (IS_ERR(pll2_bus_clk) || IS_ERR(secondary_sel_clk)) {
-			dev_err(cpu_dev, "failed to get clocks specific to imx6ul\n");
-			ret = -ENOENT;
-			goto put_clk;
-		}
-	}
-
-	arm_reg = regulator_get(cpu_dev, "arm");
-	pu_reg = regulator_get_optional(cpu_dev, "pu");
-	soc_reg = regulator_get(cpu_dev, "soc");
-	if (IS_ERR(arm_reg) || IS_ERR(soc_reg)) {
-		dev_err(cpu_dev, "failed to get regulators\n");
-		ret = -ENOENT;
-		goto put_reg;
-	}
+	ret = imx6q_cpufreq_get_resources();
+	if (ret)
+		goto drop_resources;
 
 	/*
 	 * We expect an OPP table supplied by platform.
@@ -239,7 +309,7 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
 		ret = dev_pm_opp_of_add_table(cpu_dev);
 		if (ret < 0) {
 			dev_err(cpu_dev, "failed to init OPP table: %d\n", ret);
-			goto put_reg;
+			goto drop_resources;
 		}
 
 		/* Because we have added the OPPs here, we must free them */
@@ -348,28 +418,9 @@ free_freq_table:
 out_free_opp:
 	if (free_opp)
 		dev_pm_opp_of_remove_table(cpu_dev);
-put_reg:
-	if (!IS_ERR(arm_reg))
-		regulator_put(arm_reg);
-	if (!IS_ERR(pu_reg))
-		regulator_put(pu_reg);
-	if (!IS_ERR(soc_reg))
-		regulator_put(soc_reg);
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
+drop_resources:
+	imx6q_cpufreq_put_resources();
+
 	of_node_put(np);
 	return ret;
 }
@@ -380,17 +431,8 @@ static int imx6q_cpufreq_remove(struct platform_device *pdev)
 	dev_pm_opp_free_cpufreq_table(cpu_dev, &freq_table);
 	if (free_opp)
 		dev_pm_opp_of_remove_table(cpu_dev);
-	regulator_put(arm_reg);
-	if (!IS_ERR(pu_reg))
-		regulator_put(pu_reg);
-	regulator_put(soc_reg);
-	clk_put(arm_clk);
-	clk_put(pll1_sys_clk);
-	clk_put(pll1_sw_clk);
-	clk_put(step_clk);
-	clk_put(pll2_pfd2_396m_clk);
-	clk_put(pll2_bus_clk);
-	clk_put(secondary_sel_clk);
+
+	imx6q_cpufreq_put_resources();
 
 	return 0;
 }
-- 
2.6.1

