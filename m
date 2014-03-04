From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [RFC v3 5/5] cpufreq:LAB:dts:trats2: Add DTS nodes for LAB governor
Date: Tue, 04 Mar 2014 11:27:32 +0100
Message-ID: <1393928852-22725-6-git-send-email-l.majewski@samsung.com>
References: <1367590072-10496-1-git-send-email-jonghwa3.lee@samsung.com>
 <1393928852-22725-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1393928852-22725-1-git-send-email-l.majewski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, linux-kernel <linux-kernel@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, Tomasz Figa <t.figa@samsung.com>, Thomas Abraham <ta.omasab@gmail.com>, thomas.ab@samsung.com, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Adds LAB attributes to proper CPU0 node.
The lab-num-of-states attribute shows how many compartments will be used.
The LAB code is prepared to be more fine grained.

The lab-ctrl-freq defines how the LAB governor will be controlled:
	- 0xFFFFFFFE 		- use the minimal frequency
	- 0xFFFFFFFF 		- enable boost
	- non zero 		- set the frequency specified
	- zero		- use ondemand to specify output frequency

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
---
 arch/arm/boot/dts/exynos4412-trats2.dts |   29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/exynos4412-trats2.dts
index 4f851cc..9eeeb38 100644
--- a/arch/arm/boot/dts/exynos4412-trats2.dts
+++ b/arch/arm/boot/dts/exynos4412-trats2.dts
@@ -511,6 +511,35 @@
 		};
 	};
 
+	cpus {
+		cpu@0 {
+			compatible = "arm,cortex-a9";
+			device_type = "cpu";
+			lab-num-of-states = <5>;
+			lab-ctrl-freq = < 0          0          0          1300000    1200000
+					  0          0          0          0          1300000
+					  0          0          0          0          0xFFFFFFFF
+					  0          0          0          0xFFFFFFFF 0xFFFFFFFF
+					  0xFFFFFFFE 0xFFFFFFFE 0xFFFFFFFE 0xFFFFFFFE 0xFFFFFFFE
+				>;
+		};
+
+		cpu@1 {
+			compatible = "arm,cortex-a9";
+			device_type = "cpu";
+		};
+
+		cpu@2 {
+			compatible = "arm,cortex-a9";
+			device_type = "cpu";
+		};
+
+		cpu@3 {
+			compatible = "arm,cortex-a9";
+			device_type = "cpu";
+		};
+	};
+
 	camera {
 		pinctrl-0 = <&cam_port_b_clk_active>;
 		pinctrl-names = "default";
-- 
1.7.10.4
