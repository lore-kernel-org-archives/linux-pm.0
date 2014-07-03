From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [RFCv2 PATCH 08/23] sched: Aggregate unweighted load contributed by task entities on parenting cfs_rq
Date: Thu,  3 Jul 2014 17:25:55 +0100
Message-ID: <1404404770-323-9-git-send-email-morten.rasmussen@arm.com>
References: <1404404770-323-1-git-send-email-morten.rasmussen@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1404404770-323-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, peterz@infradead.org, mingo@kernel.org
Cc: rjw@rjwysocki.net, vincent.guittot@linaro.org, daniel.lezcano@linaro.org, preeti@linux.vnet.ibm.com, Dietmar.Eggemann@arm.com, pjt@google.com
List-Id: linux-pm@vger.kernel.org

From: Dietmar Eggemann <dietmar.eggemann@arm.com>

Energy aware scheduling relies on cpu utilization and to be able to
maintain it, we need a per run queue signal of the sum of the
unweighted, i.e. not scaled with task priority, load contribution of
runnable task entries.

The unweighted runnable load on a run queue is maintained alongside the
existing (weighted) runnable load.

This patch is the unweighted counterpart of "sched: Aggregate load
contributed by task entities on parenting cfs_rq" (commit id
2dac754e10a5).

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 include/linux/sched.h |    1 +
 kernel/sched/debug.c  |    4 ++++
 kernel/sched/fair.c   |   26 ++++++++++++++++++++++----
 kernel/sched/sched.h  |    1 +
 4 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 1507390..b5eeae0 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1105,6 +1105,7 @@ struct sched_avg {
 =09u64 last_runnable_update;
 =09s64 decay_count;
 =09unsigned long load_avg_contrib;
+=09unsigned long uw_load_avg_contrib;
 };
=20
 #ifdef CONFIG_SCHEDSTATS
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 695f977..78d4151 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -96,6 +96,7 @@ static void print_cfs_group_stats(struct seq_file *m, int=
 cpu, struct task_group
 =09P(se->avg.runnable_avg_sum);
 =09P(se->avg.runnable_avg_period);
 =09P(se->avg.load_avg_contrib);
+=09P(se->avg.uw_load_avg_contrib);
 =09P(se->avg.decay_count);
 #endif
 #undef PN
@@ -215,6 +216,8 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct c=
fs_rq *cfs_rq)
 #ifdef CONFIG_SMP
 =09SEQ_printf(m, "  .%-30s: %ld\n", "runnable_load_avg",
 =09=09=09cfs_rq->runnable_load_avg);
+=09SEQ_printf(m, "  .%-30s: %ld\n", "uw_runnable_load_avg",
+=09=09=09cfs_rq->uw_runnable_load_avg);
 =09SEQ_printf(m, "  .%-30s: %ld\n", "blocked_load_avg",
 =09=09=09cfs_rq->blocked_load_avg);
 #ifdef CONFIG_FAIR_GROUP_SCHED
@@ -635,6 +638,7 @@ void proc_sched_show_task(struct task_struct *p, struct=
 seq_file *m)
 =09P(se.avg.runnable_avg_sum);
 =09P(se.avg.runnable_avg_period);
 =09P(se.avg.load_avg_contrib);
+=09P(se.avg.uw_load_avg_contrib);
 =09P(se.avg.decay_count);
 #endif
 =09P(policy);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 981406e..1ee47b3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2345,6 +2345,8 @@ static inline u64 __synchronize_entity_decay(struct s=
ched_entity *se)
 =09=09return 0;
=20
 =09se->avg.load_avg_contrib =3D decay_load(se->avg.load_avg_contrib, decay=
s);
+=09se->avg.uw_load_avg_contrib =3D decay_load(se->avg.uw_load_avg_contrib,
+=09=09=09=09=09=09 decays);
 =09se->avg.decay_count =3D 0;
=20
 =09return decays;
@@ -2451,12 +2453,18 @@ static inline void __update_task_entity_contrib(str=
uct sched_entity *se)
 =09contrib =3D se->avg.runnable_avg_sum * scale_load_down(se->load.weight)=
