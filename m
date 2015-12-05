From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 1/4] cpufreq: Add configurable generic policies
Date: Fri,  4 Dec 2015 16:08:35 -0800
Message-ID: <1449274118-15575-2-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1449274118-15575-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:41632 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752413AbbLEAJs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 4 Dec 2015 19:09:48 -0500
In-Reply-To: <1449274118-15575-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, len.brown@intel.com, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

For drivers using cpufreq_driver->setpolicy callback, by default two
policies are available (performance and powersave). The client drivers
can't change them, even if there is no support for a policy.
This change adds a new callback get_available_policies() which provides,
a mask of supported policies. If there is no callback then only two
polices are supported "performance powersave" matching current
implementation.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/cpufreq.c | 14 +++++++++++++-
 include/linux/cpufreq.h   |  3 +++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 8412ce5..6fc6e39d 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -688,7 +688,10 @@ static ssize_t show_scaling_available_governors(struct cpufreq_policy *policy,
 	struct cpufreq_governor *t;
 
 	if (!has_target()) {
-		i += sprintf(buf, "performance powersave");
+		if (policy->available_policies & CPUFREQ_POLICY_PERFORMANCE)
+			i += sprintf(buf, "performance ");
+		if (policy->available_policies & CPUFREQ_POLICY_POWERSAVE)
+			i += sprintf(&buf[i], "powersave ");
 		goto out;
 	}
 
@@ -963,9 +966,18 @@ static int cpufreq_init_policy(struct cpufreq_policy *policy)
 {
 	struct cpufreq_governor *gov = NULL;
 	struct cpufreq_policy new_policy;
+	u8 mask;
 
 	memcpy(&new_policy, policy, sizeof(*policy));
 
+	if (cpufreq_driver->get_available_policies) {
+		if (!cpufreq_driver->get_available_policies(&mask))
+			policy->available_policies = mask;
+	}
+	if (!policy->available_policies)
+		policy->available_policies = CPUFREQ_POLICY_PERFORMANCE |
+						CPUFREQ_POLICY_POWERSAVE;
+
 	/* Update governor of new_policy to the governor used before hotplug */
 	gov = find_governor(policy->last_governor);
 	if (gov)
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 177c768..8259c3c 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -76,6 +76,7 @@ struct cpufreq_policy {
 	unsigned int		restore_freq; /* = policy->cur before transition */
 	unsigned int		suspend_freq; /* freq to set during suspend */
 
+	u8			available_policies;
 	unsigned int		policy; /* see above */
 	unsigned int		last_policy; /* policy before unplug */
 	struct cpufreq_governor	*governor; /* see below */
@@ -229,6 +230,8 @@ struct cpufreq_driver {
 	int		(*init)(struct cpufreq_policy *policy);
 	int		(*verify)(struct cpufreq_policy *policy);
 
+	/* Get available generic policies */
+	int		(*get_available_policies)(u8 *mask);
 	/* define one out of two */
 	int		(*setpolicy)(struct cpufreq_policy *policy);
 
-- 
2.4.3

