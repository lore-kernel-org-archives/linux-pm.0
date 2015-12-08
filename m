From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 1/4] cpufreq: Add configurable generic policies
Date: Tue,  8 Dec 2015 14:31:27 -0800
Message-ID: <1449613890-10403-2-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1449613890-10403-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:60772 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750815AbbLHWcp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 8 Dec 2015 17:32:45 -0500
In-Reply-To: <1449613890-10403-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rafael.j.wysocki@intel.com, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, prarit@redhat.com, trenn@suse.de, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

For drivers using cpufreq_driver->setpolicy callback, by default two
policies are available (performance and powersave). The client drivers
can't change them, even if there is no support for a policy.
This change adds a new field "available_policies" in the struct
cpufreq_policy. The client driver can optionally set this field during
init() callback. If the client driver doesn't set this field then the
default policies are "performance powersave" matching current
implementation.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/cpufreq.c | 9 ++++++++-
 include/linux/cpufreq.h   | 1 +
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 8412ce5..286eaec 100644
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
 
@@ -966,6 +969,10 @@ static int cpufreq_init_policy(struct cpufreq_policy *policy)
 
 	memcpy(&new_policy, policy, sizeof(*policy));
 
+	if (!policy->available_policies)
+		policy->available_policies = CPUFREQ_POLICY_PERFORMANCE |
+						CPUFREQ_POLICY_POWERSAVE;
+
 	/* Update governor of new_policy to the governor used before hotplug */
 	gov = find_governor(policy->last_governor);
 	if (gov)
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 177c768..7cc17df 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -76,6 +76,7 @@ struct cpufreq_policy {
 	unsigned int		restore_freq; /* = policy->cur before transition */
 	unsigned int		suspend_freq; /* freq to set during suspend */
 
+	u8			available_policies;
 	unsigned int		policy; /* see above */
 	unsigned int		last_policy; /* policy before unplug */
 	struct cpufreq_governor	*governor; /* see below */
-- 
2.4.3

