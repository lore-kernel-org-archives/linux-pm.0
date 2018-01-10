From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 2/2] cpufreq: intel_pstate: Add Skylake servers support
Date: Wed, 10 Jan 2018 11:38:52 -0800
Message-ID: <20180110193852.63667-2-srinivas.pandruvada@linux.intel.com>
References: <20180110193852.63667-1-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180110193852.63667-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lenb@kernel.org, rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Currently intel_pstate can function only in HWP mode on Skylake servers.
When HWP feature is not enabled on the processor then acpi-cpufreq is
driver is used.

Based on the power and performance tests using intel_pstate scaling
algorithm the results are comparable. But intel_pstate brings in
additional features:
- Display of turbo frequency range, which many users like to see
- Place limits in the turbo frequency range when platform allows

Since these tests are done only using non PID algorithm introduced in
kernel version 4.14, this patch is not a backport candidate. So each user
has to carefully weigh the benefits before he backports.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 3b6616b15c59..7edf7a0e5a96 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1620,6 +1620,7 @@ static const struct x86_cpu_id intel_pstate_cpu_ids[] = {
 	ICPU(INTEL_FAM6_XEON_PHI_KNM,		knl_funcs),
 	ICPU(INTEL_FAM6_ATOM_GOLDMONT,		core_funcs),
 	ICPU(INTEL_FAM6_ATOM_GEMINI_LAKE,       core_funcs),
+	ICPU(INTEL_FAM6_SKYLAKE_X,		core_funcs),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_pstate_cpu_ids);
-- 
2.13.6
