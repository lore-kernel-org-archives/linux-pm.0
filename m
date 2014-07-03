From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [RFCv2 PATCH 18/23] sched: Energy model functions
Date: Thu,  3 Jul 2014 17:26:05 +0100
Message-ID: <1404404770-323-19-git-send-email-morten.rasmussen@arm.com>
References: <1404404770-323-1-git-send-email-morten.rasmussen@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1404404770-323-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, peterz@infradead.org, mingo@kernel.org
Cc: rjw@rjwysocki.net, vincent.guittot@linaro.org, daniel.lezcano@linaro.org, preeti@linux.vnet.ibm.com, Dietmar.Eggemann@arm.com, pjt@google.com
List-Id: linux-pm@vger.kernel.org

Introduces energy_diff_util() which finds the energy impacts of adding
or removing utilization from a specific cpu. The calculation is based on
the energy information provided by the platform through sched_energy
data in the sched_domain hierarchy.

Task and cpu utilization is based on unweighted load tracking
(uw_load_avg_contrib) and unweighted cpu_load(cpu, 1) that is introduced
earlier in the patch set. While it isn't a perfect utilization metric,
it is better than weighted load. There are several other loose ends that
need to be addressed, such as load/utilization invariance and proper
representation of compute capacity. However, the energy model and
unweighted load metrics are there.

The energy cost model only considers utilization (busy time) and idle
energy (remaining time) for now. The basic idea is to determine the
energy cost at each level in the sched_domain hierarchy.

=09for_each_domain(cpu, sd) {
=09=09sg =3D sched_group_of(cpu)
=09=09energy_before =3D curr_util(sg) * busy_power(sg)
=09=09=09=09+ (1-curr_util(sg)) * idle_power(sg)
=09=09energy_after =3D new_util(sg) * busy_power(sg)
=09=09=09=09+ (1-new_util(sg)) * idle_power(sg)
=09=09energy_diff +=3D energy_before - energy_after
=09}

Wake-ups energy is added later in this series.

Assumptions and the basic algorithm are described in the code comments.

Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
---
 kernel/sched/fair.c |  251 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 251 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 353e2d0..44ba754 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4249,6 +4249,32 @@ static long effective_load(struct task_group *tg, in=
t cpu, long wl, long wg)
=20
 #endif
=20
+/*
+ * Energy model for energy-aware scheduling
+ *
+ * Assumptions:
+ *
+ * 1. Task and cpu load/utilization are assumed to be scale invariant. Tha=
t is,
+ * task utilization is invariant to frequency scaling and cpu microarchite=
cture
+ * differences. For example, a task utilization of 256 means a cpu with a
+ * capacity of 1024 will be 25% busy running the task, while another cpu w=
ith a
+ * capacity of 512 will be 50% busy.
+ *
+ * 2. When capacity states are shared (SD_SHARE_CAP_STATES) the capacity s=
tate
+ * tables are equivalent. That is, the same table index can be used across=
 all
+ * tables.
+ *
+ * 3. Only the lowest level in sched_domain hierarchy has SD_SHARE_CAP_STA=
TES
+ * set. This restriction will be removed later.
+ *
+ * 4. No independent higher level capacity states. Cluster/package power s=
tates
+ * are either shared with cpus (SD_SHARE_CAP_STATES) or they only have one=
.
+ * This restriction will be removed later.
+ *
+ * 5. The scheduler doesn't control capacity (frequency) scaling, but assu=
mes
+ * that the controller will adjust the capacity to match the utilization.
+ */
+
 static inline bool energy_aware(void)
 {
 =09return sched_feat(ENERGY_AWARE);
@@ -4267,6 +4293,231 @@ static inline int likely_idle_state_idx(struct sche=
d_group *sg)
 =09return 0;
 }
