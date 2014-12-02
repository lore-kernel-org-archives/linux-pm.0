From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [RFC PATCH 06/10] arm: Cpu invariant scheduler load-tracking support
Date: Tue,  2 Dec 2014 14:06:28 +0000
Message-ID: <1417529192-11579-7-git-send-email-morten.rasmussen@arm.com>
References: <1417529192-11579-1-git-send-email-morten.rasmussen@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1417529192-11579-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, mingo@redhat.com
Cc: dietmar.eggemann@arm.com, vincent.guittot@linaro.org, pjt@google.com, bsegall@google.com, mturquette@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Russell King <linux@arm.linux.org.uk>
List-Id: linux-pm@vger.kernel.org

From: Dietmar Eggemann <dietmar.eggemann@arm.com>

Reuses the existing infrastructure for cpu_scale to provide the scheduler
with a cpu scaling correction factor for more accurate load-tracking.
This factor comprises a micro-architectural part, which is based on the
cpu efficiency value of a cpu as well as a platform-wide max frequency
part, which relates to the dtb property clock-frequency of a cpu node.

The calculation of cpu_scale, return value of arch_scale_cpu_capacity,
changes from:

    capacity / middle_capacity

    with capacity =3D (clock_frequency >> 20) * cpu_efficiency

to:

    SCHED_CAPACITY_SCALE * cpu_perf / max_cpu_perf

The range of the cpu_scale value changes from
[0..3*SCHED_CAPACITY_SCALE/2] to [0..SCHED_CAPACITY_SCALE].

The functionality to calculate the middle_capacity which corresponds to an
'average' cpu has been taken out since the scaling is now done
differently.

In the case that either the cpu efficiency or the clock-frequency value
for a cpu is missing, no cpu scaling is done for any cpu.

The platform-wide max frequency part of the factor should not be confused
with the frequency invariant scheduler load-tracking support which deals
with frequency related scaling due to DFVS functionality on a cpu.

Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 arch/arm/kernel/topology.c | 64 +++++++++++++++++-------------------------=
----
 1 file changed, 23 insertions(+), 41 deletions(-)

diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index 73ef337..e4c59fa 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -62,9 +62,7 @@ struct cpu_efficiency {
  * Table of relative efficiency of each processors
  * The efficiency value must fit in 20bit and the final
  * cpu_scale value must be in the range
- *   0 < cpu_scale < 3*SCHED_CAPACITY_SCALE/2
- * in order to return at most 1 when DIV_ROUND_CLOSEST
- * is used to compute the capacity of a CPU.
+ *   0 < cpu_scale < SCHED_CAPACITY_SCALE.
  * Processors that are not defined in the table,
  * use the default SCHED_CAPACITY_SCALE value for cpu_scale.
  */
@@ -77,24 +75,18 @@ static const struct cpu_efficiency table_efficiency[] =
=3D {
 static unsigned long *__cpu_capacity;
 #define cpu_capacity(cpu)=09__cpu_capacity[cpu]
=20
-static unsigned long middle_capacity =3D 1;
+static unsigned long max_cpu_perf;
=20
 /*
  * Iterate all CPUs' descriptor in DT and compute the efficiency
- * (as per table_efficiency). Also calculate a middle efficiency
- * as close as possible to  (max{eff_i} - min{eff_i}) / 2
- * This is later used to scale the cpu_capacity field such that an
- * 'average' CPU is of middle capacity. Also see the comments near
- * table_efficiency[] and update_cpu_capacity().
+ * (as per table_efficiency). Calculate the max cpu performance too.
  */
+
 static void __init parse_dt_topology(void)
 {
 =09const struct cpu_efficiency *cpu_eff;
 =09struct device_node *cn =3D NULL;
-=09unsigned long min_capacity =3D ULONG_MAX;
-=09unsigned long max_capacity =3D 0;
-=09unsigned long capacity =3D 0;
-=09int cpu =3D 0;
+=09int cpu =3D 0, i =3D 0;
=20
 =09__cpu_capacity =3D kcalloc(nr_cpu_ids, sizeof(*__cpu_capacity),
 =09=09=09=09 GFP_NOWAIT);
@@ -102,6 +94,7 @@ static void __init parse_dt_topology(void)
 =09for_each_possible_cpu(cpu) {
 =09=09const u32 *rate;
 =09=09int len;
+=09=09unsigned long cpu_perf;
=20
 =09=09/* too early to use cpu->of_node */
 =09=09cn =3D of_get_cpu_node(cpu, NULL);
@@ -124,46 +117,35 @@ static void __init parse_dt_topology(void)
 =09=09=09continue;
 =09=09}
=20
-=09=09capacity =3D ((be32_to_cpup(rate)) >> 20) * cpu_eff->efficiency;
-
-=09=09/* Save min capacity of the system */
-=09=09if (capacity < min_capacity)
-=09=09=09min_capacity =3D capacity;
-
-=09=09/* Save max capacity of the system */
-=09=09if (capacity > max_capacity)
-=09=09=09max_capacity =3D capacity;
-
-=09=09cpu_capacity(cpu) =3D capacity;
+=09=09cpu_perf =3D ((be32_to_cpup(rate)) >> 20) * cpu_eff->efficiency;
+=09=09cpu_capacity(cpu) =3D cpu_perf;
+=09=09max_cpu_perf =3D max(max_cpu_perf, cpu_perf);
+=09=09i++;
 =09}
=20
-=09/* If min and max capacities are equals, we bypass the update of the
-=09 * cpu_scale because all CPUs have the same capacity. Otherwise, we
-=09 * compute a middle_capacity factor that will ensure that the capacity
-=09 * of an 'average' CPU of the system will be as close as possible to
-=09 * SCHED_CAPACITY_SCALE, which is the default value, but with the
-=09 * constraint explained near table_efficiency[].
-=09 */
-=09if (4*max_capacity < (3*(max_capacity + min_capacity)))
-=09=09middle_capacity =3D (min_capacity + max_capacity)
-=09=09=09=09>> (SCHED_CAPACITY_SHIFT+1);
-=09else
-=09=09middle_capacity =3D ((max_capacity / 3)
-=09=09=09=09>> (SCHED_CAPACITY_SHIFT-1)) + 1;
-
+=09if (i < num_possible_cpus())
+=09=09max_cpu_perf =3D 0;
 }
=20
 /*
  * Look for a customed capacity of a CPU in the cpu_capacity table during =
the
  * boot. The update of all CPUs is in O(n^2) for heteregeneous system but =
the
- * function returns directly for SMP system.
+ * function returns directly for SMP systems or if there is no complete se=
t
+ * of cpu efficiency, clock frequency data for each cpu.
  */
 static void update_cpu_capacity(unsigned int cpu)
 {
-=09if (!cpu_capacity(cpu))
+=09unsigned long capacity =3D cpu_capacity(cpu);
+
+=09if (!capacity || !max_cpu_perf) {
+=09=09cpu_capacity(cpu) =3D 0;
 =09=09return;
+=09}
+
+=09capacity *=3D SCHED_CAPACITY_SCALE;
+=09capacity /=3D max_cpu_perf;
=20
-=09set_capacity_scale(cpu, cpu_capacity(cpu) / middle_capacity);
+=09set_capacity_scale(cpu, capacity);
=20
 =09printk(KERN_INFO "CPU%u: update cpu_capacity %lu\n",
 =09=09cpu, arch_scale_cpu_capacity(NULL, cpu));
--=20
1.9.1
