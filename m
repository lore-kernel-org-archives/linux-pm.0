From: Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH v3 4/4] ARM64: dts: rockchip: add syscon-reboot-mode DT node
Date: Tue,  2 Feb 2016 18:13:19 +0800
Message-ID: <1454407999-5476-1-git-send-email-andy.yan@rock-chips.com>
References: <1454406981-4692-1-git-send-email-andy.yan@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1454406981-4692-1-git-send-email-andy.yan@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, arnd@arndb.de, john.stultz@linaro.org
Cc: moritz.fischer@ettus.com, matthias.bgg@gmail.com, galak@codeaurora.org, ijc+devicetree@hellion.org.uk, catalin.marinas@arm.com, heiko@sntech.de, sre@kernel.org, dbaryshkov@gmail.com, alexandre.belloni@free-electrons.com, jun.nie@linaro.org, pawel.moll@arm.com, will.deacon@arm.com, linux-rockchip@lists.infradead.org, wxt@rock-chips.com, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux@arm.linux.org.uk, mbrugger@suse.com, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, linux-kernel@vger.kernel.org, richard@nod.at, dwmw2@infradead.org, mark.rutland@arm.com, Andy Yan <andy.yan@rock-chips.com>
List-Id: linux-pm@vger.kernel.org

Add syscon-reboot-mode driver DT node for rk3368 platform

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>

---

Changes in v3:
- descirbe all reboot mode as property instead of subnode

Changes in v2:
- make this node as a subnode of pmugrf

Changes in v1: None

 arch/arm64/boot/dts/rockchip/rk3368.dtsi | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
index 122777b..5213713 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
@@ -45,6 +45,7 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/pinctrl/rockchip.h>
+#include <dt-bindings/soc/rockchip_boot-mode.h>
 #include <dt-bindings/thermal/thermal.h>
 
 / {
@@ -554,8 +555,19 @@
 	};
 
 	pmugrf: syscon@ff738000 {
-		compatible = "rockchip,rk3368-pmugrf", "syscon";
+		compatible = "rockchip,rk3368-pmugrf", "syscon", "simple-mfd";
 		reg = <0x0 0xff738000 0x0 0x1000>;
+
+		reboot-mode {
+			compatible = "syscon-reboot-mode";
+			offset = <0x200>;
+			mode-normal = <BOOT_NORMAL>;
+			mode-recovery = <BOOT_RECOVERY>;
+			mode-fastboot = <BOOT_FASTBOOT>;
+			mode-loader = <BOOT_LOADER>;
+			mode-maskrom = <BOOT_MASKROM>;
+
+		};
 	};
 
 	cru: clock-controller@ff760000 {
-- 
1.9.1
