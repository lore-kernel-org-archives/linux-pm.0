From: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
Subject: [PATCH v3 3/4] dt-bindings: add rpi power domain driver bindings
Date: Tue, 15 Dec 2015 13:40:21 -0800
Message-ID: <1450215622-27394-4-git-send-email-eric@anholt.net>
References: <1450215622-27394-1-git-send-email-eric@anholt.net>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1450215622-27394-1-git-send-email-eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Alexander Aring <alex.aring-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

From: Alexander Aring <alex.aring-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

This patch adds devicetree tree bindings for the Raspberry Pi power
domain driver.

Signed-off-by: Alexander Aring <alex.aring-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
