Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98D13DE448
	for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 11:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773230185; cv=none; b=kDcjEgu9O7dawj33kx23wI0GMb/jvNGaRYkb2XQUmBGQVBaOKD//b4ud6V/euecTyA3oiVqzg5ax2FFuBbzeMEh3k4f8TIKW8BxhxaDQ0HxTyHzR1ZqtHcUkYRLFKmcC0TZHqkABQMmVkJJ4q7jg76A3dP5uy4ZRwWvVu/oekSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773230185; c=relaxed/simple;
	bh=Kch86XWLNpsoWXsiUYScxG9+qZq2PDWJ+mVUNiuprdY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=boxD8vMSwZbTAdZ9XeCpHZVBcCqAjMbqm17dnp5maQg2nC+AVkHOEgRt6zl6vF0mN1KNiVTHWP+5IoB+fClM9BjcQu1o98fq0xp8BNnKGk3dhdMYeOxpQ20kOytw7/QleB4K5DnGgLwbgvWS9E4ZcgxhFZqSDrtXrLoaNSNYYRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=ZoPfvd7u; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="ZoPfvd7u"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4852fdb36a8so49615765e9.2
        for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 04:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1773230182; x=1773834982; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a3tePfAp0V+6zfOlKlirFvJa8IZ0hYoxL5FVcQEbR28=;
        b=ZoPfvd7uwgmLH8bnvkCOkEOOkiu0xTsr0qCkebF1drwbWDVQ9zNslBrc5yT//loPu/
         6DwI2gzbfZRHyrqyO0mM8/rNB/szh6Kn7MurAgwd8NOvEeC3Y0wN/WEEOHyYNTm7FmyU
         Feq7dHtUv6FjpCev68pbU/qZMBLql/E7LtvyytmgILfedooeQ+8HZllaElNMer9xAwuZ
         42Tvnj9tSgTQODQqBWu8yoHERClJrNWRMQrV1/1Devq36/gJAXEJufM8zHoNL25TynJ5
         cgKYvfnqsTePT+YwCTe89wvw8ZdzbVXwdr74jZIh6Dw1FmFeD5Syh1YxroSAWTaon77/
         os2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773230182; x=1773834982;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a3tePfAp0V+6zfOlKlirFvJa8IZ0hYoxL5FVcQEbR28=;
        b=rgcwtZBYFMneA+f3VByWdmW2ksOGRz3tHKxOxMkHZbmN9B6CBY/4sCG1yCdgpr6MEp
         mKSbmg3zMyCUNWuGixF/r/uyp3C+q3BASg0zcsgZjh5qzT8wpdup+iCmAjkLoT5GD5yM
         YCpjtYsStqGq6sYGEU0FTic+bjcexKt3vE+BjAfhPm+z87U/klJqWX42gM27jk1dJKL5
         QN4ShAehsQuHwPEr1vBGBrHRaQXtshcPmcgHjT9cTa5yBvFlqCutIN77QX/rD8zTq6rH
         VZULKOb0+XYyUS39CZvc6Pmm0a+eXLl2JnBRezf2+diIJqkkG9HMlF610i8zeLg9kO/Y
         +lUA==
X-Forwarded-Encrypted: i=1; AJvYcCXYKx5Xxl6sxe3PlqlIt+D1J5ULpToHZNUvj5uuaJsU+2LziB/yKtv0o5AhvgwSaXLiWwBQFXGR9Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJu2NvzrQa6xokf/R8qDOkXkx0wN8Et332nmyZrf855wosnD/m
	HZQCQNsboaWL7K3VnCtfiNqYpNDbM2/4ipg2ztuThxa4egObhE8ZfmH1r4J+yqNV4X8=
X-Gm-Gg: ATEYQzzgytaZLnwu658/2ZBnmSSas5ycgqAxuo7wcm9+NjyBswIIMtddk/ZCz9udu8u
	JjlwAraU0HK5QnUpGF9uo92JNYLoTH9Sed2pNmJ1VztNLMe9ynkGWckBMxIBKl9mFSTQmDklih+
	Y7fo99RSXoZLvJiqy1tXLBdBw/ICdOjkuTE29IxJpu9xCfS4aajIRw+JIW/QwR6CdLn8AwMxvVf
	hOdGZ7dg5XrILP5masMfyYiP2ywvQvjXR5IZjAJvm6jwA1AV8KQeHd6D2MfRFWDCgrh6qutYWqe
	1KCNPSEU7QxVGcoDsjqYFYlnkbtmaU0ky63SGS6owh7hZ1dfdkVUkX3wvfd2TkXBIkfXap4hQ03
	NCJRJuCcmmwqH/yUnj+lgU1mSA+K2kbjwUNF9SlBhVaeVhFKEYiavUAcMfa2O90mQs9cfJzgiW/
	H0OtYqWCLGwMg/Sn15+aMFBPYHqPIRjp+Hi8nIQQv6edwJsxnjCu64KU8nG1ry0yxyEDXBejlz8
	32SNhbsuN2Xyz2K
X-Received: by 2002:a05:600c:4fd5:b0:485:379b:57be with SMTP id 5b1f17b1804b1-4854b0cb6c7mr36459495e9.1.1773230182091;
        Wed, 11 Mar 2026 04:56:22 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-109.alshamil.net.ae. [86.98.192.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854ad5416bsm39586485e9.1.2026.03.11.04.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 04:56:21 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Wed, 11 Mar 2026 15:56:14 +0400
Subject: [PATCH v4 01/11] dt-bindings: mfd: ti,bq25703a: Expand to include
 BQ25792
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-bq25792-v4-1-7213415d9eec@flipper.net>
References: <20260311-bq25792-v4-0-7213415d9eec@flipper.net>
In-Reply-To: <20260311-bq25792-v4-0-7213415d9eec@flipper.net>
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
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWRujEg6a9bvJP2Bu9fpQktK45xGg9KtpzUvs/5hF1FlZ
 jUKOJHdMZGFQYyLwVJMkWXutyW2U434Zu3y8PgKM4eVCWSItEgDAxCwMPDlJuaVGukY6ZlqG+oZ
 GuoY6xgxcHEKwFSfesnwP0N3QQg7w6XjyUyf5JMPVaw+lyCutkOwN5+D4XvqOgvTHYwM789/evh
 JS7i3TWLOd5bnk9I6oh/9eK0pUbbu86PytTNNOAA=
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

