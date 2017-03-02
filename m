From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: [PATCH 1/6] cpufreq: schedutil: reset sg_cpus's flags at IDLE enter
Date: Thu,  2 Mar 2017 15:45:02 +0000
Message-ID: <1488469507-32463-2-git-send-email-patrick.bellasi@arm.com>
References: <1488469507-32463-1-git-send-email-patrick.bellasi@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1488469507-32463-1-git-send-email-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Patrick Bellasi <patrick.bellasi@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, Vincent Guittot <vincent.guittot@linaro.org>, John Stultz <john.stultz@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Todd Kjos <tkjos@android.com>, Tim Murray <timmurray@google.com>, Andres Oportus <andresoportus@google.com>, Joel Fernandes <joelaf@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Chris Redpath <chris.redpath@arm.com>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-pm@vger.kernel.org

Currently, sg_cpu's flags are set to the value defined by the last call of
the cpufreq_update_util()/cpufreq_update_this_cpu(); for RT/DL classes
this corresponds to the SCHED_CPUFREQ_{RT/DL} flags always being set.

When multiple CPU shares the same frequency domain it might happen that a
CPU which executed an RT task, right before entering IDLE, has one of the
SCHED_CPUFREQ_RT_DL flags set, permanently, until it exits IDLE.

Thus, in sugov_next_freq_shared(), where utilisation and flags are
aggregated across all the CPUs of a frequency domain, it turns out that all
the CPUs of that domain will always run at the maximum OPP until another
event happens in the idle CPU to eventually clear the SCHED_CPUFREQ_{RT/DL}
flag.

Such a behaviour can harm the energy efficiency of systems when RT
workloads are not so frequent and other CPUs in the same frequency
domain are running small utilisation workloads, which is a quite common
scenario in mobile embedded systems.

This patch proposes a solution which is aligned with the current principle
to update the flags each time a scheduling event happens. The scheduling
of the idle_task on a CPU is considered one of such meaningful events.
That's why when the idle_task is selected for execution we poke the
schedutil policy to reset the flags for that CPU.

Moreover, no frequency transitions are activated at that point, which is
fair in case the RT workload should come back in the future, but it allows
other CPUs in the same frequency domain to scale down the frequency in
case that should be needed.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
---
 include/linux/sched.h            | 1 +
 kernel/sched/cpufreq_schedutil.c | 7 +++++++
 kernel/sched/idle_task.c         | 4 ++++
 3 files changed, 12 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index e2ed46d..739b29d 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -3653,6 +3653,7 @@ static inline unsigned long rlimit_max(unsigned int limit)
 #define SCHED_CPUFREQ_RT	(1U << 0)
 #define SCHED_CPUFREQ_DL	(1U << 1)
 #define SCHED_CPUFREQ_IOWAIT	(1U << 2)
+#define SCHED_CPUFREQ_IDLE	(1U << 3)
 
 #define SCHED_CPUFREQ_RT_DL	(SCHED_CPUFREQ_RT | SCHED_CPUFREQ_DL)
 
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index fd46593..084a98b 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -281,6 +281,12 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
 
 	raw_spin_lock(&sg_policy->update_lock);
 
+	/* CPU is entering IDLE, reset flags without triggering an update */
+	if (flags & SCHED_CPUFREQ_IDLE) {
+		sg_cpu->flags = 0;
+		goto done;
+	}
+
 	sg_cpu->util = util;
 	sg_cpu->max = max;
 	sg_cpu->flags = flags;
@@ -293,6 +299,7 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
 		sugov_update_commit(sg_policy, time, next_f);
 	}
 
+done:
 	raw_spin_unlock(&sg_policy->update_lock);
 }
 
diff --git a/kernel/sched/idle_task.c b/kernel/sched/idle_task.c
index 0c00172..a844c91 100644
--- a/kernel/sched/idle_task.c
+++ b/kernel/sched/idle_task.c
@@ -29,6 +29,10 @@ pick_next_task_idle(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
 	put_prev_task(rq, prev);
 	update_idle_core(rq);
 	schedstat_inc(rq->sched_goidle);
+
+	/* kick cpufreq (see the comment in kernel/sched/sched.h). */
+	cpufreq_update_this_cpu(rq, SCHED_CPUFREQ_IDLE);
+
 	return rq->idle;
 }
 
-- 
2.7.4
