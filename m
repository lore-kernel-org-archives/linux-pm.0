From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 133/228] cpufreq: exynos: use cpufreq_generic_init() routine
Date: Fri, 13 Sep 2013 18:31:19 +0530
Message-ID: <8e311fb003cfc82e37e4a5717a92106a2ceb15f7.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Use generic cpufreq_generic_init() routine instead of replicating the same code
here.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/exynos-cpufreq.c     |  7 +------
 drivers/cpufreq/exynos5440-cpufreq.c | 14 ++------------
 2 files changed, 3 insertions(+), 18 deletions(-)

diff --git a/drivers/cpufreq/exynos-cpufreq.c b/drivers/cpufreq/exynos-cpufreq.c
index 5244086..b96fcc8 100644
--- a/drivers/cpufreq/exynos-cpufreq.c
+++ b/drivers/cpufreq/exynos-cpufreq.c
@@ -241,12 +241,7 @@ static struct notifier_block exynos_cpufreq_nb = {
 
 static int exynos_cpufreq_cpu_init(struct cpufreq_policy *policy)
 {
-	/* set the transition latency value */
-	policy->cpuinfo.transition_latency = 100000;
-
-	cpumask_setall(policy->cpus);
-
-	return cpufreq_table_validate_and_show(policy, exynos_info->freq_table);
+	return cpufreq_generic_init(policy, exynos_info->freq_table, 100000);
 }
 
 static struct cpufreq_driver exynos_driver = {
diff --git a/drivers/cpufreq/exynos5440-cpufreq.c b/drivers/cpufreq/exynos5440-cpufreq.c
index a7d272b..e6fae7f 100644
--- a/drivers/cpufreq/exynos5440-cpufreq.c
+++ b/drivers/cpufreq/exynos5440-cpufreq.c
@@ -321,18 +321,8 @@ static void exynos_sort_descend_freq_table(void)
 
 static int exynos_cpufreq_cpu_init(struct cpufreq_policy *policy)
 {
-	int ret;
-
-	ret = cpufreq_table_validate_and_show(policy, dvfs_info->freq_table);
-	if (ret) {
-		dev_err(dvfs_info->dev, "Invalid frequency table: %d\n", ret);
-		return ret;
-	}
-
-	policy->cpuinfo.transition_latency = dvfs_info->latency;
-	cpumask_setall(policy->cpus);
-
-	return 0;
+	return cpufreq_generic_init(policy, dvfs_info->freq_table,
+			dvfs_info->latency);
 }
 
 static struct cpufreq_driver exynos_driver = {
-- 
1.7.12.rc2.18.g61b472e
