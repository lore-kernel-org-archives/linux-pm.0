From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 5/5] cpufreq: imx6q: pu regulator is not optional
Date: Wed, 28 Oct 2015 08:59:14 +0100
Message-ID: <1446019154-16384-6-git-send-email-s.hauer@pengutronix.de>
References: <1446019154-16384-1-git-send-email-s.hauer@pengutronix.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:57372 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754585AbbJ1H7a (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 28 Oct 2015 03:59:30 -0400
In-Reply-To: <1446019154-16384-1-git-send-email-s.hauer@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, kernel@pengutronix.de, Heiner Kallweit <hkallweit1@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>

Some SoC types have a PU regulator and others don't. On the SoCs which
have a PU regulator it's not optional, so regulator_get_optional is
not appropriate here.

Use the IMX6_CPUFREQ_NEED_PU_REG introduced with the last patch to
check whether we need a PU regulator and if we do, request it using
regulator_get() rather than regulator_get_optional.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/cpufreq/imx6q-cpufreq.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index f3729f9..605897b 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -92,7 +92,7 @@ static int imx6q_set_target(struct cpufreq_policy *policy, unsigned int index)
 
 	/* scaling up?  scale voltage before frequency */
 	if (new_freq > old_freq) {
-		if (!IS_ERR(pu_reg)) {
+		if (pu_reg) {
 			ret = regulator_set_voltage_tol(pu_reg, imx6_soc_volt[index], 0);
 			if (ret) {
 				dev_err(cpu_dev, "failed to scale vddpu up: %d\n", ret);
@@ -169,7 +169,7 @@ static int imx6q_set_target(struct cpufreq_policy *policy, unsigned int index)
 			dev_warn(cpu_dev, "failed to scale vddsoc down: %d\n", ret);
 			ret = 0;
 		}
-		if (!IS_ERR(pu_reg)) {
+		if (pu_reg) {
 			ret = regulator_set_voltage_tol(pu_reg, imx6_soc_volt[index], 0);
 			if (ret) {
 				dev_warn(cpu_dev, "failed to scale vddpu down: %d\n", ret);
@@ -237,7 +237,11 @@ static int imx6q_cpufreq_get_resources(void)
 	if (IS_ERR(arm_reg))
 		return PTR_ERR(arm_reg);
 
-	pu_reg = regulator_get_optional(cpu_dev, "pu");
+	if (imx6_cpufreq_flags & IMX6_CPUFREQ_NEED_PU_REG) {
+		pu_reg = regulator_get(cpu_dev, "pu");
+		if (IS_ERR(pu_reg))
+			return -EPROBE_DEFER;
+	}
 
 	soc_reg = regulator_get(cpu_dev, "soc");
 	if (IS_ERR(soc_reg))
@@ -404,7 +408,7 @@ soc_opp_out:
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

