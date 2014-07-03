From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [RFCv2 PATCH 23/23] sched: Use energy model in load balance path
Date: Thu,  3 Jul 2014 17:26:10 +0100
Message-ID: <1404404770-323-24-git-send-email-morten.rasmussen@arm.com>
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

Attempt to pick the source cpu which potentially gives the maximum energy
savings in case the minimum of the amount of utilization which the
destination cpu is additionally able to handle and the current
utilization on the source cpu is taken away from it and put on the
destination cpu instead.
Finding the optimum source requires an exhaustive search through all cpus
in the groups. Instead, the source group is determined based on
utilization and probing the energy cost on a single cpu in each group.

This implementation is not providing an actual energy aware load
balancing right now. It is only trying to showcase the way to find the
most suitable source queue (cpu) based on the energy aware data. The
actual load balance is still done based on the calculated load based
imbalance.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/fair.c |   88 +++++++++++++++++++++++++++++++++++++++++++++++=
+---
 1 file changed, 83 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2acd45a..1ce3a89 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4549,6 +4549,42 @@ static int energy_diff_task(int cpu, struct task_str=
uct *p)
 =09=09=09p->se.avg.wakeup_avg_sum);
 }
=20
+static int energy_diff_cpu(int dst_cpu, int src_cpu)
+{
+=09int util_diff, dst_nrg_diff, src_nrg_diff;
+=09unsigned long src_curr_cap, src_util;
+=09unsigned long dst_curr_cap =3D get_curr_capacity(dst_cpu);
+=09unsigned long dst_util =3D cpu_load(dst_cpu, 1);
+
+=09/*
+=09 * If the destination cpu is already fully or even over-utilized
+=09 * return error.
+=09 */
+=09if (dst_curr_cap <=3D dst_util)
+=09=09return INT_MAX;
+
+=09src_curr_cap =3D get_curr_capacity(src_cpu);
+=09src_util =3D cpu_load(src_cpu, 1);
+
+=09/*
+=09 * If the source cpu is over-utilized return the minimum value
+=09 * to indicate maximum potential energy savings. Performance
+=09 * is still given priority over pure energy efficiency here.
+=09 */
+=09if (src_curr_cap < src_util)
+=09=09return INT_MIN;
+
+=09util_diff =3D min(dst_curr_cap - dst_util, src_util);
+
+=09dst_nrg_diff =3D energy_diff_util(dst_cpu, util_diff, 0);
+=09src_nrg_diff =3D energy_diff_util(src_cpu, -util_diff, 0);
+
+=09if (dst_nrg_diff =3D=3D INT_MAX || src_nrg_diff =3D=3D INT_MAX)
+=09=09return INT_MAX;
+
+=09return dst_nrg_diff + src_nrg_diff;
+}
+
 static int wake_wide(struct task_struct *p)
 {
 =09int factor =3D this_cpu_read(sd_llc_size);
@@ -5488,6 +5524,9 @@ struct lb_env {
 =09unsigned int=09=09loop_max;
=20
 =09enum fbq_type=09=09fbq_type;
+
+=09unsigned int use_ea;=09/* Use energy aware lb */
+
 };
=20
 /*
@@ -5957,6 +5996,7 @@ struct sg_lb_stats {
 =09unsigned int nr_numa_running;
 =09unsigned int nr_preferred_running;
 #endif
+=09int nrg_diff; /* Maximum energy difference btwn dst_cpu and probe_cpu *=
/
 };
=20
 /*
@@ -5969,9 +6009,11 @@ struct sd_lb_stats {
 =09unsigned long total_load;=09/* Total load of all groups in sd */
 =09unsigned long total_capacity;=09/* Total capacity of all groups in sd *=
/
 =09unsigned long avg_load;=09/* Average load across all groups in sd */
+=09unsigned int use_ea;=09=09/* Use energy aware lb */
=20
 =09struct sg_lb_stats busiest_stat;/* Statistics of the busiest group */
 =09struct sg_lb_stats local_stat;=09/* Statistics of the local group */
+
 };
=20
 static inline void init_sd_lb_stats(struct sd_lb_stats *sds)
@@ -5987,8 +6029,10 @@ static inline void init_sd_lb_stats(struct sd_lb_sta=
ts *sds)
 =09=09.local =3D NULL,
 =09=09.total_load =3D 0UL,
 =09=09.total_capacity =3D 0UL,
+=09=09.use_ea =3D 0,
 =09=09.busiest_stat =3D {
 =09=09=09.avg_load =3D 0UL,
+=09=09=09.nrg_diff =3D INT_MAX,
 =09=09},
 =09};
 }
