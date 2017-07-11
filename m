From: Mason <slash.tmp@free.fr>
Subject: Re: cpufreq: frequency scaling spec in DT node
Date: Tue, 11 Jul 2017 15:36:50 +0200
Message-ID: <9a2638ee-e04f-13f1-b1e5-56f27b58da2e@free.fr>
References: <1f665895-a2a0-6bdf-a9d9-66219fe3a8ef@free.fr>
 <20170629100459.GL29665@vireshk-i7>
 <538b1aa2-9298-6f21-392e-73d6559b581c@free.fr>
 <20170629143432.GM29665@vireshk-i7>
 <405bfa30-b083-2690-5747-aa1cd423e576@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp5-g21.free.fr ([212.27.42.5]:30977 "EHLO smtp5-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932246AbdGKNhD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 11 Jul 2017 09:37:03 -0400
In-Reply-To: <405bfa30-b083-2690-5747-aa1cd423e576@free.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm <linux-pm@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>

On 11/07/2017 11:27, Mason wrote:

> I'll experiment with the other solution of creating the OPP table
> at init.

For the sake of discussion, based on your suggestion to use
dev_pm_opp_add(), I have tested the patch below.

There is one remaining error:
[    2.071139] of: dev_pm_opp_of_cpumask_add_table: couldn't find opp table for cpu:0, -19

Reached through:
[    1.878461] [<c0359a0c>] (dev_pm_opp_of_add_table) from [<c0359ff0>] (dev_pm_opp_of_cpumask_add_table+0x40/0xc8)
[    1.888695] [<c0359ff0>] (dev_pm_opp_of_cpumask_add_table) from [<c03d66d8>] (cpufreq_init+0x23c/0x2dc)
[    1.898139] [<c03d66d8>] (cpufreq_init) from [<c03d3d94>] (cpufreq_online+0xb8/0x660)
[    1.906009] [<c03d3d94>] (cpufreq_online) from [<c03d43f8>] (cpufreq_add_dev+0xbc/0xcc)
[    1.914058] [<c03d43f8>] (cpufreq_add_dev) from [<c0350560>] (subsys_interface_register+0x90/0xcc)
[    1.923065] [<c0350560>] (subsys_interface_register) from [<c03d32f4>] (cpufreq_register_driver+0x15c/0x1e0)
[    1.932945] [<c03d32f4>] (cpufreq_register_driver) from [<c03d67f0>] (dt_cpufreq_probe+0x78/0xec)
[    1.941866] [<c03d67f0>] (dt_cpufreq_probe) from [<c035327c>] (platform_drv_probe+0x34/0x6c)

The cpufreq-dt driver seems to recover despite the error:

/sys/devices/system/cpu/cpu0/cpufreq$ cat scaling_available_frequencies
135000 243000 405000 607500 1215000 

Regards.



 arch/arm/boot/dts/tango4-smp8758.dtsi |  1 -
 drivers/cpufreq/Makefile              |  1 +
 drivers/cpufreq/cpufreq-dt-platdev.c  |  2 --
 drivers/cpufreq/tango-cpufreq.c       | 45 +++++++++++++++++++++++++++++++++++
 4 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/tango4-smp8758.dtsi b/arch/arm/boot/dts/tango4-smp8758.dtsi
index d2e65c46bcc7..eca33d568690 100644
--- a/arch/arm/boot/dts/tango4-smp8758.dtsi
+++ b/arch/arm/boot/dts/tango4-smp8758.dtsi
@@ -13,7 +13,6 @@
 			reg = <0>;
 			clocks = <&clkgen CPU_CLK>;
 			clock-latency = <1>;
-			operating-points = <1215000 0 607500 0 405000 0 243000 0 135000 0>;
 		};
 
 		cpu1: cpu@1 {
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 0a9b6a093646..5ae156dc0d35 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -75,6 +75,7 @@ obj-$(CONFIG_ARM_SA1110_CPUFREQ)	+= sa1110-cpufreq.o
 obj-$(CONFIG_ARM_SCPI_CPUFREQ)		+= scpi-cpufreq.o
 obj-$(CONFIG_ARM_SPEAR_CPUFREQ)		+= spear-cpufreq.o
 obj-$(CONFIG_ARM_STI_CPUFREQ)		+= sti-cpufreq.o
+obj-$(CONFIG_ARCH_TANGO)		+= tango-cpufreq.o
 obj-$(CONFIG_ARM_TEGRA20_CPUFREQ)	+= tegra20-cpufreq.o
 obj-$(CONFIG_ARM_TEGRA124_CPUFREQ)	+= tegra124-cpufreq.o
 obj-$(CONFIG_ARM_VEXPRESS_SPC_CPUFREQ)	+= vexpress-spc-cpufreq.o
diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 71267626456b..1490e4ce3fbc 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -70,8 +70,6 @@
 	{ .compatible = "rockchip,rk3368", },
 	{ .compatible = "rockchip,rk3399", },
 
-	{ .compatible = "sigma,tango4" },
-
 	{ .compatible = "ti,am33xx", },
 	{ .compatible = "ti,dra7", },
 	{ .compatible = "ti,omap2", },
diff --git a/drivers/cpufreq/tango-cpufreq.c b/drivers/cpufreq/tango-cpufreq.c
new file mode 100644
index 000000000000..270c8261ebfa
--- /dev/null
+++ b/drivers/cpufreq/tango-cpufreq.c
@@ -0,0 +1,45 @@
+#include <linux/of.h>
+#include <linux/cpu.h>
+#include <linux/clk.h>
+#include <linux/pm_opp.h>
+#include <linux/platform_device.h>
+
+static const struct of_device_id machines[] __initconst = {
+	{ .compatible = "sigma,tango4" },
+	{ .compatible = "sigma,tango5" },
+	{ /* sentinel */ }
+};
+
+static void __init build_opp_table(struct device *cpu_dev, struct clk *cpu_clk)
+{
+	unsigned long max_freq = clk_get_rate(cpu_clk);
+
+	dev_pm_opp_add(cpu_dev, max_freq / 1, 0);
+	dev_pm_opp_add(cpu_dev, max_freq / 2, 0);
+	dev_pm_opp_add(cpu_dev, max_freq / 3, 0);
+	dev_pm_opp_add(cpu_dev, max_freq / 5, 0);
+	dev_pm_opp_add(cpu_dev, max_freq / 9, 0);
+}
+
+static int __init cpufreq_dt_platdev_init(void)
+{
+	struct device *cpu_dev = get_cpu_device(0);
+	const struct of_device_id *match;
+	struct clk *cpu_clk;
+	void *res;
+
+	match = of_match_node(machines, of_root);
+	if (!match)
+		return -ENODEV;
+
+	cpu_clk = clk_get(cpu_dev, NULL);
+	if (IS_ERR(cpu_clk))
+		return -ENODEV;
+
+	build_opp_table(cpu_dev, cpu_clk);
+
+	res = platform_device_register_data(NULL, "cpufreq-dt", -1, NULL, 0);
+
+	return PTR_ERR_OR_ZERO(res);
+}
+device_initcall(cpufreq_dt_platdev_init);
