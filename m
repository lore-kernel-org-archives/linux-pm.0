Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F3C3E3145
	for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2026 15:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773847686; cv=none; b=aZIf/n0VJW8U1AfuD12M5kqBbegpuy6y2DdXMMsBafz/vF1L4F/mIwUvmSFlk/LkJPWqmmhG65eQMnodN8IQCTfLF/ENX/J7FdeF3gEUuYKyx4gPrCpkwbJhqGl9XywLrJwxvMDKJxYdjHmwlcJFGUpvWljgH+xnF8v6pu0I+Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773847686; c=relaxed/simple;
	bh=bANrr+Wq+QpSWQ7fIpXKRUfezFgMImbXTooKuFM/BqU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nDddMrp2ugAsYEPCZly0tgVxDnxQglacsxIjXM0KxHCuN4QwLX0VKyPJE2vbWgYAY2bQSpj5VzRy78r+yTdc0oMEHTM9kO1NCkWaSl922DIjkTHtHl1bfWqMbc0RmyCn9SqP8YG7p1SJWMvooTyVAPx8NIUBPKRBvuGAedTpZmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=witfuG3f; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="witfuG3f"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b97a0f18a3aso566584566b.1
        for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2026 08:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773847679; x=1774452479; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=94oKRwhTxKOCc5T6avfbasAgA93RZvczT3rsQ8lQehE=;
        b=witfuG3fxBsLThwRzY9q26vmPLPUK/DXQKxWj0JH7eQzzRBi3SKRfcHopueciSUeT0
         ZYhH0YxpaAYTPlLJniwf1ndJ9eKYqPmCEpR+gB8zG4TZR6wTJA7I/lf9B62/pn8j3XQB
         cKsjZI5LehJ+C3qE4MICBeisroKUWE7hDGEGIGulVS7Dn/OfpX60mmHztE7z9+aS3/LH
         w+/Whd+dLEdWQQixbRg+hVW0ovV4NKnaUdfVKOUoxSv0M8ww6sWc/PujnSTTXvf/v4RY
         ziLVTFRqeu0NaHyfZ70DpQl2JaIaNd/F7FMoiIOqwTjacAf1rwtG0hTWzrWdNMkx72Jc
         6NtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773847679; x=1774452479;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=94oKRwhTxKOCc5T6avfbasAgA93RZvczT3rsQ8lQehE=;
        b=go0Tg+JMTzxfN00srIb7/E0sR1BDxvP+KcVyqs8dfZxUsTyp57IIUHfo0YeeNNWdLt
         Dmq0xmjk/iPmfAAni9Kymjtwxndwim7jOOovFMQB8Oi8ZZZ8OKApzIzPgRaik1ynKEZl
         s5okt/4BEXzEOzfSBcrH0CFARNHPW9jKPlsn8LgKNZSnzM9GWD4xcCuqS0KAwaWcfq6D
         CuT3JhiZ7UtnRGorvK41G+DdBquWZEDzqhJdLnAxWkmYFHLq7sD+LRRwiE5LmAlQZCcH
         cfjgh1Hrjr19g0Kp4FfIVc8ZwgIjnJpxn6c85ygZP7Bir4O7nAbR3D8VekcliFTMKb1N
         K9Wg==
X-Forwarded-Encrypted: i=1; AJvYcCWfprzwTFwdkBZAZ7sKvKqMxdTGtEBcrd6wb+9g64Ud9i4HAKYF68EtHApPNBxK2OCLuz0Qcqr97g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxfIy+oSkQsNijAEXDpUlNb54CVj6z1AlYKWSoc4RPVt50Ts67j
	znBmJkYZageYb+xYLtB5PsMpVUVUoSpD2VUMIe2jknjrl6SaMup0MBFEBXL+6Nc1g9I=
