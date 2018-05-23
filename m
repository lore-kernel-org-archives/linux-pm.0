From: Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH v3 12/13] dt-bindings: add binding for px30 power domains
Date: Wed, 23 May 2018 14:52:51 +0800
Message-ID: <1527058371-10706-1-git-send-email-zhangqing@rock-chips.com>
References: <1527058129-10260-1-git-send-email-zhangqing@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1527058129-10260-1-git-send-email-zhangqing@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: heiko@sntech.de, robh+dt@kernel.org, mark.rutland@arm.com
Cc: devicetree@vger.kernel.org, rjw@rjwysocki.net, khilman@kernel.org, ulf.hansson@linaro.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, wxt@rock-chips.com, xxx@rock-chips.com, xf@rock-chips.com, huangtao@rock-chips.com, Finley Xiao <finley.xiao@rock-chips.com>, Elaine Zhang <zhangqing@rock-chips.com>
List-Id: linux-pm@vger.kernel.org

From: Finley Xiao <finley.xiao@rock-chips.com>

Add binding documentation for the power domains
found on Rockchip PX30 SoCs.

Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 Documentation/devicetree/bindings/soc/rockchip/power_domain.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt b/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
index affe36dcfa17..5d49d0a2ff29 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
+++ b/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
@@ -5,6 +5,7 @@ powered up/down by software based on different application scenes to save power.
 
 Required properties for power domain controller:
 - compatible: Should be one of the following.
+	"rockchip,px30-power-controller" - for PX30 SoCs.
 	"rockchip,rk3036-power-controller" - for RK3036 SoCs.
 	"rockchip,rk3128-power-controller" - for RK3128 SoCs.
 	"rockchip,rk3228-power-controller" - for RK3228 SoCs.
@@ -20,6 +21,7 @@ Required properties for power domain controller:
 
 Required properties for power domain sub nodes:
 - reg: index of the power domain, should use macros in:
+	"include/dt-bindings/power/px30-power.h" - for PX30 type power domain.
 	"include/dt-bindings/power/rk3036-power.h" - for RK3036 type power domain.
 	"include/dt-bindings/power/rk3128-power.h" - for RK3128 type power domain.
 	"include/dt-bindings/power/rk3228-power.h" - for RK3228 type power domain.
@@ -99,6 +101,7 @@ Node of a device using power domains must have a power-domains property,
 containing a phandle to the power device node and an index specifying which
 power domain to use.
 The index should use macros in:
+	"include/dt-bindings/power/px30-power.h" - for px30 type power domain.
 	"include/dt-bindings/power/rk3036-power.h" - for rk3036 type power domain.
 	"include/dt-bindings/power/rk3128-power.h" - for rk3128 type power domain.
 	"include/dt-bindings/power/rk3128-power.h" - for rk3228 type power domain.
-- 
1.9.1
