From: Michael Turquette <mturquette@baylibre.com>
Subject: [PATCH 7/8] cpufreq: Frequency invariant scheduler load-tracking support
Date: Sun, 13 Mar 2016 22:22:11 -0700
Message-ID: <1457932932-28444-8-git-send-email-mturquette+renesas@baylibre.com>
References: <1457932932-28444-1-git-send-email-mturquette+renesas@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1457932932-28444-1-git-send-email-mturquette+renesas@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, rjw@rjwysocki.net
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Juri.Lelli@arm.com, steve.muckle@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, vincent.guittot@linaro.org, Michael Turquette <mturquette+renesas@baylibre.com>
List-Id: linux-pm@vger.kernel.org

From: Dietmar Eggemann <dietmar.eggemann@arm.com>

Implements cpufreq_scale_freq_capacity() to provide the scheduler with a
frequency scaling correction factor for more accurate load-tracking.

The factor is:

	current_freq(cpu) << SCHED_CAPACITY_SHIFT / max_freq(cpu)

In fact, freq_scale should be a struct cpufreq_policy data member. But
this would require that the scheduler hot path (__update_load_avg()) would
have to grab the cpufreq lock. This can be avoided by using per-cpu data
initialized to SCHED_CAPACITY_SCALE for freq_scale.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Michael Turquette <mturquette+renesas@baylibre.com>
---
I'm not as sure about patches 7 & 8, but I included them since I needed
frequency invariance while testing.

As mentioned by myself in 2014 and Rafael last month, the
arch_scale_freq_capacity hook is awkward, because this behavior may vary
within an architecture.

I re-introduce Dietmar's generic cpufreq implementation of the frequency
invariance hook in this patch,  and change the preprocessor magic in
sched.h to favor the cpufreq implementation over arch- or
platform-specific ones in the next patch.

If run-time selection of ops is needed them someone will need to write
that code.

I think that this negates the need for the arm arch hooks[0-2], and
hopefully Morten and Dietmar can weigh in on this.

[0] lkml.kernel.org/r/1436293469-25707-2-git-send-email-morten.rasmussen@arm.com
[1] lkml.kernel.org/r/1436293469-25707-6-git-send-email-morten.rasmussen@arm.com
[2] lkml.kernel.org/r/1436293469-25707-8-git-send-email-morten.rasmussen@arm.com

 drivers/cpufreq/cpufreq.c | 29 +++++++++++++++++++++++++++++
 include/linux/cpufreq.h   |  3 +++
 2 files changed, 32 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index b1ca9c4..e67584f 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -306,6 +306,31 @@ static void adjust_jiffies(unsigned long val, struct cpufreq_freqs *ci)
 #endif
 }
 
+/*********************************************************************
+ *               FREQUENCY INVARIANT CPU CAPACITY                    *
+ *********************************************************************/
+
+static DEFINE_PER_CPU(unsigned long, freq_scale) = SCHED_CAPACITY_SCALE;
+
+static void
+scale_freq_capacity(struct cpufreq_policy *policy, struct cpufreq_freqs *freqs)
+{
+	unsigned long cur = freqs ? freqs->new : policy->cur;
+	unsigned long scale = (cur << SCHED_CAPACITY_SHIFT) / policy->max;
+	int cpu;
+
+	pr_debug("cpus %*pbl cur/cur max freq %lu/%u kHz freq scale %lu\n",
+		 cpumask_pr_args(policy->cpus), cur, policy->max, scale);
+
+	for_each_cpu(cpu, policy->cpus)
+		per_cpu(freq_scale, cpu) = scale;
+}
+
+unsigned long cpufreq_scale_freq_capacity(struct sched_domain *sd, int cpu)
+{
+	return per_cpu(freq_scale, cpu);
+}
+
 static void __cpufreq_notify_transition(struct cpufreq_policy *policy,
 		struct cpufreq_freqs *freqs, unsigned int state)
 {
@@ -409,6 +434,8 @@ wait:
 
 	spin_unlock(&policy->transition_lock);
 
+	scale_freq_capacity(policy, freqs);
+
 	cpufreq_notify_transition(policy, freqs, CPUFREQ_PRECHANGE);
 }
 EXPORT_SYMBOL_GPL(cpufreq_freq_transition_begin);
@@ -2125,6 +2152,8 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 	blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
 			CPUFREQ_NOTIFY, new_policy);
 
+	scale_freq_capacity(new_policy, NULL);
+
 	policy->min = new_policy->min;
 	policy->max = new_policy->max;
 
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 0e39499..72833be 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -583,4 +583,7 @@ unsigned int cpufreq_generic_get(unsigned int cpu);
 int cpufreq_generic_init(struct cpufreq_policy *policy,
 		struct cpufreq_frequency_table *table,
 		unsigned int transition_latency);
+
+struct sched_domain;
+unsigned long cpufreq_scale_freq_capacity(struct sched_domain *sd, int cpu);
 #endif /* _LINUX_CPUFREQ_H */
-- 
2.1.4
