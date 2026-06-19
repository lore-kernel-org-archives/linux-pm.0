Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A083B19D1;
	Fri, 19 Jun 2026 17:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781891167; cv=none; b=AXnR8svZCd8gKUUXFYtabaVOPSh5z6IEiWqgUiR5KgcWLmupid3NH6R6PvYcyIwZDSv5Lj3XixXLU76H2gdJBx2bHMlCktbdoCEqx/c0s6ZuVExzeONyM7Z+e+xL3CfXnhhKlySXj3O14Iv/gUKxIQ15FW0fLB5OYmSwX5n6+fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781891167; c=relaxed/simple;
	bh=RWEOWnsrA3HI81PPpHcmRCsQs+IuFaUsxW6u+cVQXpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SKr79dpGvnCk3FWRIcvZc4zok78K3wbkm/GNQf4ZA0yEq2jlUbhCq4tiQCrgHhP5p1c6ZJG8wH9JEnwfrYMkeRmda4FlYPTVGFRU7APGH7c2bFC4cuxfgCO8gQCo0NLTtCdsguFBeN6orlxKS2/eEenWHlO5bV8R8sRIbTwu6Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CIOmWkyd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CIOmWkyd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D55C1F000E9;
	Fri, 19 Jun 2026 17:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781891165;
	bh=ZeWfL5j6jgN68jlol6NZaK8GYIZ1lyQxVIP1XkXLT9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CIOmWkydZ+p1/dncUhUgsbyoarHkS5TP2VFADrqYH1Po0F8hintFEVoBK2Yie8EXn
	 QulHZrdh8Tk6BY+eElVYIjSYsfsLW47gQ2tER+AqS7EQ5C1ej4kJ+Lfhcxn2ZFDzrV
	 xJAVn/T4GGA5+JDtwQqrNgny9f3rU26lS3Q0iH7HrFPWYExN6MfjVQzDUU2IC8V0+f
	 5it1RraGP0N8168BzFZcpXBeINGCLxIRCGBfdnY1gmd/TMPCZFvJPE1qi3rRQKWZtF
	 3fisc5gfBGeUrIfVBmfeKvTKTIGCK6gZSNB8dvxfKlzA02r76nBdZZeBm6fSuIHXHs
	 NJ8iasyvLKspA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject:
 [PATCH v2 6/6] cpufreq: intel_pstate: Move two functions closer to callers
Date: Fri, 19 Jun 2026 19:45:19 +0200
Message-ID: <2044603.PYKUYFuaPT@rafael.j.wysocki>
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

Move intel_pstate_set_pstate() and intel_pstate_set_min_pstate() that
are not used on systems with HWP enabled, closer to their first
callers.

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: New patch

---
 drivers/cpufreq/intel_pstate.c |   36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2258,24 +2258,6 @@ static int hwp_get_cpu_scaling(int cpu)
 	return intel_pstate_cppc_get_scaling(cpu);
 }
 
-static void intel_pstate_set_pstate(struct cpudata *cpu, int pstate)
-{
-	trace_cpu_frequency(pstate * cpu->pstate.scaling, cpu->cpu);
-	cpu->pstate.current_pstate = pstate;
-	/*
-	 * Generally, there is no guarantee that this code will always run on
-	 * the CPU being updated, so force the register update to run on the
-	 * right CPU.
-	 */
-	wrmsrq_on_cpu(cpu->cpu, MSR_IA32_PERF_CTL,
-		      pstate_funcs.get_val(cpu, pstate));
-}
-
-static void intel_pstate_set_min_pstate(struct cpudata *cpu)
-{
-	intel_pstate_set_pstate(cpu, cpu->pstate.min_pstate);
-}
-
 static void intel_pstate_get_hwp_pstates(struct cpudata *cpu)
 {
 	int perf_ctl_max_phys = cpu->pstate.max_pstate_physical;
@@ -2869,6 +2851,19 @@ static void intel_pstate_update_perf_lim
 		 cpu->min_perf_ratio);
 }
 
+static void intel_pstate_set_pstate(struct cpudata *cpu, int pstate)
+{
+	trace_cpu_frequency(pstate * cpu->pstate.scaling, cpu->cpu);
+	cpu->pstate.current_pstate = pstate;
+	/*
+	 * Generally, there is no guarantee that this code will always run on
+	 * the CPU being updated, so force the register update to run on the
+	 * right CPU.
+	 */
+	wrmsrq_on_cpu(cpu->cpu, MSR_IA32_PERF_CTL,
+		      pstate_funcs.get_val(cpu, pstate));
+}
+
 static int intel_pstate_set_policy(struct cpufreq_policy *policy)
 {
 	struct cpudata *cpu;
@@ -2956,6 +2951,11 @@ static int intel_pstate_verify_policy(st
 	return 0;
 }
 
+static void intel_pstate_set_min_pstate(struct cpudata *cpu)
+{
+	intel_pstate_set_pstate(cpu, cpu->pstate.min_pstate);
+}
+
 static int intel_cpufreq_cpu_offline(struct cpufreq_policy *policy)
 {
 	struct cpudata *cpu = all_cpu_data[policy->cpu];



