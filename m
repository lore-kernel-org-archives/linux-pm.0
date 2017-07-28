From: Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH 3/7] turbostat: Calculate additional node information for a package
Date: Fri, 28 Jul 2017 08:06:17 -0400
Message-ID: <1501243581-31491-5-git-send-email-prarit@redhat.com>
References: <1501243581-31491-1-git-send-email-prarit@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47378 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751722AbdG1MGg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 28 Jul 2017 08:06:36 -0400
In-Reply-To: <1501243581-31491-1-git-send-email-prarit@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: lenb@kernel.org, Prarit Bhargava <prarit@redhat.com>, Len Brown <len.brown@intel.com>

The code currently assumes each package has exactly one node.  This is not
the case for AMD systems and Intel systems with COD.  AMD systems also
may re-enumerate each node's core IDs starting at 0 (for example, an AMD
processor may have two nodes, each with core IDs from 0 to 7).  In order
to properly enumerate the cores we need to track both the physical and
logical node IDs.

Add physical_node_id to track the node ID assigned by the kernel, and
logical_node_id used by turbostat to track the nodes per package ie) a 0-based
count within the package.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Cc: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 66 ++++++++++++++++++++++++++++++++---
 1 file changed, 62 insertions(+), 4 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 5f66988b0303..696ced1974c5 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -249,7 +249,8 @@ struct system_summary {
 struct cpu_topology {
 	int physical_package_id;
 	int logical_cpu_id;
-	int node_id;
+	int physical_node_id;
+	int logical_node_id;	/* 0-based count within the package */
 	int physical_core_id;
 	cpu_set_t *put_ids; /* Processing Unit/Thread IDs */
 } *cpus;
@@ -259,6 +260,8 @@ struct topo_params {
 	int num_cpus;
 	int num_cores;
 	int max_cpu_num;
+	int max_node_num;
+	int num_nodes_per_pkg;
 	int num_cores_per_pkg;
 	int num_threads_per_core;
 } topo;
@@ -2316,7 +2319,54 @@ int get_core_id(int cpu)
 	return parse_int_file("/sys/devices/system/cpu/cpu%d/topology/core_id", cpu);
 }
 
-int get_node_id(struct cpu_topology *thiscpu)
+void set_node_data(void)
+{
+	char path[80];
+	FILE *filep;
+	int pkg, node, cpu;
+
+	struct pkg_node_info {
+		int count;
+		int min;
+	} *pni;
+
+	pni = calloc(topo.num_packages, sizeof(struct pkg_node_info));
+	if (!pni)
+		err(1, "calloc pkg_node_count");
+
+	for (pkg = 0; pkg < topo.num_packages; pkg++)
+		pni[pkg].min = topo.num_cpus;
+
+	for (node = 0; node <= topo.max_node_num; node++) {
+		/* find the "first" cpu in the node */
+		sprintf(path, "/sys/bus/node/devices/node%d/cpulist", node);
+		filep = fopen(path, "r");
+		if (!filep)
+			continue;
+		fscanf(filep, "%d", &cpu);
+		fclose(filep);
+
+		pkg = cpus[cpu].physical_package_id;
+		pni[pkg].count++;
+
+		if (node < pni[pkg].min)
+			pni[pkg].min = node;
+	}
+
+	for (pkg = 0; pkg < topo.num_packages; pkg++)
+		if (pni[pkg].count > topo.num_nodes_per_pkg)
+			topo.num_nodes_per_pkg = pni[0].count;
+
+	for (cpu = 0; cpu < topo.num_cpus; cpu++) {
+		pkg = cpus[cpu].physical_package_id;
+		node = cpus[cpu].physical_node_id;
+		cpus[cpu].logical_node_id = node - pni[pkg].min;
+	}
+	free(pni);
+
+}
+
+int get_physical_node_id(struct cpu_topology *thiscpu)
 {
 	char path[80];
 	FILE *filep;
@@ -4361,6 +4411,7 @@ void topology_probe()
 	int max_core_id = 0;
 	int max_package_id = 0;
 	int max_siblings = 0;
+	int max_physical_node_id = 0;
 
 	/* Initialize num_cpus, max_cpu_num */
 	set_max_cpu_num();
@@ -4426,7 +4477,9 @@ void topology_probe()
 			max_package_id = cpus[i].physical_package_id;
 
 		/* get numa node information */
-		cpus[i].node_id = get_node_id(&cpus[i]);
+		cpus[i].physical_node_id = get_physical_node_id(&cpus[i]);
+		if (cpus[i].physical_node_id > max_physical_node_id)
+			topo.max_node_num = cpus[i].physical_node_id;
 
 		/* get core information */
 		cpus[i].physical_core_id = get_core_id(i);
@@ -4441,9 +4494,10 @@ void topology_probe()
 		if (debug > 1)
 			fprintf(outf, "cpu %d pkg %d node %d core %d\n",
 				i, cpus[i].physical_package_id,
-				cpus[i].node_id,
+				cpus[i].physical_node_id,
 				cpus[i].physical_core_id);
 	}
+
 	topo.num_cores_per_pkg = max_core_id + 1;
 	if (debug > 1)
 		fprintf(outf, "max_core_id %d, sizing for %d cores per package\n",
@@ -4458,6 +4512,10 @@ void topology_probe()
 	if (!summary_only && topo.num_packages > 1)
 		BIC_PRESENT(BIC_Package);
 
+	set_node_data();
+	if (debug > 1)
+		fprintf(outf, "num_nodes_per_pkg %d\n", topo.num_nodes_per_pkg);
+
 	topo.num_threads_per_core = max_siblings;
 	if (debug > 1)
 		fprintf(outf, "max_siblings %d\n", max_siblings);
-- 
1.8.5.5
