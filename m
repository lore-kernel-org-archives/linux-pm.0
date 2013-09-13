From: Dmitry Eremin-Solenikov <dmitry_eremin@mentor.com>
Subject: [PATCH] cpufreq: merge maple cpufreq driver to pmac64
Date: Fri, 13 Sep 2013 15:30:06 +0400
Message-ID: <1379071806-17453-1-git-send-email-dmitry_eremin@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>
List-Id: linux-pm@vger.kernel.org

Maple boards use the same frequency changing mechanism, as do newer
PowerMacs (write to SCOM). Thus maple-cpufreq.c is a reduced version
of pmac64 driver. Merge it back to pmac64-cpufreq.c

Signed-off-by: Dmitry Eremin-Solenikov <dmitry_eremin@mentor.com>
---
 drivers/cpufreq/Kconfig.powerpc  |  10 +-
 drivers/cpufreq/Makefile         |   1 -
 drivers/cpufreq/maple-cpufreq.c  | 308 ---------------------------------------
 drivers/cpufreq/pmac64-cpufreq.c |  58 +++++---
 4 files changed, 40 insertions(+), 337 deletions(-)
 delete mode 100644 drivers/cpufreq/maple-cpufreq.c

diff --git a/drivers/cpufreq/Kconfig.powerpc b/drivers/cpufreq/Kconfig.powerpc
index 25ca9db..2a802bd 100644
--- a/drivers/cpufreq/Kconfig.powerpc
+++ b/drivers/cpufreq/Kconfig.powerpc
@@ -17,14 +17,6 @@ config CPU_FREQ_CBE_PMI
 	  frequencies. Using PMI, the processor will not only be able to run at
 	  lower speed, but also at lower core voltage.
 
-config CPU_FREQ_MAPLE
-	bool "Support for Maple 970FX Evaluation Board"
-	depends on PPC_MAPLE
-	select CPU_FREQ_TABLE
-	help
-	  This adds support for frequency switching on Maple 970FX
-	  Evaluation Board and compatible boards (IBM JS2x blades).
-
 config PPC_CORENET_CPUFREQ
 	tristate "CPU frequency scaling driver for Freescale E500MC SoCs"
 	depends on PPC_E500MC && OF && COMMON_CLK
@@ -46,7 +38,7 @@ config CPU_FREQ_PMAC
 
 config CPU_FREQ_PMAC64
 	bool "Support for some Apple G5s"
-	depends on PPC_PMAC && PPC64
+	depends on (PPC_PMAC || PPC_MAPLE) && PPC64
 	select CPU_FREQ_TABLE
 	help
 	  This adds support for frequency switching on Apple iMac G5,
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index d345b5a..488502e 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -83,7 +83,6 @@ obj-$(CONFIG_ARM_TEGRA_CPUFREQ)		+= tegra-cpufreq.o
 obj-$(CONFIG_CPU_FREQ_CBE)		+= ppc-cbe-cpufreq.o
 ppc-cbe-cpufreq-y			+= ppc_cbe_cpufreq_pervasive.o ppc_cbe_cpufreq.o
 obj-$(CONFIG_CPU_FREQ_CBE_PMI)		+= ppc_cbe_cpufreq_pmi.o
-obj-$(CONFIG_CPU_FREQ_MAPLE)		+= maple-cpufreq.o
 obj-$(CONFIG_PPC_CORENET_CPUFREQ)   += ppc-corenet-cpufreq.o
 obj-$(CONFIG_CPU_FREQ_PMAC)		+= pmac32-cpufreq.o
 obj-$(CONFIG_CPU_FREQ_PMAC64)		+= pmac64-cpufreq.o
