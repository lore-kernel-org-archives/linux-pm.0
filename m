From: Frans Klaver <frans.klaver-MHHw4NDrbWwAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v5 2/2] power: reset: document LTC2952 poweroff support
Date: Mon, 13 Oct 2014 10:05:13 +0200
Message-ID: <1413187513-11178-3-git-send-email-frans.klaver@xsens.com>
References: <1413187513-11178-1-git-send-email-frans.klaver@xsens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1413187513-11178-1-git-send-email-frans.klaver-MHHw4NDrbWwAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: =?UTF-8?q?Ren=C3=A9=20Moll?= <linux-93MfrKQ0iTlmR6Xm/wNWPw@public.gmane.org>, Tjerk Hofmeijer <tjerk.hofmeijer-MHHw4NDrbWwAvxtiuMwx3w@public.gmane.org>, Frans Klaver <frans.klaver-MHHw4NDrbWwAvxtiuMwx3w@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

=46rom: Ren=C3=A9 Moll <linux-93MfrKQ0iTlmR6Xm/wNWPw@public.gmane.org>

Signed-off-by: Ren=C3=A9 Moll <linux-93MfrKQ0iTlmR6Xm/wNWPw@public.gmane.org>
Signed-off-by: Tjerk Hofmeijer <tjerk.hofmeijer-MHHw4NDrbWwAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Frans Klaver <frans.klaver-MHHw4NDrbWwAvxtiuMwx3w@public.gmane.org>
---
 .../bindings/power/reset/ltc2952-poweroff.txt      | 30 ++++++++++++++=
++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/reset/ltc29=
52-poweroff.txt

diff --git a/Documentation/devicetree/bindings/power/reset/ltc2952-powe=
roff.txt b/Documentation/devicetree/bindings/power/reset/ltc2952-powero=
ff.txt
new file mode 100644
index 0000000..80e58cd
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/ltc2952-poweroff.tx=
t
@@ -0,0 +1,30 @@
+Binding for the LTC2952 PowerPath controller
+
+This chip is used to externally trigger a system shut down. Once the t=
rigger
+has been sent, the chip's watchdog has to be reset to gracefully shut =
down.
+A full power down can be triggered via the poweroff signal.
+
+Required properties:
+
+- compatible:		Should contain: "lltc,ltc2952"
+- watchdog-gpios:	phandle + gpio-specifier for the GPIO connected to t=
he
+			chip's watchdog line
+- poweroff-gpios:	phandle + gpio-specifier for the GPIO connected to t=
he
+			chip's kill line
+
+Optional properties:
+
+- trigger-gpios:	phandle + gpio-specifier for the GPIO connected to th=
e
+			chip's trigger line. If this property is not set, the
+			trigger function is ignored and the chip is kept alive
+			until an explicit kill signal is received
+
+Example:
+
+ltc2952 {
+	compatible =3D "lltc,ltc2952";
+
+	trigger-gpios =3D <&gpio0 1 GPIO_ACTIVE_LOW>;
+	watchdog-gpios =3D <&gpio1 2 GPIO_ACTIVE_HIGH>;
+	poweroff-gpios =3D <&gpio0 2 GPIO_ACTIVE_LOW>;
+};
--=20
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
