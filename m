From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [RFCv2 PATCH 12/23] sched: Rename weighted_cpuload() to cpu_load()
Date: Thu,  3 Jul 2014 17:25:59 +0100
Message-ID: <1404404770-323-13-git-send-email-morten.rasmussen@arm.com>
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

The function weighted_cpuload() is the only one in the group of load
related functions used in the scheduler load balancing code
(weighted_cpuload(), source_load(), target_load(), task_h_load()) which
carries an explicit 'weighted' identifier in its name. Get rid of this
'weighted' identifier since following patches will introduce a
weighted/unweighted switch as an argument for these functions.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/fair.c |   33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 93c8dbe..784fdab 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1014,7 +1014,7 @@ bool should_numa_migrate_memory(struct task_struct *p=
, struct page * page,
 =09return group_faults(p, dst_nid) < (group_faults(p, src_nid) * 3 / 4);
 }
=20
-static unsigned long weighted_cpuload(const int cpu);
+static unsigned long cpu_load(const int cpu);
 static unsigned long source_load(int cpu, int type);
 static unsigned long target_load(int cpu, int type);
 static unsigned long capacity_of(int cpu);
@@ -1045,7 +1045,7 @@ static void update_numa_stats(struct numa_stats *ns, =
int nid)
 =09=09struct rq *rq =3D cpu_rq(cpu);
=20
 =09=09ns->nr_running +=3D rq->nr_running;
-=09=09ns->load +=3D weighted_cpuload(cpu);
+=09=09ns->load +=3D cpu_load(cpu);
 =09=09ns->compute_capacity +=3D capacity_of(cpu);
=20
 =09=09cpus++;
@@ -4036,7 +4036,7 @@ static void dequeue_task_fair(struct rq *rq, struct t=
ask_struct *p, int flags)
=20
 #ifdef CONFIG_SMP
 /* Used instead of source_load when we know the type =3D=3D 0 */
-static unsigned long weighted_cpuload(const int cpu)
+static unsigned long cpu_load(const int cpu)
 {
 =09return cpu_rq(cpu)->cfs.runnable_load_avg;
 }
@@ -4051,7 +4051,7 @@ static unsigned long weighted_cpuload(const int cpu)
 static unsigned long source_load(int cpu, int type)
 {
 =09struct rq *rq =3D cpu_rq(cpu);
-=09unsigned long total =3D weighted_cpuload(cpu);
+=09unsigned long total =3D cpu_load(cpu);
=20
 =09if (type =3D=3D 0 || !sched_feat(LB_BIAS))
 =09=09return total;
@@ -4066,7 +4066,7 @@ static unsigned long source_load(int cpu, int type)
 static unsigned long target_load(int cpu, int type)
 {
 =09struct rq *rq =3D cpu_rq(cpu);
-=09unsigned long total =3D weighted_cpuload(cpu);
+=09unsigned long total =3D cpu_load(cpu);
=20
 =09if (type =3D=3D 0 || !sched_feat(LB_BIAS))
 =09=09return total;
@@ -4433,7 +4433,7 @@ find_idlest_cpu(struct sched_group *group, struct tas=
k_struct *p, int this_cpu)
=20
 =09/* Traverse only the allowed CPUs */
 =09for_each_cpu_and(i, sched_group_cpus(group), tsk_cpus_allowed(p)) {
-=09=09load =3D weighted_cpuload(i);
+=09=09load =3D cpu_load(i);
=20
 =09=09if (load < min_load || (load =3D=3D min_load && i =3D=3D this_cpu)) =
{
 =09=09=09min_load =3D load;
@@ -5926,7 +5926,7 @@ static inline void update_sg_lb_stats(struct lb_env *=
env,
 =09=09sgs->nr_numa_running +=3D rq->nr_numa_running;
 =09=09sgs->nr_preferred_running +=3D rq->nr_preferred_running;
 #endif
-=09=09sgs->sum_weighted_load +=3D weighted_cpuload(i);
+=09=09sgs->sum_weighted_load +=3D cpu_load(i);
 =09=09if (idle_cpu(i))
 =09=09=09sgs->idle_cpus++;
 =09}
@@ -6388,7 +6388,7 @@ static struct rq *find_busiest_queue(struct lb_env *e=
nv,
 =09int i;
=20
 =09for_each_cpu_and(i, sched_group_cpus(group), env->cpus) {
-=09=09unsigned long capacity, capacity_factor, wl;
+=09=09unsigned long capacity, capacity_factor, load;
 =09=09enum fbq_type rt;
=20
 =09=09rq =3D cpu_rq(i);
@@ -6421,28 +6421,29 @@ static struct rq *find_busiest_queue(struct lb_env =
*env,
 =09=09if (!capacity_factor)
 =09=09=09capacity_factor =3D fix_small_capacity(env->sd, group);
=20
-=09=09wl =3D weighted_cpuload(i);
+=09=09load =3D cpu_load(i);
=20
 =09=09/*
-=09=09 * When comparing with imbalance, use weighted_cpuload()
+=09=09 * When comparing with imbalance, use cpu_load()
 =09=09 * which is not scaled with the cpu capacity.
 =09=09 */
-=09=09if (capacity_factor && rq->nr_running =3D=3D 1 && wl > env->imbalanc=
e)
+=09=09if (capacity_factor && rq->nr_running =3D=3D 1 &&
+=09=09=09=09load > env->imbalance)
 =09=09=09continue;
=20
 =09=09/*
 =09=09 * For the load comparisons with the other cpu's, consider
-=09=09 * the weighted_cpuload() scaled with the cpu capacity, so
+=09=09 * the cpu_load() scaled with the cpu capacity, so
 =09=09 * that the load can be moved away from the cpu that is
 =09=09 * potentially running at a lower capacity.
 =09=09 *
-=09=09 * Thus we're looking for max(wl_i / capacity_i), crosswise
+=09=09 * Thus we're looking for max(load_i / capacity_i), crosswise
 =09=09 * multiplication to rid ourselves of the division works out
-=09=09 * to: wl_i * capacity_j > wl_j * capacity_i;  where j is
+=09=09 * to: load_i * capacity_j > load_j * capacity_i;  where j is
 =09=09 * our previous maximum.
 =09=09 */
-=09=09if (wl * busiest_capacity > busiest_load * capacity) {
-=09=09=09busiest_load =3D wl;
+=09=09if (load * busiest_capacity > busiest_load * capacity) {
+=09=09=09busiest_load =3D load;
 =09=09=09busiest_capacity =3D capacity;
 =09=09=09busiest =3D rq;
 =09=09}
--=20
1.7.9.5
