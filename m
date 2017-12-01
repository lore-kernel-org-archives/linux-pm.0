From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH 6/6] arm64: dts: marvell: armada-37xx: add nodes allowing cpufreq support
Date: Fri,  1 Dec 2017 12:25:08 +0100
Message-ID: <20171201112508.14121-7-gregory.clement@free-electrons.com>
References: <20171201112508.14121-1-gregory.clement@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:32789 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752209AbdLALZ2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Dec 2017 06:25:28 -0500
In-Reply-To: <20171201112508.14121-1-gregory.clement@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Antoine Tenart <antoine.tenart@free-electrons.com>, =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>, Victor Gu <xigu@marvell.com>, Marcin Wojtas <mw@semihalf.com>, Wilson Ding <dingwei@marvell.com>, Hua Jing <jinghua@marvell.com>, Neta Zur Hershkovits <neta@marvell.com>, Evan Wang <xswang@marvell.com>

In order to be able to use cpu freq, we need to associate a clock to each
CPU and to expose the power management registers.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-372x.dtsi | 1 +
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-372x.dtsi b/arch/arm64/boot/dts/marvell/armada-372x.dtsi
index 59d7557d3b1b..2554e0baea6b 100644
--- a/arch/arm64/boot/dts/marvell/armada-372x.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-372x.dtsi
@@ -56,6 +56,7 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a53","arm,armv8";
 			reg = <0x1>;
+			clocks = <&nb_periph_clk 16>;
 			enable-method = "psci";
 		};
 	};
diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index 90c26d616a54..6e51ed54d75c 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -65,6 +65,7 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a53", "arm,armv8";
 			reg = <0>;
+			clocks = <&nb_periph_clk 16>;
 			enable-method = "psci";
 		};
 	};
@@ -234,6 +235,12 @@
 				};
 			};
 
+			nb_pm: nb_pm@14000 {
+				compatible = "marvell,armada-3700-nb-pm",
+					     "syscon";
+				reg = <0x14000 0x60>;
+			};
+
 			pinctrl_sb: pinctrl@18800 {
 				compatible = "marvell,armada3710-sb-pinctrl",
 					     "syscon", "simple-mfd";
-- 
2.15.0
