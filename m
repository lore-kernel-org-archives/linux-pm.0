From: Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [RFC PATCH 1/8] ARM: dts: ls1021a: Fix clockgen node
Date: Thu, 18 Jun 2015 21:49:11 -0500
Message-ID: <1434682158-7243-2-git-send-email-scottwood@freescale.com>
References: <1434682158-7243-1-git-send-email-scottwood@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1434682158-7243-1-git-send-email-scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Tang Yuantian <Yuantian.Tang-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Liberman Igal-B31950 <Igal.Liberman-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Bucur Madalin-Cristian-B32716 <madalin.bucur-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Jingchang Lu <b35083-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

The binding requires compatible and reg properties, but the ls1021a
device tree does not contain them.  This will break with subsequent
clock driver changes.  If required (it's not clear to me whether the
ls1 code currently works at all -- I tried multi_v7_defconfig and it
didn't boot, whereas I was able to boot an SDK kernel), backwards
compatibility can be retained with a device tree fixup.

LS1021A also deviates from existing QorIQ clockgen practice by making
the sysclk node be a fixed-clock node rather than the U-Boot
compatibility hack of having a clock-frequency property in the clockgen
node itself, and a fsl,qoriq-sysclk-... node that exports the clock.
While this is not a violation of the existing binding, the upcoming
rework of the clock driver requires that a driver for the clockgen node
itself be able to find the input clock.  Thus, a clocks property is
added to reference the sysclk node.

Signed-off-by: Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Jingchang Lu <b35083-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 arch/arm/boot/dts/ls1021a.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index c70bb27..a0a1c51 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -146,9 +146,12 @@
 		};
 
 		clockgen: clocking@1ee1000 {
+			compatible = "fsl,ls201a-clockgen";
 			#address-cells = <1>;
 			#size-cells = <1>;
+			reg = <0 0x1ee1000 0x10000>;
 			ranges = <0x0 0x0 0x1ee1000 0x10000>;
+			clocks = <&sysclk>;
 
 			sysclk: sysclk {
 				compatible = "fixed-clock";
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
