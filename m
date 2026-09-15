Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E112C440A25;
	Tue, 15 Sep 2026 21:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789508824; cv=none; b=U6caPAteg5S4bgxfEuiB79FHO4G57JktqMOW7VNrO4aEpysg5DH2l1yrc0s+y+bpSGQ7jey1QEOHy5vW3ikWjNXceo7bn3+72FT6wSCZtTEykj4ucX4KRVLUl85TpB0S69jvSZ795pQDEPJOEBTn4R6e3XDUuKe/CN5f6GBEBQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789508824; c=relaxed/simple;
	bh=xKUSxZOgu16+R0Jv/lQuC6b+n4RUrB44AQQMJncXYys=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O6VLbxyJAGBcX5P6gLi49E0Z+lyV5V18yceyYXJ0QSEqA1RwYMjs4iOkm1qBRkV/REzv6l5dHwtyTfUdx+gT8l/AEZUUBVdUrOcnMOzx31IvD6pZj51QNTJ3ZRRmmj9T0J/X4CvGyuQYtOmemwQSGHI0tNGc9lywb1AAH1neEOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Az5V1daa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Az5V1daa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F28DE1F00899;
	Tue, 15 Sep 2026 21:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789508822;
	bh=KxSzm0ggBxNUpiYbkuBEyg3K/GaDY3ZMEQ2n/EmZGh0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Az5V1daaEXZOWv6oxVAMveUDyt6Rzelx++7gTXMCzIdIq/OmYOIpcfoG2aUD7u6an
	 FmDHlibYhGZMj30HqBea2tN9IKgKtKFQ9eTlNPRt0f2l9QQIuxJfldHdZN1M/49c12
	 K/fz/t+HIGZKB4fFGJDPDuQdsW8p+fvWMhSy42L9+JapR3CQTARu/+dNH63nxEVf8Y
	 ILratZxL3vZBn4x8mmVqsmEuI5Sy26Eg+JCKo52x0pk5I7Qt+uPsAYaRMWfL2Twf8j
	 V5yzbDxGcO6QEO+xnyq9x82j3aeq8Nx16gXsfdMiGQ2NzxiomhyklwfkqLBiCKJ2ow
	 q4P5EzmduQPtw==
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 15 Sep 2026 23:46:54 +0200
Subject: [PATCH 1/2] dt-bindings: power: supply: ab8500: Allow AB8505
 interrupts
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-ab8500-charger-dt-v1-1-10b7b387e6a6@kernel.org>
References: <20260915-ab8500-charger-dt-v1-0-10b7b387e6a6@kernel.org>
In-Reply-To: <20260915-ab8500-charger-dt-v1-0-10b7b387e6a6@kernel.org>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.14.3

AB8505 has no main charger or main-charger interrupts. Permit its
nine USB charger interrupts as an alternative to the full set of
fourteen AB8500 interrupts.

Also clarify that autopower_cfg describes the AB8500 facility, since
the corresponding AB8505 register bit is reserved.

Fixes: eb917497734c ("dt-bindings: power: supply: ab8500: Convert to DT schema format")
Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 .../power/supply/stericsson,ab8500-charger.yaml    | 44 ++++++++++++++--------
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/supply/stericsson,ab8500-charger.yaml b/Documentation/devicetree/bindings/power/supply/stericsson,ab8500-charger.yaml
index 4f19744844e9..437b58e82e9a 100644
--- a/Documentation/devicetree/bindings/power/supply/stericsson,ab8500-charger.yaml
+++ b/Documentation/devicetree/bindings/power/supply/stericsson,ab8500-charger.yaml
@@ -28,27 +28,39 @@ properties:
 
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
+    oneOf:
+      - items:
+          - const: MAIN_CH_UNPLUG_DET
+          - const: MAIN_CHARGE_PLUG_DET
+          - const: MAIN_EXT_CH_NOT_OK
+          - const: MAIN_CH_TH_PROT_R
+          - const: MAIN_CH_TH_PROT_F
+          - const: VBUS_DET_F
+          - const: VBUS_DET_R
+          - const: USB_LINK_STATUS
+          - const: USB_CH_TH_PROT_R
+          - const: USB_CH_TH_PROT_F
+          - const: USB_CHARGER_NOT_OKR
+          - const: VBUS_OVV
+          - const: CH_WD_EXP
+          - const: VBUS_CH_DROP_END
+      - items:
+          - const: VBUS_DET_F
+          - const: VBUS_DET_R
+          - const: USB_LINK_STATUS
+          - const: USB_CH_TH_PROT_R
+          - const: USB_CH_TH_PROT_F
+          - const: USB_CHARGER_NOT_OKR
+          - const: VBUS_OVV
+          - const: CH_WD_EXP
+          - const: VBUS_CH_DROP_END
 
   io-channels:
     minItems: 2

-- 
2.55.0

