From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [RFCv2 PATCH 09/23] sched: Maintain the unweighted load contribution of blocked entities
Date: Thu,  3 Jul 2014 17:25:56 +0100
Message-ID: <1404404770-323-10-git-send-email-morten.rasmussen@arm.com>
References: <1404404770-323-1-git-send-email-morten.rasmussen@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:52433 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759536AbaGCQ2M (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Jul 2014 12:28:12 -0400
In-Reply-To: <1404404770-323-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, peterz@infradead.org, mingo@kernel.org
Cc: rjw@rjwysocki.net, vincent.guittot@linaro.org, daniel.lezcano@linaro.org, preeti@linux.vnet.ibm.com, Dietmar.Eggemann@arm.com, pjt@google.com

From: Dietmar Eggemann <dietmar.eggemann@arm.com>

The unweighted blocked load on a run queue is maintained alongside the
existing (weighted) blocked load.

This patch is the unweighted counterpart of "sched: Maintain the load
contribution of blocked entities" (commit id 9ee474f55664).

Note: The unweighted blocked load is not used for energy aware
scheduling yet.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/debug.c |    2 ++
 kernel/sched/fair.c  |   22 +++++++++++++++++-----
 kernel/sched/sched.h |    2 +-
 3 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 78d4151..ffa56a8 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -220,6 +220,8 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct c=
fs_rq *cfs_rq)
 =09=09=09cfs_rq->uw_runnable_load_avg);
 =09SEQ_printf(m, "  .%-30s: %ld\n", "blocked_load_avg",
 =09=09=09cfs_rq->blocked_load_avg);
+=09SEQ_printf(m, "  .%-30s: %ld\n", "uw_blocked_load_avg",
+=09=09=09cfs_rq->uw_blocked_load_avg);
 #ifdef CONFIG_FAIR_GROUP_SCHED
 =09SEQ_printf(m, "  .%-30s: %ld\n", "tg_load_contrib",
 =09=09=09cfs_rq->tg_load_contrib);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1ee47b3..c6207f7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2481,12 +2481,18 @@ static long __update_entity_load_avg_contrib(struct=
 sched_entity *se,
 }
=20
 static inline void subtract_blocked_load_contrib(struct cfs_rq *cfs_rq,
-=09=09=09=09=09=09 long load_contrib)
+=09=09=09=09=09=09 long load_contrib,
+=09=09=09=09=09=09 long uw_load_contrib)
 {
 =09if (likely(load_contrib < cfs_rq->blocked_load_avg))
 =09=09cfs_rq->blocked_load_avg -=3D load_contrib;
 =09else
 =09=09cfs_rq->blocked_load_avg =3D 0;
+
+=09if (likely(uw_load_contrib < cfs_rq->uw_blocked_load_avg))
+=09=09cfs_rq->uw_blocked_load_avg -=3D uw_load_contrib;
+=09else
+=09=09cfs_rq->uw_blocked_load_avg =3D 0;
 }
=20
 static inline u64 cfs_rq_clock_task(struct cfs_rq *cfs_rq);
@@ -2521,7 +2527,8 @@ static inline void update_entity_load_avg(struct sche=
d_entity *se,
 =09=09cfs_rq->uw_runnable_load_avg +=3D uw_contrib_delta;
 =09}
 =09else
-=09=09subtract_blocked_load_contrib(cfs_rq, -contrib_delta);
+=09=09subtract_blocked_load_contrib(cfs_rq, -contrib_delta,
+=09=09=09=09=09      -uw_contrib_delta);
 }
=20
 /*
@@ -2540,12 +2547,14 @@ static void update_cfs_rq_blocked_load(struct cfs_r=
q *cfs_rq, int force_update)
 =09if (atomic_long_read(&cfs_rq->removed_load)) {
 =09=09unsigned long removed_load;
 =09=09removed_load =3D atomic_long_xchg(&cfs_rq->removed_load, 0);
-=09=09subtract_blocked_load_contrib(cfs_rq, removed_load);
+=09=09subtract_blocked_load_contrib(cfs_rq, removed_load, 0);
 =09}
=20
 =09if (decays) {
 =09=09cfs_rq->blocked_load_avg =3D decay_load(cfs_rq->blocked_load_avg,
 =09=09=09=09=09=09      decays);
+=09=09cfs_rq->uw_blocked_load_avg =3D
+=09=09=09=09decay_load(cfs_rq->uw_blocked_load_avg, decays);
 =09=09atomic64_add(decays, &cfs_rq->decay_counter);
 =09=09cfs_rq->last_decay =3D now;
 =09}
@@ -2591,7 +2600,8 @@ static inline void enqueue_entity_load_avg(struct cfs=
_rq *cfs_rq,
=20
 =09/* migrated tasks did not contribute to our blocked load */
 =09if (wakeup) {
-=09=09subtract_blocked_load_contrib(cfs_rq, se->avg.load_avg_contrib);
+=09=09subtract_blocked_load_contrib(cfs_rq, se->avg.load_avg_contrib,
+=09=09=09=09=09      se->avg.uw_load_avg_contrib);
 =09=09update_entity_load_avg(se, 0);
 =09}
=20
@@ -2620,6 +2630,7 @@ static inline void dequeue_entity_load_avg(struct cfs=
_rq *cfs_rq,
=20
 =09if (sleep) {
 =09=09cfs_rq->blocked_load_avg +=3D se->avg.load_avg_contrib;
+=09=09cfs_rq->uw_blocked_load_avg +=3D se->avg.uw_load_avg_contrib;
 =09=09se->avg.decay_count =3D atomic64_read(&cfs_rq->decay_counter);
 =09} /* migrations, e.g. sleep=3D0 leave decay_count =3D=3D 0 */
 }
@@ -7481,7 +7492,8 @@ static void switched_from_fair(struct rq *rq, struct =
task_struct *p)
 =09*/
 =09if (se->avg.decay_count) {
 =09=09__synchronize_entity_decay(se);
-=09=09subtract_blocked_load_contrib(cfs_rq, se->avg.load_avg_contrib);
+=09=09subtract_blocked_load_contrib(cfs_rq, se->avg.load_avg_contrib,
+=09=09=09=09=09      se->avg.uw_load_avg_contrib);
 =09}
 #endif
 }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 46cb8bd..3f1eeb3 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -337,7 +337,7 @@ struct cfs_rq {
 =09 * the FAIR_GROUP_SCHED case).
 =09 */
 =09unsigned long runnable_load_avg, blocked_load_avg;
-=09unsigned long uw_runnable_load_avg;
+=09unsigned long uw_runnable_load_avg, uw_blocked_load_avg;
 =09atomic64_t decay_counter;
 =09u64 last_decay;
 =09atomic_long_t removed_load;
--=20
1.7.9.5


