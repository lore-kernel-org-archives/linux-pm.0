From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Subject: [PATCH v3 1/2] cpufreq: powernv: Remove flag use-case of policy->driver_data
Date: Tue, 19 Apr 2016 15:28:00 +0530
Message-ID: <1461059881-14434-2-git-send-email-akshay.adiga@linux.vnet.ibm.com>
References: <1461059881-14434-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e28smtp05.in.ibm.com ([125.16.236.5]:35914 "EHLO
	e28smtp05.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753351AbcDSJ6X (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 19 Apr 2016 05:58:23 -0400
Received: from localhost
	by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <akshay.adiga@linux.vnet.ibm.com>;
	Tue, 19 Apr 2016 15:28:20 +0530
In-Reply-To: <1461059881-14434-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: ego@linux.vnet.ibm.com, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>

From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>

commit 1b0289848d5d ("cpufreq: powernv: Add sysfs attributes to show
throttle stats") used policy->driver_data as a flag for one-time creation
of throttle sysfs files. Instead of this use 'kernfs_find_and_get()' to
check if the attribute already exists. This is required as
policy->driver_data is used for other purposes in the later patch.

Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/powernv-cpufreq.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index 39ac78c..e2e2219 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -455,13 +455,15 @@ static int powernv_cpufreq_target_index(struct cpufreq_policy *policy,
 static int powernv_cpufreq_cpu_init(struct cpufreq_policy *policy)
 {
 	int base, i;
+	struct kernfs_node *kn;
 
 	base = cpu_first_thread_sibling(policy->cpu);
 
 	for (i = 0; i < threads_per_core; i++)
 		cpumask_set_cpu(base + i, policy->cpus);
 
-	if (!policy->driver_data) {
+	kn = kernfs_find_and_get(policy->kobj.sd, throttle_attr_grp.name);
+	if (!kn) {
 		int ret;
 
 		ret = sysfs_create_group(&policy->kobj, &throttle_attr_grp);
@@ -470,11 +472,8 @@ static int powernv_cpufreq_cpu_init(struct cpufreq_policy *policy)
 				policy->cpu);
 			return ret;
 		}
-		/*
-		 * policy->driver_data is used as a flag for one-time
-		 * creation of throttle sysfs files.
-		 */
-		policy->driver_data = policy;
+	} else {
+		kernfs_put(kn);
 	}
 	return cpufreq_table_validate_and_show(policy, powernv_freqs);
 }
-- 
2.5.5

