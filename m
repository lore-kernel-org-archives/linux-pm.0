From: =?iso-8859-1?Q?Ren=E9_Moll?= <Rene.Moll@xsens.com>
Subject: [PATCH 2/2] power: reset: add LTC2952 poweroff support
Date: Fri, 8 Aug 2014 13:12:22 +0000
Message-ID: <8B68774BB69A844693005BA12A50F1146D4B8E@XSMBXSVR01.xsens-tech.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from filter1.ibarracuda.nl ([83.247.7.10]:53062 "EHLO
	filter1.ibarracuda.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756641AbaHHNMZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 8 Aug 2014 09:12:25 -0400
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Frans Klaver <Frans.Klaver@xsens.com>


Signed-off-by: Ren=E9 Moll <rene.moll@xsens.com>

---
 .../bindings/power/reset/ltc2952-poweroff.txt      | 26 ++++++++++++++=
++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/reset/ltc29=
52-poweroff.txt

diff --git a/Documentation/devicetree/bindings/power/reset/ltc2952-powe=
roff.txt b/Documentation/devicetree/bindings/power/reset/ltc2952-powero=
ff.txt
new file mode 100644
index 0000000..4432c8f
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/ltc2952-poweroff.tx=
t
@@ -0,0 +1,26 @@
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
+- trigger-gpios:	phandle + gpio-specifier for the GPIO connected to th=
e
+			chip's trigger line
+- watchdog-gpios:	phandle + gpio-specifier for the GPIO connected to t=
he
+			chip's watchdog line
+- kill-gpios:		phandle + gpio-specifier for the GPIO connected to the
+			chip's kill line
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
\ No newline at end of file
--=20
1.9.1

