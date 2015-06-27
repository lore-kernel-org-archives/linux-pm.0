From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH RFC v2 04/16] WIP: ARM: PM domains for CPUs/clusters
Date: Fri, 26 Jun 2015 21:02:24 -0600
Message-ID: <1435374156-19214-5-git-send-email-lina.iyer@linaro.org>
References: <1435374156-19214-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:34431 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751732AbbF0DCu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Jun 2015 23:02:50 -0400
Received: by pdbep18 with SMTP id ep18so63069559pdb.1
        for <linux-pm@vger.kernel.org>; Fri, 26 Jun 2015 20:02:50 -0700 (PDT)
In-Reply-To: <1435374156-19214-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, ulf.hansson@linaro.org, khilman@linaro.org
Cc: geert@linux-m68k.org, k.kozlowski@samsung.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, msivasub@codeaurora.org, agross@codeaurora.org

From: Kevin Hilman <khilman@linaro.org>

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 534f27c..fc59876 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -61,6 +61,7 @@
 			reg = <0x0>;
 			clock-frequency = <1800000000>;
 			cci-control-port = <&cci_control1>;
+			power-domains = <&big_cluster_pd>;
 		};
 
 		cpu1: cpu@1 {
@@ -69,6 +70,7 @@
 			reg = <0x1>;
 			clock-frequency = <1800000000>;
 			cci-control-port = <&cci_control1>;
+			power-domains = <&big_cluster_pd>;
 		};
 
 		cpu2: cpu@2 {
@@ -77,6 +79,7 @@
 			reg = <0x2>;
 			clock-frequency = <1800000000>;
 			cci-control-port = <&cci_control1>;
+			power-domains = <&big_cluster_pd>;
 		};
 
 		cpu3: cpu@3 {
@@ -85,6 +88,7 @@
 			reg = <0x3>;
 			clock-frequency = <1800000000>;
 			cci-control-port = <&cci_control1>;
+			power-domains = <&big_cluster_pd>;
 		};
 
 		cpu4: cpu@100 {
@@ -93,6 +97,7 @@
 			reg = <0x100>;
 			clock-frequency = <1000000000>;
 			cci-control-port = <&cci_control0>;
+			power-domains = <&little_cluster_pd>;
 		};
 
 		cpu5: cpu@101 {
@@ -101,6 +106,7 @@
 			reg = <0x101>;
 			clock-frequency = <1000000000>;
 			cci-control-port = <&cci_control0>;
+			power-domains = <&little_cluster_pd>;
 		};
 
 		cpu6: cpu@102 {
@@ -109,6 +115,7 @@
 			reg = <0x102>;
 			clock-frequency = <1000000000>;
 			cci-control-port = <&cci_control0>;
+			power-domains = <&little_cluster_pd>;
 		};
 
 		cpu7: cpu@103 {
@@ -117,6 +124,7 @@
 			reg = <0x103>;
 			clock-frequency = <1000000000>;
 			cci-control-port = <&cci_control0>;
+			power-domains = <&little_cluster_pd>;
 		};
 	};
 
@@ -249,6 +257,16 @@
 		};
 	};
 
