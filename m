Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0764327467F;
	Fri, 19 Jun 2026 14:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781880734; cv=none; b=jp/ZWyvqASR6UtWRSHz8WCeOaM6DdccPixARv/6YV0cYrbZ88MZE6kEizPQ4eI3Nf2YWnVaiSarKxPX7b4/+Cr1BAHPQP4vTPyG1AsSw5mFE9f4/860v3OtnIX5gFpkaaDGgK+cLJoEEHludHp3Ghts4P9goQ5FeOhsgfWd2Mck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781880734; c=relaxed/simple;
	bh=1TKHOOgIi2B54S5F5zBztQ//B5Kzm+e8gYrFWEcvawA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PnIOPhlWb2ZXpmVzI8r2YplBciEmjH03yJ+BQXo6mM4Gcet9PQ9cSgviVXr6+mQ0TLv3BPDmkdphT5m2gum/yxSYqUMuV5rl3LAq8Y3so2rsYzQH3g0mdtLyJC6RQQx8QXuFX9/VWgby3JE3SjR9Vc59wYgYc4Cvhcg6BXaFsMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ztvcb7gK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ztvcb7gK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB5411F000E9;
	Fri, 19 Jun 2026 14:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781880732;
	bh=LUJ5P/oH3jsbOHH+ze6NU0xGCFjKU1qMIrAx9AtT24s=;
	h=From:To:Cc:Subject:Date;
	b=Ztvcb7gKIIW0IcaVJUIbmR5h+z+RMZANRpUC4qUnfJN0Ef+oZXe2JxtumV9q9Foe4
	 pTpj06bDh9iOD1tFrRrqbnTmaKc2fbiz7URwPV1n91Juq+R6QHuKD7drU/TQtH9E1A
	 5uzRIkeU47oKWxwYUhul84NCIekEdloAdo1cuMgszq2gfHVNXu6q2czwfKGHAHG8EN
	 fKflnke8khfCqP4JMhEsCQIJj3vfURRNx4vSe1uBTFweVSWTB4RPWyYN1VJn0d/6BG
	 UM79FCUzT2/Xwqp8J25PT3qcgJXhArlvNnEvg1UvcHuxu38DrAVhiirra4SlgjlSwY
	 xbEIYdwBXskOA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Christian Loehle <christian.loehle@arm.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
 Mario Limonciello <superm1@kernel.org>
Subject:
 [PATCH v2] cpufreq: intel_pstate: Adjust the .adjust_perf() driver callback
Date: Fri, 19 Jun 2026 16:52:08 +0200
Message-ID: <6277654.lOV4Wx5bFT@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

In some cases, the processor may not actually stick to the "desired"
performance level programmed through the driver's .adjust_perf()
callback and may go above it, which may not be desirable (for instance,
there may be a UCLAMP_MAX limit set for the task currently running on
the given CPU which should be respected).

Address that by adjusting the .adjust_perf() callback to take an
additional argument, max_perf, representing the maximum allowed
performance level of the CPU and update the intel_pstate driver to
take that argument into account as appropriate.

Accordingly, adjust cpufreq_driver_adjust_perf() and the other existing
user of .adjust_perf(), which is the amd-pstate driver (but the behavior
of that driver is not changed).

While at it, also update the cpufreq_driver_adjust_perf()
documentation to reflect this change and some previous code
changes that have not been taken into account in it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---

This is an update of

https://lore.kernel.org/linux-pm/14060154.uLZWGnKmhe@rafael.j.wysocki/

sent mainly because the v1 did not update the Rust bindings by
omission.  It also fixes a few typos present in the v1.

Thanks!

---
 drivers/cpufreq/amd-pstate.c     |    1 +
 drivers/cpufreq/cpufreq.c        |   14 +++++++++-----
 drivers/cpufreq/intel_pstate.c   |    9 ++++++++-
 include/linux/cpufreq.h          |    2 ++
 kernel/sched/cpufreq_schedutil.c |    4 +++-
 rust/kernel/cpufreq.rs           |    6 ++++--
 6 files changed, 27 insertions(+), 9 deletions(-)

