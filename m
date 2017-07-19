From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 4/9] cpufreq: Don't set transition_latency for setpolicy drivers
Date: Wed, 19 Jul 2017 15:42:44 +0530
Message-ID: <8f030aa6194cf1e67306f929e993e36971d1257b.1500373914.git.viresh.kumar@linaro.org>
References: <cover.1500373914.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1500373914.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1500373914.git.viresh.kumar@linaro.org>
References: <cover.1500373914.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux@dominikbrodowski.net, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The transition_latency field isn't used for drivers with ->setpolicy()
callback present and there is no point setting it from the drivers.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/intel_pstate.c | 1 -
 drivers/cpufreq/longrun.c      | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index b7fb8b7c980d..c1100a3e3325 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2138,7 +2138,6 @@ static int intel_pstate_cpu_init(struct cpufreq_policy *policy)
 	if (ret)
 		return ret;
 
-	policy->cpuinfo.transition_latency = CPUFREQ_ETERNAL;
 	if (IS_ENABLED(CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE))
 		policy->policy = CPUFREQ_POLICY_PERFORMANCE;
 	else
diff --git a/drivers/cpufreq/longrun.c b/drivers/cpufreq/longrun.c
index 074971b12635..542aa9adba1a 100644
--- a/drivers/cpufreq/longrun.c
+++ b/drivers/cpufreq/longrun.c
@@ -270,7 +270,6 @@ static int longrun_cpu_init(struct cpufreq_policy *policy)
 	/* cpuinfo and default policy values */
 	policy->cpuinfo.min_freq = longrun_low_freq;
 	policy->cpuinfo.max_freq = longrun_high_freq;
-	policy->cpuinfo.transition_latency = CPUFREQ_ETERNAL;
 	longrun_get_policy(policy);
 
 	return 0;
-- 
2.13.0.71.gd7076ec9c9cb
