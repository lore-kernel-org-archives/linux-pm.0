From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] ARM: EXYNOS: add power domains support for EXYNOS5440
Date: Fri, 02 Aug 2013 15:23:19 +0200
Message-ID: <2729097.X0eAsuYF97@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: Myungjoo Ham <myungjoo.ham@samsung.com>, Tomasz Figa <t.figa@samsung.com>, Stephen Warren <swarren@wwwdotorg.org>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On EXYNOS5440 power domains are handled in a different way than on
the previous EXYNOS SoCs. Add support for them to EXYNOS pm_domains
driver. Then add device tree nodes for PCIe (controlling power for
PCIe host controller) and Conn2 (controlling power for Ethernet,
SATA and USB controllers) power domains to exynos5440.dtsi.

Currently if runtime Power Management is enabled and the driver
for devices under power domain is disabled then the power domain
will be disabled by EXYNOS pm_domains driver. To make more active
use of power domains (dynamically enable and disabled them as
needed) it is required to add runtime PM support to pci-exynos,
stmmac, ahci_platform, ohci-exynos and ehci-s5p drivers (to be
done later).

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Myungjoo Ham <myungjoo.ham@samsung.com>
Cc: Tomasz Figa <t.figa@samsung.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
---
 Documentation/devicetree/bindings/arm/exynos/power_domain.txt |   33 ++
 arch/arm/boot/dts/exynos5440.dtsi                             |   23 +
 arch/arm/mach-exynos/Kconfig                                  |    1 
 arch/arm/mach-exynos/common.c                                 |    4 
 arch/arm/mach-exynos/pm_domains.c                             |  138 +++++++++-
 5 files changed, 190 insertions(+), 9 deletions(-)

Index: b/Documentation/devicetree/bindings/arm/exynos/power_domain.txt
===================================================================
--- a/Documentation/devicetree/bindings/arm/exynos/power_domain.txt	2013-08-02 14:45:53.551392396 +0200
+++ b/Documentation/devicetree/bindings/arm/exynos/power_domain.txt	2013-08-02 14:46:29.799391845 +0200
@@ -5,20 +5,47 @@ to gate power to one or more peripherals
 
 Required Properties:
 - compatible: should be one of the following.
-    * samsung,exynos4210-pd - for exynos4210 type power domain.
+    * samsung,exynos4210-pd - for Exynos4210 type power domain.
+    * samsung,exynos5440-pd - for Exynos5440 type power domain.
 - reg: physical base address of the controller and length of memory mapped
-    region.
+    region (Exynos4210 type power domain) or bit offset in the control
+    register (Exynos5440 type power domain).
+
+Additional parent node must be created for Exynos5440 power domains with
+the following required properties:
+- compatible: samsung,exynos5440-power-domains, simple-bus
+- reg: physical base address of the XMU controller and length of memory
+    mapped region
 
 Node of a device using power domains must have a samsung,power-domain property
 defined with a phandle to respective power domain.
 
-Example:
+Example for Exynos4210 compatible power domain:
 
 	lcd0: power-domain-lcd0 {
 		compatible = "samsung,exynos4210-pd";
 		reg = <0x10023C00 0x10>;
 	};
 
+Example for Exynos5440 compatible power domains:
+
+	power-domains@00160000 {
+		compatible = "samsung,exynos5440-power-domains", "simple-bus";
+		reg = <0x00160000 0x1000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pd_pcie: pcie-power-domain@6 {
+			compatible = "samsung,exynos5440-pd";
+			reg = <6>;
+		};
+
+		pd_conn2: conn2-power-domain@7 {
+			compatible = "samsung,exynos5440-pd";
+			reg = <7>;
+		};
+	};
+
 Example of the node using power domain:
 
 	node {
Index: b/arch/arm/boot/dts/exynos5440.dtsi
===================================================================
--- a/arch/arm/boot/dts/exynos5440.dtsi	2013-08-02 14:45:53.599392397 +0200
+++ b/arch/arm/boot/dts/exynos5440.dtsi	2013-08-02 14:46:29.815391842 +0200
@@ -29,6 +29,23 @@
 		#clock-cells = <1>;
 	};
 