@@ -6282,20 +6326,32 @@ static inline void update_sg_lb_stats(struct lb_env=
 *env,
 =09=09=09struct sched_group *group, int load_idx,
 =09=09=09int local_group, struct sg_lb_stats *sgs)
 {
-=09unsigned long load;
-=09int i;
+=09unsigned long load, probe_util =3D 0;
+=09int i, probe_cpu =3D cpumask_first(sched_group_cpus(group));
=20
 =09memset(sgs, 0, sizeof(*sgs));
=20
+=09sgs->nrg_diff =3D INT_MAX;
+
 =09for_each_cpu_and(i, sched_group_cpus(group), env->cpus) {
 =09=09struct rq *rq =3D cpu_rq(i);
=20
 =09=09/* Bias balancing toward cpus of our domain */
 =09=09if (local_group)
 =09=09=09load =3D target_load(i, load_idx, 0);
-=09=09else
+=09=09else {
 =09=09=09load =3D source_load(i, load_idx, 0);
=20
+=09=09=09if (energy_aware()) {
+=09=09=09=09unsigned long util =3D source_load(i, load_idx, 1);
+
+=09=09=09=09if (probe_util < util) {
+=09=09=09=09=09probe_util =3D util;
+=09=09=09=09=09probe_cpu =3D i;
+=09=09=09=09}
+=09=09=09}
+=09=09}
+
 =09=09sgs->group_load +=3D load;
 =09=09sgs->sum_nr_running +=3D rq->nr_running;
 #ifdef CONFIG_NUMA_BALANCING
@@ -6321,6 +6377,9 @@ static inline void update_sg_lb_stats(struct lb_env *=
env,
=20
 =09if (sgs->group_capacity_factor > sgs->sum_nr_running)
 =09=09sgs->group_has_free_capacity =3D 1;
+
+=09if (energy_aware() && !local_group)
+=09=09sgs->nrg_diff =3D energy_diff_cpu(env->dst_cpu, probe_cpu);
 }
=20
 /**
@@ -6341,6 +6400,14 @@ static bool update_sd_pick_busiest(struct lb_env *en=
v,
 =09=09=09=09   struct sched_group *sg,
 =09=09=09=09   struct sg_lb_stats *sgs)
 {
+=09if (energy_aware()) {
+=09=09if (sgs->nrg_diff < sds->busiest_stat.nrg_diff) {
+=09=09=09sds->use_ea =3D 1;
+=09=09=09return true;
+=09=09}
+=09=09sds->use_ea =3D 0;
+=09}
+
 =09if (sgs->avg_load <=3D sds->busiest_stat.avg_load)
 =09=09return false;
=20
@@ -6450,6 +6517,8 @@ static inline void update_sd_lb_stats(struct lb_env *=
env, struct sd_lb_stats *sd
 =09=09if (update_sd_pick_busiest(env, sds, sg, sgs)) {
 =09=09=09sds->busiest =3D sg;
 =09=09=09sds->busiest_stat =3D *sgs;
+=09=09=09if (energy_aware())
+=09=09=09=09env->use_ea =3D sds->use_ea;
 =09=09}
=20
 next_group:
@@ -6761,7 +6830,7 @@ static struct rq *find_busiest_queue(struct lb_env *e=
nv,
 {
 =09struct rq *busiest =3D NULL, *rq;
 =09unsigned long busiest_load =3D 0, busiest_capacity =3D 1;
-=09int i;
+=09int i, min_nrg =3D INT_MAX;
=20
 =09for_each_cpu_and(i, sched_group_cpus(group), env->cpus) {
 =09=09unsigned long capacity, capacity_factor, load;
@@ -6807,6 +6876,14 @@ static struct rq *find_busiest_queue(struct lb_env *=
env,
 =09=09=09=09load > env->imbalance)
 =09=09=09continue;
=20
+=09=09if (energy_aware() && env->use_ea) {
+=09=09=09int nrg =3D energy_diff_cpu(env->dst_cpu, i);
+
+=09=09=09if (nrg < min_nrg) {
+=09=09=09=09min_nrg =3D nrg;
+=09=09=09=09busiest =3D rq;
+=09=09=09}
+=09=09}
 =09=09/*
 =09=09 * For the load comparisons with the other cpu's, consider
 =09=09 * the cpu_load() scaled with the cpu capacity, so
@@ -6818,7 +6895,7 @@ static struct rq *find_busiest_queue(struct lb_env *e=
nv,
 =09=09 * to: load_i * capacity_j > load_j * capacity_i;  where j is
 =09=09 * our previous maximum.
 =09=09 */
-=09=09if (load * busiest_capacity > busiest_load * capacity) {
+=09=09else if (load * busiest_capacity > busiest_load * capacity) {
 =09=09=09busiest_load =3D load;
 =09=09=09busiest_capacity =3D capacity;
 =09=09=09busiest =3D rq;
@@ -6915,6 +6992,7 @@ static int load_balance(int this_cpu, struct rq *this=
_rq,
 =09=09.loop_break=09=3D sched_nr_migrate_break,
 =09=09.cpus=09=09=3D cpus,
 =09=09.fbq_type=09=3D all,
+=09=09.use_ea=09=09=3D 0,
 =09};
=20
 =09/*
--=20
1.7.9.5
