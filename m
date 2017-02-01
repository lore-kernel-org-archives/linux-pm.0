From: Markus Mayer <code@mmayer.net>
Subject: [PATCH v6 1/2] dt-bindings: brcm: clocks: add binding for brcmstb-cpu-clk-div
Date: Wed,  1 Feb 2017 15:26:37 -0800
Message-ID: <20170201232638.74396-2-code@mmayer.net>
References: <20170201232638.74396-1-code@mmayer.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170201232638.74396-1-code@mmayer.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Arnd Bergmann <arnd@arndb.de>
Cc: Markus Mayer <mmayer@broadcom.com>, Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>, Linux Clock List <linux-clk@vger.kernel.org>, Power Management List <linux-pm@vger.kernel.org>, Device Tree List <devicetree@vger.kernel.org>, ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Markus Mayer <mmayer@broadcom.com>

Add binding document for brcm,brcmstb-cpu-clk-div.

Signed-off-by: Markus Mayer <mmayer@broadcom.com>
---
 .../bindings/clock/brcm,brcmstb-cpu-clk-div.txt    | 22 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/brcm,brcmstb-cpu-clk-div.txt

diff --git a/Documentation/devicetree/bindings/clock/brcm,brcmstb-cpu-clk-div.txt b/Documentation/devicetree/bindings/clock/brcm,brcmstb-cpu-clk-div.txt
new file mode 100644
index 0000000..7b6a8ce
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/brcm,brcmstb-cpu-clk-div.txt
@@ -0,0 +1,22 @@
+The CPU divider node serves as the sole clock for the CPU complex. It supports
+power-of-2 clock division, with a divider of "1" as the default highest-speed
+setting.
+
+Required properties:
+- compatible: shall be "brcm,brcmstb-cpu-clk-div"
+- reg: address and width of the divider configuration register
+- #clock-cells: shall be set to 0
+- clocks: phandle of clock provider which provides the source clock
+          (this would typically be a "fixed-clock" type PLL)
+
+Optional properties:
+- clock-names: the clock may be named
+
+Example:
+	cpuclkdiv: clock-controller@f03e257c {
+		compatible = "brcm,brcmstb-cpu-clk-div";
+		reg = <0xf03e257c 0x4>;
+		#clock-cells = <0>;
+		clocks = <&cpupll>;
+		clock-names = "cpupll";
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index cfff2c9..690761d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2786,6 +2786,7 @@ M:	bcm-kernel-feedback-list@broadcom.com
 L:	linux-pm@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/cpufreq/brcm,stb-avs-cpu-freq.txt
+F:	Documentation/devicetree/bindings/clock/brcm,brcmstb-cpu-clk-div.txt
 F:	drivers/cpufreq/brcmstb*
 
 BROADCOM SPECIFIC AMBA DRIVER (BCMA)
-- 
2.7.4
