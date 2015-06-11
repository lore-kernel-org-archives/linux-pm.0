From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH 1/8] cpufreq: arm_big_little: add cluster regulator support
Date: Fri, 12 Jun 2015 00:17:17 +0200
Message-ID: <2090246.ynyoecCn6f@diego>
References: <1429622278-12216-1-git-send-email-b.zolnierkie@samsung.com> <1429622278-12216-2-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:49968 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752324AbbFKWRc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 11 Jun 2015 18:17:32 -0400
In-Reply-To: <1429622278-12216-2-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Mike Turquette <mturquette@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, Andreas Faerber <afaerber@suse.de>, Sachin Kamat <sachin.kamat@linaro.org>

Hi,

Am Dienstag, 21. April 2015, 15:17:51 schrieb Bartlomiej Zolnierkiewicz:
> Add cluster regulator support as a preparation to adding
> generic arm_big_little_dt cpufreq_dt driver support for
> ODROID-XU3 board.  This allows arm_big_little[_dt] driver
> to set not only the frequency but also the voltage (which
> is obtained from operating point's voltage value) for CPU
> clusters.
> 
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Doug Anderson <dianders@chromium.org>
> Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> Cc: Andreas Faerber <afaerber@suse.de>
> Cc: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Thomas Abraham <thomas.ab@samsung.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

I gave this a spin on the rk3368 arm64 soc from Rockchip, mainly to check if
my armclk handling was correct.

Your patch here only supports individual supplies per cluster but my
current board shares the supplies over both cpu clusters, so I've cooked
up a patch to also try to support shared supplies
[0].

Nevertheless,
Tested-by: Heiko Stuebner <heiko@sntech.de>

Do you plan to continue working on this?


Thanks
Heiko


[0] ---------------- 8< -----------------------------
From: Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH] cpufreq: arm_big_little: add support for shared cluster regulators

In some socs or board designs the supplying regulator is shared between
more than one cluster but the current regulator support for big_little
sets the target voltage without any tolerance.

So when cluster0 requests 0.9V and cluster1 1.3V no suitable frequency
span is available that fits both. To accomodate this, look for shared
regulators and calculate the maximum voltage necessary. If the regulator
of the remote cluster has a lower voltage, its maximum also gets increased.

If cluster supplies are not shared, the behaviour is the same as before
with one specific voltage being set instead of a voltage-range.

When adapting shared voltages the remote clusters need to be locked too,
because cpufreq can very well try to change more than one cluster at the
same time. While the used mutex_trylock prevents deadlocks reliably,
it might also prevent some (or a lot) frequency changes from succeeding:

	lock cluster0
				lock cluster1
	trylock cluster1
				trylock cluster0
			both fail

I'm probably simply overlooking some better way currently.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/cpufreq/arm_big_little.c | 102 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 91 insertions(+), 11 deletions(-)

diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
index e04ca0c..c65b111 100644
--- a/drivers/cpufreq/arm_big_little.c
+++ b/drivers/cpufreq/arm_big_little.c
@@ -130,12 +130,78 @@ static unsigned int bL_cpufreq_get_rate(unsigned int cpu)
 }
 
 static int
