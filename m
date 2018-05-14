From: Anson Huang <Anson.Huang@nxp.com>
Subject: [PATCH 2/3] cpufreq: imx6q: add cpufreq cooling device based on device tree
Date: Mon, 14 May 2018 16:09:18 +0800
Message-ID: <1526285359-17978-2-git-send-email-Anson.Huang@nxp.com>
References: <1526285359-17978-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1526285359-17978-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, rui.zhang@intel.com, edubezval@gmail.com
Cc: Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Register the imx6q cpufreq driver as a cooling device
based on the thermal device tree framework.

When temperature exceeds the passive trip point, cpufreq
driver will be used to throttle CPUs.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/cpufreq/imx6q-cpufreq.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index 83cf631..27ce84d 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -9,6 +9,7 @@
 #include <linux/clk.h>
 #include <linux/cpu.h>
 #include <linux/cpufreq.h>
+#include <linux/cpu_cooling.h>
 #include <linux/err.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -50,6 +51,7 @@ static struct clk_bulk_data clks[] = {
 };
 
 static struct device *cpu_dev;
+struct thermal_cooling_device *cdev;
 static bool free_opp;
 static struct cpufreq_frequency_table *freq_table;
 static unsigned int max_freq;
@@ -202,6 +204,11 @@ static int imx6q_cpufreq_init(struct cpufreq_policy *policy)
 	return ret;
 }
 
+static void imx6q_cpufreq_ready(struct cpufreq_policy *policy)
+{
+	cdev = of_cpufreq_cooling_register(policy);
+}
+
 static struct cpufreq_driver imx6q_cpufreq_driver = {
 	.flags = CPUFREQ_NEED_INITIAL_FREQ_CHECK,
 	.verify = cpufreq_generic_frequency_table_verify,
@@ -210,6 +217,7 @@ static struct cpufreq_driver imx6q_cpufreq_driver = {
 	.init = imx6q_cpufreq_init,
 	.name = "imx6q-cpufreq",
 	.attr = cpufreq_generic_attr,
+	.ready = imx6q_cpufreq_ready,
 	.suspend = cpufreq_generic_suspend,
 };
 
@@ -482,6 +490,7 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
 
 static int imx6q_cpufreq_remove(struct platform_device *pdev)
 {
+	cpufreq_cooling_unregister(cdev);
 	cpufreq_unregister_driver(&imx6q_cpufreq_driver);
 	dev_pm_opp_free_cpufreq_table(cpu_dev, &freq_table);
 	if (free_opp)
-- 
2.7.4
