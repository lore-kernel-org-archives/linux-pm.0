From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 1/3] cpufreq: Relocate handle_update() to kill its declaration
Date: Mon, 22 Feb 2016 16:36:42 +0530
Message-ID: <366829a89505a358c372bea0c17e58462768b4bb.1456139127.git.viresh.kumar@linaro.org>
References: <cover.1456139127.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35227 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753987AbcBVLHI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 22 Feb 2016 06:07:08 -0500
Received: by mail-pa0-f48.google.com with SMTP id ho8so92075670pac.2
        for <linux-pm@vger.kernel.org>; Mon, 22 Feb 2016 03:07:07 -0800 (PST)
In-Reply-To: <cover.1456139127.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1456139127.git.viresh.kumar@linaro.org>
References: <cover.1456139127.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

handle_update() is declared at the top of the file as its user appear
before its definition. Relocate the routine to get rid of this.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 5ab9c5432113..3689b4dff967 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -121,7 +121,6 @@ static inline bool has_target(void)
 static int __cpufreq_governor(struct cpufreq_policy *policy,
 		unsigned int event);
 static unsigned int __cpufreq_get(struct cpufreq_policy *policy);
-static void handle_update(struct work_struct *work);
 
 /**
  * Two notifier lists: the "policy" list is involved in the
@@ -1023,6 +1022,15 @@ static int cpufreq_add_policy_cpu(struct cpufreq_policy *policy, unsigned int cp
 	return ret;
 }
 
+static void handle_update(struct work_struct *work)
+{
+	struct cpufreq_policy *policy =
+		container_of(work, struct cpufreq_policy, update);
+	unsigned int cpu = policy->cpu;
+	pr_debug("handle_update for cpu %u called\n", cpu);
+	cpufreq_update_policy(cpu);
+}
+
 static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
 {
 	struct device *dev = get_cpu_device(cpu);
@@ -1404,15 +1412,6 @@ static void cpufreq_remove_dev(struct device *dev, struct subsys_interface *sif)
 		cpufreq_policy_free(policy, true);
 }
 
-static void handle_update(struct work_struct *work)
-{
-	struct cpufreq_policy *policy =
-		container_of(work, struct cpufreq_policy, update);
-	unsigned int cpu = policy->cpu;
-	pr_debug("handle_update for cpu %u called\n", cpu);
-	cpufreq_update_policy(cpu);
-}
-
 /**
  *	cpufreq_out_of_sync - If actual and saved CPU frequency differs, we're
  *	in deep trouble.
-- 
2.7.1.410.g6faf27b

