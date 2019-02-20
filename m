From: <michael.kao@mediatek.com>
Subject: [PATCH v2,6/7] dt-bindings: thermal: add binding document for mt8183 thermal controller
Date: Wed, 20 Feb 2019 20:31:32 +0800
Message-ID: <1550665893-22561-7-git-send-email-michael.kao@mediatek.com>
References: <1550665893-22561-1-git-send-email-michael.kao@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1550665893-22561-1-git-send-email-michael.kao@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, Michael Kao <michael.kao@mediatek.com>
List-Id: linux-pm@vger.kernel.org

From: Michael Kao <michael.kao@mediatek.com>

This patch adds binding document for mt8183 thermal controller.

Signed-off-by: Michael Kao <michael.kao@mediatek.com>
---
 Documentation/devicetree/bindings/thermal/mediatek-thermal.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt b/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
index 41d6a44..f8d7831 100644
--- a/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
@@ -13,6 +13,7 @@ Required properties:
   - "mediatek,mt2701-thermal" : For MT2701 family of SoCs
   - "mediatek,mt2712-thermal" : For MT2712 family of SoCs
   - "mediatek,mt7622-thermal" : For MT7622 SoC
+  - "mediatek,mt8183-thermal" : For MT8183 family of SoCs
 - reg: Address range of the thermal controller
 - interrupts: IRQ for the thermal controller
 - clocks, clock-names: Clocks needed for the thermal controller. required
-- 
1.9.1
