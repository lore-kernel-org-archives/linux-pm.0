From: Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v4 6/9] ACPI/PPTT: Add topology parsing code
Date: Thu,  9 Nov 2017 15:03:08 -0600
Message-ID: <20171109210311.25655-7-jeremy.linton@arm.com>
References: <20171109210311.25655-1-jeremy.linton@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171109210311.25655-1-jeremy.linton@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, sudeep.holla@arm.com, hanjun.guo@linaro.org, lorenzo.pieralisi@arm.com, rjw@rjwysocki.net, will.deacon@arm.com, catalin.marinas@arm.com, gregkh@linuxfoundation.org, viresh.kumar@linaro.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, jhugo@codeaurora.org, wangxiongfeng2@huawei.com, Jonathan.Zhang@cavium.com, ahs3@redhat.com, Jayachandran.Nair@cavium.com, austinwc@codeaurora.org, lenb@kernel.org, robert.moore@intel.com, lv.zheng@intel.com, devel@acpica.org, Jeremy Linton <jeremy.linton@arm.com>
List-Id: linux-pm@vger.kernel.org

The PPTT can be used to determine the groupings of CPU's at
given levels in the system. Lets add a few routines to the PPTT
parsing code to return a unique id for each unique level in the
processor hierarchy. This can then be matched to build
thread/core/cluster/die/package/etc mappings for each processing
element in the system.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 drivers/acpi/pptt.c | 117 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 117 insertions(+)

diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
index aa259502c4eb..b629d0b9a3a0 100644
--- a/drivers/acpi/pptt.c
+++ b/drivers/acpi/pptt.c
@@ -388,6 +388,81 @@ static void cache_setup_acpi_cpu(struct acpi_table_header *table,
 	}
 }
 
+/*
+ * Passing level values greater than this will result in search termination
+ */
+#define PPTT_ABORT_PACKAGE 0xFF
+
+/*
+ * Given a acpi_pptt_processor node, walk up until we identify the
+ * package that the node is associated with, or we run out of levels
+ * to request or the search is terminated with a flag match
+ * The level parameter also serves to limit possible loops within the tree.
+ */
+static struct acpi_pptt_processor *acpi_find_processor_package_id(
+	struct acpi_table_header *table_hdr,
+	struct acpi_pptt_processor *cpu,
+	int level, int flag)
+{
+	struct acpi_pptt_processor *prev_node;
+
+	while (cpu && level) {
+		if (cpu->flags & flag)
+			break;
+		pr_debug("level %d\n", level);
+		prev_node = fetch_pptt_node(table_hdr, cpu->parent);
+		if (prev_node == NULL)
+			break;
+		cpu = prev_node;
+		level--;
+	}
+	return cpu;
+}
+
+/*
+ * Get a unique value given a cpu, and a topology level, that can be
+ * matched to determine which cpus share common topological features
+ * at that level.
+ */
+static int topology_get_acpi_cpu_tag(struct acpi_table_header *table,
+				     unsigned int cpu, int level, int flag)
+{
+	struct acpi_pptt_processor *cpu_node;
+	u32 acpi_cpu_id = get_acpi_id_for_cpu(cpu);
+
+	cpu_node = acpi_find_processor_node(table, acpi_cpu_id);
+	if (cpu_node) {
+		cpu_node = acpi_find_processor_package_id(table, cpu_node,
+							  level, flag);
+		/* Only the first level has a guaranteed id */
+		if (level == 0)
+			return cpu_node->acpi_processor_id;
+		return (int)((u8 *)cpu_node - (u8 *)table);
+	}
+	pr_err_once("PPTT table found, but unable to locate core for %d\n",
+		    cpu);
+	return -ENOENT;
+}
+
+static int find_acpi_cpu_topology_tag(unsigned int cpu, int level, int flag)
+{
+	struct acpi_table_header *table;
+	acpi_status status;
+	int retval;
+
+	status = acpi_get_table(ACPI_SIG_PPTT, 0, &table);
+	if (ACPI_FAILURE(status)) {
+		pr_err_once("No PPTT table found, cpu topology may be inaccurate\n");
+		return -ENOENT;
+	}
+	retval = topology_get_acpi_cpu_tag(table, cpu, level, flag);
+	pr_debug("Topology Setup ACPI cpu %d, level %d ret = %d\n",
+		 cpu, level, retval);
+	acpi_put_table(table);
+
+	return retval;
+}
+
 /**
  * acpi_find_last_cache_level() - Determines the number of cache levels for a PE
  * @cpu: Kernel logical cpu number
@@ -451,3 +526,45 @@ int cache_setup_acpi(unsigned int cpu)
 
 	return status;
 }
+
+/**
+ * find_acpi_cpu_topology() - Determine a unique topology value for a given cpu
+ * @cpu: Kernel logical cpu number
+ * @level: The topological level for which we would like a unique ID
+ *
+ * Determine a topology unique ID for each thread/core/cluster/mc_grouping
+ * /socket/etc. This ID can then be used to group peers, which will have
+ * matching ids.
+ *
+ * The search terminates when either the requested level is found or
+ * we reach a root node. Levels beyond the termination point will return the
+ * same unique ID. The unique id for level 0 is the acpi processor id. All
+ * other levels beyond this use a generated value to uniquely identify
+ * a topological feature.
+ *
+ * Return: -ENOENT if the PPTT doesn't exist, or the cpu cannot be found.
+ * Otherwise returns a value which represents a unique topological feature.
+ */
+int find_acpi_cpu_topology(unsigned int cpu, int level)
+{
+	return find_acpi_cpu_topology_tag(cpu, level, 0);
+}
+
+/**
+ * find_acpi_cpu_topology_package() - Determine a unique cpu package value
+ * @cpu: Kernel logical cpu number
+ *
+ * Determine a topology unique package ID for the given cpu.
+ * This ID can then be used to group peers, which will have matching ids.
+ *
+ * The search terminates when either a level is found with the PHYSICAL_PACKAGE
+ * flag set or we reach a root node.
+ *
+ * Return: -ENOENT if the PPTT doesn't exist, or the cpu cannot be found.
+ * Otherwise returns a value which represents the package for this cpu.
+ */
+int find_acpi_cpu_topology_package(unsigned int cpu)
+{
+	return find_acpi_cpu_topology_tag(cpu, PPTT_ABORT_PACKAGE,
+					  ACPI_PPTT_PHYSICAL_PACKAGE);
+}
-- 
2.13.5
