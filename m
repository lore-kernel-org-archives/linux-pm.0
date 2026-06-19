Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003713C1992;
	Fri, 19 Jun 2026 17:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781891170; cv=none; b=FKorug5QJZtmk/Gf4aR70bdIW6xsaEtvTCiXOwzFjfUESUAqBkq77MN9aUr/Pr1Vp/VYpi214egXneiRIcSjG+rN4yDcaWIP5I1q4K90t4bViW4ppmTDvp5ldA/7xG5hZTghukqMaKrEQC9TqsgNYO+6sbZBBsWSfHWtqDEM4qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781891170; c=relaxed/simple;
	bh=+cwIjTIXB60uec92FKjFSCEZ/bAxp2drjzwyk4KluNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tSdFuyIvF+hFE0dUNMC5etFIlo67fM63Y4pc7QUlHE9JQWxSYhDmYspuA+vMTG4nCFZYYrB+8YKjHrexfZcV+kQv+Gv+56p5L1LM1xvBiQco4cK3lm8a8eiJ7BQu6IJ6vzASUO1vsDxX0UkAdhkVJi38BeVVVVJV6GZql3qALH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ggz3E2jH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ggz3E2jH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 142CE1F000E9;
	Fri, 19 Jun 2026 17:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781891168;
	bh=ky3rhIIem8oRxKNKwMCF/+8Z+JVXafDQ0reQ29XnBRk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ggz3E2jHwny6D8vaTmlBF0YMHbgiFXE+EmfggSs1U8Md7mYO/GEO2BVmkMs1dUE7F
	 cGY+fDo2rxccn82o9KKdjQJO3yRnrsvC/ThXQR1yr+PbY36XvYCqV3YYQNXL4H1aEI
	 yasG/BxH93f0I0iriJfG9GtQAFq/lbEcRszAyJ/q6NfaxL2euTurYelKYFgNqZkJie
	 +ndyw0xg8aq1XRxcK1AzHSX5YybTxQ69MWkhFjKlzSsoPRRbC+MaqBnxcM7TvL6D6g
	 Ekehm+eHSlJypychyAKvvCzeUZbGPFCcCASEjVf2EzEmUTgcbjl2Rhlw0FIDjB0ava
	 OmJDWRvWLy02Q==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject:
 [PATCH v2 5/6] cpufreq: intel_pstate: Consolidate HWP P-states initialization
Date: Fri, 19 Jun 2026 19:44:20 +0200
Message-ID: <10871015.nUPlyArG6x@rafael.j.wysocki>
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

After previous changes, intel_pstate_hybrid_hwp_adjust() does not do
much and its name and kerneldoc comment (which is not really necessary
becuase the function is static) have become a bit confusing.  Moreover,
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

v1 -> v2: New patch

---
 drivers/cpufreq/intel_pstate.c |  103 +++++++++++++++++++----------------------
 1 file changed, 50 insertions(+), 53 deletions(-)

--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -556,41 +556,6 @@ static int intel_pstate_freq_to_hwp(stru
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
-}
-
 static bool turbo_is_disabled(void)
 {
 	u64 misc_en;
@@ -2311,32 +2276,64 @@ static void intel_pstate_set_min_pstate(
 	intel_pstate_set_pstate(cpu, cpu->pstate.min_pstate);
 }
 
-static void intel_pstate_get_cpu_pstates(struct cpudata *cpu)
+static void intel_pstate_get_hwp_pstates(struct cpudata *cpu)
 {
-	int perf_ctl_scaling = pstate_funcs.get_scaling();
+	int perf_ctl_max_phys = cpu->pstate.max_pstate_physical;
+	int perf_ctl_scaling = cpu->pstate.perf_ctl_scaling;
+	int perf_ctl_turbo = cpu->pstate.turbo_pstate;
+	int cpuid = cpu->cpu;
+
+	__intel_pstate_get_hwp_cap(cpu);
+
+	if (!pstate_funcs.get_cpu_scaling)
+		return;
 
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
+	 * performance level accordingly.
+	 */
+	if (cpu->pstate.scaling != perf_ctl_scaling) {
+		int freq = perf_ctl_max_phys * perf_ctl_scaling;
+		unsigned int hwp = intel_pstate_freq_to_hwp(cpu, freq);
+
+		cpu->pstate.max_pstate_physical = hwp;
+
+		hwp_is_hybrid = true;
+	}
+	/*
+	 * If the CPU is going online for the first time and it was offline
+	 * initially, asym capacity scaling needs to be updated.
+	 */
+	hybrid_update_capacity(cpu);
+}
+
+static void intel_pstate_get_cpu_pstates(struct cpudata *cpu)
+{
 	cpu->pstate.max_pstate_physical = pstate_funcs.get_max_physical(cpu->cpu);
-	cpu->pstate.perf_ctl_scaling = perf_ctl_scaling;
+	cpu->pstate.turbo_pstate = pstate_funcs.get_turbo(cpu->cpu);
+	cpu->pstate.perf_ctl_scaling = pstate_funcs.get_scaling();
+	cpu->pstate.scaling = cpu->pstate.perf_ctl_scaling;
 
 	if (hwp_active && !hwp_mode_bdw) {
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
+		intel_pstate_get_hwp_pstates(cpu);
 	} else {
-		cpu->pstate.scaling = perf_ctl_scaling;
 		cpu->pstate.min_pstate = pstate_funcs.get_min(cpu->cpu);
 		cpu->pstate.max_pstate = pstate_funcs.get_max(cpu->cpu);
-		cpu->pstate.turbo_pstate = pstate_funcs.get_turbo(cpu->cpu);
 	}
 
 	intel_pstate_update_freq_limits(cpu);



