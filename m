Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE213E3C56
	for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2026 15:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773847687; cv=none; b=JxO1h8C9DaakXRVQudZMzqNqGRh2LO9c4cnFKAZfUiVnxgItTUA3xQZ5PiDLoGFjfUqpSRXUmFDQPY1NH/SRlFUCkrHtWgyGS7pezmttNfEXDkuG2B0FwIqECqIM/zuBBLI5OUsT+G/wQILe2EcPGObl1Nbh0+J+E2OArfRL2L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773847687; c=relaxed/simple;
	bh=bLUWwsSBeNkjQIGbf7RQhzd8YJKonybEFdSnbDCOcgQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QKmEedeHx0g1p4HSMmIuPp3dEswq0sOP+UBTentW7+tsNVUm+ER5PeicmtlnnvY/2mkLCgd/lMf04vUVUJaDpBecNk4gsFONylvgZ1gm6SQmNZV1NgHFVAFLFTIYw7wXTfLvJpEYS/FAzntHzVRMpuoUn7pio3YyPYvfEsLFYIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Hffl+d9i; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hffl+d9i"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b97bca3797dso507013666b.0
        for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2026 08:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773847681; x=1774452481; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=76ew0Aox6hZpcoaCX95kIQMvXTcJq4g+BOpg4Kox4lM=;
        b=Hffl+d9ihou3IuBu/ce6Tbl34d3hl2LZevZGIwlWFa4RzAHdj/VPBI1EyqNgEUQQ5L
         l2GVbJb4V25XpZH/U1ulhSrnbGdxqrfZmq7jXkaUWHBhqKI0G4BVISUkB5BxA7VNIiQi
         q2MJA35E7c7dMzkjZp4CzguyT7kgoPPgJgjmyeQh0VRUm2qpc+A81Ku/TR8x7VcWwXii
         Za9NpWFGVVS3oFx1DOrhSJHD1Ig0O5BYH2TEwthCZyxjibmkle7VR/5MAxdgjEjID4uV
         FBGzT7s2b+xKGJLfWWFNec/da/4MVWDVyr7ns8RAsevNZMUYsAApUxwozbi9yhqUPS3g
         FVBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773847681; x=1774452481;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=76ew0Aox6hZpcoaCX95kIQMvXTcJq4g+BOpg4Kox4lM=;
        b=An1XaT9n5QXV3onknIjf5CD1Bskla323ZJ66W4w2UWaIhJO603j586LfQbs1Oyedfr
         gVDyr8D4mEJVB8xslq5qVEMwUdYN6NGngFrLSf5UqsYEgSzizgDeknO0NEtlymM3A8X1
         uSSMq9FPN4MJMOB1N9AT3o5Cc+mg7HSTtYrGUjk8De8+U7+cf2LpuGEPbghi2R0lag3p
         InUUGyoTVTq4EDV6DZJee0bSNIA6QwQAd3kZR5E4anlzLhqzTd4aNrAIu1wZKc5DgEZD
         U9/nJdZE9cq762VSt5p/GvJiyOpVSXnajXR1f9vA/AGl2xABFcd+BNi5gifaUx2KKgde
         Fp9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVGmkRegADrabYJBllvPIOyywOYQvcxZ0w2DL1o9bzqNmS14pgjVG2g8xp6Z2abAZ1t2PC5jWP69Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxsCowe8mBGffYQ/QyU0azDgCQFcXo9lmVFNTrXutsFmTKYQ+4f
	8b/8C43WhUF2Y6BXhrQLXJ+pJqz1VcJp2+MKN62r90Nt4fVVRCG5DrvxCoy7aqQszvc=
X-Gm-Gg: ATEYQzzZRPUkgW9ZOORznUH+cH+Nfxrkby0B8qzfiaPr9n7yLn+vgk7JfDXI1Ja1liE
	z/r9ySvW0JMtXTzfDhe5ji+aSEv1YuHU5hmf8DhgJxEc1Ip8+UxLVQdhETTds3MqZMwqWLHkQz6
	bIFMxhnl8Qx7BxiLZPirnJDhA6ks1XfZx23X2zUXSeYQqe+NAMUU/WVhaECaHggctrli2GbxTFq
	+0wqiTdfrLMm0iKqgHDC0amAK6Dhr53BcrGulx69XVKVcrStcLl4NfzR3yXl22wlG6Ewsj4lOR6
	wgWt453Bx3/wYhc748QQ7Tcm9lXLLkthYuOgHza8zD3FZvLJkNy6Y9R3/Ou/x5nOnBgTujDzEAM
	ZuqDkUWIPemfnLjol/hQngzkG6q/B0CX2zNWpWvtMdhDTfryktroFPEq9Ja7paslzK31ozidZDI
	9BzB0Jr7pZTzEkfMiN6jzVQC3M/7NgB0n2m8d1phOasiPO2X4rJS3nOENkoJowpiqB1AMrYfRp9
	IVukAvXQv6gA/g=
