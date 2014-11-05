From: Yadwinder Singh Brar <yadi.brar@samsung.com>
Subject: [PATCH] thermal: cpu_cooling: Update always cpufreq policy with
 thermal constraints
Date: Wed, 05 Nov 2014 17:46:25 +0530
Message-ID: <1415189785-18593-1-git-send-email-yadi.brar@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:45541 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753898AbaKEMQv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 5 Nov 2014 07:16:51 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: rui.zhang@intel.com, edubezval@gmail.com, amit.daniel@samsung.com, viresh.kumar@linaro.org, linux-samsung-soc@vger.kernel.org, yadi.brar01@gmail.com, Yadwinder Singh Brar <yadi.brar@samsung.com>

Existing code updates cupfreq policy only while executing
cpufreq_apply_cooling() function (i.e. when notify_device != NOTIFY_INVALID).
It doesn't apply constraints when cpufreq policy update happens from any other
place but it should update the cpufreq policy with thermal constraints every
time when there is a cpufreq policy update, to keep state of
cpufreq_cooling_device and max_feq of cpufreq policy in sync.

This patch modifies code to maintain a global cpufreq_dev_list and get
corresponding cpufreq_cooling_device for policy's cpu from cpufreq_dev_list
when there is any policy update.

Signed-off-by: Yadwinder Singh Brar <yadi.brar@samsung.com>
---
 drivers/thermal/cpu_cooling.c |   37 ++++++++++++++++++++-----------------
 1 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 1ab0018..5546278 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -50,15 +50,14 @@ struct cpufreq_cooling_device {
 	unsigned int cpufreq_state;
 	unsigned int cpufreq_val;
 	struct cpumask allowed_cpus;
+	struct list_head node;
 };
 static DEFINE_IDR(cpufreq_idr);
 static DEFINE_MUTEX(cooling_cpufreq_lock);
 
 static unsigned int cpufreq_dev_count;
 
-/* notify_table passes value to the CPUFREQ_ADJUST callback function. */
-#define NOTIFY_INVALID NULL
-static struct cpufreq_cooling_device *notify_device;
+static LIST_HEAD(cpufreq_dev_list);
 
 /**
  * get_idr - function to get a unique id.
@@ -287,15 +286,12 @@ static int cpufreq_apply_cooling(struct cpufreq_cooling_device *cpufreq_device,
 
 	cpufreq_device->cpufreq_state = cooling_state;
 	cpufreq_device->cpufreq_val = clip_freq;
-	notify_device = cpufreq_device;
 
 	for_each_cpu(cpuid, mask) {
 		if (is_cpufreq_valid(cpuid))
 			cpufreq_update_policy(cpuid);
 	}
 
-	notify_device = NOTIFY_INVALID;
-
 	return 0;
 }
 
@@ -316,21 +312,27 @@ static int cpufreq_thermal_notifier(struct notifier_block *nb,
 {
 	struct cpufreq_policy *policy = data;
 	unsigned long max_freq = 0;
+	struct cpufreq_cooling_device *cpufreq_dev;
 
-	if (event != CPUFREQ_ADJUST || notify_device == NOTIFY_INVALID)
+	if (event != CPUFREQ_ADJUST)
 		return 0;
 
-	if (cpumask_test_cpu(policy->cpu, &notify_device->allowed_cpus))
-		max_freq = notify_device->cpufreq_val;
-	else
-		return 0;
+	mutex_lock(&cooling_cpufreq_lock);
+	list_for_each_entry(cpufreq_dev, &cpufreq_dev_list, node) {
+		if (!cpumask_test_cpu(policy->cpu,
+					&cpufreq_dev->allowed_cpus))
+			continue;
 
-	/* Never exceed user_policy.max */
-	if (max_freq > policy->user_policy.max)
-		max_freq = policy->user_policy.max;
+		max_freq = cpufreq_dev->cpufreq_val;
 
-	if (policy->max != max_freq)
-		cpufreq_verify_within_limits(policy, 0, max_freq);
+		/* Never exceed user_policy.max */
+		if (max_freq > policy->user_policy.max)
+			max_freq = policy->user_policy.max;
+
+		if (policy->max != max_freq)
+			cpufreq_verify_within_limits(policy, 0, max_freq);
+	}
+	mutex_unlock(&cooling_cpufreq_lock);
 
 	return 0;
 }
@@ -486,7 +488,7 @@ __cpufreq_cooling_register(struct device_node *np,
 		cpufreq_register_notifier(&thermal_cpufreq_notifier_block,
 					  CPUFREQ_POLICY_NOTIFIER);
 	cpufreq_dev_count++;
-
+	list_add(&cpufreq_dev->node, &cpufreq_dev_list);
 	mutex_unlock(&cooling_cpufreq_lock);
 
 	return cool_dev;
@@ -549,6 +551,7 @@ void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
 
 	cpufreq_dev = cdev->devdata;
 	mutex_lock(&cooling_cpufreq_lock);
+	list_del(&cpufreq_dev->node);
 	cpufreq_dev_count--;
 
 	/* Unregister the notifier for the last cpufreq cooling device */
-- 
1.7.0.4

