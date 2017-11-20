From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] cpupower: Combine two condition checks into one statement in
 get_cpu_topology()
Date: Mon, 20 Nov 2017 19:19:39 +0100
Message-ID: <3daea226-c5cb-62e7-a025-8f758712a81a@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, Shuah Khan <shuah@kernel.org>, Thomas Renninger <trenn@suse.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 20 Nov 2017 19:10:14 +0100

The same assignments were used in an if branch of two separate statements.

* Merge their condition checks into a single statement instead.

* Adjust the indentation there.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 tools/power/cpupower/lib/cpupower.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/tools/power/cpupower/lib/cpupower.c b/tools/power/cpupower/lib/cpupower.c
index 9c395ec924de..81c828e5920e 100644
--- a/tools/power/cpupower/lib/cpupower.c
+++ b/tools/power/cpupower/lib/cpupower.c
@@ -140,18 +140,12 @@ int get_cpu_topology(struct cpupower_topology *cpu_top)
 	for (cpu = 0; cpu < cpus; cpu++) {
 		cpu_top->core_info[cpu].cpu = cpu;
 		cpu_top->core_info[cpu].is_online = cpupower_is_cpu_online(cpu);
-		if(sysfs_topology_read_file(
-			cpu,
-			"physical_package_id",
-			&(cpu_top->core_info[cpu].pkg)) < 0) {
-			cpu_top->core_info[cpu].pkg = -1;
-			cpu_top->core_info[cpu].core = -1;
-			continue;
-		}
-		if(sysfs_topology_read_file(
-			cpu,
-			"core_id",
-			&(cpu_top->core_info[cpu].core)) < 0) {
+		if (sysfs_topology_read_file(cpu, "physical_package_id",
+					     &(cpu_top->core_info[cpu].pkg))
+		    < 0 ||
+		    sysfs_topology_read_file(cpu, "core_id",
+					     &(cpu_top->core_info[cpu].core))
+		    < 0) {
 			cpu_top->core_info[cpu].pkg = -1;
 			cpu_top->core_info[cpu].core = -1;
 			continue;
-- 
2.15.0
