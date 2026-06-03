Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC5148097B
	for <linux-pm@vger.kernel.org>; Wed,  3 Jun 2026 13:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780491625; cv=none; b=t0qrz6sd3TrosXUKaONTDieOtWsUryK2G2xiT7CwHZMFJx8r8sjcse9gpGc8B46XPWLRoPEgAJpQilBK2M0VTac4OFWLvU6uC3u9ceGJpudGhmuOStHTF34ydNh5FGqAQAAEjTOj0fNiLA4VPJR9uCuSCeM2q7Y3blYtQdDXkpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780491625; c=relaxed/simple;
	bh=2NgviHNZdxpicEM9rd/dWgHY01rnKmCVPlo7M+lrE2E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F2nOCdZVgMSOqN267wD1lByOoKfiBJ5BcZbBt5DSvb5HEVWJsMZkCc8WrjvuDwesU+4xjgdDOfYOayUeIdeiQ7j6kF5vT3OTjs9XZZx5YCc7PbWvDRSb+AejR+qEFR0TbDv+twGeHLN3r+7mU3GzXDbMXVn2T75WxOWPvPlv4NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Rt0XiKF/; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rt0XiKF/"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490ae94a89eso27456835e9.1
        for <linux-pm@vger.kernel.org>; Wed, 03 Jun 2026 06:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780491619; x=1781096419; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0UJRcwfUx7m4tQO0H7dzGL7l03jX+wNFvSSTwQ2iw18=;
        b=Rt0XiKF/kE2Bzaw9uZMtgERZFKaVVkutUoZUlv2H2DzvyWIhpwxFu5kiQE253tLuK2
         uKRe4WXUCRlQ4x7DJS1/ov55YulxEz77HnMsjmSnOtlq54uz7yZhApop5Ae/xGyF3WFn
         w7OBOfLMd25jOrEm/48kv683bmcussw48mH5HwvUEyVPpMFN3WVUgQ170cFn7KoQaNAf
         UOA+PZw2+xMExxf1KAvR7W090Ic+M0o0Ao03t0czuAkzG5PmXwRgoJoO0oNhj3StiI7f
         oIHDXNk5f8aoW4lF8FyyJLibQq2GXnaS+tX+TCFPrxyNYzISAcKMD3SI+ZJXq0VcCqL1
         l4ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780491619; x=1781096419;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0UJRcwfUx7m4tQO0H7dzGL7l03jX+wNFvSSTwQ2iw18=;
        b=pqlOS+4ZZpQHiMlml6kbTzhB+BmHAqL30ipp424hVJjpDYznWW+RgxCL6BxyF0Z/wM
         ZRLt32735KLLRgR3wBH5joBcKQ/G0pgoUZ8knsoru2LGlHdiwlFBJKs69It7e8y4x0SK
         UeMru5WXvkznSEMwbTyI9Tu6c+2m8pBAH+yH66AaIqSNaX7WC6tIJxmMUjHoyULfOyzR
         3qzSlwRN+jvMNrNQ1oYBLuWrMKzzzBCyI+HXmqj0dBdCGrCvhHosF03krq/WVhNPSaDK
         RKwCmUEQxmmfD2IG3jVL1WWy5KKNomQ/xdLN7l88SDYFK/xPWLX//JID0qz/QOioVFjw
         R5pA==
X-Forwarded-Encrypted: i=1; AFNElJ8pI2Y+v3QeIPC2VsalRkm5oxqw2g6vVet5EciAUpDFDweD0xBb+6GT6MYle76aFhFpXbay9lG38w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyX/ZMj9w4nYkxDteubDNBWN0jMq0myxBwsfHciIukLEx2LREvI
	KCaUwxwdmON7iufnDfBx8fFhfZtcc5zKK6hFKnpsbCL0NlfaPmimnA5IU3FAe16U6d8=
X-Gm-Gg: Acq92OEkxa6JUW2JreRgZOUG1iN6dUHset8mfyGuQYMjgPE6jkNLGiK+2n9WemiWsHo
	jNECbpLahlPXfz5LomxI5kGNSJO+URlTfkEufJZt8cdqVWUIlTbEfO4tD1km3sWyr8BDWJy09Gj
	L1wwvg/gwQr+VILbm2rkLKSbeifKhWSFnQK+gB4lfYYutAkamPHhUwF5UcfvJASebDr2xiaG6bf
	Q99JBQz4cN3pDkWA5mGwA6X0G6zwLZDQpZNVdi0aMvm2BsjLaJiPpE/PQ3ddx6QzacUDOACzG5R
	lZFpOuwor/+IpHr8qkzGbNoyPMtrUPbeT1UI22Kvzohf+Y6m003sNBlN61+RhEzlRd2FVZ2t56/
	ajGcyzrHmv5B6h1g2atw7P/TuDnR1Q4DY/hTYpwt46BkQE38rKwgkJoty51y2Ea2hawpTPYvaJX
	PRhFDP8PlNtSkQonFxGDDTbPk7OIiCefQv795Vb+SU/nuv8CzjvkHW5UMPhxXwM3nIRb/Dj4Hrj
	pOwe0q4sXiU+0E=