diff --git a/drivers/cpufreq/maple-cpufreq.c b/drivers/cpufreq/maple-cpufreq.c
deleted file mode 100644
index cdd6291..0000000
--- a/drivers/cpufreq/maple-cpufreq.c
+++ /dev/null
@@ -1,308 +0,0 @@
-/*
- *  Copyright (C) 2011 Dmitry Eremin-Solenikov
- *  Copyright (C) 2002 - 2005 Benjamin Herrenschmidt <benh@kernel.crashing.org>
- *  and                       Markus Demleitner <msdemlei@cl.uni-heidelberg.de>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This driver adds basic cpufreq support for SMU & 970FX based G5 Macs,
- * that is iMac G5 and latest single CPU desktop.
- */
-
-#undef DEBUG
-
-#include <linux/module.h>
-#include <linux/types.h>
-#include <linux/errno.h>
-#include <linux/kernel.h>
-#include <linux/delay.h>
-#include <linux/sched.h>
-#include <linux/cpufreq.h>
-#include <linux/init.h>
-#include <linux/completion.h>
-#include <linux/mutex.h>
-#include <linux/time.h>
-#include <linux/of.h>
-
-#define DBG(fmt...) pr_debug(fmt)
-
-/* see 970FX user manual */
-
-#define SCOM_PCR 0x0aa001			/* PCR scom addr */
-
-#define PCR_HILO_SELECT		0x80000000U	/* 1 = PCR, 0 = PCRH */
-#define PCR_SPEED_FULL		0x00000000U	/* 1:1 speed value */
-#define PCR_SPEED_HALF		0x00020000U	/* 1:2 speed value */
-#define PCR_SPEED_QUARTER	0x00040000U	/* 1:4 speed value */
-#define PCR_SPEED_MASK		0x000e0000U	/* speed mask */
-#define PCR_SPEED_SHIFT		17
-#define PCR_FREQ_REQ_VALID	0x00010000U	/* freq request valid */
-#define PCR_VOLT_REQ_VALID	0x00008000U	/* volt request valid */
-#define PCR_TARGET_TIME_MASK	0x00006000U	/* target time */
-#define PCR_STATLAT_MASK	0x00001f00U	/* STATLAT value */
-#define PCR_SNOOPLAT_MASK	0x000000f0U	/* SNOOPLAT value */
-#define PCR_SNOOPACC_MASK	0x0000000fU	/* SNOOPACC value */
-
-#define SCOM_PSR 0x408001			/* PSR scom addr */
-/* warning: PSR is a 64 bits register */
-#define PSR_CMD_RECEIVED	0x2000000000000000U   /* command received */
-#define PSR_CMD_COMPLETED	0x1000000000000000U   /* command completed */
-#define PSR_CUR_SPEED_MASK	0x0300000000000000U   /* current speed */
-#define PSR_CUR_SPEED_SHIFT	(56)
-
-/*
- * The G5 only supports two frequencies (Quarter speed is not supported)
- */
-#define CPUFREQ_HIGH                  0
-#define CPUFREQ_LOW                   1
-
-static struct cpufreq_frequency_table maple_cpu_freqs[] = {
-	{CPUFREQ_HIGH,		0},
-	{CPUFREQ_LOW,		0},
-	{0,			CPUFREQ_TABLE_END},
-};
-
-static struct freq_attr *maple_cpu_freqs_attr[] = {
-	&cpufreq_freq_attr_scaling_available_freqs,
-	NULL,
-};
-
-/* Power mode data is an array of the 32 bits PCR values to use for
- * the various frequencies, retrieved from the device-tree
- */
-static int maple_pmode_cur;
-
-static DEFINE_MUTEX(maple_switch_mutex);
-
-static const u32 *maple_pmode_data;
-static int maple_pmode_max;
-
-/*
- * SCOM based frequency switching for 970FX rev3
- */
-static int maple_scom_switch_freq(int speed_mode)
-{
-	unsigned long flags;
-	int to;
-
-	local_irq_save(flags);
-
-	/* Clear PCR high */
-	scom970_write(SCOM_PCR, 0);
-	/* Clear PCR low */
-	scom970_write(SCOM_PCR, PCR_HILO_SELECT | 0);
-	/* Set PCR low */
-	scom970_write(SCOM_PCR, PCR_HILO_SELECT |
-		      maple_pmode_data[speed_mode]);
-
-	/* Wait for completion */
-	for (to = 0; to < 10; to++) {
-		unsigned long psr = scom970_read(SCOM_PSR);
-
-		if ((psr & PSR_CMD_RECEIVED) == 0 &&
-		    (((psr >> PSR_CUR_SPEED_SHIFT) ^
-		      (maple_pmode_data[speed_mode] >> PCR_SPEED_SHIFT)) & 0x3)
-		    == 0)
-			break;
-		if (psr & PSR_CMD_COMPLETED)
-			break;
-		udelay(100);
-	}
-
-	local_irq_restore(flags);
-
-	maple_pmode_cur = speed_mode;
-	ppc_proc_freq = maple_cpu_freqs[speed_mode].frequency * 1000ul;
-
-	return 0;
-}
-
-static int maple_scom_query_freq(void)
-{
-	unsigned long psr = scom970_read(SCOM_PSR);
-	int i;
-
-	for (i = 0; i <= maple_pmode_max; i++)
-		if ((((psr >> PSR_CUR_SPEED_SHIFT) ^
-		      (maple_pmode_data[i] >> PCR_SPEED_SHIFT)) & 0x3) == 0)
-			break;
-	return i;
-}
-
-/*
- * Common interface to the cpufreq core
- */
-
-static int maple_cpufreq_verify(struct cpufreq_policy *policy)
-{
-	return cpufreq_frequency_table_verify(policy, maple_cpu_freqs);
-}
-
-static int maple_cpufreq_target(struct cpufreq_policy *policy,
-	unsigned int target_freq, unsigned int relation)
-{
-	unsigned int newstate = 0;
-	struct cpufreq_freqs freqs;
-	int rc;
-
-	if (cpufreq_frequency_table_target(policy, maple_cpu_freqs,
-			target_freq, relation, &newstate))
-		return -EINVAL;
-
-	if (maple_pmode_cur == newstate)
-		return 0;
-
-	mutex_lock(&maple_switch_mutex);
-
-	freqs.old = maple_cpu_freqs[maple_pmode_cur].frequency;
-	freqs.new = maple_cpu_freqs[newstate].frequency;
-
-	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
-	rc = maple_scom_switch_freq(newstate);
-	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
-
-	mutex_unlock(&maple_switch_mutex);
-
-	return rc;
-}
-
-static unsigned int maple_cpufreq_get_speed(unsigned int cpu)
-{
-	return maple_cpu_freqs[maple_pmode_cur].frequency;
-}
-
-static int maple_cpufreq_cpu_init(struct cpufreq_policy *policy)
-{
-	policy->cpuinfo.transition_latency = 12000;
-	policy->cur = maple_cpu_freqs[maple_scom_query_freq()].frequency;
-	/* secondary CPUs are tied to the primary one by the
-	 * cpufreq core if in the secondary policy we tell it that
-	 * it actually must be one policy together with all others. */
-	cpumask_setall(policy->cpus);
-	cpufreq_frequency_table_get_attr(maple_cpu_freqs, policy->cpu);
-
-	return cpufreq_frequency_table_cpuinfo(policy,
-		maple_cpu_freqs);
-}
-
-
-static struct cpufreq_driver maple_cpufreq_driver = {
-	.name		= "maple",
-	.owner		= THIS_MODULE,
-	.flags		= CPUFREQ_CONST_LOOPS,
-	.init		= maple_cpufreq_cpu_init,
-	.verify		= maple_cpufreq_verify,
-	.target		= maple_cpufreq_target,
-	.get		= maple_cpufreq_get_speed,
-	.attr		= maple_cpu_freqs_attr,
-};
-
-static int __init maple_cpufreq_init(void)
-{
-	struct device_node *cpus;
-	struct device_node *cpunode;
-	unsigned int psize;
-	unsigned long max_freq;
-	const u32 *valp;
-	u32 pvr_hi;
-	int rc = -ENODEV;
-
-	/*
-	 * Behave here like powermac driver which checks machine compatibility
-	 * to ease merging of two drivers in future.
-	 */
-	if (!of_machine_is_compatible("Momentum,Maple") &&
-	    !of_machine_is_compatible("Momentum,Apache"))
-		return 0;
-
-	cpus = of_find_node_by_path("/cpus");
-	if (cpus == NULL) {
-		DBG("No /cpus node !\n");
-		return -ENODEV;
-	}
-
-	/* Get first CPU node */
-	for (cpunode = NULL;
-	     (cpunode = of_get_next_child(cpus, cpunode)) != NULL;) {
-		const u32 *reg = of_get_property(cpunode, "reg", NULL);
-		if (reg == NULL || (*reg) != 0)
-			continue;
-		if (!strcmp(cpunode->type, "cpu"))
-			break;
-	}
-	if (cpunode == NULL) {
-		printk(KERN_ERR "cpufreq: Can't find any CPU 0 node\n");
-		goto bail_cpus;
-	}
-
-	/* Check 970FX for now */
-	/* we actually don't care on which CPU to access PVR */
-	pvr_hi = PVR_VER(mfspr(SPRN_PVR));
-	if (pvr_hi != 0x3c && pvr_hi != 0x44) {
-		printk(KERN_ERR "cpufreq: Unsupported CPU version (%x)\n",
-				pvr_hi);
-		goto bail_noprops;
-	}
-
-	/* Look for the powertune data in the device-tree */
-	/*
-	 * On Maple this property is provided by PIBS in dual-processor config,
-	 * not provided by PIBS in CPU0 config and also not provided by SLOF,
-	 * so YMMV
-	 */
-	maple_pmode_data = of_get_property(cpunode, "power-mode-data", &psize);
-	if (!maple_pmode_data) {
-		DBG("No power-mode-data !\n");
-		goto bail_noprops;
-	}
-	maple_pmode_max = psize / sizeof(u32) - 1;
-
-	/*
-	 * From what I see, clock-frequency is always the maximal frequency.
-	 * The current driver can not slew sysclk yet, so we really only deal
-	 * with powertune steps for now. We also only implement full freq and
-	 * half freq in this version. So far, I haven't yet seen a machine
-	 * supporting anything else.
-	 */
-	valp = of_get_property(cpunode, "clock-frequency", NULL);
-	if (!valp)
-		return -ENODEV;
-	max_freq = (*valp)/1000;
-	maple_cpu_freqs[0].frequency = max_freq;
-	maple_cpu_freqs[1].frequency = max_freq/2;
-
-	/* Force apply current frequency to make sure everything is in
-	 * sync (voltage is right for example). Firmware may leave us with
-	 * a strange setting ...
-	 */
-	msleep(10);
-	maple_pmode_cur = -1;
-	maple_scom_switch_freq(maple_scom_query_freq());
-
-	printk(KERN_INFO "Registering Maple CPU frequency driver\n");
-	printk(KERN_INFO "Low: %d Mhz, High: %d Mhz, Cur: %d MHz\n",
-		maple_cpu_freqs[1].frequency/1000,
-		maple_cpu_freqs[0].frequency/1000,
-		maple_cpu_freqs[maple_pmode_cur].frequency/1000);
-
-	rc = cpufreq_register_driver(&maple_cpufreq_driver);
-
-	of_node_put(cpunode);
-	of_node_put(cpus);
-
-	return rc;
-
-bail_noprops:
-	of_node_put(cpunode);
-bail_cpus:
-	of_node_put(cpus);
-
-	return rc;
-}
-
-module_init(maple_cpufreq_init);
-
-
-MODULE_LICENSE("GPL");
diff --git a/drivers/cpufreq/pmac64-cpufreq.c b/drivers/cpufreq/pmac64-cpufreq.c
index 7ba4234..2962e6a 100644
--- a/drivers/cpufreq/pmac64-cpufreq.c
+++ b/drivers/cpufreq/pmac64-cpufreq.c
@@ -22,6 +22,9 @@
 #include <linux/init.h>
 #include <linux/completion.h>
 #include <linux/mutex.h>
