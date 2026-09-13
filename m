Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D867C3451B3
	for <linux-pm@vger.kernel.org>; Sun, 13 Sep 2026 14:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789311590; cv=none; b=m4el6AOb/EeWw70u13BfvFIkFY2yksyOM9YQGHpy5URQB2uoMfPI1FW7tkp4Ap1Duw4iGx5pEQz9P3I8TFkeNuU8ztDPMwdomONwNjGwh91UDp5H/DpWaLGBT0nSeDEdXHHd0szLcPvwNnNlJn85UKQsTg+bcA0VdwxNz+9yuEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789311590; c=relaxed/simple;
	bh=0IIGU054tt+E8qnL/Yk5Tr//CO6EOeuDoT49QSKK/uM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hJ+S7LW3mc3r4b4jsl+E9Oby7i0FuJi81MdDG9F8mUaQaHFwhAopxxA6YHox/0LkFEGNEFr5qx6vaCBXneSinDnMkhD5JqfSaJUEat0qsIP9rG3Fylj+oua90b5QxCVbaO/jkzk/S2qNF/6xI+54bS/UujgRR9dTw4MnMu8eq+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ErzaFGF8; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ErzaFGF8"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4bdf8acd6so859440a12.1
        for <linux-pm@vger.kernel.org>; Sun, 13 Sep 2026 07:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789311585; x=1789916385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BAqzrev3ql7m+gjCEjFJwn+RHOm49DDWKh/BDuvYgTQ=;
        b=ErzaFGF8lP4fWVrKmnpxOaYk52Ut87LYVjT67ccPYcOcGSchMzxLkFvgFTcAD5euls
         iE4fzNl/JGq+YsikXzGka9phkdHtiBvYCeRMEU3utWaauyY3XEDPaScxmwmM/asCXPAd
         EXoZM9th1Jor22jDZjSxj3viIXLAdAObXixCv5dSDga+/Zarh+ZzCRPt+19302ABzKXc
         /pFaS/7h08P0Ps6eo9HxbpecVqd2nbXHgVWh1gC1IwtcYvUJkmIYYuPF15dy8H9k3Wuf
         h6GPDaZjV50SmOlXJtn9B3ugD+28tqiGHjdeIGeXCf++nYGmRQ0Nqzf9oAWoARjsiDhY
         qPxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789311585; x=1789916385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BAqzrev3ql7m+gjCEjFJwn+RHOm49DDWKh/BDuvYgTQ=;
        b=byti8Go5vl/rsGwd7YP1exioeNuJD4wjpalauXanmqiDkLSOOlNAz4rim7H9LCIw1E
         3SalQva8y5gvFJH30sdBOMEKPDUwbwJ0N1QIdcQn+7HSSIZGYpMLQ3Bo90lZKu/hMOSR
         930uR5EvKo2iezS5jVorXGKg3w0IDkZVz5BcnYN3R8s9kJdFY6zSergIKnMT2/o874ij
         8dkkYIxqa0h/BghfYTcul56JsNAi1hrjfF3VyNxo+QAbEwzgBqBWKpoEvHRPiga/mJPs
         hJ0aC5554haScKBv0EC4Q19kRLRd4jsTGCenuDLpCek1AyA+OlejbncyE62fpO1MYUKd
         mE2g==
X-Forwarded-Encrypted: i=1; AKwUvBxSyMpAPRSbR5m/ZJizHm89UQjnbyI5FkRWlHuO91hMJzpQiequLLbhJm6Hc2AZNLS/vBt2A/BTuA==@vger.kernel.org
X-Gm-Message-State: AFuF++ltNdh/nW6etQYpQCnUK/ijjx2ajVeIrrOMFnpn37wreIT4A5f2
	WZhv2Q0hR9eTu+st1GmNs3lxRsEmfGkR4HYdmH1JwdASLmsRQv++T7IS
