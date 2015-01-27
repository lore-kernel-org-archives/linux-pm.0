From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 18/18] cpufreq: Merge __cpufreq_add_dev() and cpufreq_add_dev()
Date: Tue, 27 Jan 2015 14:06:24 +0530
Message-ID: <c1eefa65bf65d9de2b9f1e2394d485d52b462992.1422346933.git.viresh.kumar@linaro.org>
References: <cover.1422346933.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:42354 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757922AbbA0Ihs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 27 Jan 2015 03:37:48 -0500
Received: by mail-pd0-f173.google.com with SMTP id fp1so17598276pdb.4
        for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2015 00:37:48 -0800 (PST)
In-Reply-To: <cover.1422346933.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1422346933.git.viresh.kumar@linaro.org>
References: <cover.1422346933.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

cpufreq_add_dev() is an unnecessary wrapper over __cpufreq_add_dev(). Merge
them.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index bcc042a6221a..7501347cf19c 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1148,7 +1148,16 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy, bool notify)
 	kfree(policy);
 }
 
-static int __cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
+/**
+ * cpufreq_add_dev - add a CPU device
+ *
+ * Adds the cpufreq interface for a CPU device.
+ *
+ * The Oracle says: try running cpufreq registration/unregistration concurrently
+ * with with cpu hotplugging and all hell will break loose. Tried to clean this
+ * mess up, but more thorough testing is needed. - Mathieu
+ */
+static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 {
 	unsigned int cpu = dev->id;
 	int ret = -ENOMEM;
@@ -1320,20 +1329,6 @@ static int __cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 	return ret;
 }
 
-/**
- * cpufreq_add_dev - add a CPU device
- *
- * Adds the cpufreq interface for a CPU device.
- *
- * The Oracle says: try running cpufreq registration/unregistration concurrently
- * with with cpu hotplugging and all hell will break loose. Tried to clean this
- * mess up, but more thorough testing is needed. - Mathieu
- */
-static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
-{
-	return __cpufreq_add_dev(dev, sif);
-}
-
 static int __cpufreq_remove_dev_prepare(struct device *dev,
 					struct subsys_interface *sif)
 {
@@ -2307,7 +2302,7 @@ static int cpufreq_cpu_callback(struct notifier_block *nfb,
 	if (dev) {
 		switch (action & ~CPU_TASKS_FROZEN) {
 		case CPU_ONLINE:
-			__cpufreq_add_dev(dev, NULL);
+			cpufreq_add_dev(dev, NULL);
 			break;
 
 		case CPU_DOWN_PREPARE:
@@ -2319,7 +2314,7 @@ static int cpufreq_cpu_callback(struct notifier_block *nfb,
 			break;
 
 		case CPU_DOWN_FAILED:
-			__cpufreq_add_dev(dev, NULL);
+			cpufreq_add_dev(dev, NULL);
 			break;
 		}
 	}
-- 
2.3.0.rc0.44.ga94655d

