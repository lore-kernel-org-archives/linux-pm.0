Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA3B34846A;
	Wed, 24 Jun 2026 17:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782322583; cv=none; b=nDpr74MtMVK4BS+4N3dBBYF38nAdamXZtAm4b5I5kwFFkkl+twGNnCcp2oP3iMf+JUn+zngHzLMh8lDMrYzjXSeQ2hPUdqLLnEmhYNu33OAB0vR34MtAnUcpxLTjC8mewDLu4sZiog0S6x9vUwtSwccPjl+CJLyxxOG35kGCySc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782322583; c=relaxed/simple;
	bh=Nh+ZK0Futar+xVZq79GNJSjS8XKMNa61oiZRJdDTrE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fK/z5a+KZGESiOARGkULFG25dEtIjsZszTd7VearNvD1QeZgOAv/f18sw/P/2uH8we4sJRxIqCWZSs/LK86EfzoSpL+hv7PgoYwI5Ss7505XitCNnDlwQ9StbL0WdDFJT+ot5R+5EstgHM6KaVw9vH7pVfZI4M3ErCS1yo/4AkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NOnjuM9e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NOnjuM9e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1EFC1F000E9;
	Wed, 24 Jun 2026 17:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782322581;
	bh=iq806iFwOzzgxnf/TFhXF+kIms0xBX2UwXUN4FXUqZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NOnjuM9e5g77oTvEpZRjkwviPCcr5b8B8Nh2GyO2eyg2gScoR0sHi9frhoVwLE6Sc
	 PwKlxR+ZKxpPE1GWrksxglxu2qQ9MICBk7aFjtwNUMcX4NGGHO6UKlvN5QajSyrlG6
	 /jzUhxsyXCNd3tcOXwccGDOGT6k/l8lzFBVs7468gZtst5N0tXpHSE1Qn0AflkwWwr
	 tZ9cT3QjWAtXW3WPWMeGvgzFCFIjFHk6f+uZ39oIqpPUv6YO0HNML3GI8HpbJ3fHX0
	 T4zKJdwRm3B6gWiQ/LnTbtI2Wa3/qe2n8ODZE2sdkSDxjCE5MrkKBjeM/NfrGC8Wvl
	 AU7f7V9hrwG8Q==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Doug Smythies <dsmythies@telus.net>
Subject:
 [PATCH v3 4/4] cpufreq: intel_pstate: Move two functions closer to callers
Date: Wed, 24 Jun 2026 19:36:05 +0200
Message-ID: <3433588.44csPzL39Z@rafael.j.wysocki>
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

Move intel_pstate_set_pstate() and intel_pstate_set_min_pstate() that
are not used on systems with HWP enabled, closer to their first
callers.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c | 36 +++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index edc90ecb0b00..25ef2848eebf 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2294,24 +2294,6 @@ static int hwp_get_cpu_scaling(int cpu)
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
 static void intel_pstate_get_cpu_pstates(struct cpudata *cpu)
 {
 	int perf_ctl_scaling = pstate_funcs.get_scaling();
@@ -2874,6 +2856,19 @@ static void intel_pstate_update_perf_limits(struct cpudata *cpu,
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
@@ -2961,6 +2956,11 @@ static int intel_pstate_verify_policy(struct cpufreq_policy_data *policy)
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
-- 
2.51.0




