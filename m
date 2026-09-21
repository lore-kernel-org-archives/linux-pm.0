Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69E744A404;
	Mon, 21 Sep 2026 07:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789977029; cv=none; b=IOqWYlxsNitzdsucUBS6vsC/jWMWlpdgEqoEbG11zSd5qXqklKM+jg07byAOIDLCraIO2tzy6qpP759KdF1yuMiD4quG5rrFNW0S4Ujt3h5Pq6YxlPsVGzldYRfBQ33V6q/tbrZG4L1qP8z/rFHyBEFYdYGx185xjtQHXeQ+MLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789977029; c=relaxed/simple;
	bh=kvW2wtFi4KgEvcIkbiTYobALqwrfnuma/iDmVJ0C9Wk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SooGY8Azm1mIfB3uIbV5noX9qyLc8l1yYCJMA2zHa68fQ/Hi8MtPWs5BfOwWVB0VYeSqDaIh2Kx8Fdl+ENOe2PagHnKMmJuk7D538n4RnX6fj0OVajZpwCSEsjo2bvt/neblvfMx0ZaE9jHGZKqs03Q6QV3DD9PwXHC1jZToqMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JCY2WLvI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JCY2WLvI"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86F43C2BCF6;
	Mon, 21 Sep 2026 07:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789977028;
	bh=kvW2wtFi4KgEvcIkbiTYobALqwrfnuma/iDmVJ0C9Wk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=JCY2WLvIl5nZPSOAIBhKvER3EujbwB9twrDIeIHqSGi2yKO2udhEBxVy+spl1GmGR
	 QJJOrU//BingRMrHY4zzfXa49QYkV4k9kKyex8KQwX5w7OOFEKVAqexnyh9aTlnzwU
	 ilC3NYcBuuVkHPVJypad7XOzHq4Cy/8yG19ZT+IiD8IZ838wDO0tPb3PXKtAFTIHen
	 G15lO3AOuzUj7r5EFZgypn/pxQaGcFriBxjUKB6+X8DskQDmsAtyVtHPePHu6CIbeh
	 aNTha1p50JYI1Q6DWxiF1Om2orMTgxb1iFMC95dQBqGikRnV5K6wOt7tAm5lURwmVG
	 +VWYXHTkJFNoQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67403C982DE;
	Mon, 21 Sep 2026 07:50:28 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Date: Mon, 21 Sep 2026 10:50:02 +0300
Subject: [PATCH v5 1/3] dt-bindings: mfd: mediatek: mt6397: add mt6323 PMIC
 EFUSE
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-mt6323-nvmem-v5-1-2f5d308369f0@protonmail.com>
References: <20260921-mt6323-nvmem-v5-0-2f5d308369f0@protonmail.com>
In-Reply-To: <20260921-mt6323-nvmem-v5-0-2f5d308369f0@protonmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789977026; l=1581;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=mlQDk3dan2vmhf7s3FB34YUhH5UJAOcwjjg7f1t51Hs=;
 b=jYi5D0ZpLAxZPr3YuxJlL2rWdoMaE5b5z5VP9LMjKqdJENvJ79CzgDJIc1gBeZbyI5eG+j01t
 R7S0AxfYUrZAZnvzP99AP6o8K5RadBnk0wm2PN9zqZ56jlI/2zqdz8/
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


