From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v8 02/20] PM / devfreq: exynos: Add documentation for generic
 exynos bus frequency driver
Date: Fri, 08 Apr 2016 13:24:51 +0900
Message-ID: <1460089509-16260-3-git-send-email-cw00.choi@samsung.com>
References: <1460089509-16260-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1460089509-16260-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com, kgene@kernel.org
Cc: rjw@rjwysocki.net, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, linux.amoon@gmail.com, m.reichl@fivetechno.de, tjakobi@math.uni-bielefeld.de, inki.dae@samsung.com, cw00.choi@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This patch adds the documentation for generic exynos bus frequency
driver.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
---
 .../devicetree/bindings/devfreq/exynos-bus.txt     | 95 ++++++++++++++++++++++
 1 file changed, 95 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/devfreq/exynos-bus.txt

diff --git a/Documentation/devicetree/bindings/devfreq/exynos-bus.txt b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
new file mode 100644
index 000000000000..78171b918e3f
--- /dev/null
+++ b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
@@ -0,0 +1,95 @@
+* Generic Exynos Bus frequency device
+
+The Samsung Exynos SoC has many buses for data transfer between DRAM
+and sub-blocks in SoC. Most Exynos SoCs share the common architecture
+for buses. Generally, each bus of Exynos SoC includes a source clock
+and a power line, which are able to change the clock frequency
+of the bus in runtime. To monitor the usage of each bus in runtime,
+the driver uses the PPMU (Platform Performance Monitoring Unit), which
+is able to measure the current load of sub-blocks.
+
+There are a little different composition among Exynos SoC because each Exynos
+SoC has different sub-blocks. Therefore, shch difference should be specified
+in devicetree file instead of each device driver. In result, this driver
+is able to support the bus frequency for all Exynos SoCs.
+
+Required properties for bus device:
+- compatible: Should be "samsung,exynos-bus".
+- clock-names : the name of clock used by the bus, "bus".
+- clocks : phandles for clock specified in "clock-names" property.
+- operating-points-v2: the OPP table including frequency/voltage information
+  to support DVFS (Dynamic Voltage/Frequency Scaling) feature.
+- vdd-supply: the regulator to provide the buses with the voltage.
+- devfreq-events: the devfreq-event device to monitor the current utilization
+  of buses.
+
+Optional properties for bus device:
+- exynos,saturation-ratio: the percentage value which is used to calibrate
+			the performance count against total cycle count.
+- exynos,voltage-tolerance: the percentage value for bus voltage tolerance
+			which is used to calculate the max voltage.
+
+Example1:
+	Show the AXI buses of Exynos3250 SoC. Exynos3250 divides the buses to
+	power line (regulator). The MIF (Memory Interface) AXI bus is used to
+	transfer data between DRAM and CPU and uses the VDD_MIF regualtor.
+
+	- power line(VDD_MIF) --> bus for DMC (Dynamic Memory Controller) block
+
+	- MIF bus's frequency/voltage table
+	-----------------------
+	|Lv| Freq   | Voltage |
+	-----------------------
+	|L1| 50000  |800000   |
+	|L2| 100000 |800000   |
+	|L3| 134000 |800000   |
+	|L4| 200000 |825000   |
+	|L5| 400000 |875000   |
+	-----------------------
+
+Example2 :
+	The bus of DMC (Dynamic Memory Controller) block in exynos3250.dtsi
+	is listed below:
+
+	bus_dmc: bus_dmc {
+		compatible = "samsung,exynos-bus";
+		clocks = <&cmu_dmc CLK_DIV_DMC>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_dmc_opp_table>;
+		status = "disabled";
+	};
+
+	bus_dmc_opp_table: opp_table1 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp@50000000 {
+			opp-hz = /bits/ 64 <50000000>;
+			opp-microvolt = <800000>;
+		};
+		opp@100000000 {
+			opp-hz = /bits/ 64 <100000000>;
+			opp-microvolt = <800000>;
+		};
+		opp@134000000 {
+			opp-hz = /bits/ 64 <134000000>;
+			opp-microvolt = <800000>;
+		};
+		opp@200000000 {
+			opp-hz = /bits/ 64 <200000000>;
+			opp-microvolt = <825000>;
+		};
+		opp@400000000 {
+			opp-hz = /bits/ 64 <400000000>;
+			opp-microvolt = <875000>;
+		};
+	};
+
+	Usage case to handle the frequency and voltage of bus on runtime
+	in exynos3250-rinato.dts is listed below:
+
+	&bus_dmc {
+		devfreq-events = <&ppmu_dmc0_3>, <&ppmu_dmc1_3>;
+		vdd-supply = <&buck1_reg>;	/* VDD_MIF */
+		status = "okay";
+	};
-- 
1.9.1
