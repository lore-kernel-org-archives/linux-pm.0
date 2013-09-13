From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 096/228] cpufreq: nforce2: don't initialize part of policy that is set by core too
Date: Fri, 13 Sep 2013 18:30:42 +0530
Message-ID: <3c20fa29fabb09e527bf8f5477d78eb4710a7fa6.1379063063.git.viresh.kumar@linaro.org>
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

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq-nforce2.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq-nforce2.c b/drivers/cpufreq/cpufreq-nforce2.c
index 56c964c..a05b876 100644
--- a/drivers/cpufreq/cpufreq-nforce2.c
+++ b/drivers/cpufreq/cpufreq-nforce2.c
@@ -360,7 +360,6 @@ static int nforce2_cpu_init(struct cpufreq_policy *policy)
 	policy->min = policy->cpuinfo.min_freq = min_fsb * fid * 100;
 	policy->max = policy->cpuinfo.max_freq = max_fsb * fid * 100;
 	policy->cpuinfo.transition_latency = CPUFREQ_ETERNAL;
-	policy->cur = nforce2_get(policy->cpu);
 
 	return 0;
 }
-- 
1.7.12.rc2.18.g61b472e

