From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 2/3] cpufreq: armada: Free resources on error paths
Date: Tue, 24 Apr 2018 11:37:35 +0530
Message-ID: <f1c51daa2b6f932107bf933247cb659713989a98.1524549644.git.viresh.kumar@linaro.org>
References: <cover.1524549644.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1524549644.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1524549644.git.viresh.kumar@linaro.org>
References: <cover.1524549644.git.viresh.kumar@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Miquel Raynal <miquel.raynal@bootlin.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The resources weren't freed on failures, free them properly.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/armada-37xx-cpufreq.c | 40 +++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/drivers/cpufreq/armada-37xx-cpufreq.c b/drivers/cpufreq/armada-37xx-cpufreq.c
index 72a2975499db..9dafb3bbc334 100644
--- a/drivers/cpufreq/armada-37xx-cpufreq.c
+++ b/drivers/cpufreq/armada-37xx-cpufreq.c
@@ -166,6 +166,7 @@ static int __init armada37xx_cpufreq_driver_init(void)
 {
 	struct armada_37xx_dvfs *dvfs;
 	struct platform_device *pdev;
+	unsigned long freq;
 	unsigned int cur_frequency;
 	struct regmap *nb_pm_base;
 	struct device *cpu_dev;
@@ -202,38 +203,49 @@ static int __init armada37xx_cpufreq_driver_init(void)
 	cur_frequency = clk_get_rate(clk);
 	if (!cur_frequency) {
 		dev_err(cpu_dev, "Failed to get clock rate for CPU\n");
-		clk_put(clk);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto put_clk;
 	}
 
 	dvfs = armada_37xx_cpu_freq_info_get(cur_frequency);
-	if (!dvfs)
-		return -EINVAL;
+	if (!dvfs) {
+		ret = -EINVAL;
+		goto put_clk;
+	}
 
 	armada37xx_cpufreq_dvfs_setup(nb_pm_base, clk, dvfs->divider);
 	clk_put(clk);
 
 	for (load_lvl = ARMADA_37XX_DVFS_LOAD_0; load_lvl < LOAD_LEVEL_NR;
 	     load_lvl++) {
-		unsigned long freq = cur_frequency / dvfs->divider[load_lvl];
+		freq = cur_frequency / dvfs->divider[load_lvl];
 
 		ret = dev_pm_opp_add(cpu_dev, freq, 0);
-		if (ret) {
-			/* clean-up the already added opp before leaving */
-			while (load_lvl-- > ARMADA_37XX_DVFS_LOAD_0) {
-				freq = cur_frequency / dvfs->divider[load_lvl];
-				dev_pm_opp_remove(cpu_dev, freq);
-			}
-			return ret;
-		}
+		if (ret)
+			goto remove_opp;
 	}
 
 	/* Now that everything is setup, enable the DVFS at hardware level */
 	armada37xx_cpufreq_enable_dvfs(nb_pm_base);
 
 	pdev = platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
+	ret = PTR_ERR_OR_ZERO(pdev);
+	if (ret)
+		goto disable_dvfs;
+
+	return 0;
 
-	return PTR_ERR_OR_ZERO(pdev);
+disable_dvfs:
+	armada37xx_cpufreq_disable_dvfs(nb_pm_base);
+remove_opp:
+	/* clean-up the already added opp before leaving */
+	while (load_lvl-- > ARMADA_37XX_DVFS_LOAD_0) {
+		freq = cur_frequency / dvfs->divider[load_lvl];
+		dev_pm_opp_remove(cpu_dev, freq);
+	}
+put_clk:
+	clk_put(clk);
+	return ret;
 }
 /* late_initcall, to guarantee the driver is loaded after A37xx clock driver */
 late_initcall(armada37xx_cpufreq_driver_init);
-- 
2.15.0.194.g9af6a3dea062
