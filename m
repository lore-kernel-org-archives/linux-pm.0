From: Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH v6 4/4] ARM64: dts: rockchip: add syscon-reboot-mode DT node
Date: Tue, 22 Mar 2016 19:38:58 +0800
Message-ID: <1458646738-687-1-git-send-email-andy.yan@rock-chips.com>
References: <1458646525-491-1-git-send-email-andy.yan@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1458646525-491-1-git-send-email-andy.yan@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, sre@kernel.org, heiko@sntech.de, john.stultz@linaro.org, arnd@arndb.de
Cc: galak@codeaurora.org, ijc+devicetree@hellion.org.uk, catalin.marinas@arm.com, olof@lixom.net, alexandre.belloni@free-electrons.com, dbaryshkov@gmail.com, jun.nie@linaro.org, pawel.moll@arm.com, will.deacon@arm.com, linux-rockchip@lists.infradead.org, matthias.bgg@gmail.com, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, f.fainelli@gmail.com, linux@arm.linux.org.uk, mbrugger@suse.com, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, moritz.fischer@ettus.com, linux-kernel@vger.kernel.org, wxt@rock-chips.com, dwmw2@infradead.org, mark.rutland@arm.com, Andy Yan <andy.yan@rock-chips.com>
List-Id: linux-pm@vger.kernel.org

Add syscon-reboot-mode driver DT node for rk3368 platform

Tested-by: Caesar Wang <caesar.upstream@gmail.com>
Signed-off-by: Andy Yan <andy.yan@rock-chips.com>

---

Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3:
- descirbe all reboot mode as properity instead of subnode

Changes in v2:
- make this node as a subnode of pmugrf

Changes in v1: None

 arch/arm64/boot/dts/rockchip/rk3368.dtsi | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
index 122777b..df062ea 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
@@ -45,6 +45,7 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/pinctrl/rockchip.h>
+#include <dt-bindings/soc/rockchip_boot-mode.h>
 #include <dt-bindings/thermal/thermal.h>
 
 / {
@@ -554,8 +555,17 @@
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
+			mode-bootloader = <BOOT_FASTBOOT>;
+			mode-loader = <BOOT_BL_DOWNLOAD>;
+		};
 	};
 
 	cru: clock-controller@ff760000 {
-- 
1.9.1
