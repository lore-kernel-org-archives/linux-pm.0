From: Lucas Stach <l.stach@pengutronix.de>
Subject: [PATCH] cpufreq: imx6q: fix speed grading regression on i.MX6 QuadPlus
Date: Mon, 11 Dec 2017 14:19:00 +0100
Message-ID: <20171211131900.17423-1-l.stach@pengutronix.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:54101 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751400AbdLKNTD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Dec 2017 08:19:03 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>, kernel@pengutronix.de, patchwork-lst@pengutronix.de

The commit moving the speed grading check to the cpufreq driver introduced
some additional checks, so the OPP disable is only attempted on SoCs where
those OPPs are present. The compatible checks are missing the QuadPlus
compatible, so invalid OPPs are not correctly disabled there.

Move both checks to a single condition, so we don't need to sprinkle even
more calls to of_machine_is_compatible().

Fixes: 2b3d58a3adca (cpufreq: imx6q: Move speed grading check to cpufreq driver)
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/cpufreq/imx6q-cpufreq.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index 628fe899cb48..d9b2c2de49c4 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -226,17 +226,18 @@ static void imx6q_opp_check_speed_grading(struct device *dev)
 	val >>= OCOTP_CFG3_SPEED_SHIFT;
 	val &= 0x3;
 
-	if ((val != OCOTP_CFG3_SPEED_1P2GHZ) &&
-	     of_machine_is_compatible("fsl,imx6q"))
-		if (dev_pm_opp_disable(dev, 1200000000))
-			dev_warn(dev, "failed to disable 1.2GHz OPP\n");
 	if (val < OCOTP_CFG3_SPEED_996MHZ)
 		if (dev_pm_opp_disable(dev, 996000000))
 			dev_warn(dev, "failed to disable 996MHz OPP\n");
-	if (of_machine_is_compatible("fsl,imx6q")) {
+
+	if (of_machine_is_compatible("fsl,imx6q") ||
+	    of_machine_is_compatible("fsl,imx6qp")) {
 		if (val != OCOTP_CFG3_SPEED_852MHZ)
 			if (dev_pm_opp_disable(dev, 852000000))
 				dev_warn(dev, "failed to disable 852MHz OPP\n");
+		if (val != OCOTP_CFG3_SPEED_1P2GHZ)
+			if (dev_pm_opp_disable(dev, 1200000000))
+				dev_warn(dev, "failed to disable 1.2GHz OPP\n");
 	}
 	iounmap(base);
 put_node:
-- 
2.11.0
