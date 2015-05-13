From: Mikko Perttunen <mikko.perttunen@kapsi.fi>
Subject: [PATCH v9 01/17] clk: tegra: Add binding for the Tegra124 DFLL clocksource
Date: Wed, 13 May 2015 17:58:35 +0300
Message-ID: <1431529131-16710-2-git-send-email-mikko.perttunen@kapsi.fi>
References: <1431529131-16710-1-git-send-email-mikko.perttunen@kapsi.fi>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1431529131-16710-1-git-send-email-mikko.perttunen@kapsi.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: swarren@wwwdotorg.org, thierry.reding@gmail.com, gnurou@gmail.com, pdeschrijver@nvidia.com, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: mturquette@linaro.org, pwalmsley@nvidia.com, vinceh@nvidia.com, pgaikwad@nvidia.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tuomas.tynkkynen@iki.fi, Tuomas Tynkkynen <ttynkkynen@nvidia.com>, Mikko Perttunen <mikko.perttunen@kapsi.fi>
List-Id: linux-pm@vger.kernel.org

From: Tuomas Tynkkynen <ttynkkynen@nvidia.com>

The DFLL is the main clocksource for the fast CPU cluster on Tegra124
and also provides automatic CPU rail voltage scaling as well. The DFLL
is a separate IP block from the usual Tegra124 clock-and-reset
controller, so it gets its own node in the device tree.

Signed-off-by: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
Signed-off-by: Mikko Perttunen <mikko.perttunen@kapsi.fi>
Acked-by: Michael Turquette <mturquette@linaro.org>
---
 .../bindings/clock/nvidia,tegra124-dfll.txt        | 79 ++++++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt

diff --git a/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt b/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt
new file mode 100644
index 0000000..ee7e5fd
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt
@@ -0,0 +1,79 @@
+NVIDIA Tegra124 DFLL FCPU clocksource
+
+This binding uses the common clock binding:
+Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+The DFLL IP block on Tegra is a root clocksource designed for clocking
+the fast CPU cluster. It consists of a free-running voltage controlled
+oscillator connected to the CPU voltage rail (VDD_CPU), and a closed loop
+control module that will automatically adjust the VDD_CPU voltage by
+communicating with an off-chip PMIC either via an I2C bus or via PWM signals.
+Currently only the I2C mode is supported by these bindings.
+
+Required properties:
+- compatible : should be "nvidia,tegra124-dfll"
+- reg : Defines the following set of registers, in the order listed:
+        - registers for the DFLL control logic.
+        - registers for the I2C output logic.
+        - registers for the integrated I2C master controller.
+        - look-up table RAM for voltage register values.
+- interrupts: Should contain the DFLL block interrupt.
+- clocks: Must contain an entry for each entry in clock-names.
+  See clock-bindings.txt for details.
+- clock-names: Must include the following entries:
+  - soc: Clock source for the DFLL control logic.
+  - ref: The closed loop reference clock
+  - i2c: Clock source for the integrated I2C master.
+- resets: Must contain an entry for each entry in reset-names.
+  See ../reset/reset.txt for details.
+- reset-names: Must include the following entries:
+  - dvco: Reset control for the DFLL DVCO.
+- #clock-cells: Must be 0.
+- clock-output-names: Name of the clock output.
+- vdd-cpu-supply: Regulator for the CPU voltage rail that the DFLL
+  hardware will start controlling. The regulator will be queried for
+  the I2C register, control values and supported voltages.
+
+Required properties for the control loop parameters:
+- nvidia,sample-rate: Sample rate of the DFLL control loop.
+- nvidia,droop-ctrl: See the register CL_DVFS_DROOP_CTRL in the TRM.
+- nvidia,force-mode: See the field DFLL_PARAMS_FORCE_MODE in the TRM.
+- nvidia,cf: Numeric value, see the field DFLL_PARAMS_CF_PARAM in the TRM.
+- nvidia,ci: Numeric value, see the field DFLL_PARAMS_CI_PARAM in the TRM.
+- nvidia,cg: Numeric value, see the field DFLL_PARAMS_CG_PARAM in the TRM.
+
+Optional properties for the control loop parameters:
+- nvidia,cg-scale: Boolean value, see the field DFLL_PARAMS_CG_SCALE in the TRM.
+
+Required properties for I2C mode:
+- nvidia,i2c-fs-rate: I2C transfer rate, if using full speed mode.
+
+Example:
+
+clock@0,70110000 {
+        compatible = "nvidia,tegra124-dfll";
+        reg = <0 0x70110000 0 0x100>, /* DFLL control */
+              <0 0x70110000 0 0x100>, /* I2C output control */
+              <0 0x70110100 0 0x100>, /* Integrated I2C controller */
+              <0 0x70110200 0 0x100>; /* Look-up table RAM */
+        interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&tegra_car TEGRA124_CLK_DFLL_SOC>,
+                 <&tegra_car TEGRA124_CLK_DFLL_REF>,
+                 <&tegra_car TEGRA124_CLK_I2C5>;
+        clock-names = "soc", "ref", "i2c";
+        resets = <&tegra_car TEGRA124_RST_DFLL_DVCO>;
+        reset-names = "dvco";
+        #clock-cells = <0>;
+        clock-output-names = "dfllCPU_out";
+        vdd-cpu-supply = <&vdd_cpu>;
+        status = "okay";
+
+        nvidia,sample-rate = <12500>;
+        nvidia,droop-ctrl = <0x00000f00>;
+        nvidia,force-mode = <1>;
+        nvidia,cf = <10>;
+        nvidia,ci = <0>;
+        nvidia,cg = <2>;
+
+        nvidia,i2c-fs-rate = <400000>;
+};
-- 
2.3.0
