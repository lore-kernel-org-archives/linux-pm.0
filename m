From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH 1/7] DT: add binding for mxs power subsystem
Date: Sun, 22 Mar 2015 00:29:57 +0000
Message-ID: <1426984203-9133-2-git-send-email-stefan.wahren@i2se.com>
References: <1426984203-9133-1-git-send-email-stefan.wahren@i2se.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:55090 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751426AbbCVAep (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 21 Mar 2015 20:34:45 -0400
In-Reply-To: <1426984203-9133-1-git-send-email-stefan.wahren@i2se.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: shawn.guo@linaro.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, broonie@kernel.org, lgirdwood@gmail.com, mark.rutland@arm.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, robh+dt@kernel.org, galak@codeaurora.org
Cc: fabio.estevam@freescale.com, marex@denx.de, kernel@pengutronix.de, rjw@rjwysocki.net, viresh.kumar@linaro.org, sebastien.szymanski@armadeus.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>

This patch adds the device tree bindings for the Freescale MXS
power subsystem.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 .../devicetree/bindings/power/mxs_power.txt        |   23 ++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/mxs_power.txt

diff --git a/Documentation/devicetree/bindings/power/mxs_power.txt b/Documentation/devicetree/bindings/power/mxs_power.txt
new file mode 100644
index 0000000..aa9139b
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/mxs_power.txt
@@ -0,0 +1,23 @@
+Power subsystem for Freescale i.MX23/i.MX28
+
+Required properties:
+- compatible:
+  - "fsl,imx23-power" for i.MX23
+  - "fsl,imx28-power" for i.MX28
+- address-cells, size-cells, ranges: must be present as appropriate to
+  map children
+- reg: Address and length of the register set for the power subsystem.
+
+Optional properties;
+- interrupts: Interrupts used by the power subsystem
+
+Example for i.MX28:
+
+	power: power@80044000 {
+				compatible = "fsl,imx28-power";
+				#address-cells = <1>;
+				#size-cells = <1>;
+				reg = <0x80044000 0x2000>;
+				interrupts = <6>;
+				ranges;
+	}
-- 
1.7.9.5