+	big_cluster_pd: big_cluster {
+		compatible = "arm,pd";
+		#power-domain-cells = <0>;
+	};
+
+	little_cluster_pd: little_cluster {
+		compatible = "arm,pd";
+ 		#power-domain-cells = <0>;
+	};
+
 	gsc_pd: power-domain@10044000 {
 		compatible = "samsung,exynos4210-pd";
 		reg = <0x10044000 0x20>;
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index e69f7a1..98ce19c 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -78,6 +78,7 @@ CFLAGS_pj4-cp0.o		:= -marm
 AFLAGS_iwmmxt.o			:= -Wa,-mcpu=iwmmxt
 obj-$(CONFIG_ARM_CPU_TOPOLOGY)  += topology.o
 obj-$(CONFIG_VDSO)		+= vdso.o
+obj-$(CONFIG_PM_GENERIC_DOMAINS) += domains.o
 
 ifneq ($(CONFIG_ARCH_EBSA110),y)
   obj-y		+= io.o
diff --git a/arch/arm/kernel/domains.c b/arch/arm/kernel/domains.c
new file mode 100644
index 0000000..8388f54
--- /dev/null
+++ b/arch/arm/kernel/domains.c
@@ -0,0 +1,122 @@
+#define DEBUG
+
+#include <linux/kernel.h>
+#include <linux/of_platform.h>
+#include <linux/device.h>
+#include <linux/pm_domain.h>
+#include <linux/pm_runtime.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#define NAME_MAX 16
+
+struct arm_pm_domain {
+	struct generic_pm_domain genpd;
+};
+
+static inline
+struct arm_pm_domain *to_arm_pd(struct generic_pm_domain *d)
+{
+	return container_of(d, struct arm_pm_domain, genpd);
+}
+
+static int arm_pd_power_down(struct generic_pm_domain *genpd)
+{
+	/* pr_info("KJH: %s: %s\n", __func__, genpd->name); */
+	return 0;
+}
+
+static int arm_pd_power_up(struct generic_pm_domain *genpd)
+{
+	/* pr_info("KJH: %s: %s\n", __func__, genpd->name); */
+	return 0;
+}
+
+static int arm_domain_cpu_init(void)
+{
+	int cpuid, ret = 0;
+
+	/* Find any CPU nodes with a phandle to this power domain */
+	for_each_possible_cpu(cpuid) {
+		struct device *cpu_dev;
+
+		/* FIXME: this is open-coding of_cpu_device_node_get(), but I want handle to cpu_dev */
+		cpu_dev = get_cpu_device(cpuid);
+		if (!cpu_dev) {
+ 			pr_warn("%s: Unable to get device for CPU%d\n", __func__, cpuid);
+			return -ENODEV;
+		}
+
+		/* 
+		 * HACK: genpd checks if devices are runtime_suspended
+		 * before doing a poweroff of the domain.  However, that check
+		 * assumes that that device has a driver.  Since CPU devices don't
+		 * have a driver, genpd assumes that the device is runtime_suspended
+		 * and will power off the domain as soon as the any device 
+		 * in the domain does a runtime_suspend.
+		 *
+		 * c.f. the following code in pm_genpd_poweroff():
+		 *
+		 * if (pdd->dev->driver && (!pm_runtime_suspended(pdd->dev)
+		 *      || pdd->dev->power.irq_safe))
+		 *  	not_suspended++;
+		 *
+		 * Just removing the pdd->dev->driver check would also work, 
+		 * but not sure if that's right in the general case.
+		 */
+		cpu_dev->driver = kzalloc(sizeof(struct device_driver), GFP_KERNEL);
+		WARN_ON(!cpu_dev->driver);
+
+		if (cpu_online(cpuid)) {
+			pm_runtime_set_active(cpu_dev);
+			pm_runtime_get_noresume(cpu_dev);
+		} else {
+			pm_runtime_set_suspended(cpu_dev);
+		}
+		pm_runtime_irq_safe(cpu_dev);
+		pm_runtime_enable(cpu_dev);
+
+		ret = genpd_dev_pm_attach(cpu_dev);
+		if (ret) {
+			dev_warn(cpu_dev, "%s: Unable to attach to power-domain: %d\n", __func__, ret);
+			pm_runtime_disable(cpu_dev);
+		}
+	}
+
+	return 0;
+}
+device_initcall(arm_domain_cpu_init);
+
+static int arm_domain_init(void)
+{
+	struct platform_device *pdev;
+	struct device_node *np;
+
+	for_each_compatible_node(np, NULL, "arm,pd") {
+		struct arm_pm_domain *pd;
+		struct device *dev;
+
+		pdev = of_find_device_by_node(np);
+		dev = &pdev->dev;
+
+		pd = kzalloc(sizeof(*pd), GFP_KERNEL);
+		if (!pd) {
+			pr_err("%s: failed to allocate memory for domain\n",
+					__func__);
+			return -ENOMEM;
+		}
+
+		pd->genpd.name = kstrdup(np->name, GFP_KERNEL);
+		pd->genpd.power_off = arm_pd_power_down;
+		pd->genpd.power_on = arm_pd_power_up;
+		platform_set_drvdata(pdev, pd);
+
+		dev_dbg(dev, "adding as generic power domain.\n");
+		pm_genpd_init(&pd->genpd, &simple_qos_governor, false);
+		of_genpd_add_provider_simple(np, &pd->genpd);
+	}
+
+	return 0;
+}
+arch_initcall(arm_domain_init);
diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 42ffb8b..02140e6 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -5,6 +5,7 @@
  *
  * This file is released under the GPLv2.
  */
+#define DEBUG
 
 #include <linux/kernel.h>
 #include <linux/io.h>
-- 
2.1.4

