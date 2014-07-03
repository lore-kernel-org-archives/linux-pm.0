From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [RFCv2 PATCH 07/23] sched: Introduce system-wide sched_energy
Date: Thu,  3 Jul 2014 17:25:54 +0100
Message-ID: <1404404770-323-8-git-send-email-morten.rasmussen@arm.com>
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

The energy aware algorithm needs system wide energy information on certain
platforms (e.g. a one socket SMP system). Unfortunately, there is no
sched_group that covers all cpus in the system, so there is no place to
attach a system wide sched_group_energy data structure. In such a system,
the energy data is only attached to the sched groups for the individual
cpus in the sched domain (sd) MC level.

This patch adds a _hack_ to provide system-wide energy data via the
sched_domain_topology_level table for such a system.

The problem is that the sched_domain_topology_level table is not an
interface to provide system-wide data but we want to keep the
configuration of all energy related data in one place.

The sched_domain_energy_f of the last entry (the one which is
initialized with {NULL, }) of the sched_domain_topology_level table is
set to cpu_sys_energy(). Since the sched_domain_mask_f of this entry
stays NULL it is still not considered for the existing scheduler set-up
code (see for_each_sd_topology()).

A second call to init_sched_energy() with an sd pointer argument set to
NULL initializes the system-wide energy structure sse.

There is no system-wide power management on the example platform (ARM TC2)
which could potentially interact with the scheduler so struct
sched_group_energy *sse stays NULL.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 arch/arm/kernel/topology.c |    7 ++++++-
 kernel/sched/core.c        |   34 ++++++++++++++++++++++++++++++----
 kernel/sched/sched.h       |    2 ++
 3 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index a7d5a6e..70915b1 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -386,6 +386,11 @@ static inline const struct sched_group_energy *cpu_cor=
e_energy(int cpu)
 =09=09=09&energy_core_a15;
 }
=20
+static inline const struct sched_group_energy *cpu_sys_energy(int cpu)
+{
+=09return NULL;
+}
+
 static inline const int cpu_corepower_flags(void)
 {
 =09return SD_SHARE_PKG_RESOURCES  | SD_SHARE_POWERDOMAIN;
@@ -396,7 +401,7 @@ static struct sched_domain_topology_level arm_topology[=
] =3D {
 =09{ cpu_coregroup_mask, cpu_corepower_flags, cpu_core_energy, SD_INIT_NAM=
E(MC) },
 #endif
 =09{ cpu_cpu_mask, 0, cpu_cluster_energy, SD_INIT_NAME(DIE) },
-=09{ NULL, },
+=09{ NULL,=090, cpu_sys_energy},
 };
=20
 /*
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7fecc63..2d7544a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5954,20 +5954,44 @@ static void init_sched_groups_capacity(int cpu, str=
uct sched_domain *sd)
 =09atomic_set(&sg->sgc->nr_busy_cpus, sg->group_weight);
 }
=20
+/* System-wide energy information. */
+struct sched_group_energy *sse;
+
 static void init_sched_energy(int cpu, struct sched_domain *sd,
 =09=09=09      struct sched_domain_topology_level *tl)
 {
-=09struct sched_group *sg =3D sd->groups;
-=09struct sched_group_energy *energy =3D sg->sge;
+=09struct sched_group *sg =3D sd ? sd->groups : NULL;
+=09struct sched_group_energy *energy =3D sd ? sg->sge : sse;
 =09sched_domain_energy_f fn =3D tl->energy;
-=09struct cpumask *mask =3D sched_group_cpus(sg);
+=09const struct cpumask *mask =3D sd ? sched_group_cpus(sg) :
+=09=09=09=09=09  cpu_cpu_mask(cpu);
=20
-=09if (!fn || !fn(cpu))
+=09if (!fn || !fn(cpu) || (!sd && energy))
 =09=09return;
=20
 =09if (cpumask_weight(mask) > 1)
 =09=09check_sched_energy_data(cpu, fn, mask);
=20
+=09if (!sd) {
+=09=09energy =3D sse =3D kzalloc(sizeof(struct sched_group_energy) +
+=09=09=09=09       fn(cpu)->nr_idle_states*
+=09=09=09=09       sizeof(struct idle_state) +
+=09=09=09=09       fn(cpu)->nr_cap_states*
+=09=09=09=09       sizeof(struct capacity_state),
+=09=09=09=09       GFP_KERNEL);
+=09=09BUG_ON(!energy);
+
+=09=09energy->idle_states =3D (struct idle_state *)
+=09=09=09=09      ((void *)&energy->cap_states +
+=09=09=09=09       sizeof(energy->cap_states));
+
+=09=09energy->cap_states =3D (struct capacity_state *)
+=09=09=09=09     ((void *)&energy->cap_states +
+=09=09=09=09      sizeof(energy->cap_states) +
+=09=09=09=09      fn(cpu)->nr_idle_states*
+=09=09=09=09      sizeof(struct idle_state));
+=09}
+
 =09energy->nr_idle_states =3D fn(cpu)->nr_idle_states;
 =09memcpy(energy->idle_states, fn(cpu)->idle_states,
 =09       energy->nr_idle_states*sizeof(struct idle_state));
@@ -6655,6 +6679,8 @@ static int build_sched_domains(const struct cpumask *=
cpu_map,
 =09=09=09claim_allocations(i, sd);
 =09=09=09init_sched_groups_capacity(i, sd);
 =09=09}
+
+=09=09init_sched_energy(i, NULL, tl);
 =09}
=20
 =09/* Attach the domains */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1a5f1ee..c971359 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -747,6 +747,8 @@ struct sched_group_capacity {
 =09unsigned long cpumask[0]; /* iteration mask */
 };
=20
+extern struct sched_group_energy *sse;
+
 struct sched_group {
 =09struct sched_group *next;=09/* Must be a circular list */
 =09atomic_t ref;
--=20
1.7.9.5