;
 =09contrib /=3D (se->avg.runnable_avg_period + 1);
 =09se->avg.load_avg_contrib =3D scale_load(contrib);
+
+=09contrib =3D se->avg.runnable_avg_sum * scale_load_down(NICE_0_LOAD);
+=09contrib /=3D (se->avg.runnable_avg_period + 1);
+=09se->avg.uw_load_avg_contrib =3D scale_load(contrib);
 }
=20
 /* Compute the current contribution to load_avg by se, return any delta */
-static long __update_entity_load_avg_contrib(struct sched_entity *se)
+static long __update_entity_load_avg_contrib(struct sched_entity *se,
+=09=09=09=09=09     long *uw_contrib_delta)
 {
 =09long old_contrib =3D se->avg.load_avg_contrib;
+=09long uw_old_contrib =3D se->avg.uw_load_avg_contrib;
=20
 =09if (entity_is_task(se)) {
 =09=09__update_task_entity_contrib(se);
@@ -2465,6 +2473,10 @@ static long __update_entity_load_avg_contrib(struct =
sched_entity *se)
 =09=09__update_group_entity_contrib(se);
 =09}
=20
+=09if (uw_contrib_delta)
+=09=09*uw_contrib_delta =3D se->avg.uw_load_avg_contrib -
+=09=09=09=09=09uw_old_contrib;
+
 =09return se->avg.load_avg_contrib - old_contrib;
 }
=20
@@ -2484,7 +2496,7 @@ static inline void update_entity_load_avg(struct sche=
d_entity *se,
 =09=09=09=09=09  int update_cfs_rq)
 {
 =09struct cfs_rq *cfs_rq =3D cfs_rq_of(se);
-=09long contrib_delta;
+=09long contrib_delta, uw_contrib_delta;
 =09u64 now;
=20
 =09/*
@@ -2499,13 +2511,15 @@ static inline void update_entity_load_avg(struct sc=
hed_entity *se,
 =09if (!__update_entity_runnable_avg(now, &se->avg, se->on_rq))
 =09=09return;
=20
-=09contrib_delta =3D __update_entity_load_avg_contrib(se);
+=09contrib_delta =3D __update_entity_load_avg_contrib(se, &uw_contrib_delt=
a);
=20
 =09if (!update_cfs_rq)
 =09=09return;
=20
-=09if (se->on_rq)
+=09if (se->on_rq) {
 =09=09cfs_rq->runnable_load_avg +=3D contrib_delta;
+=09=09cfs_rq->uw_runnable_load_avg +=3D uw_contrib_delta;
+=09}
 =09else
 =09=09subtract_blocked_load_contrib(cfs_rq, -contrib_delta);
 }
@@ -2582,6 +2596,8 @@ static inline void enqueue_entity_load_avg(struct cfs=
_rq *cfs_rq,
 =09}
=20
 =09cfs_rq->runnable_load_avg +=3D se->avg.load_avg_contrib;
+=09cfs_rq->uw_runnable_load_avg +=3D se->avg.uw_load_avg_contrib;
+
 =09/* we force update consideration on load-balancer moves */
 =09update_cfs_rq_blocked_load(cfs_rq, !wakeup);
 }
@@ -2600,6 +2616,8 @@ static inline void dequeue_entity_load_avg(struct cfs=
_rq *cfs_rq,
 =09update_cfs_rq_blocked_load(cfs_rq, !sleep);
=20
 =09cfs_rq->runnable_load_avg -=3D se->avg.load_avg_contrib;
+=09cfs_rq->uw_runnable_load_avg -=3D se->avg.uw_load_avg_contrib;
+
 =09if (sleep) {
 =09=09cfs_rq->blocked_load_avg +=3D se->avg.load_avg_contrib;
 =09=09se->avg.decay_count =3D atomic64_read(&cfs_rq->decay_counter);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index c971359..46cb8bd 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -337,6 +337,7 @@ struct cfs_rq {
 =09 * the FAIR_GROUP_SCHED case).
 =09 */
 =09unsigned long runnable_load_avg, blocked_load_avg;
+=09unsigned long uw_runnable_load_avg;
 =09atomic64_t decay_counter;
 =09u64 last_decay;
 =09atomic_long_t removed_load;
--=20
1.7.9.5
