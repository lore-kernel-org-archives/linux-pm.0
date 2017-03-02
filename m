From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 1/3] cpufreq: schedutil: move cached_raw_freq to struct sugov_policy
Date: Thu,  2 Mar 2017 14:03:20 +0530
Message-ID: <0ee63c640d47281997d544d05f9dd543aef80588.1488437503.git.viresh.kumar@linaro.org>
References: <cover.1488437503.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:33293 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750733AbdCBIjy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Mar 2017 03:39:54 -0500
Received: by mail-pf0-f177.google.com with SMTP id w189so20002517pfb.0
        for <linux-pm@vger.kernel.org>; Thu, 02 Mar 2017 00:39:53 -0800 (PST)
In-Reply-To: <cover.1488437503.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1488437503.git.viresh.kumar@linaro.org>
References: <cover.1488437503.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>

cached_raw_freq applies to the entire cpufreq policy and not individual
CPUs. Apart from wasting per-cpu memory, it is actually wrong to keep it
in struct sugov_cpu as we may end up comparing next_freq with a stale
cached_raw_freq of a random CPU.

Move cached_raw_freq to struct sugov_policy.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 kernel/sched/cpufreq_schedutil.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 306d97e7b57c..721f4e011366 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -35,6 +35,7 @@ struct sugov_policy {
 	u64 last_freq_update_time;
 	s64 freq_update_delay_ns;
 	unsigned int next_freq;
+	unsigned int cached_raw_freq;
 
 	/* The next fields are only needed if fast switch cannot be used. */
 	struct irq_work irq_work;
@@ -51,7 +52,6 @@ struct sugov_cpu {
 	struct update_util_data update_util;
 	struct sugov_policy *sg_policy;
 
-	unsigned int cached_raw_freq;
 	unsigned long iowait_boost;
 	unsigned long iowait_boost_max;
 	u64 last_update;
@@ -145,9 +145,9 @@ static unsigned int get_next_freq(struct sugov_cpu *sg_cpu, unsigned long util,
 
 	freq = (freq + (freq >> 2)) * util / max;
 
-	if (freq == sg_cpu->cached_raw_freq && sg_policy->next_freq != UINT_MAX)
+	if (freq == sg_policy->cached_raw_freq && sg_policy->next_freq != UINT_MAX)
 		return sg_policy->next_freq;
-	sg_cpu->cached_raw_freq = freq;
+	sg_policy->cached_raw_freq = freq;
 	return cpufreq_driver_resolve_freq(policy, freq);
 }
 
@@ -579,6 +579,7 @@ static int sugov_start(struct cpufreq_policy *policy)
 	sg_policy->next_freq = UINT_MAX;
 	sg_policy->work_in_progress = false;
 	sg_policy->need_freq_update = false;
+	sg_policy->cached_raw_freq = 0;
 
 	for_each_cpu(cpu, policy->cpus) {
 		struct sugov_cpu *sg_cpu = &per_cpu(sugov_cpu, cpu);
@@ -589,7 +590,6 @@ static int sugov_start(struct cpufreq_policy *policy)
 			sg_cpu->max = 0;
 			sg_cpu->flags = SCHED_CPUFREQ_RT;
 			sg_cpu->last_update = 0;
-			sg_cpu->cached_raw_freq = 0;
 			sg_cpu->iowait_boost = 0;
 			sg_cpu->iowait_boost_max = policy->cpuinfo.max_freq;
 			cpufreq_add_update_util_hook(cpu, &sg_cpu->update_util,
-- 
2.7.1.410.g6faf27b
