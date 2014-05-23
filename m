From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [RFC PATCH 04/16] sched: Allocate and initialize sched energy
Date: Fri, 23 May 2014 19:16:31 +0100
Message-ID: <1400869003-27769-5-git-send-email-morten.rasmussen@arm.com>
References: <1400869003-27769-1-git-send-email-morten.rasmussen@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1400869003-27769-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, peterz@infradead.org, mingo@kernel.org
Cc: rjw@rjwysocki.net, vincent.guittot@linaro.org, daniel.lezcano@linaro.org, preeti@linux.vnet.ibm.com, dietmar.eggemann@arm.com
List-Id: linux-pm@vger.kernel.org

From: Dietmar Eggemann <dietmar.eggemann@arm.com>

The per sg struct sched_group_energy structure plus the related struct
capacity_state array are allocated like the other sd hierarchy data
structures (e.g. struct sched_group).  This includes the freeing of
struct sched_group_energy structures which are not used.
One problem is that the sd energy information consists of two structures
per sg, the actual struct sched_group_energy and the related
capacity_state array and that the number of elements of this array can be
configured (see struct sched_group_energy.nr_cap_states).  That means
that the number of capacity states has to be figured out in __sdt_alloc()
and since both data structures are allocated at the same time, struct
sched_group_energy.cap_states is initialized to point to the start of the
capacity state array memory.

The new function init_sched_energy() initializes the per sg struct
sched_group_energy and the struct capacity_state array in case the struct
sched_domain_topology_level contains sd energy information.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/core.c  |   86 ++++++++++++++++++++++++++++++++++++++++++++++=
++++
 kernel/sched/sched.h |   30 ++++++++++++++++++
 2 files changed, 116 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 851cbd8..785b61d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5438,6 +5438,9 @@ static void free_sched_domain(struct rcu_head *rcu)
 =09=09free_sched_groups(sd->groups, 1);
 =09} else if (atomic_dec_and_test(&sd->groups->ref)) {
 =09=09kfree(sd->groups->sgp);
+#ifdef CONFIG_SCHED_ENERGY
+=09=09kfree(sd->groups->sge);
+#endif
 =09=09kfree(sd->groups);
 =09}
 =09kfree(sd);
@@ -5698,6 +5701,10 @@ static int get_group(int cpu, struct sd_data *sdd, s=
truct sched_group **sg)
 =09=09*sg =3D *per_cpu_ptr(sdd->sg, cpu);
 =09=09(*sg)->sgp =3D *per_cpu_ptr(sdd->sgp, cpu);
 =09=09atomic_set(&(*sg)->sgp->ref, 1); /* for claim_allocations */
+#ifdef CONFIG_SCHED_ENERGY
+=09=09(*sg)->sge =3D *per_cpu_ptr(sdd->sge, cpu);
+=09=09atomic_set(&(*sg)->sge->ref, 1); /* for claim_allocations */
+#endif
 =09}
=20
 =09return cpu;
@@ -5789,6 +5796,31 @@ static void init_sched_groups_power(int cpu, struct =
sched_domain *sd)
 =09atomic_set(&sg->sgp->nr_busy_cpus, sg->group_weight);
 }
=20
+#ifdef CONFIG_SCHED_ENERGY
+static void init_sched_energy(int cpu, struct sched_domain *sd,
+=09=09=09      struct sched_domain_topology_level *tl)
+{
+=09struct sched_group *sg =3D sd->groups;
+=09struct sched_energy *energy =3D &sg->sge->data;
+=09sched_domain_energy_f fn =3D tl->energy;
+=09struct cpumask *mask =3D sched_group_cpus(sg);
+
+=09if (!fn || !fn(cpu))
+=09=09return;
+
+=09if (cpumask_weight(mask) > 1)
+=09=09check_sched_energy_data(cpu, fn, mask);
+
+=09energy->max_capacity =3D fn(cpu)->max_capacity;
+=09energy->idle_power =3D fn(cpu)->idle_power;
+=09energy->wakeup_energy =3D fn(cpu)->wakeup_energy;
+=09energy->nr_cap_states =3D fn(cpu)->nr_cap_states;
+
+=09memcpy(energy->cap_states, fn(cpu)->cap_states,
+=09       energy->nr_cap_states*sizeof(struct capacity_state));
+}
+#endif
+
 /*
  * Initializers for schedule domains
  * Non-inlined to reduce accumulated stack pressure in build_sched_domains=
()
@@ -5879,6 +5911,11 @@ static void claim_allocations(int cpu, struct sched_=
domain *sd)
=20
 =09if (atomic_read(&(*per_cpu_ptr(sdd->sgp, cpu))->ref))
 =09=09*per_cpu_ptr(sdd->sgp, cpu) =3D NULL;
+
+#ifdef CONFIG_SCHED_ENERGY
+=09if (atomic_read(&(*per_cpu_ptr(sdd->sge, cpu))->ref))
+=09=09*per_cpu_ptr(sdd->sge, cpu) =3D NULL;
+#endif
 }
=20
 #ifdef CONFIG_NUMA
@@ -6284,10 +6321,29 @@ static int __sdt_alloc(const struct cpumask *cpu_ma=
p)
 =09=09if (!sdd->sgp)
 =09=09=09return -ENOMEM;
=20
+#ifdef CONFIG_SCHED_ENERGY
+=09=09sdd->sge =3D alloc_percpu(struct sched_group_energy *);
+=09=09if (!sdd->sge)
+=09=09=09return -ENOMEM;
+#endif
 =09=09for_each_cpu(j, cpu_map) {
 =09=09=09struct sched_domain *sd;
 =09=09=09struct sched_group *sg;
 =09=09=09struct sched_group_power *sgp;
+#ifdef CONFIG_SCHED_ENERGY
+=09=09=09struct sched_group_energy *sge;
+=09=09=09sched_domain_energy_f fn =3D tl->energy;
+
+=09=09=09/*
+=09=09=09 * Figure out how many elements the cap state array has
+=09=09=09 * to contain.
+=09=09=09 * In case tl->info.energy(j)->nr_cap_states is 0, we
+=09=09=09 * still allocate struct sched_group_energy XXX which is
+=09=09=09 * not used but will be freed later XXX.
+=09=09=09 */
+=09=09=09unsigned int nr_cap_states =3D !fn || !fn(j) ? 0 :
+=09=09=09=09=09fn(j)->nr_cap_states;
+#endif
=20
 =09=09       =09sd =3D kzalloc_node(sizeof(struct sched_domain) + cpumask_=
size(),
 =09=09=09=09=09GFP_KERNEL, cpu_to_node(j));
