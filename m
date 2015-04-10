From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 2/6] cpufreq-dt: add 'boost' mode frequencies support
Date: Fri, 10 Apr 2015 19:58:58 +0200
Message-ID: <1428688742-15578-3-git-send-email-b.zolnierkie@samsung.com>
References: <1428688742-15578-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1428688742-15578-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Mike Turquette <mturquette@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

Add 'boost' mode frequencies support:
- add boost-opps binding to cpufreq-dt driver bindings
- make cpufreq_init() adjust freq_table accordingly
- fix set_target() to handle boost frequencies
- add boost_supported field to struct cpufreq_dt_platform_data
- set dt_cpufreq_driver.boost_supported in dt_cpufreq_probe()

This patch makes cpufreq-dt driver aware of 'boost' mode frequencies
and prepares it for adding support for Exynos4x12 'boost' support.

boost-opps binding is currently limited to cpufreq-dt but once there is
a need for cpufreq wide and/or generic Linux device support for 'boost'
mode cpufreq-dt can be updated to handle the new code without changing
the binding itself.

The decision to make 'boost' mode support limited to cpufreq-dt driver
for now was taken because 'boost' mode is currently a niche feature and
code needed for parsing boost-opps binding is minimal and simple.  More
generic (i.e. separate 'boost' OPPs list in struct device and generic
cpufreq convertion of them to freq_table format) support would need far
more code and effort to make it work.  Doing it without a demonstrated
real need would be on overengineering IMHO.

Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Mike Turquette <mturquette@linaro.org>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 .../devicetree/bindings/cpufreq/cpufreq-dt.txt     |   14 +++
 drivers/cpufreq/cpufreq-dt.c                       |  114 +++++++++++++++++---
 include/linux/cpufreq-dt.h                         |    1 +
 3 files changed, 116 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-dt.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-dt.txt
index e41c98f..98572d8 100644
--- a/Documentation/devicetree/bindings/cpufreq/cpufreq-dt.txt
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-dt.txt
@@ -14,6 +14,16 @@ Optional properties:
 - operating-points: Refer to Documentation/devicetree/bindings/power/opp.txt for
   details. OPPs *must* be supplied either via DT, i.e. this property, or
   populated at runtime.
+- boost-opps: Certain CPUs can be operated in optional 'boost' mode (sometimes
+  also referred as overclocking) in which the CPU can operate at frequencies
+  which are not specified by the manufacturer as CPU's operating frequency.
+  CPU usually can operate in 'boost' mode for limited amount of time which
+  depends on thermal conditions.  This makes the boost operating points
+  separate from normal ones which can be used at any time.  This property
+  consists of an array of 2-tuples items, and each item consists of frequency
+  and voltage like <freq-kHz vol-uV>.
+	freq: clock frequency in kHz
+	vol: voltage in microvolt
 - clock-latency: Specify the possible maximum transition latency for clock,
   in unit of nanoseconds.
 - voltage-tolerance: Specify the CPU voltage tolerance in percentage.
