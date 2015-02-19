From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 02/20] cpufreq: Merge __cpufreq_add_dev() and cpufreq_add_dev()
Date: Thu, 19 Feb 2015 17:02:04 +0530
Message-ID: <cb3787174ea4da5ebe52efc974dff715c3241968.1424345053.git.viresh.kumar@linaro.org>
References: <cover.1424345053.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:43433 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753237AbbBSLd3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 Feb 2015 06:33:29 -0500
Received: by pdev10 with SMTP id v10so8252347pde.10
        for <linux-pm@vger.kernel.org>; Thu, 19 Feb 2015 03:33:29 -0800 (PST)
In-Reply-To: <cover.1424345053.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1424345053.git.viresh.kumar@linaro.org>
References: <cover.1424345053.git.viresh.kumar@linaro.org>
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
index fc51b8fbb0b0..4884caf92bff 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1125,7 +1125,16 @@ static int update_policy_cpu(struct cpufreq_policy *policy, unsigned int cpu,
 	return 0;
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
 	unsigned int j, cpu = dev->id;
 	int ret = -ENOMEM;
@@ -1336,20 +1345,6 @@ static int __cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
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
@@ -2328,7 +2323,7 @@ static int cpufreq_cpu_callback(struct notifier_block *nfb,
 	if (dev) {
 		switch (action & ~CPU_TASKS_FROZEN) {
 		case CPU_ONLINE:
-			__cpufreq_add_dev(dev, NULL);
+			cpufreq_add_dev(dev, NULL);
 			break;
 
 		case CPU_DOWN_PREPARE:
@@ -2340,7 +2335,7 @@ static int cpufreq_cpu_callback(struct notifier_block *nfb,
 			break;
 
 		case CPU_DOWN_FAILED:
-			__cpufreq_add_dev(dev, NULL);
+			cpufreq_add_dev(dev, NULL);
 			break;
 		}
 	}
-- 
2.3.0.rc0.44.ga94655d

