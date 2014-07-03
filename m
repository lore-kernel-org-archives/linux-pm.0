From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [RFCv2 PATCH 13/23] sched: Introduce weighted/unweighted switch in load related functions
Date: Thu,  3 Jul 2014 17:26:00 +0100
Message-ID: <1404404770-323-14-git-send-email-morten.rasmussen@arm.com>
References: <1404404770-323-1-git-send-email-morten.rasmussen@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:45532 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759285AbaGCQ0S (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Jul 2014 12:26:18 -0400
In-Reply-To: <1404404770-323-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, peterz@infradead.org, mingo@kernel.org
Cc: rjw@rjwysocki.net, vincent.guittot@linaro.org, daniel.lezcano@linaro.org, preeti@linux.vnet.ibm.com, Dietmar.Eggemann@arm.com, pjt@google.com

From: Dietmar Eggemann <dietmar.eggemann@arm.com>

Add weighted/unweighted switch as an additional argument to cpu_load(),
source_load(), target_load() and task_h_load() to enable the user to
either ask for weighted or unweighted load signal. Use 0 (weighted) for
all existing occurrences of these functions.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/fair.c |   65 +++++++++++++++++++++++++++--------------------=
----
 1 file changed, 35 insertions(+), 30 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 784fdab..37e9ea1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -665,7 +665,7 @@ static u64 sched_vslice(struct cfs_rq *cfs_rq, struct s=
ched_entity *se)
 }
=20
 #ifdef CONFIG_SMP
-static unsigned long task_h_load(struct task_struct *p);
+static unsigned long task_h_load(struct task_struct *p, int uw);
=20
 static inline void __update_task_entity_contrib(struct sched_entity *se);
=20
@@ -1014,9 +1014,9 @@ bool should_numa_migrate_memory(struct task_struct *p=
, struct page * page,
 =09return group_faults(p, dst_nid) < (group_faults(p, src_nid) * 3 / 4);
 }
=20
-static unsigned long cpu_load(const int cpu);
-static unsigned long source_load(int cpu, int type);
-static unsigned long target_load(int cpu, int type);
+static unsigned long cpu_load(const int cpu, int uw);
+static unsigned long source_load(int cpu, int type, int uw);
+static unsigned long target_load(int cpu, int type, int uw);
 static unsigned long capacity_of(int cpu);
 static long effective_load(struct task_group *tg, int cpu, long wl, long w=
g);
=20
@@ -1045,7 +1045,7 @@ static void update_numa_stats(struct numa_stats *ns, =
int nid)
 =09=09struct rq *rq =3D cpu_rq(cpu);
=20
 =09=09ns->nr_running +=3D rq->nr_running;
-=09=09ns->load +=3D cpu_load(cpu);
+=09=09ns->load +=3D cpu_load(cpu, 0);
 =09=09ns->compute_capacity +=3D capacity_of(cpu);
=20
 =09=09cpus++;
@@ -1215,12 +1215,12 @@ balance:
 =09orig_src_load =3D env->src_stats.load;
=20
 =09/* XXX missing capacity terms */
-=09load =3D task_h_load(env->p);
+=09load =3D task_h_load(env->p, 0);
 =09dst_load =3D orig_dst_load + load;
 =09src_load =3D orig_src_load - load;
=20
 =09if (cur) {
-=09=09load =3D task_h_load(cur);
+=09=09load =3D task_h_load(cur, 0);
 =09=09dst_load -=3D load;
 =09=09src_load +=3D load;
 =09}
@@ -4036,9 +4036,10 @@ static void dequeue_task_fair(struct rq *rq, struct =
task_struct *p, int flags)
=20
 #ifdef CONFIG_SMP
 /* Used instead of source_load when we know the type =3D=3D 0 */
-static unsigned long cpu_load(const int cpu)
+static unsigned long cpu_load(const int cpu, int uw)
 {
-=09return cpu_rq(cpu)->cfs.runnable_load_avg;
+=09return uw ? cpu_rq(cpu)->cfs.uw_runnable_load_avg :
+=09=09=09cpu_rq(cpu)->cfs.runnable_load_avg;
 }
=20
 /*
@@ -4048,30 +4049,32 @@ static unsigned long cpu_load(const int cpu)
  * We want to under-estimate the load of migration sources, to
  * balance conservatively.
  */
-static unsigned long source_load(int cpu, int type)
+static unsigned long source_load(int cpu, int type, int uw)
 {
 =09struct rq *rq =3D cpu_rq(cpu);
-=09unsigned long total =3D cpu_load(cpu);
+=09unsigned long total =3D cpu_load(cpu, uw);
=20
 =09if (type =3D=3D 0 || !sched_feat(LB_BIAS))
 =09=09return total;
=20
-=09return min(rq->cpu_load[type-1], total);
+=09return uw ? min(rq->uw_cpu_load[type-1], total) :
+=09=09=09min(rq->cpu_load[type-1], total);
 }
=20
 /*
  * Return a high guess at the load of a migration-target cpu weighted
  * according to the scheduling class and "nice" value.
  */
-static unsigned long target_load(int cpu, int type)
+static unsigned long target_load(int cpu, int type, int uw)
 {
 =09struct rq *rq =3D cpu_rq(cpu);
-=09unsigned long total =3D cpu_load(cpu);
+=09unsigned long total =3D cpu_load(cpu, uw);
=20
 =09if (type =3D=3D 0 || !sched_feat(LB_BIAS))
 =09=09return total;
=20
-=09return max(rq->cpu_load[type-1], total);
+=09return uw ? max(rq->uw_cpu_load[type-1], total) :
+=09=09=09max(rq->cpu_load[type-1], total);
 }
=20
 static unsigned long capacity_of(int cpu)
