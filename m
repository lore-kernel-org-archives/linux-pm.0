Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79613D47A8;
	Wed, 17 Jun 2026 16:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781713826; cv=none; b=TjoupOd+YYZcnUImDjIdOOk2FStnAHmYRAODD7eIIJ7vxv0jZYf0vNNmxbJvWMlUm0fy4qIWefdA7dXw44ZfKUc4lizOH/gtfdRGSiCVDXYWC5me2nbdeeazA2ce05swMOOCdxRh9j6HvFDoRwQk44VWPlQ6V1HcVEmt6vzANTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781713826; c=relaxed/simple;
	bh=X+tIRN1SoJdFLjK5YBmV94AaAh1LWi1hf3iOD9+vrb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YjJw/czRKDmJTcrbdJT3E+S4V6jMxbpWLeApKJmQs5koCYyEO2OpGS1ckh2ex/N5WVNYOcRSLbFukO3ywF7JxeRwOryWtnr1MnFTft+L1BgJ9OZs4BDC8G7dB/wMAHDVPmFcG0zyiHDMIFGpr+bx8o11mdlGXW84zXFOKXbyLOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nk2x1uDG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nk2x1uDG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A3641F000E9;
	Wed, 17 Jun 2026 16:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781713820;
	bh=f+i/jNAbtaGby4B82sHRwqUieho9G5xeqwMv7b+fITE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nk2x1uDGeL0iiFWnGaGIGM+o02ByCGQkEyIjtxCNfwkb9UGuhWk0qpH3uOtAias6/
	 AAygtHqEOmaYJLnBMWkk+/vElaJZWeQv6r2/XLx1iCxw6J9ljjodNVznm8mxOze6y2
	 e3A0c52lXTapFENFNQoH3zmg3g2SXljvTAabYaEqRswHj3DIDYWxjBs06S02EhHAPq
	 2RCSk44KCwoOIQgklYgHBACJxxGfYb+kyoBLUPyY7Xk6h0nEphISCaoZnZpsAn/BZ1
	 t8B06vcwoy7Uq82xA+93XDaqR69egiEf6hKISikB+azrlhqcdS6zVMOFB+wYASoc+f
	 usMrx7f6Ia8+A==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject:
 [PATCH v1 2/2] cpufreq: intel_pstate: Set initial scaling_min_freq value
Date: Wed, 17 Jun 2026 18:30:04 +0200
Message-ID: <3981503.kQq0lBPeGt@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <2381464.iZASKD2KPV@rafael.j.wysocki>
References: <2381464.iZASKD2KPV@rafael.j.wysocki>
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
value from MSR_PLATFORM_INFO (bits 40:47) which prevents users from
setting scaling_min_freq below that value.  However, there are systems
where CPUs may actually run at P-states below that limit and the power
of the processor is then lower than when they run at the limit P-state,
even though running them at the limit P-state may still be more
energy-efficient.

