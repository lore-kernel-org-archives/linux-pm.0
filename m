From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [RFC PATCH 08/10] sched: Track blocked utilization contributions
Date: Tue,  2 Dec 2014 14:06:30 +0000
Message-ID: <1417529192-11579-9-git-send-email-morten.rasmussen@arm.com>
References: <1417529192-11579-1-git-send-email-morten.rasmussen@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1417529192-11579-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, mingo@redhat.com
Cc: dietmar.eggemann@arm.com, vincent.guittot@linaro.org, pjt@google.com, bsegall@google.com, mturquette@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Morten Rasmussen <morten.rasmussen@arm.com>
List-Id: linux-pm@vger.kernel.org

Introduces the blocked utilization, the utilization counter-part to
cfs_rq->utilization_load_avg. It is the sum of sched_entity utilization
contributions of entities that were recently on the cfs_rq that are
currently blocked. Combined with sum of contributions of entities
currently on the cfs_rq or currently running
(cfs_rq->utilization_load_avg) this can provide a more stable average
view of the cpu usage.

cc: Ingo Molnar <mingo@redhat.com>
cc: Peter Zijlstra <peterz@infradead.org>

Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
---
 kernel/sched/fair.c  | 30 +++++++++++++++++++++++++++++-
 kernel/sched/sched.h |  8 ++++++--
 2 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 090223f..adf64df 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2778,6 +2778,15 @@ static inline void subtract_blocked_load_contrib(str=
uct cfs_rq *cfs_rq,
 =09=09cfs_rq->blocked_load_avg =3D 0;
 }
=20
+static inline void subtract_utilization_blocked_contrib(struct cfs_rq *cfs=
_rq,
+=09=09=09=09=09=09long utilization_contrib)
+{
+=09if (likely(utilization_contrib < cfs_rq->utilization_blocked_avg))
+=09=09cfs_rq->utilization_blocked_avg -=3D utilization_contrib;
+=09else
+=09=09cfs_rq->utilization_blocked_avg =3D 0;
+}
+
 static inline u64 cfs_rq_clock_task(struct cfs_rq *cfs_rq);
=20
 /* Update a sched_entity's runnable average */
@@ -2813,6 +2822,8 @@ static inline void update_entity_load_avg(struct sche=
d_entity *se,
 =09=09cfs_rq->utilization_load_avg +=3D utilization_delta;
 =09} else {
 =09=09subtract_blocked_load_contrib(cfs_rq, -contrib_delta);
+=09=09subtract_utilization_blocked_contrib(cfs_rq,
+=09=09=09=09=09=09=09-utilization_delta);
 =09}
 }
=20
@@ -2830,14 +2841,20 @@ static void update_cfs_rq_blocked_load(struct cfs_r=
q *cfs_rq, int force_update)
 =09=09return;
=20
 =09if (atomic_long_read(&cfs_rq->removed_load)) {
-=09=09unsigned long removed_load;
+=09=09unsigned long removed_load, removed_utilization;
 =09=09removed_load =3D atomic_long_xchg(&cfs_rq->removed_load, 0);
+=09=09removed_utilization =3D
+=09=09=09atomic_long_xchg(&cfs_rq->removed_utilization, 0);
 =09=09subtract_blocked_load_contrib(cfs_rq, removed_load);
+=09=09subtract_utilization_blocked_contrib(cfs_rq,
+=09=09=09=09=09=09=09removed_utilization);
 =09}
=20
 =09if (decays) {
 =09=09cfs_rq->blocked_load_avg =3D decay_load(cfs_rq->blocked_load_avg,
 =09=09=09=09=09=09      decays);
+=09=09cfs_rq->utilization_blocked_avg =3D
+=09=09=09decay_load(cfs_rq->utilization_blocked_avg, decays);
 =09=09atomic64_add(decays, &cfs_rq->decay_counter);
 =09=09cfs_rq->last_decay =3D now;
 =09}