@@ -4292,8 +4295,8 @@ static int wake_affine(struct sched_domain *sd, struc=
t task_struct *p, int sync)
 =09idx=09  =3D sd->wake_idx;
 =09this_cpu  =3D smp_processor_id();
 =09prev_cpu  =3D task_cpu(p);
-=09load=09  =3D source_load(prev_cpu, idx);
-=09this_load =3D target_load(this_cpu, idx);
+=09load=09  =3D source_load(prev_cpu, idx, 0);
+=09this_load =3D target_load(this_cpu, idx, 0);
=20
 =09/*
 =09 * If sync wakeup then subtract the (maximum possible)
@@ -4349,7 +4352,7 @@ static int wake_affine(struct sched_domain *sd, struc=
t task_struct *p, int sync)
=20
 =09if (balanced ||
 =09    (this_load <=3D load &&
-=09     this_load + target_load(prev_cpu, idx) <=3D tl_per_task)) {
+=09     this_load + target_load(prev_cpu, idx, 0) <=3D tl_per_task)) {
 =09=09/*
 =09=09 * This domain has SD_WAKE_AFFINE and
 =09=09 * p is cache cold in this domain, and
@@ -4398,9 +4401,9 @@ find_idlest_group(struct sched_domain *sd, struct tas=
k_struct *p,
 =09=09for_each_cpu(i, sched_group_cpus(group)) {
 =09=09=09/* Bias balancing toward cpus of our domain */
 =09=09=09if (local_group)
-=09=09=09=09load =3D source_load(i, load_idx);
+=09=09=09=09load =3D source_load(i, load_idx, 0);
 =09=09=09else
-=09=09=09=09load =3D target_load(i, load_idx);
+=09=09=09=09load =3D target_load(i, load_idx, 0);
=20
 =09=09=09avg_load +=3D load;
 =09=09}
@@ -4433,7 +4436,7 @@ find_idlest_cpu(struct sched_group *group, struct tas=
k_struct *p, int this_cpu)
=20
 =09/* Traverse only the allowed CPUs */
 =09for_each_cpu_and(i, sched_group_cpus(group), tsk_cpus_allowed(p)) {
-=09=09load =3D cpu_load(i);
+=09=09load =3D cpu_load(i, 0);
=20
 =09=09if (load < min_load || (load =3D=3D min_load && i =3D=3D this_cpu)) =
{
 =09=09=09min_load =3D load;
@@ -5402,7 +5405,7 @@ static int move_tasks(struct lb_env *env)
 =09=09if (!can_migrate_task(p, env))
 =09=09=09goto next;
=20
-=09=09load =3D task_h_load(p);
+=09=09load =3D task_h_load(p, 0);
=20
 =09=09if (sched_feat(LB_MIN) && load < 16 && !env->sd->nr_balance_failed)
 =09=09=09goto next;
@@ -5542,12 +5545,14 @@ static void update_cfs_rq_h_load(struct cfs_rq *cfs=
_rq)
 =09}
 }
=20
-static unsigned long task_h_load(struct task_struct *p)
+static unsigned long task_h_load(struct task_struct *p, int uw)
 {
 =09struct cfs_rq *cfs_rq =3D task_cfs_rq(p);
+=09unsigned long task_load =3D uw ? p->se.avg.uw_load_avg_contrib
+=09=09=09=09     : p->se.avg.load_avg_contrib;
=20
 =09update_cfs_rq_h_load(cfs_rq);
-=09return div64_ul(p->se.avg.load_avg_contrib * cfs_rq->h_load,
+=09return div64_ul(task_load * cfs_rq->h_load,
 =09=09=09cfs_rq->runnable_load_avg + 1);
 }
 #else
@@ -5555,9 +5560,9 @@ static inline void update_blocked_averages(int cpu)
 {
 }
=20
-static unsigned long task_h_load(struct task_struct *p)
+static unsigned long task_h_load(struct task_struct *p, int uw)
 {
-=09return p->se.avg.load_avg_contrib;
+=09return uw ? p->se.avg.uw_load_avg_contrib : p->se.avg.load_avg_contrib;
 }
 #endif
=20
@@ -5916,9 +5921,9 @@ static inline void update_sg_lb_stats(struct lb_env *=
env,
=20
 =09=09/* Bias balancing toward cpus of our domain */
 =09=09if (local_group)
-=09=09=09load =3D target_load(i, load_idx);
+=09=09=09load =3D target_load(i, load_idx, 0);
 =09=09else
-=09=09=09load =3D source_load(i, load_idx);
+=09=09=09load =3D source_load(i, load_idx, 0);
=20
 =09=09sgs->group_load +=3D load;
 =09=09sgs->sum_nr_running +=3D rq->nr_running;
@@ -5926,7 +5931,7 @@ static inline void update_sg_lb_stats(struct lb_env *=
env,
 =09=09sgs->nr_numa_running +=3D rq->nr_numa_running;
 =09=09sgs->nr_preferred_running +=3D rq->nr_preferred_running;
 #endif
-=09=09sgs->sum_weighted_load +=3D cpu_load(i);
+=09=09sgs->sum_weighted_load +=3D cpu_load(i, 0);
 =09=09if (idle_cpu(i))
 =09=09=09sgs->idle_cpus++;
 =09}
@@ -6421,7 +6426,7 @@ static struct rq *find_busiest_queue(struct lb_env *e=
nv,
 =09=09if (!capacity_factor)
 =09=09=09capacity_factor =3D fix_small_capacity(env->sd, group);
=20
-=09=09load =3D cpu_load(i);
+=09=09load =3D cpu_load(i, 0);
=20
 =09=09/*
 =09=09 * When comparing with imbalance, use cpu_load()
--=20
1.7.9.5


