From: Sudeep.KarkadaNagesha-5wv7dgnIgG8@public.gmane.org
Subject: [RFC PATCH v2 04/15] ARM: topology: remove hwid/MPIDR dependency from
 cpu_capacity
Date: Wed, 17 Jul 2013 15:06:13 +0100
Message-ID: <1374069984-20567-5-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1374069984-20567-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1374069984-20567-1-git-send-email-Sudeep.KarkadaNagesha-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, cpufreq-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

From: Sudeep KarkadaNagesha <sudeep.karkadanagesha-5wv7dgnIgG8@public.gmane.org>

Currently the topology code computes cpu capacity and stores it in
the list along with hwid(which is MPIDR) as it parses the CPU nodes
in the device tree. This is required as it needs to be mapped to the
logical CPU later.

Since the CPU device nodes can be retrieved in the logical ordering
using DT/OF helpers, its possible to store cpu_capacity also in logical
ordering and avoid storing hwid for each entry.

This patch removes hwid by making use of of_get_cpu_node.

Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha-5wv7dgnIgG8@public.gmane.org>
---
 arch/arm/kernel/topology.c | 61 +++++++++++++++-------------------------------
 1 file changed, 19 insertions(+), 42 deletions(-)

diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index c5a5954..28ef27a 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -74,12 +74,8 @@ struct cpu_efficiency table_efficiency[] = {
 	{NULL, },
 };
 
-struct cpu_capacity {
-	unsigned long hwid;
-	unsigned long capacity;
-};
-
-struct cpu_capacity *cpu_capacity;
+unsigned long *__cpu_capacity;
+#define cpu_capacity(cpu)	__cpu_capacity[cpu]
 
 unsigned long middle_capacity = 1;
 
@@ -100,15 +96,19 @@ static void __init parse_dt_topology(void)
 	unsigned long capacity = 0;
 	int alloc_size, cpu = 0;
 
-	alloc_size = nr_cpu_ids * sizeof(struct cpu_capacity);
-	cpu_capacity = kzalloc(alloc_size, GFP_NOWAIT);
+	alloc_size = nr_cpu_ids * sizeof(*__cpu_capacity);
+	__cpu_capacity = kzalloc(alloc_size, GFP_NOWAIT);
 
-	while ((cn = of_find_node_by_type(cn, "cpu"))) {
-		const u32 *rate, *reg;
+	for_each_possible_cpu(cpu) {
+		const u32 *rate;
 		int len;
 
-		if (cpu >= num_possible_cpus())
-			break;
+		/* too early to use cpu->of_node */
+		cn = of_get_cpu_node(cpu);
+		if (!cn) {
+			pr_err("missing device node for CPU %d\n", cpu);
+			continue;
+		}
 
 		for (cpu_eff = table_efficiency; cpu_eff->compatible; cpu_eff++)
 			if (of_device_is_compatible(cn, cpu_eff->compatible))
@@ -124,12 +124,6 @@ static void __init parse_dt_topology(void)
 			continue;
 		}
 
-		reg = of_get_property(cn, "reg", &len);
-		if (!reg || len != 4) {
-			pr_err("%s missing reg property\n", cn->full_name);
-			continue;
-		}
-
 		capacity = ((be32_to_cpup(rate)) >> 20) * cpu_eff->efficiency;
 
 		/* Save min capacity of the system */
@@ -140,13 +134,9 @@ static void __init parse_dt_topology(void)
 		if (capacity > max_capacity)
 			max_capacity = capacity;
 
-		cpu_capacity[cpu].capacity = capacity;
-		cpu_capacity[cpu++].hwid = be32_to_cpup(reg);
+		cpu_capacity(cpu) = capacity;
 	}
 
-	if (cpu < num_possible_cpus())
-		cpu_capacity[cpu].hwid = (unsigned long)(-1);
-
 	/* If min and max capacities are equals, we bypass the update of the
 	 * cpu_scale because all CPUs have the same capacity. Otherwise, we
 	 * compute a middle_capacity factor that will ensure that the capacity
@@ -154,9 +144,7 @@ static void __init parse_dt_topology(void)
 	 * SCHED_POWER_SCALE, which is the default value, but with the
 	 * constraint explained near table_efficiency[].
 	 */
-	if (min_capacity == max_capacity)
-		cpu_capacity[0].hwid = (unsigned long)(-1);
-	else if (4*max_capacity < (3*(max_capacity + min_capacity)))
+	if (4*max_capacity < (3*(max_capacity + min_capacity)))
 		middle_capacity = (min_capacity + max_capacity)
 				>> (SCHED_POWER_SHIFT+1);
 	else
@@ -170,23 +158,12 @@ static void __init parse_dt_topology(void)
  * boot. The update of all CPUs is in O(n^2) for heteregeneous system but the
  * function returns directly for SMP system.
  */
-void update_cpu_power(unsigned int cpu, unsigned long hwid)
+void update_cpu_power(unsigned int cpu)
 {
-	unsigned int idx = 0;
-
-	/* look for the cpu's hwid in the cpu capacity table */
-	for (idx = 0; idx < num_possible_cpus(); idx++) {
-		if (cpu_capacity[idx].hwid == hwid)
-			break;
-
-		if (cpu_capacity[idx].hwid == -1)
-			return;
-	}
-
-	if (idx == num_possible_cpus())
+	if (!cpu_capacity(cpu))
 		return;
 
-	set_power_scale(cpu, cpu_capacity[idx].capacity / middle_capacity);
+	set_power_scale(cpu, cpu_capacity(cpu) / middle_capacity);
 
 	printk(KERN_INFO "CPU%u: update cpu_power %lu\n",
 		cpu, arch_scale_freq_power(NULL, cpu));
@@ -194,7 +171,7 @@ void update_cpu_power(unsigned int cpu, unsigned long hwid)
 
 #else
 static inline void parse_dt_topology(void) {}
-static inline void update_cpu_power(unsigned int cpuid, unsigned int mpidr) {}
+static inline void update_cpu_power(unsigned int cpuid) {}
 #endif
 
  /*
@@ -281,7 +258,7 @@ void store_cpu_topology(unsigned int cpuid)
 
 	update_siblings_masks(cpuid);
 
-	update_cpu_power(cpuid, mpidr & MPIDR_HWID_BITMASK);
+	update_cpu_power(cpuid);
 
 	printk(KERN_INFO "CPU%u: thread %d, cpu %d, socket %d, mpidr %x\n",
 		cpuid, cpu_topology[cpuid].thread_id,
-- 
1.8.1.2