X-Received: by 2002:a17:907:98e:b0:b97:1d24:bfd1 with SMTP id a640c23a62f3a-b97f47c86fdmr235982266b.13.1773847680401;
        Wed, 18 Mar 2026 08:28:00 -0700 (PDT)
Received: from puffmais2.c.googlers.com (221.210.91.34.bc.googleusercontent.com. [34.91.210.221])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b97f173a3e3sm226989566b.61.2026.03.18.08.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 08:28:00 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Wed, 18 Mar 2026 15:27:48 +0000
Subject: [PATCH v8 03/10] dt-bindings: soc: samsung: exynos-pmu: move
 gs101-pmu into separate binding
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260318-gs101-pd-v8-3-241523460b10@linaro.org>
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

The gs101-pmu binding is going to acquire various additional (pattern)
properties that don't apply to other PMUs supported by this binding.

To enable this, move google,gs101-pmu into a separate binding.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
v7:
- drop invalid tested-by tag (Krzysztof)

v4:
- update since 'syscon' was removed from gs101-pmu compatibles
- update since 'select:' was removed from google,gs101-pmu.yaml

v3:
- use additionalProperties, not unevaluatedProperties
- fix path in $id (Rob)
- drop comment around 'select' (Rob)
---
 .../bindings/soc/google/google,gs101-pmu.yaml      | 56 ++++++++++++++++++++++
 .../bindings/soc/samsung/exynos-pmu.yaml           | 20 --------
 MAINTAINERS                                        |  1 +
 3 files changed, 57 insertions(+), 20 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/google/google,gs101-pmu.yaml b/Documentation/devicetree/bindings/soc/google/google,gs101-pmu.yaml
new file mode 100644
index 000000000000..a06bd8ec3c20
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/google/google,gs101-pmu.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/google/google,gs101-pmu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Google GS101 Power Management Unit (PMU)
+
+maintainers:
+  - André Draszik <andre.draszik@linaro.org>
+
+properties:
+  compatible:
+    const: google,gs101-pmu
+
+  reg:
+    maxItems: 1
+
+  reboot-mode:
+    $ref: /schemas/power/reset/syscon-reboot-mode.yaml
+    type: object
+    description:
+      Reboot mode to alter bootloader behavior for the next boot
+
+  syscon-poweroff:
+    $ref: /schemas/power/reset/syscon-poweroff.yaml#
+    type: object
+    description:
+      Node for power off method
+
+  syscon-reboot:
+    $ref: /schemas/power/reset/syscon-reboot.yaml#
+    type: object
+    description:
+      Node for reboot method
+
+  google,pmu-intr-gen-syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to PMU interrupt generation interface.
+
+required:
+  - compatible
+  - reg
+  - google,pmu-intr-gen-syscon
+
+additionalProperties: false
+
+examples:
+  - |
+    system-controller@17460000 {
+        compatible = "google,gs101-pmu";
+        reg = <0x17460000 0x10000>;
+
+        google,pmu-intr-gen-syscon = <&pmu_intr_gen>;
+    };
diff --git a/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml b/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml
index 76ce7e98c10f..09368dbb6de6 100644
--- a/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml
+++ b/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml
@@ -12,8 +12,6 @@ maintainers:
 properties:
   compatible:
     oneOf:
-      - enum:
-          - google,gs101-pmu
       - items:
           - enum:
               - samsung,exynos3250-pmu
@@ -110,11 +108,6 @@ properties:
     description:
       Node for reboot method
 
-  google,pmu-intr-gen-syscon:
-    $ref: /schemas/types.yaml#/definitions/phandle
-    description:
-      Phandle to PMU interrupt generation interface.
-
 required:
   - compatible
   - reg
@@ -176,19 +169,6 @@ allOf:
       properties:
         dp-phy: false
 
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - google,gs101-pmu
-    then:
-      required:
-        - google,pmu-intr-gen-syscon
-    else:
-      properties:
-        google,pmu-intr-gen-syscon: false
-
 examples:
   - |
     #include <dt-bindings/clock/exynos5250.h>
diff --git a/MAINTAINERS b/MAINTAINERS
index e8376343935f..60da52c420d4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10906,6 +10906,7 @@ C:	irc://irc.oftc.net/pixel6-kernel-dev
 F:	Documentation/devicetree/bindings/clock/google,gs101-clock.yaml
 F:	Documentation/devicetree/bindings/phy/google,lga-usb-phy.yaml
 F:	Documentation/devicetree/bindings/soc/google/google,gs101-dtzpc.yaml
+F:	Documentation/devicetree/bindings/soc/google/google,gs101-pmu.yaml
 F:	Documentation/devicetree/bindings/soc/google/google,gs101-pmu-intr-gen.yaml
 F:	Documentation/devicetree/bindings/usb/google,lga-dwc3.yaml
 F:	arch/arm64/boot/dts/exynos/google/

-- 
2.53.0.851.ga537e3e6e9-goog

