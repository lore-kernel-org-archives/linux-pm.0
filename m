From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 10/18] cpufreq: Don't allow updating inactive-policies from sysfs
Date: Tue, 27 Jan 2015 14:06:16 +0530
Message-ID: <935ec6b1fe24e17a95c71cfb01ea1bf27d03a5d5.1422346933.git.viresh.kumar@linaro.org>
References: <cover.1422346933.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:41463 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757884AbbA0IhT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 27 Jan 2015 03:37:19 -0500
Received: by mail-pd0-f172.google.com with SMTP id v10so17617683pde.3
        for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2015 00:37:18 -0800 (PST)
In-Reply-To: <cover.1422346933.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1422346933.git.viresh.kumar@linaro.org>
References: <cover.1422346933.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

Later commits would change the way policies are managed today. Policies wouldn't
be freed on cpu hotplug (currently they aren't freed on suspend), and while the
CPU is offline, the sysfs cpufreq files would still be present.

User may accidentally try to update the sysfs files in following directory:
'/sys/devices/system/cpu/cpuX/cpufreq/'. And that would result in undefined
behavior as policy wouldn't be active then.

To disallow such accesses, sense if a policy is active or not while doing such
operations. This can be done easily by getting the policy again with
cpufreq_cpu_get_raw(), as that would traverse the list of active policies.

Apart from updating the store() routine, we also update __cpufreq_get() which
can call cpufreq_out_of_sync(). The later routine tries to update policy->cur
and start notifying kernel about it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index ed36c09f83cc..fffa37136b7b 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -826,11 +826,22 @@ static ssize_t store(struct kobject *kobj, struct attribute *attr,
 
 	down_write(&policy->rwsem);
 
+	/*
+	 * Policy might not be active currently, and so we shouldn't try
+	 * updating any values here. An inactive policy is moved to fallback
+	 * list and so cpufreq_cpu_get_raw() should fail.
+	 */
+	if (unlikely(!cpufreq_cpu_get_raw(policy->cpu))) {
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
@@ -1587,6 +1598,14 @@ static unsigned int __cpufreq_get(struct cpufreq_policy *policy)
 
 	ret_freq = cpufreq_driver->get(policy->cpu);
 
+	/*
+	 * Policy might not be active currently, and so we shouldn't try
+	 * updating any values here. An inactive policy is moved to fallback
+	 * list and so cpufreq_cpu_get_raw() should fail.
+	 */
+	if (unlikely(!cpufreq_cpu_get_raw(policy->cpu)))
+		return ret_freq;
+
 	if (ret_freq && policy->cur &&
 		!(cpufreq_driver->flags & CPUFREQ_CONST_LOOPS)) {
 		/* verify no discrepancy between actual and
-- 
2.3.0.rc0.44.ga94655d

