Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68FD351C1C
	for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 07:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779260544; cv=none; b=L0t4dPT1uqlNHMxF7I7WOQMUCTZuoFEHAIy0qwsG240cyTwogxoF7qRX2s4GKiveoVGUmdCI24Lfak3BcaavFYaZMiV4TLEmx7rLiomzEWNVSuvdb347oH7KOBufPzd8u1Sd7eSRhapyBJJxgGchSu9jl1BcqJQkvTnEjKImqMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779260544; c=relaxed/simple;
	bh=+mGoF9JwgI6c+QZpu+TCNir986u8wYfMWu5E5ArQeng=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=juC9rQhKrZxUVs1tSaoP2oTQG4SiZJFeLANB+EHEluKMJT8IankQylvGXW55KUjb0HAeV+SeMsubfgICvaDSm2gzrGVx2MRVaEF18tfILXq9YBmTlu3oMImczsyGkEnqO9ylz8M4o74MOf8FL7c0yCoIqRIFN8bjzo6NLYhRHzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NqDO34Ip; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NqDO34Ip"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2b941cd869cso27360065ad.1
        for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 00:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779260542; x=1779865342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ywhZO2eqzRTajRbw+DBdw5fKWMJj8Wquqh8z21Ew4Lg=;
        b=NqDO34IpVb7Uzq9aITosOpIrVCeqQBQ72BpK4A8MJsVq1tyzc5GrS3kBlRvf759/F9
         xlj3uFlenvkm4aPcw+BxAguN5iCoo9tNcbgbN3t6/AF8LXfDBBppR2kryHqAr8zGctG/
         NCmQpU1elHlGQwhkrCo7ZOTSJzKlTJb624BhKs5Zj6xxJPZvOINAarcmWPhM4xjwN2G5
         TOjEyiZaJkG9sO7xxPwD+JLBLBlp++aoufjlQdfFeIM30foc3ruhEHkDRUIyy2dPxw/V
         cHDJ0dR+YBnp3ZLKTXpn0nKCjXBgsU1J6asn1r+Hc70EmEL+Z+2a76N+x0OAbEhwXWAL
         bOBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779260542; x=1779865342;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ywhZO2eqzRTajRbw+DBdw5fKWMJj8Wquqh8z21Ew4Lg=;
        b=m7yCwCfW8QbEv/m1SaDQn5g8nV+8qupbwenoV/Pm+DiLq6YQWMpw+Xk5xsGR1t4OfH
         Aw2T5Vjyik2RcwRoyDpLS19QZ+YiBDfSAJJSMiSsLuegkP/1tZRqqiAJh3CTMPNJG3OA
         26WHh7N+8PtSpMwnetNJXZumC6Upj/K6mYDU7HgzBAnmARGu35QXg4mLJdTZ8yENj6cg
         BU7LJcECWMCvVaUwrLNWrwRS1m+5G55M9pwFhkdMI8F5Aw9ObxutkeEnmnCzwGofgtU3
         8xDf7mN3sVgzdIb3FjGUAjd12go6VqaLr6YwKBsKgN6mgPTP/X2BHFfxeNsmkh39frhx
         GWSA==
X-Forwarded-Encrypted: i=1; AFNElJ9/Ss3epSuXus9lfGcXwHimGfX3Pksgjb5Mfz8CEiQOzvo1riuoMNtePWnOaXr7R8rdQfGpYfEJzw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyTZ6/oXJEZKAjfyj7keLt9bAmjyYl5qo+dwzkC+mRfVHgWxttw
	h7zFUZVZgfbrZmdA0arPPOdc3Xmj6Xz3IwQpb7vMHEDWoLMsIGVDuKql
