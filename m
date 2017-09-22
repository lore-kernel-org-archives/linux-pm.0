From: Abhishek Goel <huntbag@linux.vnet.ibm.com>
Subject: [PATCH] cpupower : Fix cpupower working when cpu0 is offline
Date: Fri, 22 Sep 2017 16:32:18 +0530
Message-ID: <20170922110218.120948-1-huntbag@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: trenn@suse.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Abhishek Goel <huntbag@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

cpuidle_monitor used to assume that cpu0 is always online. Now the
cpuidle_monitor function searches for the first online cpu and use
it, instead of always using cpu0 which may not be online.

Signed-off-by: Abhishek Goel <huntbag@linux.vnet.ibm.com>
---
 tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c b/tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c
index 1b5da00..adacf99 100644
--- a/tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c
+++ b/tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c
@@ -130,15 +130,23 @@ static struct cpuidle_monitor *cpuidle_register(void)
 {
 	int num;
 	char *tmp;
+	int first_online_cpu;
+
+	for (num = 0; num < cpu_count; num++) {
+		if (cpupower_is_cpu_online(num))
+			break;
+	};
+	first_online_cpu = num;
 
 	/* Assume idle state count is the same for all CPUs */
-	cpuidle_sysfs_monitor.hw_states_num = cpuidle_state_count(0);
+	cpuidle_sysfs_monitor.hw_states_num =
+		cpuidle_state_count(first_online_cpu);
 
 	if (cpuidle_sysfs_monitor.hw_states_num <= 0)
 		return NULL;
 
 	for (num = 0; num < cpuidle_sysfs_monitor.hw_states_num; num++) {
-		tmp = cpuidle_state_name(0, num);
+		tmp = cpuidle_state_name(first_online_cpu, num);
 		if (tmp == NULL)
 			continue;
 
@@ -146,7 +154,7 @@ static struct cpuidle_monitor *cpuidle_register(void)
 		strncpy(cpuidle_cstates[num].name, tmp, CSTATE_NAME_LEN - 1);
 		free(tmp);
 
-		tmp = cpuidle_state_desc(0, num);
+		tmp = cpuidle_state_desc(first_online_cpu, num);
 		if (tmp == NULL)
 			continue;
 		strncpy(cpuidle_cstates[num].desc, tmp,	CSTATE_DESC_LEN - 1);
-- 
2.9.3
