Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6258138DC43
	for <linux-pm@vger.kernel.org>; Thu,  8 Oct 2026 04:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791432480; cv=none; b=ntNHgVwRGQbWA1PAZpDeYu14JYV3hMKPAzPzQo3WdIxOUPcXNsVV75Ce3S9hclkkrFzdL07e1Cn54FB4lAJZvrQueTiVrsLdQuHLpzGgsx7POKs1Q+/cehzu24JVBeMA6EGh73wGiojYZsPSVCO1/M4Q49VB7vkW32Kx6VhQW40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791432480; c=relaxed/simple;
	bh=eN/CZ0g8dEhhAB4TCIZ6bYboNzAcetSZ5y4UbmprSTs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZClexiKr0Yt04ctqdVLZxedyjWt7Ku2DY/zqg+d5ZmAioVgalp5t8NxoAX5ceFmeTmd8nbwhFF3HWB7Zl0AEcd2LoFj84bDstiaKGxOOBjUxidnnRaw9mMnv+2WnS15YW2isfXM6xAthdOf5EzINDMyfijLNU4VnztqL+aHdYjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dwt7N5aq; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dwt7N5aq"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a17f65ab8bso9331695e9.1
        for <linux-pm@vger.kernel.org>; Wed, 07 Oct 2026 21:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791432475; x=1792037275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8RXN0pRoDPRt/4/q4G7QWKtdi+MOFx+4+xgS3NP3upU=;
        b=Dwt7N5aqm5cYyDc+huAxA+bLXtiDg6jeXvEFkMg+ckSARoR0cYQeAG5KUuatz6Whia
         DviSzTI5DvX07Ci7/9M1oIBWOp5/+tvj5oKk/ghkCBwGZDMGlSVF0a2C0kgsxjJNUdO9
         M3nXtMPY4Nb62XKtRO0ewmUKyA5167h5X+QBwye1Q39eGPnDG7xtiX7ULXKd0rUB2us6
         OZ+3x8ckeZFfZzHDEF0xtEVHsyJKF2JOwN+QRZC1JQ1o+0E+j5LbZZUxB8kC93dJCHWI
         gZncDi/V3Q3u6jmCzMO1po58UHwtvhhq68zNa5iAzukzs5ijvtq3rGSXTAsHPkthPEBH
         M0oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791432475; x=1792037275;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8RXN0pRoDPRt/4/q4G7QWKtdi+MOFx+4+xgS3NP3upU=;
        b=Ht9gORDeQ8G654RYIGyQsoEgyEfkT5dD92H+Tq12ayhqsEBmWpAuy+DSNUPkM8rP+j
         8j/3Tp59mhxNpMvCccUzNqwq/O9ZyridaFh4atRG/3rbpMchUveeq9h61+4XbSlPJVkz
         V1TuEnB1f2jdafpz/QEPafbXEYct7paLmQ5sIZaU58NG34Udrqhwu8e3PBun9ojhxx/L
         Flwgz+spatD9bLnfTLDIHkYzwS6gWcXqe0xcjhqytabCuEi4SbX9j1dKGr7zHRSQDOIi
         75hpAQo6InoQWTshDEjOWE0XhtsreXeh6DeNJIx9mbo0SzSGT5Gv/45MFObWvfeeOQFN
         YgPw==
X-Forwarded-Encrypted: i=1; AKwUvBy9QW3FFWXEUAwUdCsa122tdPeZQocpRccud2oZhu8lM0PQN5OM0YYtfqS6JgVokVzF2aWTW722bA==@vger.kernel.org
X-Gm-Message-State: AFuF++nu1w74vbhIn92G7bK8AkMLuF55cqK0sjGJ/GzZTk0Xk7+oY2eI
	6xsNTKOTcHWRL61cKEoMaStwrY2gUP0VSFC/cUVUg0OgPgh2sc+9c9Fw
X-Gm-Gg: AYBFou3O/wKcaIMtFjGfpYvPGUxRPU9VaMiBKEoT4mwnden3W2MisnmWbdxtaNgCNI1
	V/IVAM54bTolp6/jW/ijMskf5XQOmuw1ATNoPKH2zIb/yafdduo1QM3QwNjOIQz3wY73Fa+8cCe
	hCnqsZCNgt6/rE4CaRdTc8PEKjBejGz5fjQZBFHkJL7khV4+nrYFo8NXFRgVihBUhmf/E4WNg20
	QszlQg87SIVJZMcuLdEc5bUjMY0Pf/Om6umX1V1uPXVf9SlFTEKHVDlfySgJ8iDByH4z35kuaRV
	9YvtX4M6bhQA8mSt8kioFj0E0ewU0y9aGFYLYx+8RvZbfqniXIfntXLHK6iFMql8kaLiNn0LEf7
	F8Z3wAax+7L7ewXb7Mh+DQens0uCF2uRsX0d/95ww5KGKqP6MilOhBwNK3z5HU2FLiSb9skVuaX
	4jLCukmNAxFcYZPzy5larfAwqEKpxmbnJ/iDLatqeKaxb9T5410LDT/AkGjkXBVdozOHE=
