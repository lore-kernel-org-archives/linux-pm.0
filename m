From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: [PATCH] cpufreq: imx6q: Fix imx6sx low frequency support
Date: Mon, 28 Aug 2017 14:05:18 +0300
Message-ID: <4304e578a343c9acaed46b7e205d49bb63323f80.1503918257.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-by2nam03on0065.outbound.protection.outlook.com ([104.47.42.65]:29699
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751157AbdH1LFi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 28 Aug 2017 07:05:38 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shawn Guo <shawnguo@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Anson Huang <Anson.Huang@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, Bai Ping <ping.bai@nxp.com>, kernel@pengutronix.de, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

This patch contains the minimal changes required to support imx6sx OPP
of 198 Mhz. Without this patch cpufreq still reports success but the
frequency is not changed, the "arm" clock will still be at 396000000 in
clk_summary.

In order to do this PLL1 needs to be still kept enabled while changing
the ARM clock. This is a hardware requirement: when ARM_PODF is changed
in CCM we need to check the busy bit of CCM_CDHIPR bit 16 arm_podf_busy,
and this bit is sync with PLL1 clock, so if PLL1 NOT enabled, this
bit will never get clear.

Keep pll1_sys explicitly enabled until after the rate is change to deal
with this. Otherwise from the clk framework perspective pll1_sys is
unused and gets turned off.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
Changes since v1:
 - Link: https://lkml.org/lkml/2017/7/19/302
 - Only keep pll1_sys enabled until after ARM rate is changed.
 - Incorporate more elaborate explanation from Anson
 - Do not add new clocks or bypass PLL1. Just let it get disabled.

 drivers/cpufreq/imx6q-cpufreq.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index b6edd3c..14466a9 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -47,6 +47,7 @@ static int imx6q_set_target(struct cpufreq_policy *policy, unsigned int index)
 	struct dev_pm_opp *opp;
 	unsigned long freq_hz, volt, volt_old;
 	unsigned int old_freq, new_freq;
+	bool pll1_sys_temp_enabled = false;
 	int ret;
 
 	new_freq = freq_table[index].frequency;
@@ -124,6 +125,10 @@ static int imx6q_set_target(struct cpufreq_policy *policy, unsigned int index)
 		if (freq_hz > clk_get_rate(pll2_pfd2_396m_clk)) {
 			clk_set_rate(pll1_sys_clk, new_freq * 1000);
 			clk_set_parent(pll1_sw_clk, pll1_sys_clk);
+		} else {
+			/* pll1_sys needs to be enabled for divider rate change to work. */
+			pll1_sys_temp_enabled = true;
+			clk_prepare_enable(pll1_sys_clk);
 		}
 	}
 
@@ -135,6 +140,10 @@ static int imx6q_set_target(struct cpufreq_policy *policy, unsigned int index)
 		return ret;
 	}
 
+	/* PLL1 is only needed until after ARM-PODF is set. */
+	if (pll1_sys_temp_enabled)
+		clk_disable_unprepare(pll1_sys_clk);
+
 	/* scaling down?  scale voltage after frequency */
 	if (new_freq < old_freq) {
 		ret = regulator_set_voltage_tol(arm_reg, volt, 0);
-- 
2.7.4
