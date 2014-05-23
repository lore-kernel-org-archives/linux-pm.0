From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [RFC PATCH 07/16] sched: Introduce system-wide sched_energy
Date: Fri, 23 May 2014 19:16:34 +0100
Message-ID: <1400869003-27769-8-git-send-email-morten.rasmussen@arm.com>
References: <1400869003-27769-1-git-send-email-morten.rasmussen@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:36102 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751397AbaEWSQx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 23 May 2014 14:16:53 -0400
In-Reply-To: <1400869003-27769-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, peterz@infradead.org, mingo@kernel.org
Cc: rjw@rjwysocki.net, vincent.guittot@linaro.org, daniel.lezcano@linaro.org, preeti@linux.vnet.ibm.com, dietmar.eggemann@arm.com

From: Dietmar Eggemann <dietmar.eggemann@arm.com>

The Energy-aware algorithm needs system wide sched energy information on
certain platforms (e.g. a one socket system with multiple cpus).

In such a system, the sched energy data is only attached to the sched
groups for the individual cpus in the sched domain MC level.

For those systems, this patch adds a _hack_ to provide system-wide sched
energy data via the sched_domain_topology_level table.

The problem is that the sched_domain_topology_level table is not an
interface to provide system-wide data but we want to keep the
configuration of all sched energy related data in one place.

The sched_domain_energy_f of the last entry (the one which is
initialized with {NULL, }) of the sched_domain_topology_level table is
set to cpu_sys_energy(). Since the sched_domain_mask_f of this entry
stays NULL it is still not considered for the existing scheduler set-up
code (see for_each_sd_topology()).

A second call to init_sched_energy() with a struct sched_domain pointer
equal NULL as an argument will initialize the system-wide sched energy
structure sse.

For the example platform (ARM TC2 (MC and DIE sd level)), the
system-wide sched_domain_energy_f returns NULL, so struct sched_energy
*sse stays NULL.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 arch/arm/kernel/topology.c |    8 +++++++-
 kernel/sched/core.c        |   26 ++++++++++++++++++++++----
 kernel/sched/sched.h       |    2 ++
 3 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index 4050348..0b9c1e0 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -374,6 +374,11 @@ static inline const struct sched_energy *cpu_core_ener=
gy(int cpu)
 =09return cpu_topology[cpu].socket_id ? &energy_core_a7 :
 =09=09=09&energy_core_a15;
 }
+
+static inline const struct sched_energy *cpu_sys_energy(int cpu)
+{
+=09return NULL;
+}
 #endif /* CONFIG_SCHED_ENERGY */
=20
 static inline const int cpu_corepower_flags(void)
@@ -392,10 +397,11 @@ static struct sched_domain_topology_level arm_topolog=
y[] =3D {
 #endif
 #ifdef CONFIG_SCHED_ENERGY
 =09{ cpu_cpu_mask, 0, cpu_cluster_energy, SD_INIT_NAME(DIE) },
+=09{ NULL,=090, cpu_sys_energy},
 #else
 =09{ cpu_cpu_mask, SD_INIT_NAME(DIE) },
+=09{ NULL,=09},
 #endif
-=09{ NULL, },
 };
=20
 /*
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 096fa55..530a348 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5866,20 +5866,35 @@ static void init_sched_groups_power(int cpu, struct=
 sched_domain *sd)
 }
=20
 #ifdef CONFIG_SCHED_ENERGY
+/* System-wide energy information. */
+struct sched_energy *sse;
+
 static void init_sched_energy(int cpu, struct sched_domain *sd,
 =09=09=09      struct sched_domain_topology_level *tl)
 {
-=09struct sched_group *sg =3D sd->groups;
-=09struct sched_energy *energy =3D &sg->sge->data;
+=09struct sched_group *sg =3D sd ? sd->groups : NULL;
+=09struct sched_energy *energy =3D sd ? &sg->sge->data : sse;
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
+=09=09energy =3D sse =3D kzalloc_node(sizeof(struct sched_energy) +
+=09=09=09=09=09    fn(cpu)->nr_cap_states*
+=09=09=09=09=09    sizeof(struct capacity_state),
+=09=09=09=09=09    GFP_KERNEL, cpu_to_node(cpu));
+=09=09BUG_ON(!energy);
+
+=09=09energy->cap_states =3D (struct capacity_state *)((void *)energy +
+=09=09=09=09sizeof(struct sched_energy));
+=09}
+
 =09energy->max_capacity =3D fn(cpu)->max_capacity;
 =09energy->idle_power =3D fn(cpu)->idle_power;
 =09energy->wakeup_energy =3D fn(cpu)->wakeup_energy;
@@ -6579,6 +6594,9 @@ static int build_sched_domains(const struct cpumask *=
cpu_map,
 =09=09=09claim_allocations(i, sd);
 =09=09=09init_sched_groups_power(i, sd);
 =09=09}
+#ifdef CONFIG_SCHED_ENERGY
+=09=09init_sched_energy(i, NULL, tl);
+#endif
 =09}
=20
 =09/* Attach the domains */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 6726437..9ff67a7 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -760,6 +760,8 @@ struct sched_group_energy {
 =09atomic_t ref;
 =09struct sched_energy data;
 };
+
+extern struct sched_energy *sse;
 #endif
=20
 struct sched_group {
--=20
1.7.9.5


