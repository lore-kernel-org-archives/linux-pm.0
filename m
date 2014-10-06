From: Frans Klaver <frans.klaver@xsens.com>
Subject: [PATCH v3 2/2] power: reset: document LTC2952 poweroff support
Date: Mon, 6 Oct 2014 10:40:36 +0200
Message-ID: <1412584836-27677-3-git-send-email-frans.klaver@xsens.com>
References: <1412584836-27677-1-git-send-email-frans.klaver@xsens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from filter1.ibarracuda.nl ([83.247.7.10]:46919 "EHLO
	filter1.ibarracuda.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752284AbaJFIlq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 6 Oct 2014 04:41:46 -0400
In-Reply-To: <1412584836-27677-1-git-send-email-frans.klaver@xsens.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: =?UTF-8?q?Ren=C3=A9=20Moll?= <linux@r-moll.nl>, Tjerk Hofmeijer <tjerk.hofmeijer@xsens.com>, Frans Klaver <frans.klaver@xsens.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

=46rom: Ren=C3=A9 Moll <linux@r-moll.nl>

Signed-off-by: Ren=C3=A9 Moll <linux@r-moll.nl>
Signed-off-by: Tjerk Hofmeijer <tjerk.hofmeijer@xsens.com>
Signed-off-by: Frans Klaver <frans.klaver@xsens.com>
---
 .../bindings/power/reset/ltc2952-poweroff.txt      | 31 ++++++++++++++=
++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/reset/ltc29=
52-poweroff.txt

diff --git a/Documentation/devicetree/bindings/power/reset/ltc2952-powe=
roff.txt b/Documentation/devicetree/bindings/power/reset/ltc2952-powero=
ff.txt
new file mode 100644
index 0000000..3d15814
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/ltc2952-poweroff.tx=
t
@@ -0,0 +1,31 @@
+Binding for the LTC2952 PowerPath controller
+
+This chip is used to externally trigger a system shut down. Once the t=
rigger has
+been sent, the chips' watchdog has to be reset to gracefully shut down=
=2E
+If the Linux systems decides to shut down it powers off the platform v=
ia the
+kill signal.
+
+Required properties:
+
+- compatible:		Must contain: "lltc,ltc2952"
+- watchdog-gpios:	phandle + gpio-specifier for the GPIO connected to t=
he
+			chip's watchdog line
+- kill-gpios:		phandle + gpio-specifier for the GPIO connected to the
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
+	kill-gpios =3D <&gpio0 2 GPIO_ACTIVE_LOW>;
+};
--=20
2.1.0

