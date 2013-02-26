From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH v4 4/8] ARM i.MX6q: Link system reset controller (SRC) to IPU in DT
Date: Tue, 26 Feb 2013 12:39:30 +0100
Message-ID: <1361878774-6382-5-git-send-email-p.zabel@pengutronix.de>
References: <1361878774-6382-1-git-send-email-p.zabel@pengutronix.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54324 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756051Ab3BZLkA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 26 Feb 2013 06:40:00 -0500
In-Reply-To: <1361878774-6382-1-git-send-email-p.zabel@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Stephen Warren <swarren@wwwdotorg.org>, Marek Vasut <marex@denx.de>, Fabio Estevam <fabio.estevam@freescale.com>, Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, kernel@pengutronix.de, devicetree-discuss@lists.ozlabs.org, Mike Turquette <mturquette@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Reviewed-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/imx6q.dtsi   |    1 +
 arch/arm/boot/dts/imx6qdl.dtsi |    2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index cba021e..4cd4f8d 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -291,6 +291,7 @@
 			interrupts = <0 8 0x4 0 7 0x4>;
 			clocks = <&clks 133>, <&clks 134>, <&clks 137>;
 			clock-names = "bus", "di0", "di1";
+			resets = <&src 4>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 06ec460..3e21e92 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -516,6 +516,7 @@
 				compatible = "fsl,imx6q-src";
 				reg = <0x020d8000 0x4000>;
 				interrupts = <0 91 0x04 0 96 0x04>;
+				#reset-cells = <1>;
 			};
 
 			gpc: gpc@020dc000 {
@@ -795,6 +796,7 @@
 			interrupts = <0 6 0x4 0 5 0x4>;
 			clocks = <&clks 130>, <&clks 131>, <&clks 132>;
 			clock-names = "bus", "di0", "di1";
+			resets = <&src 2>;
 		};
 	};
 };
-- 
1.7.10.4

