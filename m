From: Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH 2/8 v2 RESEND] turbostat: Fix node and siblings lookup data
Date: Fri, 15 Sep 2017 09:15:32 -0400
Message-ID: <1505481338-19770-3-git-send-email-prarit@redhat.com>
References: <1505481338-19770-1-git-send-email-prarit@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37477 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751207AbdIONPm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 15 Sep 2017 09:15:42 -0400
In-Reply-To: <1505481338-19770-1-git-send-email-prarit@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Prarit Bhargava <prarit@redhat.com>, Len Brown <len.brown@intel.com>

The turbostat code only looks at thread_siblings_list to determine if
processing units/threads are on the same the core.  This works well on
Intel systems which have a shared L1 instruction and data cache.  This
does not work on AMD systems which have shared L1 instruction cache but
separate L1 data caches.  Other utilities also check sibling's core ID
to determine if the processing unit shares the same core.

Additionally, the cpu_topology *cpus list used in topology_probe() can
be used elsewhere in the code to simplify things.

Export *cpus to the entire turbostat code, and add Processing Unit/Thread
IDs information to each cpu_topology struct.  Confirm that the thread
is on the same core as indicated by thread_siblings_list.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Cc: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 114 +++++++++++++++++++++++-----------
 1 file changed, 79 insertions(+), 35 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 6135aa99f8ad..33d35e19164d 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -149,6 +149,7 @@
 cpu_set_t *cpu_present_set, *cpu_affinity_set, *cpu_subset;
 size_t cpu_present_setsize, cpu_affinity_setsize, cpu_subset_size;
 #define MAX_ADDED_COUNTERS 16
+#define BITMASK_SIZE 32
 
 struct thread_data {
 	struct timeval tv_begin;
@@ -245,6 +246,13 @@ struct system_summary {
 	struct pkg_data packages;
 } average;
 
+struct cpu_topology {
+	int physical_package_id;
+	int logical_cpu_id;
+	int node_id;
+	int physical_core_id;
+	cpu_set_t *put_ids; /* Processing Unit/Thread IDs */
+} *cpus;
 
 struct topo_params {
 	int num_packages;
@@ -2188,6 +2196,8 @@ void free_fd_percpu(void)
 
 void free_all_buffers(void)
 {
+	int i;
+
 	CPU_FREE(cpu_present_set);
 	cpu_present_set = NULL;
 	cpu_present_setsize = 0;
@@ -2220,6 +2230,12 @@ void free_all_buffers(void)
 
 	free(irq_column_2_cpu);
 	free(irqs_per_cpu);
+
+	for (i = 0; i <= topo.max_cpu_num; ++i) {
+		if (cpus[i].put_ids)
+			CPU_FREE(cpus[i].put_ids);
+	}
+	free(cpus);
 }
 
 
@@ -2300,35 +2316,57 @@ int get_core_id(int cpu)
 	return parse_int_file("/sys/devices/system/cpu/cpu%d/topology/core_id", cpu);
 }
 
-int get_num_ht_siblings(int cpu)
+int get_node_id(struct cpu_topology *thiscpu)
 {
 	char path[80];
 	FILE *filep;
-	int sib1;
-	int matches = 0;
-	char character;
-	char str[100];
-	char *ch;
-
-	sprintf(path, "/sys/devices/system/cpu/cpu%d/topology/thread_siblings_list", cpu);
-	filep = fopen_or_die(path, "r");
+	int i;
+	int cpu = thiscpu->logical_cpu_id;
 
-	/*
-	 * file format:
-	 * A ',' separated or '-' separated set of numbers
-	 * (eg 1-2 or 1,3,4,5)
-	 */
-	fscanf(filep, "%d%c\n", &sib1, &character);
-	fseek(filep, 0, SEEK_SET);
-	fgets(str, 100, filep);
-	ch = strchr(str, character);
-	while (ch != NULL) {
-		matches++;
-		ch = strchr(ch+1, character);
+	for (i = 0; i <= topo.max_cpu_num; i++) {
+		sprintf(path, "/sys/devices/system/cpu/cpu%d/node%i/cpulist",
+			cpu, i);
+		filep = fopen(path, "r");
+		if (!filep)
+			continue;
+		fclose(filep);
+		return i;
 	}
+	return -1;
+}
 
+int get_thread_siblings(struct cpu_topology *thiscpu)
+{
+	char path[80], character;
+	FILE *filep;
+	unsigned long map;
+	int shift, sib_core;
+	int cpu = thiscpu->logical_cpu_id;
+	int offset = topo.max_cpu_num + 1;
+
+	thiscpu->put_ids = CPU_ALLOC((topo.max_cpu_num + 1));
+	if (!thiscpu->put_ids)
+		return -1;
+	CPU_ZERO(thiscpu->put_ids);
+
+	sprintf(path,
+		"/sys/devices/system/cpu/cpu%d/topology/thread_siblings", cpu);
+	filep = fopen_or_die(path, "r");
+	do {
+		offset -= BITMASK_SIZE;
+		fscanf(filep, "%lx%c", &map, &character);
+		for (shift = 0; shift < BITMASK_SIZE; shift++) {
+			if ((map >> shift) & 0x1) {
+				sib_core = get_core_id(shift + offset);
+				if (sib_core == thiscpu->physical_core_id)
+					CPU_SET(shift + offset,
+						thiscpu->put_ids);
+			}
+		}
+	} while (!strncmp(&character, ",", 1));
 	fclose(filep);
-	return matches+1;
+
+	return CPU_COUNT(thiscpu->put_ids);
 }
 
 /*
@@ -2423,7 +2461,7 @@ void set_max_cpu_num(void)
 			"/sys/devices/system/cpu/cpu0/topology/thread_siblings",
 			"r");
 	while (fscanf(filep, "%lx,", &dummy) == 1)
-		topo.max_cpu_num += 32;
+		topo.max_cpu_num += BITMASK_SIZE;
 	fclose(filep);
 	topo.max_cpu_num--; /* 0 based */
 }
@@ -4325,10 +4363,6 @@ void topology_probe()
 	int max_core_id = 0;
 	int max_package_id = 0;
 	int max_siblings = 0;
-	struct cpu_topology {
-		int core_id;
-		int physical_package_id;
-	} *cpus;
 
 	/* Initialize num_cpus, max_cpu_num */
 	set_max_cpu_num();
@@ -4385,20 +4419,32 @@ void topology_probe()
 				fprintf(outf, "cpu%d NOT PRESENT\n", i);
 			continue;
 		}
