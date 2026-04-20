Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17043A7F73
	for <linux-pm@vger.kernel.org>; Mon, 20 Apr 2026 17:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776706819; cv=none; b=gPCjhS6X1r5aSuen0xLqRwzd4/nXfi2eKrfwmtCaIyF1pg/VO2qCtnUGfbrPuXLeA7FbOSLpcpogOJebVzVAMTUG9vIjtLV6j4UtlRjkNiTmj1xtfA1M4KuvmQD1U9y5ZcNnMCu5tqeKofgrTBJwKS6nKGSEkrfXMOLL6GaWgNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776706819; c=relaxed/simple;
	bh=b4zN6V69pfC0jSn1B6TPnsLWLax41ajhjGEGhYeLmtA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h3pZXultBPT5s9K5DGNaGKPArEMbGcsU1XENexEkBUBFQzBvdtA+q4ansIbF/S0KrC7q5zrVq7gFTA31l+g5jeHzLsKfFSA/WtUb6aBPrUItBq+7n8w3HgnPkmiAVfPE0oxXuRu9wshPZCLyWvPOWm4Ywm5NEWckgZeFOrxCPxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CAupjM4Z; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CAupjM4Z"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488ad135063so26876115e9.0
        for <linux-pm@vger.kernel.org>; Mon, 20 Apr 2026 10:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776706812; x=1777311612; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/fwlZkaqAkipgy6piybX/zlZcoSztD08jPD+bFmkPvg=;
        b=CAupjM4Z1Cnnk5+fUwu87eU5F0dqCJ4DBy5J9OWidnQGgRD9cM/KpImYqzvDJVoR0y
         qK25eH4CxGXCSHFOi7ojOdumtqNojW2f7h3fBBkoDdesm5MiMRaAJaQK3HvFzDd3Mao2
         9V4isxGMmC2yBBzQeHsC5YZDls1NzsnuA9MkcJWJB/TM/gTolma2J26Ye5KQvUA5MjHH
         7bHzCATBvSXp0Vi1ij6ibGXYd4nmZR241kra+6TBuL4NyDm1Jht0Qh/a03zGYfHK2FpQ
         E971bDsl75zhjMpNJ6/lYn1iujfcc4LPG+Rd0qzCtk3rTW7c4Ka/3YKGQ63jh8xC33/l
         rHpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776706812; x=1777311612;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/fwlZkaqAkipgy6piybX/zlZcoSztD08jPD+bFmkPvg=;
        b=nZruQGREKMSe2N4vdM0CCrI88AUt18DAuRfKgcJvWeWcMV3gOZA6zJL3f8W9hy/QHQ
         5EK21HMvl6qr+ygpSjcQWGpoJj93F9SDhm+SBrnfQle9PyQr7iqaAbIvwonFfCvtfeFx
         p1Vnb3NmJhX9acxAK9iSinAr8bOoP8Td+NIxx35ShO+nEfP+4o+Bm+0L57h9wPi5W1KV
         XMY5Oj2tFbJdg24JnGiqBFjzZOVftdcw5j+yHt/d0uTokoUmGSLd471Pgd6NqZuRtBjz
         8iIPN6omuU+mJVaszM2bw/E0Eo3XvWWR6zuwIWmig3Cm6mqtj8Cj21vtSmnlLGSiqqfD
         YXig==
X-Forwarded-Encrypted: i=1; AFNElJ+gPF+qjMBdaaYZy29FpixL2b7kp9kcV2veMDN5vdhFSt5izSAKpyAX5nLxbQmMNNW9xcnbnEdKyA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzns3sEbMKKiWV8hbjztCScT/yKpljFswshwgXu3UaxkdRe9RK2
	nIdYxtpVRsKHGnKeMUxlVanwXWmoTcYtAtVIqGcZOQvRh6e3wDPYnJUu6Fd07E2wGfU=
X-Gm-Gg: AeBDietp5efQbu/3BQFFeTFNTkNyb07pYf5aW6/RDSGZygoY9iLLQJGm8AQCbasiWzd
	ofdCZZlJ7qdwpiX+i71ErivWGc9iyUktiecicbQAyv9BUqXI2nQIv/Ug3/qZOyScg5wJ+exDJJZ
	NYJ70QZ57FFAbh0K7WwkOJzFQIY9JlJpw5FKqBInbsns4fyS3YlLk/2xQhT46UcaBQLQrGFvYvd
	jc3v3qmNVVuHU4WLgHo+bOilHo2PXtQdUo/DaqZI5eX8dHmorpz2cXtUI9wnxvpz/KPHi9ugilW
	v31TJg6IyzbelroazMtsT9CBNA8fcerIVnWOO6D31Z+uw9+I10OOEvx6QBI/Y+D5a11RvehXmko
	i75EVPPRbYvg0KWx9rtu6cShcXymWPG5FWvnTF1x+sl65a2wriwUnPyYJK0n3eUW8IwDQHZfHXi
	ZuMeoH4gnDXDmJQJWaU6j7YIoc+P8B1dNWlIy8UCHF3Rx8+A3DftRlWyiTDT8OFL5868DgfC3yw
	GYNaanhvyPHeYGqkw==
X-Received: by 2002:a05:600c:a108:b0:480:69b6:dfed with SMTP id 5b1f17b1804b1-488fb78ba6fmr175032275e9.24.1776706812164;
        Mon, 20 Apr 2026 10:40:12 -0700 (PDT)
Received: from ta2.c.googlers.com (17.83.155.104.bc.googleusercontent.com. [104.155.83.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb72d365sm144280285e9.1.2026.04.20.10.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 10:40:11 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Mon, 20 Apr 2026 17:39:56 +0000
Subject: [PATCH v3 10/10] arm64: defconfig: enable Exynos ACPM thermal
 support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-acpm-tmu-v3-10-3dc8e93f0b26@linaro.org>
References: <20260420-acpm-tmu-v3-0-3dc8e93f0b26@linaro.org>
In-Reply-To: <20260420-acpm-tmu-v3-0-3dc8e93f0b26@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Lee Jones <lee@kernel.org>
Cc: willmcvicker@google.com, jyescas@google.com, shin.son@samsung.com, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org, 
 linux-clk@vger.kernel.org, Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776706804; l=816;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=b4zN6V69pfC0jSn1B6TPnsLWLax41ajhjGEGhYeLmtA=;
 b=WOxgRvOtzj9KL76srvu0GVEREFLVVJ/F/w3yzCSjd20IjCwgYQ6jiBj/Qn2GHV5jR3DQEJmfQ
 HziKyX9JAqtC2Ws4BV2sIldy6WYYbWuh1/1Pc0VmL0pBFzg1xMme3pe
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Enable the Exynos ACPM thermal driver (CONFIG_EXYNOS_ACPM_THERMAL)
to allow temperature monitoring and thermal management on Samsung
Exynos SoCs that use the Alive Clock and Power Manager (ACPM)
protocol.

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
2.54.0.rc1.555.g9c883467ad-goog