+#include <linux/time.h>
+#include <linux/of.h>
+#ifdef CONFIG_PPC_PMAC
 #include <asm/prom.h>
 #include <asm/machdep.h>
 #include <asm/irq.h>
@@ -30,6 +33,7 @@
 #include <asm/time.h>
 #include <asm/smu.h>
 #include <asm/pmac_pfunc.h>
+#endif
 
 #define DBG(fmt...) pr_debug(fmt)
 
@@ -87,11 +91,12 @@ static DEFINE_MUTEX(g5_switch_mutex);
 
 static unsigned long transition_latency;
 
-#ifdef CONFIG_PMAC_SMU
+#if defined(CONFIG_PMAC_SMU) || defined(CONFIG_PPC_MAPLE)
 
 static const u32 *g5_pmode_data;
 static int g5_pmode_max;
 
+#ifdef CONFIG_PMAC_SMU
 static struct smu_sdbp_fvt *g5_fvt_table;	/* table of op. points */
 static int g5_fvt_count;			/* number of op. points */
 static int g5_fvt_cur;				/* current op. point */
@@ -146,7 +151,7 @@ static void g5_vdnap_switch_volt(int speed_mode)
 	if (done == 0)
 		printk(KERN_WARNING "cpufreq: Timeout in clock slewing !\n");
 }
