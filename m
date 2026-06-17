Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170F830C16E;
	Wed, 17 Jun 2026 16:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781712882; cv=none; b=CAAuQNwfIQ0P/CpfnNKqGTtFf/HnPKxEx8HTiz3K596d5XXcp/xujFFA4b2ZQpMem1o66rG0G4WU4qA9+7tcKik0SEWce0XeGZMz2dGk9xfD5r2y5qzvd6oHZ4TgkKHCS7Xfxi2cuN7dljoIR7K8Oe1Cc/xUKsGrWqCisI5/4Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781712882; c=relaxed/simple;
	bh=TS1rzuSkSYvUZa0kKqZA4F19mYo09LbKUz7kLc2R7c4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dx0abR7FXGXa/mDlJCFbuvpRGWIYJ0J3n7JXaTIAzFHNiK++gAnTxXxV8ZRKm37gzLH3wLYiZkH+Y3igNk31+KQhpnUyz2LUevTXXDVWjdJAUMM3J6iEw2wZ0kN7LYuoAmuRkEuvM5UvyfF9iERy55rWmdt7EgwVrqD60hCIxgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NCaWe3/X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NCaWe3/X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F16F1F000E9;
	Wed, 17 Jun 2026 16:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781712873;
	bh=lEeXcVaibcbRS/Vz+saNgFaKALdonox1Eju25A6Eq2c=;
	h=From:To:Cc:Subject:Date;
	b=NCaWe3/XEf3xiLjb81l0msxUArWukc0y/lkEik4MCixXBzYaCg90ZPVKBJcpQTFuW
	 dixanZ1ogS/hGH8He4npoUsnt/YP19YvNwveERCUmVklgNS9sv7nvx7SHiK/HtcZKZ
	 6HB7Ad9vnQOrGmgFQCVO3pbV7RwCdb1YhvDaa0vh/uk2K0s4skD+MZhaRPr1NEttv/
	 IoZvSAO3/rn3q+iaOAAj3dkxfXtL7D9LzoZ01Jn15edKMGygTV4jvVrqjLI6W/Dz+J
	 2uf4t0NwQVSJuVkGigyMxLQkmW+uaW651kn7DLCBYbojJbfzeZuuqK+QxgEoMHAlNs
	 hnAKROmVm90Zg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Christian Loehle <christian.loehle@arm.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>
Subject:
 [PATCH v1] cpufreq: intel_pstate: Adjust the .adjust_perf() driver callback
Date: Wed, 17 Jun 2026 18:14:30 +0200
Message-ID: <14060154.uLZWGnKmhe@rafael.j.wysocki>
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
---
 drivers/cpufreq/amd-pstate.c     |    1 +
 drivers/cpufreq/cpufreq.c        |   14 +++++++++-----
 drivers/cpufreq/intel_pstate.c   |    9 ++++++++-
 include/linux/cpufreq.h          |    2 ++
 kernel/sched/cpufreq_schedutil.c |    4 +++-
 5 files changed, 23 insertions(+), 7 deletions(-)

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
+ * Carry out a fast performance level adjustment for the CPU represeted by
+ * @policy without sleeping.
  *
  * The driver's ->adjust_perf() callback invoked by this function must be
- * suitable for being called from within RCU-sched read-side critical sections
- * and it is expected to select a suitable performance level equal to or above
- * @min_perf and preferably equal to or below @target_perf.
+ * suitable for calling from within RCU-sched read-side critical sections and
+ * it is expected to program the proocessor to select suitable performance
+ * levels betweem @min_perf and @max_perf inclusive and preferably close to
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



