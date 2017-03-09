From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] cpufreq: intel_pstate: Drop redundant wrapper function
Date: Thu, 09 Mar 2017 16:30:38 +0100
Message-ID: <8470689.BtHKNtPoNa@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

intel_pstate_hwp_set_policy() is a wrapper around
intel_pstate_hwp_set(), but the only value it adds is to check
hwp_active before calling the latter and one of its two callers
has already checked hwp_active before that happens, so in that
code path the additional check is redundant and using the wrapper
is rather pointless.

For this reason, drop intel_pstate_hwp_set_policy() and make its
callers invoke intel_pstate_hwp_set() directly (after checking
hwp_active).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |   18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -935,14 +935,6 @@ skip_epp:
 	}
 }
 
-static int intel_pstate_hwp_set_policy(struct cpufreq_policy *policy)
-{
-	if (hwp_active)
-		intel_pstate_hwp_set(policy);
-
-	return 0;
-}
-
 static int intel_pstate_hwp_save_state(struct cpufreq_policy *policy)
 {
 	struct cpudata *cpu_data = all_cpu_data[policy->cpu];
@@ -957,20 +949,17 @@ static int intel_pstate_hwp_save_state(s
 
 static int intel_pstate_resume(struct cpufreq_policy *policy)
 {
-	int ret;
-
 	if (!hwp_active)
 		return 0;
 
 	mutex_lock(&intel_pstate_limits_lock);
 
 	all_cpu_data[policy->cpu]->epp_policy = 0;
-
-	ret = intel_pstate_hwp_set_policy(policy);
+	intel_pstate_hwp_set(policy);
 
 	mutex_unlock(&intel_pstate_limits_lock);
 
-	return ret;
+	return 0;
 }
 
 static void intel_pstate_update_policies(void)
@@ -2174,7 +2163,8 @@ static int intel_pstate_set_policy(struc
 
 	intel_pstate_set_update_util_hook(policy->cpu);
 
-	intel_pstate_hwp_set_policy(policy);
+	if (hwp_active)
+		intel_pstate_hwp_set(policy);
 
 	mutex_unlock(&intel_pstate_limits_lock);
 
