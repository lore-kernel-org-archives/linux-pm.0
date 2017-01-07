From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 1/4] ARM: dts: exynos: Fix indentation of EHCI and OHCI ports
Date: Sat,  7 Jan 2017 10:52:00 +0200
Message-ID: <20170107085203.4431-2-krzk@kernel.org>
References: <20170107085203.4431-1-krzk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170107085203.4431-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Anand Moon <linux.amoon@gmail.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Peter Chen <peter.chen@nxp.com>, gregkh@linuxfoundation.org, stern@rowland.harvard.edu, ulf.hansson@linaro.org, broonie@kernel.org, sre@kernel.org, robh+dt@kernel.org, linux-usb@vger.kernel.org, linux-pm@vger.kernel.org, hverkuil@xs4all.nl, Markus Reichl <m.reichl@fivetechno.de>
List-Id: linux-pm@vger.kernel.org

Replace spaces with tabs in EHCI and OHCI ports indentation.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos4.dtsi | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index c64737baa45e..3209c60389e2 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -370,19 +370,19 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		port@0 {
-		    reg = <0>;
-		    phys = <&exynos_usbphy 1>;
-		    status = "disabled";
+			reg = <0>;
+			phys = <&exynos_usbphy 1>;
+			status = "disabled";
 		};
 		port@1 {
-		    reg = <1>;
-		    phys = <&exynos_usbphy 2>;
-		    status = "disabled";
+			reg = <1>;
+			phys = <&exynos_usbphy 2>;
+			status = "disabled";
 		};
 		port@2 {
-		    reg = <2>;
-		    phys = <&exynos_usbphy 3>;
-		    status = "disabled";
+			reg = <2>;
+			phys = <&exynos_usbphy 3>;
+			status = "disabled";
 		};
 	};
 
@@ -396,9 +396,9 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		port@0 {
-		    reg = <0>;
-		    phys = <&exynos_usbphy 1>;
-		    status = "disabled";
+			reg = <0>;
+			phys = <&exynos_usbphy 1>;
+			status = "disabled";
 		};
 	};
 
-- 
2.9.3
