From: Michael Haas <haas-bdq14YP6qtSV9CzYT+GlPGD2FQJk+8+b@public.gmane.org>
Subject: [PATCH 3/4] ARM: dts: Add binding documentation for
 AXP20x pmic ac power supply
Date: Sun,  3 Apr 2016 15:15:06 +0200
Message-ID: <1459689307-8501-3-git-send-email-haas@computerlinguist.org>
References: <1459689307-8501-1-git-send-email-haas@computerlinguist.org>
Reply-To: haas-bdq14YP6qtSV9CzYT+GlPGD2FQJk+8+b@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCD4V7EG6QFRB2FOQS4AKGQERPNDWNQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <1459689307-8501-1-git-send-email-haas-bdq14YP6qtSV9CzYT+GlPGD2FQJk+8+b@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
Cc: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Michael Haas <haas-bdq14YP6qtSV9CzYT+GlPGD2FQJk+8+b@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Add binding documentation for the ac power supply part of the AXP20x
pmic.

Signed-off-by: Michael Haas <haas-bdq14YP6qtSV9CzYT+GlPGD2FQJk+8+b@public.gmane.org>
---
 .../bindings/power_supply/axp20x_ac_power.txt      | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power_supply/axp20x_ac_power.txt

diff --git a/Documentation/devicetree/bindings/power_supply/axp20x_ac_power.txt b/Documentation/devicetree/bindings/power_supply/axp20x_ac_power.txt
new file mode 100644
index 0000000..1cbdcfb
--- /dev/null
+++ b/Documentation/devicetree/bindings/power_supply/axp20x_ac_power.txt
@@ -0,0 +1,34 @@
+AXP20x AC power supply
+
+Required Properties:
+-compatible: "x-powers,axp202-ac-power-supply"
+
+This node is a subnode of the axp20x PMIC.
+
+Example:
+
+axp209: pmic@34 {
+	compatible = "x-powers,axp209";
+	reg = <0x34>;
+	interrupt-parent = <&nmi_intc>;
+	interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+	interrupt-controller;
+	#interrupt-cells = <1>;
+
+	regulators {
+		x-powers,dcdc-freq = <1500>;
+
+		vdd_cpu: dcdc2 {
+			regulator-always-on;
+			regulator-min-microvolt = <1000000>;
+			regulator-max-microvolt = <1450000>;
+			regulator-name = "vdd-cpu";
+		};
+
+		...
+	};
+
+	ac-power-supply: ac-power-supply {
+		compatible = "x-powers,axp202-ac-power-supply";
+	};
+};
-- 
2.8.0