X-Gm-Gg: Acq92OHvrCMEr7NhM5bEJStGou6TbP1lNaSOgfScQ/QQxCsVgJ0fqAec3bk0zzm1sft
	lu67LzPM49Qc6q5A8xNm/gCWudr/gvn9afmUify1tFuVaq7qWVvEocULVU5raD96tN/2zjn+wjx
	ocVMiXb7SV8nsq0E9hnT8fWap4qukAGFNHQHz+FYqS3EXqGhh1tByAgrx4dwDZIQUSqvfLLOIzu
	OgiYy2buQ+EvBXidoLNzKlp7LmkjkRxRfHDH+umHjUzZIMDB3Gwc4y5g2v+Vq4O9bUKWl55CnG8
	wQZYcLscHdobA5V1e+Zmm9+35r4CVMsXKH31Qp4/RHhXHAvB3TOmhg/hvsZ/dZk3QYAG+D96T3d
	xNE8zN8LR6YydvyV/Gg3qPBPS/PPgnfE+TFMasnr++yx+JNSo/3looxd1Tqf7dloSjzvUjEwB3z
	y5dOKi/f/zGsQH2bQ6b6QG+etm1N1BUrmaGHP08/s1MesUtyH0gtbsQ++bAISBGcvzQFvmeEU=
X-Received: by 2002:a17:903:1ae7:b0:2b2:49a7:a5bc with SMTP id d9443c01a7336-2bd7e9e5458mr233213185ad.39.1779260542004;
        Wed, 20 May 2026 00:02:22 -0700 (PDT)
Received: from EDAMAMEPC.tail763c14.ts.net (p1188143-ipoe.ipoe.ocn.ne.jp. [122.26.33.142])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5b568cefsm209708455ad.0.2026.05.20.00.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 00:02:21 -0700 (PDT)
From: EDAMAMEX <edame8080@gmail.com>
To: mario.limonciello@amd.com,
	ray.huang@amd.com
Cc: perry.yuan@amd.com,
	kprateek.nayak@amd.com,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	EDAMAMEX <edame8080@gmail.com>
Subject: [PATCH] cpufreq/amd-pstate: handle missing policy in dynamic EPP callbacks
Date: Wed, 20 May 2026 16:02:11 +0900
Message-ID: <20260520070211.2753183-1-edame8080@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cpufreq_cpu_get() returns NULL when no cpufreq policy is associated with
the requested CPU, for example because the CPU is offline or the policy
has already been torn down.  Both amd_pstate_power_supply_notifier() and
amd_pstate_profile_set() acquire a policy via cpufreq_cpu_get() and then
pass that pointer to amd_pstate_get_balanced_epp() and
amd_pstate_set_epp(), which dereference it unconditionally.  A racing
CPU hotplug or driver teardown can therefore lead to a NULL pointer
dereference on either of these dynamic EPP paths.

The third cpufreq_cpu_get() caller in this file, amd_pstate_verify(),
already handles the NULL case.  Bring the two new callers in line with
that pattern: return NOTIFY_OK from the power-supply notifier (matching
the other "nothing to do" exits) and -ENODEV from amd_pstate_profile_set()
(the usual cpufreq error for a missing CPU policy).

Found by code inspection; not tested on hardware.

Fixes: e30ca6dd5345 ("cpufreq/amd-pstate: Add dynamic energy performance preference")
Fixes: 798c47593cca ("cpufreq/amd-pstate: Add support for platform profile class")
Signed-off-by: EDAMAMEX <edame8080@gmail.com>
---
 drivers/cpufreq/amd-pstate.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 453084c67..f659a54c7 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1183,6 +1183,9 @@ static int amd_pstate_power_supply_notifier(struct notifier_block *nb,
 	if (cpudata->current_profile != PLATFORM_PROFILE_BALANCED)
 		return 0;
 
+	if (!policy)
+		return NOTIFY_OK;
+
 	epp = amd_pstate_get_balanced_epp(policy);
 
 	ret = amd_pstate_set_epp(policy, epp);
@@ -1218,6 +1221,9 @@ static int amd_pstate_profile_set(struct device *dev,
 	struct cpufreq_policy *policy __free(put_cpufreq_policy) = cpufreq_cpu_get(cpudata->cpu);
 	int ret;
 
+	if (!policy)
+		return -ENODEV;
+
 	switch (profile) {
 	case PLATFORM_PROFILE_LOW_POWER:
 		ret = amd_pstate_set_epp(policy, AMD_CPPC_EPP_POWERSAVE);
-- 
2.43.0

