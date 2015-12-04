From: Eric Anholt <eric@anholt.net>
Subject: [PATCH v2 5/5] ARM: bcm2835: Add the Raspberry Pi power domain driver to the DT.
Date: Fri,  4 Dec 2015 09:45:48 -0800
Message-ID: <1449251148-19344-6-git-send-email-eric@anholt.net>
References: <1449251148-19344-1-git-send-email-eric@anholt.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449251148-19344-1-git-send-email-eric@anholt.net>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Aring <alex.aring@gmail.com>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Eric Anholt <eric@anholt.net>
List-Id: linux-pm@vger.kernel.org

From: Alexander Aring <alex.aring@gmail.com>

This connects the USB driver to the USB power domain, so that USB can
actually be turned on at boot if the bootloader didn't do it for us.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
Signed-off-by: Eric Anholt <eric@anholt.net>
---
 arch/arm/boot/dts/bcm2835-rpi.dtsi | 11 +++++++++++
 arch/arm/boot/dts/bcm2835.dtsi     |  2 +-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/bcm2835-rpi.dtsi
index 3572f03..f828202 100644
--- a/arch/arm/boot/dts/bcm2835-rpi.dtsi
+++ b/arch/arm/boot/dts/bcm2835-rpi.dtsi
@@ -1,3 +1,4 @@
+#include <dt-bindings/arm/raspberrypi-power.h>
 #include "bcm2835.dtsi"
 
 / {
@@ -20,6 +21,12 @@
 			compatible = "raspberrypi,bcm2835-firmware";
 			mboxes = <&mailbox>;
 		};
+
+		power: power {
+			compatible = "raspberrypi,bcm2835-power";
+			firmware = <&firmware>;
+			#power-domain-cells = <1>;
+		};
 	};
 };
 
@@ -60,3 +67,7 @@
 	status = "okay";
 	bus-width = <4>;
 };
+
+&usb {
+	power-domains = <&power RPI_POWER_DOMAIN_USB>;
+};
diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
index aef64de..6d62af0 100644
--- a/arch/arm/boot/dts/bcm2835.dtsi
+++ b/arch/arm/boot/dts/bcm2835.dtsi
@@ -177,7 +177,7 @@
 			status = "disabled";
 		};
 
-		usb@7e980000 {
+		usb: usb@7e980000 {
 			compatible = "brcm,bcm2835-usb";
 			reg = <0x7e980000 0x10000>;
 			interrupts = <1 9>;
-- 
2.6.2
