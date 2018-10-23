From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH] cpufreq: intel_pstate: Fix compilation for !CONFIG_ACPI
Date: Tue, 23 Oct 2018 20:54:29 +0200
Message-ID: <20181023185429.GA6756@light.dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, srinivas.pandruvada@linux.intel.com, lenb@kernel.org
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


Fixes: 86d333a8cc7f ("cpufreq: intel_pstate: Add base_frequency attribute")
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 49c0abf2d48f..50c5699970c5 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -390,11 +390,6 @@ static int intel_pstate_get_cppc_guranteed(int cpu)
 static void intel_pstate_set_itmt_prio(int cpu)
 {
 }
-
-static int intel_pstate_get_cppc_guranteed(int cpu)
-{
-	return -ENOTSUPP;
-}
 #endif
 
 static void intel_pstate_init_acpi_perf_limits(struct cpufreq_policy *policy)
@@ -490,6 +485,11 @@ static inline bool intel_pstate_acpi_pm_profile_server(void)
 {
 	return false;
 }
+
+static int intel_pstate_get_cppc_guranteed(int cpu)
+{
+	return -ENOTSUPP;
+}
 #endif
 
 static inline void update_turbo_state(void)
