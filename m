From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH RFC 3/3] ARM: dts: enable power subsystem for i.MX28
Date: Thu, 20 Nov 2014 20:14:37 +0000
Message-ID: <1416514477-19190-4-git-send-email-stefan.wahren@i2se.com>
References: <1416514477-19190-1-git-send-email-stefan.wahren@i2se.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:65432 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756291AbaKTUPZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 20 Nov 2014 15:15:25 -0500
In-Reply-To: <1416514477-19190-1-git-send-email-stefan.wahren@i2se.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org

This patch enables the power subsystem for all i.MX28 boards.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/boot/dts/imx28.dtsi |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 47f68ac..5c163a5 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -1022,8 +1022,12 @@
 			};

 			power: power@80044000 {
+				compatible = "fsl,imx28-power";
+				#address-cells = <1>;
+				#size-cells = <1>;
 				reg = <0x80044000 0x2000>;
-				status = "disabled";
+				interrupts = <6>;
+				ranges;
 			};

 			saif1: saif@80046000 {
--
1.7.9.5

