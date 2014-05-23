From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [RFC PATCH 06/16] arm: topology: Define TC2 sched energy and provide it to scheduler
Date: Fri, 23 May 2014 19:16:33 +0100
Message-ID: <1400869003-27769-7-git-send-email-morten.rasmussen@arm.com>
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

!!! This patch is only here to be able to test provisioning of sched
energy related data from an arch topology shim layer to the scheduler.
Since there is no code today which deals with extracting sched energy
related data from the dtb or acpi, and process it in the topology shim
layer, the struct sched_energy and the related struct capacity_state
arrays are hard-coded here !!!

This patch defines the struct sched_energy and the related struct
capacity_state array for the cluster (relates to sg's in DIE sd level)
and for the core (relates to sg's in MC sd level) for a Cortex A7 as
well as for a Cortex A15. It further provides related implementations of
the sched_domain_energy_f functions (cpu_cluster_energy() and
cpu_core_energy()).

To be able to propagate this information from the topology shim layer to
the scheduler, the elements of the arm_topology[] table have been
provisioned with the appropriate sched_domain_energy_f functions.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 arch/arm/kernel/topology.c |  109 ++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 109 insertions(+)

diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index 71e1fec..4050348 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -275,6 +275,107 @@ void store_cpu_topology(unsigned int cpuid)
 =09=09cpu_topology[cpuid].socket_id, mpidr);
 }
