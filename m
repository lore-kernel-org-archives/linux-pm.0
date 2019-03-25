From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 2/2] cpufreq: intel_pstate: Also use cppc nominal_perf for base_frequency
Date: Mon, 25 Mar 2019 09:04:40 -0700
Message-ID: <20190325160440.7575-3-srinivas.pandruvada@linux.intel.com>
References: <20190325160440.7575-1-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190325160440.7575-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, viresh.kumar@linaro.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, pprakash@codeaurora.org, wangxiongfeng2@huawei.com, srinivas.pandruvada@linux.intel.com
List-Id: linux-pm@vger.kernel.org

ACPI specifications stat that if the "Guaranteed Performance Register" is
not implemented, OSPM assumes guaranteed performance is always equal to
nominal performance. So for invalid and unimplemented guaranteed
performance register, use nominal performance as guaranteed performance.

This change will fallback to nominal_perf when guranteed_perf is invalid.
If nominal_perf is also invalid, then fallback to existing implementation,
which is to read from HWP Capabilities MSR.

Fixes: 86d333a8cc7f ("cpufreq: intel_pstate: Add base_frequency attribute")
Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: 4.20+ <stable@vger.kernel.org> # 4.20+
---
 drivers/cpufreq/intel_pstate.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index e22f0dbaebb1..b599c7318aab 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -385,7 +385,10 @@ static int intel_pstate_get_cppc_guranteed(int cpu)
 	if (ret)
 		return ret;
 
-	return cppc_perf.guaranteed_perf;
+	if (cppc_perf.guaranteed_perf)
+		return cppc_perf.guaranteed_perf;
+
+	return cppc_perf.nominal_perf;
 }
 
 #else /* CONFIG_ACPI_CPPC_LIB */
-- 
2.17.2
