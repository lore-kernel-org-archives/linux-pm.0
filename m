From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 Resend 42/92] cpufreq: nforce2: don't initialize part of policy that is set by core too
Date: Thu,  3 Oct 2013 20:28:36 +0530
Message-ID: <a5b6e072f2601dbe178120bd16cdfca321ace459.1380783079.git.viresh.kumar@linaro.org>
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
 drivers/cpufreq/cpufreq-nforce2.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq-nforce2.c b/drivers/cpufreq/cpufreq-nforce2.c
index b83d45f6..ef70de2 100644
--- a/drivers/cpufreq/cpufreq-nforce2.c
+++ b/drivers/cpufreq/cpufreq-nforce2.c
@@ -362,7 +362,6 @@ static int nforce2_cpu_init(struct cpufreq_policy *policy)
 	policy->min = policy->cpuinfo.min_freq = min_fsb * fid * 100;
 	policy->max = policy->cpuinfo.max_freq = max_fsb * fid * 100;
 	policy->cpuinfo.transition_latency = CPUFREQ_ETERNAL;
-	policy->cur = nforce2_get(policy->cpu);
 
 	return 0;
 }
-- 
1.7.12.rc2.18.g61b472e

