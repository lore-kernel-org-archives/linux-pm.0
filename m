Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695CF3E3D86
	for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2026 15:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773847689; cv=none; b=tuQtt5AQ8teslO6iVT9w5zAsBp1kjqK6ZpUJUOwfkHkw6u0cRRiFi9KNM2+n6smG03jTkTqCvDG5hL56p/EGMHdCT7KCJbnNaTLP6Ms2FalZVBkJboMSf1VSPsjAe50lf+csPVkfc1Kt7YQ1uRGUBTKTrqKS7pjwOhMdwuWrBHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773847689; c=relaxed/simple;
	bh=Zm8WGMHTAOqa9bAfCg+ucMjVyj2BEnq0cG9Nd+VlKz8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=deDrVOKkiHKbnfgnfBGc0RBabbutEE4dmndJ19Qr5IgeZOKyld57ZsXTl7sWxwrltq7STPs7JICbFb54aC8LRBhDEQCzHBzq/GGtwPr40CW/JGuF727A07YzbAJQrpSeQJN2BdLaph3mGfFxEwscDu4qkd0rpZh+Hkh0T1JP4SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lFFcTGFt; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lFFcTGFt"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b93698bb57aso190875966b.0
        for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2026 08:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773847681; x=1774452481; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ucI1VpoOF8SXIqxz1Ls6Q9HI1Th2/zJLOADwE4rqh4E=;
        b=lFFcTGFtOyaxHGhLlUl4rswHgzaOg/1fhbYhw9Hg7xMkmaO/0fjS2UV2nIOdhqIf0x
         M3S3rDD55hGpDiQHlI3Lbh2rSekwwWTB+20wuzpO5XlH98u/k0MG0/6AcMm3AHDB4TB6
         NhtCL4Tw50ttS/fiuaGgLEhD3N03yyUi5fU33/f1TN2CAELyUPJCrzS8TOGLDhkX5gjv
         NhSsRFD4RkBblwyJT1RWq2m0oprBTCzr8NO+U0qgarJT45fTjY0++lfiDtJUPI9Rw/IX
         GcCgZLHIQYoUpc0u+mzUchwVQJ1uhNYKf5GguFoxwAiKWaMmf7k2AX1QxKNcSvRgSKRD
         TZZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773847681; x=1774452481;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ucI1VpoOF8SXIqxz1Ls6Q9HI1Th2/zJLOADwE4rqh4E=;
        b=PnErU+tTa0QoH1HsEqOU4MkWZO1OQqIobecRVC8iZzdR7+c1k1fu2/cjKIYrFgjDcd
         1VOOLgsvLLogDg74iv5O9oEzxtggGWvtWWLdiA7qB4r2XsBrH3gCeu3dtkq+kWIN/EBz
         WZc6LHpaH//wYeydaRYzDBN/LBeHQJCLwLzbpvzUmEPnlM/RvQsx+zB1xBKv4aOk0eAS
         cEuAeSLtU2Zc1TqGu9Lj6Ub/fWDYh/yqqwb4q+DuU0q+Ve2xU0RSCPfSAjpYuWoqsuUh
         jgjlky+8TmOfPoEie4IPyC1BfA580nTRGI/O6v3Q5dElGNmpILtES8hbTmJnoAFjsO0l
         Selw==
X-Forwarded-Encrypted: i=1; AJvYcCX4O/MQ4TZffkyE7gXTTj/eVZfopGM6aBDuB7KdKlljXvRpfATb35my8diVGuL/ZiWh6uzRsH4/3A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1Yk6l7CcG3xkLcyJjx/3OvbBPZceKu/3FRpQW6nB/VaOyAwzT
	SZWAExeRqvDD/iViVrWOQ+FkI+k6UqSBn2yMv4jmYGZ2bNSHfwmJOWj8NwVUe7MM00s=
