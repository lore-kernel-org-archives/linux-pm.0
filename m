From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [RFCv2 PATCH 04/23] sched: Allocate and initialize energy data structures
Date: Thu,  3 Jul 2014 17:25:51 +0100
Message-ID: <1404404770-323-5-git-send-email-morten.rasmussen@arm.com>
References: <1404404770-323-1-git-send-email-morten.rasmussen@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:44979 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759115AbaGCQ0K (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Jul 2014 12:26:10 -0400
In-Reply-To: <1404404770-323-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, peterz@infradead.org, mingo@kernel.org
Cc: rjw@rjwysocki.net, vincent.guittot@linaro.org, daniel.lezcano@linaro.org, preeti@linux.vnet.ibm.com, Dietmar.Eggemann@arm.com, pjt@google.com

From: Dietmar Eggemann <dietmar.eggemann@arm.com>

The per sched group (sg) sched_group_energy structure plus the related
idle_state and capacity_state arrays are allocated like the other sched
domain (sd) hierarchy data structures. This includes the freeing of
sched_group_energy structures which are not used.

One problem is that the number of elements of the idle_state and the
capacity_state arrays is not fixed and has to be retrieved in
__sdt_alloc() to allocate memory for the sched_group_energy structure and
the two arrays in one chunk. The array pointers (idle_states and
cap_states) are initialized here to point to the correct place inside the
memory chunk.

The new function init_sched_energy() initializes the sched_group_energy
structure and the two arrays in case the sd topology level contains energy
information.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/core.c  |   71 ++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 kernel/sched/sched.h |   35 +++++++++++++++++++++++++
 2 files changed, 105 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 54f5722..ecece17 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5539,6 +5539,7 @@ static void free_sched_domain(struct rcu_head *rcu)
 =09=09free_sched_groups(sd->groups, 1);
 =09} else if (atomic_dec_and_test(&sd->groups->ref)) {
 =09=09kfree(sd->groups->sgc);
+=09=09kfree(sd->groups->sge);
 =09=09kfree(sd->groups);
 =09}
 =09kfree(sd);
@@ -5799,6 +5800,8 @@ static int get_group(int cpu, struct sd_data *sdd, st=
ruct sched_group **sg)
 =09=09*sg =3D *per_cpu_ptr(sdd->sg, cpu);
 =09=09(*sg)->sgc =3D *per_cpu_ptr(sdd->sgc, cpu);
 =09=09atomic_set(&(*sg)->sgc->ref, 1); /* for claim_allocations */
+=09=09(*sg)->sge =3D *per_cpu_ptr(sdd->sge, cpu);
+=09=09atomic_set(&(*sg)->sge->ref, 1); /* for claim_allocations */
 =09}
=20
 =09return cpu;
@@ -5888,6 +5891,28 @@ static void init_sched_groups_capacity(int cpu, stru=
ct sched_domain *sd)
 =09atomic_set(&sg->sgc->nr_busy_cpus, sg->group_weight);
 }