@@ -6311,6 +6367,20 @@ static int __sdt_alloc(const struct cpumask *cpu_map=
)
 =09=09=09=09return -ENOMEM;
=20
 =09=09=09*per_cpu_ptr(sdd->sgp, j) =3D sgp;
+
+#ifdef CONFIG_SCHED_ENERGY
+=09=09=09sge =3D kzalloc_node(sizeof(struct sched_group_energy) +
+=09=09=09=09nr_cap_states*sizeof(struct capacity_state),
+=09=09=09=09GFP_KERNEL, cpu_to_node(j));
+
+=09=09=09if (!sge)
+=09=09=09=09return -ENOMEM;
+
+=09=09=09sge->data.cap_states =3D (struct capacity_state *)((void *)sge +
+=09=09=09=09 sizeof(struct sched_group_energy));
+
+=09=09=09*per_cpu_ptr(sdd->sge, j) =3D sge;
+#endif
 =09=09}
 =09}
=20
@@ -6339,6 +6409,10 @@ static void __sdt_free(const struct cpumask *cpu_map=
)
 =09=09=09=09kfree(*per_cpu_ptr(sdd->sg, j));
 =09=09=09if (sdd->sgp)
 =09=09=09=09kfree(*per_cpu_ptr(sdd->sgp, j));
+#ifdef CONFIG_SCHED_ENERGY
+=09=09=09if (sdd->sge)
+=09=09=09=09kfree(*per_cpu_ptr(sdd->sge, j));
+#endif
 =09=09}
 =09=09free_percpu(sdd->sd);
 =09=09sdd->sd =3D NULL;
@@ -6346,6 +6420,10 @@ static void __sdt_free(const struct cpumask *cpu_map=
)
 =09=09sdd->sg =3D NULL;
 =09=09free_percpu(sdd->sgp);
 =09=09sdd->sgp =3D NULL;
+#ifdef CONFIG_SCHED_ENERGY
+=09=09free_percpu(sdd->sge);
+=09=09sdd->sge =3D NULL;
+#endif
 =09}
 }
=20
@@ -6417,10 +6495,18 @@ static int build_sched_domains(const struct cpumask=
 *cpu_map,
=20
 =09/* Calculate CPU power for physical packages and nodes */
 =09for (i =3D nr_cpumask_bits-1; i >=3D 0; i--) {
+#ifdef CONFIG_SCHED_ENERGY
+=09=09struct sched_domain_topology_level *tl =3D sched_domain_topology;
+#endif
 =09=09if (!cpumask_test_cpu(i, cpu_map))
 =09=09=09continue;
=20
+#ifdef CONFIG_SCHED_ENERGY
+=09=09for (sd =3D *per_cpu_ptr(d.sd, i); sd; sd =3D sd->parent, tl++) {
+=09=09=09init_sched_energy(i, sd, tl);
+#else
 =09=09for (sd =3D *per_cpu_ptr(d.sd, i); sd; sd =3D sd->parent) {
+#endif
 =09=09=09claim_allocations(i, sd);
 =09=09=09init_sched_groups_power(i, sd);
 =09=09}
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index c566f5e..6726437 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -807,6 +807,36 @@ static inline unsigned int group_first_cpu(struct sche=
d_group *group)
=20
 extern int group_balance_cpu(struct sched_group *sg);
=20
+/*
+ * Check that the per-cpu provided sd energy data is consistent for all cp=
us
+ * within the mask.
+ */
+#ifdef CONFIG_SCHED_ENERGY
+static inline void check_sched_energy_data(int cpu, sched_domain_energy_f =
fn,
+=09=09=09=09=09   const struct cpumask *cpumask)
+{
+=09struct cpumask mask;
+=09int i;
+
+=09cpumask_xor(&mask, cpumask, get_cpu_mask(cpu));
+
+=09for_each_cpu(i, &mask) {
+=09=09int y =3D 0;
+
+=09=09BUG_ON(fn(i)->max_capacity !=3D fn(cpu)->max_capacity);
+=09=09BUG_ON(fn(i)->idle_power !=3D fn(cpu)->idle_power);
+=09=09BUG_ON(fn(i)->wakeup_energy !=3D fn(cpu)->wakeup_energy);
+=09=09BUG_ON(fn(i)->nr_cap_states !=3D fn(cpu)->nr_cap_states);
+
+=09=09for (; y < (fn(i)->nr_cap_states); y++) {
+=09=09=09BUG_ON(fn(i)->cap_states[y].cap !=3D
+=09=09=09=09=09fn(cpu)->cap_states[y].cap);
+=09=09=09BUG_ON(fn(i)->cap_states[y].power !=3D
+=09=09=09=09=09fn(cpu)->cap_states[y].power);
+=09=09}
+=09}
+}
+#endif
 #endif /* CONFIG_SMP */
=20
 #include "stats.h"
--=20
1.7.9.5