=20
+/*
+ * Find suitable capacity state for utilization.
+ * If over-utilized, return nr_cap_states.
+ */
+static int energy_match_cap(unsigned long util,
+=09=09struct sched_group_energy *sge)
+{
+=09int idx;
+
+=09for (idx =3D 0; idx < sge->nr_cap_states; idx++) {
+=09=09if (sge->cap_states[idx].cap >=3D util)
+=09=09=09return idx;
+=09}
+
+=09return idx;
+}
+
+/*
+ * Find the max cpu utilization in a group of cpus before and after
+ * adding/removing tasks (util) from a specific cpu (cpu).
+ */
+static void find_max_util(const struct cpumask *mask, int cpu, int util,
+=09=09unsigned long *max_util_bef, unsigned long *max_util_aft)
+{
+=09int i;
+
+=09*max_util_bef =3D 0;
+=09*max_util_aft =3D 0;
+
+=09for_each_cpu(i, mask) {
+=09=09unsigned long cpu_util =3D cpu_load(i, 1);
+
+=09=09*max_util_bef =3D max(*max_util_bef, cpu_util);
+
+=09=09if (i =3D=3D cpu)
+=09=09=09cpu_util +=3D util;
+
+=09=09*max_util_aft =3D max(*max_util_aft, cpu_util);
+=09}
+}
+
+static inline unsigned long get_curr_capacity(int cpu);
+
+/*
+ * Estimate the energy cost delta caused by adding/removing utilization (u=
til)
+ * from a specific cpu (cpu).
+ *
+ * The basic idea is to determine the energy cost at each level in sched_d=
omain
+ * hierarchy based on utilization:
+ *
+ * for_each_domain(cpu, sd) {
+ *=09sg =3D sched_group_of(cpu)
+ *=09energy_before =3D curr_util(sg) * busy_power(sg)
+ *=09=09=09=09+ (1-curr_util(sg)) * idle_power(sg)
+ *=09energy_after =3D new_util(sg) * busy_power(sg)
+ *=09=09=09=09+ (1-new_util(sg)) * idle_power(sg)
+ *=09energy_diff +=3D energy_before - energy_after
+ * }
+ *
+ */
+static int energy_diff_util(int cpu, int util)
+{
+=09struct sched_domain *sd;
+=09int i;
+=09int nrg_diff =3D 0;
+=09int curr_cap_idx =3D -1;
+=09int new_cap_idx =3D -1;
+=09unsigned long max_util_bef, max_util_aft, aff_util_bef, aff_util_aft;
+=09unsigned long unused_util_bef, unused_util_aft;
+=09unsigned long cpu_curr_capacity;
+
+=09cpu_curr_capacity =3D get_curr_capacity(cpu);
+
+=09max_util_aft =3D cpu_load(cpu, 1) + util;
+
+=09/* Can't remove more utilization than there is */
+=09if (max_util_aft < 0) {
+=09=09max_util_aft =3D 0;
+=09=09util =3D -cpu_load(cpu, 1);
+=09}
+
+=09rcu_read_lock();
+=09for_each_domain(cpu, sd) {
+=09=09struct capacity_state *curr_state, *new_state, *cap_table;
+=09=09struct idle_state *is;
+=09=09struct sched_group_energy *sge;
+
+=09=09if (!sd->groups->sge)
+=09=09=09continue;
+
+=09=09sge =3D sd->groups->sge;
+=09=09cap_table =3D sge->cap_states;
+
+=09=09if (curr_cap_idx < 0 || !(sd->flags & SD_SHARE_CAP_STATES)) {
+
+=09=09=09/* TODO: Fix assumption 2 and 3. */
+=09=09=09curr_cap_idx =3D energy_match_cap(cpu_curr_capacity, sge);
+
+=09=09=09/*
+=09=09=09 * If we remove tasks, i.e. util < 0, we should find
+=09=09=09 * out if the cap state changes as well, but that is
+=09=09=09 * complicated and might not be worth it. It is assumed
+=09=09=09 * that the state won't be lowered for now.
+=09=09=09 *
+=09=09=09 * Also, if the cap state is shared new_cap_state can't
+=09=09=09 * be lower than curr_cap_idx as the utilization on an
+=09=09=09 * other cpu might have higher utilization than this
+=09=09=09 * cpu.
+=09=09=09 */
+
+=09=09=09if (cap_table[curr_cap_idx].cap < max_util_aft) {
+=09=09=09=09new_cap_idx =3D energy_match_cap(max_util_aft,
+=09=09=09=09=09=09sge);
+=09=09=09=09if (new_cap_idx >=3D sge->nr_cap_states) {
+=09=09=09=09=09/*
+=09=09=09=09=09 * Can't handle the additional
+=09=09=09=09=09 * utilization
+=09=09=09=09=09 */
+=09=09=09=09=09nrg_diff =3D INT_MAX;
+=09=09=09=09=09goto unlock;
+=09=09=09=09}
+=09=09=09} else {
+=09=09=09=09new_cap_idx =3D curr_cap_idx;
+=09=09=09}
+=09=09}
+
+=09=09curr_state =3D &cap_table[curr_cap_idx];
+=09=09new_state =3D &cap_table[new_cap_idx];
+=09=09find_max_util(sched_group_cpus(sd->groups), cpu, util,
+=09=09=09=09&max_util_bef, &max_util_aft);
+=09=09is =3D &sge->idle_states[likely_idle_state_idx(sd->groups)];
+
+=09=09if (!sd->child) {
+=09=09=09/* Lowest level - groups are individual cpus */
+=09=09=09if (sd->flags & SD_SHARE_CAP_STATES) {
+=09=09=09=09int sum_util =3D 0;
+=09=09=09=09for_each_cpu(i, sched_domain_span(sd))
+=09=09=09=09=09sum_util +=3D cpu_load(i, 1);
+=09=09=09=09aff_util_bef =3D sum_util;
+=09=09=09} else {
+=09=09=09=09aff_util_bef =3D cpu_load(cpu, 1);
+=09=09=09}
+=09=09=09aff_util_aft =3D aff_util_bef + util;
+
+=09=09=09/* Estimate idle time based on unused utilization */
+=09=09=09unused_util_bef =3D curr_state->cap
+=09=09=09=09=09=09- cpu_load(cpu, 1);
+=09=09=09unused_util_aft =3D new_state->cap - cpu_load(cpu, 1)
+=09=09=09=09=09=09- util;
+=09=09} else {
+=09=09=09/* Higher level */
+=09=09=09aff_util_bef =3D max_util_bef;
+=09=09=09aff_util_aft =3D max_util_aft;
+
+=09=09=09/* Estimate idle time based on unused utilization */
+=09=09=09unused_util_bef =3D curr_state->cap
+=09=09=09=09=09- min(aff_util_bef, curr_state->cap);
+=09=09=09unused_util_aft =3D new_state->cap
+=09=09=09=09=09- min(aff_util_aft, new_state->cap);
+=09=09}
+
+=09=09/*
+=09=09 * The utilization change has no impact at this level (or any
+=09=09 * parent level).
+=09=09 */
+=09=09if (aff_util_bef =3D=3D aff_util_aft && curr_cap_idx =3D=3D new_cap_=
idx)
+=09=09=09goto unlock;
+
+=09=09/* Energy before */
+=09=09nrg_diff -=3D (aff_util_bef * curr_state->power)/curr_state->cap;
+=09=09nrg_diff -=3D (unused_util_bef * is->power)/curr_state->cap;
+
+=09=09/* Energy after */
+=09=09nrg_diff +=3D (aff_util_aft*new_state->power)/new_state->cap;
+=09=09nrg_diff +=3D (unused_util_aft * is->power)/new_state->cap;
+=09}
+
+=09/*
+=09 * We don't have any sched_group covering all cpus in the sched_domain
+=09 * hierarchy to associate system wide energy with. Treat it specially
+=09 * for now until it can be folded into the loop above.
+=09 */
+=09if (sse) {
+=09=09struct capacity_state *cap_table =3D sse->cap_states;
+=09=09struct capacity_state *curr_state, *new_state;
+=09=09struct idle_state *is;
+
+=09=09curr_state =3D &cap_table[curr_cap_idx];
+=09=09new_state =3D &cap_table[new_cap_idx];
+
+=09=09find_max_util(cpu_online_mask, cpu, util, &aff_util_bef,
+=09=09=09=09&aff_util_aft);
+=09=09is =3D &sse->idle_states[likely_idle_state_idx(NULL)];
+
+=09=09/* Estimate idle time based on unused utilization */
+=09=09unused_util_bef =3D curr_state->cap - aff_util_bef;
+=09=09unused_util_aft =3D new_state->cap - aff_util_aft;
+
+=09=09/* Energy before */
+=09=09nrg_diff -=3D (aff_util_bef*curr_state->power)/curr_state->cap;
+=09=09nrg_diff -=3D (unused_util_bef * is->power)/curr_state->cap;
+
+=09=09/* Energy after */
+=09=09nrg_diff +=3D (aff_util_aft*new_state->power)/new_state->cap;
+=09=09nrg_diff +=3D (unused_util_aft * is->power)/new_state->cap;
+=09}
+
+unlock:
+=09rcu_read_unlock();
+
+=09return nrg_diff;
+}
+
+static int energy_diff_task(int cpu, struct task_struct *p)
+{
+=09if (!energy_aware())
+=09=09return INT_MAX;
+
+=09if (!cpumask_test_cpu(cpu, tsk_cpus_allowed(p)))
+=09=09return INT_MAX;
+
+=09return energy_diff_util(cpu, p->se.avg.uw_load_avg_contrib);
+
+}
+
 static int wake_wide(struct task_struct *p)
 {
 =09int factor =3D this_cpu_read(sd_llc_size);
--=20
1.7.9.5
