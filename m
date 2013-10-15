From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] intel_pstate: Fix type mismatch warning
Date: Wed, 16 Oct 2013 01:09:29 +0200
Message-ID: <9494730.EGV2mTSpNl@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:63330 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S933632Ab3JOW5k (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Oct 2013 18:57:40 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: dirk.brandewie@gmail.com, Dirk Brandewie <dirk.j.brandewie@intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The expression in line 398 of intel_pstate.c causes the following
warning to be emitted:

drivers/cpufreq/intel_pstate.c:398:3: warning: left shift count >= width of type

which is due to the fact that the pstate variable is of type int.
Fix that by using a helper unsigned long variable and simplify the
code slightly.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -383,6 +383,7 @@ static void intel_pstate_get_min_max(str
 static void intel_pstate_set_pstate(struct cpudata *cpu, int pstate)
 {
 	int max_perf, min_perf;
+	unsigned long val;
 
 	intel_pstate_get_min_max(cpu, &min_perf, &max_perf);
 
@@ -394,11 +395,11 @@ static void intel_pstate_set_pstate(stru
 	trace_cpu_frequency(pstate * 100000, cpu->cpu);
 
 	cpu->pstate.current_pstate = pstate;
+	val = pstate << 8;
 	if (limits.no_turbo)
-		wrmsrl(MSR_IA32_PERF_CTL, BIT(32) | (pstate << 8));
-	else
-		wrmsrl(MSR_IA32_PERF_CTL, pstate << 8);
+		val |= BIT(32);
 
+	wrmsrl(MSR_IA32_PERF_CTL, val);
 }
 
 static inline void intel_pstate_pstate_increase(struct cpudata *cpu, int steps)

