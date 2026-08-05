Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECED23C7DE1;
	Wed,  5 Aug 2026 12:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785932352; cv=none; b=qbqRgKVfeYoJ5VOz5veK+S0fr30Ut4hyApg1LNkVxMlcU4RI0YoBqOBxYlk3RxbqpYgoPL2OxhRFC3SmX0mWb9WhcnpoQGO1/8eQNKchFomw3jABVlFWcy3NQ1q0muinmN/3l3Ny4pgeTZrQpw+6xiEsDsbYPbkuKnCKtMKwbxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785932352; c=relaxed/simple;
	bh=WOfSRyqBWsti+5UaYoASEG3wumEQviKwq06a2NUHNEI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q3Ezx8bArBi03WlM3QDAncOre04uUrxfJcK46G3bvnbBllco/SQW+7Ya42w6UgE8Nv2x7FcoW11wy3eTuLZ8ZSQsGhw1XZA+f9HlNVrsDvTBY8aoSGOrvcD609ozswHUSoGJGGMvp7TQlpRcC1hX0w/NrjgscvDudhXOzUeR/DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JzIEOmVa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JzIEOmVa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 936B41F000E9;
	Wed,  5 Aug 2026 12:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785932350;
	bh=YB3JCmfUTbLYcy9JXvXTh3AEelW+rKTYTa8kaBgSgic=;
	h=From:To:Cc:Subject:Date;
	b=JzIEOmVar1dIVaHrdHMc2SJU3MGM8vwZqKN+hLy1RYXZGw2pDJ2SuJq0wuTMPF09Z
	 jSqqXgOhtlclca2lGS1JnqmZn/5k19IzckL+dx1fy19xflvLxL/y3AhJoFmUgDI3nD
	 3NZOT0p4xkeYNKU2n2Ay+oZkB9i1axhG3mcxcqkkSMA6P8mQC8Wyv9QdzSeVgiB+xA
	 3Br/7gZ3y+IR3XZadWtXxLxus+jVISTkru0+K+kpqXmhAoFqAmEto3MhV2T1tIu2kY
	 9V9HAxELnax8EaF+TiOjKDI8ZiNRByiaxFDdGwo40qojzlNN5JMATxEUpaIecpMPH5
	 eJrrX2yfcqUrQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Doug Smythies <dsmythies@telus.net>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>
Subject:
 [PATCH v2] cpufreq: intel_pstate: Consolidate HWP P-states initialization
Date: Wed, 05 Aug 2026 14:15:31 +0200
Message-ID: <6021518.DvuYhMxLoT@rafael.j.wysocki>
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
Subject: [PATCH v2] cpufreq: intel_pstate: Consolidate HWP P-states initialization

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

Applies on top of linux-next.

v1 -> v2:
   * Correct new debug message regarding cpu->pstate.min_pstate (Sashiko)

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
+	pr_debug("CPU%d: PERF_CTL min = %d\n", cpuid, cpu->pstate.min_pstate);
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
+	 * performance level accordingly.
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
 



