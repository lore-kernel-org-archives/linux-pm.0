From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 2/4] cpufreq: Add ondemand as a generic policy
Date: Tue,  8 Dec 2015 14:31:28 -0800
Message-ID: <1449613890-10403-3-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1449613890-10403-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:60772 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750752AbbLHWcp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 8 Dec 2015 17:32:45 -0500
In-Reply-To: <1449613890-10403-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rafael.j.wysocki@intel.com, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, prarit@redhat.com, trenn@suse.de, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Allow ondemand policy as a supported generic policy. Client drivers can
enable this policy by setting struct cpufreq->available_policies during
init() callback.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

---
 drivers/cpufreq/cpufreq.c | 8 ++++++++
 include/linux/cpufreq.h   | 3 ++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 286eaec..7d45fb6 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -528,6 +528,10 @@ static int cpufreq_parse_governor(char *str_governor, unsigned int *policy,
 						CPUFREQ_NAME_LEN)) {
 			*policy = CPUFREQ_POLICY_POWERSAVE;
 			err = 0;
+		} else if (!strncasecmp(str_governor, "ondemand",
+					CPUFREQ_NAME_LEN)) {
+			*policy = CPUFREQ_POLICY_ONDEMAND;
+			err = 0;
 		}
 	} else {
 		struct cpufreq_governor *t;
@@ -640,6 +644,8 @@ static ssize_t show_scaling_governor(struct cpufreq_policy *policy, char *buf)
 		return sprintf(buf, "powersave\n");
 	else if (policy->policy == CPUFREQ_POLICY_PERFORMANCE)
 		return sprintf(buf, "performance\n");
+	else if (policy->policy == CPUFREQ_POLICY_ONDEMAND)
+		return sprintf(buf, "ondemand\n");
 	else if (policy->governor)
 		return scnprintf(buf, CPUFREQ_NAME_PLEN, "%s\n",
 				policy->governor->name);
@@ -692,6 +698,8 @@ static ssize_t show_scaling_available_governors(struct cpufreq_policy *policy,
 			i += sprintf(buf, "performance ");
 		if (policy->available_policies & CPUFREQ_POLICY_POWERSAVE)
 			i += sprintf(&buf[i], "powersave ");
+		if (policy->available_policies & CPUFREQ_POLICY_ONDEMAND)
+			i += sprintf(&buf[i], "ondemand ");
 		goto out;
 	}
 
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 7cc17df..0b9e119 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -230,7 +230,7 @@ struct cpufreq_driver {
 	int		(*init)(struct cpufreq_policy *policy);
 	int		(*verify)(struct cpufreq_policy *policy);
 
-	/* define one out of two */
+	/* define one out of three */
 	int		(*setpolicy)(struct cpufreq_policy *policy);
 
 	/*
@@ -432,6 +432,7 @@ static inline unsigned long cpufreq_scale(unsigned long old, u_int div,
  */
 #define CPUFREQ_POLICY_POWERSAVE	(1)
 #define CPUFREQ_POLICY_PERFORMANCE	(2)
+#define CPUFREQ_POLICY_ONDEMAND		(4)
 
 /* Governor Events */
 #define CPUFREQ_GOV_START	1
-- 
2.4.3

