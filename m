From: Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH 2/2] cpufreq: armada-37xx: fix frequency calculation for opp
Date: Fri,  8 Mar 2019 17:47:10 +0100
Message-ID: <20190308164710.10597-3-gregory.clement@bootlin.com>
References: <20190308164710.10597-1-gregory.clement@bootlin.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190308164710.10597-1-gregory.clement@bootlin.com>
Sender: stable-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
Cc: Christian Neubert <christian.neubert.86@gmail.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-arm-kernel@lists.infradead.org, Antoine Tenart <antoine.tenart@bootlin.com>, =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The frequency calculation was based on the current(max) frequency of the
CPU. However for low frequency, the value used was already the parent
frequency divided by a factor of 2.

Instead of using this frequency, this fix directly get the frequency from
the parent clock.

Fixes: 92ce45fb875d ("cpufreq: Add DVFS support for Armada 37xx")
Cc: <stable@vger.kernel.org>
Reported-by: Christian Neubert <christian.neubert.86@gmail.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 drivers/cpufreq/armada-37xx-cpufreq.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/armada-37xx-cpufreq.c b/drivers/cpufreq/armada-37xx-cpufreq.c
index ad4463e4266e..a0962463805e 100644
--- a/drivers/cpufreq/armada-37xx-cpufreq.c
+++ b/drivers/cpufreq/armada-37xx-cpufreq.c
@@ -373,11 +373,11 @@ static int __init armada37xx_cpufreq_driver_init(void)
 	struct armada_37xx_dvfs *dvfs;
 	struct platform_device *pdev;
 	unsigned long freq;
-	unsigned int cur_frequency;
+	unsigned int cur_frequency, base_frequency;
 	struct regmap *nb_pm_base, *avs_base;
 	struct device *cpu_dev;
 	int load_lvl, ret;
-	struct clk *clk;
+	struct clk *clk, *parent;
 
 	nb_pm_base =
 		syscon_regmap_lookup_by_compatible("marvell,armada-3700-nb-pm");
@@ -413,6 +413,22 @@ static int __init armada37xx_cpufreq_driver_init(void)
 		return PTR_ERR(clk);
 	}
 
+	parent = clk_get_parent(clk);
+	if (IS_ERR(parent)) {
+		dev_err(cpu_dev, "Cannot get parent clock for CPU0\n");
+		clk_put(clk);
+		return PTR_ERR(parent);
+	}
+
+	/* Get parent CPU frequency */
+	base_frequency =  clk_get_rate(parent);
+
+	if (!base_frequency) {
+		dev_err(cpu_dev, "Failed to get parent clock rate for CPU\n");
+		clk_put(clk);
+		return -EINVAL;
+	}
+
 	/* Get nominal (current) CPU frequency */
 	cur_frequency = clk_get_rate(clk);
 	if (!cur_frequency) {
@@ -445,7 +461,7 @@ static int __init armada37xx_cpufreq_driver_init(void)
 	for (load_lvl = ARMADA_37XX_DVFS_LOAD_0; load_lvl < LOAD_LEVEL_NR;
 	     load_lvl++) {
 		unsigned long u_volt = avs_map[dvfs->avs[load_lvl]] * 1000;
-		freq = cur_frequency / dvfs->divider[load_lvl];
+		freq = base_frequency / dvfs->divider[load_lvl];
 		ret = dev_pm_opp_add(cpu_dev, freq, u_volt);
 		if (ret)
 			goto remove_opp;
-- 
2.20.1
