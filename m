From: Len Brown <lenb@kernel.org>
Subject: [PATCH 3/4] tools/power turbostat: KNL workaround for %Busy and Avg_MHz
Date: Sat, 26 Sep 2015 01:05:14 -0400
Message-ID: <b2b34dfe4d9aa4c468fc363b3b666974783ed1f9.1443243089.git.len.brown@intel.com>
References: <1443243915-6696-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1443243915-6696-1-git-send-email-lenb@kernel.org>
In-Reply-To: <135919a3a80565070b9645009e65f73e72c661c0.1443243089.git.len.brown@intel.com>
References: <135919a3a80565070b9645009e65f73e72c661c0.1443243089.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Hubert Chrzaniuk <hubert.chrzaniuk@intel.com>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Hubert Chrzaniuk <hubert.chrzaniuk@intel.com>

KNL increments APERF and MPERF every 1024 clocks.
This is compliant with the architecture specification,
which requires that only the ratio of APERF/MPERF need be valid.

However, turbostat takes advantage of the fact that these
two MSRs increment every un-halted clock
at the actual and base frequency:

AVG_MHz = APERF_delta/measurement_interval

%Busy = MPERF_delta/TSC_delta

This quirk is needed for these calculations to also work on KNL,
which would otherwise show a value 1024x smaller than expected.

Signed-off-by: Hubert Chrzaniuk <hubert.chrzaniuk@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index e05d3033..d333c81 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -71,6 +71,7 @@ unsigned int extra_msr_offset32;
 unsigned int extra_msr_offset64;
 unsigned int extra_delta_offset32;
 unsigned int extra_delta_offset64;
+unsigned int aperf_mperf_multiplier = 1;
 int do_smi;
 double bclk;
 unsigned int show_pkg;
@@ -984,6 +985,8 @@ int get_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 			return -3;
 		if (get_msr(cpu, MSR_IA32_MPERF, &t->mperf))
 			return -4;
+		t->aperf = t->aperf * aperf_mperf_multiplier;
+		t->mperf = t->mperf * aperf_mperf_multiplier;
 	}
 
 	if (do_smi) {
@@ -2541,6 +2544,13 @@ int is_knl(unsigned int family, unsigned int model)
 	return 0;
 }
 
+unsigned int get_aperf_mperf_multiplier(unsigned int family, unsigned int model)
+{
+	if (is_knl(family, model))
+		return 1024;
+	return 1;
+}
+
 #define SLM_BCLK_FREQS 5
 double slm_freq_table[SLM_BCLK_FREQS] = { 83.3, 100.0, 133.3, 116.7, 80.0};
 
@@ -2742,6 +2752,9 @@ void process_cpuid()
 		}
 	}
 
+	if (has_aperf)
+		aperf_mperf_multiplier = get_aperf_mperf_multiplier(family, model);
+
 	do_nhm_platform_info = do_nhm_cstates = do_smi = probe_nhm_msrs(family, model);
 	do_snb_cstates = has_snb_msrs(family, model);
 	do_pc2 = do_snb_cstates && (pkg_cstate_limit >= PCL__2);
-- 
2.6.0.rc1
