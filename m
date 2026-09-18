Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3FF51A132;
	Fri, 18 Sep 2026 16:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789750618; cv=none; b=Cki9Br3SaQkkwkOzcwYEe1czjw4LPYX3eGYmKO+9PJ0cC4sX3Z3l+6La+uHCZwb91n4x6U+l/snaYMzz/x4491Z+mIZJ5SdaMp9+fiCnCz2o2XYvj8hTIwI78H+HL6aQiWhg3gN4iJVhAism7PTX85av5lqtkDhhs5v0axllG1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789750618; c=relaxed/simple;
	bh=xHZ76/JTCsIp54kTa9uFV+Wyd9Sq4I0xWG21cji0XzY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ue7LvINXNkUvYwnn6suJB5HVpPH+MSLaA2QZEbzh5zram9xKh2VACqXwh02SLXdiBUS0stsTVkP6VzOfGtZWBzeKLrw1Afexy04jjexDoLFxebepUV478Rp45FPGHthO6EIZ0cZH5YkTJCB9bMami18LpgraWOFJcrA94kRvNMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iiv+4B3I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iiv+4B3I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 725C01F000FF;
	Fri, 18 Sep 2026 16:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789750617;
	bh=JnjD5uTxUzRLD4xPJw/Uy/MHkSAmk7MI9VnoFTHi/G4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Iiv+4B3IwbRt23ARyVWzaPfF/VZRdtEVpKsVyuLMGrvEMHqn2HSa7nJshKn8qB2Se
	 7hpARJGuKHVKkBeuKyAG9cALNpR52yuLDiB7P10KEaFEWmizmyjcW7/tPp0uec5pIw
	 cTFRqAdY1Vli7j2G03ctes6dd++g/02ouRx1dGvyHwovf1s/CdbelJ2Hr38Hi/tCnX
	 cLQiTKparfo/Nt2TtypIl+VMVnMv2ZKje6cR0fSlRWglUEKov06u4xGrEnc3NpEOlp
	 JLAKN0uRZRsfiJ9ZuvCeyV7NjHnxDLXW4Mtck6nkrhb0KV52as0WpyDIey48aKkllr
	 RJG2sueMRh8oQ==
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 18 Sep 2026 18:56:51 +0200
Subject: [PATCH v2 1/2] dt-bindings: power: supply: ab8500: Add AB8505
 charger
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-ab8500-charger-dt-v2-1-5f17c332a2a7@kernel.org>
References: <20260918-ab8500-charger-dt-v2-0-5f17c332a2a7@kernel.org>
In-Reply-To: <20260918-ab8500-charger-dt-v2-0-5f17c332a2a7@kernel.org>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 Linus Walleij <linusw@kernel.org>
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
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 .../power/supply/stericsson,ab8500-charger.yaml    | 70 ++++++++++++++++------
 1 file changed, 53 insertions(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/supply/stericsson,ab8500-charger.yaml b/Documentation/devicetree/bindings/power/supply/stericsson,ab8500-charger.yaml
index 4f19744844e9..73f5df2d7a36 100644
--- a/Documentation/devicetree/bindings/power/supply/stericsson,ab8500-charger.yaml
+++ b/Documentation/devicetree/bindings/power/supply/stericsson,ab8500-charger.yaml
@@ -12,10 +12,58 @@ maintainers:
 
 allOf:
   - $ref: power-supply.yaml#
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
 
 properties:
   compatible:
-    const: stericsson,ab8500-charger
+    oneOf:
+      - const: stericsson,ab8500-charger
+      - items:
+          - const: stericsson,ab8505-charger
+          - const: stericsson,ab8500-charger
 
   monitored-battery: true
 
@@ -28,27 +76,15 @@ properties:
 
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

-- 
2.55.0

