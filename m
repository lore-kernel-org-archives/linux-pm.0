From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: [RFCv4 6/6] cpufreq: schedutil: add util clamp for RT/DL tasks
Date: Thu, 24 Aug 2017 19:08:57 +0100
Message-ID: <20170824180857.32103-7-patrick.bellasi@arm.com>
References: <20170824180857.32103-1-patrick.bellasi@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170824180857.32103-1-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Paul Turner <pjt@google.com>, Vincent Guittot <vincent.guittot@linaro.org>, John Stultz <john.stultz@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <juri.lelli@arm.com>, Tim Murray <timmurray@google.com>, Todd Kjos <tkjos@android.com>, Andres Oportus <andresoportus@google.com>, Joel Fernandes <joelaf@google.com>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Currently schedutil enforces a maximum frequency when RT/DL tasks are
RUNNABLE.  Such a mandatory policy can be made more tunable from
userspace thus allowing for example to define a max frequency which is
still reasonable for the execution of a specific RT/DL workload. This
will contribute to make the RT class more friendly for power/energy
sensitive use-cases.

This patch extends the usage of util_{min,max} to the RT/DL classes.
Whenever a task in these classes is RUNNABLE, the util required is
defined by the constraints of the CPU control group the task belongs to.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
---
 kernel/sched/cpufreq_schedutil.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index f67c26bbade4..feca60c107bc 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -227,7 +227,10 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
 	busy = sugov_cpu_is_busy(sg_cpu);
 
 	if (flags & SCHED_CPUFREQ_RT_DL) {
-		next_f = policy->cpuinfo.max_freq;
+		util = uclamp_util(smp_processor_id(), SCHED_CAPACITY_SCALE);
+		next_f = (uclamp_enabled && util < SCHED_CAPACITY_SCALE)
+			? get_next_freq(sg_policy, util, policy->cpuinfo.max_freq)
+			: policy->cpuinfo.max_freq;
 	} else {
 		sugov_get_util(&util, &max);
 		sugov_iowait_boost(sg_cpu, &util, &max);
@@ -276,10 +279,15 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
 			j_sg_cpu->iowait_boost = 0;
 			continue;
 		}
-		if (j_sg_cpu->flags & SCHED_CPUFREQ_RT_DL)
-			return policy->cpuinfo.max_freq;
 
-		j_util = j_sg_cpu->util;
+		if (j_sg_cpu->flags & SCHED_CPUFREQ_RT_DL) {
+			if (!uclamp_enabled)
+				return policy->cpuinfo.max_freq;
+			j_util = uclamp_util(j, SCHED_CAPACITY_SCALE);
+		} else {
+			j_util = j_sg_cpu->util;
+		}
+
 		j_max = j_sg_cpu->max;
 		if (j_util * max > j_max * util) {
 			util = j_util;
-- 
2.14.1
