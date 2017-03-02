From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 2/3] cpufreq: intel_pstate: Fix intel_cpufreq_verify_policy()
Date: Thu, 02 Mar 2017 23:24:36 +0100
Message-ID: <2885960.26GOj6xOKI@aspire.rjw.lan>
References: <1573986.gdsgdO0VUn@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1573986.gdsgdO0VUn@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The intel_pstate_update_perf_limits() called from
intel_cpufreq_verify_policy() may cause global P-state limits
to change which is generally confusing and unnecessary.

In the passive mode the global limits are only applied to the
frequency selected by the scaling governor (they are not taken
into account by governors when making decisions anyway), so making
them follow the per-policy limits serves no purpose and may go
against user expectations (as it generally causes the global
attributes in sysfs to change even though they have not been
written to in some cases).

Fix that by dropping the intel_pstate_update_perf_limits()
invocation from intel_cpufreq_verify_policy() (which also
reduces the code size by a few lines).

This change does not affect the per-CPU limits case, because those
limits allow any P-state to be set by default in the passive mode
and it removes the only piece of code updating them in that mode,
so the per-policy settings will be the only ones taken into account
in that case as expected.

Fixes: 001c76f05b01 (cpufreq: intel_pstate: Generic governors support)
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |   10 ----------
 1 file changed, 10 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -2306,7 +2306,6 @@ static struct cpufreq_driver intel_pstat
 static int intel_cpufreq_verify_policy(struct cpufreq_policy *policy)
 {
 	struct cpudata *cpu = all_cpu_data[policy->cpu];
-	struct perf_limits *perf_limits = limits;
 
 	update_turbo_state();
 	policy->cpuinfo.max_freq = limits->turbo_disabled ?
@@ -2314,15 +2313,6 @@ static int intel_cpufreq_verify_policy(s
 
 	cpufreq_verify_within_cpu_limits(policy);
 
-	if (per_cpu_limits)
-		perf_limits = cpu->perf_limits;
-
-	mutex_lock(&intel_pstate_limits_lock);
-
-	intel_pstate_update_perf_limits(policy, perf_limits);
-
-	mutex_unlock(&intel_pstate_limits_lock);
-
 	return 0;
 }
 
