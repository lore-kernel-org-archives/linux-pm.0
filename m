From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [RFC 4/9] sched: cpufreq: extend irq work to support fast switches
Date: Thu,  9 Mar 2017 17:15:14 +0530
Message-ID: <9d2ff35af95f5accb40d3447e6ff5970c0ba405e.1489058244.git.viresh.kumar@linaro.org>
References: <cover.1489058244.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1489058244.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1489058244.git.viresh.kumar@linaro.org>
References: <cover.1489058244.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, smuckle.linux@gmail.com, juri.lelli@arm.com, Morten.Rasmussen@arm.com, patrick.bellasi@arm.com, eas-dev@lists.linaro.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

From: Steve Muckle <smuckle.linux@gmail.com>

In preparation for schedutil receiving sched cpufreq callbacks for
remote CPUs, extend the irq work in schedutil to support policies with
fast switching enabled in addition to policies using the slow path.

Signed-off-by: Steve Muckle <smuckle.linux@gmail.com>
[ vk: minor code updates ]
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 kernel/sched/cpufreq_schedutil.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index f5ffe241812e..a418544c51b1 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -88,6 +88,17 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
 	return delta_ns >= sg_policy->freq_update_delay_ns;
 }
 
+static void sugov_fast_switch(struct cpufreq_policy *policy,
+			      unsigned int next_freq)
+{
+	next_freq = cpufreq_driver_fast_switch(policy, next_freq);
+	if (next_freq == CPUFREQ_ENTRY_INVALID)
+		return;
+
+	policy->cur = next_freq;
+	trace_cpu_frequency(next_freq, smp_processor_id());
+}
+
 static void sugov_update_commit(struct sugov_policy *sg_policy, u64 time,
 				unsigned int next_freq)
 {
@@ -100,12 +111,7 @@ static void sugov_update_commit(struct sugov_policy *sg_policy, u64 time,
 		}
 		sg_policy->next_freq = next_freq;
 		sg_policy->last_freq_update_time = time;
-		next_freq = cpufreq_driver_fast_switch(policy, next_freq);
-		if (next_freq == CPUFREQ_ENTRY_INVALID)
-			return;
-
-		policy->cur = next_freq;
-		trace_cpu_frequency(next_freq, smp_processor_id());
+		sugov_fast_switch(policy, next_freq);
 	} else if (sg_policy->next_freq != next_freq) {
 		sg_policy->next_freq = next_freq;
 		sg_policy->last_freq_update_time = time;
@@ -303,9 +309,15 @@ static void sugov_work(struct kthread_work *work)
 
 static void sugov_irq_work(struct irq_work *irq_work)
 {
-	struct sugov_policy *sg_policy;
+	struct sugov_policy *sg_policy = container_of(irq_work, struct
+						      sugov_policy, irq_work);
+	struct cpufreq_policy *policy = sg_policy->policy;
 
-	sg_policy = container_of(irq_work, struct sugov_policy, irq_work);
+	if (policy->fast_switch_enabled) {
+		sugov_fast_switch(policy, sg_policy->next_freq);
+		sg_policy->work_in_progress = false;
+		return;
+	}
 
 	/*
 	 * For RT and deadline tasks, the schedutil governor shoots the
-- 
2.7.1.410.g6faf27b
