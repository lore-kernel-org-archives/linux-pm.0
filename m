Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E102F1FC2;
	Sun, 25 Jan 2026 19:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769368098; cv=none; b=X2bPBtRzS4MzKPfxNJ6de0zfvpAKuPXQ5y3+Qh9EKeWZ9+i1+FWcmOl2sITJwAzaqysePaEi+tG/XqjvLzMxch012/rWzamz4J0dNYaXK3EXwPUyCCwdnC+IGu2Neo99FQkSQ91n8j5OLIMqN0kIIhfxRP291x5XR2uF8zVRFcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769368098; c=relaxed/simple;
	bh=Zy+SVUpiJPjBHTmVZxRaYPNFRrYrsIXJ4T0wcFAGRGQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mLaR60DougF6ySA4tHY4cqIQpqKPaybYFdPubOXv2Vl5fhehCplTOD7FVxw9tWITY4gplaLCv5+ASzvFsQ4jb0l+NCt3vhv25Avt1m07RlAOu7arkBZTa7TiyKJVWTffl56F8TAk5wERwpGdW/kf10663t1qTQY8WfVox2SWfS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=I30CBUZa; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="I30CBUZa"
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 2DBA728088;
	Sun, 25 Jan 2026 20:08:15 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WICNRE4q0Jxc; Sun, 25 Jan 2026 20:08:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1769368094; bh=Zy+SVUpiJPjBHTmVZxRaYPNFRrYrsIXJ4T0wcFAGRGQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=I30CBUZaEeGWXCJW1mJeeIE91qdxqZIlaPjvFXLMN2WNmADQpmeJXXJcR62NWW5UY
	 LOYNtqNaBJvDG78vLlMdim0K2soILbfv99oC+4QylGkJ/sbCip3ElYPskzy5cbEfTV
	 i1ghRC42jFx5blFwb7noNQmH4BGbLKrjyh6jHZW1XW6Dct7MXmLBVosvembDUN5l1D
	 Rj7/kZ45LG1NQ0gbTBj1TrvrmsEee1SMfUC621F+Df0kgJWjTZg+dl6d34hhzNnc+e
	 IBXJ73MfdD1F+ffZ/J5fhgIdCkmp7tH8hVRvf20Me8YrUr/AkDoXI+zrly01rKVfCz
	 YwMgRqK5Ns7aQ==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Mon, 26 Jan 2026 00:37:12 +0530
Subject: [PATCH v2 05/12] dt-bindings: mfd: s2mps11: add documentation for
 S2MU005 PMIC
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260126-s2mu005-pmic-v2-5-78f1a75f547a@disroot.org>
References: <20260126-s2mu005-pmic-v2-0-78f1a75f547a@disroot.org>
In-Reply-To: <20260126-s2mu005-pmic-v2-0-78f1a75f547a@disroot.org>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Sebastian Reichel <sre@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-rtc@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kaustabh Chakraborty <kauschluss@disroot.org>

Samsung's S2MU005 PMIC includes subdevices for a charger, an MUIC (Micro
USB Interface Controller), and flash and RGB LED controllers.

Since regulators are not supported by this device, unmark this property
as required and instead set this in a per-device basis for ones which
need it.

Add the compatible and documentation for the S2MU005 PMIC. Also, add an
example for nodes for supported sub-devices, i.e. charger, extcon,
flash, and rgb.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 .../devicetree/bindings/mfd/samsung,s2mps11.yaml   | 103 ++++++++++++++++++++-
 1 file changed, 102 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/samsung,s2mps11.yaml b/Documentation/devicetree/bindings/mfd/samsung,s2mps11.yaml
index 31d544a9c05ca..aef634ca2e36f 100644
--- a/Documentation/devicetree/bindings/mfd/samsung,s2mps11.yaml
+++ b/Documentation/devicetree/bindings/mfd/samsung,s2mps11.yaml
@@ -27,12 +27,28 @@ properties:
       - samsung,s2mps15-pmic
       - samsung,s2mpu02-pmic
       - samsung,s2mpu05-pmic
+      - samsung,s2mu005-pmic
 
   clocks:
     $ref: /schemas/clock/samsung,s2mps11.yaml
     description:
       Child node describing clock provider.
 
