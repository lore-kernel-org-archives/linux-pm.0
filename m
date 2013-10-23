From: Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH 4/4] mvebu: Dove: Add clocks and DFS interrupt to cpu node in DT.
Date: Wed, 23 Oct 2013 15:04:21 +0200
Message-ID: <1382533461-31021-4-git-send-email-andrew@lunn.ch>
References: <1382533461-31021-1-git-send-email-andrew@lunn.ch>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:43371 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753792Ab3JWNJU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 23 Oct 2013 09:09:20 -0400
In-Reply-To: <1382533461-31021-1-git-send-email-andrew@lunn.ch>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Jason Cooper <jason@lakedaemon.net>, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux ARM <linux-arm-kernel@lists.infradead.org>, Andrew Lunn <andrew@lunn.ch>

The dove-cpufreq driver needs access to the DDR and CPU clock.  There
is also an interrupt generated when the DFS hardware completes a
change of frequencey. Add these to the cpu node in DT.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
 arch/arm/boot/dts/dove.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
index 1fd615d..e96d7a6 100644
--- a/arch/arm/boot/dts/dove.dtsi
+++ b/arch/arm/boot/dts/dove.dtsi
@@ -19,6 +19,10 @@
 			device_type = "cpu";
 			next-level-cache = <&l2>;
 			reg = <0>;
+			clocks = <&core_clk 1>, <&core_clk 3>;
+			clock-names = "cpu_clk", "ddrclk";
+			interrupt-parent = <&pmu_intc>;
+			interrupts = <0>;
 		};
 	};
 
-- 
1.8.4.rc3

