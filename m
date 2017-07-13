From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [RFC V2 4/6] cpufreq: Use transition_delay_us for legacy governors as well
Date: Thu, 13 Jul 2017 11:10:55 +0530
Message-ID: <2b3bfd2566ecaa0635c29a49c110e16803f80db0.1499853492.git.viresh.kumar@linaro.org>
References: <cover.1499853492.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f52.google.com ([74.125.83.52]:36562 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751188AbdGMFl5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Jul 2017 01:41:57 -0400
Received: by mail-pg0-f52.google.com with SMTP id u62so24031326pgb.3
        for <linux-pm@vger.kernel.org>; Wed, 12 Jul 2017 22:41:47 -0700 (PDT)
In-Reply-To: <cover.1499853492.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1499853492.git.viresh.kumar@linaro.org>
References: <cover.1499853492.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux@dominikbrodowski.net, linux-kernel@vger.kernel.org

The policy->transition_delay_us field is used only by the schedutil
governor currently, and this field describes how fast the driver wants
the cpufreq governor to change CPUs frequency. It should rather be a
common thing across all governors, as it doesn't have any schedutil
dependency here.

Create a new helper cpufreq_policy_transition_delay_us() to get the
transition delay across all governors.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_governor.c |  9 +--------
 include/linux/cpufreq.h            | 15 +++++++++++++++
 kernel/sched/cpufreq_schedutil.c   | 11 +----------
 3 files changed, 17 insertions(+), 18 deletions(-)

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
index 00e4c40a3249..14f0ab61ed17 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -532,6 +532,21 @@ static inline void cpufreq_policy_apply_limits(struct cpufreq_policy *policy)
 		__cpufreq_driver_target(policy, policy->min, CPUFREQ_RELATION_L);
 }
 
+static inline unsigned int
+cpufreq_policy_transition_delay_us(struct cpufreq_policy *policy)
+{
+	unsigned int delay_us = LATENCY_MULTIPLIER, latency;
+
+	if (policy->transition_delay_us)
+		return policy->transition_delay_us;
+
+	latency = policy->cpuinfo.transition_latency / NSEC_PER_USEC;
+	if (latency)
+		delay_us *= latency;
+
+	return delay_us;
+}
+
 /* Governor attribute set */
 struct gov_attr_set {
 	struct kobject kobj;
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index ab9d7a1b43dc..5c72c569ec2f 100644
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