X-Received: by 2002:a05:600c:c165:b0:49c:ffab:551f with SMTP id 5b1f17b1804b1-4a181b33928mr74752385e9.22.1791432475504;
        Wed, 07 Oct 2026 21:07:55 -0700 (PDT)
Received: from arch.local ([105.110.78.96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a180310c9fsm91191145e9.4.2026.10.07.21.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 21:07:55 -0700 (PDT)
From: Akram Boulahia <akram02st@gmail.com>
To: Mario Limonciello <mario.limonciello@amd.com>,
	Huang Rui <ray.huang@amd.com>,
	linux-pm@vger.kernel.org
Cc: Perry Yuan <perry.yuan@amd.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-kernel@vger.kernel.org,
	Akram Boulahia <akram02st@gmail.com>,
	stable@vger.kernel.org,
	Marco Scardovi <scardracs@disroot.org>
Subject: [PATCH] cpufreq/amd-pstate: Don't fail active mode init on read-only auto_sel
Date: Thu,  8 Oct 2026 05:07:05 +0100
Message-ID: <20261008040705.10600-1-akram02st@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 9dfd13f80c85 ("cpufreq/amd-pstate: Toggle auto_sel in active
mode on shared memory systems"), shmem_init_perf() no longer returns
early in active mode and always calls cppc_set_auto_sel(), which was
needed for shared memory systems. However, on firmware where the
Autonomous Selection Enable entry of _CPC is a constant integer rather
than a register, that write fails with -EOPNOTSUPP. The error is
returned, every CPU fails to initialize, cpufreq_register_driver() finds
no policy and returns -ENODEV, and the kernel falls back to
acpi-cpufreq:

  amd_pstate: failed to set auto_sel, ret: -95
  amd_pstate: Failed to initialize CPU 0: -95
  ...
  amd_pstate: failed to register with return -19

This was seen on an ASUS ROG Zephyrus G14 (GA403UV, Ryzen 9 8945HS, BIOS
308). Its _CPC tables are revision 3 with the entry fixed at 1, and
cppc_get_auto_sel() reads back 1 on all CPUs.

If the write returns -EOPNOTSUPP while active mode is requested and
auto_sel already reads as enabled, which is what active mode needs, the
refused write is harmless and initialization can continue. Any other
failure, including a refusal where the current value does not match the
requested mode, is still returned as before.

With this change, amd-pstate-epp loads on all 16 CPUs of that machine
without warnings. amd_pstate=passive behaves as before: it still falls
back to acpi-cpufreq with the same -95 errors, because auto_sel stays at 1
and cannot be changed.

Tested on Linux 7.3.0-rc6-00037-g7b63ef2d55f2.

Fixes: 9dfd13f80c85 ("cpufreq/amd-pstate: Toggle auto_sel in active mode on shared memory systems")
Cc: stable@vger.kernel.org
Cc: Marco Scardovi <scardracs@disroot.org>
Signed-off-by: Akram Boulahia <akram02st@gmail.com>
---
 drivers/cpufreq/amd-pstate.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 8bfd46d60843..05b496946d13 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -500,6 +500,7 @@ static int shmem_init_perf(struct amd_cpudata *cpudata)
 	union perf_cached perf = READ_ONCE(cpudata->perf);
 	u64 numerator;
 	bool auto_sel;
+	bool want;
 
 	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
 	if (ret)
@@ -518,14 +519,23 @@ static int shmem_init_perf(struct amd_cpudata *cpudata)
 	WRITE_ONCE(cpudata->perf, perf);
 	WRITE_ONCE(cpudata->prefcore_ranking, cppc_perf.highest_perf);
 
+	want = (cppc_state != AMD_PSTATE_PASSIVE);
+
 	ret = cppc_get_auto_sel(cpudata->cpu, &auto_sel);
 	if (ret) {
 		pr_warn("failed to get auto_sel, ret: %d\n", ret);
 		return 0;
 	}
 
-	ret = cppc_set_auto_sel(cpudata->cpu,
-			(cppc_state == AMD_PSTATE_PASSIVE) ? 0 : 1);
+	ret = cppc_set_auto_sel(cpudata->cpu, want);
+
+	/*
+	 * Firmware may expose Autonomous Selection Enable as a read-only
+	 * constant. If it already matches what active mode needs, the
+	 * failed write is harmless.
+	 */
+	if (ret == -EOPNOTSUPP && want && auto_sel)
+		return 0;
 
 	if (ret)
 		pr_warn("failed to set auto_sel, ret: %d\n", ret);
-- 
2.56.0

