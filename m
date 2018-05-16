From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [RFC/RFT] [PATCH 03/10] cpufreq: intel_pstate: Utility functions to boost HWP performance limits
Date: Tue, 15 May 2018 21:49:04 -0700
Message-ID: <20180516044911.28797-4-srinivas.pandruvada@linux.intel.com>
References: <20180516044911.28797-1-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180516044911.28797-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: srinivas.pandruvada@linux.intel.com, tglx@linutronix.de, mingo@redhat.com, peterz@infradead.org, bp@suse.de, lenb@kernel.org, rjw@rjwysocki.net, mgorman@techsingularity.net
Cc: x86@kernel.org, linux-pm@vger.kernel.org, viresh.kumar@linaro.org, juri.lelli@arm.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Setup necessary infrastructure to be able to boost HWP performance on a
remote CPU. First initialize data structure to be able to use
smp_call_function_single_async(). The boost up function simply set HWP
min to HWP max value and EPP to 0. The boost down function simply restores
to last cached HWP Request value.

To avoid reading HWP Request MSR during dynamic update, the HWP Request
MSR value is cached in the local memory. This caching is done whenever
HWP request MSR is modified during driver init on in setpolicy() callback
path.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index f686bbe..dc7dfa9 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -221,6 +221,9 @@ struct global_params {
  *			preference/bias
  * @epp_saved:		Saved EPP/EPB during system suspend or CPU offline
  *			operation
+ * @hwp_req_cached:	Cached value of the last HWP request MSR
+ * @csd:		A structure used to issue SMP async call, which
+ *			defines callback and arguments
  *
  * This structure stores per CPU instance data for all CPUs.
  */
@@ -253,6 +256,8 @@ struct cpudata {
 	s16 epp_policy;
 	s16 epp_default;
 	s16 epp_saved;
+	u64 hwp_req_cached;
+	call_single_data_t csd;
 };
 
 static struct cpudata **all_cpu_data;
@@ -763,6 +768,7 @@ static void intel_pstate_hwp_set(unsigned int cpu)
 		intel_pstate_set_epb(cpu, epp);
 	}
 skip_epp:
+	cpu_data->hwp_req_cached = value;
 	wrmsrl_on_cpu(cpu, MSR_HWP_REQUEST, value);
 }
 
@@ -1381,6 +1387,39 @@ static void intel_pstate_get_cpu_pstates(struct cpudata *cpu)
 	intel_pstate_set_min_pstate(cpu);
 }
 
+
+static inline void intel_pstate_hwp_boost_up(struct cpudata *cpu)
+{
+	u64 hwp_req;
+	u8 max;
+
+	max = (u8) (cpu->hwp_req_cached >> 8);
+
+	hwp_req = cpu->hwp_req_cached & ~GENMASK_ULL(31, 24);
+	hwp_req = (hwp_req & ~GENMASK_ULL(7, 0)) | max;
+
+	wrmsrl(MSR_HWP_REQUEST, hwp_req);
+}
+
+static inline void intel_pstate_hwp_boost_down(struct cpudata *cpu)
+{
+	wrmsrl(MSR_HWP_REQUEST, cpu->hwp_req_cached);
+}
+
+static void intel_pstate_hwp_boost_up_local(void *arg)
+{
+	struct cpudata *cpu = arg;
+
+	intel_pstate_hwp_boost_up(cpu);
+}
+
+static void csd_init(struct cpudata *cpu)
+{
+	cpu->csd.flags = 0;
+	cpu->csd.func = intel_pstate_hwp_boost_up_local;
+	cpu->csd.info = cpu;
+}
+
 static inline void intel_pstate_calc_avg_perf(struct cpudata *cpu)
 {
 	struct sample *sample = &cpu->sample;
@@ -1894,6 +1933,9 @@ static int __intel_pstate_cpu_init(struct cpufreq_policy *policy)
 
 	policy->fast_switch_possible = true;
 
+	if (hwp_active)
+		csd_init(cpu);
+
 	return 0;
 }
 
-- 
2.9.5