-
+#endif /* CONFIG_PMAC_SMU */
 
 /*
  * SCOM based frequency switching for 970FX rev3
@@ -216,8 +221,9 @@ static void g5_dummy_switch_volt(int speed_mode)
 {
 }
 
-#endif /* CONFIG_PMAC_SMU */
+#endif /* CONFIG_PMAC_SMU || CONFIG_PPC_MAPLE */
 
+#ifdef CONFIG_PPC_PMAC
 /*
  * Platform function based voltage switching for PowerMac7,2 & 7,3
  */
@@ -310,7 +316,7 @@ static int g5_pfunc_query_freq(void)
 	pmf_call_one(pfunc_cpu_getfreq, &args);
 	return val ? CPUFREQ_HIGH : CPUFREQ_LOW;
 }
-
+#endif
 
 /*
  * Common interface to the cpufreq core
@@ -370,7 +376,7 @@ static int g5_cpufreq_cpu_init(struct cpufreq_policy *policy)
 
 
 static struct cpufreq_driver g5_cpufreq_driver = {
-	.name		= "powermac",
+	.name		= "G5",
 	.owner		= THIS_MODULE,
 	.flags		= CPUFREQ_CONST_LOOPS,
 	.init		= g5_cpufreq_cpu_init,
@@ -381,18 +387,19 @@ static struct cpufreq_driver g5_cpufreq_driver = {
 };
 
 
-#ifdef CONFIG_PMAC_SMU
+#if defined(CONFIG_PMAC_SMU) || defined(CONFIG_PPC_MAPLE)
 
 static int __init g5_neo2_cpufreq_init(struct device_node *cpus)
 {
 	struct device_node *cpunode;
-	unsigned int psize, ssize;
+	unsigned int psize;
 	unsigned long max_freq;
 	char *freq_method, *volt_method;
 	const u32 *valp;
 	u32 pvr_hi;
 	int use_volts_vdnap = 0;
 	int use_volts_smu = 0;
+	int use_volts_dummy = 0;
 	int rc = -ENODEV;
 
 	/* Check supported platforms */
