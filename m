From: Anson Huang <Anson.Huang@nxp.com>
Subject: [PATCH 2/2] cpufreq: imx6q: add 696MHz operating point for i.mx6ul
Date: Wed, 3 Jan 2018 01:07:39 +0800
Message-ID: <1514912859-17691-2-git-send-email-Anson.Huang@nxp.com>
References: <1514912859-17691-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-by2nam01on0044.outbound.protection.outlook.com ([104.47.34.44]:4370
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752816AbeABJ37 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 2 Jan 2018 04:29:59 -0500
In-Reply-To: <1514912859-17691-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk, rjw@rjwysocki.net, viresh.kumar@linaro.org, ping.bai@nxp.com, aisheng.dong@nxp.com

Add 696MHz operating point for i.MX6UL, only for those
parts with speed grading fuse set to 2b'10 supports
696MHz operating point, so, speed grading check is also
added for i.MX6UL in this patch, the clock tree for each
operating point are as below:

696MHz:
    pll1                       696000000
       pll1_bypass             696000000
          pll1_sys             696000000
             pll1_sw           696000000
                arm            696000000
528MHz:
    pll2                       528000000
       pll2_bypass             528000000
          pll2_bus             528000000
             ca7_secondary_sel 528000000
                step           528000000
                   pll1_sw     528000000
                      arm      528000000
396MHz:
    pll2_pfd2_396m             396000000
       ca7_secondary_sel       396000000
          step                 396000000
             pll1_sw           396000000
                arm            396000000
198MHz:
    pll2_pfd2_396m             396000000
       ca7_secondary_sel       396000000
          step                 396000000
             pll1_sw           396000000
                arm            198000000

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/cpufreq/imx6q-cpufreq.c | 46 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index d9b2c2d..cbda0cc 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -120,6 +120,10 @@ static int imx6q_set_target(struct cpufreq_policy *policy, unsigned int index)
 			clk_set_parent(secondary_sel_clk, pll2_pfd2_396m_clk);
 		clk_set_parent(step_clk, secondary_sel_clk);
 		clk_set_parent(pll1_sw_clk, step_clk);
+		if (freq_hz > clk_get_rate(pll2_bus_clk)) {
+			clk_set_rate(pll1_sys_clk, new_freq * 1000);
+			clk_set_parent(pll1_sw_clk, pll1_sys_clk);
+		}
 	} else {
 		clk_set_parent(step_clk, pll2_pfd2_396m_clk);
 		clk_set_parent(pll1_sw_clk, step_clk);
@@ -244,6 +248,43 @@ static void imx6q_opp_check_speed_grading(struct device *dev)
 	of_node_put(np);
 }
 
+#define OCOTP_CFG3_6UL_SPEED_696MHZ	0x2
+
+static void imx6ul_opp_check_speed_grading(struct device *dev)
+{
+	struct device_node *np;
+	void __iomem *base;
+	u32 val;
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,imx6ul-ocotp");
+	if (!np)
+		return;
+
+	base = of_iomap(np, 0);
+	if (!base) {
+		dev_err(dev, "failed to map ocotp\n");
+		goto put_node;
+	}
+
+	/*
+	 * Speed GRADING[1:0] defines the max speed of ARM:
+	 * 2b'00: Reserved;
+	 * 2b'01: 528000000Hz;
+	 * 2b'10: 696000000Hz;
+	 * 2b'11: Reserved;
+	 * We need to set the max speed of ARM according to fuse map.
+	 */
+	val = readl_relaxed(base + OCOTP_CFG3);
+	val >>= OCOTP_CFG3_SPEED_SHIFT;
+	val &= 0x3;
+	if (val != OCOTP_CFG3_6UL_SPEED_696MHZ)
+		if (dev_pm_opp_disable(dev, 696000000))
+			dev_warn(dev, "failed to disable 696MHz OPP\n");
+	iounmap(base);
+put_node:
+	of_node_put(np);
+}
+
 static int imx6q_cpufreq_probe(struct platform_device *pdev)
 {
 	struct device_node *np;
@@ -311,7 +352,10 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
 		goto put_reg;
 	}
 
-	imx6q_opp_check_speed_grading(cpu_dev);
+	if (of_machine_is_compatible("fsl,imx6ul"))
+		imx6ul_opp_check_speed_grading(cpu_dev);
+	else
+		imx6q_opp_check_speed_grading(cpu_dev);
 
 	/* Because we have added the OPPs here, we must free them */
 	free_opp = true;
-- 
1.9.1
