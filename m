Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318773DBD7C;
	Tue,  9 Jun 2026 07:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780990261; cv=none; b=K3aq+y95MFpsmd8iGk/GOh1iOFKzYK07mntwL9lOKF6buj790Uk4JtLFfoHvBS9oYMPxyQymkE0FEtBQVRsQnBMSShjsiVtXq/7QNCtD3JcAncR2czGon/FrXBeq6+3Usc5nCL5Hv3Juz9nPClduMX59Kdc5DjHLajWuA5IPk/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780990261; c=relaxed/simple;
	bh=wz2ThGY7KI5YQ2+7Lf8IEjXwwOE9OQNCV1H8OR1+9Q0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H0Gnnws5gV4LTHc3WJsUMjLGPeU4vMGhbOE8B9L5h/TiBH7X17ANhx6bOxu88MjHzh/qay4j4M7Aq/ln8zmd7o22hc4lPYBd1PQFRVLELPCC1f0gSfGUaqIKV3cZZpt4GYWInfNWwk8+YYu2zV2oT73z8VBn3zUr+MBp+2L0oTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=FYQ4cJ78; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="FYQ4cJ78"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id D309B266AF;
	Tue,  9 Jun 2026 09:30:58 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lDR6n4qvJW_u; Tue,  9 Jun 2026 09:30:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1780990258; bh=wz2ThGY7KI5YQ2+7Lf8IEjXwwOE9OQNCV1H8OR1+9Q0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FYQ4cJ78OeDyY7fBQQQTbVWRubQMvim4fnq26RSNyQMyN1dMKA4KrVwR6rxHaviG6
	 Ky1E0SCfGIGOgNhOumqd6UCJvnI2pKQD65KcY6jWsW4O2M3ZuN9M+Wjg5gVco5VkAK
	 b9jypD6mG7n6aQt3HnpYIvevvVGg79TyPg5SpIhhSjD/fUC+n9H6XOQf/uS+HI/8ww
	 shONefRePzgfJA/B7LMczQOOZm8kj8lf3wIFDpDz34XgXwM16qaoy1Vg7VesHW2S+Y
	 miVtGzlurLOgRAS/5fvyivO+cWMtweZDnftvL3D3DaFznBOQAGS+OcyGvv8/LEgN9D
	 WckJ7Nb9QGbSw==
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
Subject: [PATCH v6 3/3] cpufreq/amd-pstate: Cache the firmware programmed EPP value
Date: Tue,  9 Jun 2026 09:29:05 +0200
Message-ID: <20260609073042.81275-4-scardracs@disroot.org>
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

At CPU EPP initialization, the private cpudata structure is allocated via
kzalloc, which means cpudata->cppc_req_cached is initialized to 0. This
makes the default cached EPP value 0 (AMD_CPPC_EPP_PERFORMANCE).

When initializing a system that defaults to performance EPP, the driver
attempts to configure the EPP via amd_pstate_set_epp(). Because the
requested EPP (0) matches the uninitialized cached value (0), the cache
guard check triggers, and the driver skips writing to the hardware.

Cache the firmware-programmed default EPP value in cppc_req_cached during
CPU EPP initialization. This saves on an unnecessary reprogramming later
when the EPP is first set.

Assisted-by: Antigravity:gemini-3.5-flash
Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Marco Scardovi <scardracs@disroot.org>
---
 drivers/cpufreq/amd-pstate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index c67e02f77059..a30f6fff72a0 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1924,12 +1924,13 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 
 	policy->boost_supported = READ_ONCE(cpudata->boost_supported);
 
-	/* Fetch the firmware programmed default EPP value */
+	/* Cache the firmware programmed EPP */
 	default_epp = amd_pstate_get_epp(cpudata);
 	if (default_epp < 0) {
 		ret = default_epp;
 		goto free_cpudata1;
 	}
+	FIELD_MODIFY(AMD_CPPC_EPP_PERF_MASK, &cpudata->cppc_req_cached, default_epp);
 
 	/*
 	 * Set the policy to provide a valid fallback value in case
-- 
2.54.0

