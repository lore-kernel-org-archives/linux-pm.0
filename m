From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 14/15] thermal: Add Mediatek thermal controller support
Date: Fri, 15 May 2015 08:12:22 +0200
Message-ID: <20150515061222.GK6325@pengutronix.de>
References: <1431507163-19933-1-git-send-email-s.hauer@pengutronix.de>
 <1431507163-19933-15-git-send-email-s.hauer@pengutronix.de>
 <1431597146.2650.59.camel@x220>
 <CABicQ-XxXbMMnYyFAst=Xk1HMOXc6N1-J1bvyutMFY_=iNd0fg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46673 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752138AbbEOGMu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 15 May 2015 02:12:50 -0400
Content-Disposition: inline
In-Reply-To: <CABicQ-XxXbMMnYyFAst=Xk1HMOXc6N1-J1bvyutMFY_=iNd0fg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wei-Ning Huang <wnhuang@google.com>
Cc: Paul Bolle <pebolle@tiscali.nl>, Stephen Warren <swarren@wwwdotorg.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>, Mikko Perttunen <mikko.perttunen@kapsi.fi>, linux-mediatek@lists.infradead.org, kernel@pengutronix.de, Zhang Rui <rui.zhang@intel.com>, Brian Norris <computersforpeace@gmail.com>, linux-arm-kernel@lists.infradead.org

Hi Wei-Ning,

On Fri, May 15, 2015 at 01:33:02PM +0800, Wei-Ning Huang wrote:
>    Hi Sascha,
>    I tried these patches but I didn't see any entries under
>    '/sys/class/thermal', am I missing something?
>    Wei-Ning

Please write a mail to me rather than to Paul if you want me to react.

You'll need a dts snippet that registers a thermal zone. Try the
attached patch. I haven't posted it because it only contains my testing
code which registers a fake gpio controlled fan.

Sascha

-----------------------------8<-----------------------------

>From 2ea6d94fe430c317064d06b46a8d0d2036ca4236 Mon Sep 17 00:00:00 2001
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Tue, 12 May 2015 09:24:25 +0200
Subject: [PATCH] ARM64: dts: mt8173-evb: debugging: Add fake thermal zone

This adds a thermal zone for the CPU which is controlled by a fan. No
fan exists on this board and the temperatures are bogus. This is only
for debugging purposes until the cpufreq driver is available.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts | 39 +++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
index 43d5401..0a1f905 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
@@ -14,6 +14,7 @@
 
 /dts-v1/;
 #include "mt8173.dtsi"
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	model = "mediatek,mt8173-evb";
@@ -31,6 +32,44 @@
 	};
 
 	chosen { };
+
+	fan: gpio_fan {
+		compatible = "gpio-fan";
+		gpios = <&pio 24 0>;
+		gpio-fan,speed-map = <0    0
+				      4500 1>;
+		#cooling-cells = <2>;
+	};
+
+	thermal-zones {
+		cpu_thermal: cpu_thermal {
+			polling-delay-passive = <1000>; /* milliseconds */
+			polling-delay = <0>; /* milliseconds */
+
+			thermal-sensors = <&thermal 0>;
+
+			trips {
+				cpu_passive: cpu_passive {
+					temperature = <47000>; /* millicelsius */
+					hysteresis = <2000>; /* millicelsius */
+					type = "passive";
+				};
+
+				cpu_crit {
+					temperature = <90000>; /* millicelsius */
+					hysteresis = <2000>; /* millicelsius */
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu_passive>;
+					cooling-device = <&fan THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+	};
 };
 
 &uart0 {
-- 
2.1.4


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
