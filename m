From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [RFC/RFT] [PATCH v2 1/6] cpufreq: intel_pstate: Cache last HWP capability/request value
Date: Wed, 23 May 2018 18:47:33 -0700
Message-ID: <20180524014738.52924-2-srinivas.pandruvada@linux.intel.com>
References: <20180524014738.52924-1-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180524014738.52924-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lenb@kernel.org, rjw@rjwysocki.net, peterz@infradead.org, mgorman@techsingularity.net
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, juri.lelli@redhat.com, viresh.kumar@linaro.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Store the HWP request value last set using MSR_HWP_REQUEST. This will
allow us to save cycles used for reading last HWP request value for
dynamic update of MSR_HWP_REQUEST.
Also store HWP capability MSR value in local memory, to avoid reading
MSR later for calculating limits for dynamic update of MSR_HWP_REQUEST.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 17e566afbb41..baed29c768e7 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -221,6 +221,8 @@ struct global_params {
  *			preference/bias
  * @epp_saved:		Saved EPP/EPB during system suspend or CPU offline
  *			operation
+ * @hwp_req_cached:	Cached value of the last HWP Request MSR
+ * @hwp_cap_cached:	Cached value of the last HWP Capabilities MSR
  *
  * This structure stores per CPU instance data for all CPUs.
  */
@@ -253,6 +255,8 @@ struct cpudata {
 	s16 epp_policy;
 	s16 epp_default;
 	s16 epp_saved;
+	u64 hwp_req_cached;
+	u64 hwp_cap_cached;
 };
 
 static struct cpudata **all_cpu_data;
@@ -689,6 +693,7 @@ static void intel_pstate_get_hwp_max(unsigned int cpu, int *phy_max,
 	u64 cap;
 
 	rdmsrl_on_cpu(cpu, MSR_HWP_CAPABILITIES, &cap);
+	WRITE_ONCE(all_cpu_data[cpu]->hwp_cap_cached, cap);
 	if (global.no_turbo)
 		*current_max = HWP_GUARANTEED_PERF(cap);
 	else
@@ -763,6 +768,7 @@ static void intel_pstate_hwp_set(unsigned int cpu)
 		intel_pstate_set_epb(cpu, epp);
 	}
 skip_epp:
+	WRITE_ONCE(cpu_data->hwp_req_cached, value);
 	wrmsrl_on_cpu(cpu, MSR_HWP_REQUEST, value);
 }
 
-- 
2.13.6
