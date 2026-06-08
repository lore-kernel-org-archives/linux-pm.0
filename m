Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD7D282F02;
	Mon,  8 Jun 2026 07:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780904203; cv=none; b=lEFX9+3T/lSb0Lq6UK5vyakJr7XghBgfXIcZWWhpbMfB6VVqD339n8DXn1/8ucFK7XO09/sMvwzYRWCWtYs5Mo89yyiHr382no67PXHQTjv5dnU8mnNBtO1vj0WsdPcQXlSBG6zy5jo4TztnsDAJQ5BbhbFsW3flDn6dVkkX5gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780904203; c=relaxed/simple;
	bh=qs/5O9k00C/iDn81REg1rQH/ynCYx5bssNKl4VPA10c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MQEi4vovv+knAuoHQpn2rp5fzl80yW/6CCy7Tpo9zz8c1GWlj5kviFsZ4SNPr+ODfITKBqOYJ/JxV+QvpQZ6VEDOVhRBJXntFQipnImtfJD7LVLB2MVICJoPhSIbfesTltBp6+9Lhe1g7sPafuZMB46QAtI3qf1wnKSHwIYJ37o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=Mt3NUDes; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="Mt3NUDes"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 7601927888;
	Mon,  8 Jun 2026 09:36:40 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 88qnt85QJ2N7; Mon,  8 Jun 2026 09:36:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1780904199; bh=qs/5O9k00C/iDn81REg1rQH/ynCYx5bssNKl4VPA10c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Mt3NUDesO0xeyONvZ8iKK65LeVyL5/IWbhONaFxDenpnQUVSNI2MS2haptkj40+BQ
	 hXmL9tc9FcKlev79qK054S3pEf2HOP4rfaEwlhe4/I7wy65bxXpP1on25xg/perZpm
	 SkFwwrWQdK0348H3LzaHlgvNZdZgzxDB1QmzXNFsrjyqKypNu6U8uPD1Ikk/jrI3TR
	 WYDXgEVOt2fRKldQgga95XmMpNuL9g8dKh4qmPh1FQlYzDdIdCXVYJFo04+hEbhLwG
	 T8SAhClBJ5jGm0bETDsyRD1HgIerBlJ9HgraJ9jZ0vyBYglqtcac+qvlIKpyhSp8/o
	 VKhJ3TRNMMqAQ==
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
Subject: [PATCH v5 3/3] cpufreq/amd-pstate: Cache the firmware programmed EPP value
Date: Mon,  8 Jun 2026 09:31:03 +0200
Message-ID: <20260608073614.5738-4-scardracs@disroot.org>
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

At CPU EPP initialization, the private cpudata structure is allocated via
kzalloc, which means cpudata->cppc_req_cached is initialized to 0. This
makes the default cached EPP value 0 (AMD_CPPC_EPP_PERFORMANCE).

When initializing a system that defaults to performance EPP, the driver
attempts to configure the EPP via amd_pstate_set_epp(). Because the
requested EPP (0) matches the uninitialized cached value (0), the cache
guard check triggers, and the driver skips writing to the hardware.

On shared memory systems, skipping the EPP write consequently skips
enabling auto_sel, leaving the CPU in non-autonomous mode.

Cache the firmware-programmed default EPP value in cppc_req_cached during
CPU EPP initialization. This saves on an unnecessary reprogramming later
when the EPP is first set.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Marco Scardovi <scardracs@disroot.org>
---
 drivers/cpufreq/amd-pstate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 7982f9d0f634..d1ed53a0f119 100644
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

