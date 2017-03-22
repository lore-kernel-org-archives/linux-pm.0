From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: [RFC 7/8] cpufreq: imx6q: Initialize LDO bypass
Date: Wed, 22 Mar 2017 18:53:09 +0200
Message-ID: <75ec3ea8fe812b4cf689e0c130358e81aa7fbd13.1490199005.git.leonard.crestez@nxp.com>
References: <cover.1490199005.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1490199005.git.leonard.crestez@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Leonard Crestez <leonard.crestez@nxp.com>, Anson Huang <Anson.Huang@nxp.com>, Irina Tirdea <irina.tirdea@nxp.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Octavian Purdila <octavian.purdila@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>, Robin Gong <yibin.gong@nxp.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Several imx6* socs have three built-in regulators LDO_ARM LDO_SOC and
LDO_PU used to control internal chip voltages. "ldo-bypass" mode refers
to placing these regulators in bypass mode and controlling voltages from
an external power management chip instead. This is intended to save
power at the expense of an extra PMIC on the board.

The voltages for these regulators are controlled from the imxq6 cpufreq
driver so it makes sense to also control LDO bypass from here. The gpc
driver also fetches a reference to LDO_PU and uses it to gate power to
graphics blocks.

The LDO regulator has a minimum dropout voltage of 125mv so enabling
bypass mode will raise the effective voltage by that amount. We need set
the minimum frequency first to avoid overvolting when enabling LDO
bypass.

The binding is an u32 fsl,ldo-bypass in the gpc node because that's how
it was defined in the freescale vendor tree for a long time and
compatibility is desirable. Otherwise it would be a bool.

Some versions of u-boot shipped by freescale check this same property
and set regulators in bypass mode before linux actually starts so we
check for that scenario as well and finish early.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 .../devicetree/bindings/power/fsl,imx-gpc.txt      |   4 +
 arch/arm/mach-imx/gpc.c                            |   7 +
 drivers/cpufreq/imx6q-cpufreq.c                    | 171 +++++++++++++++++++++
 3 files changed, 182 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/fsl,imx-gpc.txt b/Documentation/devicetree/bindings/power/fsl,imx-gpc.txt
index 65cc034..8a7584b 100644
--- a/Documentation/devicetree/bindings/power/fsl,imx-gpc.txt
+++ b/Documentation/devicetree/bindings/power/fsl,imx-gpc.txt
@@ -11,6 +11,10 @@ Required properties:
   datasheet
 - interrupts: Should contain GPC interrupt request 1
 - pu-supply: Link to the LDO regulator powering the PU power domain
+- fsl,ldo-bypass: Should be 0 or 1 to enable LDO bypass mode (default 0).
+  This is performed in cooperation with cpufreq. Some versions of uboot will
+  also look at this property and set the arm and soc regulators in bypass mode
+  before linux.
 - clocks: Clock phandles to devices in the PU power domain that need
 	  to be enabled during domain power-up for reset propagation.
 - #power-domain-cells: Should be 1, see below:
diff --git a/arch/arm/mach-imx/gpc.c b/arch/arm/mach-imx/gpc.c
index ce64d11..62a2555 100644
--- a/arch/arm/mach-imx/gpc.c
+++ b/arch/arm/mach-imx/gpc.c
@@ -22,6 +22,7 @@
 #include <linux/pm_domain.h>
 #include <linux/regulator/consumer.h>
 #include <linux/irqchip/arm-gic.h>
+#include <linux/cpufreq.h>
 #include "common.h"
 #include "hardware.h"
 
@@ -461,6 +462,12 @@ static int imx_gpc_probe(struct platform_device *pdev)
 	if (!of_property_read_bool(pdev->dev.of_node, "#power-domain-cells"))
 		return 0;
 
+	/* wait for cpufreq to initialize before using pu_reg */
+	if (IS_ENABLED(CONFIG_ARM_IMX6Q_CPUFREQ) && cpufreq_get_current_driver() == NULL) {
+		dev_dbg(&pdev->dev, "cpufreq driver not ready, retry\n");
+		return -EPROBE_DEFER;
+	}
+
 	pu_reg = devm_regulator_get_optional(&pdev->dev, "pu");
 	if (PTR_ERR(pu_reg) == -ENODEV)
 		pu_reg = NULL;
diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index e2c1fbf..a0c11ed 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -159,8 +159,179 @@ static int imx6q_set_target(struct cpufreq_policy *policy, unsigned int index)
 	return 0;
 }
 
