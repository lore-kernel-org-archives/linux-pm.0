From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [RFC PATCH 09/16] sched, cpufreq: Introduce current cpu compute capacity into scheduler
Date: Fri, 23 May 2014 19:16:36 +0100
Message-ID: <1400869003-27769-10-git-send-email-morten.rasmussen@arm.com>
References: <1400869003-27769-1-git-send-email-morten.rasmussen@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1400869003-27769-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, peterz@infradead.org, mingo@kernel.org
Cc: rjw@rjwysocki.net, vincent.guittot@linaro.org, daniel.lezcano@linaro.org, preeti@linux.vnet.ibm.com, dietmar.eggemann@arm.com
List-Id: linux-pm@vger.kernel.org

The scheduler is currently unaware of frequency changes and the current
compute capacity offered by the cpus. This patch is not the solution.
It is a hack to give us something to experiment with for now.

A proper solution could be based on the frequency invariant load
tracking proposed in the past: https://lkml.org/lkml/2013/4/16/289

This patch should _not_ be considered safe.

Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
---
 drivers/cpufreq/cpufreq.c |    2 ++
 include/linux/sched.h     |    2 ++
 kernel/sched/fair.c       |    6 ++++++
 kernel/sched/sched.h      |    2 ++
 4 files changed, 12 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index abda660..a2b788d 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -28,6 +28,7 @@
 #include <linux/slab.h>
 #include <linux/suspend.h>
 #include <linux/tick.h>
+#include <linux/sched.h>
 #include <trace/events/power.h>
=20
 /**
@@ -315,6 +316,7 @@ static void __cpufreq_notify_transition(struct cpufreq_=
policy *policy,
 =09=09pr_debug("FREQ: %lu - CPU: %lu\n",
 =09=09=09 (unsigned long)freqs->new, (unsigned long)freqs->cpu);
 =09=09trace_cpu_frequency(freqs->new, freqs->cpu);
+=09=09set_curr_capacity(freqs->cpu, (freqs->new*1024)/policy->max);
 =09=09srcu_notifier_call_chain(&cpufreq_transition_notifier_list,
 =09=09=09=09CPUFREQ_POSTCHANGE, freqs);
 =09=09if (likely(policy) && likely(policy->cpu =3D=3D freqs->cpu))
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 62d61b5..727b936 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -3068,4 +3068,6 @@ static inline unsigned long rlimit_max(unsigned int l=
imit)
 =09return task_rlimit_max(current, limit);
 }
=20
+void set_curr_capacity(int cpu, long capacity);
+
 #endif
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7570dd9..3a2aeee 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7410,9 +7410,15 @@ void init_cfs_rq(struct cfs_rq *cfs_rq)
 #ifdef CONFIG_SMP
 =09atomic64_set(&cfs_rq->decay_counter, 1);
 =09atomic_long_set(&cfs_rq->removed_load, 0);
+=09atomic_long_set(&cfs_rq->curr_capacity, 1024);
 #endif
 }
=20
+void set_curr_capacity(int cpu, long capacity)
+{
+=09atomic_long_set(&cpu_rq(cpu)->cfs.curr_capacity, capacity);
+}
+
 #ifdef CONFIG_FAIR_GROUP_SCHED
 static void task_move_group_fair(struct task_struct *p, int on_rq)
 {
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 9ff67a7..5a117b8 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -341,6 +341,8 @@ struct cfs_rq {
 =09u64 last_decay;
 =09atomic_long_t removed_load;
=20
+=09atomic_long_t curr_capacity;
+
 #ifdef CONFIG_FAIR_GROUP_SCHED
 =09/* Required to track per-cpu representation of a task_group */
 =09u32 tg_runnable_contrib;
--=20
1.7.9.5
