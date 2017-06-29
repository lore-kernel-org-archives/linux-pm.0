From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 1/4] cpufreq: schedutil: Process remote callback for shared policies
Date: Thu, 29 Jun 2017 10:56:30 +0530
Message-ID: <643fe4ad707e3b02336ecf069e7f022d770bec98.1498712046.git.viresh.kumar@linaro.org>
References: <cover.1498712046.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:35337 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751850AbdF2F15 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Jun 2017 01:27:57 -0400
Received: by mail-pf0-f169.google.com with SMTP id c73so44560181pfk.2
        for <linux-pm@vger.kernel.org>; Wed, 28 Jun 2017 22:27:57 -0700 (PDT)
In-Reply-To: <cover.1498712046.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1498712046.git.viresh.kumar@linaro.org>
References: <cover.1498712046.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux-kernel@vger.kernel.org, smuckle.linux@gmail.com, juri.lelli@arm.com, Morten.Rasmussen@arm.com, patrick.bellasi@arm.com, eas-dev@lists.linaro.org

This patch updates the schedutil governor to process cpufreq utilization
update hooks called for remote CPUs (i.e. For updates to the
runqueue of other non-local CPUs). For now, we only support remote
callbacks for CPUs which share their cpufreq policy with the local CPU.

It may not be worth allowing remote callbacks in other cases, as we
wouldn't be able to update the frequency on local CPU in that case.

The schedutil governor already has proper locking in place for shared
policy update hooks.

This also adds a new field "cpu" in "struct update_util_data", to
identify the remote CPU.

Based on initial work from Steve Muckle.

Signed-off-by: Steve Muckle <smuckle.linux@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 include/linux/sched/cpufreq.h    |  1 +
 kernel/sched/cpufreq.c           |  1 +
 kernel/sched/cpufreq_schedutil.c | 19 ++++++++++++++-----
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/include/linux/sched/cpufreq.h b/include/linux/sched/cpufreq.h
index d2be2ccbb372..8256a8f35f22 100644
--- a/include/linux/sched/cpufreq.h
+++ b/include/linux/sched/cpufreq.h
@@ -16,6 +16,7 @@
 #ifdef CONFIG_CPU_FREQ
 struct update_util_data {
        void (*func)(struct update_util_data *data, u64 time, unsigned int flags);
+       unsigned int cpu;
 };
 
 void cpufreq_add_update_util_hook(int cpu, struct update_util_data *data,
diff --git a/kernel/sched/cpufreq.c b/kernel/sched/cpufreq.c
index dbc51442ecbc..ee4c596b71b4 100644
--- a/kernel/sched/cpufreq.c
+++ b/kernel/sched/cpufreq.c
@@ -42,6 +42,7 @@ void cpufreq_add_update_util_hook(int cpu, struct update_util_data *data,
 		return;
 
 	data->func = func;
+	data->cpu = cpu;
 	rcu_assign_pointer(per_cpu(cpufreq_update_util_data, cpu), data);
 }
 EXPORT_SYMBOL_GPL(cpufreq_add_update_util_hook);
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 076a2e31951c..3f9cae9ab326 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -154,12 +154,12 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
 	return cpufreq_driver_resolve_freq(policy, freq);
 }
 
-static void sugov_get_util(unsigned long *util, unsigned long *max)
+static void sugov_get_util(unsigned long *util, unsigned long *max, int cpu)
 {
-	struct rq *rq = this_rq();
+	struct rq *rq = cpu_rq(cpu);
 	unsigned long cfs_max;
 
-	cfs_max = arch_scale_cpu_capacity(NULL, smp_processor_id());
+	cfs_max = arch_scale_cpu_capacity(NULL, cpu);
 
 	*util = min(rq->cfs.avg.util_avg, cfs_max);
 	*max = cfs_max;
@@ -218,6 +218,10 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
 	unsigned int next_f;
 	bool busy;
 
+	/* Remote callbacks aren't allowed for policies which aren't shared */
+	if (smp_processor_id() != hook->cpu)
+		return;
+
 	sugov_set_iowait_boost(sg_cpu, time, flags);
 	sg_cpu->last_update = time;
 
@@ -229,7 +233,7 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
 	if (flags & SCHED_CPUFREQ_RT_DL) {
 		next_f = policy->cpuinfo.max_freq;
 	} else {
-		sugov_get_util(&util, &max);
+		sugov_get_util(&util, &max, hook->cpu);
 		sugov_iowait_boost(sg_cpu, &util, &max);
 		next_f = get_next_freq(sg_policy, util, max);
 		/*
@@ -287,10 +291,15 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
 {
 	struct sugov_cpu *sg_cpu = container_of(hook, struct sugov_cpu, update_util);
 	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
+	struct cpufreq_policy *policy = sg_policy->policy;
 	unsigned long util, max;
 	unsigned int next_f;
 
-	sugov_get_util(&util, &max);
+	/* Allow remote callbacks only on the CPUs sharing cpufreq policy */
+	if (!cpumask_test_cpu(smp_processor_id(), policy->cpus))
+		return;
+
+	sugov_get_util(&util, &max, hook->cpu);
 
 	raw_spin_lock(&sg_policy->update_lock);
 
-- 
2.13.0.71.gd7076ec9c9cb
