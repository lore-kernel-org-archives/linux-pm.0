Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8009536F91E;
	Tue,  9 Jun 2026 07:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780990260; cv=none; b=IxFs9rubHogcpbZfWhTUZ8XNMSHDBT/JkTvx6frPfLodRY2FWfnBCEkWmjSdES3f9AVqWOy6vhCLc9lLtEAARUXdiBARGUW0PGZsW5A7h76REE5sB7JHo8l5QQOwpMx9pgH1qAdhM4iQDAPJTA02sgX6hdHEo/hbJ+eXavwpwRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780990260; c=relaxed/simple;
	bh=E7LiMG/Pc3uFrYERBVUR/1VlqoEYran2huy5abxrG+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pbzVMk+t4BjPG8BexUK0Ae6jImiBw9ul44V3U25Ujawa91h1rt4gLaK2cIdJ27cTeUVRURS4EtOezxmg0usM9jiK8ues0/yR6sYZT8AoH0NdT00AeboQmd9tqUsXX61XNCUkJFPfZES/ELZmgLCgB2/RYOOFnBaQB8WhaNdtdTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=JHRVovlK; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="JHRVovlK"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 307B326DFC;
	Tue,  9 Jun 2026 09:30:58 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VW55KReyW-rn; Tue,  9 Jun 2026 09:30:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1780990257; bh=E7LiMG/Pc3uFrYERBVUR/1VlqoEYran2huy5abxrG+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JHRVovlKldJQjPtyPb87FVdbSf4yMQjKF3yIruAQedY6C8iKkeeNEYacyPc60FG5g
	 31xcGnDHUNmS+XYuZUQxEJYdTL6gWvc3QRU6WKY9elDt+pT2ZTAQtg2zKM8w4ZaC9o
	 /XkqRlJ8uQq3d2QiMGTpuatcKt28K5JE4cm3pOCCoCOvz+qTTLw/WHZmjHy35I03BU
	 EDjds6asHdCcKyy/P670nekP8dQqOSe5vxaIAhTISO55AEIDQNKsq+nRuYSzJMv7PZ
	 P3lTEoTILYKT5vpvHNBFUA4rrY20rB3izx4/ubwtXZCGFMabrXxbAhQYt0kiZ4Up8t
	 QvhNCBwsW4Zag==
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
Subject: [PATCH v6 2/3] cpufreq/amd-pstate: Toggle auto_sel in active mode on shared memory systems
Date: Tue,  9 Jun 2026 09:29:04 +0200
Message-ID: <20260609073042.81275-3-scardracs@disroot.org>
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
Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Marco Scardovi <scardracs@disroot.org>
---
 drivers/cpufreq/amd-pstate.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index a04ff2bad4dd..c67e02f77059 100644
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

