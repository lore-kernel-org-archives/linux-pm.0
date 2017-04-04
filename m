From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: [PATCH v2 1/4] cpufreq: imx6q: Fix handling EPROBE_DEFER from regulator
Date: Tue, 4 Apr 2017 20:04:11 +0300
Message-ID: <118bbfc3747dcbcd1c34da2f94732fac0a5d4793.1491324640.git.leonard.crestez@nxp.com>
References: <cover.1491324640.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-sn1nam02on0078.outbound.protection.outlook.com ([104.47.36.78]:3136
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754278AbdDDREk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 4 Apr 2017 13:04:40 -0400
In-Reply-To: <cover.1491324640.git.leonard.crestez@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>
Cc: Leonard Crestez <leonard.crestez@nxp.com>, Mark Brown <broonie@kernel.org>, Robin Gong <yibin.gong@nxp.com>, Anson Huang <Anson.Huang@nxp.com>, Irina Tirdea <irina.tirdea@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>, Octavian Purdila <octavian.purdila@nxp.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

From: Irina Tirdea <irina.tirdea@nxp.com>

If there are any errors in getting the cpu0 regulators, the driver returns
-ENOENT. In case the regulators are not yet available, the devm_regulator_get
calls will return -EPROBE_DEFER, so that the driver can be probed later.
If we return -ENOENT, the driver will fail its initialization and will
not try to probe again (when the regulators become available).

Return the actual error received from regulator_get in probe. Print a
differentiated message in case we need to probe the device later and
in case we actually failed. Also add a message to inform when the
driver has been successfully registered.

Signed-off-by: Irina Tirdea <irina.tirdea@nxp.com>
Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/imx6q-cpufreq.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index 7719b02..be90ee3 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -222,6 +222,13 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
 	arm_reg = regulator_get(cpu_dev, "arm");
 	pu_reg = regulator_get_optional(cpu_dev, "pu");
 	soc_reg = regulator_get(cpu_dev, "soc");
+	if (PTR_ERR(arm_reg) == -EPROBE_DEFER ||
+			PTR_ERR(soc_reg) == -EPROBE_DEFER ||
+			PTR_ERR(pu_reg) == -EPROBE_DEFER) {
+		ret = -EPROBE_DEFER;
+		dev_dbg(cpu_dev, "regulators not ready, defer\n");
+		goto put_reg;
+	}
 	if (IS_ERR(arm_reg) || IS_ERR(soc_reg)) {
 		dev_err(cpu_dev, "failed to get regulators\n");
 		ret = -ENOENT;
-- 
2.7.4
