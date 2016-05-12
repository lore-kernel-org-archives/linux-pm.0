From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 1/2] cpufreq: governor: CPUFREQ_GOV_POLICY_EXIT never fails
Date: Thu, 12 May 2016 15:13:35 +0200
Message-ID: <10942818.DP54y8SPGY@vostro.rjw.lan>
References: <4540082.RMPf3KxPDh@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4540082.RMPf3KxPDh@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

None of the cpufreq governors currently in the tree will ever fail
an invocation of the ->governor() callback with the event argument
equal to CPUFREQ_GOV_POLICY_EXIT (unless invoked with incorrect
arguments which doesn't matter anyway) and it wouldn't really
make sense to fail it, because the caller won't be able to handle
that failure in a meaningful way.

Accordingly, rearrange the code in the core to make it clear that
this call never fails.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c |   35 ++++++++++++-----------------------
 1 file changed, 12 insertions(+), 23 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -78,9 +78,9 @@ static int cpufreq_governor(struct cpufr
 static unsigned int __cpufreq_get(struct cpufreq_policy *policy);
 static int cpufreq_start_governor(struct cpufreq_policy *policy);
 
-static inline int cpufreq_exit_governor(struct cpufreq_policy *policy)
+static inline void cpufreq_exit_governor(struct cpufreq_policy *policy)
 {
-	return cpufreq_governor(policy, CPUFREQ_GOV_POLICY_EXIT);
+	(void)cpufreq_governor(policy, CPUFREQ_GOV_POLICY_EXIT);
 }
 
 /**
@@ -1387,12 +1387,8 @@ static void cpufreq_offline(unsigned int
 	if (cpufreq_driver->stop_cpu)
 		cpufreq_driver->stop_cpu(policy);
 
-	/* If cpu is last user of policy, free policy */
-	if (has_target()) {
-		ret = cpufreq_exit_governor(policy);
-		if (ret)
-			pr_err("%s: Failed to exit governor\n", __func__);
-	}
+	if (has_target())
+		cpufreq_exit_governor(policy);
 
 	/*
 	 * Perform the ->exit() even during light-weight tear-down,
@@ -2049,16 +2045,15 @@ static int cpufreq_governor(struct cpufr
 
 	ret = policy->governor->governor(policy, event);
 
-	if (!ret) {
-		if (event == CPUFREQ_GOV_POLICY_INIT)
+	if (event == CPUFREQ_GOV_POLICY_INIT) {
+		if (ret)
+			module_put(policy->governor->owner);
+		else
 			policy->governor->initialized++;
-		else if (event == CPUFREQ_GOV_POLICY_EXIT)
-			policy->governor->initialized--;
-	}
-
-	if (((event == CPUFREQ_GOV_POLICY_INIT) && ret) ||
-			((event == CPUFREQ_GOV_POLICY_EXIT) && !ret))
+	} else if (event == CPUFREQ_GOV_POLICY_EXIT) {
+		policy->governor->initialized--;
 		module_put(policy->governor->owner);
+	}
 
 	return ret;
 }
@@ -2228,13 +2223,7 @@ static int cpufreq_set_policy(struct cpu
 				 __func__, old_gov->name, ret);
 			return ret;
 		}
-
-		ret = cpufreq_exit_governor(policy);
-		if (ret) {
-			pr_err("%s: Failed to Exit Governor: %s (%d)\n",
-			       __func__, old_gov->name, ret);
-			return ret;
-		}
+		cpufreq_exit_governor(policy);
 	}
 
 	/* start new governor */
