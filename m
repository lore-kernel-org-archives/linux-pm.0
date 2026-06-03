Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB1746AF35;
	Wed,  3 Jun 2026 12:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780488100; cv=none; b=b1HeTC5Kvycco4L2YjnQVuCCl1KyTC2Va5s41S7HYwMXYvckfWf3Q7llSD3phf/zKim2/L+ObeQxhjxAyrF+jHjKVmu64dnacmX0MKJNMM2wIOecd9m+GhGicL9TDW2PNp4Au0cnvI15jT8nmCE/TQsbuGMZmDw0/Qc5TcP5c+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780488100; c=relaxed/simple;
	bh=w53jTP55JGMEWudVbVJWcnW1SsDQrplJAM711/mWEP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qBlrGRc3hy6eBwl8S11v+N6px3oANNaoibZz815jdTboyyGOiS5t4VgT+H+W/NeMUoVpmCuJBAeolmXkri4BcTds+9NxR2en4rldBa0mFd10GAkC4zjDoU9dJ9NQU5u50zBTpwdp382QbLuyZ1smlCqDPZmfqxbV2qXletTpuVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=g1c+1HSY; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="g1c+1HSY"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 4F39E27210;
	Wed,  3 Jun 2026 14:01:36 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hT91COlUxbpg; Wed,  3 Jun 2026 14:01:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1780488095; bh=w53jTP55JGMEWudVbVJWcnW1SsDQrplJAM711/mWEP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g1c+1HSYKJ5wWqmC7aorW63EKblqgMd00f2wBiD2BinEDb7uSSwscfNHuaqfN9pWj
	 TmZPGKteBuxBC9EFNbRXiQrUTPxthX9CYBK8Rv1Oy6EcsuRDQzmThO7wAQ84Dyg0QR
	 IhgJGnh3Y6pC/CISPNJ2Bmn8Oc/XXE6dX0TNkm4DTcfl2pGH9l6v7GG0PV3bqIUXlM
	 krDNHN6T8BGkg6fGN38UZJ7luWFUWocR66+nC4jFp6sYuuYFW1nzuzUduAiM+YmO3m
	 Drx97NhBZ35FitD8T3YViC3zgXVk3xetleTuX/RVQdnJPF33NcsiyNBb2CJr2qljr3
	 jH8PPCjdq69kA==
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
	viresh.kumar@linaro.org,
	wyes.karny@amd.com
Subject: [PATCH v2 1/2] cpufreq/amd-pstate: Fix EPP initialization for shared memory systems
Date: Wed,  3 Jun 2026 13:56:34 +0200
Message-ID: <20260603120121.25772-2-scardracs@disroot.org>
In-Reply-To: <20260603120121.25772-1-scardracs@disroot.org>
References: <4cb9459c-f471-478a-9670-58d898619f45@amd.com>
 <20260603120121.25772-1-scardracs@disroot.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

At CPU boot/initialization, the private cpudata structure is allocated
via kzalloc, which means cpudata->cppc_req_cached is initialized to 0.
This makes the default cached EPP value 0 (AMD_CPPC_EPP_PERFORMANCE).

When initializing a system that defaults to performance EPP, the driver
attempts to configure the EPP via shmem_set_epp(policy, 0). Because the
requested EPP (0) matches the uninitialized cached value (0), the early
return check (epp == epp_cached) triggers, and the driver skips writing
to the hardware.

The cppc_set_epp_perf() helper is responsible for writing both the EPP
register and the CPPC autonomous mode enable register (auto_sel). Skipping
the EPP write on initialization due to the false cache hit consequently
skips setting auto_sel to 1, leaving the CPU in non-autonomous mode. This
prevents the hardware from boosting and leaves the CPU frequency stuck at
the lowest non-linear frequency (1.7GHz).

Fix this by introducing an `epp_hw_programmed` flag in struct amd_cpudata
to track whether EPP has been configured on the hardware. Bypass the early
return check in shmem_set_epp() if EPP has not yet been programmed on the
hardware. Once EPP has been successfully programmed once, the cached EPP
value becomes authoritative (representing driver intent rather than dynamic
firmware state), allowing subsequent runtime mode transitions to use the
cache guard optimization safely.

Fixes: ffa5096a7c33 ("cpufreq: amd-pstate: implement Pstate EPP support for the AMD processors")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=221473
Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Marco Scardovi <scardracs@disroot.org>
---
 drivers/cpufreq/amd-pstate.c | 9 ++++++++-
 drivers/cpufreq/amd-pstate.h | 2 ++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 8d55e2be825b..e8057f3dfb1e 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -424,7 +424,13 @@ static int shmem_set_epp(struct cpufreq_policy *policy, u8 epp)
 					  epp != epp_cached);
 	}
 
-	if (epp == epp_cached)
+	/*
+	 * After the first successful programming, the cached EPP value
+	 * becomes authoritative (representing driver intent rather than
+	 * dynamic firmware state), allowing us to skip redundant hardware
+	 * writes when the EPP value is unchanged.
+	 */
+	if (cpudata->epp_hw_programmed && epp == epp_cached)
 		return 0;
 
 	perf_ctrls.energy_perf = epp;
@@ -434,6 +440,7 @@ static int shmem_set_epp(struct cpufreq_policy *policy, u8 epp)
 		return ret;
 	}
 
+	cpudata->epp_hw_programmed = true;
 	value = READ_ONCE(cpudata->cppc_req_cached);
 	FIELD_MODIFY(AMD_CPPC_EPP_PERF_MASK, &value, epp);
 	WRITE_ONCE(cpudata->cppc_req_cached, value);
diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
index e4722e54387b..fc6cd4b873f6 100644
--- a/drivers/cpufreq/amd-pstate.h
+++ b/drivers/cpufreq/amd-pstate.h
@@ -128,6 +128,8 @@ struct amd_cpudata {
 	u8	epp_default_dc;
 	bool	dynamic_epp;
 	bool	raw_epp;
+	/* Indicates that EPP has been successfully programmed at least once since boot. */
+	bool	epp_hw_programmed;
 	struct notifier_block power_nb;
 
 	/* platform profile */
-- 
2.54.0

