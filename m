From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [RFC PATCH 15/16] sched: Use energy to guide wakeup task placement
Date: Fri, 23 May 2014 19:16:42 +0100
Message-ID: <1400869003-27769-16-git-send-email-morten.rasmussen@arm.com>
References: <1400869003-27769-1-git-send-email-morten.rasmussen@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1400869003-27769-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, peterz@infradead.org, mingo@kernel.org
Cc: rjw@rjwysocki.net, vincent.guittot@linaro.org, daniel.lezcano@linaro.org, preeti@linux.vnet.ibm.com, dietmar.eggemann@arm.com
List-Id: linux-pm@vger.kernel.org

Attempt to pick most energy efficient wakeup in find_idlest_{group,
cpu}(). Finding the optimum target requires an exhaustive search
through all cpus in the groups. Instead, the target group is determined
based on load and probing the energy cost on a single cpu in each group.
The target cpu is the cpu with the lowest energy cost.

Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
---
 kernel/sched/fair.c |   64 +++++++++++++++++++++++++++++++++++++++++------=
----
 1 file changed, 52 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 542c2b2..0d3334b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4556,25 +4556,27 @@ static int wake_affine(struct sched_domain *sd, str=
uct task_struct *p, int sync)
 }
=20
 /*
- * find_idlest_group finds and returns the least busy CPU group within the
- * domain.
+ * find_target_group finds and returns the least busy/most energy-efficien=
t
+ * CPU group within the domain.
  */
 static struct sched_group *
-find_idlest_group(struct sched_domain *sd, struct task_struct *p,
+find_target_group(struct sched_domain *sd, struct task_struct *p,
 =09=09  int this_cpu, int sd_flag)
 {
-=09struct sched_group *idlest =3D NULL, *group =3D sd->groups;
+=09struct sched_group *idlest =3D NULL, *group =3D sd->groups, *energy =3D=
 NULL;
 =09unsigned long min_load =3D ULONG_MAX, this_load =3D 0;
 =09int load_idx =3D sd->forkexec_idx;
 =09int imbalance =3D 100 + (sd->imbalance_pct-100)/2;
+=09int local_energy =3D 0, min_energy =3D INT_MAX;
=20
 =09if (sd_flag & SD_BALANCE_WAKE)
 =09=09load_idx =3D sd->wake_idx;
=20
 =09do {
-=09=09unsigned long load, avg_load;
+=09=09unsigned long load, avg_load, probe_load =3D UINT_MAX;
 =09=09int local_group;
 =09=09int i;
+=09=09int probe_cpu, energy_diff;
=20
 =09=09/* Skip over this group if it has no CPUs allowed */
 =09=09if (!cpumask_intersects(sched_group_cpus(group),
@@ -4586,6 +4588,7 @@ find_idlest_group(struct sched_domain *sd, struct tas=
k_struct *p,
=20
 =09=09/* Tally up the load of all CPUs in the group */
 =09=09avg_load =3D 0;
+=09=09probe_cpu =3D cpumask_first(sched_group_cpus(group));
=20
 =09=09for_each_cpu(i, sched_group_cpus(group)) {
 =09=09=09/* Bias balancing toward cpus of our domain */
@@ -4595,44 +4598,81 @@ find_idlest_group(struct sched_domain *sd, struct t=
ask_struct *p,
 =09=09=09=09load =3D target_load(i, load_idx);
=20
 =09=09=09avg_load +=3D load;
+
+=09=09=09if (load < probe_load) {
+=09=09=09=09probe_load =3D load;
+=09=09=09=09probe_cpu =3D i;
+=09=09=09}
 =09=09}
=20
 =09=09/* Adjust by relative CPU power of the group */
 =09=09avg_load =3D (avg_load * SCHED_POWER_SCALE) / group->sgp->power;
=20
+=09=09/*
+=09=09 * Sample energy diff on probe_cpu.
+=09=09 * Finding the optimum cpu requires testing all cpus which is
+=09=09 * expensive.
+=09=09 */
+
+=09=09energy_diff =3D energy_diff_task(probe_cpu, p);
+
 =09=09if (local_group) {
 =09=09=09this_load =3D avg_load;
-=09=09} else if (avg_load < min_load) {
-=09=09=09min_load =3D avg_load;
-=09=09=09idlest =3D group;
+=09=09=09local_energy =3D energy_diff;
+=09=09} else {
+=09=09=09if (avg_load < min_load) {
+=09=09=09=09min_load =3D avg_load;
+=09=09=09=09idlest =3D group;
+=09=09=09}
+
+=09=09=09if (energy_diff < min_energy) {
+=09=09=09=09min_energy =3D energy_diff;
+=09=09=09=09energy =3D group;
+=09=09=09}
 =09=09}
 =09} while (group =3D group->next, group !=3D sd->groups);
=20
+#ifdef CONFIG_SCHED_ENERGY
+=09if (energy && min_energy < local_energy)
+=09=09return energy;
+=09return NULL;
+#else
 =09if (!idlest || 100*this_load < imbalance*min_load)
 =09=09return NULL;
 =09return idlest;
+#endif
 }
=20
 /*
- * find_idlest_cpu - find the idlest cpu among the cpus in group.
+ * find_target_cpu - find the target cpu among the cpus in group.
  */
 static int
-find_idlest_cpu(struct sched_group *group, struct task_struct *p, int this=
_cpu)
+find_target_cpu(struct sched_group *group, struct task_struct *p, int this=
_cpu)
 {
 =09unsigned long load, min_load =3D ULONG_MAX;
+=09int min_energy =3D INT_MAX, energy, least_energy =3D -1;
 =09int idlest =3D -1;
 =09int i;
=20
 =09/* Traverse only the allowed CPUs */
 =09for_each_cpu_and(i, sched_group_cpus(group), tsk_cpus_allowed(p)) {
 =09=09load =3D weighted_cpuload(i);
+=09=09energy =3D energy_diff_task(i, p);
=20
 =09=09if (load < min_load || (load =3D=3D min_load && i =3D=3D this_cpu)) =
{
 =09=09=09min_load =3D load;
 =09=09=09idlest =3D i;
 =09=09}
+
+=09=09if (energy < min_energy) {
+=09=09=09min_energy =3D energy;
+=09=09=09least_energy =3D i;
+=09=09}
 =09}
=20
+=09if (least_energy >=3D 0)
+=09=09return least_energy;
+
 =09return idlest;
 }
=20
@@ -4755,13 +4795,13 @@ select_task_rq_fair(struct task_struct *p, int prev=
_cpu, int sd_flag, int wake_f
 =09=09=09continue;
 =09=09}
=20
-=09=09group =3D find_idlest_group(sd, p, cpu, sd_flag);
+=09=09group =3D find_target_group(sd, p, cpu, sd_flag);
 =09=09if (!group) {
 =09=09=09sd =3D sd->child;
 =09=09=09continue;
 =09=09}
=20
-=09=09new_cpu =3D find_idlest_cpu(group, p, cpu);
+=09=09new_cpu =3D find_target_cpu(group, p, cpu);
 =09=09if (new_cpu =3D=3D -1 || new_cpu =3D=3D cpu) {
 =09=09=09/* Now try balancing at a lower domain level of cpu */
 =09=09=09sd =3D sd->child;
--=20
1.7.9.5
