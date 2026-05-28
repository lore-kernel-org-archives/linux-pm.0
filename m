Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748CF3E51DC
	for <linux-pm@vger.kernel.org>; Thu, 28 May 2026 11:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779968189; cv=none; b=di51bJXE6sKwOVQvkQhvhkTvTdqME4uBeHqCoytLbkMHk4zY65LJpAOsJCahrNg76/z90vCRjJgH5R5/jtP6BZdwnbBF6sG2BGsnAobHkFmffKhJMFjTUO4oV01v880v1N9skk6qF/z35Cm5HbNA2aJGPrIl1vK/3IA8AC4obbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779968189; c=relaxed/simple;
	bh=Aobvj69DN8F6w0+Jb0r9TFQ6oCGfBu7fy/EjQhPy1lI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oj43omDJVEw2OaVgYlhRY56QPF7NVS8qFWdIcb8nhMFOHgbOU5vuDQVCfy5H2/9GaUPgFI6j7L2PerV1zJtKVvTIXpMr3h/lYiEy4mPk8T9tox+CM2PCRuaoonAlW9Aqa8tzmwMFcrNHQXe+h0VP7k8Ab8rqeJ+VeQE2FhUn9lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JS80tqNZ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JS80tqNZ"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48d146705b4so134219485e9.3
        for <linux-pm@vger.kernel.org>; Thu, 28 May 2026 04:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779968183; x=1780572983; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wpUOS+9fsWY0UqlgRlGBSremc/v/5gxyA5J8k3968CI=;
        b=JS80tqNZjTwx+lUJcz3qQiVMLsMc6hrU6LFf9NvYdWVr8mxXyg3rHxnIcJNkOg7OEO
         creHdT/CzuN+IbwOun69wCtQvMuJtT9BEj3Dzc0533ZsFZCSgMLGsvyVJvroiy1EFXFJ
         5AgxNjKVnKnBv6Y3ocT7vso1iCyrGue6okSRqIuFNkUtHDLzpdTcCSndrG/Xa8eW/mO3
         lM/h8kbs5PalzV6AZ1m9ZjADEOuflA2xeZsO54iISgBUxv9XYb5U7wlpYOFU4eh1ugCS
         aw1hm0EXiaImxpkSd2x3KytsgicKWobpSSek9RO+bBQOlZyYksEiKfjT4cOsDvtBxJAr
         3tVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779968183; x=1780572983;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wpUOS+9fsWY0UqlgRlGBSremc/v/5gxyA5J8k3968CI=;
        b=ltRfJDv8xpxMSMWQCE1ypWKvVW0VHIKCMQGcUPT20Owspn5Rug7TMGXuWfCUMAr3xJ
         IzcudJF8xbtjUQUGrlO1Q2uVimV4Jl6SBJIrWwdwWc43efL6lUNRmrrgBUQWiYqhOzES
         ipRXC1Ae0xB0Cfz0WiOgOifJFNwAVze8npofLnSbCncx1w3tPYerNuTsgELbnnv1Dq1U
         gV0Gca2aAT3VaDULX5AwPKSBRDt8NYYVTCxKYiLTq3OBO2Ku2UQ2FLNT3F0mpctEWHMw
         g5Ihpbasc2QwUlp67vqruESMf/dX/CuQSc/x1mmMlvVs0sqrpk/PILqa7GWHeqoQVH/H
         gWLg==
X-Forwarded-Encrypted: i=1; AFNElJ/kIX9OQnrlalIEpvtjltitIrktp8heKfonhCVeduBaqFEaPz51oJMOYqQju+ztbg8LrZhSDwj86Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4XX2aJYKnyc0Ggxl1B4/GaT7U6jZ54OhxiqGhmI4XhUF7c/U3
	CjGWDnotg09CchWjUxY7ubB38ysE4PEHpI+qVzzRvz/ASspPCKjegcKp5k6uBmoSzdU=
X-Gm-Gg: Acq92OHqDDCMDmXQgcR+89fWXVfxN/tUrEJxngZsXpsGl/5cufVg+gHhkUdUtcQ2B9W
	rliapaO/msc0GNKdrXu6JnEja1vpXfipjB+MwwpO9bosrjXKnxd5x/MA3TytPzAGPcUt6qRdf6Z
	HgnRcrChZyjEVyMD2oOJIL+Q4KQcNtkK8mVFnP416v4Q27Jw5M+fqa62K+i0b0NOVPGouWx/OHT
	wDnEuEmS7B8iVAqYGLxLtZhmcPUAHBvA0CcY9luBY/4orPs7iNXpU47HtZHJWdteq53KBXiYFyL
	S5JeD293WwdfLyj2WIJaEd9+DtPgS6/aVKw2HnZzybDtBJDk6KoJB/7hbdtJAF9wx6KLMUA7PC8
	6mqAVPEr0f1Ez1SNhxdkwiW4viHT/hf9cJznLpieZaj1Dv9p0y7tWSKPIkjGi5KdF7xVV403qeU
	aj9POL/CKdpY+pZNpxo9nrtCEX3ggPh6nKodvSTe9BqLJa0y9C63q3tLvsq8wdchLg5JPIOw7Us
	fM1n9tuIZy1hL7Znk8Ytlgb8vGS
X-Received: by 2002:a05:600c:8484:b0:48a:906b:14ca with SMTP id 5b1f17b1804b1-490426cd8c4mr466725355e9.20.1779968183364;
        Thu, 28 May 2026 04:36:23 -0700 (PDT)
Received: from ta2.c.googlers.com (231.141.38.34.bc.googleusercontent.com. [34.38.141.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49092a902bfsm60385715e9.12.2026.05.28.04.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 04:36:23 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Thu, 28 May 2026 11:36:18 +0000
Subject: [PATCH v6 5/5] arm64: defconfig: enable Exynos ACPM thermal
 support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-acpm-tmu-v6-5-b4d7ce57594b@linaro.org>
References: <20260528-acpm-tmu-v6-0-b4d7ce57594b@linaro.org>
In-Reply-To: <20260528-acpm-tmu-v6-0-b4d7ce57594b@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779968180; l=794;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=Aobvj69DN8F6w0+Jb0r9TFQ6oCGfBu7fy/EjQhPy1lI=;
 b=IrVw2lxVCkAd6zW/JJPCyuIUKwWUWmwU9qRVAfB/8ZYIYZEo8nd4c6wq7R9RZmeF123hMczZw
 7EaqfiU+KYjBsr+EB35bTx2qZFhGyzz8N0BhvF5UIvxX1zl1H7Zm7/j
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
2.54.0.794.g4f17f83d09-goog

