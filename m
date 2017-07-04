From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: [PATCH v2 2/6] cpufreq: schedutil: reset sg_cpus's flags at IDLE enter
Date: Tue,  4 Jul 2017 18:34:07 +0100
Message-ID: <1499189651-18797-3-git-send-email-patrick.bellasi@arm.com>
References: <1499189651-18797-1-git-send-email-patrick.bellasi@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1499189651-18797-1-git-send-email-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Joel Fernandes <joelaf@google.com>, Andres Oportus <andresoportus@google.com>, Todd Kjos <tkjos@android.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>
List-Id: linux-pm@vger.kernel.org

Currently, sg_cpu's flags are set to the value defined by the last call of
the cpufreq_update_util()/cpufreq_update_this_cpu(); for RT/DL classes
this corresponds to the SCHED_CPUFREQ_{RT/DL} flags always being set.

When multiple CPU shares the same frequency domain it might happen that a
CPU which executed a RT task, right before entering IDLE, has one of the
SCHED_CPUFREQ_RT_DL flags set, permanently, until it exits IDLE.

Although such an idle CPU is _going to be_ ignored by the
sugov_next_freq_shared():
  1. this kind of "useless RT requests" are ignored only if more then
     TICK_NSEC have elapsed since the last update
  2. we can still potentially trigger an already too late switch to
     MAX, which starts also a new throttling interval
  3. the internal state machine is not consistent with what the
     scheduler knows, i.e. the CPU is now actually idle

Thus, in sugov_next_freq_shared(), where utilisation and flags are
aggregated across all the CPUs of a frequency domain, it can turn out
that all the CPUs of that domain can run unnecessary at the maximum OPP
until another event happens in the idle CPU, which eventually clear the
SCHED_CPUFREQ_{RT/DL} flag, or the IDLE CPUs gets ignored after
TICK_NSEC since the CPU entering IDLE.

Such a behaviour can harm the energy efficiency of systems where RT
workloads are not so frequent and other CPUs in the same frequency
domain are running small utilisation workloads, which is a quite common
scenario in mobile embedded systems.

This patch proposes a solution which is aligned with the current principle
to update the flags each time a scheduling event happens. The scheduling
of the idle_task on a CPU is considered one of such meaningful events.
That's why when the idle_task is selected for execution we poke the
schedutil policy to reset the flags for that CPU.

No frequency transitions are activated at that point, which is fair in
case the RT workload should come back in the future. However, this still
allows other CPUs in the same frequency domain to scale down the
frequency in case that should be possible.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org

---
Changes from v1:
- added "unlikely()" around the statement (SteveR)
---
 include/linux/sched/cpufreq.h    | 1 +
 kernel/sched/cpufreq_schedutil.c | 7 +++++++
 kernel/sched/idle_task.c         | 4 ++++
 3 files changed, 12 insertions(+)

diff --git a/include/linux/sched/cpufreq.h b/include/linux/sched/cpufreq.h
index d2be2cc..36ac8d2 100644
--- a/include/linux/sched/cpufreq.h
+++ b/include/linux/sched/cpufreq.h
@@ -10,6 +10,7 @@
 #define SCHED_CPUFREQ_RT	(1U << 0)
 #define SCHED_CPUFREQ_DL	(1U << 1)
 #define SCHED_CPUFREQ_IOWAIT	(1U << 2)
+#define SCHED_CPUFREQ_IDLE	(1U << 3)
 
 #define SCHED_CPUFREQ_RT_DL	(SCHED_CPUFREQ_RT | SCHED_CPUFREQ_DL)
 
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index eaba6d6..004ae18 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -304,6 +304,12 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
 
 	sg_cpu->util = util;
 	sg_cpu->max = max;
+
+	/* CPU is entering IDLE, reset flags without triggering an update */
+	if (unlikely(flags & SCHED_CPUFREQ_IDLE)) {
+		sg_cpu->flags = 0;
+		goto done;
+	}
 	sg_cpu->flags = flags;
 
 	sugov_set_iowait_boost(sg_cpu, time, flags);
@@ -318,6 +324,7 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
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
