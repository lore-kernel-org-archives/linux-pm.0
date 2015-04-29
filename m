From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH V2 4/6] DT: add binding for mxs on-chip regulators
Date: Wed, 29 Apr 2015 22:32:25 +0000
Message-ID: <1430346747-28728-5-git-send-email-stefan.wahren@i2se.com>
References: <1430346747-28728-1-git-send-email-stefan.wahren@i2se.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:63294 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751772AbbD2Wdi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 29 Apr 2015 18:33:38 -0400
In-Reply-To: <1430346747-28728-1-git-send-email-stefan.wahren@i2se.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Russell King <linux@arm.linux.org.uk>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, fabio.estevam@freescale.com, sebastien.szymanski@armadeus.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>

This patch adds the device tree bindings for the Freescale MXS on-chip
regulators.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 .../bindings/regulator/mxs-regulator.txt           |   65 ++++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/mxs-regulator.txt

diff --git a/Documentation/devicetree/bindings/regulator/mxs-regulator.txt b/Documentation/devicetree/bindings/regulator/mxs-regulator.txt
new file mode 100644
index 0000000..e7092fc
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/mxs-regulator.txt
@@ -0,0 +1,65 @@
+Regulators on Freescale i.MX23/i.MX28
+
+On-chip linear regulator daisy chain:
+
++------------+     VDD5V  +---------+  VDDIO
+| DC-DC      |   +--------> LINREG  +--------->+
+|            |            | VDDIO   |          |
+|            |            +---------+          |
+| DCDC_VDDIO +->-+-----------------------------+
+|            |   |
+|            |   | VDDIO  +---------+  VDDA
+|            |   +--------> LINREG  +--------->+
+|            |            | VDDA    |          |
+|            |            +---------+          |
+| DCDC_VDDA  +->-+-----------------------------+
+|            |   |
+|            |   | VDDA   +---------+  VDD1P5
+|            |   +--------> LINREG  +--------->
+|            |   |        | VDD1P5  |
+|            |   |        +---------+
+|            |   | VDDA   +---------+  VDDD
+|            |   +--------> LINREG  +--------->+
+|            |            | VDDD    |          |
+|            |            +---------+          |
+| DCDC_VDDD  +->-------------------------------+
++------------+                                 |
+                                               v
+
+Required properties:
+- compatible (imx23 and imx28 supported):
+  - "fsl,<soc>-dcdc" for DC-DC converter
+  - "fsl,<soc>-vddd" for VDDD linear regulator
+  - "fsl,<soc>-vdda" for VDDA linear regulator
+  - "fsl,<soc>-vddio" for VDDIO linear regulator
+
+Optional properties:
+- switching-frequency: switching frequency for the DC-DC converter in Hz.
+  Possible values are <1200000>, <1250000> or <1500000> (default).
+
+Any regulator property defined as part of the core regulator
+binding, defined in regulator.txt, can also be used.
+
+Example for i.MX28:
+
+	power: power@80044000 {
+		compatible = "fsl,imx28-power", "syscon";
+		reg = <0x80044000 0x2000>;
+		interrupts = <6>;
+
+		dcdc: regulator@1 {
+			compatible = "fsl,imx28-dcdc";
+			regulator-name = "dcdc";
+			regulator-boot-on;
+			regulator-always-on;
+			switching-frequency = <1250000>;
+		};
+
+		reg_vddd: regulator@2 {
+			compatible = "fsl,imx28-vddd";
+			regulator-name = "vddd";
+			regulator-min-microvolt = <1350000>;
+			regulator-max-microvolt = <1550000>;
+		};
+	};
+
-- 
1.7.9.5

