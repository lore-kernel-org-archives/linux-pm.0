From: David Singleton <dsingleton@mvista.com>
Subject: PowerOp for x86 centrino patch
Date: Tue, 08 Aug 2006 11:15:44 -0700
Message-ID: <44D8D4D0.8050908@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

This patch adds PowerOp support to the x86 centrino line of processors. =

 The code
has been moved out of the cpufreq directory into its own =

arch/i386/kernel/cpu/powerop
directory.

The patch is different from the first powerop-x86-centrino.patch in that it
now supports all the speedstep-centrino processors at boot time, instead
of just the 1.4GHz my laptop was using.

It also uses the new unified naming scheme of operating points.  This =

feature
lets any set of operating points to be supported and lets the PowerOp
daemon be able to make some simple rules based decisions on which
operating points to transition to without having to know too much about
the underlying frequencies or voltages.

The patch also adds a new module to create dynamic, on-the-fly
operating point with the frequency, voltage and transition latency
passed in at insmod time.

Signed-Off-by: David Singleton <dsingleton@mvista.com>

 arch/i386/kernel/cpu/Makefile                           |    1
 arch/i386/kernel/cpu/powerop/Makefile                   |    2
 arch/i386/kernel/cpu/powerop/centrino-dynamic-powerop.c |   70 ++
 arch/i386/kernel/cpu/powerop/centrino-powerop.c         |  465 =

++++++++++++++++
 arch/i386/kernel/i386_ksyms.c                           |    4
 5 files changed, 542 insertions(+)

Index: linux-2.6.17/arch/i386/kernel/cpu/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.17.orig/arch/i386/kernel/cpu/Makefile
+++ linux-2.6.17/arch/i386/kernel/cpu/Makefile
@@ -17,3 +17,4 @@ obj-$(CONFIG_X86_MCE) +=3D      mcheck/

 obj-$(CONFIG_MTRR)     +=3D      mtrr/
 obj-$(CONFIG_CPU_FREQ) +=3D      cpufreq/
+obj-$(CONFIG_PM)       +=3D      powerop/
Index: linux-2.6.17/arch/i386/kernel/cpu/powerop/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ linux-2.6.17/arch/i386/kernel/cpu/powerop/Makefile
@@ -0,0 +1,2 @@
[david-singletons-Computer:~] dsinglet% cat powerop-x86-centrino.patch
Signed-Off-by: David Singleton <dsingleton@mvista.com>

 arch/i386/kernel/cpu/Makefile                           |    1
 arch/i386/kernel/cpu/powerop/Makefile                   |    2
 arch/i386/kernel/cpu/powerop/centrino-dynamic-powerop.c |   70 ++
 arch/i386/kernel/cpu/powerop/centrino-powerop.c         |  465 =

++++++++++++++++
 arch/i386/kernel/i386_ksyms.c                           |    4
 5 files changed, 542 insertions(+)

Index: linux-2.6.17/arch/i386/kernel/cpu/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.17.orig/arch/i386/kernel/cpu/Makefile
+++ linux-2.6.17/arch/i386/kernel/cpu/Makefile
@@ -17,3 +17,4 @@ obj-$(CONFIG_X86_MCE) +=3D      mcheck/

 obj-$(CONFIG_MTRR)     +=3D      mtrr/
 obj-$(CONFIG_CPU_FREQ) +=3D      cpufreq/
