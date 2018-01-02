From: Anson Huang <Anson.Huang@nxp.com>
Subject: [PATCH 1/2] ARM: dts: imx6ul: add 696MHz operating point
Date: Wed, 3 Jan 2018 01:07:38 +0800
Message-ID: <1514912859-17691-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bn3nam01on0055.outbound.protection.outlook.com ([104.47.33.55]:22560
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752076AbeABJ3z (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 2 Jan 2018 04:29:55 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk, rjw@rjwysocki.net, viresh.kumar@linaro.org, ping.bai@nxp.com, aisheng.dong@nxp.com

Add 696MHz operating point according to datasheet
(Rev. 0, 12/2015).

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6ul.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index e0b4a46..86b3251 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -68,12 +68,14 @@
 			clock-latency = <61036>; /* two CLK32 periods */
 			operating-points = <
 				/* kHz	uV */
+				696000	1275000
 				528000	1175000
 				396000	1025000
 				198000	950000
 			>;
 			fsl,soc-operating-points = <
 				/* KHz	uV */
+				696000	1275000
 				528000	1175000
 				396000	1175000
 				198000	1175000
-- 
1.9.1
