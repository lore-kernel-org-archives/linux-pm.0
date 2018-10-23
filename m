From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH v2] cpufreq: intel_pstate: Fix compilation for !CONFIG_ACPI
Date: Tue, 23 Oct 2018 21:54:04 +0200
Message-ID: <20181023195403.GA3094@light.dominikbrodowski.net>
References: <20181023185429.GA6756@light.dominikbrodowski.net>
 <e8e018e267434cabc2b8db434a3576c082ab3fff.camel@linux.intel.com>
 <20181023193405.pxfl4vyazt7rtc3x@isilmar-4.linta.de>
 <b95b247b5dd85b0839a9fa6167fd1682578fb92b.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b95b247b5dd85b0839a9fa6167fd1682578fb92b.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-pm@vger.kernel.org, lenb@kernel.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

While at it, add a few comments which config options #ifdef
and #else statements refer to.

Fixes: 86d333a8cc7f ("cpufreq: intel_pstate: Add base_frequency attribute")
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 49c0abf2d48f..9578312e43f2 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -386,16 +386,11 @@ static int intel_pstate_get_cppc_guranteed(int cpu)
 	return cppc_perf.guaranteed_perf;
 }
 
-#else
+#else /* CONFIG_ACPI_CPPC_LIB */
 static void intel_pstate_set_itmt_prio(int cpu)
 {
 }
-
-static int intel_pstate_get_cppc_guranteed(int cpu)
-{
-	return -ENOTSUPP;
-}
-#endif
+#endif /* CONFIG_ACPI_CPPC_LIB */
 
 static void intel_pstate_init_acpi_perf_limits(struct cpufreq_policy *policy)
 {
@@ -477,7 +472,7 @@ static void intel_pstate_exit_perf_limits(struct cpufreq_policy *policy)
 
 	acpi_processor_unregister_performance(policy->cpu);
 }
-#else
+#else /* CONFIG_ACPI */
 static inline void intel_pstate_init_acpi_perf_limits(struct cpufreq_policy *policy)
 {
 }
@@ -490,7 +485,14 @@ static inline bool intel_pstate_acpi_pm_profile_server(void)
 {
 	return false;
 }
-#endif
+#endif /* CONFIG_ACPI */
+
+#ifndef CONFIG_ACPI_CPPC_LIB
+static int intel_pstate_get_cppc_guranteed(int cpu)
+{
+	return -ENOTSUPP;
+}
+#endif /* CONFIG_ACPI_CPPC_LIB */
 
 static inline void update_turbo_state(void)
 {
