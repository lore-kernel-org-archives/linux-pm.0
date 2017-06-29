From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 4/6] cpufreq: Use transition_delay_us for legacy governors as well
Date: Thu, 29 Jun 2017 16:29:07 +0530
Message-ID: <157b6fdb97615e47126fcad7d7bc40370ed672f0.1498733506.git.viresh.kumar@linaro.org>
References: <cover.1498733506.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f52.google.com ([74.125.83.52]:35561 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752670AbdF2K71 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Jun 2017 06:59:27 -0400
Received: by mail-pg0-f52.google.com with SMTP id j186so46254435pge.2
        for <linux-pm@vger.kernel.org>; Thu, 29 Jun 2017 03:59:27 -0700 (PDT)
In-Reply-To: <cover.1498733506.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1498733506.git.viresh.kumar@linaro.org>
References: <cover.1498733506.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux-kernel@vger.kernel.org

The policy->transition_delay_us field is used only by the schedutil
governor currently, but it should rather be a common thing across all
governors.

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
index 083e7f3c23dd..dee6fe3d8af0 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -529,6 +529,21 @@ static inline void cpufreq_policy_apply_limits(struct cpufreq_policy *policy)
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
index 076a2e31951c..3bdec2a08e1e 100644
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
