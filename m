Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB73D38D006
	for <linux-pm@vger.kernel.org>; Thu,  9 Jul 2026 01:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783559438; cv=none; b=MSkQDANN0B48+7oBfNsl4rbl1ut4lbTWsdu8RfXt6qwf+iI3jtpDee/+PSeW3sH/5i5cmjlk6Jk8PdJpTjiWM/qCbICivwMnn7C3UxEQMlXrWzX+vmiPEuuVSttx6YZWJpZpqwwaZ7eEfohG/f+Jk4Y7lP/Vo6yNs15mxk8uBJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783559438; c=relaxed/simple;
	bh=s1AKyzoSxxIvdhYYPordthXUPycyeTIy07faFZKS5zg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pg03Bo8WeUKe/59OdHHLakN7XxdhkPSY/EwAyd9nazaz4USjZOmGEVYbCQZzqf3SFeujFlEBhsPfkoFW+aM6CyDiBBbsE9wC/Uckq8mIjMb2P/84LbYhqLVn7gbyVb+VKTFoon49lHnLGOs3hKN1lJVL1i4u2trOW+TdddFGOsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VX/Z2DfC; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VX/Z2DfC"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-493e497643fso7045225e9.0
        for <linux-pm@vger.kernel.org>; Wed, 08 Jul 2026 18:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1783559435; x=1784164235; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jq7X/6sAn2Z6bUb0L/rtYSi5kwwPRvuB+ZVyS57/4wU=;
        b=VX/Z2DfCoqvjm2owhRY6CxUoUTERFnSDdXkeEny75dtIlSRWA2uRYokSX6qCShaiQf
         69PeL4/3OtdoyJ5uMe9aCJNl+iDZ84I1gqGktlF/hMGHJ1DzPkm93zNMmPsQ9WqLbma4
         Fbejp2zJCQw1oS7TpV9p+YVXi70IJuRgmQgrMTdghRlwNtwy/3UlMMIU5rXn36VT5DnJ
         XPr9cx0TNgwwF2ZjLTMzl9mZNwJlHYSFm2GA4gZtP5f3+ND2XajrstQ+J0/RDNFde4xa
         F5UOMn4LiVlSAc+aytAeu8UnL2Varnil0Iqzi0PVG5b9huFcxrr3KImYzYXfNyvI71SX
         qGnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783559435; x=1784164235;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jq7X/6sAn2Z6bUb0L/rtYSi5kwwPRvuB+ZVyS57/4wU=;
        b=csAohxU/yoBqW7HO0fZiJo95Yae3TfZVnKywCaKTmN+juIWJVHVER8HMv1pMZQ/la9
         ciQ8wyJ9kM8xRFf1QZeeZauM7Q5XKSm69fM4mqg6W0uvFPNrxQABjTqSOlr4064GlGH5
         vVNz+dSnM+vbI0V8G3QdSLTvxapx0ygCVuPl32aLvqfK+LDqWdlFK/Rin/b70+kCkFwU
         KKjq2DlRn3NKP3yC5b5KUh75IzCLTL8HKubJmP8kkrtl6hmmAawyJZS0MY/axBxdngZT
         G3qeyzG5nD4wKEElJIlyWT9j4ZragvqbudCuA3WVFuvro8CpdrZEIl6JbIwYUVFrj0hT
         04Mg==
X-Forwarded-Encrypted: i=1; AHgh+RplM/7djP7D+h2fP0PKB/kw3/JTmLZ/G+Y5fuz6Pm5t6TX1cGM70tejo9QMyLVKvyQpdFMg2pRktQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxCqk6bfw9t3FnoFK65976I0KNT22YEmmi1UrnxA73Ics0uJkox
	GULOPW2VuWYZyGB/mUGXVTkggR3WwnSKiLWXmrg2+YIIYHFvhi4Hrq9cGwM3a9O9eQ0=
