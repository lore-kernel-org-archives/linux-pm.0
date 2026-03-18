Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3BF3E316B
	for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2026 15:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773847688; cv=none; b=dt0oLeVFwGCn29CwSv/Y4wTJwpqMmn9IwTAwfEEldgeWJjDiU9MCYXp+xNzaEEyXi3wXjOYEq+YcCYap0HD3MEMb4Vmt4YwvY1LDeQDXliAZZEwvYggp/S+0W5uRxCnAbW7Cs8dlhueufSN7/oHP3wCIxo0RZ+5Fj34Q93B0pAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773847688; c=relaxed/simple;
	bh=5HBp8bV1/vaov7w+S+97JbyTVIIwdoaJlgTvdiC2X1A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hh4o0Jrk5WLq1w7VfSkjcer5aycxawS+UmAv6pn7EDYZ5DVvQ1k/Vd44DSgWHbinhN2dl/giW0q4qo5QUEqOkluu5m8IUP2E8c/6/R9/5QC7jygpuBb/3e5pSY06ZedAb4moloj7mPcRhRQXon82sH3MaPRNkIe9GxMEyCOJqAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NnU8yo1x; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NnU8yo1x"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b886fc047d5so150870266b.3
        for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2026 08:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773847680; x=1774452480; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P48rUo71pAt5qHURMk+v6z4m8HRw94KlYaJLWRXtfGc=;
        b=NnU8yo1xqfBITHf4u3NjINasim/rbCpKIS93FUhT0EE3Biw7YkfIUwJuo0yqMVzuXG
         FYAtg5s7f4qnt944sWCFFeIJqmBK14SCVlPtHGeQxJK8BEkHOAqWoPjEjOREA5QXns5E
         9ylgYoCggqr4E3Fq11JRlnOWZAxVE9cfDjS7nEQDw51/OuIXl+sK0cNPfKoSR7My2lkY
         B3vYWPPrPJ5mPSaFE+3mHnpMpMKwRMWPFXpAw+Uc0aaACKvXue94mhEVwJ8OOqNpxtxq
         MKJc8bHfO4pU3Ywru49gLqzVFRgmIxfT8WmJ88ZusLp+lDXRGHsyb5JL2hQWE0aj5KZK
         q0GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773847680; x=1774452480;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=P48rUo71pAt5qHURMk+v6z4m8HRw94KlYaJLWRXtfGc=;
        b=etqWfApAGvUjct7DisE/sO4NCcs9lfRtG43Gar9FXEVwdtbyI4YI4U7iv0TfbEec3W
         eR7Lr1iQDnneSdojW7wGSxoq5Ex8iki79oqk90exPcsn8n+L+y/ycloDTC6D+OvfLEa8
         0ZSujuQIavPgoy/HIOXoic8m82XJqhNuxjSuc8u+38ZY97lyjlHwPnxb9sAS25LCChBg
         Za+fn8WAcP7sT9PPO3z2iOrd/rYySABvP8PLRXxg0j9oug7xOtXml0nFbjE0ngtGii6O
         694vcJIyvgR6EBjHG4vACdHZUsTlxMKY0uupHRiRRV1mN6XM/ecyUtPjG4X6VW2y0R/V
         o+/w==
X-Forwarded-Encrypted: i=1; AJvYcCVvzR/iIBla/FE+ivGiJkHmnz5NGNqYYlO1QuEket+T/mnWoHoEY6fRdcMpSwC5aqJF1ctPiUPxjA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzRtLizRoTc0xE+AOdOdWUa1BaCAZKueR5PmImetvyWueKf5SLp
	6fsRDWuRIrWBIGAiNGh99ywFgJZVUyaLDAvv0L+hEgvLkIQpmL2uHrdOPkLj9Zd8NrE=