+bL_adapt_shared_regulators(u32 cluster, unsigned long *volt_max)
+{
+	unsigned long other_volt;
+	int ret, i;
+
+	for (i = 0; i < MAX_CLUSTERS; i++) {
+		if (i == cluster || IS_ERR_OR_NULL(reg[i]))
+			continue;
+
+		if (regulator_is_match(reg[cluster], reg[i])) {
+			other_volt = regulator_get_voltage(reg[i]);
+			if (other_volt > *volt_max) {
+				*volt_max = other_volt;
+			} else {
+				pr_debug("%s: adapting shared regulator in cluster %d to %lu-%lu mV\n",
+					 __func__, i, other_volt / 1000, *volt_max / 1000);
+				ret = regulator_set_voltage(reg[i], other_volt, *volt_max);
+				if (ret) {
+					pr_err("%s: shared-supply for cluster: %d, failed to scale voltage up: %d\n",
+					       __func__, cluster, ret);
+					return ret;
+				}
+			}
+		}
+	}
+
+	return 0;
+}
+
+static int
+bL_lock_shared_regulators(u32 cluster)
+{
+	int ret, i;
+
+	for (i = 0; i < MAX_CLUSTERS; i++) {
+		if (i == cluster || IS_ERR_OR_NULL(reg[i]))
+			continue;
+
+		if (regulator_is_match(reg[cluster], reg[i])) {
+			ret = mutex_trylock(&cluster_lock[i]);
+			if (!ret) {
+				for (i--; i >= 0; i--)
+					mutex_unlock(&cluster_lock[i]);
+				return -EBUSY;
+			}
+		}
+	}
+
+	return 0;
+}
+
+static void
+bL_unlock_shared_regulators(u32 cluster)
+{
+	int i;
+
+	for (i = 0; i < MAX_CLUSTERS; i++) {
+		if (i == cluster || IS_ERR_OR_NULL(reg[i]))
+			continue;
+
+		if (regulator_is_match(reg[cluster], reg[i]))
+			mutex_unlock(&cluster_lock[i]);
+	}
+}
+
+static int
 bL_cpufreq_set_rate_cluster(u32 cpu, u32 cluster, u32 new_rate)
 {
-	unsigned long volt = 0, volt_old = 0;
+	unsigned long volt = 0, volt_max = 0, volt_old = 0;
 	long freq_Hz;
 	u32 old_rate;
-	int ret;
+	int ret = 0;
 
 	freq_Hz = new_rate * 1000;
 	old_rate = clk_get_rate(clk[cluster]) / 1000;
@@ -144,13 +210,18 @@ bL_cpufreq_set_rate_cluster(u32 cpu, u32 cluster, u32 new_rate)
 		struct dev_pm_opp *opp;
 		unsigned long opp_freq;
 
+		ret = bL_lock_shared_regulators(cluster);
+		if(ret)
+			return 0;
+
 		rcu_read_lock();
 		opp = dev_pm_opp_find_freq_ceil(cpu_devs[cluster], &freq_Hz);
 		if (IS_ERR(opp)) {
 			rcu_read_unlock();
 			pr_err("%s: cpu %d, cluster: %d, failed to find OPP for %ld\n",
 				__func__, cpu, cluster, freq_Hz);
-			return PTR_ERR(opp);
+			ret = PTR_ERR(opp);
+			goto unlock;
 		}
 		volt = dev_pm_opp_get_voltage(opp);
 		opp_freq = dev_pm_opp_get_freq(opp);
@@ -158,20 +229,25 @@ bL_cpufreq_set_rate_cluster(u32 cpu, u32 cluster, u32 new_rate)
 		volt_old = regulator_get_voltage(reg[cluster]);
 		pr_debug("%s: cpu %d, cluster: %d, Found OPP: %ld kHz, %ld uV\n",
 			__func__, cpu, cluster, opp_freq / 1000, volt);
+
+		volt_max = volt;
+		ret = bL_adapt_shared_regulators(cluster, &volt_max);
+		if (ret)
+			goto unlock;
 	}
 
-	pr_debug("%s: cpu %d, cluster: %d, %u MHz, %ld mV --> %u MHz, %ld mV\n",
+	pr_debug("%s: cpu %d, cluster: %d, %u MHz, %ld mV --> %u MHz, %ld-%ld mV\n",
 		__func__, cpu, cluster,
 		old_rate / 1000, (volt_old > 0) ? volt_old / 1000 : -1,
-		new_rate / 1000, volt ? volt / 1000 : -1);
+		new_rate / 1000, volt ? volt / 1000 : -1, volt_max ? volt_max / 1000 : -1);
 
 	/* scaling up? scale voltage before frequency */
 	if (!IS_ERR(reg[cluster]) && new_rate > old_rate) {
-		ret = regulator_set_voltage_tol(reg[cluster], volt, 0);
+		ret = regulator_set_voltage(reg[cluster], volt, volt_max);
 		if (ret) {
 			pr_err("%s: cpu: %d, cluster: %d, failed to scale voltage up: %d\n",
 				__func__, cpu, cluster, ret);
-			return ret;
+			goto unlock;
 		}
 	}
 
