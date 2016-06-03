From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 1/9] cpufreq: Use policy->freq_table in ->target_index()
Date: Fri,  3 Jun 2016 19:05:07 +0530
Message-ID: <c6b8e13cb2084abc5ec220d4b7dcba7e2749450c.1464960877.git.viresh.kumar@linaro.org>
References: <cover.1464960877.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1464960877.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1464960877.git.viresh.kumar@linaro.org>
References: <cover.1464960877.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, steve.muckle@linaro.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Shawn Guo <shawn.guo@freescale.com>, Steven Miao <realmz6@gmail.com>
List-Id: linux-pm@vger.kernel.org

The 'policy' already contains a pointer to the freq table, use that
instead of using driver specific tables name.

This is done in order to make sure that the 'index' passed to the
->target_index() callback is used *only* to index into the
policy->freq_table and nothing else.

Later patches would make changes in cpufreq core, after which
policy->freq_table may be reordered by cpufreq core and it wouldn't be
safe anymore to use 'index' for any other local array.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/arm_big_little.c       | 2 +-
 drivers/cpufreq/at32ap-cpufreq.c       | 2 +-
 drivers/cpufreq/blackfin-cpufreq.c     | 2 +-
 drivers/cpufreq/cris-artpec3-cpufreq.c | 2 +-
 drivers/cpufreq/cris-etraxfs-cpufreq.c | 2 +-
 drivers/cpufreq/dbx500-cpufreq.c       | 3 ++-
 drivers/cpufreq/e_powersaver.c         | 2 +-
 drivers/cpufreq/exynos5440-cpufreq.c   | 3 +--
 drivers/cpufreq/imx6q-cpufreq.c        | 2 +-
 drivers/cpufreq/kirkwood-cpufreq.c     | 2 +-
 drivers/cpufreq/loongson2_cpufreq.c    | 5 ++---
 11 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
