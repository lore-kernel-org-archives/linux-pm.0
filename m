From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] intel_pstate: Fix intel_pstate_get()
Date: Wed, 04 May 2016 14:01:10 +0200
Message-ID: <54177738.QIcPrzf0Y7@vostro.rjw.lan>
References: <87mvo8gd44.fsf@yhuang-dev.intel.com> <20160503083231.GG3430@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:62921 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751629AbcEDL6A (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 4 May 2016 07:58:00 -0400
In-Reply-To: <20160503083231.GG3430@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Linux PM list <linux-pm@vger.kernel.org>
Cc: kernel test robot <ying.huang@linux.intel.com>, Steve Muckle <steve.muckle@linaro.org>, lkp@01.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rafael@kernel.org>, Patrick Bellasi <patrick.bellasi@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Mike Galbraith <efault@gmx.de>, Michael Turquette <mturquette@baylibre.com>, Juri Lelli <Juri.Lelli@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Steve Muckle <smuckle@linaro.org>, Ingo Molnar <mingo@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

After commit 8fa520af5081 "intel_pstate: Remove freq calculation from
intel_pstate_calc_busy()" intel_pstate_get() calls get_avg_frequency()
to compute the average frequency, which is problematic for two reasons.

First, intel_pstate_get() may be invoked before the driver reads the
CPU feedback registers for the first time and if that happens,
get_avg_frequency() will attempt to divide by zero.

Second, the get_avg_frequency() call in intel_pstate_get() is racy
with respect to intel_pstate_sample() and it may end up returning
completely meaningless values for this reason.

Moreover, after commit 7349ec0470b6 "intel_pstate: Move
intel_pstate_calc_busy() into get_target_pstate_use_performance()"
sample.core_pct_busy is never computed on Atom, but it is used in
intel_pstate_adjust_busy_pstate() in that case too.

To address those problems notice that if sample.core_pct_busy
was used in the average frequency computation carried out by
get_avg_frequency(), both the divide by zero problem and the
race with respect to intel_pstate_sample() would be avoided.

Accordingly, move the invocation of intel_pstate_calc_busy() from
get_target_pstate_use_performance() to intel_pstate_update_util(),
which also will take care of the uninitialized sample.core_pct_busy
on Atom, and modify get_avg_frequency() to use sample.core_pct_busy
as per the above.

Reported-by: kernel test robot <ying.huang@linux.intel.com>
Link: http://marc.info/?l=linux-kernel&m=146226437623173&w=4
Fixes: 8fa520af5081 "intel_pstate: Remove freq calculation from intel_pstate_calc_busy()"
Fixes: 7349ec0470b6 "intel_pstate: Move intel_pstate_calc_busy() into get_target_pstate_use_performance()"
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -928,8 +928,9 @@ static inline bool intel_pstate_sample(s
 
 static inline int32_t get_avg_frequency(struct cpudata *cpu)
 {
-	return div64_u64(cpu->pstate.max_pstate_physical * cpu->sample.aperf *
-		cpu->pstate.scaling, cpu->sample.mperf);
+	return fp_toint(mul_fp(cpu->sample.core_pct_busy,
+			       int_tofp(cpu->pstate.max_pstate_physical *
+						cpu->pstate.scaling / 100)));
 }
 
 static inline int32_t get_target_pstate_use_cpu_load(struct cpudata *cpu)
@@ -972,8 +973,6 @@ static inline int32_t get_target_pstate_
 	int32_t core_busy, max_pstate, current_pstate, sample_ratio;
 	u64 duration_ns;
 
-	intel_pstate_calc_busy(cpu);
-
 	/*
 	 * core_busy is the ratio of actual performance to max
 	 * max_pstate is the max non turbo pstate available
@@ -1056,8 +1055,11 @@ static void intel_pstate_update_util(str
 	if ((s64)delta_ns >= pid_params.sample_rate_ns) {
 		bool sample_taken = intel_pstate_sample(cpu, time);
 
-		if (sample_taken && !hwp_active)
-			intel_pstate_adjust_busy_pstate(cpu);
+		if (sample_taken) {
+			intel_pstate_calc_busy(cpu);
+			if (!hwp_active)
+				intel_pstate_adjust_busy_pstate(cpu);
+		}
 	}
 }
 

