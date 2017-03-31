From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: [PATCH 2/5] cpufreq: imx6q: Fix handling EPROBE_DEFER from regulator
Date: Fri, 31 Mar 2017 22:25:37 +0300
Message-ID: <36c230773c14d37037dbe8cadf4f99b0d875e679.1490987945.git.leonard.crestez@nxp.com>
References: <cover.1490987945.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1490987945.git.leonard.crestez@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Mark Brown <broonie@kernel.org>
Cc: Leonard Crestez <leonard.crestez@nxp.com>, Anson Huang <Anson.Huang@nxp.com>, Irina Tirdea <irina.tirdea@nxp.com>, linux-pm@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Octavian Purdila <octavian.purdila@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>, Robin Gong <yibin.gong@nxp.com>, linux-arm-kernel@lists.infradead.org, Lucas Stach <l.stach@pengutronix.de>
List-Id: linux-pm@vger.kernel.org

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
