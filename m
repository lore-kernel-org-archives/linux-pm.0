From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] cpufreq: imx6: Fix the secondary_sel_clk clock string
Date: Thu, 19 May 2016 23:59:47 -0300
Message-ID: <1463713188-6896-1-git-send-email-festevam@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:32776 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932402AbcETDAK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 May 2016 23:00:10 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rafael.j.wysocki@intel.com
Cc: viresh.kumar@linaro.org, ping.bai@nxp.com, shawnguo@kernel.org, kernel@pengutronix.de, linux-pm@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>, stable@vger.kernel.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Commit a35fc5a33b62a6 ("cpufreq: imx: update the clock switch flow to
support imx6ul") introduced the 'secondary_sel_clk' clock, which is
specific for the i.mx6ul case, but used the wrong clock string inside 
the clk_get() function.

Use the correct clock string: "secondary_sel_clk".

This fixes a kernel crash after running the 'reboot' command on a
mx6ul.

Fixes: a35fc5a33b62a6 ("cpufreq: imx: update the clock switch flow to support imx6ul")
Cc: <stable@vger.kernel.org> # 4.4.x
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 drivers/cpufreq/imx6q-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index ef1fa81..00b481e 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -212,7 +212,7 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
 
 	if (of_machine_is_compatible("fsl,imx6ul")) {
 		pll2_bus_clk = clk_get(cpu_dev, "pll2_bus");
-		secondary_sel_clk = clk_get(cpu_dev, "secondary_sel");
+		secondary_sel_clk = clk_get(cpu_dev, "secondary_sel_clk");
 		if (IS_ERR(pll2_bus_clk) || IS_ERR(secondary_sel_clk)) {
 			dev_err(cpu_dev, "failed to get clocks specific to imx6ul\n");
 			ret = -ENOENT;
-- 
1.9.1

