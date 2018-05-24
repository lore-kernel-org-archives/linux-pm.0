From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [RFC/RFT] [PATCH v2 6/6] cpufreq: intel_pstate: enable boost for SKX
Date: Wed, 23 May 2018 18:47:38 -0700
Message-ID: <20180524014738.52924-7-srinivas.pandruvada@linux.intel.com>
References: <20180524014738.52924-1-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180524014738.52924-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lenb@kernel.org, rjw@rjwysocki.net, peterz@infradead.org, mgorman@techsingularity.net
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, juri.lelli@redhat.com, viresh.kumar@linaro.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Enable HWP boost on Skylake server platform.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index b2613c9775d5..6f8214a40764 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1801,6 +1801,11 @@ static const struct x86_cpu_id intel_pstate_cpu_ee_disable_ids[] = {
 	{}
 };
 
+static const struct x86_cpu_id intel_pstate_hwp_boost_ids[] __initconst = {
+	ICPU(INTEL_FAM6_SKYLAKE_X, core_funcs),
+	{}
+};
+
 static int intel_pstate_init_cpu(unsigned int cpunum)
 {
 	struct cpudata *cpu;
@@ -1831,6 +1836,10 @@ static int intel_pstate_init_cpu(unsigned int cpunum)
 			intel_pstate_disable_ee(cpunum);
 
 		intel_pstate_hwp_enable(cpu);
+
+		id = x86_match_cpu(intel_pstate_hwp_boost_ids);
+		if (id)
+			hwp_boost = true;
 	}
 
 	intel_pstate_get_cpu_pstates(cpu);
-- 
2.13.6
