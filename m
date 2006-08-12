From: david singleton <dsingleton@mvista.com>
Subject: Re: Dynanic On-The-Fly Operating points for PowerOP
Date: Sat, 12 Aug 2006 14:41:33 -0700
Message-ID: <064e1613db40023e58967726efc3ea13@mvista.com>
References: <44D8D40F.50005@mvista.com>
	<bb52214749a48f317fba09eb522537bb@nomadgs.com>
	<5da81756733c335565f969bab0c9b934@mvista.com>
	<26d93dc005e384544d9ea702baa4a4af@nomadgs.com>
	<acd2a5930608120107k36653863vdfc8bd3875d395a9@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: multipart/mixed; boundary=Apple-Mail-5-1018034042
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <acd2a5930608120107k36653863vdfc8bd3875d395a9@mail.gmail.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Vitaly Wool <vitalywool@gmail.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org


--Apple-Mail-5-1018034042
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed

Here's the powerop-x86-centrino.patch.   It's only change from the 
2.6.18-rc1 version
is to change names  of operating points from med to medium, etc.

David


--Apple-Mail-5-1018034042
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream; x-unix-mode=0644;
	name="powerop-x86-centrino.patch"
Content-Disposition: attachment;
	filename=powerop-x86-centrino.patch


Signed-Off-by: David Singleton <dsingleton@mvista.com>

 arch/i386/kernel/cpu/Makefile                           |    1 
 arch/i386/kernel/cpu/powerop/Makefile                   |    2 
 arch/i386/kernel/cpu/powerop/centrino-dynamic-powerop.c |   71 ++
 arch/i386/kernel/cpu/powerop/centrino-powerop.c         |  465 ++++++++++++++++
 arch/i386/kernel/i386_ksyms.c                           |    4 
 5 files changed, 543 insertions(+)

Index: linux-2.6.17/arch/i386/kernel/cpu/Makefile
===================================================================
--- linux-2.6.17.orig/arch/i386/kernel/cpu/Makefile
+++ linux-2.6.17/arch/i386/kernel/cpu/Makefile
@@ -17,3 +17,4 @@ obj-$(CONFIG_X86_MCE)	+=	mcheck/
 
 obj-$(CONFIG_MTRR)	+= 	mtrr/
 obj-$(CONFIG_CPU_FREQ)	+=	cpufreq/