@@ -38,6 +48,10 @@ cpus {
 			396000  950000
 			198000  850000
 		>;
+		boost-opps = <
+			/* kHz    uV */
+			891000  1150000
+		>;
 		clock-latency = <61036>; /* two CLK32 periods */
 		#cooling-cells = <2>;
 		cooling-min-level = <0>;
diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index bab67db..e5aaf3a 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -60,17 +60,22 @@ static int set_target(struct cpufreq_policy *policy, unsigned int index)
 	if (!IS_ERR(cpu_reg)) {
 		unsigned long opp_freq;
 
-		rcu_read_lock();
-		opp = dev_pm_opp_find_freq_ceil(cpu_dev, &freq_Hz);
-		if (IS_ERR(opp)) {
+		if (freq_table[index].flags & CPUFREQ_BOOST_FREQ) {
+			volt = freq_table[index].driver_data;
+			opp_freq = freq_table[index].frequency * 1000;
+		} else {
+			rcu_read_lock();
+			opp = dev_pm_opp_find_freq_ceil(cpu_dev, &freq_Hz);
+			if (IS_ERR(opp)) {
+				rcu_read_unlock();
+				dev_err(cpu_dev, "failed to find OPP for %ld\n",
+					freq_Hz);
+				return PTR_ERR(opp);
+			}
+			volt = dev_pm_opp_get_voltage(opp);
+			opp_freq = dev_pm_opp_get_freq(opp);
 			rcu_read_unlock();
-			dev_err(cpu_dev, "failed to find OPP for %ld\n",
-				freq_Hz);
-			return PTR_ERR(opp);
 		}
-		volt = dev_pm_opp_get_voltage(opp);
-		opp_freq = dev_pm_opp_get_freq(opp);
-		rcu_read_unlock();
 		tol = volt * priv->voltage_tolerance / 100;
 		volt_old = regulator_get_voltage(cpu_reg);
 		dev_dbg(cpu_dev, "Found OPP: %ld kHz, %ld uV\n",
@@ -182,6 +187,11 @@ try_again:
 	return ret;
 }
 
+struct boost_opp {
+	unsigned long rate;
+	unsigned long u_volt;
+};
+
 static int cpufreq_init(struct cpufreq_policy *policy)
 {
 	struct cpufreq_dt_platform_data *pd;
@@ -191,9 +201,11 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	struct device *cpu_dev;
 	struct regulator *cpu_reg;
 	struct clk *cpu_clk;
+	struct boost_opp *boost_opps = NULL;
 	unsigned long min_uV = ~0, max_uV = 0;
+	unsigned int extra_opps = 0;
 	unsigned int transition_latency;
-	int ret;
+	int nr, i, ret;
 
 	ret = allocate_resources(policy->cpu, &cpu_dev, &cpu_reg, &cpu_clk);
 	if (ret) {
@@ -234,7 +246,10 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 		transition_latency = CPUFREQ_ETERNAL;
 
 	if (!IS_ERR(cpu_reg)) {
+		const struct property *prop;
+		unsigned long opp_uV, tol_uV;
 		unsigned long opp_freq = 0;
+		const __be32 *val;
 
 		/*
 		 * Disable any OPPs where the connected regulator isn't able to
@@ -243,7 +258,6 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 		 */
 		while (1) {
 			struct dev_pm_opp *opp;
-			unsigned long opp_uV, tol_uV;
 
 			rcu_read_lock();
 			opp = dev_pm_opp_find_freq_ceil(cpu_dev, &opp_freq);
@@ -268,17 +282,86 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 			opp_freq++;
 		}
 
+		prop = of_find_property(np, "boost-opps", NULL);
+		if (!prop || !prop->value)
+			goto set_cpu_reg;
+
+		nr = prop->length / sizeof(u32);
+		if (nr % 2) {
+			dev_err(cpu_dev, "%s: Invalid boost-opps list\n",
+				__func__);
+			goto set_cpu_reg;
+		}
+
+		boost_opps = kzalloc(nr / 2 * sizeof(*boost_opps),
+				      GFP_KERNEL);
+		if (!boost_opps)
+			goto set_cpu_reg;
+
+		val = prop->value;
+		while (nr) {
+			unsigned long rate = be32_to_cpup(val++) * 1000;
+			unsigned long u_volt = be32_to_cpup(val++);
+
+			if (rate < opp_freq) {
+				nr -= 2;
+				continue;
+			} else {
+				opp_freq = rate + 1;
+				opp_uV = u_volt;
+			}
+
+			tol_uV = opp_uV * priv->voltage_tolerance / 100;
+			if (regulator_is_supported_voltage(cpu_reg, opp_uV,
+							   opp_uV + tol_uV)) {
+				if (opp_uV < min_uV)
+					min_uV = opp_uV;
+				if (opp_uV > max_uV)
+					max_uV = opp_uV;
+			} else {
+				nr -= 2;
+				continue;
+			}
+
+			boost_opps[extra_opps].rate = rate;
+			boost_opps[extra_opps].u_volt = u_volt;
+			extra_opps++;
+			nr -= 2;
+		}
+set_cpu_reg:
 		ret = regulator_set_voltage_time(cpu_reg, min_uV, max_uV);
 		if (ret > 0)
 			transition_latency += ret * 1000;
 	}
 
-	ret = dev_pm_opp_init_cpufreq_table(cpu_dev, &freq_table);
+	ret = __dev_pm_opp_init_cpufreq_table(cpu_dev, &freq_table,
+					      extra_opps);
 	if (ret) {
 		pr_err("failed to init cpufreq table: %d\n", ret);
+		kfree(boost_opps);
 		goto out_free_priv;
 	}
 
+	if (extra_opps) {
+		nr = 0;
+		while (1) {
+			if (freq_table[nr].frequency == CPUFREQ_TABLE_END)
+				break;
+			nr++;
+		}
+
+		for (i = 0; i < extra_opps; i++) {
+			freq_table[nr + i].flags |= CPUFREQ_BOOST_FREQ;
+			freq_table[nr + i].driver_data = boost_opps[i].u_volt;
+			freq_table[nr + i].frequency =
+						boost_opps[i].rate / 1000;
+		}
+
+		freq_table[nr + i].frequency = CPUFREQ_TABLE_END;
+	}
+
+	kfree(boost_opps);
+
 	priv->cpu_dev = cpu_dev;
 	priv->cpu_reg = cpu_reg;
 	policy->driver_data = priv;
@@ -372,6 +455,7 @@ static struct cpufreq_driver dt_cpufreq_driver = {
 
 static int dt_cpufreq_probe(struct platform_device *pdev)
 {
+	struct cpufreq_dt_platform_data *pd;
 	struct device *cpu_dev;
 	struct regulator *cpu_reg;
 	struct clk *cpu_clk;
@@ -392,7 +476,11 @@ static int dt_cpufreq_probe(struct platform_device *pdev)
 	if (!IS_ERR(cpu_reg))
 		regulator_put(cpu_reg);
 
-	dt_cpufreq_driver.driver_data = dev_get_platdata(&pdev->dev);
+	pd = dev_get_platdata(&pdev->dev);
+	dt_cpufreq_driver.driver_data = pd;
+
+	if (pd)
+		dt_cpufreq_driver.boost_supported = pd->boost_supported;
 
 	ret = cpufreq_register_driver(&dt_cpufreq_driver);
 	if (ret)
diff --git a/include/linux/cpufreq-dt.h b/include/linux/cpufreq-dt.h
index 0414009..483ca1b 100644
--- a/include/linux/cpufreq-dt.h
+++ b/include/linux/cpufreq-dt.h
@@ -17,6 +17,7 @@ struct cpufreq_dt_platform_data {
 	 * clock.
 	 */
 	bool independent_clocks;
+	bool boost_supported;
 };
 
 #endif /* __CPUFREQ_DT_H__ */
-- 
1.7.9.5
