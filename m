From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v2, 2/3] intel_pstate: Use sample.core_avg_perf in get_avg_pstate()
Date: Wed, 11 May 2016 19:10:42 +0200
Message-ID: <1556570.uqd2QqlgcU@vostro.rjw.lan>
References: <2638272.Bq3MnQEe4U@vostro.rjw.lan> <4400018.TlI4RAhtYU@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4400018.TlI4RAhtYU@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Notice that get_avg_pstate() can use sample.core_avg_perf instead of
carrying the same division again, so make it do that.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: Use mul_ext_fp() to carry out the computation in get_avg_pstate().

---
 drivers/cpufreq/intel_pstate.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -1213,8 +1213,8 @@ static inline int32_t get_avg_frequency(
 
 static inline int32_t get_avg_pstate(struct cpudata *cpu)
 {
-	return div64_u64(cpu->pstate.max_pstate_physical * cpu->sample.aperf,
-			 cpu->sample.mperf);
+	return mul_ext_fp(cpu->pstate.max_pstate_physical,
+			  cpu->sample.core_avg_perf);
 }
 
 static inline int32_t get_target_pstate_use_cpu_load(struct cpudata *cpu)
