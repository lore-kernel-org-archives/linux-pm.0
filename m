From: Peter Chen <peter.chen@nxp.com>
Subject: [PATCH v15 1/7] binding-doc: power: pwrseq-generic: add binding doc for generic power sequence library
Date: Tue, 13 Jun 2017 09:59:20 +0800
Message-ID: <1497319166-17287-2-git-send-email-peter.chen@nxp.com>
References: <1497319166-17287-1-git-send-email-peter.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1497319166-17287-1-git-send-email-peter.chen@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, stern@rowland.harvard.edu, ulf.hansson@linaro.org, broonie@kernel.org, sre@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org, rjw@rjwysocki.net, dbaryshkov@gmail.com
Cc: heiko@sntech.de, linux-arm-kernel@lists.infradead.org, p.zabel@pengutronix.de, devicetree@vger.kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, linux-usb@vger.kernel.org, arnd@arndb.de, s.hauer@pengutronix.de, mail@maciej.szmigiero.name, troy.kisky@boundarydevices.com, festevam@gmail.com, oscar@naiandei.net, stephen.boyd@linaro.org, linux-pm@vger.kernel.org, stillcompiling@gmail.com, linux-kernel@vger.kernel.org, mka@chromium.org, vaibhav.hiremath@linaro.org, gary.bisson@boundarydevices.com, hverkuil@xs4all.nl, krzk@kernel.org, frank.li@nxp.com, jun.li@nxp.com, Peter Chen <peter.chen@nxp.com>
List-Id: linux-pm@vger.kernel.org

Add binding doc for generic power sequence library.

Signed-off-by: Peter Chen <peter.chen@nxp.com>
Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../bindings/power/pwrseq/pwrseq-generic.txt       | 48 ++++++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/pwrseq/pwrseq-generic.txt

diff --git a/Documentation/devicetree/bindings/power/pwrseq/pwrseq-generic.txt b/Documentation/devicetree/bindings/power/pwrseq/pwrseq-generic.txt
new file mode 100644
index 0000000..ebf0d47
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/pwrseq/pwrseq-generic.txt
@@ -0,0 +1,48 @@
+The generic power sequence library
+
+Some hard-wired devices (eg USB/MMC) need to do power sequence before
+the device can be enumerated on the bus, the typical power sequence
+like: enable USB PHY clock, toggle reset pin, etc. But current
+Linux device driver lacks of such code to do it, it may cause some
+hard-wired devices works abnormal or can't be recognized by
+controller at all. The power sequence will be done before this device
+can be found at the bus.
+
+The power sequence properties is under the device node.
+
+Optional properties:
+- clocks: the input clocks for device.
+- reset-gpios: Should specify the GPIO for reset.
+- reset-duration-us: the duration in microsecond for assert reset signal.
+
+Below is the example of USB power sequence properties on USB device
+nodes which have two level USB hubs.
+
+&usbotg1 {
+	vbus-supply = <&reg_usb_otg1_vbus>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usb_otg1_id>;
+	status = "okay";
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+	genesys: hub@1 {
+		compatible = "usb5e3,608";
+		reg = <1>;
+
+		clocks = <&clks IMX6SX_CLK_CKO>;
+		reset-gpios = <&gpio4 5 GPIO_ACTIVE_LOW>; /* hub reset pin */
+		reset-duration-us = <10>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+		asix: ethernet@1 {
+			compatible = "usbb95,1708";
+			reg = <1>;
+
+			clocks = <&clks IMX6SX_CLK_IPG>;
+			reset-gpios = <&gpio4 6 GPIO_ACTIVE_LOW>; /* ethernet_rst */
+			reset-duration-us = <15>;
+		};
+	};
+};
-- 
2.7.4