X-Gm-Gg: ATEYQzydonE4rbk0qurTdImL116A3npWpYdjmFEMmsras5oWON/kjyXgwvFGrJgyEtq
	gxEkItg7XbXmsRVL4QVtFB0TLieUtzarO9c0ixG9ypMHeGVLPKBqctQuAeqzNjVrVLfThV4A0aM
	B1fzQGHYlVdFvyhpmBVpjFfkSEHDqmEMW/l0TRETXZK1Q0bnFYTHcnfeYEyfYCahliKF9wZtc9s
	KR6rLYUpgJt9NdDG+XFduIJLyO8TpqqVTsHYavrucVJJ049rJubWm7bOTcV2UQttPCkVWkeNnSa
	4KOsz1S10sT0lCaJjYKebr/pvbab/bM2B2lRo0522BAfF6QE/BNQi9xfAiugwFYNjLjdLAlqrca
	UKNb/0Bf1LOEUJHDKvbNVdEEGbTfUMSlsjZA9Hq5M2C2yQwhG43OIKBbhDKqowtipIGwwnFwmXa
	JyX1b1eh4E952dPBal/JdHMOodVaa5WT9GzsAd2DjgeW4AKAR/xLXeVtTub13eNxhsIkVMPCFD3
	XtNRoDMYRBBC9k=
X-Received: by 2002:a17:907:3f9d:b0:b87:b0ba:5d2d with SMTP id a640c23a62f3a-b97f4b86e27mr250568466b.57.1773847679718;
        Wed, 18 Mar 2026 08:27:59 -0700 (PDT)
Received: from puffmais2.c.googlers.com (221.210.91.34.bc.googleusercontent.com. [34.91.210.221])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b97f173a3e3sm226989566b.61.2026.03.18.08.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 08:27:59 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Wed, 18 Mar 2026 15:27:47 +0000
Subject: [PATCH v8 02/10] dt-bindings: power: samsung: add google,gs101-pd
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260318-gs101-pd-v8-2-241523460b10@linaro.org>
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

Add support for the Google gs101 version of the Exynos power domains. A
new compatible is needed because register fields have changed and
because power domain operations involve interfacing with the TrustZone
protection control on newer Exynos SoCs.

Power domains can also have a power supply linked to them, so add
optional support for that, too. It is believed that all (existing)
platforms could benefit from this, hence it's not being limited to
gs101-pd.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: André Draszik <andre.draszik@linaro.org>

---
v5:
- add domain-supply and update commit message

v4:
- add new vendor property samsung,dtzpc
- drop previous tags due to that
---
 .../devicetree/bindings/power/pd-samsung.yaml      | 33 ++++++++++++++++++++--
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/pd-samsung.yaml b/Documentation/devicetree/bindings/power/pd-samsung.yaml
index 9c2c51133457..3f1a2dc17862 100644
--- a/Documentation/devicetree/bindings/power/pd-samsung.yaml
+++ b/Documentation/devicetree/bindings/power/pd-samsung.yaml
@@ -13,12 +13,10 @@ description: |+
   Exynos processors include support for multiple power domains which are used
   to gate power to one or more peripherals on the processor.
 
-allOf:
-  - $ref: power-domain.yaml#
-
 properties:
   compatible:
     enum:
+      - google,gs101-pd
       - samsung,exynos4210-pd
       - samsung,exynos5433-pd
 
@@ -33,6 +31,9 @@ properties:
     deprecated: true
     maxItems: 1
 
+  domain-supply:
+    description: domain regulator supply.
+
   label:
     description:
       Human readable string with domain name. Will be visible in userspace
@@ -44,11 +45,28 @@ properties:
   power-domains:
     maxItems: 1
 
+  samsung,dtzpc:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Distributed TrustZone Protection Control (DTZPC) node.
+
 required:
   - compatible
   - "#power-domain-cells"
   - reg
 
+allOf:
+  - $ref: power-domain.yaml#
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              const: google,gs101-pd
+    then:
+      properties:
+        samsung,dtzpc: false
+
 unevaluatedProperties: false
 
 examples:
@@ -66,3 +84,12 @@ examples:
         #power-domain-cells = <0>;
         label = "MFC";
     };
+
+    power-domain@2080 {
+        compatible = "google,gs101-pd";
+        reg = <0x2080 0x80>;
+        #power-domain-cells = <0>;
+        label = "hsi0";
+        domain-supply = <&ldo7m>;
+        samsung,dtzpc = <&dtzpc_hsi0>;
+    };

-- 
2.53.0.851.ga537e3e6e9-goog

