From: Josef Gajdusek <atx-MwjtXicnQwU@public.gmane.org>
Subject: [PATCH v2 4/5] dt-bindings: document sun8i_ths
Date: Mon, 23 Nov 2015 09:02:51 +0100
Message-ID: <20e229f191031b0b0bff96dee118d1f2d988d7b3.1448263428.git.atx@atx.name>
References: <cover.1448263428.git.atx@atx.name>
Reply-To: atx-MwjtXicnQwU@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCYM5N4ES4IRBO4QZOZAKGQELY47H3Q-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <cover.1448263428.git.atx-MwjtXicnQwU@public.gmane.org>
In-Reply-To: <cover.1448263428.git.atx-MwjtXicnQwU@public.gmane.org>
References: <cover.1448263428.git.atx-MwjtXicnQwU@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Cc: Josef Gajdusek <atx-MwjtXicnQwU@public.gmane.org>, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gpatchesrdh-I1/eAgTnXDYAvxtiuMwx3w@public.gmane.org, mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-pm@vger.kernel.org

This patch adds the binding documentation for the sun8i_ths driver

Signed-off-by: Josef Gajdusek <atx-MwjtXicnQwU@public.gmane.org>
---
 .../devicetree/bindings/thermal/sun8i-ths.txt      | 31 ++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/sun8i-ths.txt

diff --git a/Documentation/devicetree/bindings/thermal/sun8i-ths.txt b/Documentation/devicetree/bindings/thermal/sun8i-ths.txt
new file mode 100644
index 0000000..67056bf
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/sun8i-ths.txt
@@ -0,0 +1,31 @@
+* sun8i THS
+
+Required properties:
+- compatible : "allwinner,sun8i-h3-ths"
+- reg : Address range of the thermal registers and location of the calibration
+        value
+- resets : Must contain an entry for each entry in reset-names.
+           see ../reset/reset.txt for details
+- reset-names : Must include the name "ahb"
+- clocks : Must contain an entry for each entry in clock-names.
+- clock-names : Must contain "ahb" for the bus gate and "ths" for the THS
+  clock
+
+Optional properties:
+- nvmem-cells : Must contain an entry for each entry in nvmem-cell-names
+- nvmem-cell-names : Must contain "calibration" for the cell containing the
+  temperature calibration cell, if available
+
+Example:
+ths: ths@01c25000 {
+	#thermal-sensor-cells = <0>;
+	compatible = "allwinner,sun8i-h3-ths";
+	reg = <0x01c25000 0x88>, <0x01c14234 0x4>;
+	interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
+	resets = <&bus_rst 136>;
+	reset-names = "ahb";
+	clocks = <&bus_gates 72>, <&ths_clk>;
+	clock-names = "ahb", "ths";
+	nvmem-cells = <&ths_calibration>;
+	nvmem-cell-names = "calibration";
+};
-- 
2.4.10
