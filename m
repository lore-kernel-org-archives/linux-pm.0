From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [RFCv2 PATCH 10/23] sched: Account for blocked unweighted load waking back up
Date: Thu,  3 Jul 2014 17:25:57 +0100
Message-ID: <1404404770-323-11-git-send-email-morten.rasmussen@arm.com>
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

Migrate unweighted blocked load of an entity away from the run queue
in case it is migrated to another cpu during wake-up.

This patch is the unweighted counterpart of "sched: Account for blocked
load waking back up" (commit id aff3e4988444).

Note: The unweighted blocked load is not used for energy aware
scheduling yet.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/fair.c  |    9 +++++++--
 kernel/sched/sched.h |    2 +-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c6207f7..93c8dbe 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2545,9 +2545,11 @@ static void update_cfs_rq_blocked_load(struct cfs_rq=
 *cfs_rq, int force_update)
 =09=09return;
=20
 =09if (atomic_long_read(&cfs_rq->removed_load)) {
-=09=09unsigned long removed_load;
+=09=09unsigned long removed_load, uw_removed_load;
 =09=09removed_load =3D atomic_long_xchg(&cfs_rq->removed_load, 0);
-=09=09subtract_blocked_load_contrib(cfs_rq, removed_load, 0);
+=09=09uw_removed_load =3D atomic_long_xchg(&cfs_rq->uw_removed_load, 0);
+=09=09subtract_blocked_load_contrib(cfs_rq, removed_load,
+=09=09=09=09=09      uw_removed_load);
 =09}
=20
 =09if (decays) {
@@ -4606,6 +4608,8 @@ migrate_task_rq_fair(struct task_struct *p, int next_=
cpu)
 =09=09se->avg.decay_count =3D -__synchronize_entity_decay(se);
 =09=09atomic_long_add(se->avg.load_avg_contrib,
 =09=09=09=09=09=09&cfs_rq->removed_load);
+=09=09atomic_long_add(se->avg.uw_load_avg_contrib,
+=09=09=09=09=09=09&cfs_rq->uw_removed_load);
 =09}
=20
 =09/* We have migrated, no longer consider this task hot */
@@ -7553,6 +7557,7 @@ void init_cfs_rq(struct cfs_rq *cfs_rq)
 #ifdef CONFIG_SMP
 =09atomic64_set(&cfs_rq->decay_counter, 1);
 =09atomic_long_set(&cfs_rq->removed_load, 0);
+=09atomic_long_set(&cfs_rq->uw_removed_load, 0);
 #endif
 }
=20
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 3f1eeb3..d7d2ee2 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -340,7 +340,7 @@ struct cfs_rq {
 =09unsigned long uw_runnable_load_avg, uw_blocked_load_avg;
 =09atomic64_t decay_counter;
 =09u64 last_decay;
-=09atomic_long_t removed_load;
+=09atomic_long_t removed_load, uw_removed_load;
=20
 #ifdef CONFIG_FAIR_GROUP_SCHED
 =09/* Required to track per-cpu representation of a task_group */
--=20
1.7.9.5