+/*
+ * Enable ldo-bypass mode if configured and not already performed by u-boot
+ */
+static int imx6q_cpufreq_init_ldo_bypass(void)
+{
+	struct device_node *gpc_node;
+	unsigned long old_freq_hz;
+	int i, old_freq_index;
+	u32 bypass = 0;
+	int ret = 0, ret2;
+
+	/* Read ldo-bypass property */
+	gpc_node = of_find_compatible_node(NULL, NULL, "fsl,imx6q-gpc");
+	if (!gpc_node)
+		return 0;
+	ret = of_property_read_u32(gpc_node, "fsl,ldo-bypass", &bypass);
+	if (ret && ret != -EINVAL)
+		dev_warn(cpu_dev, "failed reading fsl,ldo-bypass property: %d\n", ret);
+	if (!bypass)
+		goto out;
+
+	/*
+	 * Freescale u-boot handles ldo-bypass by setting
+	 * arm/soc in bypass and vddpu disabled.
+	 *
+	 * If this is the case we don't need any special freq lowering.
+	 */
+	if (regulator_is_bypass(arm_reg) == 1 &&
+		regulator_is_bypass(soc_reg) == 1)
+	{
+		dev_info(cpu_dev, "vddarm and vddsoc already in bypass\n");
+		if (IS_ERR(pu_reg)) {
+			ret = 0;
+			goto out;
+		} else if (regulator_is_enabled(pu_reg) == 0) {
+			ret = regulator_allow_bypass(pu_reg, true);
+			if (ret) {
+				dev_err(cpu_dev, "failed to enable vddpu bypass: %d\n", ret);
+				goto out;
+			}
+			ret = regulator_is_bypass(pu_reg);
+			if (ret != 1) {
+				ret = -EINVAL;
+				dev_err(cpu_dev, "failed bypass check for vddpu: %d\n", ret);
+				goto out;
+			}
+			ret = 0;
+			goto out;
+		} else if (regulator_is_bypass(pu_reg) == 1) {
+			dev_info(cpu_dev, "vddpu also already in bypass\n");
+			ret = 0;
+			goto out;
+		} else
+			dev_info(cpu_dev, "Need frequency lowering to set vddpu in bypass\n");
+	}
+
+	/*
+	 * Enable LDO bypass from kernel.
+	 *
+	 * The LDO regulator has a minimum dropout voltage of 125mv so enabling
+	 * bypass mode will raise the effective voltage by that amount.
+	 *
+	 * We set the minimum frequency first to avoid overvolting.
+	 */
+
+	/* Find current freq so we can restore it. */
+	old_freq_hz = clk_get_rate(arm_clk);
+	if (!old_freq_hz) {
+		dev_err(cpu_dev, "failed to determine current arm freq\n");
+		goto out;
+	}
+	old_freq_index = 0;
+	for (i = 1; i < soc_opp_count; ++i) {
+		if (abs(freq_table[old_freq_index].frequency - old_freq_hz) >
+			abs(freq_table[i].frequency - old_freq_hz)) {
+			old_freq_index = i;
+		}
+	}
+	dev_dbg(cpu_dev, "current freq %lu Mhz index %d\n",
+			old_freq_hz / 1000000, old_freq_index);
+
+	dev_info(cpu_dev, "enabling ldo_bypass\n");
+	ret = imx6q_set_target(NULL, 0);
+	if (ret) {
+		dev_warn(cpu_dev, "Failed to lower frequency: %d\n", ret);
+		goto out;
+	}
+
+	ret = regulator_allow_bypass(arm_reg, true);
+	if (ret) {
+		dev_err(cpu_dev, "failed to enable bypass for vddarm: %d\n", ret);
+		goto out_restore_cpufreq;
+	}
+	ret = regulator_allow_bypass(soc_reg, true);
+	if (ret) {
+		dev_err(cpu_dev, "failed to enable bypass for vddsoc: %d\n", ret);
+		goto out_restore_arm_reg;
+	}
+	if (!IS_ERR(pu_reg)) {
+		ret = regulator_allow_bypass(pu_reg, true);
+		if (ret) {
+			dev_err(cpu_dev, "failed to enable bypass for vddsoc: %d\n", ret);
+			goto out_restore_soc_reg;
+		}
+	}
+
+	/*
+	 * We need to do get_bypass afterwards because allow_bypass does not
+	 * actually guarantee bypass mode was entered if it returns 0. In
+	 * theory there might be another used.
+	 */
+	ret = regulator_is_bypass(arm_reg);
+	if (ret != 1) {
+		ret = -EINVAL;
+		dev_err(cpu_dev, "failed bypass check for vddarm: %d\n", ret);
+		goto out_restore_pu_reg;
+	}
+	ret = regulator_is_bypass(soc_reg);
+	if (ret != 1) {
+		ret = -EINVAL;
+		dev_err(cpu_dev, "failed bypass check for vddsoc: %d\n", ret);
+		goto out_restore_pu_reg;
+	}
+	if (!IS_ERR(pu_reg)) {
+		ret = regulator_is_bypass(pu_reg);
+		if (ret != 1) {
+			ret = -EINVAL;
+			dev_err(cpu_dev, "failed bypass check for vddpu: %d\n", ret);
+			goto out_restore_pu_reg;
+		}
+	}
+
+	ret = imx6q_set_target(NULL, old_freq_index);
+	if (ret)
+		dev_warn(cpu_dev, "Failed to restore frequency: %d\n", ret);
+	/* Success! */
+	ret = 0;
+	goto out;
+
+out_restore_pu_reg:
+	if (!IS_ERR(pu_reg)) {
+		ret2 = regulator_allow_bypass(pu_reg, false);
+		if (ret2)
+			dev_err(cpu_dev, "failed to restore vddpu: %d\n", ret2);
+	}
+out_restore_arm_reg:
+	ret2 = regulator_allow_bypass(arm_reg, false);
+	if (ret2)
+		dev_err(cpu_dev, "failed to restore vddarm: %d\n", ret2);
+out_restore_soc_reg:
+	ret2 = regulator_allow_bypass(soc_reg, false);
+	if (ret2)
+		dev_err(cpu_dev, "failed to restore vddsoc: %d\n", ret2);
+out_restore_cpufreq:
+	ret2 = imx6q_set_target(NULL, old_freq_index);
+	if (ret2)
+		dev_warn(cpu_dev, "Failed to restore frequency: %d\n", ret2);
+
+out:
+	of_node_put(gpc_node);
+	return ret;
+}
+
 static int imx6q_cpufreq_init(struct cpufreq_policy *policy)
 {
+	int ret;
+
+	ret = imx6q_cpufreq_init_ldo_bypass();
+	if (ret) {
+		dev_err(cpu_dev, "failed to enable ldo_bypass: %d\n", ret);
+		return ret;
+	}
+
 	policy->clk = arm_clk;
 	policy->suspend_freq = freq_table[soc_opp_count - 1].frequency;
 	return cpufreq_generic_init(policy, freq_table, transition_latency);
-- 
2.7.4
