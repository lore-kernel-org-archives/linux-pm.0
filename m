From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v3 01/16] dt-bindings: olpc,xo1.75-ec: Add OLPC XO-1.75 EC bindings
Date: Mon,  7 Jan 2019 19:34:24 +0100
Message-ID: <20190107183439.50626-2-lkundrak@v3.sk>
References: <20190107183439.50626-1-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190107183439.50626-1-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy@infradead.org>, Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org
Cc: James Cameron <quozl@laptop.org>, Mark Rutland <mark.rutland@arm.com>, Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>, x86@kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
List-Id: linux-pm@vger.kernel.org

The OLPC XO-1.75 Embedded Controller is a SPI master that uses extra
signals for handshaking. It needs to know when is the slave (Linux)
side's TX FIFO ready for transfer (the ready-gpio signal on the SPI
controller node) and when does it wish to respond with a command (the
cmd-gpio property).

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Pavel Machek <pavel@ucw.cz>

---
Changes since v1:
- s/cmd-gpio/cmd-gpios/
- s/ready-gpio/ready-gpios/ in the documentation paragraph
- Remove status =3D "okay" from the example

 .../bindings/misc/olpc,xo1.75-ec.txt          | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/olpc,xo1.75-ec=
.txt

diff --git a/Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.txt b/=
Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.txt
new file mode 100644
index 000000000000..8c4d649cdd8f
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.txt
@@ -0,0 +1,23 @@
+OLPC XO-1.75 Embedded Controller
+
+Required properties:
+- compatible: Should be "olpc,xo1.75-ec".
+- cmd-gpios: gpio specifier of the CMD pin
+
+The embedded controller requires the SPI controller driver to signal rea=
diness
+to receive a transfer (that is, when TX FIFO contains the response data)=
 by
+strobing the ACK pin with the ready signal. See the "ready-gpios" proper=
ty of the
+SSP binding as documented in:
+<Documentation/devicetree/bindings/spi/spi-pxa2xx.txt>.
+
+Example:
+	&ssp3 {
+		spi-slave;
+		ready-gpios =3D <&gpio 125 GPIO_ACTIVE_HIGH>;
+
+		slave {
+			compatible =3D "olpc,xo1.75-ec";
+			spi-cpha;
+			cmd-gpios =3D <&gpio 155 GPIO_ACTIVE_HIGH>;
+		};
+	};
--=20
2.20.1