X-Gm-Gg: AYBFou0QPKAlCigA+Ofcxx3ldeOqWRSkKjgAOaeqhpglPvPFpqr3YTfoPm3nQC0suCf
	n5W0Has1vpZb5Wh9lrfYr9QerwAJVGANvOLmT7gHfN9uJV8TgRrcyv7UPwYGCdn6/K97wJEwNsd
	PsZ/Dez+0bCRphFj+Fyt3R18cavHRK+18N0WooLxrvV/PIoFR08hNjfUsEBZ5tYxb0XG8LzBYGV
	+oo/SUXIOsuMqxpAnoMj5OVpc6WdWoZCdimgh3/G4ox3nF0NA9fZLNiJbShiuS4FQFAv+w1/edV
	U1OZsh3Qbkm2w0qtREp7drCY6AjUD36hcZE3pD7Hq7j0/DBW7BuprikPs5qtYu+GiS++BTeasAv
	Bt4sYHW1wTauJfKiBiiIWSIJbLpLDTZ+qvAJutm8ySwbEBCTBV2AVmSb0gtN1OFQsZWZQdkY7Xq
	HGKx9hNrVsoEYGyXMWwWyG7WkzgmyfZJ06I3Y/FgLVLqPWoP9zD11p+kzlP5CwfVqZOBgImcLk
X-Received: by 2002:a05:6a21:113:b0:3c3:875d:7053 with SMTP id adf61e73a8af0-3daed2bd99dmr28436060637.8.1789311585181;
        Sun, 13 Sep 2026 07:59:45 -0700 (PDT)
Received: from archl-rock5b ([45.112.0.180])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365b8f1f7sm17536306c88.11.2026.09.13.07.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 07:59:44 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-samsung-soc@vger.kernel.org (open list:SAMSUNG THERMAL DRIVER),
	linux-pm@vger.kernel.org (open list:THERMAL),
	linux-kernel@vger.kernel.org (open list),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES)
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v9 4/9] thermal/drivers/exynos: Fixed the efuse min max value for exynos5420
Date: Sun, 13 Sep 2026 20:28:32 +0530
Message-ID: <20260913145905.9404-5-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260913145905.9404-1-linux.amoon@gmail.com>
References: <20260913145905.9404-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Exynos5420 TMU uses a valid efuse range of 16 to 76 according to
the Exynos5422 user manual. The current driver incorrectly allows
values from 0 to 100 for Exynos5420 and Exynos5420_TRIMINFO.

Separate the Exynos5420 variants from Exynos4412, Exynos5250 and
Exynos5260 and use the correct 16 to 76 efuse range for them.

Keep the existing 40 to 100 range for Exynos4412, Exynos5250 and
Exynos5260.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index a64b11e6acdc..a38b48e2236a 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -886,6 +886,22 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 	case SOC_ARCH_EXYNOS4412:
 	case SOC_ARCH_EXYNOS5250:
 	case SOC_ARCH_EXYNOS5260:
+		data->tmu_set_low_temp = exynos4412_tmu_set_low_temp;
+		data->tmu_set_high_temp = exynos4412_tmu_set_high_temp;
+		data->tmu_disable_low = exynos4412_tmu_disable_low;
+		data->tmu_disable_high = exynos4210_tmu_disable_high;
+		data->tmu_set_crit_temp = exynos4412_tmu_set_crit_temp;
+		data->tmu_initialize = exynos4412_tmu_initialize;
+		data->tmu_control = exynos4210_tmu_control;
+		data->tmu_read = exynos4412_tmu_read;
+		data->tmu_set_emulation = exynos4412_tmu_set_emulation;
+		data->tmu_clear_irqs = exynos4210_tmu_clear_irqs;
+		data->gain = 8;
+		data->reference_voltage = 16;
+		data->efuse_value = 55;
+		data->min_efuse_value = 40;
+		data->max_efuse_value = 100;
+		break;
 	case SOC_ARCH_EXYNOS5420:
 	case SOC_ARCH_EXYNOS5420_TRIMINFO:
 		data->tmu_set_low_temp = exynos4412_tmu_set_low_temp;
@@ -901,12 +917,9 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 		data->gain = 8;
 		data->reference_voltage = 16;
 		data->efuse_value = 55;
-		if (data->soc != SOC_ARCH_EXYNOS5420 &&
-		    data->soc != SOC_ARCH_EXYNOS5420_TRIMINFO)
-			data->min_efuse_value = 40;
-		else
-			data->min_efuse_value = 0;
-		data->max_efuse_value = 100;
+		/* Valid efuse range according to the Exynos5422 user manual. */
+		data->min_efuse_value = 16;
+		data->max_efuse_value = 76;
 		break;
 	case SOC_ARCH_EXYNOS5433:
 		data->tmu_set_low_temp = exynos5433_tmu_set_low_temp;
-- 
2.55.0