=20
+#ifdef CONFIG_SCHED_ENERGY
+/*
+ * ARM TC2 specific energy cost model data. There are no unit requirements=
 for
+ * the data. Data can be normalized to any reference point, but the
+ * normalization must be consistent. That is, one bogo-joule/watt must be =
the
+ * same quantity for all data, but we don't care what it is.
+ */
+static struct capacity_state cap_states_cluster_a7[] =3D {
+=09/* Cluster only power */
+=09 { .cap =3D  358, .power =3D 2967, }, /*  350 MHz */
+=09 { .cap =3D  410, .power =3D 2792, }, /*  400 MHz */
+=09 { .cap =3D  512, .power =3D 2810, }, /*  500 MHz */
+=09 { .cap =3D  614, .power =3D 2815, }, /*  600 MHz */
+=09 { .cap =3D  717, .power =3D 2919, }, /*  700 MHz */
+=09 { .cap =3D  819, .power =3D 2847, }, /*  800 MHz */
+=09 { .cap =3D  922, .power =3D 3917, }, /*  900 MHz */
+=09 { .cap =3D 1024, .power =3D 4905, }, /* 1000 MHz */
+=09};
+
+static struct capacity_state cap_states_cluster_a15[] =3D {
+=09/* Cluster only power */
+=09 { .cap =3D  840, .power =3D  7920, }, /*  500 MHz */
+=09 { .cap =3D 1008, .power =3D  8165, }, /*  600 MHz */
+=09 { .cap =3D 1176, .power =3D  8172, }, /*  700 MHz */
+=09 { .cap =3D 1343, .power =3D  8195, }, /*  800 MHz */
+=09 { .cap =3D 1511, .power =3D  8265, }, /*  900 MHz */
+=09 { .cap =3D 1679, .power =3D  8446, }, /* 1000 MHz */
+=09 { .cap =3D 1847, .power =3D 11426, }, /* 1100 MHz */
+=09 { .cap =3D 2015, .power =3D 15200, }, /* 1200 MHz */
+=09};
+
+static struct sched_energy energy_cluster_a7 =3D {
+=09  .max_capacity   =3D 1024,
+=09  .idle_power     =3D   10, /* Cluster power-down */
+=09  .wakeup_energy  =3D    6, /* << 10 */
+=09  .nr_cap_states  =3D ARRAY_SIZE(cap_states_cluster_a7),
+=09  .cap_states     =3D cap_states_cluster_a7,
+};
+
+static struct sched_energy energy_cluster_a15 =3D {
+=09  .max_capacity   =3D 2015,
+=09  .idle_power     =3D   25, /* Cluster power-down */
+=09  .wakeup_energy  =3D  210, /* << 10 */
+=09  .nr_cap_states  =3D ARRAY_SIZE(cap_states_cluster_a15),
+=09  .cap_states     =3D cap_states_cluster_a15,
+};
+
+static struct capacity_state cap_states_core_a7[] =3D {
+=09/* Power per cpu */
+=09 { .cap =3D  358, .power =3D  187, }, /*  350 MHz */
+=09 { .cap =3D  410, .power =3D  275, }, /*  400 MHz */
+=09 { .cap =3D  512, .power =3D  334, }, /*  500 MHz */
+=09 { .cap =3D  614, .power =3D  407, }, /*  600 MHz */
+=09 { .cap =3D  717, .power =3D  447, }, /*  700 MHz */
+=09 { .cap =3D  819, .power =3D  549, }, /*  800 MHz */
+=09 { .cap =3D  922, .power =3D  761, }, /*  900 MHz */
+=09 { .cap =3D 1024, .power =3D 1024, }, /* 1000 MHz */
+=09};
+
+static struct capacity_state cap_states_core_a15[] =3D {
+=09/* Power per cpu */
+=09 { .cap =3D  840, .power =3D 2021, }, /*  500 MHz */
+=09 { .cap =3D 1008, .power =3D 2312, }, /*  600 MHz */
+=09 { .cap =3D 1176, .power =3D 2756, }, /*  700 MHz */
+=09 { .cap =3D 1343, .power =3D 3125, }, /*  800 MHz */
+=09 { .cap =3D 1511, .power =3D 3524, }, /*  900 MHz */
+=09 { .cap =3D 1679, .power =3D 3846, }, /* 1000 MHz */
+=09 { .cap =3D 1847, .power =3D 5177, }, /* 1100 MHz */
+=09 { .cap =3D 2015, .power =3D 6997, }, /* 1200 MHz */
+=09};
+
+static struct sched_energy energy_core_a7 =3D {
+=09  .max_capacity   =3D 1024,
+=09  .idle_power     =3D    0, /* No power gating */
+=09  .wakeup_energy  =3D    0, /* << 10 */
+=09  .nr_cap_states  =3D ARRAY_SIZE(cap_states_core_a7),
+=09  .cap_states     =3D cap_states_core_a7,
+};
+
+static struct sched_energy energy_core_a15 =3D {
+=09  .max_capacity   =3D 2015,
+=09  .idle_power     =3D    0, /* No power gating */
+=09  .wakeup_energy  =3D    5, /* << 10 */
+=09  .nr_cap_states  =3D ARRAY_SIZE(cap_states_core_a15),
+=09  .cap_states     =3D cap_states_core_a15,
+};
+
+/* sd energy functions */
+static inline const struct sched_energy *cpu_cluster_energy(int cpu)
+{
+=09return cpu_topology[cpu].socket_id ? &energy_cluster_a7 :
+=09=09=09&energy_cluster_a15;
+}
+
+static inline const struct sched_energy *cpu_core_energy(int cpu)
+{
+=09return cpu_topology[cpu].socket_id ? &energy_core_a7 :
+=09=09=09&energy_core_a15;
+}
+#endif /* CONFIG_SCHED_ENERGY */
+
 static inline const int cpu_corepower_flags(void)
 {
 =09return SD_SHARE_PKG_RESOURCES  | SD_SHARE_POWERDOMAIN;
@@ -282,10 +383,18 @@ static inline const int cpu_corepower_flags(void)
=20
 static struct sched_domain_topology_level arm_topology[] =3D {
 #ifdef CONFIG_SCHED_MC
+#ifdef CONFIG_SCHED_ENERGY
+=09{ cpu_coregroup_mask, cpu_corepower_flags, cpu_core_energy, SD_INIT_NAM=
E(MC) },
+#else
 =09{ cpu_corepower_mask, cpu_corepower_flags, SD_INIT_NAME(GMC) },
 =09{ cpu_coregroup_mask, cpu_core_flags, SD_INIT_NAME(MC) },
 #endif
+#endif
+#ifdef CONFIG_SCHED_ENERGY
+=09{ cpu_cpu_mask, 0, cpu_cluster_energy, SD_INIT_NAME(DIE) },
+#else
 =09{ cpu_cpu_mask, SD_INIT_NAME(DIE) },
+#endif
 =09{ NULL, },
 };
=20
--=20
1.7.9.5
