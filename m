From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 2/4] cpufreq: Add ondemand as a generic policy
Date: Fri,  4 Dec 2015 16:08:36 -0800
Message-ID: <1449274118-15575-3-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1449274118-15575-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:41632 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752876AbbLEAJs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 4 Dec 2015 19:09:48 -0500
In-Reply-To: <1449274118-15575-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, len.brown@intel.com, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Allow ondemand policy as a supported generic policy. Client drivers can
enable this policy by using get_available_policies() callback.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/cpufreq.c | 8 ++++++++
 include/linux/cpufreq.h   | 3 ++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 6fc6e39d..86579fa 100644
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
index 8259c3c..65f85d5 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -232,7 +232,7 @@ struct cpufreq_driver {
 
 	/* Get available generic policies */
 	int		(*get_available_policies)(u8 *mask);
-	/* define one out of two */
+	/* define one out of three */
 	int		(*setpolicy)(struct cpufreq_policy *policy);
 
 	/*
@@ -434,6 +434,7 @@ static inline unsigned long cpufreq_scale(unsigned long old, u_int div,
  */
 #define CPUFREQ_POLICY_POWERSAVE	(1)
 #define CPUFREQ_POLICY_PERFORMANCE	(2)
+#define CPUFREQ_POLICY_ONDEMAND		(4)
 
 /* Governor Events */
 #define CPUFREQ_GOV_START	1
-- 
2.4.3

