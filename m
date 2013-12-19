From: Anson Huang <b20788@freescale.com>
Subject: [PATCH V4 2/3] ARM: imx: add vddsoc/pu setpoint info into dts
Date: Thu, 19 Dec 2013 09:16:48 -0500
Message-ID: <1387462609-13013-2-git-send-email-b20788@freescale.com>
References: <1387462609-13013-1-git-send-email-b20788@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from co9ehsobe004.messaging.microsoft.com ([207.46.163.27]:37901
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751486Ab3LSCTJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 Dec 2013 21:19:09 -0500
In-Reply-To: <1387462609-13013-1-git-send-email-b20788@freescale.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: shawn.guo@linaro.org, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

i.MX6Q needs to update vddarm, vddsoc/pu regulators when cpu freq
is changed, each setpoint has different voltage, so we need to
pass vddarm, vddsoc/pu's freq-voltage info from dts together.

Signed-off-by: Anson Huang <b20788@freescale.com>
---
 arch/arm/boot/dts/imx6q.dtsi |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index e7e8332..021e0cb 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -30,6 +30,13 @@
 				792000  1150000
 				396000  975000
 			>;
+			fsl,soc-operating-points = <
+				/* ARM kHz  SOC-PU uV */
+				1200000 1275000
+				996000	1250000
+				792000	1175000
+				396000	1175000
+			>;
 			clock-latency = <61036>; /* two CLK32 periods */
 			clocks = <&clks 104>, <&clks 6>, <&clks 16>,
 				 <&clks 17>, <&clks 170>;
-- 
1.7.9.5


