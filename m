Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C895A3C0624;
	Fri, 19 Jun 2026 17:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781891182; cv=none; b=s7+6Sg4BMqlUXeVmaG3GtK+4Pe+wX2E0vdkEImfsUVEsf62qvs1A8X2zXeP/9f4UkhVpggr71HgV8n6EvBKbyGdW7JlnBRA0ed5KR5npiRXsA6O1F/60/4eobqX8lNlvRBH1huN8p48vsQZC3St2zbRQ05E+TLUY13Jnqa2nhZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781891182; c=relaxed/simple;
	bh=QDqFKt5uGg7IxyJj3hTzirN+kE+QCB9rxT8zZERihEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OMVqzHTQ2pHOmX0y99cYmE0ooVfInqgRZU14MDNRXSJlx+3bQRJq45/SdWa1KGRpdVVn9uF+stVY4Rs7H9mqJr9+uum/vInjgtlu41vmKXKtkrviwzJaf8gnL08DuI59wH4o5ZDaGN6xS2jfEdJcbWLIkwY+F4dYgPAwoi8Ps1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4+Vv2V5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4+Vv2V5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACD171F00A3A;
	Fri, 19 Jun 2026 17:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781891178;
	bh=fYHvW89AsndmzuSQWtCYZEjFpOAPgXd7h2DbMJ73fhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h4+Vv2V5+U7YoGOlVlX+HPyC29Vh/a8mkdpE0alo4BEm52+kSVObX0Or6nwHy5DLY
	 Z0PxU5DiSbA09T3QZXCSKUQC+Vlzuqg65qErNWz+Jk6HXvJMw+b32lolC110JBXwGS
	 /p+fkVnTzB/QMGKUxseYwMmMaDjl3LKKRVh6jKl6jLxvAU80aENEj/oBVoYfnVT4Gf
	 OfzBpDgPRhrUk5hRRaGvJiuMwK6eelNq7g9ETnHXUOohTXV23vcxnr9JfEJguA2jmn
	 iRr6jE7xm+LcTIOOkXkCGbroZnaey9lGvUCm8t1jKREHPP/E1NL9qTLATP4sHs+4ny
	 2KrOiCAJ/xBpg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject:
 [PATCH v2 2/6] cpufreq: intel_pstate: Introduce
 intel_pstate_update_freq_limits()
Date: Fri, 19 Jun 2026 19:35:03 +0200
Message-ID: <5082437.GXAFRqVoOG@rafael.j.wysocki>
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

Introduce a new helper function, intel_pstate_update_freq_limits(),
for updating the max and turbo frequency values for the given CPU after
updating the corresponding P-states.

Use it in intel_pstate_get_hwp_cap() and intel_pstate_get_cpu_pstates(),
in the latter case instead of the direct updates of the max and turbo
frequency values in intel_pstate_hybrid_hwp_adjust().

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: New patch

---
 drivers/cpufreq/intel_pstate.c |   36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -587,11 +587,6 @@ static void intel_pstate_hybrid_hwp_adju
 
 	hwp_is_hybrid = true;
 
-	cpu->pstate.turbo_freq = rounddown(cpu->pstate.turbo_pstate * scaling,
-					   perf_ctl_scaling);
-	cpu->pstate.max_freq = rounddown(cpu->pstate.max_pstate * scaling,
-					 perf_ctl_scaling);
-
 	freq = perf_ctl_max_phys * perf_ctl_scaling;
 	cpu->pstate.max_pstate_physical = intel_pstate_freq_to_hwp(cpu, freq);
 
@@ -1181,6 +1176,22 @@ static bool hybrid_clear_max_perf_cpu(vo
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
@@ -1193,20 +1204,8 @@ static void __intel_pstate_get_hwp_cap(s
 
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
@@ -2327,6 +2326,7 @@ static void intel_pstate_get_cpu_pstates
 		if (pstate_funcs.get_cpu_scaling) {
 			cpu->pstate.scaling = pstate_funcs.get_cpu_scaling(cpu->cpu);
 			intel_pstate_hybrid_hwp_adjust(cpu);
+			intel_pstate_update_freq_limits(cpu);
 		} else {
 			cpu->pstate.scaling = perf_ctl_scaling;
 		}



