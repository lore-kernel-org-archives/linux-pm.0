From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 4/4] cpufreq: imx6q: check regulator_get_optional return value
Date: Thu, 22 Oct 2015 10:47:32 +0200
Message-ID: <1445503652-777-5-git-send-email-s.hauer@pengutronix.de>
References: <1445503652-777-1-git-send-email-s.hauer@pengutronix.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:41341 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756964AbbJVIr6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 22 Oct 2015 04:47:58 -0400
In-Reply-To: <1445503652-777-1-git-send-email-s.hauer@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, kernel@pengutronix.de, Heiner Kallweit <hkallweit1@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>

While pu_reg is an optional regulator we still have to check
the return value for -EPROBE_DEFER to properly detect the
case when we have a pu regulator but it is not yet present.

While at it, set pu_reg to NULL for an erroneous regulator
so that we can check for the regulator with if (pu_reg)
instead of the slightly less readable IS_ERR().

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/cpufreq/imx6q-cpufreq.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index ce0c6bd..b643614 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -71,7 +71,7 @@ static int imx6q_set_target(struct cpufreq_policy *policy, unsigned int index)
 
 	/* scaling up?  scale voltage before frequency */
 	if (new_freq > old_freq) {
-		if (!IS_ERR(pu_reg)) {
+		if (pu_reg) {
 			ret = regulator_set_voltage_tol(pu_reg, imx6_soc_volt[index], 0);
 			if (ret) {
 				dev_err(cpu_dev, "failed to scale vddpu up: %d\n", ret);
@@ -148,7 +148,7 @@ static int imx6q_set_target(struct cpufreq_policy *policy, unsigned int index)
 			dev_warn(cpu_dev, "failed to scale vddsoc down: %d\n", ret);
 			ret = 0;
 		}
-		if (!IS_ERR(pu_reg)) {
+		if (pu_reg) {
 			ret = regulator_set_voltage_tol(pu_reg, imx6_soc_volt[index], 0);
 			if (ret) {
 				dev_warn(cpu_dev, "failed to scale vddpu down: %d\n", ret);
@@ -217,6 +217,11 @@ static int imx6q_cpufreq_get_resources(struct platform_device *pdev)
 		return PTR_ERR(arm_reg);
 
 	pu_reg = regulator_get_optional(cpu_dev, "pu");
+	if (IS_ERR(pu_reg)) {
+		if (PTR_ERR(pu_reg) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+		pu_reg = NULL;
+	}
 
 	soc_reg = regulator_get(cpu_dev, "soc");
 	if (IS_ERR(soc_reg))
@@ -377,7 +382,7 @@ soc_opp_out:
 	ret = regulator_set_voltage_time(soc_reg, imx6_soc_volt[0], imx6_soc_volt[num - 1]);
 	if (ret > 0)
 		transition_latency += ret * 1000;
-	if (!IS_ERR(pu_reg)) {
+	if (pu_reg) {
 		ret = regulator_set_voltage_time(pu_reg, imx6_soc_volt[0], imx6_soc_volt[num - 1]);
 		if (ret > 0)
 			transition_latency += ret * 1000;
-- 
2.6.1

