From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 31/37] cpufreq: sa11x0: don't initialize part of policy that is set by core too
Date: Wed, 14 Aug 2013 19:02:20 +0530
Message-ID: <9f8639e3a5b27389c2c6e6e18a445c22f7a632ab.1376486714.git.viresh.kumar@linaro.org>
References: <cover.1376486713.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1376486713.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1376486713.git.viresh.kumar@linaro.org>
References: <cover.1376486713.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Russell King <linux@arm.linux.org.uk>
List-Id: linux-pm@vger.kernel.org

Many common initializations of struct policy are moved to core now and hence
this driver doesn't need to do it. This patch removes such code.

Most recent of those changes is to call ->get() in the core after calling
->init().

Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/sa1100-cpufreq.c | 1 -
 drivers/cpufreq/sa1110-cpufreq.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/cpufreq/sa1100-cpufreq.c b/drivers/cpufreq/sa1100-cpufreq.c
index b9e131e..aa49a08 100644
--- a/drivers/cpufreq/sa1100-cpufreq.c
+++ b/drivers/cpufreq/sa1100-cpufreq.c
@@ -204,7 +204,6 @@ static int __init sa1100_cpu_init(struct cpufreq_policy *policy)
 {
 	if (policy->cpu != 0)
 		return -EINVAL;
-	policy->cur = sa11x0_getspeed(0);
 	policy->cpuinfo.transition_latency = CPUFREQ_ETERNAL;
 
 	return cpufreq_table_validate_and_show(policy, sa11x0_freq_table);
diff --git a/drivers/cpufreq/sa1110-cpufreq.c b/drivers/cpufreq/sa1110-cpufreq.c
index fb69553..c00cf2b 100644
--- a/drivers/cpufreq/sa1110-cpufreq.c
+++ b/drivers/cpufreq/sa1110-cpufreq.c
@@ -316,7 +316,6 @@ static int __init sa1110_cpu_init(struct cpufreq_policy *policy)
 {
 	if (policy->cpu != 0)
 		return -EINVAL;
-	policy->cur = sa11x0_getspeed(0);
 	policy->cpuinfo.transition_latency = CPUFREQ_ETERNAL;
 
 	return cpufreq_table_validate_and_show(policy, sa11x0_freq_table);
-- 
1.7.12.rc2.18.g61b472e
