Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A46A3C1086;
	Fri, 19 Jun 2026 17:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781891176; cv=none; b=Xsi9pMp9145kjIp3EjkRAMg3bYOy0XCqRFpdlIpWA+8dAauC8U6pojTeq/GY4O3Q3Q87Wtmn3Nq+QaGw2qPuYEepwMe4++Vw3MX1rpGJpIKjmG2CsgVf6N04xpSgfoTnleFKN0m4ZyVRymSE0m1+tGDJDAj7J3KA+EA9hQGx070=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781891176; c=relaxed/simple;
	bh=HiVpQDCbpNuSMlg5h0X7CeBE03CdzZjYklewXQeh/9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GEX17S+gWM1g5aTX+ctFPvOA3SgrZkLdm7g2fTYOcBNSyGKMsFNetZt5h7uU2AxWLiuYek1GvbE6/aRJkWNo1wUv0Suj11NL7Q7Ck0NDueCXoDsrwrOL/dnE6S1tFV6WYW+1R9TACCZCVfKpZ4j7A7fl3VGA8PIMaPkQQzG7p1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MDS9P/aC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MDS9P/aC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3793C1F000E9;
	Fri, 19 Jun 2026 17:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781891175;
	bh=NeZf6n7XE070EBItEBz298+7iWfSQJPeW8Fn0WJyd8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MDS9P/aCHLIfIZmBPcq+O1PLHPHcgDdSbD13NZgdFsAG/VLQ3XljFUlGBoaKKZmo0
	 W8/qD61J3iFskhpF6+XqiKyrO8znMrSKTEMCIsS5igUteO9nTi/C7hyPsyRHyayjO4
	 /hsJBmsfxH07IRIrEfMFsjpzdgQFXQo9SC2v4Sue9/VZDgzxfKcmDIajKeg8VBQco8
	 9VJxqyMp7yf0ST9+6Bg8pgqSUJ6etE7IzBur/rKupmMNt28CAOQg7QYW4rbvOfQT2b
	 +qSdVXzcIPzw5eyChEGAWIT88FrByEtQIK8Ljz/KXjezO7gzCqtS8c+J09urW7DwLR
	 uO8aWCG+xWUHQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject:
 [PATCH v2 3/6] cpufreq: intel_pstate: Set initial scaling_min_freq value
Date: Fri, 19 Jun 2026 19:40:52 +0200
Message-ID: <3051793.e9J7NaK4W3@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <6005456.DvuYhMxLoT@rafael.j.wysocki>
References: <6005456.DvuYhMxLoT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Currently, intel_pstate sets cpuinfo_min_freq to the minimum P-state
value retrieved from MSR_PLATFORM_INFO (bits 40:47) which prevents users
from setting scaling_min_freq below it.  However, there are systems
where CPUs may actually run at P-states below that limit and the power
of the processor is then lower than when they run at the limit P-state,
even though running them at the limit P-state may still be more
energy-efficient.

To allow users to utilize the low P-states in question, notice that when
HWP is enabled, the LOWEST_PERF value from MSR_HWP_CAPABILITIES can be
used for setting cpuinfo_min_freq instead of the minimum P-state value
mentioned above, but in order to preserve the default behavior, use the
observation that after commit 8c83947c5dbb ("cpufreq: Use policy->min/max
init as QoS request"), cpufreq drivers can request the initial
scaling_min_freq values above cpuinfo_min_freq by setting policy->min to
those values in their .init() callbacks.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2:
   * Rely on intel_pstate_update_freq_limits() to update the cached frequency
     values and modify it to take the min frequency into account (based on
     Sashiko feedback:
     https://sashiko.dev/#/patchset/2381464.iZASKD2KPV%40rafael.j.wysocki)
   * Minor tweaks in the changelog

---
 drivers/cpufreq/intel_pstate.c |   32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -589,14 +589,6 @@ static void intel_pstate_hybrid_hwp_adju
 
 	freq = perf_ctl_max_phys * perf_ctl_scaling;
 	cpu->pstate.max_pstate_physical = intel_pstate_freq_to_hwp(cpu, freq);
-
-	freq = cpu->pstate.min_pstate * perf_ctl_scaling;
-	cpu->pstate.min_freq = freq;
-	/*
-	 * Cast the min P-state value retrieved via pstate_funcs.get_min() to
-	 * the effective range of HWP performance levels.
-	 */
-	cpu->pstate.min_pstate = intel_pstate_freq_to_hwp(cpu, freq);
 }
 
 static bool turbo_is_disabled(void)
@@ -1181,15 +1173,21 @@ static void intel_pstate_update_freq_lim
 	int scaling = cpu->pstate.scaling;
 	unsigned int turbo_freq = cpu->pstate.turbo_pstate * scaling;
 	unsigned int max_freq = cpu->pstate.max_pstate * scaling;
+	unsigned int min_freq = cpu->pstate.min_pstate * scaling;
 	int perf_ctl_scaling = cpu->pstate.perf_ctl_scaling;
 
 	if (scaling != perf_ctl_scaling) {
 		turbo_freq = rounddown(turbo_freq, perf_ctl_scaling);
 		max_freq = rounddown(max_freq, perf_ctl_scaling);
+		if (min_freq > perf_ctl_scaling)
+			min_freq = rounddown(min_freq, perf_ctl_scaling);
+		else
+			min_freq = perf_ctl_scaling;
 	}
 
 	cpu->pstate.turbo_freq = turbo_freq;
 	cpu->pstate.max_freq = max_freq;
+	cpu->pstate.min_freq = min_freq;
 }
 
 static void __intel_pstate_get_hwp_cap(struct cpudata *cpu)