+obj-$(CONFIG_PM)       +=3D      powerop/
Index: linux-2.6.17/arch/i386/kernel/cpu/powerop/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ linux-2.6.17/arch/i386/kernel/cpu/powerop/Makefile
@@ -0,0 +1,2 @@
+obj-$(CONFIG_X86_SPEEDSTEP_CENTRINO)   +=3D centrino-powerop.o
+obj-m                                  +=3D centrino-dynamic-powerop.o
Index: linux-2.6.17/arch/i386/kernel/cpu/powerop/centrino-dynamic-powerop.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ linux-2.6.17/arch/i386/kernel/cpu/powerop/centrino-dynamic-powerop.c
@@ -0,0 +1,70 @@
+/*
+ * powerop/centrino-dynamic-powerop.c
+ *
+ * This is the template to create dynamic operating points for power =

management.
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
+static unsigned int frequency =3D 1000000;
+static unsigned int voltage =3D 1308;
+static unsigned int latency =3D 100;
+module_param_named(frequency, frequency, uint, 0);
+module_param_named(voltage, voltage, uint, 0);
+module_param_named(latency, latency, uint, 0);
+MODULE_PARM_DESC(frequency, "cpu frequency in kHz");
+MODULE_PARM_DESC(voltage, "cpu voltage in mV");
+MODULE_PARM_DESC(latency, "transition latency in us");
+
+/* Register both the driver and the device */
+
+static struct powerop dynamic_op =3D {
+       .type =3D PM_FREQ_CHANGE,
+       .name =3D "Dynamic",
+       .description =3D "Dynamic PowerOp point for Speedstep Centrino",
+       .prepare_transition =3D cpufreq_prepare_transition,
+       .transition =3D centrino_transition,
+       .finish_transition =3D cpufreq_finish_transition,
+};
+
+extern void centrino_set_frequency(struct powerop *op, uint freq, uint =

volt);
+
+int __init dynamic_powerop_init(void)
+{
+
+       printk("Dynamic PowerOp operating point for speedstep centrino\n");
+       dynamic_op.frequency =3D frequency;
+       dynamic_op.voltage =3D voltage;
+       dynamic_op.latency =3D latency;
+       centrino_set_frequency(&dynamic_op, frequency / 1000, voltage);
+       printk("freq %d volt %d msr 0x%x\n", dynamic_op.frequency,
+          dynamic_op.voltage, (unsigned int)dynamic_op.md_data);
+       list_add_tail(&dynamic_op.list, &pm_states.list);
+       return 0;
+}
+
+void __exit dynamic_powerop_cleanup(void)
+{
+       list_del_init(&dynamic_op.list);
+}
+
+module_init(dynamic_powerop_init);
+module_exit(dynamic_powerop_cleanup);
+
+MODULE_DESCRIPTION("Dynamic Powerop module");
+MODULE_LICENSE("GPL");
Index: linux-2.6.17/arch/i386/kernel/cpu/powerop/centrino-powerop.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
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
+       __u8    x86;            /* CPU family */
+       __u8    x86_model;      /* model */
+       __u8    x86_mask;       /* stepping */
+};
+
+enum {
+       CPU_BANIAS,
+       CPU_DOTHAN_A1,
+       CPU_DOTHAN_A2,
+       CPU_DOTHAN_B0,
+       CPU_MP4HT_D0,
+       CPU_MP4HT_E0,
+};
+
+static const struct cpu_id cpu_ids[] =3D {
+       [CPU_BANIAS]    =3D { 6,  9, 5 },
+       [CPU_DOTHAN_A1] =3D { 6, 13, 1 },
+       [CPU_DOTHAN_A2] =3D { 6, 13, 2 },
+       [CPU_DOTHAN_B0] =3D { 6, 13, 6 },
+       [CPU_MP4HT_D0]  =3D {15,  3, 4 },
+       [CPU_MP4HT_E0]  =3D {15,  4, 1 },
+};
+#define N_IDS  ARRAY_SIZE(cpu_ids)
+
+struct cpu_model
+{
+       const struct cpu_id *cpu_id;
+       const char      *model_name;
+       unsigned        max_freq; /* max clock in kHz */
+
+       struct cpufreq_frequency_table *op_points; /* clock/voltage =

pairs */
+};
+static int centrino_verify_cpu_id(const struct cpuinfo_x86 *c, const =

struct cpu_id *x);
+
+void centrino_set_frequency(struct powerop *op, uint freq, uint volt)
+{
+       op->frequency =3D freq * 1000;
+       op->voltage =3D volt;
+       op->md_data =3D (void *)(((freq / 100) << 8) | (volt - 700) / 16);
+       printk("freq %d volt %d msr 0x%x\n", op->frequency, op->voltage,
+           (unsigned int)op->md_data);
+}
+EXPORT_SYMBOL(centrino_set_frequency);
+
+int centrino_transition(struct powerop *cur, struct powerop *new)
+{
+       unsigned int msr, oldmsr =3D 0, h =3D 0;
+
+       if (cur =3D=3D new)
+               return 0;
+
+       msr =3D (unsigned int)new->md_data;
+       rdmsr(MSR_IA32_PERF_CTL, oldmsr, h);
+
+       /* all but 16 LSB are reserved, treat them with care */
+       oldmsr &=3D ~0xffff;
+       msr &=3D 0xffff;
+       oldmsr |=3D msr;
+
+       wrmsr(MSR_IA32_PERF_CTL, oldmsr, h);
+
+       return 0;
+}
+EXPORT_SYMBOL(centrino_transition);
+
+#define OP(mhz, mv)                                                     \
+        {                                                               \
+                .frequency =3D (mhz) * 1000,                              \
+                .index =3D (((mhz)/100) << 8) | ((mv - 700) / 16)         \
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
+static struct cpufreq_frequency_table banias_900[] =3D
+{
+        OP(600,  844),
+        OP(800,  988),
+        OP(900, 1004),
+        { .frequency =3D CPUFREQ_TABLE_END }
+};
+/* Ultra Low Voltage Intel Pentium M processor 1000MHz (Banias) */
+static struct cpufreq_frequency_table banias_1000[] =3D
+{
+        OP(600,   844),
+        OP(800,   972),
+        OP(900,   988),
+        OP(1000, 1004),
+        { .frequency =3D CPUFREQ_TABLE_END }
+};
+
+/* Low Voltage Intel Pentium M processor 1.10GHz (Banias) */
+static struct cpufreq_frequency_table banias_1100[] =3D
+{
+        OP( 600,  956),
+        OP( 800, 1020),
+        OP( 900, 1100),
+        OP(1000, 1164),
+        OP(1100, 1180),
+        { .frequency =3D CPUFREQ_TABLE_END }
+};
+
+
+/* Low Voltage Intel Pentium M processor 1.20GHz (Banias) */
+static struct cpufreq_frequency_table banias_1200[] =3D
+{
+        OP( 600,  956),
+        OP( 800, 1004),
+        OP( 900, 1020),
+        OP(1000, 1100),
+        OP(1100, 1164),
+        OP(1200, 1180),
+        { .frequency =3D CPUFREQ_TABLE_END }
+};
+
+/* Intel Pentium M processor 1.30GHz (Banias) */
+static struct cpufreq_frequency_table banias_1300[] =3D
+{
+        OP( 600,  956),
+        OP( 800, 1260),
+        OP(1000, 1292),
+        OP(1200, 1356),
+        OP(1300, 1388),
+        { .frequency =3D CPUFREQ_TABLE_END }
+};
+
+/* Intel Pentium M processor 1.40GHz (Banias) */
+static struct cpufreq_frequency_table banias_1400[] =3D
+{
+        OP( 600,  956),
+        OP( 800, 1180),
+        OP(1000, 1308),
+        OP(1200, 1436),
+        OP(1400, 1484),
+        { .frequency =3D CPUFREQ_TABLE_END }
+};
+
+/* Intel Pentium M processor 1.50GHz (Banias) */
+static struct cpufreq_frequency_table banias_1500[] =3D
+{
+        OP( 600,  956),
+        OP( 800, 1116),
+        OP(1000, 1228),
+        OP(1200, 1356),
+        OP(1400, 1452),
+        OP(1500, 1484),
+        { .frequency =3D CPUFREQ_TABLE_END }
+};
+
+/* Intel Pentium M processor 1.60GHz (Banias) */
+static struct cpufreq_frequency_table banias_1600[] =3D
+{
+        OP( 600,  956),
+        OP( 800, 1036),
+        OP(1000, 1164),
+        OP(1200, 1276),
+        OP(1400, 1420),
+        OP(1600, 1484),
+        { .frequency =3D CPUFREQ_TABLE_END }
+};
+
+/* Intel Pentium M processor 1.70GHz (Banias) */
+static struct cpufreq_frequency_table banias_1700[] =3D
+{
+        OP( 600,  956),
+        OP( 800, 1004),
+        OP(1000, 1116),
+        OP(1200, 1228),
+        OP(1400, 1308),
+        OP(1700, 1484),
+        { .frequency =3D CPUFREQ_TABLE_END }
+};
+
+#define _BANIAS(cpuid, max, name)      \
+{      .cpu_id         =3D cpuid,        \
+       .model_name     =3D "Intel(R) Pentium(R) M processor " name "MHz", \
+       .max_freq       =3D (max)*1000,   \
+       .op_points      =3D banias_##max, \
+}
+#define BANIAS(max)    _BANIAS(&cpu_ids[CPU_BANIAS], max, #max)
+
+static struct powerop lowest =3D {
+       .name =3D "lowest",
+       .description =3D "Lowest Frequency state",
+       .type =3D PM_FREQ_CHANGE,
+       .frequency =3D 0,
+       .voltage =3D 0,
+       .latency =3D 100,
+       .prepare_transition  =3D cpufreq_prepare_transition,
+       .transition =3D centrino_transition,
+       .finish_transition =3D cpufreq_finish_transition,
+};
+
+static struct powerop low =3D {
+       .name =3D "low",
+       .description =3D "Low Frequency state",
+       .type =3D PM_FREQ_CHANGE,
+       .latency =3D 100,
+       .prepare_transition  =3D cpufreq_prepare_transition,
+       .transition =3D centrino_transition,
+       .finish_transition =3D cpufreq_finish_transition,
+};
+
+static struct powerop medlow =3D {
+       .name =3D "medlow",
+       .description =3D "Medium Low Frequency state",
+       .type =3D PM_FREQ_CHANGE,
+       .latency =3D 100,
+       .prepare_transition  =3D cpufreq_prepare_transition,
+       .transition =3D centrino_transition,
+       .finish_transition =3D cpufreq_finish_transition,
+};
+
+static struct powerop med =3D {
+       .name =3D "med",
+       .description =3D "Medium Frequency state",
+       .type =3D PM_FREQ_CHANGE,
+       .latency =3D 100,
+       .prepare_transition  =3D cpufreq_prepare_transition,
+       .transition =3D centrino_transition,
+       .finish_transition =3D cpufreq_finish_transition,
+};
+
+static struct powerop medhigh =3D {
+       .name =3D "medhigh",
+       .description =3D "Medium High Frequency state",
+       .type =3D PM_FREQ_CHANGE,
+       .latency =3D 100,
+       .prepare_transition  =3D cpufreq_prepare_transition,
+       .transition =3D centrino_transition,
+       .finish_transition =3D cpufreq_finish_transition,
+};
+
+static struct powerop high =3D {
+       .name =3D "high",
+       .description =3D "High Frequency state",
+       .type =3D PM_FREQ_CHANGE,
+       .latency =3D 100,
+       .prepare_transition  =3D cpufreq_prepare_transition,
+       .transition =3D centrino_transition,
+       .finish_transition =3D cpufreq_finish_transition,
+};
+
+static struct powerop highest =3D {
+       .name =3D "highest",
+       .description =3D "Highest Frequency state",
+       .type =3D PM_FREQ_CHANGE,
+       .latency =3D 100,
+       .prepare_transition  =3D cpufreq_prepare_transition,
+       .transition =3D centrino_transition,
+       .finish_transition =3D cpufreq_finish_transition,
+};
+
+/* CPU models, their operating frequency range, and freq/voltage
+   operating points */
+static struct cpu_model models[] =3D
+{
+       _BANIAS(&cpu_ids[CPU_BANIAS], 900, " 900"),
+       BANIAS(1000),
+       BANIAS(1100),
+       BANIAS(1200),
+       BANIAS(1300),
+       BANIAS(1400),
+       BANIAS(1500),
+       BANIAS(1600),
+       BANIAS(1700),
+
+       /* NULL model_name is a wildcard */
+       { &cpu_ids[CPU_DOTHAN_A1], NULL, 0, NULL },
+       { &cpu_ids[CPU_DOTHAN_A2], NULL, 0, NULL },
+       { &cpu_ids[CPU_DOTHAN_B0], NULL, 0, NULL },
+       { &cpu_ids[CPU_MP4HT_D0], NULL, 0, NULL },
+       { &cpu_ids[CPU_MP4HT_E0], NULL, 0, NULL },
+
+       { NULL, }
+};
+#undef _BANIAS
+#undef BANIAS
+
+static int __init centrino_init_powerop(void)
+{
+       struct cpuinfo_x86 *cpu =3D &cpu_data[0];
+       struct cpu_model *model;
+
+       for(model =3D models; model->cpu_id !=3D NULL; model++) {
+               if (centrino_verify_cpu_id(cpu, model->cpu_id) &&
+                   (model->model_name =3D=3D NULL ||
+                    strcmp(cpu->x86_model_id, model->model_name) =3D=3D 0))
+                       break;
+       }
+
+       if (model->cpu_id =3D=3D NULL) {
+               /* No match at all */
+               printk("no support for CPU model %s\n", cpu->x86_model_id);
+               return -ENOENT;
+       }
+
+       printk("found \"%s\": max frequency: %dkHz\n",
+              model->model_name, model->max_freq);
+       switch (model->max_freq) {
+           case (900000) :
+           {
+               centrino_set_frequency(&low, 600, 844);
+               centrino_set_frequency(&med, 800, 988);
+               centrino_set_frequency(&high, 900, 1004);
+               break;
+           }
+           case (1000000) :
+           {
+               centrino_set_frequency(&low, 600, 844);
+               centrino_set_frequency(&med, 800, 972);
+               centrino_set_frequency(&high, 900, 988);
+               centrino_set_frequency(&highest, 1000, 1004);
+               break;
+           }
+           case (1100000) :
+           {
+               centrino_set_frequency(&lowest, 600, 956);
+               centrino_set_frequency(&low, 800, 1020);
+               centrino_set_frequency(&med, 900, 1100);
+               centrino_set_frequency(&high, 1000, 1164);
+               centrino_set_frequency(&highest, 1100, 1180);
+               break;
+           }
+           case (1200000) :
+           {
+               centrino_set_frequency(&lowest, 600, 956);
+               centrino_set_frequency(&low, 800, 1004);
+               centrino_set_frequency(&med, 900, 1020);
+               centrino_set_frequency(&medhigh, 1000, 1100);
+               centrino_set_frequency(&high, 1100, 1164);
+               centrino_set_frequency(&highest, 1200, 1180);
+               break;
+           }
+           case (1300000) :
+           {
+               centrino_set_frequency(&lowest, 600, 956);
+               centrino_set_frequency(&low, 800, 1260);
+               centrino_set_frequency(&med, 1000, 1292);
+               centrino_set_frequency(&high, 1200, 1356);
+               centrino_set_frequency(&highest, 1300, 1388);
+               break;
+           }
+           case (1400000) :
+           {
+               centrino_set_frequency(&lowest, 600, 956);
+               centrino_set_frequency(&low, 800, 1180);
+               centrino_set_frequency(&med, 1000, 1308);
+               centrino_set_frequency(&high, 1200, 1436);
+               centrino_set_frequency(&highest, 1400, 1484);
+               break;
+           }
+           case (1500000) :
+           {
+               centrino_set_frequency(&lowest, 600, 956);
+               centrino_set_frequency(&low, 800, 1116);
+               centrino_set_frequency(&med, 1000, 1228);
+               centrino_set_frequency(&medhigh, 1200, 1356);
+               centrino_set_frequency(&high, 1400, 1452);
+               centrino_set_frequency(&highest, 1500, 1484);
+               break;
+           }
+           case (1600000) :
+           {
+               centrino_set_frequency(&lowest, 600, 956);
+               centrino_set_frequency(&low, 800, 1036);
+               centrino_set_frequency(&med, 1000, 1164);
+               centrino_set_frequency(&medhigh, 1200, 1276);
+               centrino_set_frequency(&high, 1400, 1420);
+               centrino_set_frequency(&highest, 1600, 1484);
+               break;
+           }
+           case (1700000) :
+           {
+               centrino_set_frequency(&lowest, 600, 956);
+               centrino_set_frequency(&low, 800, 1004);
+               centrino_set_frequency(&med, 1000, 1116);
+               centrino_set_frequency(&medhigh, 1200, 1228);
+               centrino_set_frequency(&high, 1400, 1308);
+               centrino_set_frequency(&highest, 1700, 1484);
+               break;
+           }
+       }
+       if (lowest.frequency)
+               list_add_tail(&lowest.list, &pm_states.list);
+       if (low.frequency)
+               list_add_tail(&low.list, &pm_states.list);
+       if (medlow.frequency)
+               list_add_tail(&medlow.list, &pm_states.list);
+       if (med.frequency)
+               list_add_tail(&med.list, &pm_states.list);
+       if (medhigh.frequency)
+               list_add_tail(&medhigh.list, &pm_states.list);
+       if (high.frequency) {
+               list_add_tail(&high.list, &pm_states.list);
+               current_state =3D &high;
+       }
+       if (highest.frequency) {
+               list_add_tail(&highest.list, &pm_states.list);
+               current_state =3D &highest;
+       }
+       return 0;
+}
+
+static void centrino_exit_powerop(void)
+{
+       if (lowest.frequency)
+               list_del_init(&lowest.list);
+       if (low.frequency)
+               list_del_init(&low.list);
+       if (medlow.frequency)
+               list_del_init(&medlow.list);
+       if (med.frequency)
+               list_del_init(&med.list);
+       if (medhigh.frequency)
+               list_del_init(&medhigh.list);
+       if (high.frequency)
+               list_del_init(&high.list);
+       if (highest.frequency)
+               list_del_init(&highest.list);
+       return;
+}
+
+static int centrino_verify_cpu_id(const struct cpuinfo_x86 *c, const =

struct cpu_id *x)
+{
+       if ((c->x86 =3D=3D x->x86) &&
+           (c->x86_model =3D=3D x->x86_model) &&
+           (c->x86_mask =3D=3D x->x86_mask))
+               return 1;
+       return 0;
+}
+
+MODULE_AUTHOR ("David Singleton <dsingleton@mvista.com>");
+MODULE_DESCRIPTION ("PowerOp operting points for Intel Pentium M =

processors.");
+MODULE_LICENSE ("GPL");
+
+late_initcall(centrino_init_powerop);
+module_exit(centrino_exit_powerop);
Index: linux-2.6.17/arch/i386/kernel/i386_ksyms.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.17.orig/arch/i386/kernel/i386_ksyms.c
+++ linux-2.6.17/arch/i386/kernel/i386_ksyms.c
@@ -28,3 +28,7 @@ EXPORT_SYMBOL(__read_lock_failed);
 #endif

 EXPORT_SYMBOL(csum_partial);
+#ifdef CONFIG_PM
+#include <linux/pm.h>
+EXPORT_SYMBOL(pm_states);
+#endif
