Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E79E367F4F
	for <linux-pm@vger.kernel.org>; Thu, 23 Apr 2026 15:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776957783; cv=none; b=LVpmHQuYxMElMs+rQCA/EkkGWim1CP+yjZLOqNfHbtkCD+9dyBufj/QdyYfg/RQR1nmJIcDSOMW1eL1c5wK5ZwziaKzg4ouUjyj950Ces+zDC6mqNFZH6ArsP2FbegAJmkBTDOZvAeJDtfTp/5H9ZlDCrppNQHZ/WnMu/I2oACk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776957783; c=relaxed/simple;
	bh=DUqmD7ypzAi56hF5Rjwm27fjn6fmPFxHtwOu1/9raE8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rAjR/qDhgbV7Y5wqRCtz2GVzhgW3DsY3Rb+RO2wrfGux9DpNtC0QgSZtqfoSkJKJJPhI9ocf6b80fwpItwk4kyBKo+oAPY10lZOSyj/rHU2uH6bhWbKmzGp2HU9NvLQT1CmyBSmw4l9X7BGk7wEWRnVOaU7lMj8E1IU7kqQ+YFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ck2aqFEG; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ck2aqFEG"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4893940bb5eso30194365e9.3
        for <linux-pm@vger.kernel.org>; Thu, 23 Apr 2026 08:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776957780; x=1777562580; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eQd9HkoufNSOLhuozcm6yh3/OjVqgZubRjD9rpq9iNY=;
        b=Ck2aqFEGjVZhmCjDJY2NfhhpSfB/Kad+p2K0ejR+OP3X1dVJAao7KU5Z1lAMTKh8Ps
         e1pH1JPXkDFW+FF9+iU5QZBq0NVj7JtZntRnFzjADXqeUD6WqCZ9cdARV0NSzW6AvMd8
         Vu4xyV6zgLmP13LO2pVi3WMifyTXqNy5zvRyd/ewo18x03HXlBcKtca7ChXuNuxf9n9x
         8pir36OTpPEpt+aZJkWvfg5gwkzmtYa9eS1UrXKVraywIgjA1/B9iU1M3KU4+F98Qo0K
         iNiqHktU+efYNDOQprVkRYzEliTZiiRCHYA9A5ll9hkrlfzwlT/on3hQlG1VDY1mLHn/
         PRcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776957780; x=1777562580;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eQd9HkoufNSOLhuozcm6yh3/OjVqgZubRjD9rpq9iNY=;
        b=Gp2tNEooKAHBUnEWX2/SZuLJ1VGvDci2D/k7WQFNoQdvjAENGqSOp4jCBGJdO3E0gV
         wx4AIDN1JhRjiOXQEG+KFZ/kwCSSS3pVSueS18LImR+GG/J4p12j7KT53Pz9CjdyS5HU
         x5MrdMux5XF3dTK++xxokdIZGbgEkX/tDFuJglA0xbChunjl0mwDzU+FYIyjSzntYISG
         J3I9/KeYBV/idATssa314ygBlYsGWIk/ic6JWLJ+1ysgBbmHNzDq4f06mzjrZAor0lDL
         AV0wCWmxySeJjlWeyvJLNUAnJlDXx/eUrv8aAOcr74QSkDnlbhVXw+hQIMxFhy/e+0Rx
         ceJA==
X-Forwarded-Encrypted: i=1; AFNElJ820MMCaUVWIlshVMV3BjWf0Ks/gLCZcRKBhiIVssDGETuLGb3VDz4Mw2llVvwi8Myg2nonMA8u8g==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl4FbZF6AAs3vaaVR612Mzrui4v9jYwOQMKHymCXVDrNeDJQZY
	LSam24SgIFUnnJp9swDztlwuFQMqYbV8yY2fagr1uvLZoXWCaQV0UBAskXfaRRD5ovM=
X-Gm-Gg: AeBDieuKWtcjKx6fU74nV5f+pVe0RCc5b3hGyA8Gcx9m3vHtHx1/FQpy+XYH0gbiRGE
	fXz+1QluXJ3dd2sVAINQZNSM0FKfR4eZu7lowHobt1tCq+E9qZ4cadJEx/UwHWjqEhLBg3taXLL
	O9h3Xa1we0FoO1+qcxcfDFKG2O+F9K7cWag62HG+/w7mzGnmv0mWc5hIcEoNJgrk+GHX8N3fLzO
	Yp4kyf6RXYypXxtJs8dQRN2J6kgHuSFdaizUCmH4zCR8XKfYZXtLjTujDvq0MnYGOc8EcSk5F2n
	4EWVElZ0cb/TnMOTFUXRAlGF+XISXsoSDwUK8Whmk8mJ1r9usc5JjVLzvbnxk9OWGkKLN6dg+k6
	uzbncpNmUQxXF2GbNpIWM0A/rSiEP9Mtowl3fFjykVQNJS2JHQnaE59n79Vkt17wG1GFZQxNWYs
	lGFKT1M51mcfBJNcXxRuJdRP56IXb60IqqFS1p+QI+8//qpC0mntpPDklGdwQFNGYL74UrWiS1P
	1OxAQPnssFss0G00g==
X-Received: by 2002:a05:600c:4f8c:b0:48a:58ae:993b with SMTP id 5b1f17b1804b1-48a58ae9faemr164398395e9.16.1776957779732;
        Thu, 23 Apr 2026 08:22:59 -0700 (PDT)
Received: from ta2.c.googlers.com (17.83.155.104.bc.googleusercontent.com. [104.155.83.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891f98728dsm90550755e9.23.2026.04.23.08.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 08:22:59 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Thu, 23 Apr 2026 15:22:49 +0000
Subject: [PATCH v4 01/11] dt-bindings: thermal: Add Google GS101 TMU
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-acpm-tmu-v4-1-8b59f8548634@linaro.org>
References: <20260423-acpm-tmu-v4-0-8b59f8548634@linaro.org>
In-Reply-To: <20260423-acpm-tmu-v4-0-8b59f8548634@linaro.org>
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
 linux-clk@vger.kernel.org, Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776957778; l=3371;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=DUqmD7ypzAi56hF5Rjwm27fjn6fmPFxHtwOu1/9raE8=;
 b=UhqzoM8PdUosgQawfVF9WiuGetFtR1EtE1aMLLS4ZQ4GarNM/s0p3imCIaP1Jdt1/LJEbxtQW
 MfMJ8SzgeYkAtmV3J0vYms9+qiOl5uPDZyy2+Zqhf2Qyfd8zS2aTut+
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
 .../bindings/thermal/google,gs101-tmu-top.yaml     | 68 ++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/google,gs101-tmu-top.yaml b/Documentation/devicetree/bindings/thermal/google,gs101-tmu-top.yaml
new file mode 100644
index 000000000000..d0eb2393d581
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/google,gs101-tmu-top.yaml
@@ -0,0 +1,68 @@
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
2.54.0.545.g6539524ca2-goog

