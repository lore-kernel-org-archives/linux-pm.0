From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 2/2] cpufreq: intel_pstate: Also use cppc nominal_perf for base_frequency
Date: Fri, 22 Mar 2019 15:45:20 -0700
Message-ID: <20190322224520.6740-3-srinivas.pandruvada@linux.intel.com>
References: <20190322224520.6740-1-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190322224520.6740-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, viresh.kumar@linaro.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, pprakash@codeaurora.org, wangxiongfeng2@huawei.com, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "4 . 20+" <stable@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

ACPI specifications stat that if the "Guaranteed Performance Register" is
not implemented, OSPM assumes guaranteed performance is always equal to
nominal performance. So for invalid and unimplemented guaranteed
performance register, use nominal performance as guaranteed performance.

This change will fallback to nominal_perf when guranteed_perf is invalid.
If nominal_perf is also invalid, then fallback to existing implementation,
which is to read from HWP Capabilities MSR.

Fixes: 86d333a8cc7f ("cpufreq: intel_pstate: Add base_frequency attribute")
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: 4.20+ <stable@vger.kernel.org> # 4.20+
---
 drivers/cpufreq/intel_pstate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 7b4b0a7ac68b..e16dea241c55 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -385,6 +385,9 @@ static int intel_pstate_get_cppc_guranteed(int cpu)
 	if (ret)
 		return ret;
 
+	if (!cppc_perf.guaranteed_perf)
+		return cppc_perf.nominal_perf;
+
 	return cppc_perf.guaranteed_perf;
 }
 
-- 
2.17.2
