From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 26/37] cpufreq: powernow: don't initialize part of policy that is set by core too
Date: Wed, 14 Aug 2013 19:02:15 +0530
Message-ID: <65b1af50f727870c124ed102cf4ef1c7e7417664.1376486713.git.viresh.kumar@linaro.org>
References: <cover.1376486713.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1376486713.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1376486713.git.viresh.kumar@linaro.org>
References: <cover.1376486713.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
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
index cb19fb8..643e795 100644
--- a/drivers/cpufreq/powernow-k6.c
+++ b/drivers/cpufreq/powernow-k6.c
@@ -126,7 +126,6 @@ static int powernow_k6_cpu_init(struct cpufreq_policy *policy)
 
 	/* cpuinfo and default policy values */
 	policy->cpuinfo.transition_latency = 200000;
-	policy->cur = busfreq * max_multiplier;
 
 	return cpufreq_table_validate_and_show(policy, clock_ratio);
 }
diff --git a/drivers/cpufreq/powernow-k7.c b/drivers/cpufreq/powernow-k7.c
index 7c76f03..946708a 100644
--- a/drivers/cpufreq/powernow-k7.c
+++ b/drivers/cpufreq/powernow-k7.c
@@ -659,8 +659,6 @@ static int powernow_cpu_init(struct cpufreq_policy *policy)
 	policy->cpuinfo.transition_latency =
 		cpufreq_scale(2000000UL, fsb, latency);
 
-	policy->cur = powernow_get(0);
-
 	return cpufreq_table_validate_and_show(policy, powernow_table);
 }
 
diff --git a/drivers/cpufreq/powernow-k8.c b/drivers/cpufreq/powernow-k8.c
index 80bc606..62a1ce4 100644
--- a/drivers/cpufreq/powernow-k8.c
+++ b/drivers/cpufreq/powernow-k8.c
@@ -1133,9 +1133,6 @@ static int powernowk8_cpu_init(struct cpufreq_policy *pol)
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