@@ -1198,6 +1196,7 @@ static void __intel_pstate_get_hwp_cap(s
 
 	rdmsrq_on_cpu(cpu->cpu, MSR_HWP_CAPABILITIES, &cap);
 	WRITE_ONCE(cpu->hwp_cap_cached, cap);
+	cpu->pstate.min_pstate = HWP_LOWEST_PERF(cap);
 	cpu->pstate.max_pstate = HWP_GUARANTEED_PERF(cap);
 	cpu->pstate.turbo_pstate = HWP_HIGHEST_PERF(cap);
 }
@@ -2317,7 +2316,6 @@ static void intel_pstate_get_cpu_pstates
 	int perf_ctl_scaling = pstate_funcs.get_scaling();
 
 	cpu->pstate.max_pstate_physical = pstate_funcs.get_max_physical(cpu->cpu);
-	cpu->pstate.min_pstate = pstate_funcs.get_min(cpu->cpu);
 	cpu->pstate.perf_ctl_scaling = perf_ctl_scaling;
 
 	if (hwp_active && !hwp_mode_bdw) {
@@ -2337,6 +2335,7 @@ static void intel_pstate_get_cpu_pstates
 		hybrid_update_capacity(cpu);
 	} else {
 		cpu->pstate.scaling = perf_ctl_scaling;
+		cpu->pstate.min_pstate = pstate_funcs.get_min(cpu->cpu);
 		cpu->pstate.max_pstate = pstate_funcs.get_max(cpu->cpu);
 		cpu->pstate.turbo_pstate = pstate_funcs.get_turbo(cpu->cpu);
 	}
@@ -3047,6 +3046,13 @@ static int __intel_pstate_cpu_init(struc
 	policy->cpuinfo.max_freq = READ_ONCE(global.no_turbo) ?
 			cpu->pstate.max_freq : cpu->pstate.turbo_freq;
 
+	/*
+	 * If policy->min is greater than policy->cpuinfo.min_freq, the cpufreq
+	 * core will use this value for initializing scaling_min_freq.
+	 */
+	if (hwp_active)
+		policy->min = pstate_funcs.get_min(cpu->cpu) * cpu->pstate.perf_ctl_scaling;
+
 	intel_pstate_init_acpi_perf_limits(policy);
 
 	policy->fast_switch_possible = true;
@@ -3313,6 +3319,7 @@ static int intel_cpufreq_cpu_init(struct
 	cpu = all_cpu_data[policy->cpu];
 
 	if (hwp_active) {
+		unsigned int hwp;
 		u64 value;
 
 		policy->transition_delay_us = INTEL_CPUFREQ_TRANSITION_DELAY_HWP;
@@ -3324,14 +3331,15 @@ static int intel_cpufreq_cpu_init(struct
 
 		cpu->epp_cached = intel_pstate_get_epp(cpu, value);
 
+		hwp = intel_pstate_freq_to_hwp(cpu, policy->min);
 		intel_cpufreq_hwp_update(cpu, cpu->pstate.min_pstate,
-					 cpu->pstate.max_pstate,
-					 cpu->pstate.min_pstate, false);
+					 cpu->pstate.max_pstate, hwp, false);
+		policy->cur = policy->min;
 	} else {
 		policy->transition_delay_us = INTEL_CPUFREQ_TRANSITION_DELAY;
 		intel_pstate_set_min_pstate(cpu);
+		policy->cur = policy->cpuinfo.min_freq;
 	}
-	policy->cur = policy->cpuinfo.min_freq;
 
 	freq = DIV_ROUND_UP(cpu->pstate.turbo_freq * global.min_perf_pct, 100);
 



