Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CF1478842;
	Fri, 25 Sep 2026 08:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790326771; cv=none; b=lL2naaZxl22AwZdJGCEwmKSYlB5A3fC0HkvUoWv2dCEpUG+rEM2bV2UXdWgnwtrMZnhZ8U0ArIokHxgYk0NCzwH2jzbBuEau3M+WSxNlYnCr2uR5590B2NMpoIHX2+GN7SCFIUNkymL3C+SGoQXqoh5h+XHSYZ2dcUpVwRGshjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790326771; c=relaxed/simple;
	bh=M2GoU4n2Gi0BX0O07E2SmRislBYHH3hyArqFSfVNi3Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QYsRt+ryxG41hbQmoVJX6o7PGAcbovEKVClqrBRydMzF/6FoF2byodBf2VvK/0kaA3iFB3Keud2YipOuAke0eqdT26dm71Gdfu45Prr3E3QhlDsueoeraMf7SHA8PkGsW4LqDVg+y8f3KB9cVWNqOtdE4F0Xu47z09nJFEuCb8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RvEQXo1c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RvEQXo1c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3811F1F00893;
	Fri, 25 Sep 2026 08:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790326769;
	bh=wDNM6HEngYwIP8WbIgxLzm1zRTYy7mP6i3iZ3a7JN3o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=RvEQXo1cxxiA6U/4pz510INT8bsrpHdC9EMdcusFLoFF2XCPJHOo0DCIqo0x+NWkL
	 hRgAGdyqpSvBzLSjSGC0ycx31621iC1NO9et9QI7LOP7WOvi2jXKwlZS02CEL/EPGN
	 StN8zgnMV7LKVp7DJe8h224Y4nPPbruPkOIJfQnryEj9zbLWP4TZZwpox6xZC/10qx
	 dr+Wlzz8CRw35N8Exx/JOLzzlXs+uoe+74Edki2Gcvv94p2YpgabOWmH/a0oqgDYIn
	 Pnxj/Tjaalbq3E1go1Hkk79vW4sb/GoncWRok6DEqKPbtOS0NQ7+VQ6gCxnqD3jt0h
	 MzGPv3sbilWDQ==
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 25 Sep 2026 10:59:24 +0200
Subject: [PATCH v3 1/2] dt-bindings: power: supply: ab8500: Add AB8505
 charger
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-ab8500-charger-dt-v3-1-f80b8d295e2d@kernel.org>
References: <20260925-ab8500-charger-dt-v3-0-f80b8d295e2d@kernel.org>
In-Reply-To: <20260925-ab8500-charger-dt-v3-0-f80b8d295e2d@kernel.org>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 Linus Walleij <linusw@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3

AB8500 and AB8505 expose different charger interrupt sets. Add a unique
AB8505 charger compatible with the AB8500 compatible as its fallback.
Use the variant-specific string to require the fourteen main and USB
charger interrupts on AB8500 and the nine USB charger interrupts on
AB8505.

Also clarify that autopower_cfg describes the AB8500 facility, since the
corresponding AB8505 register bit is reserved.

Fixes: eb917497734c ("dt-bindings: power: supply: ab8500: Convert to DT schema format")
Assisted-by: LLM
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
Sebastian: I think you can apply this now.
---
 .../power/supply/stericsson,ab8500-charger.yaml    | 76 ++++++++++++++++------
 1 file changed, 56 insertions(+), 20 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/supply/stericsson,ab8500-charger.yaml b/Documentation/devicetree/bindings/power/supply/stericsson,ab8500-charger.yaml
index 4f19744844e9..dcffcecaea13 100644
--- a/Documentation/devicetree/bindings/power/supply/stericsson,ab8500-charger.yaml
+++ b/Documentation/devicetree/bindings/power/supply/stericsson,ab8500-charger.yaml
@@ -10,12 +10,13 @@ title: AB8500 Charger
 maintainers:
   - Sebastian Reichel <sre@kernel.org>
 
-allOf:
-  - $ref: power-supply.yaml#
-
 properties:
   compatible:
-    const: stericsson,ab8500-charger
+    oneOf:
+      - const: stericsson,ab8500-charger
+      - items:
+          - const: stericsson,ab8505-charger
+          - const: stericsson,ab8500-charger
 
   monitored-battery: true
 
@@ -28,27 +29,15 @@ properties:
 
   autopower_cfg:
     type: boolean
-    description: automatic poweron after powerloss
+    description: AB8500 automatic poweron after powerloss
 
   interrupts:
+    minItems: 9
     maxItems: 14
 
   interrupt-names:
-    items:
-      - const: MAIN_CH_UNPLUG_DET
-      - const: MAIN_CHARGE_PLUG_DET
-      - const: MAIN_EXT_CH_NOT_OK
-      - const: MAIN_CH_TH_PROT_R
-      - const: MAIN_CH_TH_PROT_F
-      - const: VBUS_DET_F
-      - const: VBUS_DET_R
-      - const: USB_LINK_STATUS
-      - const: USB_CH_TH_PROT_R
-      - const: USB_CH_TH_PROT_F
-      - const: USB_CHARGER_NOT_OKR
-      - const: VBUS_OVV
-      - const: CH_WD_EXP
-      - const: VBUS_CH_DROP_END
+    minItems: 9
+    maxItems: 14
 
   io-channels:
     minItems: 2
@@ -74,6 +63,53 @@ required:
   - io-channels
   - io-channel-names
 
+allOf:
+  - $ref: power-supply.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: stericsson,ab8505-charger
+    then:
+      properties:
+        interrupts:
+          minItems: 9
+          maxItems: 9
+
+        interrupt-names:
+          items:
+            - const: VBUS_DET_F
+            - const: VBUS_DET_R
+            - const: USB_LINK_STATUS
+            - const: USB_CH_TH_PROT_R
+            - const: USB_CH_TH_PROT_F
+            - const: USB_CHARGER_NOT_OKR
+            - const: VBUS_OVV
+            - const: CH_WD_EXP
+            - const: VBUS_CH_DROP_END
+    else:
+      properties:
+        interrupts:
+          minItems: 14
+          maxItems: 14
+
+        interrupt-names:
+          items:
+            - const: MAIN_CH_UNPLUG_DET
+            - const: MAIN_CHARGE_PLUG_DET
+            - const: MAIN_EXT_CH_NOT_OK
+            - const: MAIN_CH_TH_PROT_R
+            - const: MAIN_CH_TH_PROT_F
+            - const: VBUS_DET_F
+            - const: VBUS_DET_R
+            - const: USB_LINK_STATUS
+            - const: USB_CH_TH_PROT_R
+            - const: USB_CH_TH_PROT_F
+            - const: USB_CHARGER_NOT_OKR
+            - const: VBUS_OVV
+            - const: CH_WD_EXP
+            - const: VBUS_CH_DROP_END
+
 additionalProperties: false
 
 examples:

-- 
2.55.0