=20
+static void init_sched_energy(int cpu, struct sched_domain *sd,
+=09=09=09      struct sched_domain_topology_level *tl)
+{
+=09struct sched_group *sg =3D sd->groups;
+=09struct sched_group_energy *energy =3D sg->sge;
+=09sched_domain_energy_f fn =3D tl->energy;
+=09struct cpumask *mask =3D sched_group_cpus(sg);
+
+=09if (!fn || !fn(cpu))
+=09=09return;
+
+=09if (cpumask_weight(mask) > 1)
+=09=09check_sched_energy_data(cpu, fn, mask);
+
+=09energy->nr_idle_states =3D fn(cpu)->nr_idle_states;
+=09memcpy(energy->idle_states, fn(cpu)->idle_states,
+=09       energy->nr_idle_states*sizeof(struct idle_state));
+=09energy->nr_cap_states =3D fn(cpu)->nr_cap_states;
+=09memcpy(energy->cap_states, fn(cpu)->cap_states,
+=09       energy->nr_cap_states*sizeof(struct capacity_state));
+}
+
 /*
  * Initializers for schedule domains
  * Non-inlined to reduce accumulated stack pressure in build_sched_domains=
()
@@ -5978,6 +6003,9 @@ static void claim_allocations(int cpu, struct sched_d=
omain *sd)
=20
 =09if (atomic_read(&(*per_cpu_ptr(sdd->sgc, cpu))->ref))
 =09=09*per_cpu_ptr(sdd->sgc, cpu) =3D NULL;
+
+=09if (atomic_read(&(*per_cpu_ptr(sdd->sge, cpu))->ref))
+=09=09*per_cpu_ptr(sdd->sge, cpu) =3D NULL;
 }
=20
 #ifdef CONFIG_NUMA
@@ -6383,10 +6411,24 @@ static int __sdt_alloc(const struct cpumask *cpu_ma=
p)
 =09=09if (!sdd->sgc)
 =09=09=09return -ENOMEM;
=20
+=09=09sdd->sge =3D alloc_percpu(struct sched_group_energy *);
+=09=09if (!sdd->sge)
+=09=09=09return -ENOMEM;
+
 =09=09for_each_cpu(j, cpu_map) {
 =09=09=09struct sched_domain *sd;
 =09=09=09struct sched_group *sg;
 =09=09=09struct sched_group_capacity *sgc;
+=09=09=09struct sched_group_energy *sge;
+=09=09=09sched_domain_energy_f fn =3D tl->energy;
+=09=09=09unsigned int nr_idle_states =3D 0;
+=09=09=09unsigned int nr_cap_states =3D 0;
+
+=09=09=09if (fn && fn(j)) {
+=09=09=09=09nr_idle_states =3D fn(j)->nr_idle_states;
+=09=09=09=09nr_cap_states =3D fn(j)->nr_cap_states;
+=09=09=09=09BUG_ON(!nr_idle_states || !nr_cap_states);
+=09=09=09}
=20
 =09=09       =09sd =3D kzalloc_node(sizeof(struct sched_domain) + cpumask_=
size(),
 =09=09=09=09=09GFP_KERNEL, cpu_to_node(j));
@@ -6410,6 +6452,26 @@ static int __sdt_alloc(const struct cpumask *cpu_map=
)
 =09=09=09=09return -ENOMEM;
=20
 =09=09=09*per_cpu_ptr(sdd->sgc, j) =3D sgc;
+
+=09=09=09sge =3D kzalloc_node(sizeof(struct sched_group_energy) +
+=09=09=09=09nr_idle_states*sizeof(struct idle_state) +
+=09=09=09=09nr_cap_states*sizeof(struct capacity_state),
+=09=09=09=09GFP_KERNEL, cpu_to_node(j));
+
+=09=09=09if (!sge)
+=09=09=09=09return -ENOMEM;
+
+=09=09=09sge->idle_states =3D (struct idle_state *)
+=09=09=09=09=09   ((void *)&sge->cap_states +
+=09=09=09=09=09    sizeof(sge->cap_states));
+
+=09=09=09sge->cap_states =3D (struct capacity_state *)
+=09=09=09=09=09  ((void *)&sge->cap_states +
+=09=09=09=09=09   sizeof(sge->cap_states) +
+=09=09=09=09=09   nr_idle_states*
+=09=09=09=09=09   sizeof(struct idle_state));
+
+=09=09=09*per_cpu_ptr(sdd->sge, j) =3D sge;
 =09=09}
 =09}
=20
@@ -6438,6 +6500,8 @@ static void __sdt_free(const struct cpumask *cpu_map)
 =09=09=09=09kfree(*per_cpu_ptr(sdd->sg, j));
 =09=09=09if (sdd->sgc)
 =09=09=09=09kfree(*per_cpu_ptr(sdd->sgc, j));
+=09=09=09if (sdd->sge)
+=09=09=09=09kfree(*per_cpu_ptr(sdd->sge, j));
 =09=09}
 =09=09free_percpu(sdd->sd);
 =09=09sdd->sd =3D NULL;
@@ -6445,6 +6509,8 @@ static void __sdt_free(const struct cpumask *cpu_map)
 =09=09sdd->sg =3D NULL;
 =09=09free_percpu(sdd->sgc);
 =09=09sdd->sgc =3D NULL;
+=09=09free_percpu(sdd->sge);
+=09=09sdd->sge =3D NULL;
 =09}
 }
=20
@@ -6516,10 +6582,13 @@ static int build_sched_domains(const struct cpumask=
 *cpu_map,
=20
 =09/* Calculate CPU capacity for physical packages and nodes */
 =09for (i =3D nr_cpumask_bits-1; i >=3D 0; i--) {
+=09=09struct sched_domain_topology_level *tl =3D sched_domain_topology;
+
 =09=09if (!cpumask_test_cpu(i, cpu_map))
 =09=09=09continue;
=20
-=09=09for (sd =3D *per_cpu_ptr(d.sd, i); sd; sd =3D sd->parent) {
+=09=09for (sd =3D *per_cpu_ptr(d.sd, i); sd; sd =3D sd->parent, tl++) {
+=09=09=09init_sched_energy(i, sd, tl);
 =09=09=09claim_allocations(i, sd);
 =09=09=09init_sched_groups_capacity(i, sd);
 =09=09}
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d300a64..1a5f1ee 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -790,6 +790,41 @@ static inline unsigned int group_first_cpu(struct sche=
d_group *group)
=20
 extern int group_balance_cpu(struct sched_group *sg);
=20
+/*
+ * Check that the per-cpu provided sd energy data is consistent for all cp=
us
+ * within the mask.
+ */
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
+=09=09int y;
+
+=09=09BUG_ON(fn(i)->nr_idle_states !=3D fn(cpu)->nr_idle_states);
+
+=09=09for (y =3D 0; y < (fn(i)->nr_idle_states); y++) {
+=09=09=09BUG_ON(fn(i)->idle_states[y].power !=3D
+=09=09=09=09=09fn(cpu)->idle_states[y].power);
+=09=09=09BUG_ON(fn(i)->idle_states[y].wu_energy !=3D
+=09=09=09=09=09fn(cpu)->idle_states[y].wu_energy);
+=09=09}
+
+=09=09BUG_ON(fn(i)->nr_cap_states !=3D fn(cpu)->nr_cap_states);
+
+=09=09for (y =3D 0; y < (fn(i)->nr_cap_states); y++) {
+=09=09=09BUG_ON(fn(i)->cap_states[y].cap !=3D
+=09=09=09=09=09fn(cpu)->cap_states[y].cap);
+=09=09=09BUG_ON(fn(i)->cap_states[y].power !=3D
+=09=09=09=09=09fn(cpu)->cap_states[y].power);
+=09=09}
+=09}
+}
+
 #else
=20
 static inline void sched_ttwu_pending(void) { }
--=20
1.7.9.5


