From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 2/3] intel_pstate: Use sample.core_avg_perf in get_avg_pstate()
Date: Sat, 07 May 2016 01:45:37 +0200
Message-ID: <1500006.fx2d5NQrW2@vostro.rjw.lan>
References: <2638272.Bq3MnQEe4U@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2638272.Bq3MnQEe4U@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Notice that get_avg_pstate() can use sample.core_avg_perf instead of
carrying the same division again, so make it do that.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -1201,8 +1201,7 @@ static inline int32_t get_avg_frequency(
 
 static inline int32_t get_avg_pstate(struct cpudata *cpu)
 {
-	return div64_u64(cpu->pstate.max_pstate_physical * cpu->sample.aperf,
-			 cpu->sample.mperf);
+	return fp_toint(cpu->pstate.max_pstate_physical * cpu->sample.core_avg_perf);
 }
 
 static inline int32_t get_target_pstate_use_cpu_load(struct cpudata *cpu)
