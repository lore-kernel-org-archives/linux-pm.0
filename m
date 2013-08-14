From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 03/37] cpufreq: arm_big_little: don't initialize part of policy that is set by core too
Date: Wed, 14 Aug 2013 19:01:52 +0530
Message-ID: <164053c9d49336d2482ea27f5f8b88e416f8b1ae.1376486713.git.viresh.kumar@linaro.org>
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
 drivers/cpufreq/arm_big_little.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
index 4bba5ad..daf4423 100644
--- a/drivers/cpufreq/arm_big_little.c
+++ b/drivers/cpufreq/arm_big_little.c
@@ -164,8 +164,6 @@ static int bL_cpufreq_init(struct cpufreq_policy *policy)
 	else
 		policy->cpuinfo.transition_latency = CPUFREQ_ETERNAL;
 
-	policy->cur = bL_cpufreq_get(policy->cpu);
-
 	cpumask_copy(policy->cpus, topology_core_cpumask(policy->cpu));
 
 	dev_info(cpu_dev, "%s: CPU %d initialized\n", __func__, policy->cpu);
-- 
1.7.12.rc2.18.g61b472e
