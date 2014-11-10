From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH v4 2/2] ARM: dts: keystone: add generic pm controller node
Date: Mon, 10 Nov 2014 16:59:17 +0200
Message-ID: <1415631557-22897-3-git-send-email-grygorii.strashko@ti.com>
References: <1415631557-22897-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1415631557-22897-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ssantosh@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, khilman@linaro.org
Cc: linux-pm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, grant.likely@secretlab.ca, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
List-Id: linux-pm@vger.kernel.org

Add TI Keystone 2 Generic PM Controller node and attach
the Davinci MDIO device to it.

CC: Kevin Hilman <khilman@linaro.org>
CC: Ulf Hansson <ulf.hansson@linaro.org>
CC: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 arch/arm/boot/dts/keystone.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/keystone.dtsi b/arch/arm/boot/dts/keystone.dtsi
index 5d3e83f..c669d0d 100644
--- a/arch/arm/boot/dts/keystone.dtsi
+++ b/arch/arm/boot/dts/keystone.dtsi
@@ -85,6 +85,11 @@
 
 		/include/ "keystone-clocks.dtsi"
 
+		pm_controller: pm-controller {
+			compatible = "ti,keystone-powerdomain";
+			#power-domain-cells = <0>;
+		};
+
 		uart0: serial@02530c00 {
 			compatible = "ns16550a";
 			current-speed = <115200>;
@@ -275,6 +280,7 @@
 			status = "disabled";
 			clocks = <&clkpa>;
 			clock-names = "fck";
+			power-domains = <&pm_controller>;
 			bus_freq	= <2500000>;
 		};
 
-- 
1.9.1
