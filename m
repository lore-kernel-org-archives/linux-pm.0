Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793030488;
	b=wv24vxRSr/1gkSMe5s3kjzvAxHQVhxsrOgqvoAktd6YKLlbnmdsijZCEzGLH3+1tZKjI
	 fu4+/XBZsLujYA2Z2DU6AnzhPlsdH8r3G3OSvFnFPw3A9Tv6PhostiTHE1t7d0S9xJc96
	 tyCQtZ8DHAeBBwwAnBjfh+ujB4wXpsGTtkm16+iA8omIWt9Jxnl0toJwIh5RoNRwHiEnh
	 Z0NC+lm5DO4HuMo6C7TOIRw7W6CPKeBhYbGbTh2ZEZ+1KpJdkGR9BnS5eI20dc3JqxIge
	 OeGhpssL0cJ4EPWGhwawiWfKtVyx0HG9iCQdFAQM7IozAwfF/7BSoblDVTHc7gTvxdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793030488;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=XK7qHQy7h7fEOAcUVe+GZGt54pAG7ispME5t/pzPbRc=;
	b=kqeLKumHmzlG+2JoibA0qOQXidBX4p9QRrP/lOAvbL1Yb3h+eFl9OAlYMncHUns9dhpE
	 s+MehGlVvsJZgNWQ9qNg+R1NpSVcrtqnsQ7nGMNGL6Fquy/NjS2WWiHfl+ybeirFjrrhR
	 GSGkiD87YmSQWIQ5+TPU1ZT2OW3T/qI0ewwnMxLlpfckbtvQSzgSCMCmHf3ya9vuFkrwI
	 rP9MOuOBetDf8mN2zW2RyLsWQZ8ImH7VZbmWP83bYkUlj8ksL2NDyzYWnjVOfzewy4EjV
	 s2PVV5tWFmRHzQJ5PpC0aXWqIneCHPIiCJpaZaEW9udLgcO42/PIwyaO7jYztMT9eMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ieUR3kYm;
	arc=none smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC876606A331
	for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 16:01:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC876606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ieUR3kYm
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c498e2d623bso133829666b.0
        for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 09:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793030486; x=1793635286; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XK7qHQy7h7fEOAcUVe+GZGt54pAG7ispME5t/pzPbRc=;
        b=ieUR3kYm3p4hIfOSxUoDSjFV1IWD3pQVNRWXlDRB9tsLgApSHkHf/RGj7ECfLsbymj
         SJ6Tq3aMHz3BkzycrYkIcxDPfJix09Rs+06ASpB2/Ao9+qV/mRvMh8h3aXFZHsmUCf4P
         8qFZfQMbuONsJKvol30wP7NsvW9f2Scsml+v+SUibIblbNJOW5+qniwKlh6au7xw7/lO
         DX2IDMiUq7N++2C5fkPaTH63lDyafrnNrjA6E4eexmK3J1tMN2VQgSCKJIS4qGK7gOkI
         /v/8ONz22x+hb4UxYM2FvyUp/ne77eiZnfHrqFejCU6FhjZSsRSAsd/6K/xNq7Ml339y
         kphA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793030486; x=1793635286;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XK7qHQy7h7fEOAcUVe+GZGt54pAG7ispME5t/pzPbRc=;
        b=hZvskqWcvYKkQdzowdDvVbRzO+45PRlgfijXJrMBDVNdmIG3lHwa5No1DC3mMMR5AL
         b0Jz9j1yuW3fNOUR7A18spx+qr4vqex7f9EJNe5liVl1Ky40YlAehIZR50i8Lb5KIl1R
         UKlrTCPB6OJqHy65/otag9KzOAkNPL8lftIBSj95R8EZGK9Am7JdAazLeojqD59hl07y
         pRbfsBZFXhZ8BhuqZzm5uenVh3LBOSNgsY4rfzcDOY5XNsGpcuSTdjl9Lg207Z+yqCUG
         EZTn/56idrapH6C/PqO64d93YZBm4vQEXEADCO14hV3E+IdVjzvVBYVU7UtL6KQMVFNy
         K7Ew==
X-Forwarded-Encrypted: i=1; AKwUvByH6Kl8JF1x8J5V7XGTy5lmX+ZhLlpT9VOuu8qV2Yl71F6sfw+IAoA0OLPAGmh7bK27e0HRq6ML6Q==@vger.kernel.org
X-Gm-Message-State: AFq9FYIJpO2xxInp2HbKKuPte9lyaCjLpM1rTe0Wl8ABU52M5nz7F/wT
	8UAOTC1xij3mezGUg39oC6VEr1DYlLsYru+1ohnYUIvM6ptifURTprU0zZdiY1lajP4=
