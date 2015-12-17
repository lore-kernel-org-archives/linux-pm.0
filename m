From: Eric Anholt <eric@anholt.net>
Subject: [PATCH v4 3/4] dt-bindings: add rpi power domain driver bindings
Date: Wed, 16 Dec 2015 16:26:48 -0800
Message-ID: <1450312009-1791-4-git-send-email-eric@anholt.net>
References: <1450312009-1791-1-git-send-email-eric@anholt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1450312009-1791-1-git-send-email-eric@anholt.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-rpi-kernel@lists.infradead.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Florian Fainelli <f.fainelli@gmail.com>, Pawel Moll <pawel.moll@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Kevin Hilman <khilman@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>, Rob Herring <robh+dt@kernel.org>, Alexander Aring <alex.aring@gmail.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

From: Alexander Aring <alex.aring@gmail.com>

This patch adds devicetree tree bindings for the Raspberry Pi power
domain driver.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Eric Anholt <eric@anholt.net>
---

v2: Add the new domains present in v2 to the list.
v4: Move to soc/ instead of arm/, to follow the driver's move.

 .../bindings/soc/bcm/raspberrypi,bcm2835-power.txt | 47 ++++++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/bcm/raspberrypi,bcm2835-power.txt

diff --git a/Documentation/devicetree/bindings/soc/bcm/raspberrypi,bcm2835-power.txt b/Documentation/devicetree/bindings/soc/bcm/raspberrypi,bcm2835-power.txt
new file mode 100644
index 0000000..30942cf
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/bcm/raspberrypi,bcm2835-power.txt
@@ -0,0 +1,47 @@
+Raspberry Pi power domain driver
+
+Required properties:
+
+- compatible:		Should be "raspberrypi,bcm2835-power".
+- firmware:		Reference to the RPi firmware device node.
+- #power-domain-cells:	Should be <1>, we providing multiple power domains.
+
+The valid defines for power domain are:
+
+ RPI_POWER_DOMAIN_I2C0
+ RPI_POWER_DOMAIN_I2C1
+ RPI_POWER_DOMAIN_I2C2
+ RPI_POWER_DOMAIN_VIDEO_SCALER
+ RPI_POWER_DOMAIN_VPU1
+ RPI_POWER_DOMAIN_HDMI
+ RPI_POWER_DOMAIN_USB
+ RPI_POWER_DOMAIN_VEC
+ RPI_POWER_DOMAIN_JPEG
+ RPI_POWER_DOMAIN_H264
+ RPI_POWER_DOMAIN_V3D
+ RPI_POWER_DOMAIN_ISP
+ RPI_POWER_DOMAIN_UNICAM0
+ RPI_POWER_DOMAIN_UNICAM1
+ RPI_POWER_DOMAIN_CCP2RX
+ RPI_POWER_DOMAIN_CSI2
+ RPI_POWER_DOMAIN_CPI
+ RPI_POWER_DOMAIN_DSI0
+ RPI_POWER_DOMAIN_DSI1
+ RPI_POWER_DOMAIN_TRANSPOSER
+ RPI_POWER_DOMAIN_CCP2TX
+ RPI_POWER_DOMAIN_CDP
+ RPI_POWER_DOMAIN_ARM
+
+Example:
+
+power: power {
+	compatible = "raspberrypi,bcm2835-power";
+	firmware = <&firmware>;
+	#power-domain-cells = <1>;
+};
+
+Example for using power domain:
+
+&usb {
+       power-domains = <&power RPI_POWER_DOMAIN_USB>;
+};
-- 
2.6.2
