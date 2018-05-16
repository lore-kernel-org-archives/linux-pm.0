From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [RFC/RFT] [PATCH 02/10] cpufreq: intel_pstate: Conditional frequency invariant accounting
Date: Tue, 15 May 2018 21:49:03 -0700
Message-ID: <20180516044911.28797-3-srinivas.pandruvada@linux.intel.com>
References: <20180516044911.28797-1-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180516044911.28797-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: srinivas.pandruvada@linux.intel.com, tglx@linutronix.de, mingo@redhat.com, peterz@infradead.org, bp@suse.de, lenb@kernel.org, rjw@rjwysocki.net, mgorman@techsingularity.net
Cc: x86@kernel.org, linux-pm@vger.kernel.org, viresh.kumar@linaro.org, juri.lelli@arm.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

intel_pstate has two operating modes: active and passive. In "active"
mode, the in-built scaling governor is used and in "passive" mode,
the driver can be used with any governor like "schedutil". In "active"
mode the utilization values from schedutil is not used and there is
a requirement from high performance computing use cases, not to read
any APERF/MPERF MSRs. In this case no need to use CPU cycles for
frequency invariant accounting by reading APERF/MPERF MSRs.
With this change frequency invariant account is only enabled in
"passive" mode.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
[Note: The tick will be enabled later in the series when hwp dynamic
boost is enabled]

 drivers/cpufreq/intel_pstate.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 17e566af..f686bbe 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2040,6 +2040,8 @@ static int intel_pstate_register_driver(struct cpufreq_driver *driver)
 {
 	int ret;
 
+	x86_arch_scale_freq_tick_disable();
+
 	memset(&global, 0, sizeof(global));
 	global.max_perf_pct = 100;
 
@@ -2052,6 +2054,9 @@ static int intel_pstate_register_driver(struct cpufreq_driver *driver)
 
 	global.min_perf_pct = min_perf_pct_min();
 
+	if (driver == &intel_cpufreq)
+		x86_arch_scale_freq_tick_enable();
+
 	return 0;
 }
 
-- 
2.9.5
