Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA633EC2D7
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 11:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774352308; cv=none; b=IbRHlXcgO0DQ7rFHmlFMI0egczKAIZLMEhfPvw8bNhUti6Zx7wSsV+0+B3rObVvWUtQxtfwEqfc24ZhlNgRJlbfxiK9oLCtJzU1KxZGYZVh8R1M2q5nArHlifcdekGxstTWQmJtYVDAWshJXuX5S3D4qHEi9oxMGVu0YhHbBTBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774352308; c=relaxed/simple;
	bh=Kch86XWLNpsoWXsiUYScxG9+qZq2PDWJ+mVUNiuprdY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TeXcwBjCF6wmtS398+hv11ob2giejHiPyT4cgLwbscUtrNj2aB8SQ09o5ONinHk0Qd8Yh3rUB8l8pD+nhRXUzOcIAHE8k8IYI8IdRCRiA1U/E2jvuTrqWg1ekDgSJ6YaWzpqhdZcuRXOeTK7rgVjXOK73Ks/1X0We/5+jF2puYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=ubRAuAF8; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="ubRAuAF8"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-486fd3a577eso32798875e9.1
        for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 04:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1774352305; x=1774957105; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a3tePfAp0V+6zfOlKlirFvJa8IZ0hYoxL5FVcQEbR28=;
        b=ubRAuAF88g4+lGWoPq64KrLUncS0g4eFfK1GJ4EduzgXwzIMBMpksvLqtcKEpnkqYr
         RjJixLr6YTCJErncVwJ/iz1ObtxBs4QjKFx7oAsPnVRuTlej7zfHXIBeCu1tSZecOhDP
         J5r9bg8tYNJqsveGsmqym3qp58bXbvdi3aM/spXa8SmHg8Dn7vJ8dfTC4+ZwSsQtQXko
         +siLqm4ngQT5QRGih05PnlMinhG/ddNVu0S3NzlR+k923E3ruKg2OQ1X/5ij1/NzNM6m
         /VxMy5C53NzbdxF6JUBOZPvL5n2yEgrupK/gAgp8hW7nsZ5a8Mur+c2Mw489bOU7vsJN
         tDAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774352305; x=1774957105;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a3tePfAp0V+6zfOlKlirFvJa8IZ0hYoxL5FVcQEbR28=;
        b=oVNX0eubWcYY4BLCbUtc+Iq5jaLSvqUmsfccthtxJypWRyH7Q9A7zSCjtAKSuZP0II
         OpuWpk26+KB7G7RNswNdb5mtUTBO/PyFUJYThZ+/VUXzG2Zb1BaCXzVM8v/OjgLk4hE6
         CXfgLAePC8A9TS27mqw/aHJtuDPYQYAW01UZiaoTAEuZbwjbBBsktoKDabBHN5rqheG2
         lx6w4R413JxwNJfokzJaPGCrCqfFhCmPugYMxn6ffPzLWfOAqYOUAoDy5kZX2+nDXu4k
         eHDaKW92qsoUAfV96AsFhoQj8qjcBR3AXNH6Hb1MflLsmUwmSWeOR5pk17Kcib4QJP0P
         Rjxw==
X-Forwarded-Encrypted: i=1; AJvYcCWZqJ3PN8YJMyQ4G7P0KQi+XudI9vgUEW2tdH0IgGaVceXl7uf0rWzWY9k8V2tqZY+O9pWVcCTlTw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzwH6mM/wcAszG3KBhO2yS53SgW5M3Kpl2h9jxYBvU9fozhxw+o
	aWkqWqmwN25brg3WeUsMBzh8B7yLHN9aq3uVHJcWk3b+jxwCLIf2MQUXgwdkZMaxLcI=
X-Gm-Gg: ATEYQzxTtulDqKC3ph/PRLG/8Hz9hJ76iBuNw0Wkfp7X2WU/JOD2GvMTwcG2kLpAISf
	wb2AvXgTKdlYLNGadv6kUT37AdxkWqtjzxUOpg26dSThi7nwK9AatCdKL3fZ7Rg42+DhEpQjMLx
	g4Wy6XJi5zVw8FeBMjAFQWL3WO/svmAPM7NLioyfKa6gXTK9+AGmiYmZDLvv5HRd83Dnecaz/se
	zX0euqlqp96lI9uuqGmcfhup6pNYGwjWfLUXEGlWgXXH+kRrrVEuSTwRZ7h+X2XLhcG9yR2oM6Z
	+Hf+sEMAHbZI0/RgL6VjT3Blz7fQ+yCI+JiiKSKXaj/7bGiNIkxA8SmYPk6yIx4b1Hr+3e7891T
	NzLjqMh9wbj68/RD1Q5B+8xkcOQH4xU11rqwP6qyHNgOYDWdPT43H/16MLKaAwKMk5YZ+Ssv/fA
	qQlOMq9L0S2UnsJfWfMZxGxHNNwrldmsf+GTzcouqARNGMLBJvq5XK1gwYfn43XMsomxGgnBNsO
	GK+yg==
X-Received: by 2002:a05:600c:4f10:b0:487:2e8:69c5 with SMTP id 5b1f17b1804b1-48702e86a88mr199543535e9.15.1774352305270;
        Tue, 24 Mar 2026 04:38:25 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-109.alshamil.net.ae. [86.98.192.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4870f6c0fa6sm20846715e9.1.2026.03.24.04.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 04:38:24 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 24 Mar 2026 15:38:06 +0400
Subject: [PATCH v5 01/11] dt-bindings: mfd: ti,bq25703a: Expand to include
 BQ25792
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-bq25792-v5-1-0a2eb58cf11d@flipper.net>
References: <20260324-bq25792-v5-0-0a2eb58cf11d@flipper.net>
In-Reply-To: <20260324-bq25792-v5-0-0a2eb58cf11d@flipper.net>
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
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWQeKl8b/UHHfAfH3BNlrTrCV1ZnLHZjV5NhvPzZ+aL28
 Q/X5x+X75jIwiDGxWAppsgy99sS26lGfLN2eXh8hZnDygQyRFqkgQEIWBj4chPzSo10jPRMtQ31
 DA11jHWMGLg4BWCqQ7MYGU4/Ulia0nej+siCabodsmeTlz/LZ/+6flfnzJU9Pi1r5ngz/A9vfH+
 wd9qU+HPN+iL3m15oxeRn3dXSKd2h76M/XYlbhgkA
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

