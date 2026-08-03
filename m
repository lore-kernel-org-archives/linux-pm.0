Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DBD2F7445;
	Mon,  3 Aug 2026 18:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785781193; cv=none; b=cl0JsqK54LV3cVMESvMIenn/y55tayb7qOC3Fwe6P078zVEaKfnexSaCE9W//aAjG+iq8pGrzv7AzJCfFycTDucR5KSC6x5NKB+BOnCrNP4g9keVM4Ae99OF4qMxEOodrStoUn8HZ4UNPBWxDkMz2mLxIiicmxqg9fCj69eDt24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785781193; c=relaxed/simple;
	bh=pKOCGh2LC3eZx7POG8Q8w42wprt0ftYuGYBZPNdm7rQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XgpnMX2RA+rjPBURu5w+LFswiwR8hnWeT8aMfu4WG2MZAhQBpl/P7BCcc4sHj3O4a+k/tVsp5yg4vszvM5VNvHv6t3AA3JgHxbClAns1MGhhSWtpCEVjAWbohDJc9tdJcKhYUSKedYm0UqS9FkDMAB3IO9OXRl50+6usS68Nlg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UOfaNT6S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UOfaNT6S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD5F11F000E9;
	Mon,  3 Aug 2026 18:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785781192;
	bh=eZEoZzUR+slFGo1MmV1KC5RprQhkcbLlKj7Ny4IxhYQ=;
	h=From:To:Cc:Subject:Date;
	b=UOfaNT6SdACM//4WgLTb7vIej0+XSypU0ID3f96uJR5e/qsFQj2waVTz9rPct6YWq
	 ahy0/AmBqAR8FODicoVStkNLEyq/hmt6zYLXAzk1LE5/oNlZ19OtwlU4CoUSdheKvZ
	 J6SQEN6F3/Zf+4K12Yen8I0w3er4ltOxGiZn0XFc2RvYLOLe3LZJhf4qXgfWUcD3Tc
	 eQS7x18mOBHK3CBoO8sVzQWBeZk3nj3RpiNdfex5zSiJWZ3/PF+0KwVHKy4pImQn0j
	 ZvZTZQ8cBPKom2N9SRpK26qCZwO5xNaEsstQ84f3EqFfw2SwwiipVdyM+2B2yroZMr
	 fgNT6KTiWTuBg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Doug Smythies <dsmythies@telus.net>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>
Subject:
 [PATCH v1] cpufreq: intel_pstate: Consolidate HWP P-states initialization
Date: Mon, 03 Aug 2026 20:19:47 +0200
Message-ID: <3056221.e9J7NaK4W3@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

After previous changes, intel_pstate_hybrid_hwp_adjust() does not do
much and its name and kerneldoc comment (which is not really necessary
because the function is static) have become a bit confusing.  Moreover,
the initialization of P-states on systems with HWP enabled is divided
between it and a direct conditional statement branch in
intel_pstate_get_cpu_pstates() which is not super-easy to follow.

Address this by introducing intel_pstate_get_hwp_pstates() for the
entire HWP-specific initialization of P-states and moving the code from
intel_pstate_hybrid_hwp_adjust() into it along with some HWP-related
code from intel_pstate_get_cpu_pstates().

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |  113 +++++++++++++++++++----------------------
 1 file changed, 54 insertions(+), 59 deletions(-)

--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -555,47 +555,6 @@ static int intel_pstate_freq_to_hwp(stru
 	return intel_pstate_freq_to_hwp_rel(cpu, freq, CPUFREQ_RELATION_L);
 }
 
-/**
- * intel_pstate_hybrid_hwp_adjust - Calibrate HWP performance levels.
- * @cpu: Target CPU.
- *
- * On hybrid processors, HWP may expose more performance levels than there are
- * P-states accessible through the PERF_CTL interface.  If that happens, the
- * scaling factor between HWP performance levels and CPU frequency will be less
- * than the scaling factor between P-state values and CPU frequency.
- *
- * In that case, adjust the CPU parameters used in computations accordingly.
- */
-static void intel_pstate_hybrid_hwp_adjust(struct cpudata *cpu)
-{
-	int perf_ctl_max_phys = cpu->pstate.max_pstate_physical;
-	int perf_ctl_scaling = cpu->pstate.perf_ctl_scaling;
-	int perf_ctl_turbo = pstate_funcs.get_turbo(cpu->cpu);
-	int scaling = cpu->pstate.scaling;
-	int freq;
-
-	pr_debug("CPU%d: PERF_CTL max_phys = %d\n", cpu->cpu, perf_ctl_max_phys);
-	pr_debug("CPU%d: PERF_CTL turbo = %d\n", cpu->cpu, perf_ctl_turbo);
-	pr_debug("CPU%d: PERF_CTL scaling = %d\n", cpu->cpu, perf_ctl_scaling);
-	pr_debug("CPU%d: HWP_CAP guaranteed = %d\n", cpu->cpu, cpu->pstate.max_pstate);
-	pr_debug("CPU%d: HWP_CAP highest = %d\n", cpu->cpu, cpu->pstate.turbo_pstate);
-	pr_debug("CPU%d: HWP-to-frequency scaling factor: %d\n", cpu->cpu, scaling);
-
-	if (scaling == perf_ctl_scaling)
-		return;
-
-	hwp_is_hybrid = true;
-
-	freq = perf_ctl_max_phys * perf_ctl_scaling;
-	cpu->pstate.max_pstate_physical = intel_pstate_freq_to_hwp(cpu, freq);
-
-	/*
-	 * Cast the min P-state value retrieved via pstate_funcs.get_min() to
-	 * the effective range of HWP performance levels.
-	 */
-	cpu->pstate.min_pstate = intel_pstate_freq_to_hwp(cpu, cpu->pstate.min_freq);
-}
-
 static bool turbo_is_disabled(void)
 {
 	u64 misc_en;
@@ -2293,34 +2252,70 @@ static int hwp_get_cpu_scaling(int cpu)
 	return intel_pstate_cppc_get_scaling(cpu);
 }
 
