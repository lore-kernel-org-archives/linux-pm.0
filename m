Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D0A3DD53B;
	Wed, 24 Jun 2026 17:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782322592; cv=none; b=DCQ29GsjxkIO1S71VEOeOiXSP0iB1+GXvYP8eVY1GaSNNq9DLNQUizVNhGNLBrjGS6hlVcYjXwHOii8qTtRc9BQ1Sbw0umpSAiB3nF7BD/mx/4sU6M4lQ5/L99BI0cPH54pda/pujNQj5I7KRCk8LVIKzz/arJhS3hx1zR4gnDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782322592; c=relaxed/simple;
	bh=zPZqX26sJN/XWAyecQ4Jul9qQnnr0HSzH0tfoFBi9Lk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZvWtmztJaGMf6IfW7WIb+5lqLkoe1h3mSlj4hfoayDVIWMAyYWn6eyeoOlGYea6hm79a0cKfVn3cYEeqvrduy9CP6gUZQLjZ22G9b/xRpeeR5JNwIEyyencWKSWUgFBjl1zLrSl2tyErMAFoIYfEi3ULoISgnLue/Gxyy1c7cvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LMeS1J74; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LMeS1J74"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3490F1F000E9;
	Wed, 24 Jun 2026 17:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782322591;
	bh=tG26nNdd4eiV6OGN8UrZfwgw4ikNUQbSG+vt/PYrgj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LMeS1J74+UjYQElXTvnCSsTJCZycWAbHmtxMcCC0H8NijJ3rKsGdP+HZVx7RBH8PW
	 jubejtucIy9XCNwnmG0fvpe9u7oLjUY8dw4lqEceWwoJzGN4sNNAG8fYUIP/SVrNVS
	 /wbUcPZ7+Lhm/W2yOpOcxtTh0thdRMA3R46hD9Ly9piYAOx/WUi1WhWqm2zlat3+pl
	 drV+SmEKpsIakdIy5rWDG02zYCaBfKJSL/uuj58I1CGJrzkNR9BfY6bf9Bq4FiOY1/
	 VwNELvYQMP1Jax/clNmXlS/YvU0lejIuJNyTTX5YXBdSgmW7yrTKzazlUOrvVar/d1
	 qIH/XCNVD7FxA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Doug Smythies <dsmythies@telus.net>
Subject:
 [PATCH v3 1/4] cpufreq: intel_pstate: Fix setting minimum P-state at init
 time
Date: Wed, 24 Jun 2026 19:33:08 +0200
Message-ID: <5090465.GXAFRqVoOG@rafael.j.wysocki>
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
 drivers/cpufreq/intel_pstate.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 1f093e346430..95e41e975c45 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2354,8 +2354,6 @@ static void intel_pstate_get_cpu_pstates(struct cpudata *cpu)
 
 	if (pstate_funcs.get_vid)
 		pstate_funcs.get_vid(cpu);
-
-	intel_pstate_set_min_pstate(cpu);
 }
 
 /*
@@ -3062,6 +3060,7 @@ static int __intel_pstate_cpu_init(struct cpufreq_policy *policy)
 static int intel_pstate_cpu_init(struct cpufreq_policy *policy)
 {
 	int ret = __intel_pstate_cpu_init(policy);
+	struct cpudata *cpu;
 
 	if (ret)
 		return ret;
@@ -3072,11 +3071,11 @@ static int intel_pstate_cpu_init(struct cpufreq_policy *policy)
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
@@ -3300,8 +3299,6 @@ static int intel_cpufreq_cpu_init(struct cpufreq_policy *policy)
 		return ret;
 
 	policy->cpuinfo.transition_latency = INTEL_CPUFREQ_TRANSITION_LATENCY;
-	/* This reflects the intel_pstate_get_cpu_pstates() setting. */
-	policy->cur = policy->cpuinfo.min_freq;
 
 	req = kzalloc_objs(*req, 2);
 	if (!req) {
@@ -3322,9 +3319,15 @@ static int intel_cpufreq_cpu_init(struct cpufreq_policy *policy)
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
 
-- 
2.51.0