X-Gm-Gg: ATEYQzy+WU/mzBtwVPC0QKA0yZDjcqjV94IvvELg+jpugmfrbClSG6l+vI/xtyB45rP
	g5R3MzRm4Knxy85DA43IbURtIZHXl54lYR+SDj7ANOnDFM/KjYf3qzLS6q0PAqYaulZH5Ofc/Vw
	LtO/Duexi1Copvkz8bvZ2zyQlrG3QiKSj0fMcucwSvDGSplNc876X+JNsBOT4gCwW1RfIwT7jt0
	GcFUAPdfTj7pJ70s6GTOFgaqRbLm9TBFJg5JiaMyzV7goi4w9+HlPxrbqAoSQ1ZPwR2SPwhLMs5
	kVUoyx+4Wlb97dGp0K7B8PceD4JSh750YGrLNnkfsM//ivYAzadDiyTDf0JyrepbsmBUsj2+CPC
	7vl2T5iDYWBvw3lmqlEDcRijMtGDQe9zbwVxBGyiiUIqqmMgY0qm1APkz1LY8ABMLidug5vRYj2
	7c4w+r9fQK0jvzEiK4IqDidYWLmYLKbmCDr6qcr+qSGJLf9NEDKwJktRLtd91olvq4QaUNvg8qM
	A0WuZeklRANij8=
X-Received: by 2002:a17:907:bd0:b0:b97:61e2:95ea with SMTP id a640c23a62f3a-b97f49055aamr164540766b.20.1773847679098;
        Wed, 18 Mar 2026 08:27:59 -0700 (PDT)
Received: from puffmais2.c.googlers.com (221.210.91.34.bc.googleusercontent.com. [34.91.210.221])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b97f173a3e3sm226989566b.61.2026.03.18.08.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 08:27:58 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Wed, 18 Mar 2026 15:27:46 +0000
Subject: [PATCH v8 01/10] dt-bindings: soc: google: add google,gs101-dtzpc
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260318-gs101-pd-v8-1-241523460b10@linaro.org>
References: <20260318-gs101-pd-v8-0-241523460b10@linaro.org>
In-Reply-To: <20260318-gs101-pd-v8-0-241523460b10@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Juan Yescas <jyescas@google.com>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.3

The Exynos Distributed TruztZone Protection Control (D_TZPC) provides
an interface to the protection bits that are included in the TrustZone
design in a secure system. It configures each area of the memory as
secure or non-secure.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 .../bindings/soc/google/google,gs101-dtzpc.yaml    | 42 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 43 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/google/google,gs101-dtzpc.yaml b/Documentation/devicetree/bindings/soc/google/google,gs101-dtzpc.yaml
new file mode 100644
index 000000000000..a8c61ce069d6
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/google/google,gs101-dtzpc.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/google/google,gs101-dtzpc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung Exynos Distributed TruztZone Protection Control.
+
+description:
+  Distributed TrustZone Protection Control (D_TZPC) provides an interface to the
+  protection bits that are included in the TrustZone design in a secure system.
+  It configures each area of the memory as secure or non-secure.
+
+maintainers:
+  - André Draszik <andre.draszik@linaro.org>
+
+properties:
+  compatible:
+    const: google,gs101-dtzpc
+
+  clocks:
+    maxItems: 1
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - clocks
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/google,gs101.h>
+
+    dtzpc_hsi0: dtzpc@11010000 {
+      compatible = "google,gs101-dtzpc";
+      reg = <0x11010000 0x10000>;
+      clocks = <&cmu_hsi0 CLK_GOUT_HSI0_D_TZPC_HSI0_PCLK>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 6358dd7f1632..e8376343935f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10905,6 +10905,7 @@ P:	Documentation/process/maintainer-soc-clean-dts.rst
 C:	irc://irc.oftc.net/pixel6-kernel-dev
 F:	Documentation/devicetree/bindings/clock/google,gs101-clock.yaml
 F:	Documentation/devicetree/bindings/phy/google,lga-usb-phy.yaml
+F:	Documentation/devicetree/bindings/soc/google/google,gs101-dtzpc.yaml
 F:	Documentation/devicetree/bindings/soc/google/google,gs101-pmu-intr-gen.yaml
 F:	Documentation/devicetree/bindings/usb/google,lga-dwc3.yaml
 F:	arch/arm64/boot/dts/exynos/google/

-- 
2.53.0.851.ga537e3e6e9-goog

