Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33243DC84C;
	Tue,  9 Jun 2026 07:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780990260; cv=none; b=RtpSfHNYJYPc5zICSS3QxV26xGeDaLz1gecI2OmcZngO+ShrB3mk+kRJwCV/qMTlyHBnGBviTx6CuyY7r16HD/2HnIe1H9EhO3Qak+hUPiFgJP+4ZJBI4hGbhqmI9v8N1sdgMFTJCjyssODH05BtUl9O64QkAKCDKLKsiOKG/jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780990260; c=relaxed/simple;
	bh=eD0kavkikQe4WPocJY8Y+Oa53PQxH5QdU9oPtvoq9dI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jDg0m156pV5DDiM5HMDgG2+B4ba59tMIU7EcrTJFpZ9NLvXHHdoysICBYu0gHppOtj4z2esMWL8jV2poxjDpiK1sorsX8/wU8Iqn6UjttmQjuhmynSWrokdFC1Apa2mi9qkhJH83DjTKfTrrfVqDsnljki2L/WlaeWr4EL4Es2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=FO8iAatN; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="FO8iAatN"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 85F6D2765A;
	Tue,  9 Jun 2026 09:30:57 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YQ6NACkl1YL1; Tue,  9 Jun 2026 09:30:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1780990257; bh=eD0kavkikQe4WPocJY8Y+Oa53PQxH5QdU9oPtvoq9dI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FO8iAatNoZ8RBqvZHYZYtopcdJ2W+EIpLYejW/jzTBE4bf/nCmvN1066ANYqLEMvq
	 VyU5ghOrMi4wjCOXxkUYu2pl0h56QrdQvpP40A3jr2xIs5FP5NRUaUZqNDRHJyhHWh
	 g1Sb1atBdWe9rHxI3NaCpBClUE2MD531smOl2tlTMqLNI4+2ykqSDXZxVPV+NacKsp
	 EI+wMGYz8BzDlNxz4kRNlMtNWtKGCcxAYzsyvc57xiqySiAft4awNSt7Znr+JsBPaL
	 e8hUTgjcIhg7dLxasY0tsaCpUey6S1gXdWIDT8WM2NhdRvTdpIIqjQNYn4WBeKdVTV
	 myBqlhB/AD51Q==
From: Marco Scardovi <scardracs@disroot.org>
To: kprateek.nayak@amd.com
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	mario.limonciello@amd.com,
	perry.yuan@amd.com,
	rafael@kernel.org,
	ray.huang@amd.com,
	scardracs@disroot.org,
	stuartmeckle@gmail.com,
	viresh.kumar@linaro.org
Subject: [PATCH v6 1/3] cpufreq/amd-pstate: Fix EPP return type and handle errors during initialization
Date: Tue,  9 Jun 2026 09:29:03 +0200
Message-ID: <20260609073042.81275-2-scardracs@disroot.org>
In-Reply-To: <20260609073042.81275-1-scardracs@disroot.org>
References: <d8bc45af-d8bb-48fb-9f3e-5188c8d79c8e@amd.com>
 <20260609073042.81275-1-scardracs@disroot.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the EPP getter helper functions (msr_get_epp, shmem_get_epp, and
the static call wrapper amd_pstate_get_epp) return u8 or s16. This makes it
difficult to correctly propagate negative error values returned by the
underlying MSR read or CPPC helpers (such as rdmsrq_on_cpu or
cppc_get_epp_perf).

Modify the return type of these functions to int, allowing them to return
negative error codes properly.

Additionally, in amd_pstate_epp_cpu_init(), fetch the firmware-programmed
default EPP value and validate it before assigning it to the EPP variables.
If amd_pstate_get_epp() returns an error code, propagate the error and abort
the CPU initialization to prevent subsequent configuration failures.

Fixes: 555bbe67a622 ("cpufreq/amd-pstate: Convert all perf values to u8")
Assisted-by: Antigravity:gemini-3.5-flash
Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Marco Scardovi <scardracs@disroot.org>
---
 drivers/cpufreq/amd-pstate.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index afb040c04f38..a04ff2bad4dd 100644
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
@@ -1877,6 +1877,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 	struct amd_cpudata *cpudata;
 	union perf_cached perf;
 	struct device *dev;
+	int default_epp;
 	int ret;
 
 	/*
@@ -1926,6 +1927,13 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 
 	policy->boost_supported = READ_ONCE(cpudata->boost_supported);
 
+	/* Fetch the firmware programmed default EPP value */
+	default_epp = amd_pstate_get_epp(cpudata);
+	if (default_epp < 0) {
+		ret = default_epp;
+		goto free_cpudata1;
+	}
+
 	/*
 	 * Set the policy to provide a valid fallback value in case
 	 * the default cpufreq governor is neither powersave nor performance.
@@ -1933,7 +1941,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
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