X-Received: by 2002:a05:600c:314d:b0:485:9a50:3370 with SMTP id 5b1f17b1804b1-490b5ead1b7mr52139485e9.8.1780491619214;
        Wed, 03 Jun 2026 06:00:19 -0700 (PDT)
Received: from ta2.c.googlers.com (213.53.77.34.bc.googleusercontent.com. [34.77.53.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0e88fdesm149179045e9.14.2026.06.03.06.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 06:00:18 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Wed, 03 Jun 2026 13:00:16 +0000
Subject: [PATCH v8 1/5] dt-bindings: thermal: Add Google GS101 TMU
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-acpm-tmu-v8-1-0f1810a356e6@linaro.org>
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
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780491617; l=3395;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=2NgviHNZdxpicEM9rd/dWgHY01rnKmCVPlo7M+lrE2E=;
 b=iPBfwCGJRkej/sxT+TtxA4HdlGWcPjWO694Z6qcPCKaUvKC1gLbqJWYHQRCMrbAH+I6HE7L1Q
 N4obNagGADtCS7KOAAHw3xE0kMuWt1vS+m5IVmg4jZfk1fneqUkTrV/
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Document the Thermal Management Unit (TMU) found on the Google GS101 SoC.

The GS101 TMU utilizes a hybrid control model shared between the
Application Processor (AP) and the ACPM (Alive Clock and Power Manager)
firmware. This hybrid ACPM TMU architecture is also present on other
Samsung Exynos SoCs (e.g., AutoV920, Exynos850).

While the TMU is a standard memory-mapped IP block, on this platform
the AP's direct register access is restricted to the interrupt pending
(INTPEND) registers for event identification. High-level functional
tasks, such as sensor initialization, threshold programming, and
temperature reads, are delegated to the ACPM firmware.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../bindings/thermal/google,gs101-tmu-top.yaml     | 69 ++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/google,gs101-tmu-top.yaml b/Documentation/devicetree/bindings/thermal/google,gs101-tmu-top.yaml
new file mode 100644
index 000000000000..75560ebca48d
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/google,gs101-tmu-top.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/google,gs101-tmu-top.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung Exynos ACPM Thermal Management Unit (TMU)
+
+maintainers:
+  - Tudor Ambarus <tudor.ambarus@linaro.org>
+
+description:
+  The Samsung Exynos ACPM TMU is a thermal sensor block found on Exynos
+  based platforms (such as Google GS101 and Exynos850). It supports
+  both direct register-level access and firmware-mediated management
+  via the ACPM (Alive Clock and Power Manager) firmware.
+
+  On these platforms, the hardware is managed in a hybrid fashion. The
+  Application Processor (AP) maintains direct memory-mapped access
+  exclusively to the interrupt pending registers to identify thermal
+  events. All other functional aspects - including sensor
+  initialization, threshold configuration, and temperature acquisition
+  - are handled by the ACPM firmware. The AP coordinates these
+  operations through the ACPM IPC protocol.
+
+properties:
+  compatible:
+    const: google,gs101-tmu-top
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: APB peripheral clock (PCLK) for TMU register access.
+
+  interrupts:
+    maxItems: 1
+
+  "#thermal-sensor-cells":
+    const: 1
+
+  samsung,acpm-ipc:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: Phandle to the ACPM IPC node.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - interrupts
+  - "#thermal-sensor-cells"
+  - samsung,acpm-ipc
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/google,gs101.h>
+
+    thermal-sensor@100a0000 {
+        compatible = "google,gs101-tmu-top";
+        reg = <0x100a0000 0x800>;
+        clocks = <&cmu_misc CLK_GOUT_MISC_TMU_TOP_PCLK>;
+        interrupts = <GIC_SPI 769 IRQ_TYPE_LEVEL_HIGH 0>;
+        #thermal-sensor-cells = <1>;
+        samsung,acpm-ipc = <&acpm_ipc>;
+    };

-- 
2.54.0.1013.g208068f2d8-goog

