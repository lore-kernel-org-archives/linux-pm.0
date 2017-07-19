From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 2/9] cpufreq: Use transition_delay_us for legacy governors as well
Date: Wed, 19 Jul 2017 15:42:42 +0530
Message-ID: <46734e7c365a024632e8b1d52990d4400899727b.1500373914.git.viresh.kumar@linaro.org>
References: <cover.1500373914.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1500373914.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1500373914.git.viresh.kumar@linaro.org>
References: <cover.1500373914.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux@dominikbrodowski.net, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The policy->transition_delay_us field is used only by the schedutil
governor currently, and this field describes how fast the driver wants
the cpufreq governor to change CPUs frequency. It should rather be a
common thing across all governors, as it doesn't have any schedutil
dependency here.

Create a new helper cpufreq_policy_transition_delay_us() to get the
transition delay across all governors.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c          | 15 +++++++++++++++
 drivers/cpufreq/cpufreq_governor.c |  9 +--------
 include/linux/cpufreq.h            |  1 +
 kernel/sched/cpufreq_schedutil.c   | 11 +----------
 4 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 9bf97a366029..c426d21822f7 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -524,6 +524,21 @@ unsigned int cpufreq_driver_resolve_freq(struct cpufreq_policy *policy,
 }
 EXPORT_SYMBOL_GPL(cpufreq_driver_resolve_freq);
 
+unsigned int cpufreq_policy_transition_delay_us(struct cpufreq_policy *policy)
+{
+	unsigned int latency;
+
+	if (policy->transition_delay_us)
+		return policy->transition_delay_us;
+
+	latency = policy->cpuinfo.transition_latency / NSEC_PER_USEC;
+	if (latency)
+		return latency * LATENCY_MULTIPLIER;
+
+	return LATENCY_MULTIPLIER;
+}
+EXPORT_SYMBOL_GPL(cpufreq_policy_transition_delay_us);
+
 /*********************************************************************
  *                          SYSFS INTERFACE                          *
  *********************************************************************/
diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index 858081f9c3d7..eed069ecfd5e 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -389,7 +389,6 @@ int cpufreq_dbs_governor_init(struct cpufreq_policy *policy)
 	struct dbs_governor *gov = dbs_governor_of(policy);
 	struct dbs_data *dbs_data;
 	struct policy_dbs_info *policy_dbs;
-	unsigned int latency;
 	int ret = 0;
 
 	/* State should be equivalent to EXIT */
@@ -428,13 +427,7 @@ int cpufreq_dbs_governor_init(struct cpufreq_policy *policy)
 	if (ret)
 		goto free_policy_dbs_info;
 
-	/* policy latency is in ns. Convert it to us first */
-	latency = policy->cpuinfo.transition_latency / 1000;
-	if (latency == 0)
-		latency = 1;
-
-	/* Bring kernel and HW constraints together */
-	dbs_data->sampling_rate = LATENCY_MULTIPLIER * latency;
+	dbs_data->sampling_rate = cpufreq_policy_transition_delay_us(policy);
 
 	if (!have_governor_per_policy())
 		gov->gdbs_data = dbs_data;
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 02aec384cab9..aaadfc543f63 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -523,6 +523,7 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
 				   unsigned int relation);
 unsigned int cpufreq_driver_resolve_freq(struct cpufreq_policy *policy,
 					 unsigned int target_freq);
+unsigned int cpufreq_policy_transition_delay_us(struct cpufreq_policy *policy);
 int cpufreq_register_governor(struct cpufreq_governor *governor);
 void cpufreq_unregister_governor(struct cpufreq_governor *governor);
 
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 29a397067ffa..89c4dd9777bb 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -528,16 +528,7 @@ static int sugov_init(struct cpufreq_policy *policy)
 		goto stop_kthread;
 	}
 
-	if (policy->transition_delay_us) {
-		tunables->rate_limit_us = policy->transition_delay_us;
-	} else {
-		unsigned int lat;
-
-		tunables->rate_limit_us = LATENCY_MULTIPLIER;
-		lat = policy->cpuinfo.transition_latency / NSEC_PER_USEC;
-		if (lat)
-			tunables->rate_limit_us *= lat;
-	}
+	tunables->rate_limit_us = cpufreq_policy_transition_delay_us(policy);
 
 	policy->governor_data = sg_policy;
 	sg_policy->tunables = tunables;
-- 
2.13.0.71.gd7076ec9c9cb
