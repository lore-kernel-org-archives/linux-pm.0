From: Caesar Wang <wxt@rock-chips.com>
Subject: [PATCH 3/5] dt-bindings: rockchip-thermal: Support the RK3228/RK3399 SoCs compatible
Date: Wed, 25 Nov 2015 15:59:35 +0800
Message-ID: <1448438377-29203-4-git-send-email-wxt@rock-chips.com>
References: <1448438377-29203-1-git-send-email-wxt@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448438377-29203-1-git-send-email-wxt@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: linux-rockchip@lists.infradead.org, Heiko Stuebner <heiko@sntech.de>, Dan Carpenter <dan.carpenter@oracle.com>, Caesar Wang <wxt@rock-chips.com>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Kumar Gala <galak@codeaurora.org>, linux-kernel@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, Pawel Moll <pawel.moll@arm.com>, Zhang Rui <rui.zhang@intel.com>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-pm@vger.kernel.org

This patchset attempts to new compatible for thermal founding
on RK3228/RK3399 SoCs.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

 Documentation/devicetree/bindings/thermal/rockchip-thermal.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
index 0dfa60d..af5f802 100644
--- a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
@@ -2,8 +2,10 @@
 
 Required properties:
 - compatible : should be "rockchip,<name>-tsadc"
+   "rockchip,rk3228-tsadc": found on RK3228 SoCs
    "rockchip,rk3288-tsadc": found on RK3288 SoCs
    "rockchip,rk3368-tsadc": found on RK3368 SoCs
+   "rockchip,rk3368-tsadc": found on RK3399 SoCs
 - reg : physical base address of the controller and length of memory mapped
 	region.
 - interrupts : The interrupt number to the cpu. The interrupt specifier format
-- 
1.9.1