+obj-$(CONFIG_PM)	+=	powerop/
Index: linux-2.6.17/arch/i386/kernel/cpu/powerop/Makefile
===================================================================
--- /dev/null
+++ linux-2.6.17/arch/i386/kernel/cpu/powerop/Makefile
@@ -0,0 +1,2 @@
+obj-$(CONFIG_X86_SPEEDSTEP_CENTRINO)	+= centrino-powerop.o
+obj-m					+= centrino-dynamic-powerop.o
Index: linux-2.6.17/arch/i386/kernel/cpu/powerop/centrino-dynamic-powerop.c
===================================================================
--- /dev/null
+++ linux-2.6.17/arch/i386/kernel/cpu/powerop/centrino-dynamic-powerop.c
@@ -0,0 +1,71 @@
+/*
+ * powerop/centrino-dynamic-powerop.c
+ *
+ * This is the template to create dynamic operating points for power management.
+ *
+ * Author: David Singleton dsingleton@mvista.com MontaVista Software, Inc.
+ *
+ * 2006 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/list.h>
+#include <linux/pm.h>
+#include <linux/cpufreq.h>
+#include <linux/moduleparam.h>
+#include <linux/moduleloader.h>
+
+int centrino_transition(struct powerop *cur, struct powerop *new);
+
+static char powerop_name[PM_NAME_SIZE] = "dynamic";
+static unsigned int voltage = 1308;
+static unsigned int latency = 100;
+module_param_named(name, powerop_name, char *, 0);
+module_param_named(frequency, frequency, uint, 0);
+module_param_named(voltage, voltage, uint, 0);
+module_param_named(latency, latency, uint, 0);
+MODULE_PARM_DESC(frequency, "cpu frequency in kHz");
+MODULE_PARM_DESC(voltage, "cpu voltage in mV");
+MODULE_PARM_DESC(latency, "transition latency in us");
+
+/* Register both the driver and the device */
+
+static struct powerop dynamic_op = {
+	.type = PM_FREQ_CHANGE,
+	.name = "Dynamic",
+	.description = "Dynamic PowerOp point for Speedstep Centrino",
+	.prepare_transition = cpufreq_prepare_transition,
+	.transition = centrino_transition,
+	.finish_transition = cpufreq_finish_transition,
+};
+
+extern void centrino_set_frequency(struct powerop *op, uint freq, uint volt);
+
+int __init dynamic_powerop_init(void)
+{
+
+	printk("Dynamic PowerOp operating point for speedstep centrino\n");
+	dynamic_op.frequency = frequency;
+	dynamic_op.voltage = voltage;
+	dynamic_op.latency = latency;
+	centrino_set_frequency(&dynamic_op, frequency / 1000, voltage);
+	printk("freq %d volt %d msr 0x%x\n", dynamic_op.frequency,
+	   dynamic_op.voltage, (unsigned int)dynamic_op.md_data);
+	list_add_tail(&dynamic_op.list, &pm_states.list);
+	return 0;
+}
+
+void __exit dynamic_powerop_cleanup(void)
+{
+	list_del_init(&dynamic_op.list);
+}
+
+module_init(dynamic_powerop_init);
+module_exit(dynamic_powerop_cleanup);
+
+MODULE_DESCRIPTION("Dynamic Powerop module");
+MODULE_LICENSE("GPL");
Index: linux-2.6.17/arch/i386/kernel/cpu/powerop/centrino-powerop.c
===================================================================
--- /dev/null
+++ linux-2.6.17/arch/i386/kernel/cpu/powerop/centrino-powerop.c
@@ -0,0 +1,465 @@
+/*
+ * PowerOp support for Enhanced SpeedStep, as found in Intel's Pentium
+ * M (part of the Centrino chipset).
+ *
+ * Modelled on speedstep-centrino.c
+ *
+ * Copyright (C) 2006 David Singleton <dsingleton@mvista.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/cpufreq.h>
+#include <linux/delay.h>
+#include <linux/compiler.h>
+
+#include <asm/msr.h>
+#include <asm/processor.h>
+#include <asm/cpufeature.h>
+
+struct cpu_id
+{
+	__u8	x86;            /* CPU family */
+	__u8	x86_model;	/* model */
+	__u8	x86_mask;	/* stepping */
+};
+
+enum {
+	CPU_BANIAS,
+	CPU_DOTHAN_A1,
+	CPU_DOTHAN_A2,
+	CPU_DOTHAN_B0,
+	CPU_MP4HT_D0,
+	CPU_MP4HT_E0,
+};
+
+static const struct cpu_id cpu_ids[] = {
+	[CPU_BANIAS]	= { 6,  9, 5 },
+	[CPU_DOTHAN_A1]	= { 6, 13, 1 },
+	[CPU_DOTHAN_A2]	= { 6, 13, 2 },
+	[CPU_DOTHAN_B0]	= { 6, 13, 6 },
+	[CPU_MP4HT_D0]	= {15,  3, 4 },
+	[CPU_MP4HT_E0]	= {15,  4, 1 },
+};
+#define N_IDS	ARRAY_SIZE(cpu_ids)
+
+struct cpu_model
+{
+	const struct cpu_id *cpu_id;
+	const char	*model_name;
+	unsigned	max_freq; /* max clock in kHz */
+
+	struct cpufreq_frequency_table *op_points; /* clock/voltage pairs */
+};
+static int centrino_verify_cpu_id(const struct cpuinfo_x86 *c, const struct cpu_id *x);
+
+void centrino_set_frequency(struct powerop *op, uint freq, uint volt)
+{
+	op->frequency = freq * 1000;
+	op->voltage = volt;
+	op->md_data = (void *)(((freq / 100) << 8) | (volt - 700) / 16);
+	printk("freq %d volt %d msr 0x%x\n", op->frequency, op->voltage,
+	    (unsigned int)op->md_data);
+}
+EXPORT_SYMBOL(centrino_set_frequency);
+
+int centrino_transition(struct powerop *cur, struct powerop *new)
+{
+	unsigned int msr, oldmsr = 0, h = 0;
+
+	if (cur == new)
+		return 0;
+
+	msr = (unsigned int)new->md_data;
+	rdmsr(MSR_IA32_PERF_CTL, oldmsr, h);
+
+	/* all but 16 LSB are reserved, treat them with care */
+	oldmsr &= ~0xffff;
+	msr &= 0xffff;
+	oldmsr |= msr;
+
+	wrmsr(MSR_IA32_PERF_CTL, oldmsr, h);
+
+	return 0;
+}
+EXPORT_SYMBOL(centrino_transition);
+
+#define OP(mhz, mv)                                                     \
+        {                                                               \
+                .frequency = (mhz) * 1000,                              \
+                .index = (((mhz)/100) << 8) | ((mv - 700) / 16)         \
+        }
+
+/*
+ * These voltage tables were derived from the Intel Pentium M
+ * datasheet, document 25261202.pdf, Table 5.  I have verified they
+ * are consistent with my IBM ThinkPad X31, which has a 1.3GHz Pentium
+ * M.
+ */
+
+/* Ultra Low Voltage Intel Pentium M processor 900MHz (Banias) */
+static struct cpufreq_frequency_table banias_900[] =
+{
+        OP(600,  844),
+        OP(800,  988),
+        OP(900, 1004),
+        { .frequency = CPUFREQ_TABLE_END }
+};
+/* Ultra Low Voltage Intel Pentium M processor 1000MHz (Banias) */
+static struct cpufreq_frequency_table banias_1000[] =
+{
+        OP(600,   844),
+        OP(800,   972),
+        OP(900,   988),
+        OP(1000, 1004),
+        { .frequency = CPUFREQ_TABLE_END }
+};
+
+/* Low Voltage Intel Pentium M processor 1.10GHz (Banias) */
+static struct cpufreq_frequency_table banias_1100[] =
+{
+        OP( 600,  956),
+        OP( 800, 1020),
+        OP( 900, 1100),
+        OP(1000, 1164),
+        OP(1100, 1180),
+        { .frequency = CPUFREQ_TABLE_END }
+};
+
+
+/* Low Voltage Intel Pentium M processor 1.20GHz (Banias) */
+static struct cpufreq_frequency_table banias_1200[] =
+{
+        OP( 600,  956),
+        OP( 800, 1004),
+        OP( 900, 1020),
+        OP(1000, 1100),
+        OP(1100, 1164),
+        OP(1200, 1180),
+        { .frequency = CPUFREQ_TABLE_END }
+};
+
+/* Intel Pentium M processor 1.30GHz (Banias) */
+static struct cpufreq_frequency_table banias_1300[] =
+{
+        OP( 600,  956),
+        OP( 800, 1260),
+        OP(1000, 1292),
+        OP(1200, 1356),
+        OP(1300, 1388),
+        { .frequency = CPUFREQ_TABLE_END }
+};
+
+/* Intel Pentium M processor 1.40GHz (Banias) */
+static struct cpufreq_frequency_table banias_1400[] =
+{
+        OP( 600,  956),
+        OP( 800, 1180),
+        OP(1000, 1308),
+        OP(1200, 1436),
+        OP(1400, 1484),
+        { .frequency = CPUFREQ_TABLE_END }
+};
+
+/* Intel Pentium M processor 1.50GHz (Banias) */
+static struct cpufreq_frequency_table banias_1500[] =
+{
+        OP( 600,  956),
+        OP( 800, 1116),
+        OP(1000, 1228),
+        OP(1200, 1356),
+        OP(1400, 1452),
+        OP(1500, 1484),
+        { .frequency = CPUFREQ_TABLE_END }
+};
+
+/* Intel Pentium M processor 1.60GHz (Banias) */
+static struct cpufreq_frequency_table banias_1600[] =
+{
+        OP( 600,  956),
+        OP( 800, 1036),
+        OP(1000, 1164),
+        OP(1200, 1276),
+        OP(1400, 1420),
+        OP(1600, 1484),
+        { .frequency = CPUFREQ_TABLE_END }
+};
+
+/* Intel Pentium M processor 1.70GHz (Banias) */
+static struct cpufreq_frequency_table banias_1700[] =
+{
+        OP( 600,  956),
+        OP( 800, 1004),
+        OP(1000, 1116),
+        OP(1200, 1228),
+        OP(1400, 1308),
+        OP(1700, 1484),
+        { .frequency = CPUFREQ_TABLE_END }
+};
+
+#define _BANIAS(cpuid, max, name)	\
+{	.cpu_id		= cpuid,	\
+	.model_name	= "Intel(R) Pentium(R) M processor " name "MHz", \
+	.max_freq	= (max)*1000,	\
+	.op_points	= banias_##max,	\
+}
+#define BANIAS(max)	_BANIAS(&cpu_ids[CPU_BANIAS], max, #max)
+
+static struct powerop lowest = {
+	.name = "lowest",
+	.description = "Lowest Frequency state",
+	.type = PM_FREQ_CHANGE,
+	.frequency = 0,
+	.voltage = 0,
+	.latency = 100,
+	.prepare_transition  = cpufreq_prepare_transition,
+	.transition = centrino_transition,
+	.finish_transition = cpufreq_finish_transition,
+};
+
+static struct powerop low = {
+	.name = "low",
+	.description = "Low Frequency state",
+	.type = PM_FREQ_CHANGE,
+	.latency = 100,
+	.prepare_transition  = cpufreq_prepare_transition,
+	.transition = centrino_transition,
+	.finish_transition = cpufreq_finish_transition,
+};
+
+static struct powerop mediumlow = {
+	.name = "mediumlow",
+	.description = "Medium Low Frequency state",
+	.type = PM_FREQ_CHANGE,
+	.latency = 100,
+	.prepare_transition  = cpufreq_prepare_transition,
+	.transition = centrino_transition,
+	.finish_transition = cpufreq_finish_transition,
+};
+
+static struct powerop medium = {
+	.name = "medium",
+	.description = "Medium Frequency state",
+	.type = PM_FREQ_CHANGE,
+	.latency = 100,
+	.prepare_transition  = cpufreq_prepare_transition,
+	.transition = centrino_transition,
+	.finish_transition = cpufreq_finish_transition,
+};
+
+static struct powerop mediumhigh = {
+	.name = "mediumhigh",
+	.description = "Medium High Frequency state",
+	.type = PM_FREQ_CHANGE,
+	.latency = 100,
+	.prepare_transition  = cpufreq_prepare_transition,
+	.transition = centrino_transition,
+	.finish_transition = cpufreq_finish_transition,
+};
+
+static struct powerop high = {
+	.name = "high",
+	.description = "High Frequency state",
+	.type = PM_FREQ_CHANGE,
+	.latency = 100,
+	.prepare_transition  = cpufreq_prepare_transition,
+	.transition = centrino_transition,
+	.finish_transition = cpufreq_finish_transition,
+};
+
+static struct powerop highest = {
+	.name = "highest",
+	.description = "Highest Frequency state",
+	.type = PM_FREQ_CHANGE,
+	.latency = 100,
+	.prepare_transition  = cpufreq_prepare_transition,
+	.transition = centrino_transition,
+	.finish_transition = cpufreq_finish_transition,
+};
+
+/* CPU models, their operating frequency range, and freq/voltage
+   operating points */
+static struct cpu_model models[] =
+{
+	_BANIAS(&cpu_ids[CPU_BANIAS], 900, " 900"),
+	BANIAS(1000),
+	BANIAS(1100),
+	BANIAS(1200),
+	BANIAS(1300),
+	BANIAS(1400),
+	BANIAS(1500),
+	BANIAS(1600),
+	BANIAS(1700),
+
+	/* NULL model_name is a wildcard */
+	{ &cpu_ids[CPU_DOTHAN_A1], NULL, 0, NULL },
+	{ &cpu_ids[CPU_DOTHAN_A2], NULL, 0, NULL },
+	{ &cpu_ids[CPU_DOTHAN_B0], NULL, 0, NULL },
+	{ &cpu_ids[CPU_MP4HT_D0], NULL, 0, NULL },
+	{ &cpu_ids[CPU_MP4HT_E0], NULL, 0, NULL },
+
+	{ NULL, }
+};
+#undef _BANIAS
+#undef BANIAS
+
+static int __init centrino_init_powerop(void)
+{
+	struct cpuinfo_x86 *cpu = &cpu_data[0];
+	struct cpu_model *model;
+
+	for(model = models; model->cpu_id != NULL; model++) {
+		if (centrino_verify_cpu_id(cpu, model->cpu_id) &&
+		    (model->model_name == NULL ||
+		     strcmp(cpu->x86_model_id, model->model_name) == 0))
+			break;
+	}
+
+	if (model->cpu_id == NULL) {
+		/* No match at all */
+		printk("no support for CPU model %s\n", cpu->x86_model_id);
+		return -ENOENT;
+	}
+
+	printk("found \"%s\": max frequency: %dkHz\n",
+	       model->model_name, model->max_freq);
+	switch (model->max_freq) {
+	    case (900000) :
+	    {
+		centrino_set_frequency(&low, 600, 844);
+		centrino_set_frequency(&medium, 800, 988);
+		centrino_set_frequency(&high, 900, 1004);
+		break;
+	    }
+	    case (1000000) :
+	    {
+		centrino_set_frequency(&low, 600, 844);
+		centrino_set_frequency(&medium, 800, 972);
+		centrino_set_frequency(&high, 900, 988);
+		centrino_set_frequency(&highest, 1000, 1004);
+		break;
+	    }
+	    case (1100000) :
+	    {
+		centrino_set_frequency(&lowest, 600, 956);
+		centrino_set_frequency(&low, 800, 1020);
+		centrino_set_frequency(&medium, 900, 1100);
+		centrino_set_frequency(&high, 1000, 1164);
+		centrino_set_frequency(&highest, 1100, 1180);
+		break;
+	    }
+	    case (1200000) :
+	    {
+		centrino_set_frequency(&lowest, 600, 956);
+		centrino_set_frequency(&low, 800, 1004);
+		centrino_set_frequency(&medium, 900, 1020);
+		centrino_set_frequency(&mediumhigh, 1000, 1100);
+		centrino_set_frequency(&high, 1100, 1164);
+		centrino_set_frequency(&highest, 1200, 1180);
+		break;
+	    }
+	    case (1300000) :
+	    {
+		centrino_set_frequency(&lowest, 600, 956);
+		centrino_set_frequency(&low, 800, 1260);
+		centrino_set_frequency(&medium, 1000, 1292);
+		centrino_set_frequency(&high, 1200, 1356);
+		centrino_set_frequency(&highest, 1300, 1388);
+		break;
+	    }
+	    case (1400000) :
+	    {
+		centrino_set_frequency(&lowest, 600, 956);
+		centrino_set_frequency(&low, 800, 1180);
+		centrino_set_frequency(&medium, 1000, 1308);
+		centrino_set_frequency(&high, 1200, 1436);
+		centrino_set_frequency(&highest, 1400, 1484);
+		break;
+	    }
+	    case (1500000) :
+	    {
+		centrino_set_frequency(&lowest, 600, 956);
+		centrino_set_frequency(&low, 800, 1116);
+		centrino_set_frequency(&medium, 1000, 1228);
+		centrino_set_frequency(&mediumhigh, 1200, 1356);
+		centrino_set_frequency(&high, 1400, 1452);
+		centrino_set_frequency(&highest, 1500, 1484);
+		break;
+	    }
+	    case (1600000) :
+	    {
+		centrino_set_frequency(&lowest, 600, 956);
+		centrino_set_frequency(&low, 800, 1036);
+		centrino_set_frequency(&medium, 1000, 1164);
+		centrino_set_frequency(&mediumhigh, 1200, 1276);
+		centrino_set_frequency(&high, 1400, 1420);
+		centrino_set_frequency(&highest, 1600, 1484);
+		break;
+	    }
+	    case (1700000) :
+	    {
+		centrino_set_frequency(&lowest, 600, 956);
+		centrino_set_frequency(&low, 800, 1004);
+		centrino_set_frequency(&medium, 1000, 1116);
+		centrino_set_frequency(&mediumhigh, 1200, 1228);
+		centrino_set_frequency(&high, 1400, 1308);
+		centrino_set_frequency(&highest, 1700, 1484);
+		break;
+	    }
+	}
+	if (lowest.frequency)
+		list_add_tail(&lowest.list, &pm_states.list);
+	if (low.frequency)
+		list_add_tail(&low.list, &pm_states.list);
+	if (mediumlow.frequency)
+		list_add_tail(&mediumlow.list, &pm_states.list);
+	if (medium.frequency)
+		list_add_tail(&medium.list, &pm_states.list);
+	if (mediumhigh.frequency)
+		list_add_tail(&mediumhigh.list, &pm_states.list);
+	if (high.frequency) {
+		list_add_tail(&high.list, &pm_states.list);
+		current_state = &high;
+	}
+	if (highest.frequency) {
+		list_add_tail(&highest.list, &pm_states.list);
+		current_state = &highest;
+	}
+	return 0;
+}
+
+static void centrino_exit_powerop(void)
+{
+	if (lowest.frequency)
+		list_del_init(&lowest.list);
+	if (low.frequency)
+		list_del_init(&low.list);
+	if (mediumlow.frequency)
+		list_del_init(&mediumlow.list);
+	if (medium.frequency)
+		list_del_init(&medium.list);
+	if (mediumhigh.frequency)
+		list_del_init(&mediumhigh.list);
+	if (high.frequency)
+		list_del_init(&high.list);
+	if (highest.frequency)
+		list_del_init(&highest.list);
+	return;
+}
+
+static int centrino_verify_cpu_id(const struct cpuinfo_x86 *c, const struct cpu_id *x)
+{
+	if ((c->x86 == x->x86) &&
+	    (c->x86_model == x->x86_model) &&
+	    (c->x86_mask == x->x86_mask))
+		return 1;
+	return 0;
+}
+
+MODULE_AUTHOR ("David Singleton <dsingleton@mvista.com>");
+MODULE_DESCRIPTION ("PowerOp operting points for Intel Pentium M processors.");
+MODULE_LICENSE ("GPL");
+
+late_initcall(centrino_init_powerop);
+module_exit(centrino_exit_powerop);
Index: linux-2.6.17/arch/i386/kernel/i386_ksyms.c
===================================================================
--- linux-2.6.17.orig/arch/i386/kernel/i386_ksyms.c
+++ linux-2.6.17/arch/i386/kernel/i386_ksyms.c
@@ -28,3 +28,7 @@ EXPORT_SYMBOL(__read_lock_failed);
 #endif
 
 EXPORT_SYMBOL(csum_partial);
+#ifdef CONFIG_PM
+#include <linux/pm.h>
+EXPORT_SYMBOL(pm_states);
+#endif

--Apple-Mail-5-1018034042
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--Apple-Mail-5-1018034042--
