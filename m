From: Peter Chen <peter.chen@nxp.com>
Subject: [PATCH v8 6/8] ARM: dts: imx6qdl: Enable usb node children with <reg>
Date: Fri, 14 Oct 2016 10:59:53 +0800
Message-ID: <1476413995-20361-7-git-send-email-peter.chen@nxp.com>
References: <1476413995-20361-1-git-send-email-peter.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1476413995-20361-1-git-send-email-peter.chen@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: gregkh@linuxfoundation.org, stern@rowland.harvard.edu, ulf.hansson@linaro.org, broonie@kernel.org, sre@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org, dbaryshkov@gmail.com
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, mail@maciej.szmigiero.name, stephen.boyd@linaro.org, oscar@naiandei.net, heiko@sntech.de, pawel.moll@arm.com, linux-pm@vger.kernel.org, Peter Chen <peter.chen@nxp.com>, s.hauer@pengutronix.de, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, troy.kisky@boundarydevices.com, vaibhav.hiremath@linaro.org, stillcompiling@gmail.com, arnd@arndb.de, p.zabel@pengutronix.de, festevam@gmail.com, mka@chromium.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

From: Joshua Clayton <stillcompiling@gmail.com>

Give usb nodes #address and #size attributes, so that a child node
representing a permanently connected device such as an onboard hub may
be addressed with a <reg> attribute

Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
Signed-off-by: Peter Chen <peter.chen@nxp.com>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index b13b0b2..8fc66e1 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -935,6 +935,8 @@
 
 			usbh1: usb@02184200 {
 				compatible = "fsl,imx6q-usb", "fsl,imx27-usb";
+				#address-cells = <1>;
+				#size-cells = <0>;
 				reg = <0x02184200 0x200>;
 				interrupts = <0 40 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6QDL_CLK_USBOH3>;
@@ -949,6 +951,8 @@
 
 			usbh2: usb@02184400 {
 				compatible = "fsl,imx6q-usb", "fsl,imx27-usb";
+				#address-cells = <1>;
+				#size-cells = <0>;
 				reg = <0x02184400 0x200>;
 				interrupts = <0 41 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6QDL_CLK_USBOH3>;
@@ -962,6 +966,8 @@
 
 			usbh3: usb@02184600 {
 				compatible = "fsl,imx6q-usb", "fsl,imx27-usb";
+				#address-cells = <1>;
+				#size-cells = <0>;
 				reg = <0x02184600 0x200>;
 				interrupts = <0 42 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6QDL_CLK_USBOH3>;
-- 
2.7.4
