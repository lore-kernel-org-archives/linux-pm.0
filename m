From: megous-5qf/QAjKc83QT0dZR+AlfA@public.gmane.org
Subject: [PATCH v2 03/14] dt-bindings: document sun8i_ths - H3
 thermal sensor driver
Date: Sat, 25 Jun 2016 05:45:00 +0200
Message-ID: <20160625034511.7966-4-megous@megous.com>
References: <20160625034511.7966-1-megous@megous.com>
Reply-To: megous-5qf/QAjKc83QT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDXLF6FR5INBBUH4W65QKGQEIWNZ3WA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20160625034511.7966-1-megous-5qf/QAjKc83QT0dZR+AlfA@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: dev-3kdeTeqwOZ9EV1b7eY7vFQ@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Ondrej Jirman <megous-5qf/QAjKc83QT0dZR+AlfA@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, "open list:THERMAL" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

From: Ondrej Jirman <megous-5qf/QAjKc83QT0dZR+AlfA@public.gmane.org>

This patch adds the binding documentation for the
sun8i_ths driver. This is a driver for thermal sensor
found in Allwinner H3 SoC.

Signed-off-by: Ond=C5=99ej Jirman <megous-5qf/QAjKc83QT0dZR+AlfA@public.gmane.org>
---
 .../devicetree/bindings/thermal/sun8i-ths.txt      | 26 ++++++++++++++++++=
++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/sun8i-ths.txt

diff --git a/Documentation/devicetree/bindings/thermal/sun8i-ths.txt b/Docu=
mentation/devicetree/bindings/thermal/sun8i-ths.txt
new file mode 100644
index 0000000..76859d4
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/sun8i-ths.txt
@@ -0,0 +1,26 @@
+* Thermal sensor driver for Allwinner H3 SoC
+
+Required properties:
+- compatible : "allwinner,sun8i-h3-ths"
+- reg : Address range of the thermal sensor registers and of the calibrati=
on
+  data
+- resets : Must contain phandles to reset controls matching the entries
+  of the names
+- reset-names : Must include the name "ahb"
+- clocks : Must contain phandles to clock controls matching the entries
+  of the names
+- clock-names : Must contain "ahb" for the bus gate and "ths" for the THS
+  clock
+
+Example:
+ths: ths@01c25000 {
+	#thermal-sensor-cells =3D <0>;
+	compatible =3D "allwinner,sun8i-h3-ths";
+	reg =3D <0x01c25000 0x400>,
+	      <0x01c14234 0x4>;
+	interrupts =3D <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
+	resets =3D <&bus_rst 136>;
+	reset-names =3D "ahb";
+	clocks =3D <&bus_gates 72>, <&ths_clk>;
+	clock-names =3D "ahb", "ths";
+};
--=20
2.9.0

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
