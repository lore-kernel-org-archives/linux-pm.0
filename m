From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 2/4] cpufreq: Pass policy pointer to cpufreq_parse_governor()
Date: Thu, 23 Nov 2017 01:24:05 +0100
Message-ID: <2577003.K0dSmlKcgZ@aspire.rjw.lan>
References: <1655574.Es7zYAeW1r@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1655574.Es7zYAeW1r@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Pass policy pointer to cpufreq_parse_governor() instead of passing
pointers to two members of it so as to make the code slightly more
straightforward.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c |   16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -601,17 +601,17 @@ static struct cpufreq_governor *find_gov
 /**
  * cpufreq_parse_governor - parse a governor string
  */
-static int cpufreq_parse_governor(char *str_governor, unsigned int *policy,
-				struct cpufreq_governor **governor)
+static int cpufreq_parse_governor(char *str_governor,
+				  struct cpufreq_policy *policy)
 {
 	if (cpufreq_driver->setpolicy) {
 		if (!strncasecmp(str_governor, "performance", CPUFREQ_NAME_LEN)) {
-			*policy = CPUFREQ_POLICY_PERFORMANCE;
+			policy->policy = CPUFREQ_POLICY_PERFORMANCE;
 			return 0;
 		}
 
 		if (!strncasecmp(str_governor, "powersave", CPUFREQ_NAME_LEN)) {
-			*policy = CPUFREQ_POLICY_POWERSAVE;
+			policy->policy = CPUFREQ_POLICY_POWERSAVE;
 			return 0;
 		}
 	} else {
@@ -637,7 +637,7 @@ static int cpufreq_parse_governor(char *
 		mutex_unlock(&cpufreq_governor_mutex);
 
 		if (t) {
-			*governor = t;
+			policy->governor = t;
 			return 0;
 		}
 	}
@@ -762,8 +762,7 @@ static ssize_t store_scaling_governor(st
 	if (ret != 1)
 		return -EINVAL;
 
-	if (cpufreq_parse_governor(str_governor, &new_policy.policy,
-						&new_policy.governor))
+	if (cpufreq_parse_governor(str_governor, &new_policy))
 		return -EINVAL;
 
 	ret = cpufreq_set_policy(policy, &new_policy);
@@ -1046,8 +1045,7 @@ static int cpufreq_init_policy(struct cp
 		if (policy->last_policy)
 			new_policy.policy = policy->last_policy;
 		else
-			cpufreq_parse_governor(gov->name, &new_policy.policy,
-					       NULL);
+			cpufreq_parse_governor(gov->name, &new_policy);
 	}
 	/* set default policy */
 	return cpufreq_set_policy(policy, &new_policy);
