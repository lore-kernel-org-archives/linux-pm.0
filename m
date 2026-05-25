Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2946A3839B6
	for <linux-pm@vger.kernel.org>; Mon, 25 May 2026 12:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779713438; cv=none; b=ql24OCLtLoSZfpcRf4rsdvx7Pb888U6uWPq24l13Yp2FdkR6D/Wxp844CNz0F6Xw4C5YnOxyRMnQ69pfUGHbD43kuJNYPugHV8AIXvpSD9qKiKjrb1ZqizUArybPy40UO2k5Uk4QmL9FKXegcWqza5Sg4EytrHYgcpZwJZiGu4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779713438; c=relaxed/simple;
	bh=0Frkhb5ER+1m5KgNQbdP8ycXkPjLHDxA2xf3r2hyTAM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jSh5pzJStH5dxDdmH+wyyPMAL30y06vet6/p0mYZctV9cK19tL9AOuYVk2cm5hLiEOrFFBVoQvhpjhazYKI6IIlde/oXt3ODJvLpPYuQPDEKEeBPzDENHVUUf+OV7ZBP4RxK/3OGKjr/gYNdNLfGMej3tw6XAU6EocRlG8XbWN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yIxY8eQv; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yIxY8eQv"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4893940bb5eso51442215e9.3
        for <linux-pm@vger.kernel.org>; Mon, 25 May 2026 05:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779713433; x=1780318233; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5TsR1mX2wHDSgzQPfx51FzMucuFNRcZzEimrpeG8plE=;
        b=yIxY8eQv1zNZpTK9cX+t+xCVFvAIkajwDUJOEOPxmSg4NUh5fd2UjGCwvS50qsx9sw
         NZykrXPFGScTThOGNFFpUHKqCxPBqzxNY9LLh6utBzoh29FLkJxqLrlPdZd3uzwl0ad/
         zUK41dZ20AXxm/ZI0nBACI149mT09fQCBXjjlFicscuO6HhmktldWp+89jsqo2XWe1im
         Zh/TPDEeeySU9DSWusWnCNmFDrVTtguPl0NvmDIFmTYRu9OxZUxuNCeVSafu9RK53VBJ
         DwfnVJ1v9tgmY0YVoMVLwy3s9w6z1/9mwop91DoydcXpaHGh0yn2LCquwXD/hmfCu+K/
         Ebyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779713433; x=1780318233;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5TsR1mX2wHDSgzQPfx51FzMucuFNRcZzEimrpeG8plE=;
        b=VW5OYu6MFvikWEPpg9+9DH/0mzgL2oEujO/SHEdpbzwncDypvFwBC85AnaeHdkUKx6
         aGjD/ai1IW8UoZyVRGPynkJjL7JZ6RbV7a7orp80dOPh/RD4IKKwp/hS5fdL4L6mHrs3
         u5udQk8NHlK+8Yz12CxV//0tTRdYVk1PCRGnZd5EKDRU+TEZ9ZI6upAxavBok9lURi1O
         DkMePDcWVrkzYVDEShvr70MfU8N74gvtMxFKH0SgPttMC7xKdDnROkfrmuCw3X0XKjM9
         yfQ3A8SrQZlepe9IIInv8UtHvNc87BV4JaBFxWIs/q029PIvRtLB4ZRfLsqhj3JUf/Xl
         KlMg==
X-Forwarded-Encrypted: i=1; AFNElJ/9Ax04WQ6KfPV8IUNkFBs9tCT+hDnZLmw+m9fDdTYKu7+8VoYZed/O0ezXv8Zc38QMj4PknQlo/g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyHFj4YSTwLfT3Stm5HwcnlaquuxsimcZ+MDceKTKZwgfj1+Gfg
	HmsbwPDyYv/tUeuR/UuDJFUFRYw7iUAQACfMHmTAum44w3X4cZ7SeMNjBxzwrecI61w=
X-Gm-Gg: Acq92OGeVLMU8U3Tkt2PuFHUadJ2wq/AsW4jwbqfUEyIJ96+piuE2FNNLf1445Pr6Jz
	mRkycDsgXg4ue5xWncV4MNZ5QLkY/s1twc+oTnzdQDaCaNxOMIMBkAn/ZOzQfZgpc/p9Tpo80/Y
	fV0ycjBu0YsLd4bM0Q7/VtSt+dSwuUezaGJvYo2fPlKKdXQWZ1hEy5SFS0fEjQ+WadCNau55hPh
	rseCeMSZ6CroIEiLrkbLVhHdKolQeSMdOc0l8nIuGCJF3r1XB16LOo1FxTR6dBU5x4kPrij2Pij
	1jCkignOYGw02N31AwX8/Jbs21+sMzJfVM8qiPdJoCSfwn8Gor9BAn9R8AmL2jgLvNPhMdDBPYH
	zw/4tI5CiSdqNgNPz7HkYxQ4iCObNlla3Ymu+375zH6moRjZJHJAykmmwsYrN9u4jxBK0f8UciC
	n99bnlOUqQ4XKJRS14ELzH1ykEx8S8yCehd2VZNRz09K9TuWWhKcv4N8QdplOChIp6P9OZxJAUj
	3VCqXVXqr+weMlkWA==
X-Received: by 2002:a05:600c:a30d:b0:48e:5d91:cfe3 with SMTP id 5b1f17b1804b1-490424ac7bcmr173716725e9.1.1779713433180;
        Mon, 25 May 2026 05:50:33 -0700 (PDT)
Received: from ta2.c.googlers.com (231.141.38.34.bc.googleusercontent.com. [34.38.141.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454cfcaesm241824825e9.4.2026.05.25.05.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 05:50:32 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Mon, 25 May 2026 12:50:25 +0000
Subject: [PATCH v5 5/5] arm64: defconfig: enable Exynos ACPM thermal
 support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-acpm-tmu-v5-5-85fde739752e@linaro.org>
References: <20260525-acpm-tmu-v5-0-85fde739752e@linaro.org>
In-Reply-To: <20260525-acpm-tmu-v5-0-85fde739752e@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779713428; l=812;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=0Frkhb5ER+1m5KgNQbdP8ycXkPjLHDxA2xf3r2hyTAM=;
 b=ysDvGnb5sGnYo8XyHtqcLtMEVBuxYqkwONOnmQLPxdEJXX+Z8JRyBK2v1SJeQkFgvjbrITrcE
 +ypUtdm16g9B+l1i2lE9lC28ZQzQWSfcXVHHHo8co3aVihoSxuORly3
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
2.54.0.746.g67dd491aae-goog

