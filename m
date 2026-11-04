Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793804265;
	b=RkIgonc5P9MZk6SVQIWELxE426VMO1AsiBMI2NyoGDpaYt+gF2BOT66iPJ1C8wwmTwXB
	 EhUHGdt7GD7ln9s0km9UeSJoy/d/HcIq+4G4Z5m/n0PmbAZJLB4qAOVqyKTfoigVfZLKY
	 3EinGixtBjhpdQIKcffkNKFlIUgQyktp3+4WXqwMhWjCw5mPQoloC7VNBD3qQQu0WtM95
	 065fUo8aQloOnleMbls1yDRLRu8ciooX1ortj9nVDe1VnUu67CtBtTE3m5W9J2AfwR3Lo
	 xvXAoaq9/kLxSAPON7WTCuYuWpmvH/G3HFhxMQJEuhg/f4E496/y+cIs4wt2kOHn37g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793804265;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=apXXgMBcXmgqhAAmBS3GdCjBKzXMpnkhL16Of9ur6Ww=;
	b=qeOx/iFnfFaT99zI3PCmWuOwkQpvU4ErDujRZn9oCfFAgJ2jXHjVXg3x8Kh2VwWnAlBt
	 yga2qD4V6N3VY6uT5xbQ31gDDltDd0s7eHtmG/Kte4GBL1MKdLz6VF4WM38kpi7sP511f
	 o0B4LCgbPg1avyOH1K3lJpJ47fdbsVJrczmxI5LxBMYVB3Out74YcDimCGKyqNR5WE9p0
	 coseqUkW8R0wxRm4HMBbEGRdKn5PJO30r/aYU+g9rGuHUBkyKJwM6CM7xgawQSaYxouzX
	 k+5HSyEPJ84PO3Uh7aAluoEtjJVmjguPQEBKPfdJfIh7G3TQi+FFCprV4C9CSfWfpsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=grische.xyz;
	spf=pass smtp.mailfrom=grische.xyz;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D567606A33E
	for <linux-pm@vger.kernel.org>; Wed,  4 Nov 2026 14:57:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D567606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grische.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grische.xyz
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-490f38e9688so47449f8f.0
        for <linux-pm@vger.kernel.org>; Wed, 04 Nov 2026 06:57:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793804264; x=1794409064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=apXXgMBcXmgqhAAmBS3GdCjBKzXMpnkhL16Of9ur6Ww=;
        b=jpjCyDQvo9gZ8calxoYlq6CGyoVy8dAQaMWJIQexfuCnu5K12ayHEYk08oh2s91/j8
         Ls/2WrgO6Sj6RgPavq3OB+0om7avhP7iIgiWDeeX6tMvFMEtwAh+DU3VDn5IK0VcCsAY
         Mp74twTYVhlwh/8G/QLP6/L5Hzn6A5d5aTNx/k8l6PxYH8lcy9/KnHSw/7IH/cVBjdG5
         WDfmagA5o3FZPZvxgKoHOng2v5ieAzK1Gis0UUKfJpbsarSgtfmXqoySM9Go5dZ196lb
         humIyZ4T51uaEsnmy7YJ3ijL7yjb5qTLGWlP+ELUVect+E+A7Y7rRB9JO3RkhIIdGpZu
         IbMg==
X-Forwarded-Encrypted: i=1; AKwUvBxoTMuRGhUllGZYCLiAzTfwEQXjSBXIIycITKBUiNJGZlOmH45CIzFi0YcA7oghy9DvMxhm4fA4tQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+Z3e/ipEAe9MQlgzc9nms9RkG5EVJFwyMlU3sBpttvLVNa7Lff
	V1orRY1EPskibOsf9ngAWE1eB4a+DvTvTYQsG0U50G7w03T3kbnutOZCz6T+hUuU+Bw=
X-Gm-Gg: AYBFou0t6DOLbuLWizE+ZtSNh7uNAb280WE1MxER9ZEcfUjN11F979/QLvkK1CH4fvt
	8lkoKRG7Qgc3PkNPVlOs1DOvzNGiA5yhFhNmcN8NpSvKMAHOj9aP9l0AnLlmoR9i9NHNaCENtWI
	SADNFLgPQTDkgBOM/zpr597CLrEZ36qKrFXm7sGiVDYtZnIXe9EL3f6xoOCf9FvSJ4NXKLjx/Ea
	hfJx+UO7Ssn24ZKk9detz8OdBLJYChDXPWniURqWaikTUlprzHRZ8fJD488yIiaer40iVCSwwD2
	nEI+rCpn1QjoSzlmmrsKInqqsTF8MNwn+FMj9ImeI8NW271eQ/DSt5wV8X6nXLcH2I9AGlDq0Gm
	cSwyFte2zVdFUgeh0HlhDmTIS1Wa6063bWPgpcZ9cZ+LCLSyg34z240ppopBtissnCN2ETDLqw0
	A1jdScdluDNCNTBwAyhX1WqmGGxirQ8CxvaMEVm20oCdA34+a0SsmAaf18cVSy+gjrNGnz7aK0k
	WZSFg9gcIvZ5/gD+hpN/Fj/ybTmMRsPlByK0AeGWEcMYjioec9KGflrDz1k+ZTJR0INnZTx4OAF
	lBFLeF7w8W164lvUE0gODaXalA==
