Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B035243CEFB
	for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 09:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773134953; cv=none; b=cLkMRD/VnZ6yYuaPK12nNmFgtv9csvCb3YUnXGYF1gbqfxd6L7GnFnrEw2wLvG071O8yiWuo1e5CJD6oeGARI3AuAhDm0jFFLlh4zGV0qZSIdEE9tko42O/eTaJLbLFbSDal8VtTY7uMCSuCMVKv2sPFfdXLurZRkyinfWZ8AEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773134953; c=relaxed/simple;
	bh=Kch86XWLNpsoWXsiUYScxG9+qZq2PDWJ+mVUNiuprdY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O8Y4/d+eptVijVm7MJprXmwbDFZ4jtSs9dnweX1cU6LcXVTCdJtny+kB65n2sYvlKog5GJBXatEk+tDrm6dxIEY0D4WmS3vwlpMpCmX//b2i5xANgL1yUHZzqkweRq/7oY/aH9R6BSdSR87k6IBh6wRu9DD8a80zTxjKyUvDvGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=M7SIxeTd; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="M7SIxeTd"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48374014a77so149647505e9.3
        for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 02:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1773134950; x=1773739750; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a3tePfAp0V+6zfOlKlirFvJa8IZ0hYoxL5FVcQEbR28=;
        b=M7SIxeTdPAVaLGTymXhVoVw7ZUhdRy5PCrEoHj/M182KR/YBWNEG1EGvaIFmOqfXCR
         f6+l9ZgTLm4f1QKQzvnALbqCANenX2BhKB0/bI30WbOK7yqts28HUpWiPgYnp+YBAtW+
         J/HPOS061uo+g3JYtTJE+WMcbNGGuhICYAvZpsvP6fxY0dKNwrDsXwoj4r5NJCTkFYEl
         RgPY/Ku/PW5TeSRoDdKRMbUza0oHTKKdBhCRwBCEqZOpo4Y7sKHOpKxFi49UHDlldsmn
         Lqi0nBQdK02Nwtk7KlDsG5YRLHb4HRpgqJU/mq1a4iCQlT7AoG60LjqbUFwMVzXe3MAU
         oKwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773134950; x=1773739750;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a3tePfAp0V+6zfOlKlirFvJa8IZ0hYoxL5FVcQEbR28=;
        b=XnsCczqYETNojIssAqiwZvBfBrfw4vGUbb1MFB9vFdXhs/q2fj/V2ShfYU3EjypENw
         lcbh6y5s68QD+Q1UHcRDU6+u6qJXmoMlRq8gX5MgsFEZs6mF/WbH+s0+dI6zQ1AGOfZc
         z4/sLuYzhlpckdMcFCep/xQPu1hPo8v8WWRoe2hg24gFrBSORGTtmk8ZfEbgP/cRKZBH
         Z4pEtj+z6Te96v+JFTFpiqh8BMEnY9BAVOwoA1el+hi5MoFuoiEtPCggwPWoV/VcG2Ct
         nkhMjnbm2lN644I/mLn9Tl2PeOeP95TIi1YccJ4QlcCyjFfhkqZYanL0rj6QyIXKzXjg
         tc1w==
X-Forwarded-Encrypted: i=1; AJvYcCX2Sl8BLsNnKii2jW/Vzikq0v3luwhTYdZAXXkIT6ODeMP5wLEm4emrJP3akB95zzQEPLT01l5+Jw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx51kbqrlxqPNsqMV3RLWZhL927I03mKhclPzfhsDGGUY3L/LOA
	S1uLcAY8Bzneb7MQKlBqVxgPSP0vQobAP+F8DsQa3ksaAWbfJW6Bf64//e7gusS3epw=
X-Gm-Gg: ATEYQzyW8DUoLik1ArDu7Y8NSDcEBCaYFpad8ufDLNZqVsVlxVhMKpwmlZP5ioVImqq
	FZhqx61VDP11b7kdJx4vIVzKhIsMl9awMxb3MiAu9uTWZtGDnaNu2+on4r4hQlq2dwGPF7+GgZb
	IN8K99hMFahsKQvDqckFiq43jS85Sdlm42Ulx6Dh+4VgMOJaUMTmr80yDRw+QOcqsyEJSXLbrOd
	1jPl9K4Pe6IpaHSvtJW+CSjndZkSdBGdNfLHSy8lDE/GXFINIMBjKSru7hupTzmE7pSlwtTF3OF
	vqizxH5Ut5M8vjnyQTLhTFEDn/Xkm5au4xfhaVEVa/VaKY8Ue7uLKw40ZNhGQQZqq+KqeqDQQFB
	vTBQtQt9RpKFroQh3EY3uzY8fUf+P71/1L9B/hH/jJhu4XQF5zVNfQggZ5IyGgKAjxwZ4fzfkSr
	qXJEnRiyqpou9YWalSjSIqI1B+MccELOWDuft0uiC1HbMlVk+JxZocQSeS247jaaBKx48p/NKLu
	gsmyw==
