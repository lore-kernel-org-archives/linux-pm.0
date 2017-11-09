From: Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v4 8/9] arm64: topology: Enable ACPI/PPTT based CPU topology.
Date: Thu,  9 Nov 2017 15:03:10 -0600
Message-ID: <20171109210311.25655-9-jeremy.linton@arm.com>
References: <20171109210311.25655-1-jeremy.linton@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171109210311.25655-1-jeremy.linton@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, sudeep.holla@arm.com, hanjun.guo@linaro.org, lorenzo.pieralisi@arm.com, rjw@rjwysocki.net, will.deacon@arm.com, catalin.marinas@arm.com, gregkh@linuxfoundation.org, viresh.kumar@linaro.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, jhugo@codeaurora.org, wangxiongfeng2@huawei.com, Jonathan.Zhang@cavium.com, ahs3@redhat.com, Jayachandran.Nair@cavium.com, austinwc@codeaurora.org, lenb@kernel.org, robert.moore@intel.com, lv.zheng@intel.com, devel@acpica.org, Jeremy Linton <jeremy.linton@arm.com>
List-Id: linux-pm@vger.kernel.org

Propagate the topology information from the PPTT tree to the
cpu_topology array. We can get the thread id, core_id and
cluster_id by assuming certain levels of the PPTT tree correspond
to those concepts. The package_id is flagged in the tree and can be
found by passing an arbitrary large level to setup_acpi_cpu_topology()
which terminates its search when it finds an ACPI node flagged
as the physical package. If the tree doesn't contain enough
levels to represent all of thread/core/cod/package then the package
id will be used for the missing levels.

Since server/ACPI machines are more likely to be multisocket and NUMA,
this patch also modifies the default clusters=sockets behavior
for ACPI machines to sockets=sockets. DT machines continue to
represent sockets as clusters. For ACPI machines, this results in a
more normalized view of the topology. Cluster level scheduler decisions
are still being made due to the "MC" level in the scheduler which has
knowledge of cache sharing domains.

This code is loosely based on a combination of code from:
Xiongfeng Wang <wangxiongfeng2@huawei.com>
John Garry <john.garry@huawei.com>
Jeffrey Hugo <jhugo@codeaurora.org>

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/kernel/topology.c | 47 +++++++++++++++++++++++++++++++++++++++++++-
 include/linux/topology.h     |  2 ++
 2 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 74a8a5173a35..198714aca9e8 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -11,6 +11,7 @@
  * for more details.
  */
 
+#include <linux/acpi.h>
 #include <linux/arch_topology.h>
 #include <linux/cpu.h>
 #include <linux/cpumask.h>
@@ -22,6 +23,7 @@
 #include <linux/sched.h>
 #include <linux/sched/topology.h>
 #include <linux/slab.h>
+#include <linux/smp.h>
 #include <linux/string.h>
 
 #include <asm/cpu.h>
@@ -300,6 +302,47 @@ static void __init reset_cpu_topology(void)
 	}
 }
 
+#ifdef CONFIG_ACPI
+/*
+ * Propagate the topology information of the processor_topology_node tree to the
+ * cpu_topology array.
+ */
+static int __init parse_acpi_topology(void)
+{
+	u64 is_threaded;
+	int cpu;
+	int topology_id;
+
+	is_threaded = read_cpuid_mpidr() & MPIDR_MT_BITMASK;
+
+	for_each_possible_cpu(cpu) {
+		topology_id = find_acpi_cpu_topology(cpu, 0);
+		if (topology_id < 0)
+			return topology_id;
+
+		if (is_threaded) {
+			cpu_topology[cpu].thread_id = topology_id;
+			topology_id = find_acpi_cpu_topology(cpu, 1);
+			cpu_topology[cpu].core_id   = topology_id;
+			topology_id = find_acpi_cpu_topology_package(cpu);
+			cpu_topology[cpu].physical_id = topology_id;
+		} else {
+			cpu_topology[cpu].thread_id  = -1;
+			cpu_topology[cpu].core_id    = topology_id;
+			topology_id = find_acpi_cpu_topology_package(cpu);
+			cpu_topology[cpu].physical_id = topology_id;
+		}
+	}
+	return 0;
+}
+
+#else
+static int __init parse_acpi_topology(void)
+{
+	/*ACPI kernels should be built with PPTT support*/
+	return -EINVAL;
+}
+#endif
 
 void __init init_cpu_topology(void)
 {
@@ -309,6 +352,8 @@ void __init init_cpu_topology(void)
 	 * Discard anything that was parsed if we hit an error so we
 	 * don't use partial information.
 	 */
-	if (of_have_populated_dt() && parse_dt_topology())
+	if ((!acpi_disabled) && parse_acpi_topology())
+		reset_cpu_topology();
+	else if (of_have_populated_dt() && parse_dt_topology())
 		reset_cpu_topology();
 }
diff --git a/include/linux/topology.h b/include/linux/topology.h
index cb0775e1ee4b..170ce87edd88 100644
--- a/include/linux/topology.h
+++ b/include/linux/topology.h
@@ -43,6 +43,8 @@
 		if (nr_cpus_node(node))
 
 int arch_update_cpu_topology(void);
+int find_acpi_cpu_topology(unsigned int cpu, int level);
+int find_acpi_cpu_topology_package(unsigned int cpu);
 
 /* Conform to ACPI 2.0 SLIT distance definitions */
 #define LOCAL_DISTANCE		10
-- 
2.13.5