--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -781,6 +781,7 @@ static unsigned int amd_pstate_fast_swit
 static void amd_pstate_adjust_perf(struct cpufreq_policy *policy,
 				   unsigned long _min_perf,
 				   unsigned long target_perf,
+				   unsigned long _max_perf,
 				   unsigned long capacity)
 {
 	u8 max_perf, min_perf, des_perf, cap_perf;
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2252,14 +2252,17 @@ EXPORT_SYMBOL_GPL(cpufreq_driver_fast_sw
  * @policy: cpufreq policy object of the target CPU.
  * @min_perf: Minimum (required) performance level (units of @capacity).
  * @target_perf: Target (desired) performance level (units of @capacity).
+ * @max_perf: Maximum (allowed) performance level (units of @capacity).
  * @capacity: Capacity of the target CPU.
  *
- * Carry out a fast performance level switch of @cpu without sleeping.
+ * Carry out a fast performance level adjustment for the CPU represented by
+ * @policy without sleeping.
  *
  * The driver's ->adjust_perf() callback invoked by this function must be
- * suitable for being called from within RCU-sched read-side critical sections
- * and it is expected to select a suitable performance level equal to or above
- * @min_perf and preferably equal to or below @target_perf.
+ * suitable for calling from within RCU-sched read-side critical sections and
+ * it is expected to program the processor to select suitable performance
+ * levels between @min_perf and @max_perf inclusive and preferably close to
+ * @target_perf going forward for the CPU represented by @policy.
  *
  * This function must not be called if policy->fast_switch_enabled is unset.
  *
@@ -2271,9 +2274,10 @@ EXPORT_SYMBOL_GPL(cpufreq_driver_fast_sw
 void cpufreq_driver_adjust_perf(struct cpufreq_policy *policy,
 				 unsigned long min_perf,
 				 unsigned long target_perf,
+				 unsigned long max_perf,
 				 unsigned long capacity)
 {
-	cpufreq_driver->adjust_perf(policy, min_perf, target_perf, capacity);
+	cpufreq_driver->adjust_perf(policy, min_perf, target_perf, max_perf, capacity);
 }
 
 /**
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -3241,6 +3241,7 @@ static unsigned int intel_cpufreq_fast_s
 static void intel_cpufreq_adjust_perf(struct cpufreq_policy *policy,
 				      unsigned long min_perf,
 				      unsigned long target_perf,
+				      unsigned long max_perf,
 				      unsigned long capacity)
 {
 	struct cpudata *cpu = all_cpu_data[policy->cpu];
@@ -3271,7 +3272,13 @@ static void intel_cpufreq_adjust_perf(st
 	if (min_pstate > cpu->max_perf_ratio)
 		min_pstate = cpu->max_perf_ratio;
 
-	max_pstate = min(cap_pstate, cpu->max_perf_ratio);
+	max_pstate = cap_pstate;
+	if (max_perf < capacity)
+		max_pstate = DIV_ROUND_UP(cap_pstate * max_perf, capacity);
+
+	if (max_pstate > cpu->max_perf_ratio)
+		max_pstate = cpu->max_perf_ratio;
+
 	if (max_pstate < min_pstate)
 		max_pstate = min_pstate;
 
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -379,6 +379,7 @@ struct cpufreq_driver {
 	void		(*adjust_perf)(struct cpufreq_policy *policy,
 				       unsigned long min_perf,
 				       unsigned long target_perf,
+				       unsigned long max_perf,
 				       unsigned long capacity);
 
 	/*
@@ -624,6 +625,7 @@ unsigned int cpufreq_driver_fast_switch(
 void cpufreq_driver_adjust_perf(struct cpufreq_policy *policy,
 				unsigned long min_perf,
 				unsigned long target_perf,
+				unsigned long max_perf,
 				unsigned long capacity);
 bool cpufreq_driver_has_adjust_perf(void);
 int cpufreq_driver_target(struct cpufreq_policy *policy,
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -50,6 +50,7 @@ struct sugov_cpu {
 
 	unsigned long		util;
 	unsigned long		bw_min;
+	unsigned long		bw_max;
 
 	/* The field below is for single-CPU policies only: */
 #ifdef CONFIG_NO_HZ_COMMON
@@ -232,6 +233,7 @@ static void sugov_get_util(struct sugov_
 	util = effective_cpu_util(sg_cpu->cpu, util, &min, &max);
 	util = max(util, boost);
 	sg_cpu->bw_min = min;
+	sg_cpu->bw_max = max;
 	sg_cpu->util = sugov_effective_cpu_perf(sg_cpu->cpu, util, min, max);
 }
 
@@ -484,7 +486,7 @@ static void sugov_update_single_perf(str
 		sg_cpu->util = prev_util;
 
 	cpufreq_driver_adjust_perf(sg_policy->policy, sg_cpu->bw_min,
-				   sg_cpu->util, max_cap);
+				   sg_cpu->util, sg_cpu->bw_max, max_cap);
 
 	sg_policy->last_freq_update_time = time;
 }
--- a/rust/kernel/cpufreq.rs
+++ b/rust/kernel/cpufreq.rs
@@ -792,7 +792,8 @@ pub trait Driver {
     }
 
     /// Driver's `adjust_perf` callback.
-    fn adjust_perf(_policy: &mut Policy, _min_perf: usize, _target_perf: usize, _capacity: usize) {
+    fn adjust_perf(_policy: &mut Policy, _min_perf: usize, _target_perf: usize,
+                   _max_perf: usize, _capacity: usize) {
         build_error!(VTABLE_DEFAULT_ERROR)
     }
 
@@ -1262,12 +1263,13 @@ impl<T: Driver> Registration<T> {
         ptr: *mut bindings::cpufreq_policy,
         min_perf: c_ulong,
         target_perf: c_ulong,
+        max_perf: c_ulong,
         capacity: c_ulong,
     ) {
         // SAFETY: The `ptr` is guaranteed to be valid by the contract with the C code for the
         // lifetime of `policy`.
         let policy = unsafe { Policy::from_raw_mut(ptr) };
-        T::adjust_perf(policy, min_perf, target_perf, capacity);
+        T::adjust_perf(policy, min_perf, target_perf, max_perf, capacity);
     }
 
     /// Driver's `get_intermediate` callback.



