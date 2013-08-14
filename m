From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 37/37] cpufreq: unicore2: don't initialize part of policy that is set by core too
Date: Wed, 14 Aug 2013 19:02:26 +0530
Message-ID: <ce31927595d5b585e1df8c84f27212fd9bef6d3a.1376486714.git.viresh.kumar@linaro.org>
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
 drivers/cpufreq/unicore2-cpufreq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpufreq/unicore2-cpufreq.c b/drivers/cpufreq/unicore2-cpufreq.c
index b225f04..79ca32e 100644
--- a/drivers/cpufreq/unicore2-cpufreq.c
+++ b/drivers/cpufreq/unicore2-cpufreq.c
@@ -68,7 +68,6 @@ static int __init ucv2_cpu_init(struct cpufreq_policy *policy)
 {
 	if (policy->cpu != 0)
 		return -EINVAL;
-	policy->cur = ucv2_getspeed(0);
 	policy->min = policy->cpuinfo.min_freq = 250000;
 	policy->max = policy->cpuinfo.max_freq = 1000000;
 	policy->cpuinfo.transition_latency = CPUFREQ_ETERNAL;
-- 
1.7.12.rc2.18.g61b472e
