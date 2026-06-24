Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10423DD50E;
	Wed, 24 Jun 2026 17:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782322586; cv=none; b=TBU+Cl62qe1GsIEdOIkdP97yHWwt0FxUYy32czOZbWf0op0Q2gzLPbaqJKBekW/yPnDEprr37wY+LfZjiD/bvn/fMfGGbuCn0OTmdjEvlVJNUjFBxsUK1WX1cobBLg50igrOVD9Ebo5LpLUfkLguEqI4aV9pWoVLApoa8OrGU58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782322586; c=relaxed/simple;
	bh=M8ZNk40bQxrxt/VWdy6pIYRL6+fL/Oekb3lWO5ULmnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g08XBMrVqMWqFJma/DcVbMC1udjFJlQ6QBo3G2LrXkvWlHk0eECcP2TKu5SQpbp4SM4HMYXUUc4lb0ugNSK2Kk8kqximjLkdqv9X6JM4cRFuWe4DLvufjEVmrJXm0TdtTdyHWlkFbjJXoUhm/p/9umlRD2m64030ROxcv6SeJYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QzooOGrF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QzooOGrF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D36BE1F000E9;
	Wed, 24 Jun 2026 17:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782322584;
	bh=WfExmRudyPhFj3qQoMRSGgURd5MKhCPpdtLkI4Gxxo4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QzooOGrF0ClVW7J2cEZo53UcauRlcmDxFekLH5MfBbDnjXu+SDgebTzL3HdNJHWqn
	 vwPUsaTkGaLjdI5khxzi4DUFGxHy0HIt//67M9AxUOUtJEJOQDIZ/5RtSK4FS3x6ek
	 z6rt/Xy9NqbQDC/3pjZrgRKPK8WPGmHxE0P5Q9eKeTXswdXFx/Tbj5MQX1LxRkmVqm
	 RS4FX2+0mdecc5d7sEIp/NM7fdN2sJXJ/mHHPiknUoX4g4jNf4sEA9shBbAqFtThXc
	 7gRXOLZpGznU2urMGvkWmlEHhHhphw6GqhpwWn4nqYtM6q7R/4eaD+lyvNvSKE3h4z
	 e8aBHTzrvmcRg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Doug Smythies <dsmythies@telus.net>
Subject:
 [PATCH v3 3/4] cpufreq: intel_pstate: Consolidate frequency values
 computation
Date: Wed, 24 Jun 2026 19:35:23 +0200
Message-ID: <3059329.e9J7NaK4W3@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <4752842.LvFx2qVVIh@rafael.j.wysocki>
References: <4752842.LvFx2qVVIh@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Update intel_pstate_get_cpu_pstates() to use
intel_pstate_update_freq_limits() for computing the max and
turbo frequency values in all cases, including non-hybrid HWP
and HWP disabled.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index e143c80a3215..edc90ecb0b00 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -590,13 +590,11 @@ static void intel_pstate_hybrid_hwp_adjust(struct cpudata *cpu)
 	freq = perf_ctl_max_phys * perf_ctl_scaling;
 	cpu->pstate.max_pstate_physical = intel_pstate_freq_to_hwp(cpu, freq);
 
-	freq = cpu->pstate.min_pstate * perf_ctl_scaling;
-	cpu->pstate.min_freq = freq;
 	/*
 	 * Cast the min P-state value retrieved via pstate_funcs.get_min() to
 	 * the effective range of HWP performance levels.
 	 */
-	cpu->pstate.min_pstate = intel_pstate_freq_to_hwp(cpu, freq);
+	cpu->pstate.min_pstate = intel_pstate_freq_to_hwp(cpu, cpu->pstate.min_freq);
 }
 
 static bool turbo_is_disabled(void)
@@ -2320,6 +2318,7 @@ static void intel_pstate_get_cpu_pstates(struct cpudata *cpu)
 
 	cpu->pstate.max_pstate_physical = pstate_funcs.get_max_physical(cpu->cpu);
 	cpu->pstate.min_pstate = pstate_funcs.get_min(cpu->cpu);
+	cpu->pstate.min_freq = cpu->pstate.min_pstate * perf_ctl_scaling;
 	cpu->pstate.perf_ctl_scaling = perf_ctl_scaling;
 
 	if (hwp_active && !hwp_mode_bdw) {
@@ -2328,7 +2327,6 @@ static void intel_pstate_get_cpu_pstates(struct cpudata *cpu)
 		if (pstate_funcs.get_cpu_scaling) {
 			cpu->pstate.scaling = pstate_funcs.get_cpu_scaling(cpu->cpu);
 			intel_pstate_hybrid_hwp_adjust(cpu);
-			intel_pstate_update_freq_limits(cpu);
 		} else {
 			cpu->pstate.scaling = perf_ctl_scaling;
 		}
@@ -2343,11 +2341,7 @@ static void intel_pstate_get_cpu_pstates(struct cpudata *cpu)
 		cpu->pstate.turbo_pstate = pstate_funcs.get_turbo(cpu->cpu);
 	}
 
-	if (cpu->pstate.scaling == perf_ctl_scaling) {
-		cpu->pstate.min_freq = cpu->pstate.min_pstate * perf_ctl_scaling;
-		cpu->pstate.max_freq = cpu->pstate.max_pstate * perf_ctl_scaling;
-		cpu->pstate.turbo_freq = cpu->pstate.turbo_pstate * perf_ctl_scaling;
-	}
+	intel_pstate_update_freq_limits(cpu);
 
 	if (pstate_funcs.get_aperf_mperf_shift)
 		cpu->aperf_mperf_shift = pstate_funcs.get_aperf_mperf_shift();
-- 
2.51.0




