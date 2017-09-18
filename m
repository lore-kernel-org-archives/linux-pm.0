From: Abhishek Goel <huntbag@linux.vnet.ibm.com>
Subject: [PATCH] cpupowerutils: bench - Fix cpu online check
Date: Mon, 18 Sep 2017 17:14:26 +0530
Message-ID: <20170918114426.96911-1-huntbag@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: trenn@suse.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Abhishek Goel <huntbag@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

cpupower_is_cpu_online returns 1 when cpu is online. But in function
set_cpufreq_governor, it was incorrectly checking for 0 in case cpu is
online.

Signed-off-by: Abhishek Goel <huntbag@linux.vnet.ibm.com>
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
