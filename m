From: Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH 4/7] turbostat: track thread ID in cpu_topology
Date: Fri, 28 Jul 2017 08:06:18 -0400
Message-ID: <1501243581-31491-6-git-send-email-prarit@redhat.com>
References: <1501243581-31491-1-git-send-email-prarit@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34426 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751737AbdG1MGh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 28 Jul 2017 08:06:37 -0400
In-Reply-To: <1501243581-31491-1-git-send-email-prarit@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: lenb@kernel.org, Prarit Bhargava <prarit@redhat.com>, Len Brown <len.brown@intel.com>

The code can be simplified if the cpu_topology *cpus tracks the thread
IDs.  This removes an additional file lookup and simplifies the counter
initialization code.

Add thread ID to cpu_topology information and cleanup the counter
initialization code.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Cc: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 81 +++++++++--------------------------
 1 file changed, 21 insertions(+), 60 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 696ced1974c5..124d9fbbaab6 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -252,6 +252,7 @@ struct cpu_topology {
 	int physical_node_id;
 	int logical_node_id;	/* 0-based count within the package */
 	int physical_core_id;
+	int thread_id;
 	cpu_set_t *put_ids; /* Processing Unit/Thread IDs */
 } *cpus;
 
@@ -2263,44 +2264,6 @@ int parse_int_file(const char *fmt, ...)
 }
 
 /*
- * get_cpu_position_in_core(cpu)
- * return the position of the CPU among its HT siblings in the core
- * return -1 if the sibling is not in list
- */
-int get_cpu_position_in_core(int cpu)
-{
-	char path[64];
-	FILE *filep;
-	int this_cpu;
-	char character;
-	int i;
-
-	sprintf(path,
-		"/sys/devices/system/cpu/cpu%d/topology/thread_siblings_list",
-		cpu);
-	filep = fopen(path, "r");
-	if (filep == NULL) {
-		perror(path);
-		exit(1);
-	}
-
-	for (i = 0; i < topo.num_threads_per_core; i++) {
-		fscanf(filep, "%d", &this_cpu);
-		if (this_cpu == cpu) {
-			fclose(filep);
-			return i;
-		}
-
-		/* Account for no separator after last thread*/
-		if (i != (topo.num_threads_per_core - 1))
-			fscanf(filep, "%c", &character);
-	}
-
-	fclose(filep);
-	return -1;
-}
-
-/*
  * cpu_is_first_core_in_package(cpu)
  * return 1 if given CPU is 1st core in package
  */
@@ -2392,8 +2355,10 @@ int get_thread_siblings(struct cpu_topology *thiscpu)
 	int shift, sib_core;
 	int cpu = thiscpu->logical_cpu_id;
 	int offset = topo.max_cpu_num + 1;
+	int thread_id = 0;
 
 	thiscpu->put_ids = CPU_ALLOC((topo.max_cpu_num + 1));
+	thiscpu->thread_id = thread_id++;
 	if (!thiscpu->put_ids)
 		return -1;
 	CPU_ZERO(thiscpu->put_ids);
@@ -2406,9 +2371,12 @@ int get_thread_siblings(struct cpu_topology *thiscpu)
 		for (shift = 0; shift < BITMASK_SIZE; shift++) {
 			if ((map >> shift) & 0x1) {
 				sib_core = get_core_id(shift + offset);
-				if (sib_core == thiscpu->physical_core_id)
+				if (sib_core == thiscpu->physical_core_id) {
 					CPU_SET(shift + offset,
 						thiscpu->put_ids);
+					if ((shift + offset) != cpu)
+						cpus[shift + offset].thread_id = thread_id++;
+				}
 			}
 		}
 	} while (!strncmp(&character, ",", 1));
@@ -4485,6 +4453,8 @@ void topology_probe()
 		cpus[i].physical_core_id = get_core_id(i);
 		if (cpus[i].physical_core_id > max_core_id)
 			max_core_id = cpus[i].physical_core_id;
+		if (!cpus[i].thread_id)
+			topo.num_cores++;
 
 		/* get thread information */
 		siblings = get_thread_siblings(&cpus[i]);
@@ -4557,47 +4527,38 @@ void topology_probe()
 /*
  * init_counter()
  *
- * set cpu_id, core_num, pkg_num
  * set FIRST_THREAD_IN_CORE and FIRST_CORE_IN_PACKAGE
- *
- * increment topo.num_cores when 1st core in pkg seen
  */
 void init_counter(struct thread_data *thread_base, struct core_data *core_base,
-	struct pkg_data *pkg_base, int thread_num, int core_num,
-	int pkg_num, int cpu_id)
+	struct pkg_data *pkg_base, int cpu_id)
 {
+	int pkg_id = cpus[cpu_id].physical_package_id;
+	int core_id = cpus[cpu_id].physical_core_id;
+	int thread_id = cpus[cpu_id].thread_id;
 	struct thread_data *t;
 	struct core_data *c;
 	struct pkg_data *p;
 
-	t = GET_THREAD(thread_base, thread_num, core_num, pkg_num);
-	c = GET_CORE(core_base, core_num, pkg_num);
-	p = GET_PKG(pkg_base, pkg_num);
+	t = GET_THREAD(thread_base, thread_id, core_id, pkg_id);
+	c = GET_CORE(core_base, core_id, pkg_id);
+	p = GET_PKG(pkg_base, pkg_id);
 
 	t->cpu_id = cpu_id;
-	if (thread_num == 0) {
+	if (thread_id == 0) {
 		t->flags |= CPU_IS_FIRST_THREAD_IN_CORE;
 		if (cpu_is_first_core_in_package(cpu_id))
 			t->flags |= CPU_IS_FIRST_CORE_IN_PACKAGE;
 	}
 
-	c->core_id = core_num;
-	p->package_id = pkg_num;
+	c->core_id = core_id;
+	p->package_id = pkg_id;
 }
 
 
 int initialize_counters(int cpu_id)
 {
-	int my_thread_id, my_core_id, my_package_id;
-
-	my_package_id = get_physical_package_id(cpu_id);
-	my_core_id = get_core_id(cpu_id);
-	my_thread_id = get_cpu_position_in_core(cpu_id);
-	if (!my_thread_id)
-		topo.num_cores++;
-
-	init_counter(EVEN_COUNTERS, my_thread_id, my_core_id, my_package_id, cpu_id);
-	init_counter(ODD_COUNTERS, my_thread_id, my_core_id, my_package_id, cpu_id);
+	init_counter(EVEN_COUNTERS, cpu_id);
+	init_counter(ODD_COUNTERS, cpu_id);
 	return 0;
 }
 
-- 
1.8.5.5
