Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4378E480DD5
	for <linux-pm@vger.kernel.org>; Wed,  3 Jun 2026 13:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780491625; cv=none; b=jZSJ4DtlLlObU3MeaOdgtPdS5AEtnpmodwswB85eIvVsTDTBP12bTpRQh0MZ/WruKxDgOAA928fIlTeIx11tlppNurdaWRvtZwzCZo+lbdy9vhVzLUB3v8XztvnymUg52NvkqJni4xut4pBEqbOsbSwwyWn2fZcyLShxxYVYW5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780491625; c=relaxed/simple;
	bh=APjGOr4rSujMx24P1jDIzhjkfbHKcFK80a9vPvVqD0g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tNDLslRg2Wk0+PlAx242WkwGMX7aTVWG01w4j98FXC8iGpF8+oi3cmKOUDiM0OrNoR6znEps9mo/2eOPKrMi20Z0uv5sFSUBDzW9cvuJ6UNgKPoWJVUYeebsL5hBQr0RRbZFX8eY7LwFOJ/66Vo9RzVIb6TFBiHobskbxa9RK2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H60+FdSI; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H60+FdSI"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490a76757e5so28846445e9.2
        for <linux-pm@vger.kernel.org>; Wed, 03 Jun 2026 06:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780491622; x=1781096422; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b9xxE0a97UY7UPF7zz4jpUqke1DXutWR5PtyvwLwWtU=;
        b=H60+FdSIK0d3TQlXZqVLUkCtY/lctO0prfhYmP1S8D56KoexvFUQ6TKkoHr1o6uobv
         yECXpi74UwlsqROZbEacxQhfzQwScY8w5fiWTvPfV/N157MKzYsVsqExV6yFU/cbU4xY
         P6vhnrXVtLLBwJrrObutvjy2IYNcbWCXafLBpYrsDt+8tLetgVOL94dE2OZgr9ChJeMC
         UD4awGN1HEyKo6T7kVyjZCOEccZW+CahRv43up+sZWOkpw1B3MWFvEeJ4eos3x3blkai
         4bsk2fq+nEPIilwRowP1meKxZkqrCr4eY5DLLXewDRmmUukz69mUhKmJ0JSrfGf1DWjh
         PWaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780491622; x=1781096422;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b9xxE0a97UY7UPF7zz4jpUqke1DXutWR5PtyvwLwWtU=;
        b=eyrxBDmo4BZDlNLrg8ffSTqYreaXPSOgqHRkAVIo1P2qn/oClfNmOEpDLUmJKELK1q
         hba57c9nM//9AvjCo3uMgDJpLMXqMJKa6mWSHJKmY4jBS7jrSpVKAJFVhqlWWtVXqbG8
         fO8rvP5yj3lctZK/3s6l407RLT9Zz+t94NkInlgGoZv6+NvdEinHLP1XOvX3TSjri8GW
         nrYlwtMyvNOnfvuM1/lAKDWP47NsJ2cUHtt/OBB2t/lF/RiR8Z1i/InIJn9PLCUbjTWr
         NYw2xp6gmAUTgHB0T0upbP5kzoTnrS1XSrj97zd6QCo09DIZvNZwnmnbsJP1ipTwzgYW
         zkBA==
X-Forwarded-Encrypted: i=1; AFNElJ8HQzdGv7nErIfyeCH2KMOzYcSpN3gkyC3HPR6gzrIX9EtM/8gBD+QetBrHmV/RBjs/av0Yb2W5Lw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh6Oap23P/RJdSsHyVCPSPtWJKTIU97wFWRFHe5o6Ww15q/3Vp
	7jQEBmQ9V7/6id79JSDpdZCCRBGtuhgZ+We6hC3FjgvolEXLyUEoGVJMsZPgS86/k+U=
X-Gm-Gg: Acq92OGrx+0rLvYnFP6FaufiLMTMqHsbh2N9yS9ACNkwpSPRZZMFvrYYyDOk7jJX/bh
	grwl1stdAGJE/i+vT/crbkSzMiG/zQ+9+/SroIxH7I7uvmMOqe818Iv52foNMNcyM1qAduOnveZ
	izDJaQwazIglpNOBOKL3V2zvuAYmghZDPkut0R9uF2pLnGWIqGC2nM57GPt3YolHjjA3xUefRXa
	1t+KaxyKWLjbEfYXaQjfUc1FabKoYkE6F9+UTgRhmxI5Hr6ZvQs8PBd8Q3nTl8z9PnWonRArcgE
	z26H0V38ca39xjDB9O4Ye8z0K51D/kw3nJBeTpPDjKp8hLGycaQiLXCBLstLx5oznX4ybloFggN
	J5o7/mDAHzDEUEd86Y+DHaJimPHWC654iP3v3qMCPdXgGFU6SIzDubscSXrZNpSu6mI6OaDQ4eG
	X/ji3fjZZA5py+He+xBfdb5OIty8TXfBaCvmlm0N8xIpiAIYFODiUJuRVlpwA57zKrkSic1XioK
	fDPVUwx1lmYaDI=
X-Received: by 2002:a05:600c:c174:b0:490:b2a6:8c2b with SMTP id 5b1f17b1804b1-490b5eb82b2mr55987505e9.10.1780491621605;
        Wed, 03 Jun 2026 06:00:21 -0700 (PDT)
Received: from ta2.c.googlers.com (213.53.77.34.bc.googleusercontent.com. [34.77.53.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0e88fdesm149179045e9.14.2026.06.03.06.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 06:00:21 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Wed, 03 Jun 2026 13:00:20 +0000
Subject: [PATCH v8 5/5] arm64: defconfig: enable Exynos ACPM thermal
 support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-acpm-tmu-v8-5-0f1810a356e6@linaro.org>
References: <20260603-acpm-tmu-v8-0-0f1810a356e6@linaro.org>
In-Reply-To: <20260603-acpm-tmu-v8-0-0f1810a356e6@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: jyescas@google.com, linux-kernel@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-hardening@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780491617; l=795;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=APjGOr4rSujMx24P1jDIzhjkfbHKcFK80a9vPvVqD0g=;
 b=gCX5AtDDJC3f+OxPmw3TNwWEn5IdXUI49obuY03uhwbjrXH3wrFPl2PrGLvyeK9L/I5KQ6xVA
 Fe+1lxEnh5cAHVbF9vZx+6xjJo7WU3pRmhyDsfkcxOP/ZiYgCxjet3d
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Enable the Exynos ACPM thermal driver (CONFIG_EXYNOS_ACPM_THERMAL)
to allow temperature monitoring and thermal management on Samsung
Exynos SoCs (like Google GS101), used on pixel phones.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index d905a0777f93..3fe76a4c2633 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -793,6 +793,7 @@ CONFIG_BCM2711_THERMAL=m
 CONFIG_BCM2835_THERMAL=m
 CONFIG_BRCMSTB_THERMAL=m
 CONFIG_EXYNOS_THERMAL=y
+CONFIG_EXYNOS_ACPM_THERMAL=m
 CONFIG_TEGRA_SOCTHERM=m
 CONFIG_TEGRA_BPMP_THERMAL=m
 CONFIG_GENERIC_ADC_THERMAL=m

-- 
2.54.0.1013.g208068f2d8-goog

