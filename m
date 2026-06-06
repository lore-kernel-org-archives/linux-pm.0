Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554EE30F52B;
	Sat,  6 Jun 2026 06:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780729094; cv=none; b=WneJRftmfV2euZg0CJrZMFqUhJ4tKIPzDtcLJyUV1+9kEGD8qJabLrxBHurnCO8HWVcAw0FANMVEghy97NLieIEGFU1IdjdO5K8685ZiFpvp0980VuH3WOYbq5JGrtqyyizFWPJYOdnMQeZJ1KBqJJdnOxkbatyGZiD1xM8bHwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780729094; c=relaxed/simple;
	bh=yO2ERBZbRyCm4s1Vznd9X17lL1boS7e0qk9oIqlq0Kw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RfPSlPN8YB0BTHw/4JAd9xCD/m/6ManXJ4grMW9hw4pymvBsB/37caTFHSlFJZ0aCKG5S2hsskYuVQ225ZoZv9SDHP95sfT2ylA8h16HwqfYQZ0t98XXzimwr8BYtq7xv0G3rBVc3M1w9uFfS9rCyGKNfgM0IPWIpGI8YxgPeyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=Dbpu4Wvq; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="Dbpu4Wvq"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id CF9E3276CF;
	Sat,  6 Jun 2026 08:58:10 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PEMxQ_UbWuvE; Sat,  6 Jun 2026 08:58:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1780729090; bh=yO2ERBZbRyCm4s1Vznd9X17lL1boS7e0qk9oIqlq0Kw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Dbpu4WvqmkugA6gx0IcnVd2ZskQXl5Mi42gWosF95fckD4EMRxSsrc9GziA+HV2QG
	 Q7EoBHYc+RlOufLJfx8g3ch5FxR5Adizle3ajacxsGQPYxSyDIJZ8LfEprfL1q2a9K
	 N41+uwMccI8qB1Um3w7n8uNCcfUHOEfOeQUWdjvlZGCH3tDjRdo+tMNQQkjSSov4LW
	 PMlHW1XlKIKZpT6urw35RZ8TUFMsmwct551fx5mxmRgZOB5so/8c6tD/T8d0DdsIK3
	 4oPW20fx1KMKSBzn9n5PzNy36xpJKRc9EyrL6pyq+ArzNGw15pGcfMOWJ6O5u9GKAU
	 tEanp3BlcDNYQ==
From: Marco Scardovi <scardracs@disroot.org>
To: scardracs@disroot.org
Cc: kprateek.nayak@amd.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	mario.limonciello@amd.com,
	perry.yuan@amd.com,
	rafael@kernel.org,
	ray.huang@amd.com,
	stuartmeckle@gmail.com,
	viresh.kumar@linaro.org,
	wyes.karny@amd.com
Subject: [PATCH v4 1/1] cpufreq/amd-pstate: Fix EPP initialization for shared memory systems
Date: Sat,  6 Jun 2026 08:57:15 +0200
Message-ID: <20260606065756.4442-2-scardracs@disroot.org>
In-Reply-To: <20260606065756.4442-1-scardracs@disroot.org>
References: <20260605103131.88711-1-scardracs@disroot.org>
 <20260606065756.4442-1-scardracs@disroot.org>
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
1. Caching the firmware programmed default EPP value in cppc_req_cached
   during CPU EPP initialization.
2. Propagating negative error codes from amd_pstate_get_epp() correctly
   while caching the firmware EPP value. Change msr_get_epp() and
   shmem_get_epp() to return signed int instead of u8. Also change
   amd_pstate_get_epp() return type and the local default_epp variable
   in amd_pstate_epp_cpu_init() to int.
3. Executing the remaining shared-memory initialization path even when
   booting in active mode, rather than bypassing it through an early
   return.

Fixes: ffa5096a7c33 ("cpufreq: amd-pstate: implement Pstate EPP support for the AMD processors")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=221473
Assisted-by: Antigravity:gemini-3.5-flash
Suggested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Marco Scardovi <scardracs@disroot.org>
---
 drivers/cpufreq/amd-pstate.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 8d55e2be825b..a35cf126e335 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -199,7 +199,7 @@ static inline int get_mode_idx_from_str(const char *str, size_t size)
 
 static DEFINE_MUTEX(amd_pstate_driver_lock);
 
-static u8 msr_get_epp(struct amd_cpudata *cpudata)
+static int msr_get_epp(struct amd_cpudata *cpudata)
 {
 	u64 value;
 	int ret;
@@ -215,12 +215,12 @@ static u8 msr_get_epp(struct amd_cpudata *cpudata)
 
 DEFINE_STATIC_CALL(amd_pstate_get_epp, msr_get_epp);
 
-static inline s16 amd_pstate_get_epp(struct amd_cpudata *cpudata)
+static inline int amd_pstate_get_epp(struct amd_cpudata *cpudata)
 {
 	return static_call(amd_pstate_get_epp)(cpudata);
 }
 
-static u8 shmem_get_epp(struct amd_cpudata *cpudata)
+static int shmem_get_epp(struct amd_cpudata *cpudata)
 {
 	u64 epp;
 	int ret;
@@ -525,10 +525,6 @@ static int shmem_init_perf(struct amd_cpudata *cpudata)
 	perf.lowest_perf = cppc_perf.lowest_perf;
 	WRITE_ONCE(cpudata->perf, perf);
 	WRITE_ONCE(cpudata->prefcore_ranking, cppc_perf.highest_perf);
-
-	if (cppc_state == AMD_PSTATE_ACTIVE)
-		return 0;
-
 	ret = cppc_get_auto_sel(cpudata->cpu, &auto_sel);
 	if (ret) {
 		pr_warn("failed to get auto_sel, ret: %d\n", ret);
@@ -1877,6 +1873,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 	struct amd_cpudata *cpudata;
 	union perf_cached perf;
 	struct device *dev;
+	int default_epp;
 	int ret;
 
 	/*
@@ -1926,6 +1923,14 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 
 	policy->boost_supported = READ_ONCE(cpudata->boost_supported);
 
+	/* Cache the firmware programmed EPP */
+	default_epp = amd_pstate_get_epp(cpudata);
+	if (default_epp < 0) {
+		ret = default_epp;
+		goto free_cpudata1;
+	}
+	FIELD_MODIFY(AMD_CPPC_EPP_PERF_MASK, &cpudata->cppc_req_cached, default_epp);
+
 	/*
 	 * Set the policy to provide a valid fallback value in case
 	 * the default cpufreq governor is neither powersave nor performance.
@@ -1933,7 +1938,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
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

