From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [RFC 1/3] devfreq: dt-bindings: Document Exynos3250 devfreq driver
Date: Fri, 05 Dec 2014 17:46:26 +0100
Message-ID: <1417797988-29225-2-git-send-email-k.kozlowski@samsung.com>
References: <1417797988-29225-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1417797988-29225-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Chanwoo Choi <cw00.choi@samsung.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: linux-pm@vger.kernel.org

Add documentation for bindings used by Exynos3250 devfreq driver.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 .../bindings/arm/samsung/exynos3250-devfreq.txt    | 66 ++++++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/samsung/exynos3250-devfreq.txt

diff --git a/Documentation/devicetree/bindings/arm/samsung/exynos3250-devfreq.txt b/Documentation/devicetree/bindings/arm/samsung/exynos3250-devfreq.txt
new file mode 100644
index 000000000000..047955e9e371
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/samsung/exynos3250-devfreq.txt
@@ -0,0 +1,66 @@
+Samsung Exynos3250 devfreq driver
+=================================
+
+The driver support changing frequencies and voltage for:
+ - memory controller and bus,
+ - peripheral buses (left and right).
+
+Memory controller and bus
+=========================
+Required properties:
+ - compatible : should be "samsung,exynos3250-busfreq-mif"
+ - reg : two sets (offset and length of the register) for PPMU registers
+	used by this devfreq driver
+ - clock-names : one clock of name "dmc" to manage frequency
+ - clocks : phandle and specifier for clock listed in clock-names property
+ - vdd_mif-supply : phandle to MIF voltage regulator
+
+Peripheral buses
+================
+Required properties:
+ - compatible : should be "samsung,exynos3250-busfreq-int"
+ - reg : two sets (offset and length of the register) for PPMU registers
+	used by this devfreq driver
+ - clock-names : names for PPMU clocks and bus clocks to manage frequencies;
+	All following clock names (and corresponding phandles) must be
+	provided:
+	- "ppmu_left", "ppmu_right",
+	- "aclk_400", "aclk_266", "aclk_200", "aclk_160", "aclk_gdl", "aclk_gdr", "mfc";
+ - clocks : phandles and specifiers for clocks listed in clock-names property
+ - vdd_mif-supply : phandle to INT voltage regulator
+
+Example
+=======
+	busfreq_mif: busfreq@106A0000 {
+		compatible = "samsung,exynos3250-busfreq-mif";
+		reg = <0x106A0000 0x2000>, <0x106B0000 0x2000>;
+		clocks = <&cmu_dmc CLK_DIV_DMC>;
+		clock-names = "dmc";
+		vdd_mif-supply = <&buck1_reg>;
+		status = "okay";
+	};
+
+	busfreq_int: busfreq@116A0000 {
+		compatible = "samsung,exynos3250-busfreq-int";
+		reg = <0x116A0000 0x2000>, <0x112A0000 0x2000>;
+		clocks = <&cmu CLK_PPMULEFT>,
+			<&cmu CLK_PPMURIGHT>,
+			<&cmu CLK_DIV_ACLK_400_MCUISP>,
+			<&cmu CLK_DIV_ACLK_266>,
+			<&cmu CLK_DIV_ACLK_200>,
+			<&cmu CLK_DIV_ACLK_160>,
+			<&cmu CLK_DIV_GDL>,
+			<&cmu CLK_DIV_GDR>,
+			<&cmu CLK_DIV_MFC>;
+		clock-names = "ppmuleft",
+			"ppmuright",
+			"aclk_400",
+			"aclk_266",
+			"aclk_200",
+			"aclk_160",
+			"aclk_gdl",
+			"aclk_gdr",
+			"mfc";
+		vdd_int-supply = <&buck3_reg>;
+		status = "okay";
+	};
-- 
1.9.1
