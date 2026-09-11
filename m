Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B7C421257;
	Fri, 11 Sep 2026 06:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789108434; cv=none; b=tBxLy+rbsfIJvgRvym+a0zlOHO2XaILINCI8cNfDuCmzZol9T/x+ni/ezdNWfpxeJXo1GKQOcW6p+6EMJwobKk52nvV93rJ40qF3E0YZM5k/l8+Xv9UN0QXtEXyqyUnR01G9nbLZUkMQb95Robl1pp3t6U7vTNlNI0hHgUpahxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789108434; c=relaxed/simple;
	bh=kvW2wtFi4KgEvcIkbiTYobALqwrfnuma/iDmVJ0C9Wk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WbzBxG77FMDEGYULFAp/4WVuoVnakbBzsJYdcr2zaewdxtyR5YZ4EVCqsWkxFLBsjcXLxDItUA6SUu8XkkEiXBOY4X1oQZZB2EsznJuo7LS8ROkdpTNJl0xNJMxpJtLUOAL43Z4LVOYQ4XP1Fi80NDPWS69hJOCteMEC4Al+Ek4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AYI6nmwP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AYI6nmwP"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 95637C2BCFA;
	Fri, 11 Sep 2026 06:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789108433;
	bh=kvW2wtFi4KgEvcIkbiTYobALqwrfnuma/iDmVJ0C9Wk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=AYI6nmwPSdYdltjj9GpJ9DAedXZR40+F9HFQWr+AaNt61iydMijzVsKfUYA5YAbFW
	 ZSCmwpQx1HUJKIrB8h9IUBFyLuQ/NrG//0Jf7Tj9J7fl3D+SCeAxpDNYzy4MQXSKIg
	 Ep6Jr53Dbaw5GpVH+Cc2sXkagymEY47juQtYZ+yN1741Rrs3J1btw0BenF+kMslNTA
	 vWrPHtDu+ePgv10hY5oljohWKiaMDDaxG+mrw75WhDFpW+u0zpBCwACfOJsdo2a8ng
	 urngl0ob5K/ydjJB8GuVZSJvYiowOHGKt8FeG8Mbic3+mqZPKCliI53LI9frWic1qG
	 Nt5qpllb0y5IQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DFEC79FA1;
	Fri, 11 Sep 2026 06:33:53 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Date: Fri, 11 Sep 2026 09:32:59 +0300
Subject: [PATCH v4 1/3] dt-bindings: mfd: mediatek: mt6397: add mt6323 PMIC
 EFUSE
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-mt6323-nvmem-v4-1-626dd17531dc@protonmail.com>
References: <20260911-mt6323-nvmem-v4-0-626dd17531dc@protonmail.com>
In-Reply-To: <20260911-mt6323-nvmem-v4-0-626dd17531dc@protonmail.com>
To: Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Srinivas Kandagatla <srini@kernel.org>, 
 Roman Vivchar <rva333@protonmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Ben Grisdale <bengris32@protonmail.ch>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789108431; l=1581;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=mlQDk3dan2vmhf7s3FB34YUhH5UJAOcwjjg7f1t51Hs=;
 b=2CS6utLoEJsNFo8nIKiCYuhbBkQWR9dClbRpPcH4Ei0LFgNuWV/z6WWzhdy2Nzr8ALvDkq/2k
 cbslbn0KGWuCE+2x9n68+4rJKJ03zOyVLAZ9ML7qu+MKhNSdXlchMHE
X-Developer-Key: i=rva333@protonmail.com; a=ed25519;
 pk=zww/nWjBGoQ4POXCG0BV6fx2iuXK6jx77rsKPA5YK5Y=
X-Endpoint-Received: by B4 Relay for rva333@protonmail.com/20260510 with
 auth_id=777
X-Original-From: Roman Vivchar <rva333@protonmail.com>
Reply-To: rva333@protonmail.com

From: Roman Vivchar <rva333@protonmail.com>

The MediaTek mt6323 PMIC includes an EFUSE used for storing calibration
data.

Add the devicetree binding documentation for the MediaTek mt6323 EFUSE.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Roman Vivchar <rva333@protonmail.com>
---
 .../devicetree/bindings/mfd/mediatek,mt6397.yaml    | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
index 3cbc0dc12c31..d2de227ae7a6 100644
--- a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
+++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
@@ -159,6 +159,23 @@ properties:
     required:
       - compatible
 
+  efuse:
+    type: object
+    unevaluatedProperties: false
+    description:
+      The efuse is responsible for storing calibration data, such as thermal
+      sensor calibration.
+
+    properties:
+      compatible:
+        const: mediatek,mt6323-efuse
+
+      nvmem-layout:
+        $ref: /schemas/nvmem/layouts/nvmem-layout.yaml#
+
+    required:
+      - compatible
+
   leds:
     type: object
     additionalProperties: false
@@ -307,6 +324,10 @@ examples:
         interrupt-controller;
         #interrupt-cells = <2>;
 
+        efuse {
+          compatible = "mediatek,mt6323-efuse";
+        };
+
         leds {
             compatible = "mediatek,mt6323-led";
             #address-cells = <1>;

-- 
2.55.0


