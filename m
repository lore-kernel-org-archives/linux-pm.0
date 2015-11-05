From: Caesar Wang <wxt@rock-chips.com>
Subject: [PATCH v2 1/9] dt-bindings: rockchip-thermal: Support the RK3368 SoCs compatible
Date: Thu,  5 Nov 2015 13:17:57 +0800
Message-ID: <1446700685-18017-2-git-send-email-wxt@rock-chips.com>
References: <1446700685-18017-1-git-send-email-wxt@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1446700685-18017-1-git-send-email-wxt@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Heiko Stuebner <heiko@sntech.de>, Eduardo Valentin <edubezval@gmail.com>
Cc: linux-rockchip@lists.infradead.org, Caesar Wang <wxt@rock-chips.com>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Kumar Gala <galak@codeaurora.org>, linux-kernel@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, Pawel Moll <pawel.moll@arm.com>, Zhang Rui <rui.zhang@intel.com>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-pm@vger.kernel.org

This patchset attempts to new compatible for thermal founding
on RK3368 SoCs.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

Changes in v2: None
Changes in v1:
- %s/thermal/rockchip-thermal in subject.

 Documentation/devicetree/bindings/thermal/rockchip-thermal.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
index b38200d..0dfa60d 100644
--- a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
@@ -1,7 +1,9 @@
 * Temperature Sensor ADC (TSADC) on rockchip SoCs
 
 Required properties:
-- compatible : "rockchip,rk3288-tsadc"
+- compatible : should be "rockchip,<name>-tsadc"
+   "rockchip,rk3288-tsadc": found on RK3288 SoCs
+   "rockchip,rk3368-tsadc": found on RK3368 SoCs
 - reg : physical base address of the controller and length of memory mapped
 	region.
 - interrupts : The interrupt number to the cpu. The interrupt specifier format
-- 
1.9.1
