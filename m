From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 1/3] cpupower: cpupower monitor reports uninitialized values for offline cpus
Date: Thu, 22 Oct 2015 17:17:05 +0200
Message-ID: <1445527027-2764-2-git-send-email-trenn@suse.de>
References: <1445527027-2764-1-git-send-email-trenn@suse.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:60383 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756446AbbJVPRP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 22 Oct 2015 11:17:15 -0400
In-Reply-To: <1445527027-2764-1-git-send-email-trenn@suse.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, prarit@redhat.com, jtanenba@redhat.com, Thomas Renninger <trenn@suse.de>

From: Jacob Tanenbaum <jtanenba@redhat.com>

[root@hp-dl980g7-02 linux]# cpupower monitor
...
5472|   0|   1|******|******|******|******|| 0.00|  0.00|  0.00|  0.00|  0.00 *is offline
10567|   0| 159|******|******|******|******||  0.00|  0.00|  0.00|  0.00|  0.00 *is offline
1661206560|859272560| 150|******|******|******|******|| 0.00|  0.00|  0.00|  0.00|  0.00 *is offline
1661206560|943093104| 140|******|******|******|******|| 0.00|  0.00|  0.00|  0.00|  0.00 *is offline

because of this cpupower also holds the incorrect value for the number
of physical packages in the machine

Changed cpupower to initialize the values of an offline cpu's socket and
core to -1, warn the user that one or more cpus is/are
offline and not print statistics for offline cpus.

This fix hides offlined cores where topology cannot be accessed.
With a recent kernel patch suggested from Prarit Bhargava it may be possible
that soft offlined cores' topology can still be parsed.
This patch would then show which cores in which package/socket are offline,
when sane toplogoy information is available.

Signed-off-by: Jacob Tanenbaum <jtanenba@redhat.com>
Reviewed-by: Thomas Renninger <trenn@suse.de>
CC: Prarit Bhargava <prarit@redhat.com>
Signed-off-by: Thomas Renninger <trenn@suse.de>
---
 tools/power/cpupower/utils/helpers/topology.c      | 23 ++++++++++++++--------
 .../cpupower/utils/idle_monitor/cpupower-monitor.c |  9 ++++++++-
 2 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/tools/power/cpupower/utils/helpers/topology.c b/tools/power/cpupower/utils/helpers/topology.c
index cea398c..9cbb7fd 100644
--- a/tools/power/cpupower/utils/helpers/topology.c
+++ b/tools/power/cpupower/utils/helpers/topology.c
@@ -73,18 +73,22 @@ int get_cpu_topology(struct cpupower_topology *cpu_top)
 	for (cpu = 0; cpu < cpus; cpu++) {
 		cpu_top->core_info[cpu].cpu = cpu;
 		cpu_top->core_info[cpu].is_online = sysfs_is_cpu_online(cpu);
-		if (!cpu_top->core_info[cpu].is_online)
-			continue;
 		if(sysfs_topology_read_file(
 			cpu,
 			"physical_package_id",
-			&(cpu_top->core_info[cpu].pkg)) < 0)
-			return -1;
+			&(cpu_top->core_info[cpu].pkg)) < 0) {
+			cpu_top->core_info[cpu].pkg = -1;
+			cpu_top->core_info[cpu].core = -1;
+			continue;
+		}
 		if(sysfs_topology_read_file(
 			cpu,
 			"core_id",
-			&(cpu_top->core_info[cpu].core)) < 0)
-			return -1;
+			&(cpu_top->core_info[cpu].core)) < 0) {
+			cpu_top->core_info[cpu].pkg = -1;
+			cpu_top->core_info[cpu].core = -1;
+			continue;
+		}
 	}
 
 	qsort(cpu_top->core_info, cpus, sizeof(struct cpuid_core_info),
@@ -95,12 +99,15 @@ int get_cpu_topology(struct cpupower_topology *cpu_top)
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
+	if (!cpu_top->core_info[0].pkg == -1)
+		cpu_top->pkgs++;
 
 	/* Intel's cores count is not consecutively numbered, there may
 	 * be a core_id of 3, but none of 2. Assume there always is 0
diff --git a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
index c4bae92..05f953f 100644
--- a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
+++ b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
@@ -143,6 +143,9 @@ void print_results(int topology_depth, int cpu)
 	/* Be careful CPUs may got resorted for pkg value do not just use cpu */
 	if (!bitmask_isbitset(cpus_chosen, cpu_top.core_info[cpu].cpu))
 		return;
+	if (!cpu_top.core_info[cpu].is_online &&
+	    cpu_top.core_info[cpu].pkg == -1)
+		return;
 
 	if (topology_depth > 2)
 		printf("%4d|", cpu_top.core_info[cpu].pkg);
@@ -191,7 +194,8 @@ void print_results(int topology_depth, int cpu)
 	 * It's up to the monitor plug-in to check .is_online, this one
 	 * is just for additional info.
 	 */
-	if (!cpu_top.core_info[cpu].is_online) {
+	if (!cpu_top.core_info[cpu].is_online &&
+	    cpu_top.core_info[cpu].pkg != -1) {
 		printf(_(" *is offline\n"));
 		return;
 	} else
@@ -388,6 +392,9 @@ int cmd_monitor(int argc, char **argv)
 		return EXIT_FAILURE;
 	}
 
+	if (!cpu_top.core_info[0].is_online)
+		printf("WARNING: at least one cpu is offline\n");
+
 	/* Default is: monitor all CPUs */
 	if (bitmask_isallclear(cpus_chosen))
 		bitmask_setall(cpus_chosen);
-- 
2.1.4