@@ -402,6 +409,9 @@ static int __init g5_neo2_cpufreq_init(struct device_node *cpus)
 		use_volts_smu = 1;
 	else if (of_machine_is_compatible("PowerMac11,2"))
 		use_volts_vdnap = 1;
+	else if (of_machine_is_compatible("Momentum,Maple") ||
+		of_machine_is_compatible("Momentum,Apache"))
+		use_volts_dummy = 1;
 	else
 		return -ENODEV;
 
@@ -420,18 +430,19 @@ static int __init g5_neo2_cpufreq_init(struct device_node *cpus)
 	}
 
 	/* Check 970FX for now */
-	valp = of_get_property(cpunode, "cpu-version", NULL);
-	if (!valp) {
-		DBG("No cpu-version property !\n");
-		goto bail_noprops;
-	}
-	pvr_hi = (*valp) >> 16;
+	pvr_hi = PVR_VER(mfspr(SPRN_PVR));
 	if (pvr_hi != 0x3c && pvr_hi != 0x44) {
-		printk(KERN_ERR "cpufreq: Unsupported CPU version\n");
+		printk(KERN_ERR "cpufreq: Unsupported CPU version (%x)\n",
+				pvr_hi);
 		goto bail_noprops;
 	}
 
 	/* Look for the powertune data in the device-tree */
