From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH V2 1/2] dt-bindings: thermal: add support for Raspberry Pi thermal
Date: Sat, 18 Mar 2017 01:06:02 +0100
Message-ID: <20170318000603.10158-1-zajec5@gmail.com>
References: <20170318000132.9212-1-zajec5@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170318000132.9212-1-zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal-g1n6cQUeyibVItvQsEIGlw@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

From: Rafał Miłecki <rafal-g1n6cQUeyibVItvQsEIGlw@public.gmane.org>

This commit documents binding for BCM2835 SoC thermal used in Raspberry
Pi devices.

Signed-off-by: Rafał Miłecki <rafal-g1n6cQUeyibVItvQsEIGlw@public.gmane.org>
---
 .../bindings/thermal/raspberrypi,bcm2835-thermal        | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/raspberrypi,bcm2835-thermal

diff --git a/Documentation/devicetree/bindings/thermal/raspberrypi,bcm2835-thermal b/Documentation/devicetree/bindings/thermal/raspberrypi,bcm2835-thermal
new file mode 100644
index 000000000000..fbffa9291ba9
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/raspberrypi,bcm2835-thermal
@@ -0,0 +1,17 @@
+* Broadcom BCM2835 SoC Raspberry Pi Thermal
+
+This binding describes thermal sensor that is part of BCM2835 SoC.
+
+Required properties:
+- compatible : Must be "raspberrypi,bcm2835-thermal"
+- firmware : Reference to the Raspberry Pi firmware device node, see
+	raspberrypi,bcm2835-firmware for details
+- #thermal-sensor-cells : Should be <0>
+
+Example:
+
+thermal {
+	compatible = "raspberrypi,bcm2835-thermal";
+	firmware = <&firmware>;
+	#thermal-sensor-cells = <0>;
+};
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
