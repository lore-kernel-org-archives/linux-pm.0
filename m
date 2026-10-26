Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793030487;
	b=zSpzttYT1KxRoAhXeeTYNd2xZDzgnzSrD1nyj0oKDcV/l7gy1EbU40EXli5f/SHjy84o
	 ugIBMIuU1vSAX4eOZFFDpJZWTsNezM+4HQXwYX1aZvPgbLwcoGSi2nwwRHEF18MV6MZWE
	 zbzZ/H9SeSTaPWqRCJvXxVDMl31fUtczij/age7LtIxBqUVowYVzz5Nn0QAlQlpGTrz0E
	 LZ5AgXL7WUuuWhE0QQE+B64/1hP24ZkyKb1uv256SbXND92Ks5vl3LAv79MLvDSZsoGNL
	 IatnBltu6c5v7S/mXTkcTdf0237I3CFl68R7Cj6MZh7ipvzB8GEBdB+BoQ1U0roahEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793030487;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=ieFDF25dHP1edNybu7K5/jDCEdFup8w+Bgydwx+0E/0=;
	b=z5XGTuomCyupCCeWridofMi/1YeqSMyeKRsgm4zpVgps1v17v9zCvL+HMvv45EOhNeTu
	 bMlB+Y9whMCWBkBm5yP3Gm4ChLrPiYeJtW4J5NVCEoQSXVIvlcAo7ekJ8+SUirizG6RH9
	 6HqT3cQ7P0tuauS3/ZyuwAoh0R/zkTkiAXg7SPfpJhmWq3cjbIbadT/+UjaR+62vOevip
	 K6cpWYs7mbpw/+8ah+RE/q5qQ4/Yod/3I1ibch9yUYpOGj7Z0qgLu5REquwnoZl/2ecVC
	 X5vISdAtDFr1BroupyfvFG1ZWlYVb46/0S99p43JFv/7bEuqcvQdSNkpApCMvv+dyng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=gsE9AsRf;
	arc=none smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2547606A323
	for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 16:01:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2547606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=gsE9AsRf
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c46d41f6af3so196516666b.1
        for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 09:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793030485; x=1793635285; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ieFDF25dHP1edNybu7K5/jDCEdFup8w+Bgydwx+0E/0=;
        b=gsE9AsRfp/au/VPClVtisPgS6NL256YXXHzhJBWy3p1a/BBvDH3CNC7dLlGzaId/YW
         pcOXtpWKTQYLZG12QhmvYxybnaQzqn2QsD+5YxfukWZr2gAbkqmwsLtrq0wNsrXeNJlP
         cqb1SzkAiWmtSCwz0Wlc/vT0MRZ1dVaiTkol79s82Gy5KEELqMsZ2WpuVeM+OaV//05L
         cWQ+CW0oT8G4nEGNsznxPlH9ZPL67128KDXDU5l5bGAxXBsOkRFptLyviLgsWLy5JxVS
         qcReQrkrfX3dtt0wKH7H7Cqd1dmRgKnpoJ+MNADCxuesWYeYESr46w0hAGZUTThKNIem
         FVQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793030485; x=1793635285;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ieFDF25dHP1edNybu7K5/jDCEdFup8w+Bgydwx+0E/0=;
        b=GI2MrS35zUZnZgfSbYUk2cNjnGQrLQ1/9LJe0E+2k9mb3teCnGi4gOGyLx3hbsrOxp
         CwhoIEwpsDgYTDqbGpU2IK39C5m6nS3oymY8C/jQKQ5+TBIEi6A+oybZXiZKITVCBwgI
         VdVDk/3fVQI6m/Hvikc1lc0DimOIBV4YUNona5c8KfvgWktS+q6gPYMGbgKe1FvOWVh3
         rxaStQtq2nwn+OQRL6IhUnHPZk90ppwrkMLHjteA3zljpGNwlfx2y3YPlM+GBjJ5NqMT
         aXeN5rMqRWuVC/WcDgDlR0Q0MHG7TL152NE2DD4+66uBKvr9mQbZUWcawO6mGqXX2Id8
         EIVA==
X-Forwarded-Encrypted: i=1; AKwUvByd5QKrKlYfC4avVp+gAHFkxRHtRHN77u66VhV5zFgc8eR3aw2veu4YhsLLADvFe1MGsdN4ltT7RQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYIdfvbnicF4sCphF5uDnjQN9jsMlqhBMm6zTnh/RwT4MPBdAcqM
	ZueBTECf0EWfv3CdwlgLpz+SeNYIUmipWjEJfJgHDoHQ3uzzHzOoocyo1K+m/ZAih60=
