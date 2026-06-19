Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4388438330E;
	Fri, 19 Jun 2026 17:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781891173; cv=none; b=balLs/RdtRGCw2HTwNPUcEWA04KoR57FxgiyurDZoMZBiFgJswsAiuu48XMM9Um5qurxnyqPVGPsxGjTP9XTwXHWdgE6dUw+lKSoiGZ2Y0ddLtDeRiL/9lPGZsENC//nhgTxIpPZtgsgJ2NvoBm/aMBSYZoXMtTdiclshsbHXvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781891173; c=relaxed/simple;
	bh=IXPTSJKorH+Z3pN+kulUzB8wkAi1vYu5KK25+omI53o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IPpXDtw6jQ2pOmXZEvN79Dw5PW2lomQhEd+Ya2PIkbmHPakiwa+ubllI//mkJqcfxCZoluXwSR8l6Va1GVUCLtJJifgJQOQ3NqRqCpyI8pWNaRubY5IVk03RoBPIzEBOQJJ2kXautYeXEhiESFYyusRIGJLVEWNsQhmv5dnzot8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZXRA6fp1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZXRA6fp1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25D181F00A3D;
	Fri, 19 Jun 2026 17:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781891171;
	bh=ioCCBBGFTQSxIvsQRNSBzle3SgLhMsxCvdim5DG8pR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZXRA6fp1+cjHSOK2rb13e3DgRKLCqgaetnOmzhav4yJjU2yDR/DJV5qAn77Xtq2NA
	 8Lb4v2KwozK2G33ivJEnm8y+hjAFZwCRQfu3Mf/H86cT2fecxIcO6MkXNwi/KwZcRm
	 xhHqDwLdBF01/ojzwmtzeBmKMYg+uhe592OLTwPy0B21T039Htqfks3XGllwELZLKR
	 nWwVha1UFBCQr3uiG4/bXsC5MWGLCV0p0aBDab/MmpXNpr4C/VXVw9ZXAhL+b+tQMO
	 FDW52Rn8R6Bt3ADMUpY/KAc0AOG9q+NrnyQYvK7Sa7gRfGToNQK6jiRO78flUnbWvW
	 HCzQ9E54ppZHA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject:
 [PATCH v2 4/6] cpufreq: intel_pstate: Consolidate frequency values
 computation
Date: Fri, 19 Jun 2026 19:42:24 +0200
Message-ID: <3425962.44csPzL39Z@rafael.j.wysocki>
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

Update intel_pstate_get_cpu_pstates() to use
intel_pstate_update_freq_limits() for computing the max and
turbo frequency values in all cases, including non-hybrid HWP
and HWP disabled.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: New patch

---
 drivers/cpufreq/intel_pstate.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2324,7 +2324,6 @@ static void intel_pstate_get_cpu_pstates
 		if (pstate_funcs.get_cpu_scaling) {
 			cpu->pstate.scaling = pstate_funcs.get_cpu_scaling(cpu->cpu);
 			intel_pstate_hybrid_hwp_adjust(cpu);
-			intel_pstate_update_freq_limits(cpu);
 		} else {
 			cpu->pstate.scaling = perf_ctl_scaling;
 		}
@@ -2340,11 +2339,7 @@ static void intel_pstate_get_cpu_pstates
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



