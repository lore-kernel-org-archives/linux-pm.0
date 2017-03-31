From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH V3 1/2] dt-bindings: thermal: add support for Broadcom's Northstar thermal
Date: Fri, 31 Mar 2017 09:31:31 +0200
Message-ID: <20170331073132.21457-1-zajec5@gmail.com>
References: <20170323223045.15786-1-zajec5@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170323223045.15786-1-zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal-g1n6cQUeyibVItvQsEIGlw@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

From: Rafał Miłecki <rafal-g1n6cQUeyibVItvQsEIGlw@public.gmane.org>

This commit documents binding for thermal used in Northstar family SoCs.

Signed-off-by: Rafał Miłecki <rafal-g1n6cQUeyibVItvQsEIGlw@public.gmane.org>
---
V3: Add thermal-zones to the example
    Rob: Because of this update, I didn't include Acked-by I got for V2
---
 .../devicetree/bindings/thermal/brcm,ns-thermal    | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/brcm,ns-thermal

diff --git a/Documentation/devicetree/bindings/thermal/brcm,ns-thermal b/Documentation/devicetree/bindings/thermal/brcm,ns-thermal
new file mode 100644
index 000000000000..c561c7349f17
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/brcm,ns-thermal
@@ -0,0 +1,26 @@
+* Broadcom Northstar Thermal
+
+This binding describes thermal sensor that is part of Northstar's DMU (Device
+Management Unit).
+
+Required properties:
+- compatible : Must be "brcm,ns-thermal"
+- reg : iomem address range of PVTMON registers
+- #thermal-sensor-cells : Should be <0>
+
+Example:
+
+thermal: thermal@1800c2c0 {
+	compatible = "brcm,ns-thermal";
+	reg = <0x1800c2c0 0x10>;
+	#thermal-sensor-cells = <0>;
+};
+
+thermal-zones {
+	cpu_thermal: cpu-thermal {
+		polling-delay-passive = <0>;
+		polling-delay = <1000>;
+		coefficients = <(-556) 418000>;
+		thermal-sensors = <&thermal>;
+	};
+};
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
