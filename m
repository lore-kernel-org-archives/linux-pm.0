Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CCF3E2AB7;
	Mon, 13 Jul 2026 10:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783937515; cv=none; b=WiLv2uxAWTA8k5QdLC6C84g1P0bDBjFEacDOD7o9doZMTZWuBRV+70YBjPadX4QBJsA+OQYYZRDjP4G5ZX5f8NKD79RuUFXcN9OsDisB/WHUiQZnsgv1C1i9MzRgO20SRt9yttp5HGs5E+uRF0rhZl28p6ZWZOaGOgEGmi+uzcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783937515; c=relaxed/simple;
	bh=unJmQzNev+wc/XonplIFxuHuxl8OisQRGUgkkiRKuHw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sOL81LJUfdfAuMDf5l00LwWB5g/iEW38aYgh8fjN3Es6HIxsNTIN45ecVze+ZFXKvNDHe8XTKcigP2lKZyxQ/Ez/L959ezcgsJXvHl13ZFJ1q5g0roxfhpFkb5QuI7m3+UsQ5K0rDVAMDLeSUh24Xd4dtXSiZ95iTX8HMKP/dIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HMOY7Cgf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HMOY7Cgf"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 93087C2BCF5;
	Mon, 13 Jul 2026 10:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783937514;
	bh=unJmQzNev+wc/XonplIFxuHuxl8OisQRGUgkkiRKuHw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=HMOY7CgfXoJt7xSKuSK8TApu5VhYYrSq77WIiQ4m9NgyV1lJmtVWSpjKR7e+YmjqW
	 lmyej9wBsFhQWEUidDRfiF+/FDub5psNMFer4DxM/3mB/OmDjYR9WHPBPCMWrlgqI6
	 oO04hPOhHFFSiZX19cSmtAXAYSA4t3fqmVr3XC055wY6gIqaRYl/UegLCFn8mOoyJv
	 gbrwtweowpO7YI+OKepFRl5k/2yV7fHPgw6SSn4e6Nbj7BLF/IryGsFV993at6JDqR
	 ixV+i+et5D+AXTcQhWrycnGeOl61hgLjq1DNfzSRtADfnPvi2ZKA8Wsu0Zn8iPrDgR
	 7+89oXLwFgNxw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73656C44501;
	Mon, 13 Jul 2026 10:11:54 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Date: Mon, 13 Jul 2026 13:11:35 +0300
Subject: [PATCH v3 1/3] dt-bindings: mfd: mediatek: mt6397: add mt6323 PMIC
 EFUSE
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-mt6323-nvmem-v3-1-205c39267a24@protonmail.com>
References: <20260713-mt6323-nvmem-v3-0-205c39267a24@protonmail.com>
In-Reply-To: <20260713-mt6323-nvmem-v3-0-205c39267a24@protonmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783937511; l=1581;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=GM6D7bsLXgjkmPGbknhST0foltxWwO4ZLs1IqERzFkY=;
 b=FwwvAy8himvy5YZ1J9eonMBklU4ZWtpIaLoNDmr12DsdCkTTMeVfz8uLMSN3GfBEKjYqj9gDd
 MB2Raaed6x7BEKPuK8y0xU/bkrkuLbbRydt3pLsLCa4iGetSTstGEfK
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
2.54.0


