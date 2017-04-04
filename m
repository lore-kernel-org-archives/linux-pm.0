From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: [PATCH v2 2/4] cpufreq: imx6q: Set max suspend_freq to avoid changes
 during suspend
Date: Tue, 4 Apr 2017 20:04:12 +0300
Message-ID: <5f61b819733127ddc7d41e82bf703a355c845b49.1491324640.git.leonard.crestez@nxp.com>
References: <cover.1491324640.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1491324640.git.leonard.crestez@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lucas Stach <l.stach@pengutronix.de>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>
Cc: Leonard Crestez <leonard.crestez@nxp.com>, Anson Huang <Anson.Huang@nxp.com>, Irina Tirdea <irina.tirdea@nxp.com>, linux-pm@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Octavian Purdila <octavian.purdila@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>, Robin Gong <yibin.gong@nxp.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

If the cpufreq driver tries to modify voltage/freq during suspend/resume
it might need to control an external PMIC via I2C or SPI but those
devices might be already suspended. This issue is likely to happen
whenever the LDOs have their vin-supply set.

To avoid this scenario we just increase cpufreq to the maximum before
suspend.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/cpufreq/imx6q-cpufreq.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index be90ee3..786122e 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -161,8 +161,13 @@ static int imx6q_set_target(struct cpufreq_policy *policy, unsigned int index)
 
 static int imx6q_cpufreq_init(struct cpufreq_policy *policy)
 {
+	int ret;
+
 	policy->clk = arm_clk;
-	return cpufreq_generic_init(policy, freq_table, transition_latency);
+	ret = cpufreq_generic_init(policy, freq_table, transition_latency);
+	policy->suspend_freq = policy->max;
+
+	return ret;
 }
 
 static struct cpufreq_driver imx6q_cpufreq_driver = {
@@ -173,6 +178,7 @@ static struct cpufreq_driver imx6q_cpufreq_driver = {
 	.init = imx6q_cpufreq_init,
 	.name = "imx6q-cpufreq",
 	.attr = cpufreq_generic_attr,
+	.suspend = cpufreq_generic_suspend,
 };
 
 static int imx6q_cpufreq_probe(struct platform_device *pdev)
-- 
2.7.4
