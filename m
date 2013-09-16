From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 Resend 14/44] cpufreq: exynos: use cpufreq_table_validate_and_show()
Date: Mon, 16 Sep 2013 18:56:16 +0530
Message-ID: <0bbae405428e678a8a59d4f3c76393b0fbf5f856.1379309339.git.viresh.kumar@linaro.org>
References: <cover.1379309339.git.viresh.kumar@linaro.org>
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <cover.1379309339.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1379309339.git.viresh.kumar@linaro.org>
References: <cover.1379309339.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Lets use cpufreq_table_validate_and_show() instead of calling
cpufreq_frequency_table_cpuinfo() and cpufreq_frequency_table_get_attr().

Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/exynos-cpufreq.c     | 4 +---
 drivers/cpufreq/exynos5440-cpufreq.c | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/exynos-cpufreq.c b/drivers/cpufreq/exynos-cpufreq.c
index 0fac344..954baed 100644
--- a/drivers/cpufreq/exynos-cpufreq.c
+++ b/drivers/cpufreq/exynos-cpufreq.c
@@ -249,14 +249,12 @@ static int exynos_cpufreq_cpu_init(struct cpufreq_policy *policy)
 {
 	policy->cur = policy->min = policy->max = exynos_getspeed(policy->cpu);
 
-	cpufreq_frequency_table_get_attr(exynos_info->freq_table, policy->cpu);
-
 	/* set the transition latency value */
 	policy->cpuinfo.transition_latency = 100000;
 
 	cpumask_setall(policy->cpus);
 
-	return cpufreq_frequency_table_cpuinfo(policy, exynos_info->freq_table);
+	return cpufreq_table_validate_and_show(policy, exynos_info->freq_table);
 }
 
 static int exynos_cpufreq_cpu_exit(struct cpufreq_policy *policy)
diff --git a/drivers/cpufreq/exynos5440-cpufreq.c b/drivers/cpufreq/exynos5440-cpufreq.c
index d514c15..cf52759 100644
--- a/drivers/cpufreq/exynos5440-cpufreq.c
+++ b/drivers/cpufreq/exynos5440-cpufreq.c
@@ -326,7 +326,7 @@ static int exynos_cpufreq_cpu_init(struct cpufreq_policy *policy)
 {
 	int ret;
 
-	ret = cpufreq_frequency_table_cpuinfo(policy, dvfs_info->freq_table);
+	ret = cpufreq_table_validate_and_show(policy, dvfs_info->freq_table);
 	if (ret) {
 		dev_err(dvfs_info->dev, "Invalid frequency table: %d\n", ret);
 		return ret;
@@ -336,8 +336,6 @@ static int exynos_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	policy->cpuinfo.transition_latency = dvfs_info->latency;
 	cpumask_setall(policy->cpus);
 
-	cpufreq_frequency_table_get_attr(dvfs_info->freq_table, policy->cpu);
-
 	return 0;
 }
 
-- 
1.7.12.rc2.18.g61b472e

