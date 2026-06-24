Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637663DD519;
	Wed, 24 Jun 2026 17:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782322589; cv=none; b=aRkIiooJWjHBfVYrWziT5R3xvIJsCHjOFQ5GOPBhXub7gWAlaCITMuPFXW3Z3jcAU+SateFqIHV9uvqJ151l3tUBTAxEO7sYOqx/m5e0toAMHtAOoQ+w8SOZgikYhpUFY9qFOKqDJo8UfmdJp+T48JW3bWDQQWU8u/0EjjaeIfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782322589; c=relaxed/simple;
	bh=1zd1R62Mf8N1KIewdDdGgNrM0tAKC+wUkWYk4+DmVOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cRYOZ+virddj1VCQNV6rp21Q13Rsh0zJbIr0Fwm4TWJNLgLZXjnaSfLtKUp1OO627dRgn7KgmqHx6nBryguyrrDo5+kcWStY7UJvaO0oovfbQPN6UWiW0bEyp5ofodIIBq7uVizx2Yavrgpy2yeTy035sXcgOUZVElHDz/USknM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GNsdhy7m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GNsdhy7m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A9EA1F000E9;
	Wed, 24 Jun 2026 17:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782322588;
	bh=9nVY/c5wQhoTVgunSzgOhHkZ+PopC5sbBIi2Wc+GNYc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GNsdhy7mDae76WObozdqUmqw5TRoQdDFEUemVEVwZ6fdWfjoDk7wvP3/vZ+9baQYs
	 CaAwSvoBgIzc+tkhVdyz6d7RqzNzC29JfGfO46wjmHvkD3bZDNOV9EHJLA1sEJwOay
	 mOiWRvUYMEpZf068lr1dsAJiAegis/DIi1ARdstnK0krIest3mnBvszJEZyMTGb3XK
	 RElvWBIcGgXzumeZY3BZIUEoexEPX6nCVl2Z3fKqjbdptrooVc4gA7Ddu7WM8stfrG
	 Q4usO4SNWj2PoDT61ihwSLfqtCrBZkaWIaab76JNPgsBZuE/IJTjT7fDNsRZuiOCV1
	 1Gpeb44iM9RZA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Doug Smythies <dsmythies@telus.net>
Subject:
 [PATCH v3 2/4] cpufreq: intel_pstate: Introduce
 intel_pstate_update_freq_limits()
Date: Wed, 24 Jun 2026 19:34:10 +0200
Message-ID: <2277328.irdbgypaU6@rafael.j.wysocki>
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

Introduce a new helper function, intel_pstate_update_freq_limits(),
for updating the max and turbo frequency values for the given CPU after
updating the corresponding P-states.

Use it in intel_pstate_get_hwp_cap() and intel_pstate_get_cpu_pstates(),
in the latter case instead of the direct updates of the max and turbo
frequency values in intel_pstate_hybrid_hwp_adjust().

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c | 36 +++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 95e41e975c45..e143c80a3215 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -587,11 +587,6 @@ static void intel_pstate_hybrid_hwp_adjust(struct cpudata *cpu)
 
 	hwp_is_hybrid = true;
 
-	cpu->pstate.turbo_freq = rounddown(cpu->pstate.turbo_pstate * scaling,
-					   perf_ctl_scaling);
-	cpu->pstate.max_freq = rounddown(cpu->pstate.max_pstate * scaling,
-					 perf_ctl_scaling);
-
 	freq = perf_ctl_max_phys * perf_ctl_scaling;
 	cpu->pstate.max_pstate_physical = intel_pstate_freq_to_hwp(cpu, freq);
 
@@ -1183,6 +1178,22 @@ static bool hybrid_clear_max_perf_cpu(void)
 	return ret;
 }
 
+static void intel_pstate_update_freq_limits(struct cpudata *cpu)
+{
+	int scaling = cpu->pstate.scaling;
+	unsigned int turbo_freq = cpu->pstate.turbo_pstate * scaling;
+	unsigned int max_freq = cpu->pstate.max_pstate * scaling;
+	int perf_ctl_scaling = cpu->pstate.perf_ctl_scaling;
+
+	if (scaling != perf_ctl_scaling) {
+		turbo_freq = rounddown(turbo_freq, perf_ctl_scaling);
+		max_freq = rounddown(max_freq, perf_ctl_scaling);
+	}
+
+	cpu->pstate.turbo_freq = turbo_freq;
+	cpu->pstate.max_freq = max_freq;
+}
+
 static void __intel_pstate_get_hwp_cap(struct cpudata *cpu)
 {
 	u64 cap;
@@ -1195,20 +1206,8 @@ static void __intel_pstate_get_hwp_cap(struct cpudata *cpu)
 
 static void intel_pstate_get_hwp_cap(struct cpudata *cpu)
 {
-	int scaling = cpu->pstate.scaling;
-
 	__intel_pstate_get_hwp_cap(cpu);
-
-	cpu->pstate.max_freq = cpu->pstate.max_pstate * scaling;
-	cpu->pstate.turbo_freq = cpu->pstate.turbo_pstate * scaling;
-	if (scaling != cpu->pstate.perf_ctl_scaling) {
-		int perf_ctl_scaling = cpu->pstate.perf_ctl_scaling;
-
-		cpu->pstate.max_freq = rounddown(cpu->pstate.max_freq,
-						 perf_ctl_scaling);
-		cpu->pstate.turbo_freq = rounddown(cpu->pstate.turbo_freq,
-						   perf_ctl_scaling);
-	}
+	intel_pstate_update_freq_limits(cpu);
 }
 
 static void hybrid_update_capacity(struct cpudata *cpu)
@@ -2329,6 +2328,7 @@ static void intel_pstate_get_cpu_pstates(struct cpudata *cpu)
 		if (pstate_funcs.get_cpu_scaling) {
 			cpu->pstate.scaling = pstate_funcs.get_cpu_scaling(cpu->cpu);
 			intel_pstate_hybrid_hwp_adjust(cpu);
+			intel_pstate_update_freq_limits(cpu);
 		} else {
 			cpu->pstate.scaling = perf_ctl_scaling;
 		}
-- 
2.51.0




