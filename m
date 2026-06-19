Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9783A784A;
	Fri, 19 Jun 2026 17:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781891182; cv=none; b=rGg6qdXqmRV8VL1qjkb4MrfckLUXX7ccWs3/ZJquYwXZslK4pivz74/PPThFXx+ua5O0KDJJ8yHzjAfGbMWkiZdXhWee0yxOf63CFCFkUEmh5FGxqU2MpuYCc3Dib5OEgylI5qeCas8jPqWIPSRTPii8+6AD1h8c+KMhrbLhHPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781891182; c=relaxed/simple;
	bh=87AR1mDSiosBrTSCjEoBby0NrFX+zdkm9RWwV8gRCJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ky+jCHnf1WRlZNEu8r+PUlkBvXutjM9H0jEM69X2ndt9ywdlHcIjji6cMyD1M6DHx03YVRF0VJ5U03OR4j85AMg1g2vbG4YfnGYip6XZXoToNx46fF1OHO4R8kn8FyiMIU1+f48hvSiaWiOv97y3iikE1t49nM6+H1Gf8JVyUxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=guFhDFih; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="guFhDFih"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A578F1F000E9;
	Fri, 19 Jun 2026 17:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781891181;
	bh=JCGUdV/EnVeM2KAXx1qn7wkTkdI2nO+mjzJ2n1XbNTU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=guFhDFihCBdI84oBfup71f3aloJQ39+88c0rfjqcf3rJPmaMchH/KAulopr7Z6zkk
	 P03XzJSG+yTWWOOeK4mBsyRIWvA4+peaACs9s6ESiYekaLlMTl5fh3zbBOLgGlaXyC
	 M2P1kVcttcLCbggNOqYGLZfmGZ/rHkmNWTgAWFIxrZlpKNuv+pT604OqXCwQPkwHHS
	 iaSbLQTQt+y/lxzFfX7osuBXHBC8AH87FSTmehWTI3Jk/aSyhatVzotgCEGkUg7I3D
	 BnK8f2kFL27qloD8u2u6+MVmAxkao8IRveeuqIb7TIRV3+65wYlrV+QiOivz0wR8Us
	 Lb8e463jVxJRA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject:
 [PATCH v2 1/6] cpufreq: intel_pstate: Fix setting minimum P-state at init
 time
Date: Fri, 19 Jun 2026 19:32:43 +0200
Message-ID: <5111529.31r3eYUQgx@rafael.j.wysocki>
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

v1 -> v2: No changes

---
 drivers/cpufreq/intel_pstate.c |   19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2352,8 +2352,6 @@ static void intel_pstate_get_cpu_pstates
 
 	if (pstate_funcs.get_vid)
 		pstate_funcs.get_vid(cpu);
-
-	intel_pstate_set_min_pstate(cpu);
 }
 
 /*
@@ -3059,6 +3057,7 @@ static int __intel_pstate_cpu_init(struc
 static int intel_pstate_cpu_init(struct cpufreq_policy *policy)
 {
 	int ret = __intel_pstate_cpu_init(policy);
+	struct cpudata *cpu;
 
 	if (ret)
 		return ret;
@@ -3069,11 +3068,11 @@ static int intel_pstate_cpu_init(struct
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
@@ -3304,8 +3303,6 @@ static int intel_cpufreq_cpu_init(struct
 		return ret;
 
 	policy->cpuinfo.transition_latency = INTEL_CPUFREQ_TRANSITION_LATENCY;
-	/* This reflects the intel_pstate_get_cpu_pstates() setting. */
-	policy->cur = policy->cpuinfo.min_freq;
 
 	req = kzalloc_objs(*req, 2);
 	if (!req) {
@@ -3326,9 +3323,15 @@ static int intel_cpufreq_cpu_init(struct
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
 