+  charger:
+    $ref: /schemas/power/supply/samsung,s2m-charger.yaml
+    description:
+      Child node describing battery charger device.
+
+  extcon:
+    $ref: /schemas/extcon/samsung,s2m-muic.yaml
+    description:
+      Child node describing extcon device.
+
+  flash:
+    $ref: /schemas/leds/samsung,s2m-flash.yaml
+    description:
+      Child node describing flash LEDs.
+
   interrupts:
     maxItems: 1
 
@@ -44,6 +60,11 @@ properties:
     description:
       List of child nodes that specify the regulators.
 
+  rgb:
+    $ref: /schemas/leds/samsung,s2m-rgb.yaml
+    description:
+      Child node describing RGB LEDs.
+
   samsung,s2mps11-acokb-ground:
     description: |
       Indicates that ACOKB pin of S2MPS11 PMIC is connected to the ground so
@@ -65,7 +86,6 @@ properties:
 
 required:
   - compatible
-  - regulators
 
 additionalProperties: false
 
@@ -105,6 +125,8 @@ allOf:
         regulators:
           $ref: /schemas/regulator/samsung,s2mps11.yaml
         samsung,s2mps11-wrstbi-ground: false
+      required:
+        - regulators
 
   - if:
       properties:
@@ -116,6 +138,8 @@ allOf:
         regulators:
           $ref: /schemas/regulator/samsung,s2mps13.yaml
         samsung,s2mps11-acokb-ground: false
+      required:
+        - regulators
 
   - if:
       properties:
@@ -128,6 +152,8 @@ allOf:
           $ref: /schemas/regulator/samsung,s2mps14.yaml
         samsung,s2mps11-acokb-ground: false
         samsung,s2mps11-wrstbi-ground: false
+      required:
+        - regulators
 
   - if:
       properties:
@@ -140,6 +166,8 @@ allOf:
           $ref: /schemas/regulator/samsung,s2mps15.yaml
         samsung,s2mps11-acokb-ground: false
         samsung,s2mps11-wrstbi-ground: false
+      required:
+        - regulators
 
   - if:
       properties:
@@ -152,6 +180,8 @@ allOf:
           $ref: /schemas/regulator/samsung,s2mpu02.yaml
         samsung,s2mps11-acokb-ground: false
         samsung,s2mps11-wrstbi-ground: false
+      required:
+        - regulators
 
   - if:
       properties:
@@ -164,6 +194,18 @@ allOf:
           $ref: /schemas/regulator/samsung,s2mpu05.yaml
         samsung,s2mps11-acokb-ground: false
         samsung,s2mps11-wrstbi-ground: false
+      required:
+        - regulators
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,s2mu005-pmic
+    then:
+      properties:
+        samsung,s2mps11-acokb-ground: false
+        samsung,s2mps11-wrstbi-ground: false
 
 examples:
   - |
@@ -305,3 +347,62 @@ examples:
             };
         };
     };
+
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/leds/common.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pmic@3d {
+            compatible = "samsung,s2mu005-pmic";
+            reg = <0x3d>;
+            interrupt-parent = <&gpa2>;
+            interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
+
+            charger {
+                compatible = "samsung,s2mu005-charger";
+                monitored-battery = <&battery>;
+            };
+
+            extcon {
+                compatible = "samsung,s2mu005-muic";
+
+                port {
+                    muic_to_usb: endpoint {
+                        remote-endpoint = <&usb_to_muic>;
+                    };
+                };
+            };
+
+            flash {
+                compatible = "samsung,s2mu005-flash";
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                led@0 {
+                    reg = <0>;
+                    label = "back-cam:white:flash";
+                    color = <LED_COLOR_ID_WHITE>;
+                    function = LED_FUNCTION_FLASH;
+                };
+
+                led@1 {
+                    reg = <1>;
+                    label = "front-cam:white:flash";
+                    color = <LED_COLOR_ID_WHITE>;
+                    function = LED_FUNCTION_FLASH;
+                };
+            };
+
+            rgb {
+                compatible = "samsung,s2mu005-rgb";
+                label = "notification:rgb:indicator";
+                color = <LED_COLOR_ID_RGB>;
+                function = LED_FUNCTION_INDICATOR;
+                linux,default-trigger = "pattern";
+            };
+        };
+    };

-- 
2.52.0

