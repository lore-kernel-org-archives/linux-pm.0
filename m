From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: [PATCH 3/5] cpufreq: imx6q: Set max suspend_freq to avoid changes during suspend
Date: Fri, 31 Mar 2017 22:25:38 +0300
Message-ID: <94d99b261124b813adecf11e86a0ffe05c37f276.1490987945.git.leonard.crestez@nxp.com>
References: <cover.1490987945.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1490987945.git.leonard.crestez@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Mark Brown <broonie@kernel.org>
Cc: Leonard Crestez <leonard.crestez@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, Robin Gong <yibin.gong@nxp.com>, Anson Huang <Anson.Huang@nxp.com>, Irina Tirdea <irina.tirdea@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>, Octavian Purdila <octavian.purdila@nxp.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

If the cpufreq driver tries to modify voltage/freq during suspend/resume
it might need to control an external PMIC via I2C or SPI but those
devices might be already suspended.

To avoid this scenario we just increase cpufreq to highest setpoint
before suspend. This issue can easily be triggered by ldo-bypass but in
theory any regulator set_voltage call can end up having to modify
external supply voltages.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/imx6q-cpufreq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index be90ee3..e2c1fbf 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -162,6 +162,7 @@ static int imx6q_set_target(struct cpufreq_policy *policy, unsigned int index)
 static int imx6q_cpufreq_init(struct cpufreq_policy *policy)
 {
 	policy->clk = arm_clk;
+	policy->suspend_freq = freq_table[soc_opp_count - 1].frequency;
 	return cpufreq_generic_init(policy, freq_table, transition_latency);
 }
 
@@ -173,6 +174,7 @@ static struct cpufreq_driver imx6q_cpufreq_driver = {
 	.init = imx6q_cpufreq_init,
 	.name = "imx6q-cpufreq",
 	.attr = cpufreq_generic_attr,
+	.suspend = cpufreq_generic_suspend,
 };
 
 static int imx6q_cpufreq_probe(struct platform_device *pdev)
-- 
2.7.4
