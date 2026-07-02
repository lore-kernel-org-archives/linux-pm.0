Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54184495514;
	Thu,  2 Jul 2026 09:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782986243; cv=none; b=fAQ/tHDNzemF7kXjQPsAB2aEzr2QifKEHbM/Wul/r5Zeenk49JpD05PkX6tBjpU389wpUul02MmKEyrUgOmEeKe0tYXfygZ739mzlf4400ZDY2KBLYxXzUhCXe2iYLnTZy5VQZx44Qbn8DZJayUQuy8coFR/Hpa3UZONfWmPFM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782986243; c=relaxed/simple;
	bh=KQ2jlEW1eOaS76algkR9vPolQCqOkVsbm0MXBmfkdXw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CTYX0zb04B2dU0XHdAIu51h2SW2JHgb93aW8FYr9rQrbUfj1m5Rg4RHsVNxjhVhxHtiIS4urfeC5j4UWhoq3ctXRTGqGasOPoUDOUbk8/YzvMCTH9iFZe/Bs5Chx1aG6BIZAf3FKrgIaiJDxIUcCeUtXn93+DFvbp9hKG3OwP2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pPnvnEdp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pPnvnEdp"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DB560C2BCC6;
	Thu,  2 Jul 2026 09:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782986243;
	bh=KQ2jlEW1eOaS76algkR9vPolQCqOkVsbm0MXBmfkdXw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=pPnvnEdpzP1CxLdJvI3mwxjKHmVXX85qvncSSWXumFIjkTCUpgbXOF3G7Q1qfYk6X
	 HKyDNvYl/bpNWqxp7gMk4zHHnD5qtLvnsj/AxVvGs1TurTedsliKxlxKkze9eATAsA
	 ph4v2iOeLqCQgEtW8f5wsQXOxER0gz81gPxH5xRzUZ53OctfDUNinX/k96UWE+eBrj
	 FbrusUPbj2B9Z6KwJRYXUUimqZoftGkagjQC4moOlPrxw28jKP/g36W7OB3LD2CBxA
	 XUERAAXlJHSiI8kpInIQVjyoxscPpPWOwegTmotyJAGXtS6auiMy9NmzVzo1WuaskW
	 s0C5GhIPofCrw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE37C43602;
	Thu,  2 Jul 2026 09:57:22 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Thu, 02 Jul 2026 11:55:54 +0200
Subject: [PATCH v8 1/8] dt-bindings: mfd: khadas: Add new compatible for
 Khadas VIM4 MCU
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-add-mcu-fan-khadas-vim4-v8-1-244feee91a36@aliel.fr>
References: <20260702-add-mcu-fan-khadas-vim4-v8-0-244feee91a36@aliel.fr>
In-Reply-To: <20260702-add-mcu-fan-khadas-vim4-v8-0-244feee91a36@aliel.fr>
To: Neil Armstrong <neil.armstrong@linaro.org>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Beniamino Galvani <b.galvani@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
 Ronald Claveau <linux-kernel-dev@aliel.fr>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1479;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=eCKy2chdqFWw8sHr2BRKBa6cnfiYWQdTnn103pMuJ+4=;
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQ5ab6XeX7dHr73Ks/G34SLh81+fDB/YGXGv71HqjwI3d7
 lbHwi0GHaUsDGJcDLJiiiz9cy1PvLt89MzXPeopMHNYmUCGMHBxCsBEbqgy/NPruln4kpvl5RfT
 cwVT516em7TF98eBEx9zRA6sj06MSoxn+MOxK3/+v5CZHGvqj/FfPmZyYMfGoP7/P0/znAy09nK
 9VM0HAA==
X-Developer-Key: i=linux-kernel-dev@aliel.fr; a=openpgp;
 fpr=DFD863F61375BF917F0012173953305EF1D0EC3E
X-Endpoint-Received: by B4 Relay for linux-kernel-dev@aliel.fr/default with
 auth_id=744
X-Original-From: Ronald Claveau <linux-kernel-dev@aliel.fr>
Reply-To: linux-kernel-dev@aliel.fr

From: Ronald Claveau <linux-kernel-dev@aliel.fr>

The Khadas VIM4 MCU register is slightly different
from previous boards' MCU.
This board also features a switchable power source for its fan.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
---
 Documentation/devicetree/bindings/mfd/khadas,mcu.yaml | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/khadas,mcu.yaml b/Documentation/devicetree/bindings/mfd/khadas,mcu.yaml
index 084960fd5a1fd..1f135618e3b6f 100644
--- a/Documentation/devicetree/bindings/mfd/khadas,mcu.yaml
+++ b/Documentation/devicetree/bindings/mfd/khadas,mcu.yaml
@@ -18,6 +18,7 @@ properties:
   compatible:
     enum:
       - khadas,mcu # MCU revision is discoverable
+      - khadas,vim4-mcu # Different MCU variant, not discoverable
 
   "#cooling-cells": # Only needed for boards having FAN control feature
     const: 2
@@ -25,10 +26,27 @@ properties:
   reg:
     maxItems: 1
 
+  fan-supply:
+    description: Phandle to the regulator that powers the fan.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
 required:
   - compatible
   - reg
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: khadas,vim4-mcu
+    then:
+      required:
+        - fan-supply
+    else:
+      properties:
+        fan-supply: false
+
 additionalProperties: false
 
 examples:

-- 
2.49.0


