From: Saravana Kannan <skannan@codeaurora.org>
Subject: [PATCH] cpufreq: schedutil: Update cached "current frequency" when limits change
Date: Tue, 11 Jul 2017 19:24:12 -0700
Message-ID: <1499826256-23491-1-git-send-email-skannan@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Currently, the governor calculates the next frequency, set the current CPU
frequency (policy->cur). It also assumes the current CPU frequency doesn't
change if the next frequency isn't calculated again and hence caches the
"current frequency".

However, this isn't true when CPU min/max frequency limits are changed. So,
there's room for the CPU frequency to get stuck at the wrong level if the
calculated next frequency doesn't change across multiple limits updates.

Fix this by updating the cached "current frequency" when limits changes the
current CPU frequency.

Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
---
 kernel/sched/cpufreq_schedutil.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 076a2e3..fe0b2fb 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -226,6 +226,7 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
 
 	busy = sugov_cpu_is_busy(sg_cpu);
 
+	raw_spin_lock(&sg_policy->update_lock);
 	if (flags & SCHED_CPUFREQ_RT_DL) {
 		next_f = policy->cpuinfo.max_freq;
 	} else {
@@ -240,6 +241,7 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
 			next_f = sg_policy->next_freq;
 	}
 	sugov_update_commit(sg_policy, time, next_f);
+	raw_spin_unlock(&sg_policy->update_lock);
 }
 
 static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
@@ -637,10 +639,14 @@ static void sugov_stop(struct cpufreq_policy *policy)
 static void sugov_limits(struct cpufreq_policy *policy)
 {
 	struct sugov_policy *sg_policy = policy->governor_data;
+	unsigned long flags;
 
 	if (!policy->fast_switch_enabled) {
 		mutex_lock(&sg_policy->work_lock);
 		cpufreq_policy_apply_limits(policy);
+		raw_spin_lock_irqsave(&sg_policy->update_lock, flags);
+		sg_policy->next_freq = policy->cur;
+		raw_spin_unlock_irqrestore(&sg_policy->update_lock, flags);
 		mutex_unlock(&sg_policy->work_lock);
 	}
 
-- 
~/caf-sig.txt
