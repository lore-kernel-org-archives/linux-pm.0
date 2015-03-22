From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH 5/7] ARM: dts: enable regulator support for i.MX23/i.MX28
Date: Sun, 22 Mar 2015 00:30:01 +0000
Message-ID: <1426984203-9133-6-git-send-email-stefan.wahren@i2se.com>
References: <1426984203-9133-1-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1426984203-9133-1-git-send-email-stefan.wahren@i2se.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: shawn.guo@linaro.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, broonie@kernel.org, lgirdwood@gmail.com, mark.rutland@arm.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, robh+dt@kernel.org, galak@codeaurora.org
Cc: fabio.estevam@freescale.com, marex@denx.de, devicetree@vger.kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net, Stefan Wahren <stefan.wahren@i2se.com>, kernel@pengutronix.de, sebastien.szymanski@armadeus.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

This patch enables the on-chip regulator support for all i.MX23 and
i.MX28 boards.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/boot/dts/imx23.dtsi |   67 +++++++++++++++++++++++++++++++++++++++++-
 arch/arm/boot/dts/imx28.dtsi |   67 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 132 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
index bbcfb5a..be0aee8 100644
--- a/arch/arm/boot/dts/imx23.dtsi
+++ b/arch/arm/boot/dts/imx23.dtsi
@@ -404,8 +404,73 @@
 			};
 
 			power@80044000 {
+				compatible = "fsl,imx23-power";
+				#address-cells = <1>;
+				#size-cells = <1>;
 				reg = <0x80044000 0x2000>;
-				status = "disabled";
+				interrupts = <3>;
+				ranges;
+
+				dcdc: regulator@80044010 {
+					reg = <0x80044010 0x10>,
+					      <0x80044090 0x10>,
+					      <0x800440c0 0x10>;
+					reg-names = "base-address",
+						    "misc-address",
+						    "status-address";
+					compatible = "fsl,imx23-dcdc";
+					regulator-name = "dcdc";
+					regulator-boot-on;
+					regulator-always-on;
+				};
+
+				reg_vddd: regulator@80044040 {
+					reg = <0x80044040 0x10>,
+					      <0x80044010 0x10>,
+					      <0x800440c0 0x10>;
+					reg-names = "base-address",
+						    "v5ctrl-address",
+						    "status-address";
+					compatible = "fsl,imx23-vddd";
+					regulator-name = "vddd";
+					regulator-min-microvolt = <1350000>;
+					regulator-max-microvolt = <1550000>;
+					vddd-supply = <&reg_vdda>;
+					regulator-boot-on;
+					regulator-always-on;
+				};
+
+				reg_vdda: regulator@80044050 {
+					reg = <0x80044050 0x10>,
+					      <0x80044010 0x10>,
+					      <0x800440c0 0x10>;
+					reg-names = "base-address",
+						    "v5ctrl-address",
+						    "status-address";
+					compatible = "fsl,imx23-vdda";
+					regulator-name = "vdda";
+					regulator-min-microvolt = <1725000>;
+					regulator-max-microvolt = <1950000>;
+					vdda-supply = <&reg_vddio>;
+					regulator-boot-on;
+					regulator-always-on;
+				};
+
+				reg_vddio: regulator@80044060 {
+					reg = <0x80044060 0x10>,
+					      <0x80044010 0x10>,
+					      <0x800440c0 0x10>;
+					reg-names = "base-address",
+						    "v5ctrl-address",
+						    "status-address";
+					compatible = "fsl,imx23-vddio";
+					regulator-name = "vddio";
+					regulator-min-microvolt = <3000000>;
+					regulator-max-microvolt = <3575000>;
+					regulator-microvolt-offset = <80000>;
+					regulator-boot-on;
+					regulator-always-on;
+				};
 			};
 
 			saif1: saif@80046000 {
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 02330f4..98c1be6 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -1022,8 +1022,73 @@
 			};
 
 			power: power@80044000 {
+				compatible = "fsl,imx28-power";
+				#address-cells = <1>;
+				#size-cells = <1>;
 				reg = <0x80044000 0x2000>;
-				status = "disabled";
+				interrupts = <6>;
+				ranges;
+
+				dcdc: regulator@80044010 {
+					reg = <0x80044010 0x10>,
+					      <0x80044090 0x10>,
+					      <0x800440c0 0x10>;
+					reg-names = "base-address",
+						    "misc-address",
+						    "status-address";
+					compatible = "fsl,imx28-dcdc";
+					regulator-name = "dcdc";
+					regulator-boot-on;
+					regulator-always-on;
+				};
+
+				reg_vddd: regulator@80044040 {
+					reg = <0x80044040 0x10>,
+					      <0x80044010 0x10>,
+					      <0x800440c0 0x10>;
+					reg-names = "base-address",
+						    "v5ctrl-address",
+						    "status-address";
+					compatible = "fsl,imx28-vddd";
+					regulator-name = "vddd";
+					regulator-min-microvolt = <1350000>;
+					regulator-max-microvolt = <1550000>;
+					vddd-supply = <&reg_vdda>;
+					regulator-boot-on;
+					regulator-always-on;
+				};
+
+				reg_vdda: regulator@80044050 {
+					reg = <0x80044050 0x10>,
+					      <0x80044010 0x10>,
+					      <0x800440c0 0x10>;
+					reg-names = "base-address",
+						    "v5ctrl-address",
+						    "status-address";
+					compatible = "fsl,imx28-vdda";
+					regulator-name = "vdda";
+					regulator-min-microvolt = <1725000>;
+					regulator-max-microvolt = <1950000>;
+					vdda-supply = <&reg_vddio>;
+					regulator-boot-on;
+					regulator-always-on;
+				};
+
+				reg_vddio: regulator@80044060 {
+					reg = <0x80044060 0x10>,
+					      <0x80044010 0x10>,
+					      <0x800440c0 0x10>;
+					reg-names = "base-address",
+						    "v5ctrl-address",
+						    "status-address";
+					compatible = "fsl,imx28-vddio";
+					regulator-name = "vddio";
+					regulator-min-microvolt = <3000000>;
+					regulator-max-microvolt = <3550000>;
+					regulator-microvolt-offset = <80000>;
+					regulator-boot-on;
+					regulator-always-on;
+				};
 			};
 
 			saif1: saif@80046000 {
-- 
1.7.9.5