X-Gm-Gg: AfdE7cmAdt1Nl+Sa8AAxzxf0dsQLY6K98Hezen5rlbiQJy1q2Vv87G/IUOCDWVPGWR/
	SzoAWJbebNv+0UO7bFDolBVbIWZoFUW3q5qcKRvLXt+ODx6wo7zJVP64M7FY7pA+MTPxPF0pqD7
	OPWh0V7WffyQwDgogqnQen1hBRowYNAcn0yPisc2w54AtpuoKVzSsWbdiNiXcW1C1Jr0AZ+IVdW
	/ma4Js9P4zK0F/bdFSCtOvcjnui7XAL8Jg4XZFk5gdJ+XvHlvv3Wcm2AGxvUc+G2jFfz7oSdH+/
	Tx0U5fprfunI2Ps+BjE76pQ3nWwkel9d9OeWEY2+5JwZcOeOCpSZ4NournznJxQGGVs9idCFzgo
	Mrtq2GGwqoMvE6KM9Q7BWA0cAFWwG7XoDQsZMsiUZr9aemUgEnL5cxW/uibCLjhwGYHqwoHeqSV
	iaUEeXMbW6lLY0FtoRZOdgo6Aya5r0+ZbCjY1RvJmJrW4puaJHH71ljyZtLNBwV1N2eqIfvKyHp
	pPw
X-Received: by 2002:a05:600c:34c3:b0:493:bb29:af40 with SMTP id 5b1f17b1804b1-493e689b37amr57409965e9.14.1783559435205;
        Wed, 08 Jul 2026 18:10:35 -0700 (PDT)
Received: from [127.0.1.1] ([2.122.8.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb742d0esm18994725e9.13.2026.07.08.18.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 18:10:33 -0700 (PDT)
From: Alexey Klimov <alexey.klimov@linaro.org>
Date: Thu, 09 Jul 2026 02:10:27 +0100
Subject: [PATCH 1/3] dt-bindings: thermal: gs101-tmu: add Exynos850
 compatible
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-acpm-tmu-e850-support-v1-1-9fdd58b634af@linaro.org>
References: <20260709-acpm-tmu-e850-support-v1-0-9fdd58b634af@linaro.org>
In-Reply-To: <20260709-acpm-tmu-e850-support-v1-0-9fdd58b634af@linaro.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Mateusz Majewski <m.majewski2@samsung.com>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alexey Klimov <alexey.klimov@linaro.org>
X-Mailer: b4 0.14.3

Document the `samsung,exynos850-tmu-top` compatible string for the
Exynos850 SoC.

Unlike the GS101, where the ACPM firmware handles most of the TMU
initialization and threshold configuration, the Exynos850 firmware
implements a significantly smaller subset of TMU IPC commands.
Consequently, the Application Processor requires broader direct
MMIO access to initialize the thermal unit, configure thresholds,
clear interrupts and collect calibration data.

Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---
 .../bindings/thermal/google,gs101-tmu-top.yaml     | 26 +++++++++++++++-------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/google,gs101-tmu-top.yaml b/Documentation/devicetree/bindings/thermal/google,gs101-tmu-top.yaml
index 75560ebca48d..bea208cd4619 100644
--- a/Documentation/devicetree/bindings/thermal/google,gs101-tmu-top.yaml
+++ b/Documentation/devicetree/bindings/thermal/google,gs101-tmu-top.yaml
@@ -15,17 +15,27 @@ description:
   both direct register-level access and firmware-mediated management
   via the ACPM (Alive Clock and Power Manager) firmware.
 
-  On these platforms, the hardware is managed in a hybrid fashion. The
-  Application Processor (AP) maintains direct memory-mapped access
-  exclusively to the interrupt pending registers to identify thermal
-  events. All other functional aspects - including sensor
-  initialization, threshold configuration, and temperature acquisition
-  - are handled by the ACPM firmware. The AP coordinates these
-  operations through the ACPM IPC protocol.
+  On these platforms, the hardware is managed in a hybrid fashion, though
+  the distribution of responsibilities between the Application Processor
+  (AP) and the ACPM firmware varies by SoC.
+
+  On the GS101, the AP maintains direct memory-mapped access exclusively
+  to the interrupt pending registers to identify thermal events. All other
+  functional aspects - including sensor initialization, threshold
+  configuration, and temperature acquisition - are handled by the ACPM
+  firmware. The AP coordinates these operations through the ACPM IPC protocol.
+
+  On the Exynos850, the ACPM firmware implements a smaller subset of TMU IPC
+  commands (mainly temperature querying, basic TMU initialization, and power
+  state management). Consequently, the AP is responsible for register-level
+  access to initialize the thermal unit, configure thresholds and handle
+  interrupts via MMIO.
 
 properties:
   compatible:
-    const: google,gs101-tmu-top
+    enum:
+      - google,gs101-tmu-top
+      - samsung,exynos850-tmu-top
 
   reg:
     maxItems: 1

-- 
2.51.0

