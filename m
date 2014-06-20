From: Anson Huang <b20788@freescale.com>
Subject: [PATCH V2] cpufreq: imx6: remove pu regulator dependency for SOCs with no PU regulator
Date: Fri, 20 Jun 2014 15:42:18 +0800
Message-ID: <1403250138-25030-1-git-send-email-b20788@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from [207.46.163.140] ([207.46.163.140]:57820 "EHLO
	na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S934161AbaFTHoM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 20 Jun 2014 03:44:12 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org, shawn.guo@freescale.com
Cc: linux-pm@vger.kernel.org

PU regulator is not a necessary regulator for cpufreq, not all
i.MX6 SoCs have PU regulator, only if SOC has PU regulator, then its
voltage must be equal to SOC regulator, so remove the dependency
to support i.MX6SX which has no PU regulator.

Signed-off-by: Anson Huang <b20788@freescale.com>
---
 drivers/cpufreq/imx6q-cpufreq.c |   35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index af366c2..c2d3076 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -66,10 +66,12 @@ static int imx6q_set_target(struct cpufreq_policy *policy, unsigned int index)
 
 	/* scaling up?  scale voltage before frequency */
 	if (new_freq > old_freq) {
-		ret = regulator_set_voltage_tol(pu_reg, imx6_soc_volt[index], 0);
-		if (ret) {
-			dev_err(cpu_dev, "failed to scale vddpu up: %d\n", ret);
-			return ret;
+		if (!IS_ERR(pu_reg)) {
+			ret = regulator_set_voltage_tol(pu_reg, imx6_soc_volt[index], 0);
+			if (ret) {
+				dev_err(cpu_dev, "failed to scale vddpu up: %d\n", ret);
+				return ret;
+			}
 		}
 		ret = regulator_set_voltage_tol(soc_reg, imx6_soc_volt[index], 0);
 		if (ret) {
@@ -121,10 +123,12 @@ static int imx6q_set_target(struct cpufreq_policy *policy, unsigned int index)
 			dev_warn(cpu_dev, "failed to scale vddsoc down: %d\n", ret);
 			ret = 0;
 		}
-		ret = regulator_set_voltage_tol(pu_reg, imx6_soc_volt[index], 0);
-		if (ret) {
-			dev_warn(cpu_dev, "failed to scale vddpu down: %d\n", ret);
-			ret = 0;
+		if (!IS_ERR(pu_reg)) {
+			ret = regulator_set_voltage_tol(pu_reg, imx6_soc_volt[index], 0);
+			if (ret) {
+				dev_warn(cpu_dev, "failed to scale vddpu down: %d\n", ret);
+				ret = 0;
+			}
 		}
 	}
 
@@ -182,9 +186,9 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
 	}
 
 	arm_reg = regulator_get(cpu_dev, "arm");
-	pu_reg = regulator_get(cpu_dev, "pu");
+	pu_reg = regulator_get_optional(cpu_dev, "pu");
 	soc_reg = regulator_get(cpu_dev, "soc");
-	if (IS_ERR(arm_reg) || IS_ERR(pu_reg) || IS_ERR(soc_reg)) {
+	if (IS_ERR(arm_reg) || IS_ERR(soc_reg)) {
 		dev_err(cpu_dev, "failed to get regulators\n");
 		ret = -ENOENT;
 		goto put_reg;
@@ -268,9 +272,11 @@ soc_opp_out:
 	ret = regulator_set_voltage_time(soc_reg, imx6_soc_volt[0], imx6_soc_volt[num - 1]);
 	if (ret > 0)
 		transition_latency += ret * 1000;
-	ret = regulator_set_voltage_time(pu_reg, imx6_soc_volt[0], imx6_soc_volt[num - 1]);
-	if (ret > 0)
-		transition_latency += ret * 1000;
+	if (!IS_ERR(pu_reg)) {
+		ret = regulator_set_voltage_time(pu_reg, imx6_soc_volt[0], imx6_soc_volt[num - 1]);
+		if (ret > 0)
+			transition_latency += ret * 1000;
+	}
 
 	/*
 	 * OPP is maintained in order of increasing frequency, and
@@ -327,7 +333,8 @@ static int imx6q_cpufreq_remove(struct platform_device *pdev)
 	cpufreq_unregister_driver(&imx6q_cpufreq_driver);
 	dev_pm_opp_free_cpufreq_table(cpu_dev, &freq_table);
 	regulator_put(arm_reg);
-	regulator_put(pu_reg);
+	if (!IS_ERR(pu_reg))
+		regulator_put(pu_reg);
 	regulator_put(soc_reg);
 	clk_put(arm_clk);
 	clk_put(pll1_sys_clk);
-- 
1.7.9.5

