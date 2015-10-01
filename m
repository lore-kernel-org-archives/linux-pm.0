From: Jacob Tanenbaum <jtanenba@redhat.com>
Subject: [PATCH] Fix cpupower reporting uninitialized values for offline cpus
Date: Thu,  1 Oct 2015 15:09:44 -0400
Message-ID: <1443726584-18709-1-git-send-email-jtanenba@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58900 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752965AbbJATJ5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 1 Oct 2015 15:09:57 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: trenn@suse.com, shreyas@linux.vnet.ibm.com, rafael.j.wysock@intel.com, linux-kernel@vger.kernel.org, prarit@redhat.com, Jacob Tanenbaum <jtanenba@redhat.com>

cpupower monitor reports uninitialized values for offline cpus

[root@hp-dl980g7-02 linux]# cpupower monitor
...
5472|   0|   1|******|******|******|******||******|******|******|| 0.00|  0.00|  0.00|  0.00|  0.00 *is offline
10567|   0| 159|******|******|******|******||******|******|******||  0.00|  0.00|  0.00|  0.00|  0.00 *is offline
1661206560|859272560| 150|******|******|******|******||******|******|******|| 0.00|  0.00|  0.00|  0.00|  0.00 *is offline
1661206560|943093104| 140|******|******|******|******||******|******|******|| 0.00|  0.00|  0.00|  0.00|  0.00 *is offline

because of this cpupower also holds the incorrect value for the number
of physical packages in the machine

Changed cpupower to initialize the values of an offline cpu's socket and
core to -1, warn the user that one or more cpus is/are
offline and not print statistics for offline cpus.

Thomas Renninger suggested fixing the issue by checking for the
existence of the topology files which the code already does, so I
decided to use a check on if the cpu was online.

Example output after the patch is applied:
[root@hp-dl980g7-02 ~]# cpupower monitor
WARNING: at least one cpu is offline
              |Nehalem                    || Mperf              || Idle_Stats
PKG |CORE|CPU | C3   | C6   | PC3  | PC6  || C0   | Cx   | Freq || POLL || C1-N | C1E- | C3-N | C6-N
   0|   0|   0|  0.00| 99.37|  0.00|  0.00||  0.35| 99.65|  1596||  0.00|  0.00|  0.00|  0.00| 99.85
   0|   0|  80|  0.00| 99.37|  0.00|  0.00||  0.30| 99.70|  1645||  0.00|  0.00|  0.00|  0.00| 99.98
   0|   1|  81|  0.00| 99.53|  0.00|  0.00||  0.29| 99.71|  1655||  0.00|  0.00|  0.00|  0.00| 99.33
   0|   2|   2|  0.00| 99.47|  0.00|  0.00||  0.29| 99.71|  1660||  0.00|  0.00|  0.00|  0.00| 99.35
...

Signed-off-by: Jacob Tanenbaum <jtanenba@redhat.com>

diff --git a/tools/power/cpupower/utils/helpers/topology.c b/tools/power/cpupower/utils/helpers/topology.c
index cea398c..019a712 100644
--- a/tools/power/cpupower/utils/helpers/topology.c
+++ b/tools/power/cpupower/utils/helpers/topology.c
@@ -73,8 +73,11 @@ int get_cpu_topology(struct cpupower_topology *cpu_top)
 	for (cpu = 0; cpu < cpus; cpu++) {
 		cpu_top->core_info[cpu].cpu = cpu;
 		cpu_top->core_info[cpu].is_online = sysfs_is_cpu_online(cpu);
-		if (!cpu_top->core_info[cpu].is_online)
+		if (!cpu_top->core_info[cpu].is_online) {
+			cpu_top->core_info[cpu].pkg = -1;
+			cpu_top->core_info[cpu].core = -1;
 			continue;
+		}
 		if(sysfs_topology_read_file(
 			cpu,
 			"physical_package_id",
@@ -95,12 +98,15 @@ int get_cpu_topology(struct cpupower_topology *cpu_top)
 	   done by pkg value. */
 	last_pkg = cpu_top->core_info[0].pkg;
 	for(cpu = 1; cpu < cpus; cpu++) {
-		if(cpu_top->core_info[cpu].pkg != last_pkg) {
+		if (cpu_top->core_info[cpu].pkg != last_pkg &&
+				cpu_top->core_info[cpu].pkg != -1) {
+
 			last_pkg = cpu_top->core_info[cpu].pkg;
 			cpu_top->pkgs++;
 		}
 	}
-	cpu_top->pkgs++;
+	if (!cpu_top->core_info[0].is_online)
+		cpu_top->pkgs++;
 
 	/* Intel's cores count is not consecutively numbered, there may
 	 * be a core_id of 3, but none of 2. Assume there always is 0
diff --git a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
index c4bae92..8efc5b9 100644
--- a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
+++ b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
@@ -143,6 +143,8 @@ void print_results(int topology_depth, int cpu)
 	/* Be careful CPUs may got resorted for pkg value do not just use cpu */
 	if (!bitmask_isbitset(cpus_chosen, cpu_top.core_info[cpu].cpu))
 		return;
+	if (!cpu_top.core_info[cpu].is_online)
+		return;
 
 	if (topology_depth > 2)
 		printf("%4d|", cpu_top.core_info[cpu].pkg);
@@ -191,11 +193,7 @@ void print_results(int topology_depth, int cpu)
 	 * It's up to the monitor plug-in to check .is_online, this one
 	 * is just for additional info.
 	 */
-	if (!cpu_top.core_info[cpu].is_online) {
-		printf(_(" *is offline\n"));
-		return;
-	} else
-		printf("\n");
+	printf("\n");
 }
 
 
@@ -388,6 +386,9 @@ int cmd_monitor(int argc, char **argv)
 		return EXIT_FAILURE;
 	}
 
+	if (!cpu_top.core_info[0].is_online)
+		printf("WARNING: at least one cpu is offline\n");
+
 	/* Default is: monitor all CPUs */
 	if (bitmask_isallclear(cpus_chosen))
 		bitmask_setall(cpus_chosen);
-- 
1.8.1.4

