Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9323C9EE8;
	Thu, 11 Jun 2026 10:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781173296; cv=none; b=k+K5hYjGRXKq9eChY9Ug32CkJ2GUkLpPsrIVOBvvYQpy5kLiNaoXiz8rdGk9g3rxKqxVQAUyf3LWVmzpkKKqW5aUmMkUNFWV7AXrXRJNpNonyw4qKgbk3y9Y+8bQwpwVtPeNFN8/RoM9hXPN9/aFtopXv+Q7Ix1LmhcgU9CRlvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781173296; c=relaxed/simple;
	bh=6g2ccYzYXTOaDS/BYSugRku8m8jaURLjWfi6Ou6qRoM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HNT+nNCPMp7LAv2QayI9jwhHWEdaaxYPIZWCes6/68jmz8kd/JI7UrKE5E72FjLWLkYgvVYiW0LYV/aSlzMVfIiCtKPxKIWBkalSyGiZE0LWidb7yGcRx0VdZX3kMucRvMSzzSRQxXS1UgROXIh6hnwMTpLYgBEErp5y10ylQFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vOvGcmN6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vOvGcmN6"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 391BCC2BCC7;
	Thu, 11 Jun 2026 10:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781173296;
	bh=6g2ccYzYXTOaDS/BYSugRku8m8jaURLjWfi6Ou6qRoM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=vOvGcmN6mqaXEq02r2x/RGxlclPKHG+kX3RnZGY/ZMmN0Mc20jAW0Wdya6eC58y2y
	 kYg392m+34iQQlGewspLOV8jq/lCELllq1QVnY3GBERnNK+IwqmQOjEwx1FELdtND1
	 3TpXwLRn52d9Kdx6eymUJdUR2jDo6/a1oqRY3fyI/hW9udOA/B/9LafzLtdNg7sXqc
	 8WMjJMSPQJkJ95vTMRhNv72ntjJvsqZx8EiP54G5R7GqMcU0cC+3dlYSlbdILJ+EqU
	 LVdePIQwawQboT+L7uUtbXDgeSNh5K/zVgPpp/XdeRF66yspisVbv74k2QhnpOBHq2
	 eG/Gbl4tf2QLg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264C7CD98D2;
	Thu, 11 Jun 2026 10:21:36 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Date: Thu, 11 Jun 2026 13:20:29 +0300
Subject: [PATCH 1/4] dt-bindings: mfd: mediatek: mt6397: add mt6323 PMIC
 EFUSE
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-mt6323-nvmem-v1-1-b5e1b9ce51f2@protonmail.com>
References: <20260611-mt6323-nvmem-v1-0-b5e1b9ce51f2@protonmail.com>
In-Reply-To: <20260611-mt6323-nvmem-v1-0-b5e1b9ce51f2@protonmail.com>
To: Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Srinivas Kandagatla <srini@kernel.org>, 
 Roman Vivchar <rva333@protonmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Ben Grisdale <bengris32@protonmail.ch>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781173294; l=1528;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=Z+i5otfJXHcGSb/Mu1sxOt8XM4P2sXW7ssJy3Op5BOA=;
 b=gUhy/aA0enpF2VeL1vmKbLN5+5aZ3zuP73dUD/a/f91mu7DM4Fs8e/LpcnGOhwagXVx2aRZeA
 X9iv0Tj0NXFDRNngXQNm+ceQPH+VLbmGEVsPQGhjKDgkUYrURfsAO4K
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
Signed-off-by: Roman Vivchar <rva333@protonmail.com>
---
 .../devicetree/bindings/mfd/mediatek,mt6397.yaml    | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
index 05c121b0cb3d..beaa67bf0df2 100644
--- a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
+++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
@@ -145,6 +145,23 @@ properties:
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
@@ -243,6 +260,10 @@ examples:
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