+	/*
+	 * On Maple this property is provided by PIBS in dual-processor config,
+	 * not provided by PIBS in CPU0 config and also not provided by SLOF,
+	 * so YMMV
+	 */
 	g5_pmode_data = of_get_property(cpunode, "power-mode-data",&psize);
 	if (!g5_pmode_data) {
 		DBG("No power-mode-data !\n");
@@ -439,7 +450,9 @@ static int __init g5_neo2_cpufreq_init(struct device_node *cpus)
 	}
 	g5_pmode_max = psize / sizeof(u32) - 1;
 
+#ifdef CONFIG_PMAC_SMU
 	if (use_volts_smu) {
+		unsigned int ssize;
 		const struct smu_sdbp_header *shdr;
 
 		/* Look for the FVT table */
@@ -479,7 +492,9 @@ static int __init g5_neo2_cpufreq_init(struct device_node *cpus)
 
 		g5_switch_volt = g5_vdnap_switch_volt;
 		volt_method = "GPIO";
-	} else {
+	} else
+#endif /* CONFIG_PPC_PMAC */
+	{
 		g5_switch_volt = g5_dummy_switch_volt;
 		volt_method = "none";
 	}
@@ -534,9 +549,9 @@ static int __init g5_neo2_cpufreq_init(struct device_node *cpus)
 	return rc;
 }
 
-#endif /* CONFIG_PMAC_SMU */
-
+#endif /* CONFIG_PMAC_SMU || CONFIG_PPC_MAPLE */
 
+#ifdef CONFIG_PPC_PMAC
 static int __init g5_pm72_cpufreq_init(struct device_node *cpus)
 {
 	struct device_node *cpuid = NULL, *hwclock = NULL, *cpunode = NULL;
@@ -715,6 +730,7 @@ static int __init g5_pm72_cpufreq_init(struct device_node *cpus)
 
 	return rc;
 }
+#endif
 
 static int __init g5_cpufreq_init(void)
 {
@@ -727,14 +743,18 @@ static int __init g5_cpufreq_init(void)
 		return -ENODEV;
 	}
 
+#ifdef CONFIG_PPC_PMAC
 	if (of_machine_is_compatible("PowerMac7,2") ||
 	    of_machine_is_compatible("PowerMac7,3") ||
 	    of_machine_is_compatible("RackMac3,1"))
 		rc = g5_pm72_cpufreq_init(cpus);
-#ifdef CONFIG_PMAC_SMU
 	else
+#endif
+#if defined(CONFIG_PMAC_SMU) || defined(CONFIG_PPC_MAPLE)
 		rc = g5_neo2_cpufreq_init(cpus);
-#endif /* CONFIG_PMAC_SMU */
+#else
+	rc = -ENODEV;
+#endif /* CONFIG_PMAC_SMU || CONFIG_PPC_MAPLE */
 
 	of_node_put(cpus);
 	return rc;
-- 
1.8.4.rc3

