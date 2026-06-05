Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE7541362D;
	Fri,  5 Jun 2026 10:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780655518; cv=none; b=pJ0J9x8DJRQa6LPRZPV01JAy+aJS4gmW98zvS/RZNcZtWPKcaz3P4DXbkcLbtD9Pasbr5C/RxjGVtsciSuvdOcWU6Gcs0g1cx1rA7H3r3zIf9iW6Ig0qydKPWUNHeVkaeLxkNSApZ3ydv7YqzbpDRvWCqmXBYtHQe+FJ8p7EnjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780655518; c=relaxed/simple;
	bh=2MyZ0clnYFR9GCrg62eX6NeTiC2Md9CrGs/71+aZcTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fbL0AnSuwk3uAkkFNEZOXEqnccJGs6+tN8uoJn2sZ7X9/+JQBeC1rWV5Sj0o/UxUIm+N3KVUWc6vsLRKyyVOnY3Qv1aBzFvUrM3pFxgmuAelkxPM+EFKBas/YKSY23erkqy2U1urJT7dwBcPQOeglUn7g7BibZaaOY6GKdRXqNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=FfWyntSP; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="FfWyntSP"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 5E1272767F;
	Fri,  5 Jun 2026 12:31:46 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9-h2MRNGLucR; Fri,  5 Jun 2026 12:31:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1780655505; bh=2MyZ0clnYFR9GCrg62eX6NeTiC2Md9CrGs/71+aZcTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FfWyntSPj55S4bE+SnIyg7KsRaL7MPVLOCYZSdGcKEAgSK53ceGLsuIM0Tku/0L0R
	 qDtXPKClBal+kNlHsnfiUSVzUYzrjWZNR3uERWENieSEolLzHcMFadXI/phN+fbupl
	 2nIS88MP2J5tstj2RP3BwBckHJ4ROfGsDRrxsmPLiHkxGC7P5MSOUX0iEvBDM0Pkta
	 ONrFX1UMlBMIcEL2/lc5Z1zVynTDNaH82+uBRjL2poMs60oZZTKrK8V4kQUe754wVA
	 eJfR3sKxt6Qiy8iZ8/R3uA+91nw8YhNc4/vheYO5HWZJbirwWz1JzIwJLpZMVbdmJ/
	 XIybGnUuVq4xA==
From: Marco Scardovi <scardracs@disroot.org>
To: Mario Limonciello <mario.limonciello@amd.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	perry.yuan@amd.com,
	rafael@kernel.org,
	ray.huang@amd.com,
	stuartmeckle@gmail.com,
	viresh.kumar@linaro.org,
	wyes.karny@amd.com
Subject: [PATCH v3 1/1] cpufreq/amd-pstate: Fix EPP initialization for shared memory systems
Date: Fri,  5 Jun 2026 12:26:26 +0200
Message-ID: <20260605103131.88711-2-scardracs@disroot.org>
In-Reply-To: <20260605103131.88711-1-scardracs@disroot.org>
References: <20260605103131.88711-1-scardracs@disroot.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

At CPU initialization, the private cpudata structure is allocated via
kzalloc, which means cpudata->cppc_req_cached is initialized to 0. This
makes the default cached EPP value 0 (AMD_CPPC_EPP_PERFORMANCE).

When initializing a system that defaults to performance EPP, the driver
attempts to configure the EPP via amd_pstate_set_epp(). Because the
requested EPP (0) matches the uninitialized cached value (0), the cache
guard check triggers, and the driver skips writing to the hardware.

On shared memory systems, the EPP write via cppc_set_epp_perf() is also
responsible for toggling on the autonomous selection register (auto_sel).
Skipping the EPP write consequently skips enabling auto_sel, leaving the
CPU in non-autonomous mode. This prevents the hardware from boosting and
leaves the CPU frequency stuck at the lowest non-linear frequency (1.7GHz).

Fix this by:
1. Cache the firmware programmed default EPP value in cppc_req_cached
   during CPU EPP initialization.
2. Explicitly toggle the AUTO_SEL_ENABLE register to 1 during EPP CPU
   initialization for shared memory systems, independent of whether the EPP
   write is skipped due to a cache match.

Fixes: ffa5096a7c33 ("cpufreq: amd-pstate: implement Pstate EPP support for the AMD processors")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=221473
Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
Suggested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Marco Scardovi <scardracs@disroot.org>
---
 drivers/cpufreq/amd-pstate.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 8d55e2be825b..8e0099eba512 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1877,6 +1877,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 	struct amd_cpudata *cpudata;
 	union perf_cached perf;
 	struct device *dev;
+	s16 default_epp;
 	int ret;
 
 	/*
@@ -1926,6 +1927,27 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 
 	policy->boost_supported = READ_ONCE(cpudata->boost_supported);
 
+	/* Cache the firmware programmed EPP */
+	default_epp = amd_pstate_get_epp(cpudata);
+	if (default_epp < 0) {
+		ret = default_epp;
+		goto free_cpudata1;
+	}
+	FIELD_MODIFY(AMD_CPPC_EPP_PERF_MASK, &cpudata->cppc_req_cached, default_epp);
+
+	/*
+	 * Shared memory based systems may require the AUTO_SEL_ENABLE register
+	 * to be toggled on to function correctly. Since the first call to
+	 * amd_pstate_set_epp() may bail out early if the desired EPP is
+	 * same as the one configured by the firmware, attempt to toggle the
+	 * AUTO_SEL_ENABLE here, independent of EPP programming.
+	 */
+	if (!cpu_feature_enabled(X86_FEATURE_CPPC)) {
+		ret = cppc_set_auto_sel(policy->cpu, 1);
+		if (ret)
+			pr_warn("failed to enable auto_sel for cpu %d: %d\n", policy->cpu, ret);
+	}
+
 	/*
 	 * Set the policy to provide a valid fallback value in case
 	 * the default cpufreq governor is neither powersave nor performance.
@@ -1933,7 +1955,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 	if (amd_pstate_acpi_pm_profile_server() ||
 	    amd_pstate_acpi_pm_profile_undefined()) {
 		policy->policy = CPUFREQ_POLICY_PERFORMANCE;
-		cpudata->epp_default_ac = cpudata->epp_default_dc = amd_pstate_get_epp(cpudata);
+		cpudata->epp_default_ac = cpudata->epp_default_dc = default_epp;
 		cpudata->current_profile = PLATFORM_PROFILE_PERFORMANCE;
 	} else {
 		policy->policy = CPUFREQ_POLICY_POWERSAVE;
-- 
2.54.0

