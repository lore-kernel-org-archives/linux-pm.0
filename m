From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH 1/3] dt-bindings: thermal: Add binding document for Mediatek
 thermal controller
Date: Mon, 31 Aug 2015 09:34:04 +0200
Message-ID: <1441006446-4558-2-git-send-email-s.hauer@pengutronix.de>
References: <1441006446-4558-1-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1441006446-4558-1-git-send-email-s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Signed-off-by: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Reviewed-by: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
---
 .../bindings/thermal/mediatek-thermal.txt          | 38 ++++++++++++++++++++++
 include/dt-bindings/thermal/mt8173.h               | 13 ++++++++
 2 files changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
 create mode 100644 include/dt-bindings/thermal/mt8173.h

diff --git a/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt b/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
new file mode 100644
index 0000000..1697375
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
@@ -0,0 +1,38 @@
+* Mediatek Thermal
+
+This describes the device tree binding for the Mediatek thermal controller
+which measures the on-SoC temperatures. This device does not have its own ADC,
+instead it directly controls the AUXADC via AHB bus accesses. For this reason
+this device needs phandles to the AUXADC. Also it controls a mux in the
+apmixedsys register space via AHB bus accesses, so a phandle to the APMIXEDSYS
+is also needed.
+
+Required properties:
+- compatible: "mediatek,mt8173-thermal"
+- reg: Address range of the thermal controller
+- interrupts: IRQ for the thermal controller
+- clocks, clock-names: Clocks needed for the thermal controller. required
+                       clocks are:
+		       "therm":	 Main clock needed for register access
+		       "auxadc": The AUXADC clock
+- resets: Reference to the reset controller controlling the thermal controller.
+- mediatek,auxadc: A phandle to the AUXADC which the thermal controller uses
+- mediatek,apmixedsys: A phandle to the APMIXEDSYS controller.
+- #thermal-sensor-cells : Should be 1. See ./thermal.txt for a description. See
+			  include/dt-bindings/thermal/mt8173.h for valid sensor
+			  numbers.
+
+Example:
+
+	thermal: thermal@1100b000 {
+		#thermal-sensor-cells = <1>;
+		compatible = "mediatek,mt8173-thermal";
+		reg = <0 0x1100b000 0 0x1000>;
+		interrupts = <0 70 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&pericfg CLK_PERI_THERM>, <&pericfg CLK_PERI_AUXADC>;
+		clock-names = "therm", "auxadc";
+		resets = <&pericfg MT8173_PERI_THERM_SW_RST>;
+		reset-names = "therm";
+		mediatek,auxadc = <&auxadc>;
+		mediatek,apmixedsys = <&apmixedsys>;
+	};
diff --git a/include/dt-bindings/thermal/mt8173.h b/include/dt-bindings/thermal/mt8173.h
new file mode 100644
index 0000000..692e74c
--- /dev/null
+++ b/include/dt-bindings/thermal/mt8173.h
@@ -0,0 +1,13 @@
+/*
+ * This header provides constants for mediatek,mt8173-thermal
+ */
+
+#ifndef _DT_BINDINGS_THERMAL_MEDIATEK_MT8173_H
+#define _DT_BINDINGS_THERMAL_MEDIATEK_MT8173_H
+
+#define MT8173_THERMAL_ZONE_CA53	0
+#define MT8173_THERMAL_ZONE_CA57	1
+#define MT8173_THERMAL_ZONE_GPU		2
+#define MT8173_THERMAL_ZONE_CORE	3
+
+#endif /* _DT_BINDINGS_THERMAL_MEDIATEK_MT8173_H */
-- 
2.5.0
