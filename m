Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F110313E17;
	Mon,  8 Jun 2026 07:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780904202; cv=none; b=XLkmys9dX9ZIpHeSXXvuYaHA74rKAyXEEm1YqiTL1dc2O+m5J072+ilm7+kRJP7myCDhSbnco369YWsXIxFVAijtTJw+OjV2J7spnqef0NTJ6cmu4WK3vg5FUEdbTuSmuHTk57r2RMjVZIlpxpk5yj/t3EiLfJofgTtRVW1fTiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780904202; c=relaxed/simple;
	bh=p+OrK9sx1+4AWgG3RYXyCdHWEi63PRtHAe1UELh5UkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=unc+XcB3QjJHGDPp7JBmFKw7WZS+coTAWmn1vBNgS0ucFNSVQpxmFwAUb+fVUiGtJT3K6wZQkigWXaAJ1IiA3EFVSwMasi38+2P9kAkhIlpbEt+CTTvXtMhq2MqFjPH9u8LEYskBpDhv7rY4Bayj6qqURLrPXMdzuyexldL1fXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=VO3bmdJ2; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="VO3bmdJ2"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id D59032789F;
	Mon,  8 Jun 2026 09:36:39 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v8iiC1AQIJAy; Mon,  8 Jun 2026 09:36:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1780904199; bh=p+OrK9sx1+4AWgG3RYXyCdHWEi63PRtHAe1UELh5UkI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VO3bmdJ2Y4QtW05tn9KMRyuyRI/Nh23taHrln9dm8884vtG3DboiEbL5+BUpOYTJh
	 fZLP67xr4qFCkzkzpgw2FKXMahzNrmNVumlbwOR3MlgXpcw5xSxl++BGsRWfCaLu32
	 +6nJwX8F1hl+aympgzgQjE9DZxYC4lCD9yoKPrb4570sw3wK6bSZ186sykBsM2GcC/
	 HoQ7SU8H1lssRinrxGrrIHc0FmbwflEy1o21heVPedbRPsk49NsGxwMqR1D6qYojRd
	 4wNPv2FHBUQsX2mXcWkm0tZBOHjpGAWlulWOxR9O05hUIRTm1dkCbKL3UmDnGTrocq
	 mky4NrO8uuqDg==
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
Subject: [PATCH v5 2/3] cpufreq/amd-pstate: Toggle auto_sel in active mode on shared memory systems
Date: Mon,  8 Jun 2026 09:31:02 +0200
Message-ID: <20260608073614.5738-3-scardracs@disroot.org>
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

On shared memory systems, the EPP configuration path (handled via
cppc_set_epp_perf()) is responsible for toggling on the CPPC autonomous
selection register (auto_sel).

Currently, shmem_init_perf() returns early without doing any of the auto_sel
configuration steps if cppc_state is AMD_PSTATE_ACTIVE. This skips enabling
auto_sel, leaving the CPU in non-autonomous mode.

Remove the early return check in shmem_init_perf() when cppc_state is
AMD_PSTATE_ACTIVE. Toggling auto_sel is necessary for the active mode on
shared memory systems to function based on the ACPI spec for CPPC v2 and
below.

Fixes: 2dd6d0ebf740 ("cpufreq: amd-pstate: Add guided autonomous mode")
Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Marco Scardovi <scardracs@disroot.org>
---
 drivers/cpufreq/amd-pstate.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 77261c31d81d..7982f9d0f634 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -526,9 +526,6 @@ static int shmem_init_perf(struct amd_cpudata *cpudata)
 	WRITE_ONCE(cpudata->perf, perf);
 	WRITE_ONCE(cpudata->prefcore_ranking, cppc_perf.highest_perf);
 
-	if (cppc_state == AMD_PSTATE_ACTIVE)
-		return 0;
-
 	ret = cppc_get_auto_sel(cpudata->cpu, &auto_sel);
 	if (ret) {
 		pr_warn("failed to get auto_sel, ret: %d\n", ret);
-- 
2.54.0

