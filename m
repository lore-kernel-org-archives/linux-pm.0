From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 Resend 38/92] cpufreq: arm_big_little: don't initialize part of policy that is set by core too
Date: Thu,  3 Oct 2013 20:28:32 +0530
Message-ID: <849b2bb0f42c26b237c5cc4af6c71e21c91dc7e4.1380783079.git.viresh.kumar@linaro.org>
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
 drivers/cpufreq/arm_big_little.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
index 7e92586..8075eb6 100644
--- a/drivers/cpufreq/arm_big_little.c
+++ b/drivers/cpufreq/arm_big_little.c
@@ -171,8 +171,6 @@ static int bL_cpufreq_init(struct cpufreq_policy *policy)
 	else
 		policy->cpuinfo.transition_latency = CPUFREQ_ETERNAL;
 
-	policy->cur = bL_cpufreq_get(policy->cpu);
-
 	cpumask_copy(policy->cpus, topology_core_cpumask(policy->cpu));
 
 	dev_info(cpu_dev, "%s: CPU %d initialized\n", __func__, policy->cpu);
-- 
1.7.12.rc2.18.g61b472e

