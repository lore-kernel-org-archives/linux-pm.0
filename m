From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [PATCH v3 3/5] powernv:cpufreq: Create pstate_id_to_freq() helper
Date: Thu, 20 Mar 2014 17:40:58 +0530
Message-ID: <1395317460-14811-4-git-send-email-ego@linux.vnet.ibm.com>
References: <1395317460-14811-1-git-send-email-ego@linux.vnet.ibm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e23smtp08.au.ibm.com ([202.81.31.141]:44385 "EHLO
	e23smtp08.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757165AbaCTMLo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 20 Mar 2014 08:11:44 -0400
Received: from /spool/local
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <ego@linux.vnet.ibm.com>;
	Thu, 20 Mar 2014 22:11:43 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
	by d23dlp01.au.ibm.com (Postfix) with ESMTP id 436DF2CE8052
	for <linux-pm@vger.kernel.org>; Thu, 20 Mar 2014 23:11:10 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s2KCAuUS7143778
	for <linux-pm@vger.kernel.org>; Thu, 20 Mar 2014 23:10:56 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s2KCB9oY004099
	for <linux-pm@vger.kernel.org>; Thu, 20 Mar 2014 23:11:10 +1100
In-Reply-To: <1395317460-14811-1-git-send-email-ego@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linuxppc-dev@ozlabs.org, linux-pm@vger.kernel.org
Cc: benh@kernel.crashing.org, svaidy@linux.vnet.ibm.com, "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

Create a helper routine that can return the cpu-frequency for the
corresponding pstate_id.

Also, cache the values of the pstate_max, pstate_min and
pstate_nominal and nr_pstates in a static structure so that they can
be reused in the future to perform any validations.

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 drivers/cpufreq/powernv-cpufreq.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index 66dae0d..e7b0292 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -39,6 +39,14 @@ static DEFINE_PER_CPU(struct mutex, freq_switch_lock);
 static struct cpufreq_frequency_table powernv_freqs[POWERNV_MAX_PSTATES+1];
 static int powernv_pstate_ids[POWERNV_MAX_PSTATES+1];
 
+struct powernv_pstate_info {
+	int pstate_min_id;
+	int pstate_max_id;
+	int pstate_nominal_id;
+	int nr_pstates;
+};
+static struct powernv_pstate_info powernv_pstate_info;
+
 /*
  * Initialize the freq table based on data obtained
  * from the firmware passed via device-tree
@@ -112,9 +120,28 @@ static int init_powernv_pstates(void)
 	for (i = 0; powernv_freqs[i].frequency != CPUFREQ_TABLE_END; i++)
 		pr_debug("%d: %d\n", i, powernv_freqs[i].frequency);
 
+	powernv_pstate_info.pstate_min_id = pstate_min;
+	powernv_pstate_info.pstate_max_id = pstate_max;
+	powernv_pstate_info.pstate_nominal_id = pstate_nominal;
+	powernv_pstate_info.nr_pstates = nr_pstates;
+
 	return 0;
 }
 
+/**
+ * Returns the cpu frequency corresponding to the pstate_id.
+ */
+static unsigned int pstate_id_to_freq(int pstate_id)
+{
+	int i;
+
+	i = powernv_pstate_info.pstate_max_id - pstate_id;
+
+	BUG_ON(i >= powernv_pstate_info.nr_pstates || i < 0);
+	WARN_ON(powernv_pstate_ids[i] != pstate_id);
+	return powernv_freqs[i].frequency;
+}
+
 static struct freq_attr *powernv_cpu_freq_attr[] = {
 	&cpufreq_freq_attr_scaling_available_freqs,
 	NULL,
-- 
1.8.3.1

