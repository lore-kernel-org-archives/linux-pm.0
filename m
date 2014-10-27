From: Romain Perier <romain.perier@gmail.com>
Subject: [PATCH v2 04/10] ARM: dts: rockchip: Enable power off in pmic for Radxa Rock
Date: Mon, 27 Oct 2014 16:26:49 +0000
Message-ID: <1414427215-14380-4-git-send-email-romain.perier@gmail.com>
References: <1414427215-14380-1-git-send-email-romain.perier@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1414427215-14380-1-git-send-email-romain.perier@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: heiko@sntech.de
Cc: devicetree@vger.kernel.org, broonie@kernel.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, grant.likely@linaro.org, robh@kernel.org, mark.rutland@arm.com, johan@kernel.org, linux-pm@vger.kernel.org, linux@roeck-us.net, lee.jones@linaro.org, balbi@ti.com, robh+dt@kernel.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, swarren@wwwdotorg.org, thierry.reding@gmail.com, gnurou@gmail.com, linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Add "system-power-controller" property to act8846 node.
poweroff command is now handled for this board.

Signed-off-by: Romain Perier <romain.perier@gmail.com>
---
 arch/arm/boot/dts/rk3188-radxarock.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/rk3188-radxarock.dts b/arch/arm/boot/dts/rk3188-radxarock.dts
index 15910c9..a6ead3a 100644
--- a/arch/arm/boot/dts/rk3188-radxarock.dts
+++ b/arch/arm/boot/dts/rk3188-radxarock.dts
@@ -141,6 +141,8 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&act8846_dvs0_ctl>;
 
+		system-power-controller;
+
 		regulators {
 			vcc_ddr: REG1 {
 				regulator-name = "VCC_DDR";
-- 
1.9.1
