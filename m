From: Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH v3 02/13] dt-bindings: add binding for rk3036 power domains
Date: Wed, 23 May 2018 14:48:38 +0800
Message-ID: <1527058129-10260-3-git-send-email-zhangqing@rock-chips.com>
References: <1527058129-10260-1-git-send-email-zhangqing@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1527058129-10260-1-git-send-email-zhangqing@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: heiko@sntech.de, robh+dt@kernel.org, mark.rutland@arm.com
Cc: devicetree@vger.kernel.org, rjw@rjwysocki.net, khilman@kernel.org, ulf.hansson@linaro.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, wxt@rock-chips.com, xxx@rock-chips.com, xf@rock-chips.com, huangtao@rock-chips.com, Elaine Zhang <zhangqing@rock-chips.com>
List-Id: linux-pm@vger.kernel.org

From: Caesar Wang <wxt@rock-chips.com>

Add binding documentation for the power domains
found on Rockchip RK3036 SoCs.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/soc/rockchip/power_domain.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt b/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
index 301d2a9bc1b8..79924ee9ae86 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
+++ b/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
@@ -5,6 +5,7 @@ powered up/down by software based on different application scenes to save power.
 
 Required properties for power domain controller:
 - compatible: Should be one of the following.
+	"rockchip,rk3036-power-controller" - for RK3036 SoCs.
 	"rockchip,rk3288-power-controller" - for RK3288 SoCs.
 	"rockchip,rk3328-power-controller" - for RK3328 SoCs.
 	"rockchip,rk3366-power-controller" - for RK3366 SoCs.
@@ -17,6 +18,7 @@ Required properties for power domain controller:
 
 Required properties for power domain sub nodes:
 - reg: index of the power domain, should use macros in:
+	"include/dt-bindings/power/rk3036-power.h" - for RK3036 type power domain.
 	"include/dt-bindings/power/rk3288-power.h" - for RK3288 type power domain.
 	"include/dt-bindings/power/rk3328-power.h" - for RK3328 type power domain.
 	"include/dt-bindings/power/rk3366-power.h" - for RK3366 type power domain.
@@ -93,6 +95,7 @@ Node of a device using power domains must have a power-domains property,
 containing a phandle to the power device node and an index specifying which
 power domain to use.
 The index should use macros in:
+	"include/dt-bindings/power/rk3036-power.h" - for rk3036 type power domain.
 	"include/dt-bindings/power/rk3288-power.h" - for rk3288 type power domain.
 	"include/dt-bindings/power/rk3328-power.h" - for rk3328 type power domain.
 	"include/dt-bindings/power/rk3366-power.h" - for rk3366 type power domain.
-- 
1.9.1
