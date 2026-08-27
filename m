Received: from mail-pj2-f6.google.com (mail-pj2-f6.google.com [74.125.227.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535DE3F88B9
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 09:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787821521; cv=none; b=S17QwrlG1hgP45OEXywQbtAW1B34o+jSFkqQCDn9cLDKqvaEtPMeCfAxYo6SKzhbKRpiY81GPMtpOs0TaPHT3Lt/c96fDvDuEfVtTxB747/9UY0sXg1p4DmP55FMO1hF7cgYAny+bJ2mjkEyEGUcZHxdg4R+4nlgsF//yY9U/Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787821521; c=relaxed/simple;
	bh=oN8YLZgjM7glwBTvFfgUO69SKZnq8TcdnbKsMa/7Cy0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z9imxa2gNZVmIhjs8q8tdpB8iHsEJVc+uDpAW9GDb30WK3dR0uVqj6BbleoRSuEid969CXS4erDnOt5Ouc1miOVzLEqw1hUkgCTjc0V5+8Yy69y7HgygOCUNJa3Q6E4G7gQQVNoUsWXX059TN94utcLkjrvmszVWdbiNb1QfTEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.227.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj2-f6.google.com with SMTP id 98e67ed59e1d1-3964deae8a7so181034a91.0
        for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 02:05:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787821514; x=1788426314;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=La9AuFLCROXXxoi0dY8Uwszt2DZMaT/nI3rGCZbvoXI=;
        b=aoG8Hf/TizjGLZ6kpO+Ly0S0FGGlWf4oOXapT9rlVr0s2Dj/mfGJGTzcJq6fSMXVh9
         AQSq2+OHxBDf5t3qSiKgbz3bjvMNXNcBsihUu5oMJ53MEFWYgC9i7k3X2Vv/5gH46Y0q
         tb+A0BvNYh8vLDhsCZ4fZXIVD13ASR0yAvp+zmibNHw/GdvYzvQyVvwgdBZI53lfLJ0B
         hgXnw84Vg1Jp1c0SXWjVD7OK/I5g8ZYfaFu2iaIawWsareI8qn2iqMaxz9mi6cZ48knr
         kAJvIWZo8wtYZfHnnQDo0J2QUeNSH7oLz8rXqJamvcc/0OVq3/rE0ahRetn0tXcVkfoU
         Qr7Q==
X-Gm-Message-State: AFuF++mIoapcovDoTI5QV3jektWdhPgnz3/gMHRVNlDlbHaVEtjFuf6I
	rhds5AP4BVyi5Kzx3a2BoH3bCw97a8nO2t5x4vAb3mhCBcKdQ0qtVCzo
X-Gm-Gg: AR+sD10hijNYVda0+l2cigxYnTSqT8e2g6Eg/uvIOFy5wEC1dt1BKcSYc7/B18V1LCK
	d10PK1r8VDOgjFakvMbyaKZlTnxPZph5EZRHTPdN2k+05bEH13sootmO21tjnI0ffE5nCZuu8ir
	0hvIslD9UJu3o0M31YQESMCGH8seXJie/Ny6lWh8Iy7KMNCnyGpRoxHKui2QP38afGN/QccNEp3
	ETipqvs2v+CRSgFYW/TwzbvGDTv8UfzcDC+Z94+tqGlUeSGj+Yr+zwerdgcCHUyFEDmzCEluaWx
	kLLjMeFiWt+gaN6PG096r8RaPkoM7KijM00fDZFgtEF/9/wkH/EoxewcTbkZEN1rX6f37+iie0B
	xCuTSoReckn4zn+0kgURUouUX7KMtMw+CL3tfMU65Npqwa8ZSFYVBN4ffa/xNKtauAnmva4ijaM
	CzLJzwy+kKz6j+ExNNF+vMRdgJPhQGS7U0vkoreLp2UT85dKaPSoEKKH4r3yrE8cjzCXpkqX5p8
	LBzYCwgRZkT/Us179b1
X-Received: by 2002:a17:90b:4c4c:b0:37f:e326:6557 with SMTP id 98e67ed59e1d1-3966d43edbamr26043983a91.4.1787821514469;
        Thu, 27 Aug 2026 02:05:14 -0700 (PDT)
Received: from kylin-XiaoXinPro-16-AHP9.. ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396b0d81682sm1950678a91.7.2026.08.27.02.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 02:05:13 -0700 (PDT)
From: Xueqin Luo <luoxueqin@kylinos.cn>
To: rafael@kernel.org,
	daniel.lezcano@kernel.org,
	christian.loehle@arm.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xueqin Luo <luoxueqin@kylinos.cn>
Subject: [PATCH] cpuidle: teo: Do not return a disabled idle state
Date: Thu, 27 Aug 2026 17:05:05 +0800
Message-ID: <20260827090505.3703860-1-luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If idle state 0 is disabled and none of the enabled idle states satisfies
the PM QoS latency constraint, constraint_idx in teo_select() stays at its
initial value of 0, because the loop that updates it starts at state 1,
and so the candidate state index is capped at state 0, which is disabled,
and that state is returned to the caller.

The cpuidle core does not validate the returned state index against the
per-state disable flags, so the CPU ends up entering the disabled state 0.

Address this by falling back to the shallowest enabled idle state, found
by the same loop that computes the candidate, whenever the state selected
by the latency constraint check turns out to be disabled.

Note that if none of the enabled idle states meets the latency constraint,
choosing the shallowest enabled one is the least intrusive option, and it
is also consistent with the behavior of the menu governor.

Fixes: c410a9a142f1 ("cpuidle: teo: Change the main idle state selection logic")
Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
---
 drivers/cpuidle/governors/teo.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/teo.c
index ac43b9b013b3..b4b14c86b2a9 100644
--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -433,6 +433,14 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 	if (idx > constraint_idx)
 		idx = constraint_idx;
 
+	/*
+	 * If the state selected above is disabled, which is only possible if
+	 * it is state 0 (all of the enabled states violate the latency
+	 * constraint in that case), fall back to the shallowest enabled one.
+	 */
+	if (dev->states_usage[idx].disable)
+		idx = idx0;
+
 	/*
 	 * If the tick has not been stopped and either the candidate state is
 	 * state 0 or its target residency is low enough, there is basically
-- 
2.43.0

