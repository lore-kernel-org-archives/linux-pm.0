From: Philippe Longepe <philippe.longepe@linux.intel.com>
Subject: [PATCH V6 3/4] intel_pstate: Move the intel_pstate_calc_busy into get_target_pstate_use_performance
Date: Tue,  8 Mar 2016 10:31:19 +0100
Message-ID: <1457429481-13283-8-git-send-email-philippe.longepe@linux.intel.com>
References: <1457429481-13283-1-git-send-email-philippe.longepe@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:43546 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932291AbcCHJaV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 8 Mar 2016 04:30:21 -0500
In-Reply-To: <1457429481-13283-1-git-send-email-philippe.longepe@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: srinivas.pandruvada@linux.intel.com, rafael@kernel.org

The cpu_load algorithm doesn't need to invoke intel_pstate_calc_busy(),
so move that call from intel_pstate_sample() to
get_target_pstate_use_performance().

Signed-off-by: Philippe Longepe <philippe.longepe@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index c46d23a..903341f 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -912,8 +912,6 @@ static inline void intel_pstate_sample(struct cpudata *cpu, u64 time)
 	cpu->sample.mperf -= cpu->prev_mperf;
 	cpu->sample.tsc -= cpu->prev_tsc;
 
-	intel_pstate_calc_busy(cpu);
-
 	cpu->prev_aperf = aperf;
 	cpu->prev_mperf = mperf;
 	cpu->prev_tsc = tsc;
@@ -942,7 +940,6 @@ static inline int32_t get_target_pstate_use_cpu_load(struct cpudata *cpu)
 	mperf = cpu->sample.mperf + delta_iowait_mperf;
 	cpu->prev_cummulative_iowait = cummulative_iowait;
 
-
 	/*
 	 * The load can be estimated as the ratio of the mperf counter
 	 * running at a constant frequency during active periods
@@ -960,6 +957,8 @@ static inline int32_t get_target_pstate_use_performance(struct cpudata *cpu)
 	int32_t core_busy, max_pstate, current_pstate, sample_ratio;
 	u64 duration_ns;
 
+	intel_pstate_calc_busy(cpu);
+
 	/*
 	 * core_busy is the ratio of actual performance to max
 	 * max_pstate is the max non turbo pstate available
-- 
1.9.1

