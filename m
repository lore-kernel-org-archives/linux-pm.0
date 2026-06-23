Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788643932DB;
	Tue, 23 Jun 2026 17:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782236154; cv=none; b=t5t9ULobd0vRgeobWf9hWwB7BMZzeAVKQA1boXnzqCPJQJ6WJ84Npb+TUErtzkW16EOw1tM+bqFSbcRsGBxEUAZaqNMsvCS79yLW6X/MRSPtojxqGw2siKJr5e3Lh3YTH/t5DimWRk9HrA6TrnhJfxXp5j/iL1V4hkR2+JbtxXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782236154; c=relaxed/simple;
	bh=NP/icPK2Gjr+ivcxtfnYc0/pDeEFDO8TyPuDHLWdMk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CdGVyZ8F7v9l5G/yh5bzOs4rOfKfrT+wQusu+V1VX3+kebSfMWtBrq0Dxjyj2kFKFA/VIWrMPu67y/atJvkbg1hiIn7jR4k203s2PnHgUhSB8gqbooQvVlJcTgiH0Li2VggNhhiQdXcMy+4cav4KlIlr0VKvtkbncRjUot5siqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMwgokWw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMwgokWw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 664911F000E9;
	Tue, 23 Jun 2026 17:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782236153;
	bh=zqQoIKzrrfNDhSSQ0Y79oRI+15/uJrJQE4BWsk9/Wsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WMwgokWw09YdIj/zqXCzE3PGrYlR9LqFwODcmHRdfgQUor77Zoa0/awWzo0vtUGMg
	 IDS3FbwshQ6Od2gkQ9gTIF6VY9tJb9zMezkRZ37QMi2kQaGrxbRdpxNgz9s+a1qPO3
	 Wl7vilTckK7Lwo4d0xjODzJLpQdoBUr/WFrVA7yMvoG3EMLRGf7FcLBTyNbhAX2ltn
	 St/CzXR4950gRh+iXeHmQ5s4Guyahqf5r+Rxacd42SeHy8dK+W539x293sf9yY9V0X
	 jeHyNEPkuS1B2VgWyOHkww/jkPUegHYd+LBc5GV77RqZMlzeEBKa9W4inktvMHQAWA
	 uhRPOxywt63Cg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Chen Yu <yu.c.chen@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>
Subject:
 [PATCH v1 1/2] cpufreq: intel_pstate: Simplify HWP handling on Broadwell
Date: Tue, 23 Jun 2026 19:34:40 +0200
Message-ID: <3057514.e9J7NaK4W3@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <6286434.lOV4Wx5bFT@rafael.j.wysocki>
References: <6286434.lOV4Wx5bFT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

After commit de5bcf404ace ("cpufreq: intel_pstate: Clean up
frequency computations"), the Broadwell HWP mode does not actually
do anything useful because intel_pstate_get_hwp_cap() is called in
intel_pstate_verify_cpu_policy() without checking the Broadwell mode
and it overrides the initial turbo and max pstate values read from
MSR_PLATFORM_INFO (the minimum P-state value still comes from
MSR_PLATFORM_INFO if HWP is used even without the Broadwell mode).

Moreover, hwp_cap_cached is used in some places for updating
MSR_HWP_REQUEST without checking the Broadwell mode either.

Effectively, the only difference made by the Broadwell HWP mode is
skipping the hybrid initialization which may as well be achieved
by avoiding to set pstate_funcs.get_cpu_scaling on Broadwell.

Link: https://sashiko.dev/#/patchset/6005456.DvuYhMxLoT%40rafael.j.wysocki
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Applies on top of Linux 7.1.

---
 drivers/cpufreq/intel_pstate.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 1f093e346430..1cebd44a5f12 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -299,7 +299,6 @@ struct pstate_funcs {
 static struct pstate_funcs pstate_funcs __read_mostly;
 
 static bool hwp_active __ro_after_init;
-static int hwp_mode_bdw __ro_after_init;
 static bool per_cpu_limits __ro_after_init;
 static bool hwp_forced __ro_after_init;
 static bool hwp_boost __read_mostly;
@@ -2323,7 +2322,7 @@ static void intel_pstate_get_cpu_pstates(struct cpudata *cpu)
 	cpu->pstate.min_pstate = pstate_funcs.get_min(cpu->cpu);
 	cpu->pstate.perf_ctl_scaling = perf_ctl_scaling;
 
-	if (hwp_active && !hwp_mode_bdw) {
+	if (hwp_active) {
 		__intel_pstate_get_hwp_cap(cpu);
 
 		if (pstate_funcs.get_cpu_scaling) {
@@ -3807,7 +3806,6 @@ static int __init intel_pstate_init(void)
 
 		if (!no_hwp) {
 			hwp_active = true;
-			hwp_mode_bdw = id->driver_data;
 			intel_pstate.attr = hwp_cpufreq_attrs;
 			intel_cpufreq.attr = hwp_cpufreq_attrs;
 			intel_cpufreq.flags |= CPUFREQ_NEED_UPDATE_LIMITS;
@@ -3815,7 +3813,8 @@ static int __init intel_pstate_init(void)
 			if (!default_driver)
 				default_driver = &intel_pstate;
 
-			pstate_funcs.get_cpu_scaling = hwp_get_cpu_scaling;
+			if (!id->driver_data)
+				pstate_funcs.get_cpu_scaling = hwp_get_cpu_scaling;
 
 			goto hwp_cpu_matched;
 		}
-- 
2.51.0




