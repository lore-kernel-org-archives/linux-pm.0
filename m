From: Eric Anholt <eric@anholt.net>
Subject: [PATCH v2 4/5] dt-bindings: add rpi power domain driver bindings
Date: Fri,  4 Dec 2015 09:45:47 -0800
Message-ID: <1449251148-19344-5-git-send-email-eric@anholt.net>
References: <1449251148-19344-1-git-send-email-eric@anholt.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449251148-19344-1-git-send-email-eric@anholt.net>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Aring <alex.aring@gmail.com>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Eric Anholt <eric@anholt.net>
List-Id: linux-pm@vger.kernel.org

From: Alexander Aring <alex.aring@gmail.com>

This patch adds devicetree tree bindings for the Raspberry Pi power
domain driver.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Eric Anholt <eric@anholt.net>
---

v2: Add the new domains present in v2 to the list.

 .../bindings/arm/bcm/raspberrypi,bcm2835-power.txt | 47 ++++++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-power.txt

diff --git a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-power.txt b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-power.txt
new file mode 100644
index 0000000..30942cf
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-power.txt
@@ -0,0 +1,47 @@
+Raspberry Pi power domain driver
+
+Required properties:
+
+- compatible:		Should be "raspberrypi,bcm2835-power".
+- firmware:		Reference to the RPi firmware device node.
+- #power-domain-cells:	Should be <1>, we providing multiple power domains.
+
+The valid defines for power domain are:
+
+ RPI_POWER_DOMAIN_I2C0
+ RPI_POWER_DOMAIN_I2C1
+ RPI_POWER_DOMAIN_I2C2
+ RPI_POWER_DOMAIN_VIDEO_SCALER
+ RPI_POWER_DOMAIN_VPU1
+ RPI_POWER_DOMAIN_HDMI
+ RPI_POWER_DOMAIN_USB
+ RPI_POWER_DOMAIN_VEC
+ RPI_POWER_DOMAIN_JPEG
+ RPI_POWER_DOMAIN_H264
+ RPI_POWER_DOMAIN_V3D
+ RPI_POWER_DOMAIN_ISP
+ RPI_POWER_DOMAIN_UNICAM0
+ RPI_POWER_DOMAIN_UNICAM1
+ RPI_POWER_DOMAIN_CCP2RX
+ RPI_POWER_DOMAIN_CSI2
+ RPI_POWER_DOMAIN_CPI
+ RPI_POWER_DOMAIN_DSI0
+ RPI_POWER_DOMAIN_DSI1
+ RPI_POWER_DOMAIN_TRANSPOSER
+ RPI_POWER_DOMAIN_CCP2TX
+ RPI_POWER_DOMAIN_CDP
+ RPI_POWER_DOMAIN_ARM
+
+Example:
+
+power: power {
+	compatible = "raspberrypi,bcm2835-power";
+	firmware = <&firmware>;
+	#power-domain-cells = <1>;
+};
+
+Example for using power domain:
+
+&usb {
+       power-domains = <&power RPI_POWER_DOMAIN_USB>;
+};
-- 
2.6.2
