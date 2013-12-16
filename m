From: Anson Huang <b20788@freescale.com>
Subject: [PATCH 3/4] ARM: imx: add VDDSOC/PU setpoint info into dts
Date: Mon, 16 Dec 2013 16:14:09 -0500
Message-ID: <1387228450-641-1-git-send-email-b20788@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: shawn.guo@linaro.org, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

i.MX6Q needs to update VDDARM, VDDSOC/PU regulator when CPUFreq
is changed, each setpoint has different voltage, so we need to
pass VDDARM, VDDSOC/PU's freq-voltage info from dts.

Signed-off-by: Anson Huang <b20788@freescale.com>
---
 arch/arm/boot/dts/imx6q.dtsi |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index e7e8332..03da628 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -30,6 +30,13 @@
 				792000  1150000
 				396000  975000
 			>;
+			fsl,soc-operating-points = <
+			/* ARM kHz  SOC-PU uV */
+				1200000	1275000
+				996000	1250000
+				792000	1175000
+				396000	1175000
+			>;
 			clock-latency = <61036>; /* two CLK32 periods */
 			clocks = <&clks 104>, <&clks 6>, <&clks 16>,
 				 <&clks 17>, <&clks 170>;
-- 
1.7.9.5


