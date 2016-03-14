From: Enric Balletbo i Serra <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Subject: [PATCH v4 1/2] devicetree: Add UCS1002 USB Port Power Controller binding
Date: Mon, 14 Mar 2016 10:24:44 +0100
Message-ID: <1457947485-14140-2-git-send-email-enric.balletbo@collabora.com>
References: <1457947485-14140-1-git-send-email-enric.balletbo@collabora.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1457947485-14140-1-git-send-email-enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Sjoerd Simons <sjoerd.simons-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>, Martyn Welch <martyn.welch-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

The UCS1002-2 provides a USB port power switch for precise control of up
to 2.5 amperes continuous current.

You can add support to your board with current binding.

Example:

    ucs1002: ucs1002@57 {
             compatible = "microchip,ucs1002";
             reg = <0x57>;
    };

Signed-off-by: Enric Balletbo i Serra <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
Changes since v3:
- Added Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Changes since v2:
 - Rename microchip,current-limit to microchip,limit-microamps (Rob Herring)
Changes since v1:
 - Fix units, are microamps (Rob Herring)
 - Remove microchip,pin-ignore as is implied by absence of gpio properties (Rob
   Herring)
 - Group control gpios instead of use separate gpios. All control gpios must be
   set together (Enric Balletbo)

 .../devicetree/bindings/power/ucs1002.txt          | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/ucs1002.txt

diff --git a/Documentation/devicetree/bindings/power/ucs1002.txt b/Documentation/devicetree/bindings/power/ucs1002.txt
new file mode 100644
index 0000000..31f6e49
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/ucs1002.txt
@@ -0,0 +1,41 @@
+UCS1002-2 Programmable USB Port Power Controller with Charger Emulation bindings
+
+Required properties:
+- compatible: "microchip,ucs1002"
+- reg: integer, the I2C address of the device.
+
+Optional properties:
+- interrupt-parent: the phandle of the interrupt controller that services
+    interrupts for this device.
+- interrupts: interrupt specifiers for two interrupt sources.
+    - First interrupt specifier is for A_DET interrupt.
+    - Second interrupt specifier is for ALERT interrupt.
+- microchip,limit-microamps: integer, maximum current in microamps. Note that the
+    default value is based on the resistor on the COMM_SEL/ILIM pin and this
+    value cannot be changed to be higher than hardware set value. Accepted
+    values are: 500000, 900000, 1000000, 1200000, 1500000, 1800000, 2000000 and
+    2500000 (microamps).
+- control-gpios = list of gpios used as pin states when determining the active mode
+    selection and power state. Must provide EM_EN, M1, M2 and PWR_EN gpio mapping.
+    If this property is not set it uses I2C for configuration.
+
+Example (polling):
+
+	ucs1002: ucs1002@57 {
+		compatible = "microchip,ucs1002";
+		reg = <0x57>;
+		microchip,limit-microamps = <2000000>;
+	};
+
+Example (interrupts + control gpios):
+
+	ucs1002: ucs1002@57 {
+		compatible = "microchip,ucs1002";
+		reg = <0x57>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <30 0>, <31 0>;
+		control-gpios = <&gpio0 2 GPIO_ACTIVE_HIGH>,	/* EM_EN */
+				<&gpio0 3 GPIO_ACTIVE_HIGH>,	/* M1 */
+				<&gpio1 17 GPIO_ACTIVE_HIGH>,	/* M2 */
+				<&gpio1 19 0>;			/* PWR_EN */
+	};
-- 
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