X-Received: by 2002:a05:600c:3b01:b0:485:353f:c651 with SMTP id 5b1f17b1804b1-485353fc9b9mr131031465e9.22.1773134949897;
        Tue, 10 Mar 2026 02:29:09 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-109.alshamil.net.ae. [86.98.192.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48529f019a4sm104214285e9.12.2026.03.10.02.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 02:29:09 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 10 Mar 2026 13:28:25 +0400
Subject: [PATCH v3 01/11] dt-bindings: mfd: ti,bq25703a: Expand to include
 BQ25792
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-bq25792-v3-1-02f8e232d63b@flipper.net>
References: <20260310-bq25792-v3-0-02f8e232d63b@flipper.net>
In-Reply-To: <20260310-bq25792-v3-0-02f8e232d63b@flipper.net>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chris Morgan <macromorgan@hotmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-pm@vger.kernel.org, Alexey Charkov <alchark@flipper.net>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3922; i=alchark@flipper.net;
 h=from:subject:message-id; bh=Kch86XWLNpsoWXsiUYScxG9+qZq2PDWJ+mVUNiuprdY=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWSuf5KYMFvmmzE7k+6GAuEWY17WjysLp4srttjslrrkl
 RVSFb6uYyILgxgXg6WYIsvcb0tspxrxzdrl4fEVZg4rE8gQaZEGBiBgYeDLTcwrNdIx0jPVNtQz
 NNQx1jFi4OIUgKlu+sLIMHdRU09l8SGjgy90S/dGZ/N+nm0+cfaheYfep/TlmTmuXcvI8CFYLy6
 z4grzFJNPb5bY8d34eceKI+/nmS27srY/2vrzKgMA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

TI BQ25792 is similar in operation to BQ25703A, but has a different
register layout and different current/voltage capabilities.

Expand the existing BQ25703A binding to include BQ25792, and move the
voltage and current limits into per-variant conditional statements.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Tested-by: Chris Morgan <macromorgan@hotmail.com>
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 .../devicetree/bindings/mfd/ti,bq25703a.yaml       | 73 +++++++++++++++++++---
 1 file changed, 63 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/ti,bq25703a.yaml b/Documentation/devicetree/bindings/mfd/ti,bq25703a.yaml
index ba14663c9266..cdce83f05804 100644
--- a/Documentation/devicetree/bindings/mfd/ti,bq25703a.yaml
+++ b/Documentation/devicetree/bindings/mfd/ti,bq25703a.yaml
@@ -4,17 +4,16 @@
 $id: http://devicetree.org/schemas/mfd/ti,bq25703a.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: BQ25703A Charger Manager/Buck/Boost Converter
+title: BQ257xx Charger Manager/Buck/Boost Converter
 
 maintainers:
   - Chris Morgan <macromorgan@hotmail.com>
 
-allOf:
-  - $ref: /schemas/power/supply/power-supply.yaml#
-
 properties:
   compatible:
-    const: ti,bq25703a
+    enum:
+      - ti,bq25703a
+      - ti,bq25792
 
   reg:
     const: 0x6b
@@ -25,7 +24,6 @@ properties:
       powering the device.
     minimum: 50000
     maximum: 6400000
-    default: 3250000
 
   interrupts:
     maxItems: 1
@@ -57,11 +55,11 @@ properties:
             minimum: 0
             maximum: 6350000
           regulator-min-microvolt:
-            minimum: 4480000
-            maximum: 20800000
+            minimum: 2800000
+            maximum: 22000000
           regulator-max-microvolt:
-            minimum: 4480000
-            maximum: 20800000
+            minimum: 2800000
+            maximum: 22000000
           enable-gpios:
             description:
               The BQ25703 may require both a register write and a GPIO
@@ -74,6 +72,61 @@ properties:
           - regulator-min-microvolt
           - regulator-max-microvolt
 
+allOf:
+  - $ref: /schemas/power/supply/power-supply.yaml#
+  - if:
+      properties:
+        compatible:
+          const: ti,bq25703a
+    then:
+      properties:
+        input-current-limit-microamp:
+          minimum: 50000
+          maximum: 6400000
+          default: 3250000
+        regulators:
+          properties:
+            vbus:
+              properties:
+                regulator-min-microamp:
+                  minimum: 0
+                  maximum: 6350000
+                regulator-max-microamp:
+                  minimum: 0
+                  maximum: 6350000
+                regulator-min-microvolt:
+                  minimum: 4480000
+                  maximum: 20800000
+                regulator-max-microvolt:
+                  minimum: 4480000
+                  maximum: 20800000
+  - if:
+      properties:
+        compatible:
+          const: ti,bq25792
+    then:
+      properties:
+        input-current-limit-microamp:
+          minimum: 100000
+          maximum: 3300000
+          default: 3000000
+        regulators:
+          properties:
+            vbus:
+              properties:
+                regulator-min-microamp:
+                  minimum: 0
+                  maximum: 3320000
+                regulator-max-microamp:
+                  minimum: 0
+                  maximum: 3320000
+                regulator-min-microvolt:
+                  minimum: 2800000
+                  maximum: 22000000
+                regulator-max-microvolt:
+                  minimum: 2800000
+                  maximum: 22000000
+
 unevaluatedProperties: false
 
 required:

-- 
2.52.0

