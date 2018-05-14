From: Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH v2 09/13] dt-bindings: add binding for rk3228 power domains
Date: Mon, 14 May 2018 11:31:24 +0800
Message-ID: <1526268684-22709-1-git-send-email-zhangqing@rock-chips.com>
References: <1526268455-9133-1-git-send-email-zhangqing@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1526268455-9133-1-git-send-email-zhangqing@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: heiko@sntech.de, robh+dt@kernel.org, mark.rutland@arm.com
Cc: devicetree@vger.kernel.org, rjw@rjwysocki.net, khilman@kernel.org, ulf.hansson@linaro.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, wxt@rock-chips.com, xxx@rock-chips.com, xf@rock-chips.com, huangtao@rock-chips.com, Elaine Zhang <zhangqing@rock-chips.com>
List-Id: linux-pm@vger.kernel.org

Add binding documentation for the power domains
found on Rockchip RK3228 SoCs.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 Documentation/devicetree/bindings/soc/rockchip/power_domain.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt b/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
index 9a3f5fd36a80..affe36dcfa17 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
+++ b/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
@@ -7,6 +7,7 @@ Required properties for power domain controller:
 - compatible: Should be one of the following.
 	"rockchip,rk3036-power-controller" - for RK3036 SoCs.
 	"rockchip,rk3128-power-controller" - for RK3128 SoCs.
+	"rockchip,rk3228-power-controller" - for RK3228 SoCs.
 	"rockchip,rk3288-power-controller" - for RK3288 SoCs.
 	"rockchip,rk3328-power-controller" - for RK3328 SoCs.
 	"rockchip,rk3366-power-controller" - for RK3366 SoCs.
@@ -21,6 +22,7 @@ Required properties for power domain sub nodes:
 - reg: index of the power domain, should use macros in:
 	"include/dt-bindings/power/rk3036-power.h" - for RK3036 type power domain.
 	"include/dt-bindings/power/rk3128-power.h" - for RK3128 type power domain.
+	"include/dt-bindings/power/rk3228-power.h" - for RK3228 type power domain.
 	"include/dt-bindings/power/rk3288-power.h" - for RK3288 type power domain.
 	"include/dt-bindings/power/rk3328-power.h" - for RK3328 type power domain.
 	"include/dt-bindings/power/rk3366-power.h" - for RK3366 type power domain.
@@ -99,6 +101,7 @@ power domain to use.
 The index should use macros in:
 	"include/dt-bindings/power/rk3036-power.h" - for rk3036 type power domain.
 	"include/dt-bindings/power/rk3128-power.h" - for rk3128 type power domain.
+	"include/dt-bindings/power/rk3128-power.h" - for rk3228 type power domain.
 	"include/dt-bindings/power/rk3288-power.h" - for rk3288 type power domain.
 	"include/dt-bindings/power/rk3328-power.h" - for rk3328 type power domain.
 	"include/dt-bindings/power/rk3366-power.h" - for rk3366 type power domain.
-- 
1.9.1