X-Gm-Gg: AYBFou2FKrnFJQ1Z0MlNlpY0AxE6ZKqls0GD+QmRTJK6WQIE17frfzm2CdoHWcn61py
	ZvoosiH2cd3S2nXOzAto1vRtdC1y0gFeaibq5UIYC4AYPNE9tUtN/fyfoX0z259rhEVGlVxKW3l
	pJtRxK6y2OD9BXOQZxgTNevFE9WwxRaxXr2vVHe8k7UTsMf7I/6ZWifS20z5KQaOeGxKZP3wxGP
	I7/Y6+Rk8zxIKjzj591ZnFn7ie+2aIEjFhNRuwltg43KIi86lVCWuMs1YMMdUgEX5RoOKFxY1ZB
	Gzxg/lWwBs5Csl1cARa4hBibn/zATzkSZE6YUIBZRnCpGHmcVY9rJbn5uFeg+lH5vmNAVWLvYru
	xX+u+CKgWwVLvygjxydAnrxDt7zSn719n8wps89tv5+2l2AEjmX1rHX9/4oAkr0tVOt/pAN3DYc
	QmhduGk/67mTau084lyrYy8rUUvXiDc9dSVruf2bN11+k6dgh6S6bbmsgTmB7v8lCFxcFPAuNf2
	/GGBbR/YAk/ny9Sbof8R1a0BSnhFN18gJH4ggb4nHacGEOYJp1AiOUE7OL/cPLl+LJlbvGmA4AS
	RWekbRBYqaeivE+Y36s7UUYIOBxJ++U0OYmY
X-Received: by 2002:a17:907:3fa1:b0:c2d:fade:e089 with SMTP id a640c23a62f3a-c46bd95336dmr871688466b.0.1793030485703;
        Mon, 26 Oct 2026 09:01:25 -0700 (PDT)
Received: from ta2.c.googlers.com (231.141.38.34.bc.googleusercontent.com. [34.38.141.231])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c49a530f520sm17307466b.23.2026.10.26.09.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 09:01:24 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Mon, 26 Oct 2026 16:01:19 +0000
Subject: [PATCH 02/15] thermal/drivers/samsung: Depend on PM for
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
Message-Id: <20261026-acpm-tmu-fixes-v1-2-0637431b7268@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793030483; l=1174;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=Dzhl0EEXao5JmHmXdbQBkEx1RDJKD2McfwIvQF5jBlY=;
 b=yldnHcVgig3g4YuaqhknJNmqQ0LiizU/8L7WyW6sz9Ri/9FOWRHr2VpyiIQE9S5ZTzmP6lMpo
 HHCV9rcJCDYAIrbrxD3SaBInPJhhz5uMQhuqE1CNV6B+NCUxnHtIT87
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

The Exynos ACPM TMU driver only prepares and enables its APB clock
(priv->clk) from its runtime PM resume callback
(acpm_tmu_runtime_resume()).

Neither ARM64 nor ARCH_EXYNOS selects CONFIG_PM. When CONFIG_PM is
disabled, pm_runtime_resume_and_get() is a stub returning 0 without
invoking acpm_tmu_runtime_resume(), leaving the APB clock gated when
acpm_tmu_thread_fn() reads the memory-mapped INTPEND registers.

Add a PM dependency to EXYNOS_ACPM_THERMAL.

Fixes: 50a2c5d4062a ("thermal/drivers/samsung: Add Exynos ACPM TMU driver GS101")
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/thermal/samsung/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/samsung/Kconfig b/drivers/thermal/samsung/Kconfig
index 18ab4ffc8671..b879a63e97c7 100644
--- a/drivers/thermal/samsung/Kconfig
+++ b/drivers/thermal/samsung/Kconfig
@@ -15,6 +15,7 @@ config EXYNOS_ACPM_THERMAL
 	tristate "Exynos ACPM thermal management unit driver"
 	depends on THERMAL_OF
 	depends on HAS_IOMEM
+	depends on PM
 	depends on EXYNOS_ACPM_PROTOCOL
 	select REGMAP_MMIO
 	default ARCH_EXYNOS

-- 
2.56.0.257.gf7497c7d27-goog

