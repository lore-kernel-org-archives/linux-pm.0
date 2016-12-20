From: Markus Mayer <code@mmayer.net>
Subject: [PATCH v4 1/2] dt-bindings: brcm: clocks: add binding for
 brcmstb-cpu-clk-div
Date: Tue, 20 Dec 2016 14:55:29 -0800
Message-ID: <20161220225530.96699-2-code@mmayer.net>
References: <20161220225530.96699-1-code@mmayer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161220225530.96699-1-code@mmayer.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Arnd Bergmann <arnd@arndb.de>
Cc: Device Tree List <devicetree@vger.kernel.org>, Power Management List <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>, Markus Mayer <mmayer@broadcom.com>, Linux Clock List <linux-clk@vger.kernel.org>, ARM Kernel List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

From: Markus Mayer <mmayer@broadcom.com>

Add binding document for brcm,brcmstb-cpu-clk-div.

Signed-off-by: Markus Mayer <mmayer@broadcom.com>
---
 .../bindings/clock/brcm,brcmstb-cpu-clk-div.txt    | 83 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 84 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/brcm,brcmstb-cpu-clk-div.txt

diff --git a/Documentation/devicetree/bindings/clock/brcm,brcmstb-cpu-clk-div.txt b/Documentation/devicetree/bindings/clock/brcm,brcmstb-cpu-clk-div.txt
new file mode 100644
index 0000000..3bc99c5
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/brcm,brcmstb-cpu-clk-div.txt
@@ -0,0 +1,83 @@
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
+- div-table: list of (raw_value,divider) ordered pairs that correspond to the
+             allowed clock divider settings
+- div-shift-width: least-significant bit position and width of divider value
+
+Optional properties:
+- clocks: additional clocks can be specified if needed
+- clock-names: clocks can be named, so they can be looked up
+
+Example:
+	sw_scb: sw_scb {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <432000000>;
+	};
+
+	fixed0: fixed0 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <54000000>;
+	};
+
+	cpu_pdiv: cpu_pdiv@f04e0008 {
+		compatible = "divider-clock";
+		#clock-cells = <0>;
+		reg = <0xf04e0008 0x4>;
+		bit-shift = <10>;
+		bit-mask = <0xf>;
+		index-starts-at-one;
+		clocks = <&fixed0>;
+		clock-names = "fixed0";
+	};
+
+	cpu_ndiv_int: cpu_ndiv_int {
+		compatible = "fixed-factor-clock";
+		#clock-cells = <0>;
+		clock-div = <1>;
+		clock-mult = <167>;
+		clocks = <&cpu_pdiv>;
+		clock-names = "cpu_pdiv";
+	};
+
+	cpu_mdiv_ch0: cpu_mdiv_ch0@f04e0000 {
+		compatible = "divider-clock";
+		#clock-cells = <0>;
+		reg = <0xf04e0000 0x4>;
+		bit-shift = <1>;
+		bit-mask = <0xff>;
+		index-starts-at-one;
+		clocks = <&cpu_ndiv_int>;
+		clock-names = "cpu_ndiv_int";
+	};
+
+	cpupll: cpupll@0 {
+		#clock-cells = <0>;
+		clock-frequency = <1503000000>;
+		compatible = "fixed-clock";
+	};
+
+	cpuclkdiv: cpu-clk-div@0 {
+		#clock-cells = <0>;
+		clock-names = "cpupll",
+			"cpu_mdiv_ch0",
+			"cpu_ndiv_int",
+			"sw_scb";
+		clocks = <&cpupll,
+			&cpu_mdiv_ch0,
+			&cpu_ndiv_int,
+			&sw_scb>;
+		compatible = "brcm,brcmstb-cpu-clk-div";
+		reg = <0xf03e257c 0x4>;
+		div-table = <0x00 1>;
+		div-shift-width = <0 5>;
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index f6eb97b..5473b31 100644
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
