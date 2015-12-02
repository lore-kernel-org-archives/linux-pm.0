From: Ben Gamari <ben@smart-cactus.org>
Subject: [PATCH 01/12] cpufreq: arm_big_little: add cluster regulator support
Date: Wed,  2 Dec 2015 22:19:16 +0100
Message-ID: <1449091167-20758-2-git-send-email-ben@smart-cactus.org>
References: <1449091167-20758-1-git-send-email-ben@smart-cactus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1449091167-20758-1-git-send-email-ben@smart-cactus.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Doug Anderson <dianders@chromium.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Kevin Hilman <khilman@linaro.org>, Heiko Stuebner <heiko@sntech.de>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, Ben Gamari <ben@smart-cactus.org>, linux-pm@vger.kernel.org, Tomasz Figa <tomasz.figa@gmail.com>, linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, b.zolnierkie@samsung.com, linux-samsung-soc@vger.kernel.org, Andreas Faerber <afaerber@suse.de>, Javier Martinez Canillas <javier@dowhile0.org>, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sachin Kamat <sachin.kamat@linaro.org>
List-Id: linux-pm@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Add cluster regulator support as a preparation to adding
generic arm_big_little_dt cpufreq_dt driver support for
ODROID-XU3 board.  This allows arm_big_little[_dt] driver
to set not only the frequency but also the voltage (which
is obtained from operating point's voltage value) for CPU
clusters.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Doug Anderson <dianders@chromium.org>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: Andreas Faerber <afaerber@suse.de>
Cc: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Ben Gamari <ben@smart-cactus.org>
---
 .../bindings/cpufreq/arm_big_little_dt.txt         |   4 +
 drivers/cpufreq/arm_big_little.c                   | 155 ++++++++++++++++++---
 2 files changed, 142 insertions(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/cpufreq/arm_big_little_dt.txt b/Documentation/devicetree/bindings/cpufreq/arm_big_little_dt.txt
index 0715695..8ca4a12 100644
--- a/Documentation/devicetree/bindings/cpufreq/arm_big_little_dt.txt
+++ b/Documentation/devicetree/bindings/cpufreq/arm_big_little_dt.txt
@@ -18,6 +18,10 @@ Required properties:
 Optional properties:
 - clock-latency: Specify the possible maximum transition latency for clock,
   in unit of nanoseconds.
+- cpu-cluster.0-supply: Provides the regulator node supplying voltage to CPU
+  cluster 0.
+- cpu-cluster.1-supply: Provides the regulator node supplying voltage to CPU
+  cluster 1.
 
 Examples:
 
diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
index c5d256c..855599b 100644
--- a/drivers/cpufreq/arm_big_little.c
+++ b/drivers/cpufreq/arm_big_little.c
@@ -31,6 +31,7 @@
 #include <linux/slab.h>
 #include <linux/topology.h>
 #include <linux/types.h>
+#include <linux/regulator/consumer.h>
 
 #include "arm_big_little.h"
 
@@ -57,6 +58,9 @@ static bool bL_switching_enabled;
 
 static struct cpufreq_arm_bL_ops *arm_bL_ops;
 static struct clk *clk[MAX_CLUSTERS];
+static struct regulator *reg[MAX_CLUSTERS];
+static struct device *cpu_devs[MAX_CLUSTERS];
+static int transition_latencies[MAX_CLUSTERS];
 static struct cpufreq_frequency_table *freq_table[MAX_CLUSTERS + 1];
 static atomic_t cluster_usage[MAX_CLUSTERS + 1];
 
@@ -125,6 +129,75 @@ static unsigned int bL_cpufreq_get_rate(unsigned int cpu)
 	}
 }
 
