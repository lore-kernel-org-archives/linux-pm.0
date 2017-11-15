From: Abhishek Goel <huntbag@linux.vnet.ibm.com>
Subject: [PATCH v3] cpupower : Fix cpupower working when cpu0 is offline
Date: Wed, 15 Nov 2017 14:10:02 +0530
Message-ID: <20171115084002.23887-1-huntbag@linux.vnet.ibm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58286 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755194AbdKOIkM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Nov 2017 03:40:12 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAF8dBPQ074492
        for <linux-pm@vger.kernel.org>; Wed, 15 Nov 2017 03:40:12 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2e8fpxedu2-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Wed, 15 Nov 2017 03:40:11 -0500
Received: from localhost
        by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <huntbag@linux.vnet.ibm.com>;
        Wed, 15 Nov 2017 08:40:09 -0000
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: trenn@suse.com, linux-pm@vger.kernel.org, shuah@kernel.org, linux-kernel@vger.kernel.org
Cc: Abhishek Goel <huntbag@linux.vnet.ibm.com>

cpuidle_monitor used to assume that cpu0 is always online which is not
a valid assumption on POWER machines. This patch fixes this by getting
the cpu on which the current thread is running, instead of always using
cpu0 for monitoring which may not be online.

Signed-off-by: Abhishek Goel <huntbag@linux.vnet.ibm.com>
---
 tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c b/tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c
index 1b5da00..5b3205f 100644
--- a/tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c
+++ b/tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c
@@ -130,15 +130,18 @@ static struct cpuidle_monitor *cpuidle_register(void)
 {
 	int num;
 	char *tmp;
+	int this_cpu;
+
+	this_cpu = sched_getcpu();
 
 	/* Assume idle state count is the same for all CPUs */
-	cpuidle_sysfs_monitor.hw_states_num = cpuidle_state_count(0);
+	cpuidle_sysfs_monitor.hw_states_num = cpuidle_state_count(this_cpu);
 
 	if (cpuidle_sysfs_monitor.hw_states_num <= 0)
 		return NULL;
 
 	for (num = 0; num < cpuidle_sysfs_monitor.hw_states_num; num++) {
-		tmp = cpuidle_state_name(0, num);
+		tmp = cpuidle_state_name(this_cpu, num);
 		if (tmp == NULL)
 			continue;
 
@@ -146,7 +149,7 @@ static struct cpuidle_monitor *cpuidle_register(void)
 		strncpy(cpuidle_cstates[num].name, tmp, CSTATE_NAME_LEN - 1);
 		free(tmp);
 
-		tmp = cpuidle_state_desc(0, num);
+		tmp = cpuidle_state_desc(this_cpu, num);
 		if (tmp == NULL)
 			continue;
 		strncpy(cpuidle_cstates[num].desc, tmp,	CSTATE_DESC_LEN - 1);
-- 
2.9.3
