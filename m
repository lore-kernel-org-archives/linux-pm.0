From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH v4 7/8] ARM i.MX5: Add system reset controller (SRC) to i.MX51 and i.MX53 device tree
Date: Tue, 26 Feb 2013 12:39:33 +0100
Message-ID: <1361878774-6382-8-git-send-email-p.zabel@pengutronix.de>
References: <1361878774-6382-1-git-send-email-p.zabel@pengutronix.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54338 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756051Ab3BZLkC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 26 Feb 2013 06:40:02 -0500
In-Reply-To: <1361878774-6382-1-git-send-email-p.zabel@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Stephen Warren <swarren@wwwdotorg.org>, Marek Vasut <marex@denx.de>, Fabio Estevam <fabio.estevam@freescale.com>, Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, kernel@pengutronix.de, devicetree-discuss@lists.ozlabs.org, Mike Turquette <mturquette@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>

Also, link SRC to IPU via phandle.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Reviewed-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/imx51.dtsi |    7 +++++++
 arch/arm/boot/dts/imx53.dtsi |    7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index fcf035b..cfe4e92 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -67,6 +67,7 @@
 			compatible = "fsl,imx51-ipu";
 			reg = <0x40000000 0x20000000>;
 			interrupts = <11 10>;
+			resets = <&src 2>;
 		};
 
 		aips@70000000 { /* AIPS1 */
@@ -501,6 +502,12 @@
 				status = "disabled";
 			};
 
+			src: src@73fd0000 {
+				compatible = "fsl,imx51-src";
+				reg = <0x73fd0000 0x4000>;
+				#reset-cells = <1>;
+			};
+
 			clks: ccm@73fd4000{
 				compatible = "fsl,imx51-ccm";
 				reg = <0x73fd4000 0x4000>;
diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index d05aa21..9e1348d 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -72,6 +72,7 @@
 			compatible = "fsl,imx53-ipu";
 			reg = <0x18000000 0x080000000>;
 			interrupts = <11 10>;
+			resets = <&src 2>;
 		};
 
 		aips@50000000 { /* AIPS1 */
@@ -558,6 +559,12 @@
 				status = "disabled";
 			};
 
+			src: src@53fd0000 {
+				compatible = "fsl,imx53-src", "fsl,imx51-src";
+				reg = <0x53fd0000 0x4000>;
+				#reset-cells = <1>;
+			};
+
 			clks: ccm@53fd4000{
 				compatible = "fsl,imx53-ccm";
 				reg = <0x53fd4000 0x4000>;
-- 
1.7.10.4

