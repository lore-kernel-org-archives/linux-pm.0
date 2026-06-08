Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77731391E55;
	Mon,  8 Jun 2026 07:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780904202; cv=none; b=kp90kXeRNUPaXaHIARsykt2mECQ7hkrKTZvIBVB/h6sblEp+oV4QN1K5vjYOJcU2v9AH/PqgzEwJQLri0D3rddHpbWwKMmFoaxdMo0fbq50rys0blXJO9ngkBH/JzhvdNSeWr9BKBiFUgcGaHBCrQl4z1baSEGYpTKs2lm6WBbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780904202; c=relaxed/simple;
	bh=mWUT3Tkb9GS4qGr2pSBOwD/Xn4wBDULKAkhmq5qlbjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ESSPjhYvEbTN+TPPIKHA8FRWBc47IGqOQr/4CNeIYSVvGZAcx62+UnO07rHfyhX7SNNTYp7Wwtu+EKzgukeBBEPXzeiPCbXvt/4bu4VlQz6OVF3+HS0vMc/FYBO/a/Q68CVzzAEXjLLQ5Vv2aNEoeAtolr42BO/QSTfr403aHUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=bWZCDfz7; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="bWZCDfz7"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 4661E2789B;
	Mon,  8 Jun 2026 09:36:39 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aLkbLRrQOV8y; Mon,  8 Jun 2026 09:36:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1780904198; bh=mWUT3Tkb9GS4qGr2pSBOwD/Xn4wBDULKAkhmq5qlbjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bWZCDfz7HwpJYFeStGGxDf7Z7kydzM6b2IafylyR4+/6r9pqQk+3I3sFd+1faKpiP
	 hFeNi8gLlVnZhCBcSeF9eurCGCzoAD+I8hUUox6t75q5nhh7v+GSbXL1ApMqB05JTk
	 9Br58CjGbybVcFWRGBcKPYLMI9r7Kz293AeoHoeTQVcH0G13lywurqjdWG1SEPq+yQ
	 4jK31nBPMR7VFcJrV8pDuT/KaRBO9nFyMdcHWpGj2+Y7rT2cFphOyKCRS9dW1BbfY6
	 PNrEFYVFINOC7zR7MJv8SaxvCrqNHO7h/A+tYZ8lskm+fbUsCWM1Y7FMnszN9kRevM
	 jowyk/EiSgLyg==
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
Subject: [PATCH v5 1/3] cpufreq/amd-pstate: Fix EPP return type and handle errors during initialization
Date: Mon,  8 Jun 2026 09:31:01 +0200
Message-ID: <20260608073614.5738-2-scardracs@disroot.org>
In-Reply-To: <20260608073614.5738-1-scardracs@disroot.org>
References: <c97c81f1-1254-44fe-80b2-89f82fec73f6@amd.com>
 <20260608073614.5738-1-scardracs@disroot.org>
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
Signed-off-by: Marco Scardovi <scardracs@disroot.org>
---
 drivers/cpufreq/amd-pstate.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 8d55e2be825b..77261c31d81d 100644
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

