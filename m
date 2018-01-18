From: Stefan Agner <stefan@agner.ch>
Subject: [PATCH] cpufreq: imx6q: support frequencies >528MHz for i.MX6UL/ULL
Date: Fri, 19 Jan 2018 00:58:36 +0100
Message-ID: <20180118235836.17393-1-stefan@agner.ch>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kmu-office.ch ([178.209.48.109]:34723 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932394AbeARX6m (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jan 2018 18:58:42 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: fabio.estevam@nxp.com, octavian.purdila@nxp.com, shawnguo@kernel.org, max.oss.09@gmail.com, marcel.ziswiler@toradex.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>

Depending on SKU i.MX6UL/i.MX6ULL support frequencies up to 900MHz.
Use PLL1 sys clock for all operating points higher than 528MHz.

Note: For higher operating points VDD_SOC_IN needs to be 125mV
higher than the ARM set-point (see datasheet). Specifically, the
i.MX6UL/ULL EVK boards have an external DC regulator which needs
adjustment. The regulator adjustment is not covered with this
change.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/cpufreq/imx6q-cpufreq.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index 628fe899cb48..840f6386c780 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -114,12 +114,14 @@ static int imx6q_set_target(struct cpufreq_policy *policy, unsigned int index)
 		 */
 		clk_set_rate(arm_clk, (old_freq >> 1) * 1000);
 		clk_set_parent(pll1_sw_clk, pll1_sys_clk);
-		if (freq_hz > clk_get_rate(pll2_pfd2_396m_clk))
-			clk_set_parent(secondary_sel_clk, pll2_bus_clk);
-		else
-			clk_set_parent(secondary_sel_clk, pll2_pfd2_396m_clk);
-		clk_set_parent(step_clk, secondary_sel_clk);
-		clk_set_parent(pll1_sw_clk, step_clk);
+		if (freq_hz <= clk_get_rate(pll2_bus_clk)) {
+			if (freq_hz > clk_get_rate(pll2_pfd2_396m_clk))
+				clk_set_parent(secondary_sel_clk, pll2_bus_clk);
+			else
+				clk_set_parent(secondary_sel_clk, pll2_pfd2_396m_clk);
+			clk_set_parent(step_clk, secondary_sel_clk);
+			clk_set_parent(pll1_sw_clk, step_clk);
+		}
 	} else {
 		clk_set_parent(step_clk, pll2_pfd2_396m_clk);
 		clk_set_parent(pll1_sw_clk, step_clk);
-- 
2.15.1
