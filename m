From: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Subject: [PATCH 3/7] DT: add binding for MXS regulator
Date: Sun, 22 Mar 2015 00:29:59 +0000
Message-ID: <1426984203-9133-4-git-send-email-stefan.wahren@i2se.com>
References: <1426984203-9133-1-git-send-email-stefan.wahren@i2se.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1426984203-9133-1-git-send-email-stefan.wahren-eS4NqCHxEME@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
Cc: fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org, marex-ynQEQJNshbs@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, sebastien.szymanski-d2DlULPkwbNWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

This patch adds the device tree bindings for the Freescale MXS on-chip
regulators.

Signed-off-by: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
---
 .../bindings/regulator/mxs-regulator.txt           |   70 ++++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/mxs-regulator.txt

diff --git a/Documentation/devicetree/bindings/regulator/mxs-regulator.txt b/Documentation/devicetree/bindings/regulator/mxs-regulator.txt
new file mode 100644
index 0000000..88452d2
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/mxs-regulator.txt
@@ -0,0 +1,70 @@
+Regulators for Freescale i.MX23/i.MX28
+
+Required properties:
+For imx23 regulators
+- compatible:
+  - "fsl,imx23-dcdc" for DC-DC converter
+  - "fsl,imx23-vddd" for VDDD linear regulator
+  - "fsl,imx23-vdda" for VDDA linear regulator
+  - "fsl,imx23-vddio" for VDDIO linear regulator
+For imx28 regulators
+- compatible:
+  - "fsl,imx28-dcdc" for DC-DC converter
+  - "fsl,imx28-vddd" for VDDD linear regulator
+  - "fsl,imx28-vdda" for VDDA linear regulator
+  - "fsl,imx28-vddio" for VDDIO linear regulator
+- reg: Address and length of the register set for the device. It contains
+  the information of registers in the same order as described by reg-names
+- reg-names: Should contain the reg names
+  - "base-address"	- contains base address of regulator
+  - "status-address"	- contains status address of regulator
+  - "v5ctrl-address"	- contains 5V control address of DC-DC converter
+			  (required only for linear regulators)
+  - "misc-address"      - contains misc control address of DC-DC converter
+			  (required only for DC-DC converter)
+
+Optional properties:
+- switching-frequency: switching frequency of the DC-DC converter in Hz.
+  Possible values are <19200000>, <22000000> or <24000000> (default).
+
+Any regulator property defined as part of the core regulator
+binding, defined in regulator.txt, can also be used.
+
+Example for i.MX28:
+
+	power: power@80044000 {
+		compatible = "fsl,imx28-power";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0x80044000 0x2000>;
+		interrupts = <6>;
+		ranges;
+
+		dcdc: regulator@80044010 {
+			reg = <0x80044010 0x10>,
+			      <0x80044090 0x10>,
+			      <0x800440c0 0x10>;
+			reg-names = "base-address",
+				    "misc-address",
+				    "status-address";
+			compatible = "fsl,imx28-dcdc";
+			regulator-name = "dcdc";
+			regulator-boot-on;
+			regulator-always-on;
+			switching-frequency = <24000000>;
+		};
+
+		reg_vddd: regulator@80044040 {
+			reg = <0x80044040 0x10>,
+			      <0x80044010 0x10>,
+			      <0x800440c0 0x10>;
+			reg-names = "base-address",
+				    "v5ctrl-address",
+				    "status-address";
+			compatible = "fsl,imx28-vddd";
+			regulator-name = "vddd";
+			regulator-min-microvolt = <1350000>;
+			regulator-max-microvolt = <1550000>;
+		};
+	};
+
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
