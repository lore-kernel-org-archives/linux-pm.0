From: Romain Perier <romain.perier@gmail.com>
Subject: [PATCH v2 08/10] ARM: dts: tegra: Use standard power-off property in tps65911 for tegra30 beaver
Date: Mon, 27 Oct 2014 16:26:53 +0000
Message-ID: <1414427215-14380-8-git-send-email-romain.perier@gmail.com>
References: <1414427215-14380-1-git-send-email-romain.perier@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1414427215-14380-1-git-send-email-romain.perier@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: heiko@sntech.de
Cc: devicetree@vger.kernel.org, broonie@kernel.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, grant.likely@linaro.org, robh@kernel.org, mark.rutland@arm.com, johan@kernel.org, linux-pm@vger.kernel.org, linux@roeck-us.net, lee.jones@linaro.org, balbi@ti.com, robh+dt@kernel.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, swarren@wwwdotorg.org, thierry.reding@gmail.com, gnurou@gmail.com, linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Signed-off-by: Romain Perier <romain.perier@gmail.com>
---
 arch/arm/boot/dts/tegra30-beaver.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra30-beaver.dts b/arch/arm/boot/dts/tegra30-beaver.dts
index cee8f22..4abaf7f 100644
--- a/arch/arm/boot/dts/tegra30-beaver.dts
+++ b/arch/arm/boot/dts/tegra30-beaver.dts
@@ -188,7 +188,7 @@
 			#interrupt-cells = <2>;
 			interrupt-controller;
 
-			ti,system-power-controller;
+			system-power-controller;
 
 			#gpio-cells = <2>;
 			gpio-controller;
-- 
1.9.1