+static void intel_pstate_get_hwp_pstates(struct cpudata *cpu)
+{
+	int perf_ctl_max_phys = cpu->pstate.max_pstate_physical;
+	int perf_ctl_scaling = cpu->pstate.perf_ctl_scaling;
+	int perf_ctl_turbo = cpu->pstate.turbo_pstate;
+	int cpuid = cpu->cpu;
+
+	__intel_pstate_get_hwp_cap(cpu);
+
+	if (!pstate_funcs.get_cpu_scaling)
+		return;
+
+	pr_debug("CPU%d: PERF_CTL max_phys = %d\n", cpuid, perf_ctl_max_phys);
+	pr_debug("CPU%d: PERF_CTL turbo = %d\n", cpuid, perf_ctl_turbo);
+	pr_debug("CPU%d: PERF_CTL scaling = %d\n", cpuid, perf_ctl_scaling);
+	pr_debug("CPU%d: HWP_CAP lowest = %d\n", cpuid, cpu->pstate.min_pstate);
+	pr_debug("CPU%d: HWP_CAP guaranteed = %d\n", cpuid, cpu->pstate.max_pstate);
+	pr_debug("CPU%d: HWP_CAP highest = %d\n", cpuid, cpu->pstate.turbo_pstate);
+
+	cpu->pstate.scaling = pstate_funcs.get_cpu_scaling(cpuid);
+
+	pr_debug("CPU%d: HWP-to-frequency scaling = %d\n", cpuid, cpu->pstate.scaling);
+
+	/*
+	 * On hybrid processors, HWP may expose more performance levels than
+	 * there are P-states accessible through the PERF_CTL interface.  If
+	 * that happens, the scaling between HWP performance levels and CPU
+	 * frequency will be less than the scaling between P-state values and
+	 * CPU frequency.  In that case, update the maximum physical non-turbo
+	 * performance level and the minimum performance level accordingly.
+	 */
+	if (cpu->pstate.scaling != perf_ctl_scaling) {
+		int freq;
+
+		freq = perf_ctl_max_phys * perf_ctl_scaling;
+		cpu->pstate.max_pstate_physical = intel_pstate_freq_to_hwp(cpu, freq);
+
+		freq = cpu->pstate.min_freq;
+		cpu->pstate.min_pstate = intel_pstate_freq_to_hwp(cpu, freq);
+
+		hwp_is_hybrid = true;
+	}
+	/*
+	 * If the CPU is going online for the first time and it was offline
+	 * initially, asym capacity scaling may need to be updated.
+	 */
+	hybrid_update_capacity(cpu);
+}
+
 static void intel_pstate_get_cpu_pstates(struct cpudata *cpu)
 {
 	int perf_ctl_scaling = pstate_funcs.get_scaling();
 
 	cpu->pstate.max_pstate_physical = pstate_funcs.get_max_physical(cpu->cpu);
+	cpu->pstate.turbo_pstate = pstate_funcs.get_turbo(cpu->cpu);
 	cpu->pstate.min_pstate = pstate_funcs.get_min(cpu->cpu);
 	cpu->pstate.min_freq = cpu->pstate.min_pstate * perf_ctl_scaling;
 	cpu->pstate.perf_ctl_scaling = perf_ctl_scaling;
+	cpu->pstate.scaling = perf_ctl_scaling;
 
-	if (hwp_active) {
-		__intel_pstate_get_hwp_cap(cpu);
-
-		if (pstate_funcs.get_cpu_scaling) {
-			cpu->pstate.scaling = pstate_funcs.get_cpu_scaling(cpu->cpu);
-			intel_pstate_hybrid_hwp_adjust(cpu);
-		} else {
-			cpu->pstate.scaling = perf_ctl_scaling;
-		}
-		/*
-		 * If the CPU is going online for the first time and it was
-		 * offline initially, asym capacity scaling needs to be updated.
-		 */
-		hybrid_update_capacity(cpu);
-	} else {
-		cpu->pstate.scaling = perf_ctl_scaling;
+	if (hwp_active)
+		intel_pstate_get_hwp_pstates(cpu);
+	else
 		cpu->pstate.max_pstate = pstate_funcs.get_max(cpu->cpu);
-		cpu->pstate.turbo_pstate = pstate_funcs.get_turbo(cpu->cpu);
-	}
 
 	intel_pstate_update_freq_limits(cpu);
 



