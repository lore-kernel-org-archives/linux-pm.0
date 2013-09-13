From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 102/228] cpufreq: exynos: don't initialize part of policy that is set by core too
Date: Fri, 13 Sep 2013 18:30:48 +0530
Message-ID: <f2f6bbf251d75a4b4df347720efed59753ab4805.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Many common initializations of struct policy are moved to core now and hence
this driver doesn't need to do it. This patch removes such code.

Most recent of those changes is to call ->get() in the core after calling
->init().

Acked-By: Amit Daniel Kachhap <amit.daniel@samsung.com>
Acked-by: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/exynos-cpufreq.c     | 2 --
 drivers/cpufreq/exynos5440-cpufreq.c | 1 -
 2 files changed, 3 deletions(-)

diff --git a/drivers/cpufreq/exynos-cpufreq.c b/drivers/cpufreq/exynos-cpufreq.c
index 08338d4..5244086 100644
--- a/drivers/cpufreq/exynos-cpufreq.c
+++ b/drivers/cpufreq/exynos-cpufreq.c
@@ -241,8 +241,6 @@ static struct notifier_block exynos_cpufreq_nb = {
 
 static int exynos_cpufreq_cpu_init(struct cpufreq_policy *policy)
 {
-	policy->cur = policy->min = policy->max = exynos_getspeed(policy->cpu);
-
 	/* set the transition latency value */
 	policy->cpuinfo.transition_latency = 100000;
 
diff --git a/drivers/cpufreq/exynos5440-cpufreq.c b/drivers/cpufreq/exynos5440-cpufreq.c
index e33896f..a7d272b 100644
--- a/drivers/cpufreq/exynos5440-cpufreq.c
+++ b/drivers/cpufreq/exynos5440-cpufreq.c
@@ -329,7 +329,6 @@ static int exynos_cpufreq_cpu_init(struct cpufreq_policy *policy)
 		return ret;
 	}
 
-	policy->cur = dvfs_info->cur_frequency;
 	policy->cpuinfo.transition_latency = dvfs_info->latency;
 	cpumask_setall(policy->cpus);
 
-- 
1.7.12.rc2.18.g61b472e

