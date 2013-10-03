From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 Resend 61/92] cpufreq: powernow: don't initialize part of policy that is set by core too
Date: Thu,  3 Oct 2013 20:28:55 +0530
Message-ID: <d895ffbbabc5bd8a504827f23180330998596256.1380783079.git.viresh.kumar@linaro.org>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <cover.1380783079.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1380783079.git.viresh.kumar@linaro.org>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Many common initializations of struct policy are moved to core now and hence
this driver doesn't need to do it. This patch removes such code.

Most recent of those changes is to call ->get() in the core after calling
->init().

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/powernow-k6.c | 1 -
 drivers/cpufreq/powernow-k7.c | 2 --
 drivers/cpufreq/powernow-k8.c | 3 ---
 3 files changed, 6 deletions(-)

diff --git a/drivers/cpufreq/powernow-k6.c b/drivers/cpufreq/powernow-k6.c
index ff05d28..eda1702 100644
--- a/drivers/cpufreq/powernow-k6.c
+++ b/drivers/cpufreq/powernow-k6.c
@@ -151,7 +151,6 @@ static int powernow_k6_cpu_init(struct cpufreq_policy *policy)
 
 	/* cpuinfo and default policy values */
 	policy->cpuinfo.transition_latency = 200000;
-	policy->cur = busfreq * max_multiplier;
 
 	return cpufreq_table_validate_and_show(policy, clock_ratio);
 }
diff --git a/drivers/cpufreq/powernow-k7.c b/drivers/cpufreq/powernow-k7.c
index 14cd98f..44d345b 100644
--- a/drivers/cpufreq/powernow-k7.c
+++ b/drivers/cpufreq/powernow-k7.c
@@ -673,8 +673,6 @@ static int powernow_cpu_init(struct cpufreq_policy *policy)
 	policy->cpuinfo.transition_latency =
 		cpufreq_scale(2000000UL, fsb, latency);
 
-	policy->cur = powernow_get(0);
-
 	return cpufreq_table_validate_and_show(policy, powernow_table);
 }
 
diff --git a/drivers/cpufreq/powernow-k8.c b/drivers/cpufreq/powernow-k8.c
index 1e6f68a..298beb7 100644
--- a/drivers/cpufreq/powernow-k8.c
+++ b/drivers/cpufreq/powernow-k8.c
@@ -1141,9 +1141,6 @@ static int powernowk8_cpu_init(struct cpufreq_policy *pol)
 	cpumask_copy(pol->cpus, cpu_core_mask(pol->cpu));
 	data->available_cores = pol->cpus;
 
-	pol->cur = find_khz_freq_from_fid(data->currfid);
-	pr_debug("policy current frequency %d kHz\n", pol->cur);
-
 	/* min/max the cpu is capable of */
 	if (cpufreq_table_validate_and_show(pol, data->powernow_table)) {
 		printk(KERN_ERR FW_BUG PFX "invalid powernow_table\n");
-- 
1.7.12.rc2.18.g61b472e