+static int
+bL_cpufreq_set_rate_cluster(u32 cpu, u32 cluster, u32 new_rate)
+{
+	unsigned long volt = 0, volt_old = 0;
+	long freq_Hz;
+	u32 old_rate;
+	int ret;
+
+	freq_Hz = new_rate * 1000;
+	old_rate = clk_get_rate(clk[cluster]) / 1000;
+
+	if (!IS_ERR(reg[cluster])) {
+		struct dev_pm_opp *opp;
+		unsigned long opp_freq;
+
+		rcu_read_lock();
+		opp = dev_pm_opp_find_freq_ceil(cpu_devs[cluster], &freq_Hz);
+		if (IS_ERR(opp)) {
+			rcu_read_unlock();
+			pr_err("%s: cpu %d, cluster: %d, failed to find OPP for %ld\n",
+				__func__, cpu, cluster, freq_Hz);
+			return PTR_ERR(opp);
+		}
+		volt = dev_pm_opp_get_voltage(opp);
+		opp_freq = dev_pm_opp_get_freq(opp);
+		rcu_read_unlock();
+		volt_old = regulator_get_voltage(reg[cluster]);
+		pr_debug("%s: cpu %d, cluster: %d, Found OPP: %ld kHz, %ld uV\n",
+			__func__, cpu, cluster, opp_freq / 1000, volt);
+	}
+
+	pr_debug("%s: cpu %d, cluster: %d, %u MHz, %ld mV --> %u MHz, %ld mV\n",
+		__func__, cpu, cluster,
+		old_rate / 1000, (volt_old > 0) ? volt_old / 1000 : -1,
+		new_rate / 1000, volt ? volt / 1000 : -1);
+
+	/* scaling up? scale voltage before frequency */
+	if (!IS_ERR(reg[cluster]) && new_rate > old_rate) {
+		ret = regulator_set_voltage_tol(reg[cluster], volt, 0);
+		if (ret) {
+			pr_err("%s: cpu: %d, cluster: %d, failed to scale voltage up: %d\n",
+				__func__, cpu, cluster, ret);
+			return ret;
+		}
+	}
+
+	ret = clk_set_rate(clk[cluster], new_rate * 1000);
+	if (WARN_ON(ret)) {
+		pr_err("%s: clk_set_rate failed: %d, cluster: %d\n",
+			__func__, cluster, ret);
+		if (!IS_ERR(reg[cluster]) && volt_old > 0)
+			regulator_set_voltage_tol(reg[cluster], volt_old, 0);
+		return ret;
+	}
+
+	/* scaling down? scale voltage after frequency */
+	if (!IS_ERR(reg[cluster]) && new_rate < old_rate) {
+		ret = regulator_set_voltage_tol(reg[cluster], volt, 0);
+		if (ret) {
+			pr_err("%s: cpu: %d, cluster: %d, failed to scale voltage down: %d\n",
+				__func__, cpu, cluster, ret);
+			clk_set_rate(clk[cluster], old_rate * 1000);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
 static unsigned int
 bL_cpufreq_set_rate(u32 cpu, u32 old_cluster, u32 new_cluster, u32 rate)
 {
@@ -148,7 +221,7 @@ bL_cpufreq_set_rate(u32 cpu, u32 old_cluster, u32 new_cluster, u32 rate)
 	pr_debug("%s: cpu: %d, old cluster: %d, new cluster: %d, freq: %d\n",
 			__func__, cpu, old_cluster, new_cluster, new_rate);
 
-	ret = clk_set_rate(clk[new_cluster], new_rate * 1000);
+	ret = bL_cpufreq_set_rate_cluster(cpu, new_cluster, new_rate);
 	if (!ret) {
 		/*
 		 * FIXME: clk_set_rate hasn't returned an error here however it
@@ -160,22 +233,15 @@ bL_cpufreq_set_rate(u32 cpu, u32 old_cluster, u32 new_cluster, u32 rate)
 		 */
 		if (clk_get_rate(clk[new_cluster]) != new_rate * 1000)
 			ret = -EIO;
-	}
-
-	if (WARN_ON(ret)) {
-		pr_err("clk_set_rate failed: %d, new cluster: %d\n", ret,
-				new_cluster);
-		if (bLs) {
-			per_cpu(cpu_last_req_freq, cpu) = prev_rate;
-			per_cpu(physical_cluster, cpu) = old_cluster;
-		}
+	} else if (ret && bLs) {
+		per_cpu(cpu_last_req_freq, cpu) = prev_rate;
+		per_cpu(physical_cluster, cpu) = old_cluster;
+	} 
 
-		mutex_unlock(&cluster_lock[new_cluster]);
+	mutex_unlock(&cluster_lock[new_cluster]);
 
+	if(ret)
 		return ret;
-	}
-
-	mutex_unlock(&cluster_lock[new_cluster]);
 
 	/* Recalc freq for old cluster when switching clusters */
 	if (old_cluster != new_cluster) {
@@ -195,9 +261,10 @@ bL_cpufreq_set_rate(u32 cpu, u32 old_cluster, u32 new_cluster, u32 rate)
 			pr_debug("%s: Updating rate of old cluster: %d, to freq: %d\n",
 					__func__, old_cluster, new_rate);
 
-			if (clk_set_rate(clk[old_cluster], new_rate * 1000))
-				pr_err("%s: clk_set_rate failed: %d, old cluster: %d\n",
-						__func__, ret, old_cluster);
+			if (bL_cpufreq_set_rate_cluster(cpu, old_cluster, new_rate)) {
+				pr_err("%s: bL_cpufreq_set_rate_cluster failed\n",
+					__func__);
+			}
 		}
 		mutex_unlock(&cluster_lock[old_cluster]);
 	}
@@ -304,6 +371,8 @@ static void _put_cluster_clk_and_freq_table(struct device *cpu_dev)
 		return;
 
 	clk_put(clk[cluster]);
+	if (!IS_ERR(reg[cluster]))
+		regulator_put(reg[cluster]);
 	dev_pm_opp_free_cpufreq_table(cpu_dev, &freq_table[cluster]);
 	if (arm_bL_ops->free_opp_table)
 		arm_bL_ops->free_opp_table(cpu_dev);
@@ -337,7 +406,9 @@ static void put_cluster_clk_and_freq_table(struct device *cpu_dev)
 
 static int _get_cluster_clk_and_freq_table(struct device *cpu_dev)
 {
+	unsigned long min_uV = ~0, max_uV = 0;
 	u32 cluster = raw_cpu_to_cluster(cpu_dev->id);
+	char name[14] = "cpu-cluster.";
 	int ret;
 
 	if (freq_table[cluster])
@@ -350,6 +421,51 @@ static int _get_cluster_clk_and_freq_table(struct device *cpu_dev)
 		goto out;
 	}
 
+	name[12] = cluster + '0';
+	reg[cluster] = regulator_get_optional(cpu_dev, name);
+	if (!IS_ERR(reg[cluster])) {
+		unsigned long opp_freq = 0;
+
+		dev_dbg(cpu_dev, "%s: reg: %p, cluster: %d\n",
+			__func__, reg[cluster], cluster);
+		cpu_devs[cluster] = cpu_dev;
+
+		/*
+		 * Disable any OPPs where the connected regulator isn't able to
+		 * provide the specified voltage and record minimum and maximum
+		 * voltage levels.
+		 */
+		while (1) {
+			struct dev_pm_opp *opp;
+			unsigned long opp_uV;
+
+			rcu_read_lock();
+			opp = dev_pm_opp_find_freq_ceil(cpu_dev, &opp_freq);
+			if (IS_ERR(opp)) {
+				rcu_read_unlock();
+				break;
+			}
+			opp_uV = dev_pm_opp_get_voltage(opp);
+			rcu_read_unlock();
+
+			if (regulator_is_supported_voltage(reg[cluster], opp_uV,
+							   opp_uV)) {
+				if (opp_uV < min_uV)
+					min_uV = opp_uV;
+				if (opp_uV > max_uV)
+					max_uV = opp_uV;
+			} else {
+				dev_pm_opp_disable(cpu_dev, opp_freq);
+			}
+
+			opp_freq++;
+		}
+
+		ret = regulator_set_voltage_time(reg[cluster], min_uV, max_uV);
+		if (ret > 0)
+			transition_latencies[cluster] = ret * 1000;
+	}
+
 	ret = dev_pm_opp_init_cpufreq_table(cpu_dev, &freq_table[cluster]);
 	if (ret) {
 		dev_err(cpu_dev, "%s: failed to init cpufreq table, cpu: %d, err: %d\n",
@@ -483,6 +599,11 @@ static int bL_cpufreq_init(struct cpufreq_policy *policy)
 	else
 		policy->cpuinfo.transition_latency = CPUFREQ_ETERNAL;
 
+	if (cur_cluster < MAX_CLUSTERS &&
+			policy->cpuinfo.transition_latency != CPUFREQ_ETERNAL)
+		policy->cpuinfo.transition_latency
+			+= transition_latencies[cur_cluster];
+
 	if (is_bL_switching_enabled())
 		per_cpu(cpu_last_req_freq, policy->cpu) = clk_get_cpu_rate(policy->cpu);
 
-- 
2.6.2
