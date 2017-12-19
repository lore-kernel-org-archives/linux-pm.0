From: Stefan Riedmueller <s.riedmueller@phytec.de>
Subject: [PATCH] cpufreq: imx6q-cpufreq: Fix speed grading check for imx6qp
Date: Tue, 19 Dec 2017 16:56:22 +0100
Message-ID: <1513698982-13560-1-git-send-email-s.riedmueller@phytec.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.visioncatalog.de ([217.6.246.34]:55620 "EHLO
        root.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752349AbdLSQDL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 19 Dec 2017 11:03:11 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, fabio.estevam@nxp.com, Stefan Riedmueller <s.riedmueller@phytec.de>

Add compatibility for the i.MX 6QuadPlus to make it behave like the
i.MX 6Quad, as both SOCs use the same operating points. Otherwise the
i.MX 6QuadPlus tries to run with 1.2 GHz even though it only
supports 1 GHz.

Signed-off-by: Stefan Riedmueller <s.riedmueller@phytec.de>
---
 drivers/cpufreq/imx6q-cpufreq.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index 628fe89..5ca1988 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -218,7 +218,7 @@ static void imx6q_opp_check_speed_grading(struct device *dev)
 	 * SPEED_GRADING[1:0] defines the max speed of ARM:
 	 * 2b'11: 1200000000Hz;
 	 * 2b'10: 996000000Hz;
-	 * 2b'01: 852000000Hz; -- i.MX6Q Only, exclusive with 996MHz.
+	 * 2b'01: 852000000Hz; -- i.MX6Q/QP Only, exclusive with 996MHz.
 	 * 2b'00: 792000000Hz;
 	 * We need to set the max speed of ARM according to fuse map.
 	 */
@@ -227,13 +227,15 @@ static void imx6q_opp_check_speed_grading(struct device *dev)
 	val &= 0x3;
 
 	if ((val != OCOTP_CFG3_SPEED_1P2GHZ) &&
-	     of_machine_is_compatible("fsl,imx6q"))
+	    (of_machine_is_compatible("fsl,imx6q") ||
+	     of_machine_is_compatible("fsl,imx6qp")))
 		if (dev_pm_opp_disable(dev, 1200000000))
 			dev_warn(dev, "failed to disable 1.2GHz OPP\n");
 	if (val < OCOTP_CFG3_SPEED_996MHZ)
 		if (dev_pm_opp_disable(dev, 996000000))
 			dev_warn(dev, "failed to disable 996MHz OPP\n");
-	if (of_machine_is_compatible("fsl,imx6q")) {
+	if (of_machine_is_compatible("fsl,imx6q") ||
+	    of_machine_is_compatible("fsl,imx6qp")) {
 		if (val != OCOTP_CFG3_SPEED_852MHZ)
 			if (dev_pm_opp_disable(dev, 852000000))
 				dev_warn(dev, "failed to disable 852MHz OPP\n");
-- 
2.7.4