X-Received: by 2002:a05:6000:420c:b0:48e:6264:c371 with SMTP id ffacd0b85a97d-48e6e2cb57dmr39441884f8f.9.1793804263873;
        Wed, 04 Nov 2026 06:57:43 -0800 (PST)
Received: from lake ([2a02:810d:d09:1b65:4366:70cb:bf82:f8ac])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fecf8ef85sm4830051f8f.27.2026.11.04.06.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 06:57:43 -0800 (PST)
From: Christian Schmidbauer <opensource@grische.xyz>
To: Amit Kucheria <amitk@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christian Schmidbauer <opensource@grische.xyz>
Subject: [PATCH 2/2] thermal/drivers/qcom/tsens: Drop __init from the per-SoC ->init callbacks
Date: Wed,  4 Nov 2026 15:57:40 +0100
Message-ID: <20261104145740.2623473-3-opensource@grische.xyz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261104145740.2623473-1-opensource@grische.xyz>
References: <20261104145740.2623473-1-opensource@grische.xyz>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

init_8226(), init_8909(), init_8939(), init_8952(), init_8956(),
init_9607(), init_tsens_v1_no_rpm() and init_tsens_v2_no_rpm() are
marked __init, but tsens_probe() calls them through priv->ops->init()
and can run after free_initmem().  The call then jumps into memory that
is no longer mapped executable, and the kernel oopses.

The probe runs that late when fw_devlink defers it until the deferred
probe timeout.

Fixes: a7d3006be5ca ("thermal/drivers/tsens: Sort out msm8976 vs msm8956 data")
Assisted-by: Claude:claude-opus-5
Signed-off-by: Christian Schmidbauer <opensource@grische.xyz>
---
 drivers/thermal/qcom/tsens-v0_1.c | 9 +++++----
 drivers/thermal/qcom/tsens-v1.c   | 7 ++++---
 drivers/thermal/qcom/tsens-v2.c   | 2 +-
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
index 32d2d3e33287..a13897632b91 100644
--- a/drivers/thermal/qcom/tsens-v0_1.c
+++ b/drivers/thermal/qcom/tsens-v0_1.c
@@ -207,7 +207,7 @@ static int calibrate_8974(struct tsens_priv *priv)
 	return 0;
 }
 
-static int __init init_8226(struct tsens_priv *priv)
+static int init_8226(struct tsens_priv *priv)
 {
 	priv->sensor[0].slope = 2901;
 	priv->sensor[1].slope = 2846;
@@ -219,7 +219,7 @@ static int __init init_8226(struct tsens_priv *priv)
 	return init_common(priv);
 }
 
-static int __init init_8909(struct tsens_priv *priv)
+static int init_8909(struct tsens_priv *priv)
 {
 	int i;
 
@@ -240,7 +240,8 @@ static int __init init_8909(struct tsens_priv *priv)
 	return init_common(priv);
 }
 
-static int __init init_8939(struct tsens_priv *priv) {
+static int init_8939(struct tsens_priv *priv)
+{
 	priv->sensor[0].slope = 2911;
 	priv->sensor[1].slope = 2789;
 	priv->sensor[2].slope = 2906;
@@ -255,7 +256,7 @@ static int __init init_8939(struct tsens_priv *priv) {
 	return init_common(priv);
 }
 
-static int __init init_9607(struct tsens_priv *priv)
+static int init_9607(struct tsens_priv *priv)
 {
 	int i;
 
diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
index 7bda8e6087c4..ed0064f4e1ae 100644
--- a/drivers/thermal/qcom/tsens-v1.c
+++ b/drivers/thermal/qcom/tsens-v1.c
@@ -145,7 +145,7 @@ static const struct reg_field tsens_v1_regfields[MAX_REGFIELDS] = {
 	[TRDY] = REG_FIELD(TM_TRDY_OFF, 0, 0),
 };
 
-static int __init init_8952(struct tsens_priv *priv)
+static int init_8952(struct tsens_priv *priv)
 {
 	priv->sensor[0].p1_calib_offset = 2;
 	priv->sensor[0].p2_calib_offset = -1;
@@ -173,7 +173,8 @@ static int __init init_8952(struct tsens_priv *priv)
 	return init_common(priv);
 }
 
-static int __init init_8956(struct tsens_priv *priv) {
+static int init_8956(struct tsens_priv *priv)
+{
 	priv->sensor[0].slope = 3313;
 	priv->sensor[1].slope = 3275;
 	priv->sensor[2].slope = 3320;
@@ -189,7 +190,7 @@ static int __init init_8956(struct tsens_priv *priv) {
 	return init_common(priv);
 }
 
-static int __init init_tsens_v1_no_rpm(struct tsens_priv *priv)
+static int init_tsens_v1_no_rpm(struct tsens_priv *priv)
 {
 	int i, ret;
 	u32 mask = 0;
diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
index 843dd29fad2e..22284973bb61 100644
--- a/drivers/thermal/qcom/tsens-v2.c
+++ b/drivers/thermal/qcom/tsens-v2.c
@@ -220,7 +220,7 @@ static int tsens_v2_calibration(struct tsens_priv *priv)
 	return 0;
 }
 
-static int __init init_tsens_v2_no_rpm(struct tsens_priv *priv)
+static int init_tsens_v2_no_rpm(struct tsens_priv *priv)
 {
 	struct device *dev = priv->dev;
 	int i, ret;
-- 
2.54.0

