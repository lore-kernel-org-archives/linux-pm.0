From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Subject: [PATCH v2 1/2] cpufreq: powernv: Adding fast_switch for schedutil
Date: Mon,  7 Nov 2016 13:09:08 +0530
Message-ID: <1478504349-14796-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57774 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750922AbcKGHjZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Nov 2016 02:39:25 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id uA77d6bH118806
        for <linux-pm@vger.kernel.org>; Mon, 7 Nov 2016 02:39:24 -0500
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
        by mx0a-001b2d01.pphosted.com with ESMTP id 26jb2hma16-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Mon, 07 Nov 2016 02:39:24 -0500
Received: from localhost
        by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <akshay.adiga@linux.vnet.ibm.com>;
        Mon, 7 Nov 2016 17:39:22 +1000
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, ego@linux.vnet.ibm.com, shilpa.bhat@linux.vnet.ibm.com, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>

Adding fast_switch which does light weight operation to set the desired
pstate. Both global and local pstates are set to the same desired pstate.

Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
---
Changes from v1 :
- Removed unnecessary check for index out of bound.

 drivers/cpufreq/powernv-cpufreq.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index d3ffde8..4a4380d 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -752,9 +752,12 @@ static int powernv_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	spin_lock_init(&gpstates->gpstate_lock);
 	ret = cpufreq_table_validate_and_show(policy, powernv_freqs);
 
-	if (ret < 0)
+	if (ret < 0) {
 		kfree(policy->driver_data);
+		return ret;
+	}
 
+	policy->fast_switch_possible = true;
 	return ret;
 }
 
@@ -897,6 +900,20 @@ static void powernv_cpufreq_stop_cpu(struct cpufreq_policy *policy)
 	del_timer_sync(&gpstates->timer);
 }
 
+static unsigned int powernv_fast_switch(struct cpufreq_policy *policy,
+					unsigned int target_freq)
+{
+	int index;
+	struct powernv_smp_call_data freq_data;
+
+	index = cpufreq_table_find_index_dl(policy, target_freq);
+	freq_data.pstate_id = powernv_freqs[index].driver_data;
+	freq_data.gpstate_id = powernv_freqs[index].driver_data;
+	set_pstate(&freq_data);
+
+	return powernv_freqs[index].frequency;
+}
+
 static struct cpufreq_driver powernv_cpufreq_driver = {
 	.name		= "powernv-cpufreq",
 	.flags		= CPUFREQ_CONST_LOOPS,
@@ -904,6 +921,7 @@ static struct cpufreq_driver powernv_cpufreq_driver = {
 	.exit		= powernv_cpufreq_cpu_exit,
 	.verify		= cpufreq_generic_frequency_table_verify,
 	.target_index	= powernv_cpufreq_target_index,
+	.fast_switch	= powernv_fast_switch,
 	.get		= powernv_cpufreq_get,
 	.stop_cpu	= powernv_cpufreq_stop_cpu,
 	.attr		= powernv_cpu_freq_attr,
-- 
2.5.5