index 418042201e6d..fc9e863e39d6 100644
--- a/drivers/cpufreq/arm_big_little.c
+++ b/drivers/cpufreq/arm_big_little.c
@@ -217,7 +217,7 @@ static int bL_cpufreq_set_target(struct cpufreq_policy *policy,
 	cur_cluster = cpu_to_cluster(cpu);
 	new_cluster = actual_cluster = per_cpu(physical_cluster, cpu);
 
-	freqs_new = freq_table[cur_cluster][index].frequency;
+	freqs_new = policy->freq_table[index].frequency;
 
 	if (is_bL_switching_enabled()) {
 		if ((actual_cluster == A15_CLUSTER) &&
diff --git a/drivers/cpufreq/at32ap-cpufreq.c b/drivers/cpufreq/at32ap-cpufreq.c
index 7b612c8bb09e..9231b1efb70d 100644
--- a/drivers/cpufreq/at32ap-cpufreq.c
+++ b/drivers/cpufreq/at32ap-cpufreq.c
@@ -31,7 +31,7 @@ static int at32_set_target(struct cpufreq_policy *policy, unsigned int index)
 	unsigned int old_freq, new_freq;
 
 	old_freq = policy->cur;
-	new_freq = freq_table[index].frequency;
+	new_freq = policy->freq_table[index].frequency;
 
 	if (!ref_freq) {
 		ref_freq = old_freq;
diff --git a/drivers/cpufreq/blackfin-cpufreq.c b/drivers/cpufreq/blackfin-cpufreq.c
index 12e97d8a9db0..1650c213f465 100644
--- a/drivers/cpufreq/blackfin-cpufreq.c
+++ b/drivers/cpufreq/blackfin-cpufreq.c
@@ -142,7 +142,7 @@ static int bfin_target(struct cpufreq_policy *policy, unsigned int index)
 #endif
 
 	old_freq = bfin_getfreq_khz(0);
-	new_freq = bfin_freq_table[index].frequency;
+	new_freq = policy->freq_table[index].frequency;
 
 #ifndef CONFIG_BF60x
 	plldiv = (bfin_read_PLL_DIV() & SSEL) | dpm_state_table[index].csel;
diff --git a/drivers/cpufreq/cris-artpec3-cpufreq.c b/drivers/cpufreq/cris-artpec3-cpufreq.c
index 601b88c490cf..4e7dc8f1e619 100644
--- a/drivers/cpufreq/cris-artpec3-cpufreq.c
+++ b/drivers/cpufreq/cris-artpec3-cpufreq.c
@@ -36,7 +36,7 @@ static int cris_freq_target(struct cpufreq_policy *policy, unsigned int state)
 
 	/* Even though we may be SMP they will share the same clock
 	 * so all settings are made on CPU0. */
-	if (cris_freq_table[state].frequency == 200000)
+	if (policy->freq_table[state].frequency == 200000)
 		clk_ctrl.pll = 1;
 	else
 		clk_ctrl.pll = 0;
diff --git a/drivers/cpufreq/cris-etraxfs-cpufreq.c b/drivers/cpufreq/cris-etraxfs-cpufreq.c
index 22b2cdde74d9..6ee434a54cae 100644
--- a/drivers/cpufreq/cris-etraxfs-cpufreq.c
+++ b/drivers/cpufreq/cris-etraxfs-cpufreq.c
@@ -36,7 +36,7 @@ static int cris_freq_target(struct cpufreq_policy *policy, unsigned int state)
 
 	/* Even though we may be SMP they will share the same clock
 	 * so all settings are made on CPU0. */
-	if (cris_freq_table[state].frequency == 200000)
+	if (policy->freq_table[state].frequency == 200000)
 		clk_ctrl.pll = 1;
 	else
 		clk_ctrl.pll = 0;
diff --git a/drivers/cpufreq/dbx500-cpufreq.c b/drivers/cpufreq/dbx500-cpufreq.c
index 5c3ec1dd4921..84968889ab29 100644
--- a/drivers/cpufreq/dbx500-cpufreq.c
+++ b/drivers/cpufreq/dbx500-cpufreq.c
@@ -23,7 +23,8 @@ static int dbx500_cpufreq_target(struct cpufreq_policy *policy,
 				unsigned int index)
 {
 	/* update armss clk frequency */
-	return clk_set_rate(armss_clk, freq_table[index].frequency * 1000);
+	return clk_set_rate(armss_clk,
+			    policy->freq_table[index].frequency * 1000);
 }
 
 static int dbx500_cpufreq_init(struct cpufreq_policy *policy)
diff --git a/drivers/cpufreq/e_powersaver.c b/drivers/cpufreq/e_powersaver.c
index cdf097b29862..a284bddfb067 100644
--- a/drivers/cpufreq/e_powersaver.c
+++ b/drivers/cpufreq/e_powersaver.c
@@ -163,7 +163,7 @@ static int eps_target(struct cpufreq_policy *policy, unsigned int index)
 	centaur = eps_cpu[cpu];
 
 	/* Make frequency transition */
-	dest_state = centaur->freq_table[index].driver_data & 0xffff;
+	dest_state = policy->freq_table[index].driver_data & 0xffff;
 	ret = eps_set_state(centaur, policy, dest_state);
 	if (ret)
 		pr_err("Timeout!\n");
diff --git a/drivers/cpufreq/exynos5440-cpufreq.c b/drivers/cpufreq/exynos5440-cpufreq.c
index c0f3373706f4..085f07d31ef0 100644
--- a/drivers/cpufreq/exynos5440-cpufreq.c
+++ b/drivers/cpufreq/exynos5440-cpufreq.c
@@ -212,12 +212,11 @@ static int exynos_target(struct cpufreq_policy *policy, unsigned int index)
 {
 	unsigned int tmp;
 	int i;
-	struct cpufreq_frequency_table *freq_table = dvfs_info->freq_table;
 
 	mutex_lock(&cpufreq_lock);
 
 	freqs.old = policy->cur;
-	freqs.new = freq_table[index].frequency;
+	freqs.new = policy->freq_table[index].frequency;
 
 	cpufreq_freq_transition_begin(policy, &freqs);
 
diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index ef1fa8145419..3858dc7e617b 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -49,7 +49,7 @@ static int imx6q_set_target(struct cpufreq_policy *policy, unsigned int index)
 	unsigned int old_freq, new_freq;
 	int ret;
 
-	new_freq = freq_table[index].frequency;
+	new_freq = policy->freq_table[index].frequency;
 	freq_hz = new_freq * 1000;
 	old_freq = clk_get_rate(arm_clk) / 1000;
 
diff --git a/drivers/cpufreq/kirkwood-cpufreq.c b/drivers/cpufreq/kirkwood-cpufreq.c
index be42f103db60..f63bf4fcb6fe 100644
--- a/drivers/cpufreq/kirkwood-cpufreq.c
+++ b/drivers/cpufreq/kirkwood-cpufreq.c
@@ -54,7 +54,7 @@ static unsigned int kirkwood_cpufreq_get_cpu_frequency(unsigned int cpu)
 static int kirkwood_cpufreq_target(struct cpufreq_policy *policy,
 			    unsigned int index)
 {
-	unsigned int state = kirkwood_freq_table[index].driver_data;
+	unsigned int state = policy->freq_table[index].driver_data;
 	unsigned long reg;
 
 	local_irq_disable();
diff --git a/drivers/cpufreq/loongson2_cpufreq.c b/drivers/cpufreq/loongson2_cpufreq.c
index 6bbdac1065ff..e96c98f9245a 100644
--- a/drivers/cpufreq/loongson2_cpufreq.c
+++ b/drivers/cpufreq/loongson2_cpufreq.c
@@ -58,9 +58,8 @@ static int loongson2_cpufreq_target(struct cpufreq_policy *policy,
 	cpus_allowed = current->cpus_allowed;
 	set_cpus_allowed_ptr(current, cpumask_of(cpu));
 
-	freq =
-	    ((cpu_clock_freq / 1000) *
-	     loongson2_clockmod_table[index].driver_data) / 8;
+	freq = (cpu_clock_freq / 1000) * policy->freq_table[index].driver_data;
+	freq /= 8;
 
 	set_cpus_allowed_ptr(current, &cpus_allowed);
 
-- 
2.7.1.410.g6faf27b