-		cpus[i].core_id = get_core_id(i);
-		if (cpus[i].core_id > max_core_id)
-			max_core_id = cpus[i].core_id;
 
+		cpus[i].logical_cpu_id = i;
+
+		/* get package information */
 		cpus[i].physical_package_id = get_physical_package_id(i);
 		if (cpus[i].physical_package_id > max_package_id)
 			max_package_id = cpus[i].physical_package_id;
 
-		siblings = get_num_ht_siblings(i);
+		/* get numa node information */
+		cpus[i].node_id = get_node_id(&cpus[i]);
+
+		/* get core information */
+		cpus[i].physical_core_id = get_core_id(i);
+		if (cpus[i].physical_core_id > max_core_id)
+			max_core_id = cpus[i].physical_core_id;
+
+		/* get thread information */
+		siblings = get_thread_siblings(&cpus[i]);
 		if (siblings > max_siblings)
 			max_siblings = siblings;
+
 		if (debug > 1)
-			fprintf(outf, "cpu %d pkg %d core %d\n",
-				i, cpus[i].physical_package_id, cpus[i].core_id);
+			fprintf(outf, "cpu %d pkg %d node %d core %d\n",
+				i, cpus[i].physical_package_id,
+				cpus[i].node_id,
+				cpus[i].physical_core_id);
 	}
 	topo.num_cores_per_pkg = max_core_id + 1;
 	if (debug > 1)
@@ -4417,8 +4463,6 @@ void topology_probe()
 	topo.num_threads_per_core = max_siblings;
 	if (debug > 1)
 		fprintf(outf, "max_siblings %d\n", max_siblings);
-
-	free(cpus);
 }
 
 void
-- 
1.8.5.5
