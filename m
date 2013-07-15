From: Sudeep.KarkadaNagesha@arm.com
Subject: [RFC PATCH 03/11] ARM: topology: remove hwid/MPIDR dependency from cpu_capacity
Date: Mon, 15 Jul 2013 11:22:04 +0100
Message-ID: <1373883732-26303-4-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1373883732-26303-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:33679 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755022Ab3GOKWY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jul 2013 06:22:24 -0400
In-Reply-To: <1373883732-26303-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: cpufreq@vger.kernel.org, arnd@arndb.de, olof@lixom.net, lorenzo.pieralisi@arm.com, rob.herring@calxeda.com, grant.likely@linaro.org, rjw@sisk.pl, viresh.kumar@linaro.org, gregkh@linuxfoundation.org, gregory.clement@free-electrons.com, kernel@pengutronix.de, shawn.guo@linaro.org, linux@arm.linux.org.uk, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

Currently the topology code computes cpu capacity and stores it in
the list along with hwid(which is MPIDR) as it parses the CPU nodes
in the device tree. This is required as it needs to be mapped to the
logical CPU later.

Since the CPU device nodes can be retrieved in the logical ordering
using helpers, its possible to store cpu_capacity also in logical
ordering and avoid storing hwid for each entry.

This patch removes hwid by making use of arch_of_get_cpu_node.

Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
---
 arch/arm/kernel/topology.c | 61 +++++++++++++++---------------------------=
----
 1 file changed, 19 insertions(+), 42 deletions(-)

diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index c5a5954..c1a8f05 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -74,12 +74,8 @@ struct cpu_efficiency table_efficiency[] =3D {
 =09{NULL, },
 };
=20
-struct cpu_capacity {
-=09unsigned long hwid;
-=09unsigned long capacity;
-};
-
-struct cpu_capacity *cpu_capacity;
+unsigned long *__cpu_capacity;
+#define cpu_capacity(cpu)=09__cpu_capacity[cpu]
=20
 unsigned long middle_capacity =3D 1;
=20
@@ -100,15 +96,19 @@ static void __init parse_dt_topology(void)
 =09unsigned long capacity =3D 0;
 =09int alloc_size, cpu =3D 0;
=20
-=09alloc_size =3D nr_cpu_ids * sizeof(struct cpu_capacity);
-=09cpu_capacity =3D kzalloc(alloc_size, GFP_NOWAIT);
+=09alloc_size =3D nr_cpu_ids * sizeof(*__cpu_capacity);
+=09__cpu_capacity =3D kzalloc(alloc_size, GFP_NOWAIT);
=20
-=09while ((cn =3D of_find_node_by_type(cn, "cpu"))) {
-=09=09const u32 *rate, *reg;
+=09for_each_possible_cpu(cpu) {
+=09=09const u32 *rate;
 =09=09int len;
=20
-=09=09if (cpu >=3D num_possible_cpus())
-=09=09=09break;
+=09=09/* too early to use cpu->of_node */
+=09=09cn =3D arch_of_get_cpu_node(cpu);
+=09=09if (!cn) {
+=09=09=09pr_err("missing device node for CPU %d\n", cpu);
+=09=09=09continue;
+=09=09}
=20
 =09=09for (cpu_eff =3D table_efficiency; cpu_eff->compatible; cpu_eff++)
 =09=09=09if (of_device_is_compatible(cn, cpu_eff->compatible))
@@ -124,12 +124,6 @@ static void __init parse_dt_topology(void)
 =09=09=09continue;
 =09=09}
=20
-=09=09reg =3D of_get_property(cn, "reg", &len);
-=09=09if (!reg || len !=3D 4) {
-=09=09=09pr_err("%s missing reg property\n", cn->full_name);
-=09=09=09continue;
-=09=09}
-
 =09=09capacity =3D ((be32_to_cpup(rate)) >> 20) * cpu_eff->efficiency;
=20
 =09=09/* Save min capacity of the system */
@@ -140,13 +134,9 @@ static void __init parse_dt_topology(void)
 =09=09if (capacity > max_capacity)
 =09=09=09max_capacity =3D capacity;
=20
-=09=09cpu_capacity[cpu].capacity =3D capacity;
-=09=09cpu_capacity[cpu++].hwid =3D be32_to_cpup(reg);
+=09=09cpu_capacity(cpu) =3D capacity;
 =09}
=20
-=09if (cpu < num_possible_cpus())
-=09=09cpu_capacity[cpu].hwid =3D (unsigned long)(-1);
-
 =09/* If min and max capacities are equals, we bypass the update of the
 =09 * cpu_scale because all CPUs have the same capacity. Otherwise, we
 =09 * compute a middle_capacity factor that will ensure that the capacity
@@ -154,9 +144,7 @@ static void __init parse_dt_topology(void)
 =09 * SCHED_POWER_SCALE, which is the default value, but with the
 =09 * constraint explained near table_efficiency[].
 =09 */
-=09if (min_capacity =3D=3D max_capacity)
-=09=09cpu_capacity[0].hwid =3D (unsigned long)(-1);
-=09else if (4*max_capacity < (3*(max_capacity + min_capacity)))
+=09if (4*max_capacity < (3*(max_capacity + min_capacity)))
 =09=09middle_capacity =3D (min_capacity + max_capacity)
 =09=09=09=09>> (SCHED_POWER_SHIFT+1);
 =09else
@@ -170,23 +158,12 @@ static void __init parse_dt_topology(void)
  * boot. The update of all CPUs is in O(n^2) for heteregeneous system but =
the
  * function returns directly for SMP system.
  */
-void update_cpu_power(unsigned int cpu, unsigned long hwid)
+void update_cpu_power(unsigned int cpu)
 {
-=09unsigned int idx =3D 0;
-
-=09/* look for the cpu's hwid in the cpu capacity table */
-=09for (idx =3D 0; idx < num_possible_cpus(); idx++) {
-=09=09if (cpu_capacity[idx].hwid =3D=3D hwid)
-=09=09=09break;
-
-=09=09if (cpu_capacity[idx].hwid =3D=3D -1)
-=09=09=09return;
-=09}
-
-=09if (idx =3D=3D num_possible_cpus())
+=09if (!cpu_capacity(cpu))
 =09=09return;
=20
-=09set_power_scale(cpu, cpu_capacity[idx].capacity / middle_capacity);
+=09set_power_scale(cpu, cpu_capacity(cpu) / middle_capacity);
=20
 =09printk(KERN_INFO "CPU%u: update cpu_power %lu\n",
 =09=09cpu, arch_scale_freq_power(NULL, cpu));
@@ -194,7 +171,7 @@ void update_cpu_power(unsigned int cpu, unsigned long h=
wid)
=20
 #else
 static inline void parse_dt_topology(void) {}
-static inline void update_cpu_power(unsigned int cpuid, unsigned int mpidr=
) {}
+static inline void update_cpu_power(unsigned int cpuid) {}
 #endif
=20
  /*
@@ -281,7 +258,7 @@ void store_cpu_topology(unsigned int cpuid)
=20
 =09update_siblings_masks(cpuid);
=20
-=09update_cpu_power(cpuid, mpidr & MPIDR_HWID_BITMASK);
+=09update_cpu_power(cpuid);
=20
 =09printk(KERN_INFO "CPU%u: thread %d, cpu %d, socket %d, mpidr %x\n",
 =09=09cpuid, cpu_topology[cpuid].thread_id,
--=20
1.8.1.2