To allow users to utilize the P-states in question, notice that when HWP
is enabled, the LOWEST_PERF value from MSR_HWP_CAPABILITIES can be used
for setting cpuinfo_min_freq, but in order to preserve the default
behavior, use the observation that after commit 8c83947c5dbb ("cpufreq:
Use policy->min/max init as QoS request"), cpufreq drivers can request
the initial scaling_min_freq values above cpuinfo_min_freq by setting
policy->min to those values in their .init() callbacks.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |   53 ++++++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 24 deletions(-)

--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -556,6 +556,17 @@ static int intel_pstate_freq_to_hwp(stru
 	return intel_pstate_freq_to_hwp_rel(cpu, freq, CPUFREQ_RELATION_L);
 }
 
+static void intel_pstate_hwp_tweak_frequencies(struct cpudata *cpu)
+{
+	int perf_ctl_scaling = cpu->pstate.perf_ctl_scaling;
+
+	cpu->pstate.turbo_freq = rounddown(cpu->pstate.turbo_freq, perf_ctl_scaling);
+	cpu->pstate.max_freq = rounddown(cpu->pstate.max_freq, perf_ctl_scaling);
+	cpu->pstate.min_freq = rounddown(cpu->pstate.min_freq, perf_ctl_scaling);
+	if (!cpu->pstate.min_freq)
+		cpu->pstate.min_freq = perf_ctl_scaling;
+}
+
 /**
  * intel_pstate_hybrid_hwp_adjust - Calibrate HWP performance levels.
  * @cpu: Target CPU.
@@ -587,21 +598,10 @@ static void intel_pstate_hybrid_hwp_adju
 
 	hwp_is_hybrid = true;
 
-	cpu->pstate.turbo_freq = rounddown(cpu->pstate.turbo_pstate * scaling,
-					   perf_ctl_scaling);
-	cpu->pstate.max_freq = rounddown(cpu->pstate.max_pstate * scaling,
-					 perf_ctl_scaling);
+	intel_pstate_hwp_tweak_frequencies(cpu);
 
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
@@ -1189,6 +1189,7 @@ static void __intel_pstate_get_hwp_cap(s
 
 	rdmsrq_on_cpu(cpu->cpu, MSR_HWP_CAPABILITIES, &cap);
 	WRITE_ONCE(cpu->hwp_cap_cached, cap);
+	cpu->pstate.min_pstate = HWP_LOWEST_PERF(cap);
 	cpu->pstate.max_pstate = HWP_GUARANTEED_PERF(cap);
 	cpu->pstate.turbo_pstate = HWP_HIGHEST_PERF(cap);
 }
@@ -1199,16 +1200,11 @@ static void intel_pstate_get_hwp_cap(str
 
 	__intel_pstate_get_hwp_cap(cpu);
 
+	cpu->pstate.min_freq = cpu->pstate.min_pstate * scaling;
 	cpu->pstate.max_freq = cpu->pstate.max_pstate * scaling;
 	cpu->pstate.turbo_freq = cpu->pstate.turbo_pstate * scaling;
-	if (scaling != cpu->pstate.perf_ctl_scaling) {
-		int perf_ctl_scaling = cpu->pstate.perf_ctl_scaling;
-
-		cpu->pstate.max_freq = rounddown(cpu->pstate.max_freq,
-						 perf_ctl_scaling);
-		cpu->pstate.turbo_freq = rounddown(cpu->pstate.turbo_freq,
-						   perf_ctl_scaling);
-	}
+	if (scaling != cpu->pstate.perf_ctl_scaling)
+		intel_pstate_hwp_tweak_frequencies(cpu);
 }
 
 static void hybrid_update_capacity(struct cpudata *cpu)
@@ -2320,7 +2316,6 @@ static void intel_pstate_get_cpu_pstates
 	int perf_ctl_scaling = pstate_funcs.get_scaling();
 
 	cpu->pstate.max_pstate_physical = pstate_funcs.get_max_physical(cpu->cpu);
-	cpu->pstate.min_pstate = pstate_funcs.get_min(cpu->cpu);
 	cpu->pstate.perf_ctl_scaling = perf_ctl_scaling;
 
 	if (hwp_active && !hwp_mode_bdw) {
@@ -2339,6 +2334,7 @@ static void intel_pstate_get_cpu_pstates
 		hybrid_update_capacity(cpu);
 	} else {
 		cpu->pstate.scaling = perf_ctl_scaling;
+		cpu->pstate.min_pstate = pstate_funcs.get_min(cpu->cpu);
 		cpu->pstate.max_pstate = pstate_funcs.get_max(cpu->cpu);
 		cpu->pstate.turbo_pstate = pstate_funcs.get_turbo(cpu->cpu);
 	}
@@ -3049,6 +3045,13 @@ static int __intel_pstate_cpu_init(struc
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
@@ -3315,6 +3318,7 @@ static int intel_cpufreq_cpu_init(struct
 	cpu = all_cpu_data[policy->cpu];
 
 	if (hwp_active) {
+		unsigned int hwp;
 		u64 value;
 
 		policy->transition_delay_us = INTEL_CPUFREQ_TRANSITION_DELAY_HWP;
@@ -3326,14 +3330,15 @@ static int intel_cpufreq_cpu_init(struct
 
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
 