+	power-domains@00160000 {
+		compatible = "samsung,exynos5440-power-domains", "simple-bus";
+		reg = <0x00160000 0x1000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pd_pcie: pcie-power-domain@6 {
+			compatible = "samsung,exynos5440-pd";
+			reg = <6>;
+		};
+
+		pd_conn2: conn2-power-domain@7 {
+			compatible = "samsung,exynos5440-pd";
+			reg = <7>;
+		};
+	};
+
 	gic:interrupt-controller@2E0000 {
 		compatible = "arm,cortex-a15-gic";
 		#interrupt-cells = <3>;
@@ -192,6 +209,7 @@
 		phy-mode = "sgmii";
 		clocks = <&clock 25>;
 		clock-names = "stmmaceth";
+		samsung,power-domain = <&pd_conn2>;
 	};
 
 	amba {
@@ -240,6 +258,7 @@
 		interrupts = <0 30 0>;
 		clocks = <&clock 23>;
 		clock-names = "sata";
+		samsung,power-domain = <&pd_conn2>;
 	};
 
 	ohci@220000 {
@@ -248,6 +267,7 @@
 		interrupts = <0 29 0>;
 		clocks = <&clock 24>;
 		clock-names = "usbhost";
+		samsung,power-domain = <&pd_conn2>;
 	};
 
 	ehci@221000 {
@@ -256,6 +276,7 @@
 		interrupts = <0 29 0>;
 		clocks = <&clock 24>;
 		clock-names = "usbhost";
+		samsung,power-domain = <&pd_conn2>;
 	};
 
 	pcie@290000 {
@@ -275,6 +296,7 @@
 		#interrupt-cells = <1>;
 		interrupt-map-mask = <0 0 0 0>;
 		interrupt-map = <0x0 0 &gic 53>;
+		samsung,power-domain = <&pd_pcie>;
 	};
 
 	pcie@2a0000 {
@@ -294,5 +316,6 @@
 		#interrupt-cells = <1>;
 		interrupt-map-mask = <0 0 0 0>;
 		interrupt-map = <0x0 0 &gic 56>;
+		samsung,power-domain = <&pd_pcie>;
 	};
 };
Index: b/arch/arm/mach-exynos/Kconfig
===================================================================
--- a/arch/arm/mach-exynos/Kconfig	2013-08-02 14:45:53.563392396 +0200
+++ b/arch/arm/mach-exynos/Kconfig	2013-08-02 14:46:29.815391842 +0200
@@ -104,6 +104,7 @@ config SOC_EXYNOS5440
 	select MIGHT_HAVE_PCI
 	select PCI_DOMAINS if PCI
 	select PINCTRL_EXYNOS5440
+	select PM_GENERIC_DOMAINS if PM
 	select PM_OPP
 	help
 	  Enable EXYNOS5440 SoC support
