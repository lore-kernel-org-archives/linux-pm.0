From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [RFCv2 PATCH 15/23] sched, cpufreq: Introduce current cpu compute capacity into scheduler
Date: Thu,  3 Jul 2014 17:26:02 +0100
Message-ID: <1404404770-323-16-git-send-email-morten.rasmussen@arm.com>
References: <1404404770-323-1-git-send-email-morten.rasmussen@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:45695 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759340AbaGCQ0U (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Jul 2014 12:26:20 -0400
In-Reply-To: <1404404770-323-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, peterz@infradead.org, mingo@kernel.org
Cc: rjw@rjwysocki.net, vincent.guittot@linaro.org, daniel.lezcano@linaro.org, preeti@linux.vnet.ibm.com, Dietmar.Eggemann@arm.com, pjt@google.com

The scheduler is currently unaware of frequency changes and the current
compute capacity offered by the cpus. This patch is not the solution.
It is a hack to give us something to experiment with for now.

A proper solution could be based on the frequency invariant load
tracking proposed in the past: https://lkml.org/lkml/2013/4/16/289
The best way to get current compute capacity is likely to be
architecture specific. A potential solution is therefore to let the
architecture implement get_curr_capacity() instead.

This patch should _not_ be considered safe.

Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
---
 drivers/cpufreq/cpufreq.c |    2 ++
 include/linux/sched.h     |    2 ++
 kernel/sched/fair.c       |   11 +++++++++++
 kernel/sched/sched.h      |    2 ++
 4 files changed, 17 insertions(+)

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
index e5d8d57..faebd87 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -3025,4 +3025,6 @@ static inline unsigned long rlimit_max(unsigned int l=
imit)
 =09return task_rlimit_max(current, limit);
 }
=20
+void set_curr_capacity(int cpu, long capacity);
+
 #endif
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 37e9ea1..9720f04 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7564,9 +7564,20 @@ void init_cfs_rq(struct cfs_rq *cfs_rq)
 =09atomic64_set(&cfs_rq->decay_counter, 1);
 =09atomic_long_set(&cfs_rq->removed_load, 0);
 =09atomic_long_set(&cfs_rq->uw_removed_load, 0);
+=09atomic_long_set(&cfs_rq->curr_capacity, 1024);
 #endif
 }
=20
+void set_curr_capacity(int cpu, long capacity)
+{
+=09atomic_long_set(&cpu_rq(cpu)->cfs.curr_capacity, capacity);
+}
+
+static inline unsigned long get_curr_capacity(int cpu)
+{
+=09return atomic_long_read(&cpu_rq(cpu)->cfs.curr_capacity);
+}
+
 #ifdef CONFIG_FAIR_GROUP_SCHED
 static void task_move_group_fair(struct task_struct *p, int on_rq)
 {
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 455d152..a6d5239 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -342,6 +342,8 @@ struct cfs_rq {
 =09u64 last_decay;
 =09atomic_long_t removed_load, uw_removed_load;
=20
+=09atomic_long_t curr_capacity;
+
 #ifdef CONFIG_FAIR_GROUP_SCHED
 =09/* Required to track per-cpu representation of a task_group */
 =09u32 tg_runnable_contrib;
--=20
1.7.9.5


