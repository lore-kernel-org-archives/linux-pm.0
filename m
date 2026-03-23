Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B5618B0F;
	Mon, 23 Mar 2026 04:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774240378; cv=none; b=dNsMT9sMYTVVWUz37R3GlK+UYm6uGHUWjtf35PNi3s48NnKtO1uHej9x+7ZXLXiYmPpRMiktBryTBvRkiGYIt1eC0HZ+zBwVSkrhWWZrpBpr+Gb//NeoG4G1kk0DAJZXkvb4UTiVQs/AZEuD6cuujR5XMeERpVeesjSHoli3MkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774240378; c=relaxed/simple;
	bh=yOBf0+jLCY+FWkZa27CHigJeAVHuT4ARZrfGzNsMBCo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z6hN+rbnC8avniSFOabOGKzkGuJeX675kM4+Oytdjw+PLoUveCgDmXCyIx80aECaeBu85hrij1EV2P9sT0OhzEbLApi7K8fIcdLLNo0KVbNjojlrNof3CgoGf4xnFKlHG0g3ZUwB5ftJCr0XNwA8tUjDIuibAurI/rlR3Co0Clg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VfvdOw1b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VfvdOw1b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD1F3C4CEF7;
	Mon, 23 Mar 2026 04:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774240378;
	bh=yOBf0+jLCY+FWkZa27CHigJeAVHuT4ARZrfGzNsMBCo=;
	h=From:To:Cc:Subject:Date:From;
	b=VfvdOw1b/svWWeaRCARftSgmLlpyLZ2fsXuoBLKJID8EuDFpRgSFuhueX67taAZix
	 QbO7PTDvsXxKRG2oDcWS2DzYTGoQpq8hKNXicA63+PbgG5QHG0R/gSd/4LM7JDJlu/
	 a3rye2PbcY2UYsiGPS4ExXpMx08aeuoRm6U6j3nB63R5jMU01DytB7IMnCN4YbAd+s
	 GFKuvF8mnAA+xn+wB6kFp6TBrePjFvuAsM2iFCjm7dKE+5pTR4S2au7SG3Ka5haOlL
	 L8vfWWsqDOBDzotVOpxEzp/SaP/4ZJruql1AjQwTOYgh24xFriG9TPDld0mLya30sK
	 R2ThkxW1EQC7w==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	"Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH v2] cpufreq/amd-pstate: Cache the max frequency in cpudata
Date: Sun, 22 Mar 2026 23:32:53 -0500
Message-ID: <20260323043253.722730-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The value of maximum frequency is fixed and never changes. Doing
calculations every time based off of perf is unnecessary.

Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
v2:
 * Remove unused variable
---
 drivers/cpufreq/amd-pstate.c | 27 +++++++++------------------
 drivers/cpufreq/amd-pstate.h |  1 +
 2 files changed, 10 insertions(+), 18 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 5aa9fcd80cf51..9f80f8b23a43f 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -757,15 +757,13 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
 static int amd_pstate_cpu_boost_update(struct cpufreq_policy *policy, bool on)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
-	union perf_cached perf = READ_ONCE(cpudata->perf);
-	u32 nominal_freq, max_freq;
+	u32 nominal_freq;
 	int ret = 0;
 
 	nominal_freq = READ_ONCE(cpudata->nominal_freq);
-	max_freq = perf_to_freq(perf, cpudata->nominal_freq, perf.highest_perf);
 
 	if (on)
-		policy->cpuinfo.max_freq = max_freq;
+		policy->cpuinfo.max_freq = cpudata->max_freq;
 	else if (policy->cpuinfo.max_freq > nominal_freq)
 		policy->cpuinfo.max_freq = nominal_freq;
 
@@ -952,13 +950,15 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
 
 	WRITE_ONCE(cpudata->nominal_freq, nominal_freq);
 
+	/* max_freq is calculated according to (nominal_freq * highest_perf)/nominal_perf */
 	max_freq = perf_to_freq(perf, nominal_freq, perf.highest_perf);
+	WRITE_ONCE(cpudata->max_freq, max_freq);
+
 	lowest_nonlinear_freq = perf_to_freq(perf, nominal_freq, perf.lowest_nonlinear_perf);
 	WRITE_ONCE(cpudata->lowest_nonlinear_freq, lowest_nonlinear_freq);
 
 	/**
 	 * Below values need to be initialized correctly, otherwise driver will fail to load
-	 * max_freq is calculated according to (nominal_freq * highest_perf)/nominal_perf
 	 * lowest_nonlinear_freq is a value between [min_freq, nominal_freq]
 	 * Check _CPC in ACPI table objects if any values are incorrect
 	 */
@@ -1021,9 +1021,7 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 	policy->cpuinfo.min_freq = policy->min = perf_to_freq(perf,
 							      cpudata->nominal_freq,
 							      perf.lowest_perf);
-	policy->cpuinfo.max_freq = policy->max = perf_to_freq(perf,
-							      cpudata->nominal_freq,
-							      perf.highest_perf);
+	policy->cpuinfo.max_freq = policy->max = cpudata->max_freq;
 
 	ret = amd_pstate_cppc_enable(policy);
 	if (ret)
@@ -1090,14 +1088,9 @@ static void amd_pstate_cpu_exit(struct cpufreq_policy *policy)
 static ssize_t show_amd_pstate_max_freq(struct cpufreq_policy *policy,
 					char *buf)
 {
-	struct amd_cpudata *cpudata;
-	union perf_cached perf;
-
-	cpudata = policy->driver_data;
-	perf = READ_ONCE(cpudata->perf);
+	struct amd_cpudata *cpudata = policy->driver_data;
 
-	return sysfs_emit(buf, "%u\n",
-			  perf_to_freq(perf, cpudata->nominal_freq, perf.highest_perf));
+	return sysfs_emit(buf, "%u\n", cpudata->max_freq);
 }
 
 static ssize_t show_amd_pstate_lowest_nonlinear_freq(struct cpufreq_policy *policy,
@@ -1503,9 +1496,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 	policy->cpuinfo.min_freq = policy->min = perf_to_freq(perf,
 							      cpudata->nominal_freq,
 							      perf.lowest_perf);
-	policy->cpuinfo.max_freq = policy->max = perf_to_freq(perf,
-							      cpudata->nominal_freq,
-							      perf.highest_perf);
+	policy->cpuinfo.max_freq = policy->max = cpudata->max_freq;
 	policy->driver_data = cpudata;
 
 	ret = amd_pstate_cppc_enable(policy);
diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
index cb45fdca27a6c..485ee023d79c5 100644
--- a/drivers/cpufreq/amd-pstate.h
+++ b/drivers/cpufreq/amd-pstate.h
@@ -94,6 +94,7 @@ struct amd_cpudata {
 	u32	min_limit_freq;
 	u32	max_limit_freq;
 	u32	nominal_freq;
+	u32	max_freq;
 	u32	lowest_nonlinear_freq;
 
 	struct amd_aperf_mperf cur;
-- 
2.43.0

