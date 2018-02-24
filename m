From: Anson Huang <Anson.Huang@nxp.com>
Subject: [PATCH V4 1/2] ARM: dts: imx7s: add temperature monitor support
Date: Sat, 24 Feb 2018 16:02:48 +0800
Message-ID: <1519459369-29083-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: rui.zhang@intel.com, edubezval@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com, linux@armlinux.org.uk
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Linux-imx@nxp.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Add i.MX7 temperature monitor support.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
changes since V3:
	use "fsl,imx7d-tempmon" instead of "fsl,imx7-tempmon" as compatible string
 arch/arm/boot/dts/imx7s.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 9aa2bb9..6a5c1bf 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -511,9 +511,29 @@
 			};
 
 			ocotp: ocotp-ctrl@30350000 {
+				#address-cells = <1>;
+				#size-cells = <1>;
 				compatible = "fsl,imx7d-ocotp", "syscon";
 				reg = <0x30350000 0x10000>;
 				clocks = <&clks IMX7D_OCOTP_CLK>;
+
+				tempmon_calib: calib@3c {
+					reg = <0x3c 0x4>;
+				};
+
+				tempmon_temp_grade: temp-grade@10 {
+					reg = <0x10 0x4>;
+				};
+			};
+
+			tempmon: tempmon {
+				compatible = "fsl,imx7d-tempmon";
+				interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
+				fsl,tempmon =<&anatop>;
+				nvmem-cells = <&tempmon_calib>,
+					<&tempmon_temp_grade>;
+				nvmem-cell-names = "calib", "temp_grade";
+				clocks = <&clks IMX7D_PLL_SYS_MAIN_CLK>;
 			};
 
 			anatop: anatop@30360000 {
-- 
2.7.4
