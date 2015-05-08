From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 07/14] cpufreq: Don't allow updating inactive-policies from sysfs
Date: Fri,  8 May 2015 11:53:50 +0530
Message-ID: <6ad4377106496d9d148005c902602c66eb307930.1431065963.git.viresh.kumar@linaro.org>
References: <cover.1431065963.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:33058 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751319AbbEHGY6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 8 May 2015 02:24:58 -0400
Received: by pdbnk13 with SMTP id nk13so66954301pdb.0
        for <linux-pm@vger.kernel.org>; Thu, 07 May 2015 23:24:58 -0700 (PDT)
In-Reply-To: <cover.1431065963.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1431065963.git.viresh.kumar@linaro.org>
References: <cover.1431065963.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com, skannan@codeaurora.org, Srivatsa Bhat <srivatsa@mit.edu>, Viresh Kumar <viresh.kumar@linaro.org>

Later commits would change the way policies are managed today. Policies
wouldn't be freed on cpu hotplug (currently they aren't freed only for
suspend), and while the CPU is offline, the sysfs cpufreq files would
still be present.

User may accidentally try to update the sysfs files in following
directory: '/sys/devices/system/cpu/cpuX/cpufreq/'. And that would
result in undefined behavior as policy wouldn't be active then.

Apart from updating the store() routine, we also update __cpufreq_get()
which can call cpufreq_out_of_sync(). The later routine tries to update
policy->cur and starts notifying kernel about it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index bd8a47b5054e..652a843a553b 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -887,11 +887,22 @@ static ssize_t store(struct kobject *kobj, struct attribute *attr,
 
 	down_write(&policy->rwsem);
 
+	/*
+	 * Policy might not be active currently, and so we shouldn't try
+	 * updating any values here. policy->cpus is cleared for inactive policy
+	 * and so cpufreq_cpu_get_raw() should fail.
+	 */
+	if (unlikely(policy_is_inactive(policy))) {
+		ret = -EPERM;
+		goto unlock_policy_rwsem;
+	}
+
 	if (fattr->store)
 		ret = fattr->store(policy, buf, count);
 	else
 		ret = -EIO;
 
+unlock_policy_rwsem:
 	up_write(&policy->rwsem);
 
 	up_read(&cpufreq_rwsem);
@@ -1619,6 +1630,14 @@ static unsigned int __cpufreq_get(struct cpufreq_policy *policy)
 
 	ret_freq = cpufreq_driver->get(policy->cpu);
 
+	/*
+	 * Policy might not be active currently, and so we shouldn't try
+	 * updating any values here. policy->cpus is cleared for inactive policy
+	 * and so cpufreq_cpu_get_raw() should fail.
+	 */
+	if (unlikely(policy_is_inactive(policy)))
+		return ret_freq;
+
 	if (ret_freq && policy->cur &&
 		!(cpufreq_driver->flags & CPUFREQ_CONST_LOOPS)) {
 		/* verify no discrepancy between actual and
-- 
2.4.0

