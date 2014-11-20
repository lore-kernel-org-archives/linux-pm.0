From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH RFC 1/3] DT: add binding for mxs power subsystem
Date: Thu, 20 Nov 2014 20:14:35 +0000
Message-ID: <1416514477-19190-2-git-send-email-stefan.wahren@i2se.com>
References: <1416514477-19190-1-git-send-email-stefan.wahren@i2se.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:52409 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757968AbaKTUOx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 20 Nov 2014 15:14:53 -0500
In-Reply-To: <1416514477-19190-1-git-send-email-stefan.wahren@i2se.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org

This patch adds the device tree bindings for the Freescale MXS
power subsystem.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 .../devicetree/bindings/power/mxs_power.txt        |   23 ++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/mxs_power.txt

diff --git a/Documentation/devicetree/bindings/power/mxs_power.txt b/Documentation/devicetree/bindings/power/mxs_power.txt
new file mode 100644
index 0000000..0817841
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/mxs_power.txt
@@ -0,0 +1,23 @@
+Power subsystem for Freescale MX23/MX28
+
+Required properties:
+- compatible:
+  - "fsl,imx23-power" for MX23
+  - "fsl,imx28-power" for MX28
+- address-cells, size-cells, ranges: must be present as appropriate to
+  map children
+- reg: Address and length of the register set for the power subsystem.
+
+Optional properties;
+- interrupts: Interrupts used by the power subsystem
+
+Example for imx28:
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