X-Gm-Gg: ATEYQzwgGfXMfCe7LqzyN4IS0L4agl/2++deSqH4zj83F3w9Wqeb9dhyNNRoQrfT4rH
	NhkDx1mWwW16BF+N6DqqxiPnsmrOET03eUInfMULDzyRTM50LgfJEHeiH/yA+QuCgYvA9ViCwkM
	WnDwNJ7w9DUZ/tb8CvRHNdXcEC6bMsePp7RDmFmfu8WtpFqMaiQizHQ+M0K75GOixJLRe9ifBZK
	oU6Dly9WUv8BIvb7NHt0dlmpTmUA+KR2B5x6m6EoWI/7FVZszoVX0NOQYrJSuoKBYVZTHi7bk3g
	WjbGNFkBx2NFeSNGtPyhcLPp1Un3ngyiSwCo6XwteNDf51tPcJMbpQfeU0l/H1ZNnvWRbEZDp1I
	m+IyRIG2z18/69PSOCcFNvJUxZk1W+YcodCVpi93FTufZb7+waxCBtMN6voZadAzne1MY4+4A5j
	ZJLWHx6BdWv1f4eh1HMAb9DFKswCLWkQPNWw/RKK6y6ibw/gQpA+QDtmQlQAyZFxLetZuQPccu5
	45v3xUtPCJPZpw=
X-Received: by 2002:a17:907:6d20:b0:b97:c068:555e with SMTP id a640c23a62f3a-b980f8f881dmr1151066b.1.1773847680981;
        Wed, 18 Mar 2026 08:28:00 -0700 (PDT)
Received: from puffmais2.c.googlers.com (221.210.91.34.bc.googleusercontent.com. [34.91.210.221])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b97f173a3e3sm226989566b.61.2026.03.18.08.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 08:28:00 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Wed, 18 Mar 2026 15:27:49 +0000
Subject: [PATCH v8 04/10] dt-bindings: soc: google: gs101-pmu: allow power
 domains as children
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260318-gs101-pd-v8-4-241523460b10@linaro.org>
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

The power domains are a property of / implemented in the PMU. As such,
they should be modelled as child nodes of the PMU.

Note:
Because the properties added are 'required', this commit breaks DT
validation of the existing DT for Pixel 6, but a) that's simply because
the DT is incomplete and b) a DT update will be posted once the binding
is accepted.
It is not possible to write the binding such that it supports old
(incomplete) DTs in addition to the full version, but as per above
it's not required to keep supporting old DTs.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
v8:
- move comment from commit message footer into body (Rob)
- fix incorrect use of ranges in example (Rob)

v7:
- really be consistent with quoting (Krzysztof)
- drop invalid tested-by tag (Krzysztof)

v4:
- consistent quoting using " (Krzysztof)
- add samsung,dtzpc to example
---
 .../bindings/soc/google/google,gs101-pmu.yaml      | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/google/google,gs101-pmu.yaml b/Documentation/devicetree/bindings/soc/google/google,gs101-pmu.yaml
index a06bd8ec3c20..52c47252b801 100644
--- a/Documentation/devicetree/bindings/soc/google/google,gs101-pmu.yaml
+++ b/Documentation/devicetree/bindings/soc/google/google,gs101-pmu.yaml
@@ -16,6 +16,14 @@ properties:
   reg:
     maxItems: 1
 
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+  ranges: true
+
   reboot-mode:
     $ref: /schemas/power/reset/syscon-reboot-mode.yaml
     type: object
@@ -39,9 +47,23 @@ properties:
     description:
       Phandle to PMU interrupt generation interface.
 
+patternProperties:
+  "^power-domain@[0-9a-f]+$":
+    type: object
+    description: Child node describing one power domain within the PMU
+
+    additionalProperties: true
+
+    properties:
+      compatible:
+        const: google,gs101-pd
+
 required:
   - compatible
   - reg
+  - "#address-cells"
+  - "#size-cells"
+  - ranges
   - google,pmu-intr-gen-syscon
 
 additionalProperties: false
@@ -51,6 +73,25 @@ examples:
     system-controller@17460000 {
         compatible = "google,gs101-pmu";
         reg = <0x17460000 0x10000>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges = <0x0 0x17460000 0x10000>;
 
         google,pmu-intr-gen-syscon = <&pmu_intr_gen>;
+
+        pd_g3d: power-domain@1e00 {
+            compatible = "google,gs101-pd";
+            reg = <0x1e00 0x80>;
+            #power-domain-cells = <0>;
+            label = "g3d";
+            samsung,dtzpc = <&pd_g3d>;
+        };
+
+        power-domain@2000 {
+            compatible = "google,gs101-pd";
+            reg = <0x2000 0x80>;
+            #power-domain-cells = <0>;
+            power-domains = <&pd_g3d>;
+            label = "embedded_g3d";
+        };
     };

-- 
2.53.0.851.ga537e3e6e9-goog

