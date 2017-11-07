From: Abhishek Goel <huntbag@linux.vnet.ibm.com>
Subject: [PATCH v2] cpupowerutils: bench - Fix cpu online check
Date: Tue,  7 Nov 2017 15:17:55 +0530
Message-ID: <20171107094755.49440-1-huntbag@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: trenn@suse.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Abhishek Goel <huntbag@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

cpupower_is_cpu_online was incorrectly checking for 0. This patch fixes
this by checking for 1 when the cpu is online.

Signed-off-by: Abhishek Goel <huntbag@linux.vnet.ibm.com>
---
v2: Commit message rephrased.
---
 tools/power/cpupower/bench/system.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/cpupower/bench/system.c b/tools/power/cpupower/bench/system.c
index c25a74a..2bb3eef 100644
--- a/tools/power/cpupower/bench/system.c
+++ b/tools/power/cpupower/bench/system.c
@@ -61,7 +61,7 @@ int set_cpufreq_governor(char *governor, unsigned int cpu)
 
 	dprintf("set %s as cpufreq governor\n", governor);
 
-	if (cpupower_is_cpu_online(cpu) != 0) {
+	if (cpupower_is_cpu_online(cpu) != 1) {
 		perror("cpufreq_cpu_exists");
 		fprintf(stderr, "error: cpu %u does not exist\n", cpu);
 		return -1;
-- 
2.9.3