Index: b/arch/arm/mach-exynos/common.c
===================================================================
--- a/arch/arm/mach-exynos/common.c	2013-08-02 14:45:53.583392397 +0200
+++ b/arch/arm/mach-exynos/common.c	2013-08-02 14:46:29.815391842 +0200
@@ -296,10 +296,6 @@ void exynos5_restart(enum reboot_mode mo
 
 void __init exynos_init_late(void)
 {
-	if (of_machine_is_compatible("samsung,exynos5440"))
-		/* to be supported later */
-		return;
-
 	exynos_pm_late_initcall();
 }
 
Index: b/arch/arm/mach-exynos/pm_domains.c
===================================================================
--- a/arch/arm/mach-exynos/pm_domains.c	2013-08-02 14:45:53.571392397 +0200
+++ b/arch/arm/mach-exynos/pm_domains.c	2013-08-02 14:47:36.471390825 +0200
@@ -24,12 +24,14 @@
 
 #include <mach/regs-pmu.h>
 #include <plat/devs.h>
+#include <plat/cpu.h>
 
 /*
  * Exynos specific wrapper around the generic power domain
  */
 struct exynos_pm_domain {
 	void __iomem *base;
+	unsigned int bit_offset;
 	char const *name;
 	bool is_off;
 	struct generic_pm_domain pd;
@@ -74,6 +76,75 @@ static int exynos_pd_power_off(struct ge
 	return exynos_pd_power(domain, false);
 }
 
+#define EXYNOS5440_PMU_STATUS	0x00BC
+#define EXYNOS5440_PMU_CTRL	0x00C0
+
+static int exynos5440_check_status(struct exynos_pm_domain *pd, u32 *pwr)
+{
+	u32 timeout = 10; /* Wait max 1ms */
+	int ret = 0;
+
+	do {
+		*pwr = readl(pd->base + EXYNOS5440_PMU_STATUS);
+		if ((*pwr & BIT(pd->bit_offset + 16)) == 0)
+			break;
+		if (!timeout) {
+			pr_err("%s: power domain %s status read failed\n",
+			       __func__, pd->name);
+			ret = -ETIMEDOUT;
+			break;
+		}
+		timeout--;
+		usleep_range(80, 100);
+	} while (1);
+
+	return ret;
+}
+
+static int exynos5440_pd_power(struct generic_pm_domain *domain,
+			       bool power_on)
+{
+	struct exynos_pm_domain *pd =
+			container_of(domain, struct exynos_pm_domain, pd);
+	void __iomem *base = pd->base;
+	unsigned int bit_offset = pd->bit_offset;
+	u32 pwr;
+	int ret;
+
+	pwr = readl(base + EXYNOS5440_PMU_CTRL);
+	if (power_on)
+		pwr |= BIT(bit_offset);
+	else
+		pwr |= BIT(bit_offset + 16);
+	writel(pwr, base + EXYNOS5440_PMU_CTRL);
+
+	ret = exynos5440_check_status(pd, &pwr);
+	if (ret)
+		goto err;
+
+	if ((power_on && (pwr & BIT(bit_offset)) == 0) ||
+	    (!power_on && (pwr & BIT(bit_offset)))) {
+		ret = -EIO;
+		goto err;
+	}
+
+	return 0;
+err:
+	pr_err("Power domain %s %s failed (error=%d)\n",
+	       domain->name, power_on ? "enable" : "disable", ret);
+	return ret;
+}
+
+static int exynos5440_pd_power_on(struct generic_pm_domain *domain)
+{
+	return exynos5440_pd_power(domain, true);
+}
+
+static int exynos5440_pd_power_off(struct generic_pm_domain *domain)
+{
+	return exynos5440_pd_power(domain, false);
+}
+
 static void exynos_add_device_to_domain(struct exynos_pm_domain *pd,
 					 struct device *dev)
 {
@@ -146,7 +217,7 @@ static struct notifier_block platform_nb
 	.notifier_call = exynos_pm_notifier_call,
 };
 
-static __init int exynos4_pm_init_power_domain(void)
+static __init int exynos4210_pm_init_power_domain(void)
 {
 	struct platform_device *pdev;
 	struct device_node *np;
@@ -182,7 +253,70 @@ static __init int exynos4_pm_init_power_
 
 	return 0;
 }
-arch_initcall(exynos4_pm_init_power_domain);
+
+static __init int exynos5440_pm_init_power_domain(void)
+{
+	struct device_node *np, *node = NULL;
+	void __iomem *reg_base;
+
+	np = of_find_compatible_node(NULL, NULL,
+				    "samsung,exynos5440-power-domains");
+	if (!np)
+		return 0;
+
+	reg_base = of_iomap(np, 0);
+
+	for_each_child_of_node(np, node) {
+		struct platform_device *pdev;
+		struct exynos_pm_domain *pd;
+		u32 pwr;
+		int ret, on;
+
+		pdev = of_find_device_by_node(node);
+		if (pdev == NULL) {
+			pr_err("%s: failed to get platform device for domain\n",
+			       __func__);
+			continue;
+		}
+
+		pd = kzalloc(sizeof(*pd), GFP_KERNEL);
+		if (!pd) {
+			pr_err("%s: failed to allocate memory for domain\n",
+			       __func__);
+			return -ENOMEM;
+		}
+
+		pd->pd.name = kstrdup(node->name, GFP_KERNEL);
+		pd->name = pd->pd.name;
+		pd->base = reg_base;
+		if (of_property_read_u32(node, "reg", &pd->bit_offset))
+			pr_err("%s: bit offset not specified for domain %s\n",
+			       __func__, pd->name);
+		pd->pd.power_off = exynos5440_pd_power_off;
+		pd->pd.power_on = exynos5440_pd_power_on;
+		pd->pd.of_node = node;
+
+		platform_set_drvdata(pdev, pd);
+
+		ret = exynos5440_check_status(pd, &pwr);
+		on = ret ? 0 : !!(pwr & BIT(pd->bit_offset));
+
+		pm_genpd_init(&pd->pd, NULL, !on);
+	}
+
+	bus_register_notifier(&platform_bus_type, &platform_nb);
+
+	return 0;
+}
+
+static __init int exynos_pm_init_power_domain(void)
+{
+	if (soc_is_exynos5440())
+		return exynos5440_pm_init_power_domain();
+	else
+		return exynos4210_pm_init_power_domain();
+}
+arch_initcall(exynos_pm_init_power_domain);
 
 int __init exynos_pm_late_initcall(void)
 {
