From: Abhishek Goel <huntbag@linux.vnet.ibm.com>
Subject: [PATCH] cpupower : Fix cpupower working when cpu0 is offline
Date: Fri, 22 Sep 2017 14:17:32 +0530
Message-ID: <20170922084732.119903-1-huntbag@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: trenn@suse.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Abhishek Goel <huntbag@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

cpuidle_monitor used to assume that cpu0 is always online. Now the
cpuidle_monitor function searches for the first online cpu and use
it, instead of always using cpu0 which maynot be online.

Signed-off-by: Abhishek Goel <huntbag@linux.vnet.ibm.com>
---
 tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c b/tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c
index 055a4fa..1cfba02 100644
--- a/tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c
+++ b/tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c
@@ -132,13 +132,13 @@ static struct cpuidle_monitor *cpuidle_register(void)
 	char *tmp;
 	int first_online_cpu;
 
-	for (num = 0; num < cpu_count; num++){
+	for (num = 0; num < cpu_count; num++) {
 		if (cpupower_is_cpu_online(num))
 			break;
 	};
 	first_online_cpu = num;
-	
-	/* Assume idle state count is the same for all CPUs */ 
+
+	/* Assume idle state count is the same for all CPUs */
 	cpuidle_sysfs_monitor.hw_states_num = cpuidle_state_count(first_online_cpu);
 
 	if (cpuidle_sysfs_monitor.hw_states_num <= 0)
-- 
2.9.3
