From: Abhishek Goel <huntbag@linux.vnet.ibm.com>
Subject: [PATCH v2] cpupower : Fix cpupower working when cpu0 is offline
Date: Tue,  7 Nov 2017 12:50:05 +0530
Message-ID: <20171107072005.48034-1-huntbag@linux.vnet.ibm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50480 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755108AbdKGHUT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Nov 2017 02:20:19 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vA77JcdR088042
        for <linux-pm@vger.kernel.org>; Tue, 7 Nov 2017 02:20:18 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2e35hmh0pt-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Tue, 07 Nov 2017 02:20:18 -0500
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <huntbag@linux.vnet.ibm.com>;
        Tue, 7 Nov 2017 07:20:16 -0000
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: trenn@suse.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Abhishek Goel <huntbag@linux.vnet.ibm.com>

cpuidle_monitor used to assume that cpu0 is always online which is not
a valid assumption on POWER machines. This patch fixes this by searching
for the first online cpu and uses it, instead of always using cpu0 for
monitoring which may not be online.

Signed-off-by: Abhishek Goel <huntbag@linux.vnet.ibm.com>
---
v2: Commit message updated.
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
