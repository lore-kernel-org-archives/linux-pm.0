From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 08/18] cpufreq: Add doc style comment about cpufreq_cpu_{get|put}()
Date: Tue, 27 Jan 2015 14:06:14 +0530
Message-ID: <7b7de04921e8e2e57fbe2c8e75898c9d9284a269.1422346933.git.viresh.kumar@linaro.org>
References: <cover.1422346933.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:38309 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757884AbbA0IhM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 27 Jan 2015 03:37:12 -0500
Received: by mail-pa0-f52.google.com with SMTP id kx10so17140910pab.11
        for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2015 00:37:11 -0800 (PST)
In-Reply-To: <cover.1422346933.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1422346933.git.viresh.kumar@linaro.org>
References: <cover.1422346933.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

This clearly states what the code inside these routines is doing and how these
must be used.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index d9528046f651..21c8ef6073d7 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -167,6 +167,23 @@ struct cpufreq_policy *cpufreq_cpu_get_raw(unsigned int cpu)
 	return NULL;
 }
 
+/**
+ * cpufreq_cpu_get: returns policy for a cpu and marks it busy.
+ *
+ * @cpu: cpu to find policy for.
+ *
+ * This returns policy for 'cpu', returns NULL if it doesn't exist.
+ * It also increments the kobject reference count to mark it busy and so would
+ * require a corresponding call to cpufreq_cpu_put() to decrement it back.
+ * If corresponding call cpufreq_cpu_put() isn't made, the policy wouldn't be
+ * freed as that depends on the kobj count.
+ *
+ * It also takes a read-lock of 'cpufreq_rwsem' and doesn't put it back if a
+ * valid policy is found. This is done to make sure the driver doesn't get
+ * unregistered while the policy is being used.
+ *
+ * Return: A valid policy on success, otherwise NULL on failure.
+ */
 struct cpufreq_policy *cpufreq_cpu_get(unsigned int cpu)
 {
 	struct cpufreq_policy *policy = NULL;
@@ -193,6 +210,16 @@ struct cpufreq_policy *cpufreq_cpu_get(unsigned int cpu)
 }
 EXPORT_SYMBOL_GPL(cpufreq_cpu_get);
 
+/**
+ * cpufreq_cpu_put: Decrements the usage count of a policy
+ *
+ * @policy: policy earlier returned by cpufreq_cpu_get().
+ *
+ * This decrements the kobject reference count incremented earlier by calling
+ * cpufreq_cpu_get().
+ *
+ * It also drops the read-lock of 'cpufreq_rwsem' taken at cpufreq_cpu_get().
+ */
 void cpufreq_cpu_put(struct cpufreq_policy *policy)
 {
 	kobject_put(&policy->kobj);
-- 
2.3.0.rc0.44.ga94655d