X-Gm-Gg: AYBFou0wripG3Kj/70XGpJgVnoz+FLCJhLSz2V+d+RsoXxlAxZP66FG/2whZ3ScYBpO
	n7PJMUi24o0XDzPRJPRlvdwM4CyQCQ4y6ilJmdXb6jg/KtspOAfkvB493TCkq5yJyzMxPueS/UV
	32ytZK/8UDUlHdQ5iJeCGY1OEWzR9ZcGuCuZB7abN+dOB1bpepSxEqhOsytF1e751LHua/MszFl
	2/QWZy56kX/Kzrr/xl9Acy6zal6bYdS5oqei+D7SfKUL3JqqWmB5OMkIq+AckF5GX6DZvK02zac
	Y9pP8OUnpLtp+Q778bFPteU9Vh+k1SaVKu1T+5TlWJCszRcbYUe1OLx358fp3OS55hYIq7XsWl2
	2LCb7YHBUtJjuyKBeBrIIHfyJRORrq1BtCcnKxtJMyBKTCdz4wR14YBkpIue7Xq8+J11ZKTw0/h
	AyXzO2c/uu543TEbEoLGXb7VhO/fcIzzOpsLqrzEDY6NkmcGFAuYE6L1rHRAjpiVvUopF1pCaOK
	Q3HAshxGF5vpRv3BfWf8Fp/2HTpcWlDJBcLtjyFKaRpIz2ZPKgNbA0Zc2zwhIVTajJauwAHoK9t
	cm3LBsT7rHK2Z8NdjH7YqSX5eQhpToZ2Xz0x
X-Received: by 2002:a17:907:94ca:b0:c3e:34fa:611d with SMTP id a640c23a62f3a-c46bde7eaf0mr1008564766b.35.1793030484647;
        Mon, 26 Oct 2026 09:01:24 -0700 (PDT)
Received: from ta2.c.googlers.com (231.141.38.34.bc.googleusercontent.com. [34.38.141.231])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c49a530f520sm17307466b.23.2026.10.26.09.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 09:01:24 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Mon, 26 Oct 2026 16:01:18 +0000
Subject: [PATCH 01/15] thermal/drivers/samsung: Select REGMAP_MMIO for
 EXYNOS_ACPM_THERMAL
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-acpm-tmu-fixes-v1-1-0637431b7268@linaro.org>
References: <20261026-acpm-tmu-fixes-v1-0-0637431b7268@linaro.org>
In-Reply-To: <20261026-acpm-tmu-fixes-v1-0-0637431b7268@linaro.org>
To: Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Alexey Klimov <alexey.klimov@linaro.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Juan Yescas <jyescas@google.com>, linux-pm@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793030483; l=1279;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=+KG/D0KvZbRCiAETwTUCvZNQ2kPMmB1TmI4WJYpa5dI=;
 b=2yYo0FGBL9w+ojSMILSlcsZfUlNX7O+SioBKk1y25nYproZ23ihVuFC9rL3cKbPnDkrkXyVRX
 NrWjK5uLAq8B/i+SeoGzPZ+7+BlB12MD0bUop+iIEYL7ezkPiyFgupH
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

The Exynos ACPM TMU driver calls devm_regmap_init_mmio() in
acpm_tmu_probe(), which requires CONFIG_REGMAP_MMIO.

When ARCH_EXYNOS is enabled, REGMAP_MMIO is selected transitively via
EXYNOS_PMU. However, both the Samsung thermal menu and
EXYNOS_ACPM_PROTOCOL allow COMPILE_TEST builds with ARCH_EXYNOS disabled
(COMPILE_TEST && !ARCH_EXYNOS), where nothing in EXYNOS_ACPM_THERMAL's
dependency chain selects REGMAP_MMIO, resulting in build failures when
REGMAP_MMIO is not enabled by another driver.

Select REGMAP_MMIO under config EXYNOS_ACPM_THERMAL.

Fixes: 50a2c5d4062a ("thermal/drivers/samsung: Add Exynos ACPM TMU driver GS101")
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/thermal/samsung/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/samsung/Kconfig b/drivers/thermal/samsung/Kconfig
index f63eeae304b7..18ab4ffc8671 100644
--- a/drivers/thermal/samsung/Kconfig
+++ b/drivers/thermal/samsung/Kconfig
@@ -16,6 +16,7 @@ config EXYNOS_ACPM_THERMAL
 	depends on THERMAL_OF
 	depends on HAS_IOMEM
 	depends on EXYNOS_ACPM_PROTOCOL
+	select REGMAP_MMIO
 	default ARCH_EXYNOS
 	help
 	  Support for the Thermal Management Unit (TMU) on Samsung Exynos SoCs

-- 
2.56.0.257.gf7497c7d27-goog

