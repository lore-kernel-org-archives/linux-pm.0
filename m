From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] intel_pstate: Simplify conditional in intel_pstate_set_policy()
Date: Thu, 12 May 2016 00:46:45 +0200
Message-ID: <3708662.2e5qAbF2Fs@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

One of the if () statements in intel_pstate_set_policy() causes
another if () to be evaluated if the condition is true and it
doesn't do anything else, so merge the two if () statements into
one.

No functional changes.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -1449,12 +1449,11 @@ static int intel_pstate_set_policy(struc
 	intel_pstate_clear_update_util_hook(policy->cpu);
 
 	cpu = all_cpu_data[0];
-	if (cpu->pstate.max_pstate_physical > cpu->pstate.max_pstate) {
-		if (policy->max < policy->cpuinfo.max_freq &&
-		    policy->max > cpu->pstate.max_pstate * cpu->pstate.scaling) {
-			pr_debug("policy->max > max non turbo frequency\n");
-			policy->max = policy->cpuinfo.max_freq;
-		}
+	if (cpu->pstate.max_pstate_physical > cpu->pstate.max_pstate &&
+	    policy->max < policy->cpuinfo.max_freq &&
+	    policy->max > cpu->pstate.max_pstate * cpu->pstate.scaling) {
+		pr_debug("policy->max > max non turbo frequency\n");
+		policy->max = policy->cpuinfo.max_freq;
 	}
 
 	if (policy->policy == CPUFREQ_POLICY_PERFORMANCE) {
