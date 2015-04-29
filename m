From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH V2 1/6] DT: add binding for mxs power subsystem
Date: Wed, 29 Apr 2015 22:32:22 +0000
Message-ID: <1430346747-28728-2-git-send-email-stefan.wahren@i2se.com>
References: <1430346747-28728-1-git-send-email-stefan.wahren@i2se.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:58442 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276AbbD2Wgx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 29 Apr 2015 18:36:53 -0400
In-Reply-To: <1430346747-28728-1-git-send-email-stefan.wahren@i2se.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Russell King <linux@arm.linux.org.uk>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, fabio.estevam@freescale.com, sebastien.szymanski@armadeus.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>

This patch adds the device tree bindings for the Freescale MXS
on-chip power subsystem.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 .../devicetree/bindings/power/mxs_power.txt        |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/mxs_power.txt

diff --git a/Documentation/devicetree/bindings/power/mxs_power.txt b/Documentation/devicetree/bindings/power/mxs_power.txt
new file mode 100644
index 0000000..4003ef7
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/mxs_power.txt
@@ -0,0 +1,17 @@
+Power subsystem for Freescale i.MX23/i.MX28
+
+Required properties:
+- compatible: Should be "fsl,<soc>-power". The supported SoCs include
+  imx23 and imx28.
+- reg: Address and length of the register set for the power subsystem.
+
+Optional properties;
+- interrupts: Interrupts used by the power subsystem
+
+Example for i.MX28:
+
+	power: power@80044000 {
+		compatible = "fsl,imx28-power", "syscon";
+		reg = <0x80044000 0x2000>;
+		interrupts = <6>;
+	}
-- 
1.7.9.5