@@ -181,21 +257,25 @@ bL_cpufreq_set_rate_cluster(u32 cpu, u32 cluster, u32 new_rate)
 			__func__, cluster, ret);
 		if (!IS_ERR(reg[cluster]) && volt_old > 0)
 			regulator_set_voltage_tol(reg[cluster], volt_old, 0);
-		return ret;
+		goto unlock;
 	}
 
 	/* scaling down? scale voltage after frequency */
 	if (!IS_ERR(reg[cluster]) && new_rate < old_rate) {
-		ret = regulator_set_voltage_tol(reg[cluster], volt, 0);
+		ret = regulator_set_voltage(reg[cluster], volt, volt_max);
 		if (ret) {
 			pr_err("%s: cpu: %d, cluster: %d, failed to scale voltage down: %d\n",
 				__func__, cpu, cluster, ret);
 			clk_set_rate(clk[cluster], old_rate * 1000);
-			return ret;
+			goto unlock;
 		}
 	}
 
-	return 0;
+unlock:
+	if (!IS_ERR(reg[cluster]))
+		bL_unlock_shared_regulators(cluster);
+
+	return ret;
 }
 
 static int
-- 
2.1.4

---------------- 8< ----------------
From: Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH] regulator: add a regulator_is_match function

Another stolen concept from the common clock framework. At some points it
can be useful to check if two regulator structs are actually pointing to
the same regulator_dev.

The usecase in question was to check if the supplying regulators of two
cpu clusters are actually the same and the regulator is thus shared
between these cpu clusters.

Therefore add regulator_is_match() that compares the rdev pointers
of two regulators and emits a bool stating if they match.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/regulator/core.c           | 23 +++++++++++++++++++++++
 include/linux/regulator/consumer.h |  7 +++++++
 2 files changed, 30 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 443eaab..6bb7e70 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1591,6 +1591,29 @@ void regulator_put(struct regulator *regulator)
 EXPORT_SYMBOL_GPL(regulator_put);
 
 /**
+ * regulator_is_match - check if two regulator's point to the same rdev
+ * @p: regulator compared against q
+ * @q: regulator compared against p
+ *
+ * Returns true if the two struct regulator pointers both point to the same rdev
+ * Returns false otherwise. Note that two NULL clks are treated as matching.
+ */
+bool regulator_is_match(const struct regulator *p, const struct regulator *q)
+{
+	/* trivial case: identical struct regulator's or both NULL */
+	if (p == q)
+		return true;
+
+	/* true if clk->core pointers match. Avoid derefing garbage */
+	if (!IS_ERR_OR_NULL(p) && !IS_ERR_OR_NULL(q))
+		if (p->rdev == q->rdev)
+			return true;
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(regulator_is_match);
+
+/**
  * regulator_register_supply_alias - Provide device alias for supply lookup
  *
  * @dev: device that will be given as the regulator "consumer"
diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator/consumer.h
index f8a689e..38ffaa0 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -172,6 +172,7 @@ struct regulator *__must_check devm_regulator_get_optional(struct device *dev,
 							   const char *id);
 void regulator_put(struct regulator *regulator);
 void devm_regulator_put(struct regulator *regulator);
+bool regulator_is_match(const struct regulator *p, const struct regulator *q);
 
 int regulator_register_supply_alias(struct device *dev, const char *id,
 				    struct device *alias_dev,
@@ -316,6 +317,12 @@ static inline void devm_regulator_put(struct regulator *regulator)
 {
 }
 
+static inline bool regulator_is_match(const struct regulator *p,
+				      const struct regulator *q)
+{
+	return true;
+}
+
 static inline int regulator_register_supply_alias(struct device *dev,
 						  const char *id,
 						  struct device *alias_dev,
-- 
2.1.4



