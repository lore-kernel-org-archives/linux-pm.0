Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1FB4921B9;
	Wed, 17 Jun 2026 16:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781713830; cv=none; b=p5ZRgO1cglkUFFjtRQG9lDOIKTAnFd2JnS8PISkkZG4UehTTIjNmgv1mKRqd/hqTiCBTW4uP6dqgd8hdqCSrQofw+xSsQp2F/7xA1JbvHFcF4TdLDowY6pQ5PrvKLKxW9gH7BITTs9JrlM30bC1FcvHRcIP+yDv5CRo8LFVAd+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781713830; c=relaxed/simple;
	bh=emxGE5E8SksY4QXu0nkUPxfnvIAc44eMpyjMelAA0VQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HZUWnWADIM15jziopLVfOxlXxI0eKN7sULy5U4jpB69KRMKP/OGG5HbgsM07MKnp2KrrXDM4nzRhr4AIjUvEpYal8OZKrtMVya2uM4DaHCby3rF6UvRCDGZe4kpCtgoKnLgYeJOFnd55pjsfcTcie4IFre6fJcV9Rtu9xN2sY30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5plnJ39; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5plnJ39"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 231E61F00A3A;
	Wed, 17 Jun 2026 16:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781713823;
	bh=VXbB0qmBx2S0vcs0nfx3/G4OhWrcuWIa2rVcpwM9PM8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h5plnJ39IqrNZyY41MfX/MErHXgUsC9hkiO00ujlo/5B821R0tB0tUibRka2aI1dE
	 maO8G4+F8X97I4QcXpGEadT950d2r6UW3JFe3JSuBy5nCBuQg8oBwAmgaJMJbzsqnE
	 OvgBGES5Tb4/nq5PFftMt7Pwo4BX9CbIsEguzSvp4brvIWlEhIHOBUBjlyfTSBXSs/
	 /Z9izDLqLgYSvVXMXdG2FjyH0T8G2YcPuX33mLyeg6AadAZd8lCsO/3+WEi/XS4fe1
	 wCTcM56klF3Df3CqB1ihBDo2breMgJXo6Ir7A5gjuAyEWFVNe8tkb3HdLMKYImqxZg
	 vhB3b4qjRRHSg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject:
 [PATCH v1 1/2] cpufreq: intel_pstate: Fix setting minimum P-state at init
 time
Date: Wed, 17 Jun 2026 18:29:31 +0200
Message-ID: <23170058.EfDdHjke4D@rafael.j.wysocki>
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

If HWP is enabled, writes to MSR_IA32_PERF_CTL have no effect,
so intel_pstate_get_cpu_pstates() should not attempt to call
intel_pstate_set_min_pstate() to set the minimum P-state for the
given CPU in that case.

Accordingly, remove the intel_pstate_set_min_pstate()
call from intel_pstate_get_cpu_pstates() and make both
intel_pstate_cpu_init() and intel_cpufreq_cpu_init() call
that function in their non-HWP code paths.

The HWP code path in intel_pstate_cpu_init() does not need to update
the current P-state of the CPU directly at all because it is taken
care of the processor automatically, but the HWP code path of
intel_cpufreq_cpu_init() should update it in principle to
initialize the DESIRED_PERF field in MSR_HWP_REQUEST.  For this
purpose, make it call intel_cpufreq_hwp_update() and pass
the minimum P-state limit to it as the current target value along
with the current minimum and maximum limits.

Fixes: f6ebbcf08f37 ("cpufreq: intel_pstate: Implement passive mode with HWP enabled")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |   19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2354,8 +2354,6 @@ static void intel_pstate_get_cpu_pstates
 
 	if (pstate_funcs.get_vid)
 		pstate_funcs.get_vid(cpu);
-
-	intel_pstate_set_min_pstate(cpu);
 }
 
 /*
@@ -3061,6 +3059,7 @@ static int __intel_pstate_cpu_init(struc
 static int intel_pstate_cpu_init(struct cpufreq_policy *policy)
 {
 	int ret = __intel_pstate_cpu_init(policy);
+	struct cpudata *cpu;
 
 	if (ret)
 		return ret;
@@ -3071,11 +3070,11 @@ static int intel_pstate_cpu_init(struct
 	 */
 	policy->policy = CPUFREQ_POLICY_POWERSAVE;
 
-	if (hwp_active) {
-		struct cpudata *cpu = all_cpu_data[policy->cpu];
-
+	cpu = all_cpu_data[policy->cpu];
+	if (hwp_active)
 		cpu->epp_cached = intel_pstate_get_epp(cpu, 0);
-	}
+	else
+		intel_pstate_set_min_pstate(cpu);
 
 	return 0;
 }
@@ -3306,8 +3305,6 @@ static int intel_cpufreq_cpu_init(struct
 		return ret;
 
 	policy->cpuinfo.transition_latency = INTEL_CPUFREQ_TRANSITION_LATENCY;
-	/* This reflects the intel_pstate_get_cpu_pstates() setting. */
-	policy->cur = policy->cpuinfo.min_freq;
 
 	req = kzalloc_objs(*req, 2);
 	if (!req) {
@@ -3328,9 +3325,15 @@ static int intel_cpufreq_cpu_init(struct
 		WRITE_ONCE(cpu->hwp_req_cached, value);
 
 		cpu->epp_cached = intel_pstate_get_epp(cpu, value);
+
+		intel_cpufreq_hwp_update(cpu, cpu->pstate.min_pstate,
+					 cpu->pstate.max_pstate,
+					 cpu->pstate.min_pstate, false);
 	} else {
 		policy->transition_delay_us = INTEL_CPUFREQ_TRANSITION_DELAY;
+		intel_pstate_set_min_pstate(cpu);
 	}
+	policy->cur = policy->cpuinfo.min_freq;
 
 	freq = DIV_ROUND_UP(cpu->pstate.turbo_freq * global.min_perf_pct, 100);
 



