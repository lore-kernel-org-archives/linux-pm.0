Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842F541B340
	for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 15:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774971833; cv=none; b=W+WOUZtQnecWL/IAbDZ7upuSMP59MQAawSqnlUAexubDwJc+JmReRdlU9GzOZ1NacHCA7G6w+pA2RrMP5fTzmEd6HbqObSkF52rVkycYzRHLhxzcQG/FbEbySPPnWJZ06VLrIJha1HhqGIjyq/2HUFgAv7ZpMF+Jw9NAVQmeSbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774971833; c=relaxed/simple;
	bh=Kch86XWLNpsoWXsiUYScxG9+qZq2PDWJ+mVUNiuprdY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V0/eRPmG884oW/Lfe9i3PxaZz85XpAFWQVRDubE1B48hpFZsVcQLYjoxWAInd+N4RNNtJtiIVFW4aN7ewoQx+Dx/d2dYK5zMoiNGEx+zwlV5y/5A8wq+2QrvuL2XSX91RuYB2IcRube0UlFJp4JhD6eqkWXc70llukNgGnpUKLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=SBJvd74k; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="SBJvd74k"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-486fb14227cso77163395e9.3
        for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 08:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1774971830; x=1775576630; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a3tePfAp0V+6zfOlKlirFvJa8IZ0hYoxL5FVcQEbR28=;
        b=SBJvd74kiLcY8RlHk0XC95rT+rG1H/QJ9eHW7mLJTA0jTELVftETWRwBap6qGGLXoo
         4PBwA3vp4pWlSncXJKmaUVe/2a73AGKBjzvfwp68blpMdtPDCSbIQp+CWzvL1mbKBYQN
         11zx1de7/JalUwkugmfoxZAI7NiImHnfKPlXns2m2Sh6s5aMccqedPC6MJYThPrQycCW
         JxTebjlsBDgQ+bhlZUsJkfc18li30ASnQv14+dqifBt0m8taAVX6UFoseXXb7R1hE3dx
         YZonYaFKgmAnlZG/N6P9flleVgxIfTAr3whJp05NzV9H2eHM13oDFhzMb5aJ+HO7KzhI
         4YkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774971830; x=1775576630;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a3tePfAp0V+6zfOlKlirFvJa8IZ0hYoxL5FVcQEbR28=;
        b=suCv49DUaw/47TiJ2UjfBAHPi9SmltlQzuVmlsFbEOTNHXjeC+hGXWH4A8nngvS4yz
         1ce3SLgQK9m8h8r13cchFNwYoHl/MiobSopuiOg6aATffvZcVR7gOgRqY/0jF/vB1C/G
         4ZGv5me207eQQqUis9O6WXzveV/SKDzzPRYEBb4yDO2d3uDTtct0aPMiKDyb/5htHFuk
         68lxM/61gqxsAJ9eMr64YTsSTZzMmoDZjlPLiZydIetQpZObz6tUnCeWhLkIR80cZYaM
         /a8TwpgGBp8F8eocDyXNJsutKGYKOb6WQswPbKtCiPUzvjUQZqVTolO8Q2XmZiB9wQ28
         yiTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuI1NSKau6iLQaH1vAS+J7K14pP1vnS/VhDLJ00Hce5cwwYrwQAR2UBLbCozhL4xRUL42mR5l6Pw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8BI166/JCC7WIr2LmWdJXmZen0gzgSwNxPdixcaiFnVHhLANP
	143WJEHH7/rO0OljkBB78s+VniZ45rgUKZk2XL39P9/yagcrjwYMjnCUm4Rb7qSdQAE=
X-Gm-Gg: ATEYQzxW5+W24VXFTgOJ0plwwpRKyZQ9VFRuOZYm2g0jB6Kxk6OKXMAS7bHMCrsWEdm
	ebcogXPuAhRdDsduOH5sn22J8Q2L7CWVBam5hS/au5fM43uojDeggpQla7N2kPICJWudpSc1Ll4
	H7frK5wueWkb4iahLlunytpcd5WvttsfBeLIsxcYufz75UODsgGw8H8bjiKVQh6CWMuC+0btj8z
	qdEDNiEJU1HStlfRvn4pw9KGLrKFW3O71u4fRPDD+zSz6xtIuZkMmqYQXl1zg4x2VRFICay0bRK
	Zbg+wpFm9OQJSbgwxUt6x0QaJYpNXt1A5t3cbQsWYMTP7X5GwlqgW7UJJX6C0k6ezd9rNrUKN0x
	9FGKS7JdBDCTUpwpKu3+vHYD9TFjltFs+3CXUVZoM8srw8QP/iZQcZcLiPSXjGudvigXnNrgA3s
	W9imWfGcY9NA8YoiuTCU31WnDNaWZxNAz0Mgh9oEQdSujIeMgwgz0VBmaXaANyu1dudYgF+uDzP
	ANqJQCIUOrsFrdo
X-Received: by 2002:a05:600c:3b27:b0:485:3aa1:a7f1 with SMTP id 5b1f17b1804b1-48727d5a252mr294923335e9.7.1774971829849;
        Tue, 31 Mar 2026 08:43:49 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-109.alshamil.net.ae. [86.98.192.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887c8852a5sm48412605e9.9.2026.03.31.08.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 08:43:49 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 31 Mar 2026 19:43:38 +0400
Subject: [PATCH v6 01/11] dt-bindings: mfd: ti,bq25703a: Expand to include
 BQ25792
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-bq25792-v6-1-0278fba33eb9@flipper.net>
References: <20260331-bq25792-v6-0-0278fba33eb9@flipper.net>
In-Reply-To: <20260331-bq25792-v6-0-0278fba33eb9@flipper.net>
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
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWSefr3edDpbxWsjpTPhaqe2KMzNvBRvXLWtwtxa5cMFo
 w/7GL3/d0xkYRDjYrAUU2SZ+22J7VQjvlm7PDy+wsxhZQIZIi3SwAAELAx8uYl5pUY6Rnqm2oZ6
 hoY6xjpGDFycAjDVeSqMDOftfsW83SDvWNwUMOnUhAVe0n5LRE/7ntH2exdflL8q7ATD/5BZqY3
 BoRJKf6xn7ky5/DvF7s36NQXSt55t6VPN/dLMxgwA
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