@@ -2884,6 +2901,8 @@ static inline void enqueue_entity_load_avg(struct cfs=
_rq *cfs_rq,
 =09/* migrated tasks did not contribute to our blocked load */
 =09if (wakeup) {
 =09=09subtract_blocked_load_contrib(cfs_rq, se->avg.load_avg_contrib);
+=09=09subtract_utilization_blocked_contrib(cfs_rq,
+=09=09=09=09=09se->avg.utilization_avg_contrib);
 =09=09update_entity_load_avg(se, 0);
 =09}
=20
@@ -2910,6 +2929,8 @@ static inline void dequeue_entity_load_avg(struct cfs=
_rq *cfs_rq,
 =09cfs_rq->utilization_load_avg -=3D se->avg.utilization_avg_contrib;
 =09if (sleep) {
 =09=09cfs_rq->blocked_load_avg +=3D se->avg.load_avg_contrib;
+=09=09cfs_rq->utilization_blocked_avg +=3D
+=09=09=09=09=09=09se->avg.utilization_avg_contrib;
 =09=09se->avg.decay_count =3D atomic64_read(&cfs_rq->decay_counter);
 =09} /* migrations, e.g. sleep=3D0 leave decay_count =3D=3D 0 */
 }
@@ -4929,6 +4950,8 @@ migrate_task_rq_fair(struct task_struct *p, int next_=
cpu)
 =09=09se->avg.decay_count =3D -__synchronize_entity_decay(se);
 =09=09atomic_long_add(se->avg.load_avg_contrib,
 =09=09=09=09=09=09&cfs_rq->removed_load);
+=09=09atomic_long_add(se->avg.utilization_avg_contrib,
+=09=09=09=09=09&cfs_rq->removed_utilization);
 =09}
=20
 =09/* We have migrated, no longer consider this task hot */
@@ -7944,6 +7967,8 @@ static void switched_from_fair(struct rq *rq, struct =
task_struct *p)
 =09if (se->avg.decay_count) {
 =09=09__synchronize_entity_decay(se);
 =09=09subtract_blocked_load_contrib(cfs_rq, se->avg.load_avg_contrib);
+=09=09subtract_utilization_blocked_contrib(cfs_rq,
+=09=09=09=09=09se->avg.utilization_avg_contrib);
 =09}
 #endif
 }
@@ -8003,6 +8028,7 @@ void init_cfs_rq(struct cfs_rq *cfs_rq)
 #ifdef CONFIG_SMP
 =09atomic64_set(&cfs_rq->decay_counter, 1);
 =09atomic_long_set(&cfs_rq->removed_load, 0);
+=09atomic_long_set(&cfs_rq->removed_utilization, 0);
 #endif
 }
=20
@@ -8055,6 +8081,8 @@ static void task_move_group_fair(struct task_struct *=
p, int queued)
 =09=09 */
 =09=09se->avg.decay_count =3D atomic64_read(&cfs_rq->decay_counter);
 =09=09cfs_rq->blocked_load_avg +=3D se->avg.load_avg_contrib;
+=09=09cfs_rq->utilization_blocked_avg +=3D
+=09=09=09=09=09=09se->avg.utilization_avg_contrib;
 #endif
 =09}
 }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e402133..208237f 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -368,11 +368,15 @@ struct cfs_rq {
 =09 * the blocked sched_entities on the rq.
 =09 * utilization_load_avg is the sum of the average running time of the
 =09 * sched_entities on the rq.
+=09 * utilization_blocked_avg is the utilization equivalent of
+=09 * blocked_load_avg, i.e. the sum of running contributions of blocked
+=09 * sched_entities associated with the rq.
 =09 */
-=09unsigned long runnable_load_avg, blocked_load_avg, utilization_load_avg=
;
+=09unsigned long runnable_load_avg, blocked_load_avg;
+=09unsigned long utilization_load_avg, utilization_blocked_avg;
 =09atomic64_t decay_counter;
 =09u64 last_decay;
-=09atomic_long_t removed_load;
+=09atomic_long_t removed_load, removed_utilization;
=20
 #ifdef CONFIG_FAIR_GROUP_SCHED
 =09/* Required to track per-cpu representation of a task_group */
--=20
1.9.1
