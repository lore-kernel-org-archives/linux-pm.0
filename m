From: Heiner Kallweit <heiner.kallweit@web.de>
Subject: [PATCH 2/2] cpufreq: imx: fix regulator_get_optional error handling
Date: Sun, 18 Oct 2015 13:23:29 +0200
Message-ID: <56238131.7010907@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.11]:54393 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752356AbbJRL0v (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 18 Oct 2015 07:26:51 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org

Properly handle the case that regulator_get_optional returns -EPROBE_DEFER
and ignore other errors.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/cpufreq/imx6q-cpufreq.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index 0bb33dc..67dc81c 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -67,7 +67,7 @@ static int imx6q_set_target(struct cpufreq_policy *policy, unsigned int index)
 
 	/* scaling up?  scale voltage before frequency */
 	if (new_freq > old_freq) {
-		if (!IS_ERR(pu_reg)) {
+		if (pu_reg) {
 			ret = regulator_set_voltage_tol(pu_reg, imx6_soc_volt[index], 0);
 			if (ret) {
 				dev_err(cpu_dev, "failed to scale vddpu up: %d\n", ret);
@@ -124,7 +124,7 @@ static int imx6q_set_target(struct cpufreq_policy *policy, unsigned int index)
 			dev_warn(cpu_dev, "failed to scale vddsoc down: %d\n", ret);
 			ret = 0;
 		}
-		if (!IS_ERR(pu_reg)) {
+		if (pu_reg) {
 			ret = regulator_set_voltage_tol(pu_reg, imx6_soc_volt[index], 0);
 			if (ret) {
 				dev_warn(cpu_dev, "failed to scale vddpu down: %d\n", ret);
@@ -195,6 +195,13 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
 	}
 
 	pu_reg = regulator_get_optional(cpu_dev, "pu");
+	if (IS_ERR(pu_reg)) {
+		if (PTR_ERR(pu_reg) == -EPROBE_DEFER) {
+			ret = -EPROBE_DEFER;
+			goto put_reg;
+		} else
+			pu_reg = NULL;
+	}
 
 	soc_reg = regulator_get(cpu_dev, "soc");
 	if (IS_ERR(soc_reg)) {
@@ -285,7 +292,7 @@ soc_opp_out:
 	ret = regulator_set_voltage_time(soc_reg, imx6_soc_volt[0], imx6_soc_volt[num - 1]);
 	if (ret > 0)
 		transition_latency += ret * 1000;
-	if (!IS_ERR(pu_reg)) {
+	if (pu_reg) {
 		ret = regulator_set_voltage_time(pu_reg, imx6_soc_volt[0], imx6_soc_volt[num - 1]);
 		if (ret > 0)
 			transition_latency += ret * 1000;
@@ -325,7 +332,7 @@ out_free_opp:
 put_reg:
 	if (!IS_ERR(arm_reg))
 		regulator_put(arm_reg);
-	if (!IS_ERR(pu_reg))
+	if (!IS_ERR_OR_NULL(pu_reg))
 		regulator_put(pu_reg);
 	if (!IS_ERR(soc_reg))
 		regulator_put(soc_reg);
@@ -351,7 +358,7 @@ static int imx6q_cpufreq_remove(struct platform_device *pdev)
 	if (free_opp)
 		of_free_opp_table(cpu_dev);
 	regulator_put(arm_reg);
-	if (!IS_ERR(pu_reg))
+	if (pu_reg)
 		regulator_put(pu_reg);
 	regulator_put(soc_reg);
 	clk_put(arm_clk);
-- 
2.6.1


