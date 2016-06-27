From: Jisheng Zhang <jszhang@marvell.com>
Subject: [PATCH v2 2/3] intel_pstate: add __init/__initdata marker to some functions/variables
Date: Mon, 27 Jun 2016 18:07:17 +0800
Message-ID: <1467022038-924-3-git-send-email-jszhang@marvell.com>
References: <1467022038-924-1-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467022038-924-1-git-send-email-jszhang@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
To: srinivas.pandruvada@linux.intel.com, lenb@kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Jisheng Zhang <jszhang@marvell.com>
List-Id: linux-pm@vger.kernel.org

These functions/variables are not needed after booting, so mark them
as __init or __initdata.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/intel_pstate.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 44099e9..861bcba 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1355,7 +1355,7 @@ static const struct x86_cpu_id intel_pstate_cpu_ids[] = {
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_pstate_cpu_ids);
 
-static const struct x86_cpu_id intel_pstate_cpu_oob_ids[] = {
+static const struct x86_cpu_id intel_pstate_cpu_oob_ids[] __initconst = {
 	ICPU(0x56, core_params),
 	{}
 };
@@ -1577,9 +1577,9 @@ static struct cpufreq_driver intel_pstate_driver = {
 static int no_load __initdata;
 static int no_hwp __initdata;
 static int hwp_only __initdata;
-static unsigned int force_load;
+static unsigned int force_load __initdata;
 
-static int intel_pstate_msrs_not_valid(void)
+static int __init intel_pstate_msrs_not_valid(void)
 {
 	if (!pstate_funcs.get_max() ||
 	    !pstate_funcs.get_min() ||
@@ -1589,7 +1589,7 @@ static int intel_pstate_msrs_not_valid(void)
 	return 0;
 }
 
-static void copy_pid_params(struct pstate_adjust_policy *policy)
+static void __init copy_pid_params(struct pstate_adjust_policy *policy)
 {
 	pid_params.sample_rate_ms = policy->sample_rate_ms;
 	pid_params.sample_rate_ns = pid_params.sample_rate_ms * NSEC_PER_MSEC;
@@ -1600,7 +1600,7 @@ static void copy_pid_params(struct pstate_adjust_policy *policy)
 	pid_params.setpoint = policy->setpoint;
 }
 
-static void copy_cpu_funcs(struct pstate_funcs *funcs)
+static void __init copy_cpu_funcs(struct pstate_funcs *funcs)
 {
 	pstate_funcs.get_max   = funcs->get_max;
 	pstate_funcs.get_max_physical = funcs->get_max_physical;
@@ -1615,7 +1615,7 @@ static void copy_cpu_funcs(struct pstate_funcs *funcs)
 
 #ifdef CONFIG_ACPI
 
-static bool intel_pstate_no_acpi_pss(void)
+static bool __init intel_pstate_no_acpi_pss(void)
 {
 	int i;
 
@@ -1644,7 +1644,7 @@ static bool intel_pstate_no_acpi_pss(void)
 	return true;
 }
 
-static bool intel_pstate_has_acpi_ppc(void)
+static bool __init intel_pstate_has_acpi_ppc(void)
 {
 	int i;
 
@@ -1672,7 +1672,7 @@ struct hw_vendor_info {
 };
 
 /* Hardware vendor-specific info that has its own power management modes */
-static struct hw_vendor_info vendor_info[] = {
+static struct hw_vendor_info vendor_info[] __initdata = {
 	{1, "HP    ", "ProLiant", PSS},
 	{1, "ORACLE", "X4-2    ", PPC},
 	{1, "ORACLE", "X4-2L   ", PPC},
@@ -1691,7 +1691,7 @@ static struct hw_vendor_info vendor_info[] = {
 	{0, "", ""},
 };
 
-static bool intel_pstate_platform_pwr_mgmt_exists(void)
+static bool __init intel_pstate_platform_pwr_mgmt_exists(void)
 {
 	struct acpi_table_header hdr;
 	struct hw_vendor_info *v_info;
-- 
2.8.1
