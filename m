From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v5 01/10] dt-bindings: olpc,
 xo1.75-ec: Add OLPC XO-1.75 EC bindings
Date: Thu, 10 Jan 2019 18:58:36 +0100
Message-ID: <20190110175845.1203986-2-lkundrak@v3.sk>
References: <20190110175845.1203986-1-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190110175845.1203986-1-lkundrak@v3.sk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andy Shevchenko <andy@infradead.org>, Darren Hart <dvhart@infradead.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, platform-driver-x86@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>, Rob Herring <robh+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>, linux-arm-kernel@lists.infradead.org
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
- Remove status = "okay" from the example

 .../bindings/misc/olpc,xo1.75-ec.txt          | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.txt

diff --git a/Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.txt b/Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.txt
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
+The embedded controller requires the SPI controller driver to signal readiness
+to receive a transfer (that is, when TX FIFO contains the response data) by
+strobing the ACK pin with the ready signal. See the "ready-gpios" property of the
+SSP binding as documented in:
+<Documentation/devicetree/bindings/spi/spi-pxa2xx.txt>.
+
+Example:
+	&ssp3 {
+		spi-slave;
+		ready-gpios = <&gpio 125 GPIO_ACTIVE_HIGH>;
+
+		slave {
+			compatible = "olpc,xo1.75-ec";
+			spi-cpha;
+			cmd-gpios = <&gpio 155 GPIO_ACTIVE_HIGH>;
+		};
+	};
-- 
2.20.1
