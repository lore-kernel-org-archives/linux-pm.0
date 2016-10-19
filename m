From: Alexander Kurz <akurz-3EoFODjbY6Q@public.gmane.org>
Subject: [PATCH 1/2] power_supply: Add OF bindings documentation for max14656_charger_detector
Date: Wed, 19 Oct 2016 18:04:48 +0200
Message-ID: <1476893089-7233-1-git-send-email-akurz@blala.de>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexander Kurz <akurz-3EoFODjbY6Q@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Signed-off-by: Alexander Kurz <akurz-3EoFODjbY6Q@public.gmane.org>
---
 .../bindings/power_supply/maxim,max14656.txt       | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power_supply/maxim,max14656.txt

diff --git a/Documentation/devicetree/bindings/power_supply/maxim,max14656.txt b/Documentation/devicetree/bindings/power_supply/maxim,max14656.txt
new file mode 100644
index 0000000..e03e85a
--- /dev/null
+++ b/Documentation/devicetree/bindings/power_supply/maxim,max14656.txt
@@ -0,0 +1,25 @@
+Maxim MAX14656 / AL32 USB Charger Detector
+
+Required properties :
+- compatible : "maxim,max14656";
+- reg: i2c slave address
+- interrupt-parent: the phandle for the interrupt controller
+- interrupts: interrupt line
+
+Example:
+
+&i2c2 {
+	clock-frequency = <50000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	status = "okay";
+
+	max14656@35 {
+		compatible = "maxim,max14656";
+		reg = <0x35>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_charger_detect>;
+		interrupt-parent = <&gpio6>;
+		interrupts = <26 IRQ_TYPE_LEVEL_HIGH>;
+	};
+};
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
