From: Peter Chen <peter.chen@nxp.com>
Subject: [PATCH v15 3/7] binding-doc: usb: usb-device: add optional properties for power sequence
Date: Tue, 13 Jun 2017 09:59:22 +0800
Message-ID: <1497319166-17287-4-git-send-email-peter.chen@nxp.com>
References: <1497319166-17287-1-git-send-email-peter.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1497319166-17287-1-git-send-email-peter.chen@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, stern@rowland.harvard.edu, ulf.hansson@linaro.org, broonie@kernel.org, sre@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org, rjw@rjwysocki.net, dbaryshkov@gmail.com
Cc: heiko@sntech.de, linux-arm-kernel@lists.infradead.org, p.zabel@pengutronix.de, devicetree@vger.kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, linux-usb@vger.kernel.org, arnd@arndb.de, s.hauer@pengutronix.de, mail@maciej.szmigiero.name, troy.kisky@boundarydevices.com, festevam@gmail.com, oscar@naiandei.net, stephen.boyd@linaro.org, linux-pm@vger.kernel.org, stillcompiling@gmail.com, linux-kernel@vger.kernel.org, mka@chromium.org, vaibhav.hiremath@linaro.org, gary.bisson@boundarydevices.com, hverkuil@xs4all.nl, krzk@kernel.org, frank.li@nxp.com, jun.li@nxp.com, Peter Chen <peter.chen@nxp.com>
List-Id: linux-pm@vger.kernel.org

Add optional properties for power sequence.

Signed-off-by: Peter Chen <peter.chen@nxp.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/usb/usb-device.txt | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/usb-device.txt b/Documentation/devicetree/bindings/usb/usb-device.txt
index 1c35e7b..3661dd2 100644
--- a/Documentation/devicetree/bindings/usb/usb-device.txt
+++ b/Documentation/devicetree/bindings/usb/usb-device.txt
@@ -13,6 +13,10 @@ Required properties:
 - reg: the port number which this device is connecting to, the range
   is 1-31.
 
+Optional properties:
+power sequence properties, see
+Documentation/devicetree/bindings/power/pwrseq/pwrseq-generic.txt for detail
+
 Example:
 
 &usb1 {
@@ -21,8 +25,12 @@ Example:
 	#address-cells = <1>;
 	#size-cells = <0>;
 
-	hub: genesys@1 {
+	genesys: hub@1 {
 		compatible = "usb5e3,608";
 		reg = <1>;
+
+		clocks = <&clks IMX6SX_CLK_CKO>;
+		reset-gpios = <&gpio4 5 GPIO_ACTIVE_LOW>; /* hub reset pin */
+		reset-duration-us = <10>;
 	};
 }
-- 
2.7.4
