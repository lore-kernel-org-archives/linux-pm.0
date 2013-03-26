From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2] cpufreq: ARM big LITTLE: Add generic cpufreq driver and its DT glue
Date: Tue, 26 Mar 2013 15:21:56 +0530
Message-ID: <1f864ec505cae7c5daea3810a3c26e0f5cda38ea.1364290815.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@sisk.pl, nicolas.pitre@linaro.org
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, arvind.chauhan@arm.com, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, mark.hambleton@broadcom.com, linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, devicetree-discuss@lists.ozlabs.org, Viresh Kumar <viresh.kumar@linaro.org>, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
List-Id: linux-pm@vger.kernel.org

big LITTLE is ARM's new Architecture focussing power/performance needs of m=
odern
world. More information about big LITTLE can be found here:

http://www.arm.com/products/processors/technologies/biglittleprocessing.php
http://lwn.net/Articles/481055/

In order to keep cpufreq support for all big LITTLE platforms simple/generi=
c,
this patch tries to add a generic cpufreq driver layer for all big LITTLE
platforms.

The driver is divided into two parts:
- Core driver: Generic and shared across all big LITTLE SoC's
- Glue drivers: Per platform drivers providing ops to the core driver

This patch adds in a generic glue driver which would extract information fr=
om
Device Tree.

Future SoC's can either reuse the DT glue or write their own depending on t=
he
need.

Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V1->V2:
- It was reviewed here earlier: https://lkml.org/lkml/2013/3/4/614
- It supports OPP library now and doesn't create a new binding for cpufreq =
table
- It doesn't add any dependency on cluster node in DT, rather we work with
  existing cpu nodes, Documentation updated.
- cpu_dev used because of OPP library and hence dev_err/dbg/info used at
  multiple places.
- Interface with glue driver updated a bit
- IS_ERR_OR_NULL replaced with IS_ERR for clk_get
- clk_get_sys used instead of clk_get and name of clk is also updated
- Few more minor cleanups done.

It is pushed here:

http://git.linaro.org/gitweb?p=3Dpeople/vireshk/linux.git;a=3Dshortlog;h=3D=
refs/heads/cpufreq-biglittle

 .../bindings/cpufreq/arm_big_little_dt.txt         |  65 +++++
 MAINTAINERS                                        |  11 +
 drivers/cpufreq/Kconfig.arm                        |  12 +
 drivers/cpufreq/Makefile                           |   4 +
 drivers/cpufreq/arm_big_little.c                   | 282 +++++++++++++++++=
++++
 drivers/cpufreq/arm_big_little.h                   |  40 +++
 drivers/cpufreq/arm_big_little_dt.c                |  92 +++++++
 7 files changed, 506 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/arm_big_littl=
e_dt.txt
 create mode 100644 drivers/cpufreq/arm_big_little.c
 create mode 100644 drivers/cpufreq/arm_big_little.h
 create mode 100644 drivers/cpufreq/arm_big_little_dt.c

diff --git a/Documentation/devicetree/bindings/cpufreq/arm_big_little_dt.tx=
t b/Documentation/devicetree/bindings/cpufreq/arm_big_little_dt.txt
new file mode 100644
index 0000000..34a460d
--- /dev/null
+++ b/Documentation/devicetree/bindings/cpufreq/arm_big_little_dt.txt
@@ -0,0 +1,65 @@
+Generic ARM big LITTLE cpufreq driver's DT glue
+-----------------------------------------------
+
+This is DT specific glue layer for generic cpufreq driver for big LITTLE
+systems.
+
+Both required and optional properties listed below must be defined
+under node /cpus/cpu@x. Where x is the first cpu inside a cluster.
+
+NOTE: Cpus should boot in the order specified in DT and all cpus for a clu=
ster
+must be present contiguously. Generic DT driver will check only node 'x' f=
or
+cpu:x.
+
+Required properties:
+- operating-points: Refer to Documentation/devicetree/bindings/power/opp.t=
xt
+  for details
+
+Optional properties:
+- clock-latency: Specify the possible maximum transition latency for clock=
,
+  in unit of nanoseconds.
+
+Examples:
+
+cpus {
+=09#address-cells =3D <1>;
+=09#size-cells =3D <0>;
+
+=09cpu@0 {
+=09=09compatible =3D "arm,cortex-a15";
+=09=09reg =3D <0>;
+=09=09next-level-cache =3D <&L2>;
+=09=09operating-points =3D <
+=09=09=09/* kHz    uV */
+=09=09=09792000  1100000
+=09=09=09396000  950000
+=09=09=09198000  850000
+=09=09>;
+=09=09clock-latency =3D <61036>; /* two CLK32 periods */
+=09};
+
+=09cpu@1 {
+=09=09compatible =3D "arm,cortex-a15";
+=09=09reg =3D <1>;
+=09=09next-level-cache =3D <&L2>;
+=09};
+
+=09cpu@100 {
+=09=09compatible =3D "arm,cortex-a7";
+=09=09reg =3D <100>;
+=09=09next-level-cache =3D <&L2>;
+=09=09operating-points =3D <
+=09=09=09/* kHz    uV */
+=09=09=09792000  950000
+=09=09=09396000  750000
+=09=09=09198000  450000
+=09=09>;
+=09=09clock-latency =3D <61036>; /* two CLK32 periods */
+=09};
+
+=09cpu@101 {
+=09=09compatible =3D "arm,cortex-a7";
+=09=09reg =3D <101>;
+=09=09next-level-cache =3D <&L2>;
+=09};
+};
diff --git a/MAINTAINERS b/MAINTAINERS
index 4cf5fd3..4071b71 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2206,6 +2206,17 @@ S:=09Maintained
 F:=09drivers/cpufreq/
 F:=09include/linux/cpufreq.h
=20
+CPU FREQUENCY DRIVERS - ARM BIG LITTLE
+M:=09Viresh Kumar <viresh.kumar@linaro.org>
+M:=09Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
+L:=09cpufreq@vger.kernel.org
+L:=09linux-pm@vger.kernel.org
+W:=09http://www.arm.com/products/processors/technologies/biglittleprocessi=
ng.php
+S:=09Maintained
+F:=09drivers/cpufreq/arm_big_little.h
+F:=09drivers/cpufreq/arm_big_little.c
+F:=09drivers/cpufreq/arm_big_little_dt.c
+
 CPUID/MSR DRIVER
 M:=09"H. Peter Anvin" <hpa@zytor.com>
 S:=09Maintained
diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 030ddf6..87b7e48 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -2,6 +2,18 @@
 # ARM CPU Frequency scaling drivers
 #
=20
+config ARM_BIG_LITTLE_CPUFREQ
+=09tristate
+=09depends on ARM_CPU_TOPOLOGY
+
+config ARM_DT_BL_CPUFREQ
+=09tristate "Generic ARM big LITTLE CPUfreq driver probed via DT"
+=09select ARM_BIG_LITTLE_CPUFREQ
+=09depends on OF && HAVE_CLK
+=09help
+=09  This enables the Generic CPUfreq driver for ARM big.LITTLE platform.
+=09  This gets frequency tables from DT.
+
 config ARM_OMAP2PLUS_CPUFREQ
 =09bool "TI OMAP2+"
 =09depends on ARCH_OMAP2PLUS
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 863fd18..d1b0832 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -44,6 +44,10 @@ obj-$(CONFIG_X86_INTEL_PSTATE)=09=09+=3D intel_pstate.o
=20
 ##########################################################################=
########
 # ARM SoC drivers
+obj-$(CONFIG_ARM_BIG_LITTLE_CPUFREQ)=09+=3D arm_big_little.o
+# big LITTLE per platform glues. Keep DT_BL_CPUFREQ as the last entry in a=
ll big
+# LITTLE drivers, so that it is probed last.
+obj-$(CONFIG_ARM_DT_BL_CPUFREQ)=09+=3D arm_big_little_dt.o
 obj-$(CONFIG_UX500_SOC_DB8500)=09=09+=3D dbx500-cpufreq.o
 obj-$(CONFIG_ARM_S3C2416_CPUFREQ)=09+=3D s3c2416-cpufreq.o
 obj-$(CONFIG_ARM_S3C64XX_CPUFREQ)=09+=3D s3c64xx-cpufreq.o
diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_lit=
tle.c
new file mode 100644
index 0000000..1d29d1a
--- /dev/null
+++ b/drivers/cpufreq/arm_big_little.c
@@ -0,0 +1,282 @@
+/*
+ * ARM big.LITTLE Platforms CPUFreq support
+ *
+ * Copyright (C) 2013 ARM Ltd.
+ * Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
+ *
+ * Copyright (C) 2013 Linaro.
+ * Viresh Kumar <viresh.kumar@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/clk.h>
+#include <linux/cpu.h>
+#include <linux/cpufreq.h>
+#include <linux/cpumask.h>
+#include <linux/export.h>
+#include <linux/of_platform.h>
+#include <linux/opp.h>
+#include <linux/slab.h>
+#include <linux/topology.h>
+#include <linux/types.h>
+
+#include "arm_big_little.h"
+
+/* Currently we support only two clusters */
+#define MAX_CLUSTERS=092
+
+static struct cpufreq_arm_bL_ops *arm_bL_ops;
+static struct clk *clk[MAX_CLUSTERS];
+static struct cpufreq_frequency_table *freq_table[MAX_CLUSTERS];
+static atomic_t cluster_usage[MAX_CLUSTERS] =3D {ATOMIC_INIT(0), ATOMIC_IN=
IT(0)};
+
+static int cpu_to_cluster(int cpu)
+{
+=09return topology_physical_package_id(cpu);
+}
+
+static unsigned int bL_cpufreq_get(unsigned int cpu)
+{
+=09u32 cur_cluster =3D cpu_to_cluster(cpu);
+
+=09return clk_get_rate(clk[cur_cluster]) / 1000;
+}
+
+/* Validate policy frequency range */
+static int bL_cpufreq_verify_policy(struct cpufreq_policy *policy)
+{
+=09u32 cur_cluster =3D cpu_to_cluster(policy->cpu);
+
+=09return cpufreq_frequency_table_verify(policy, freq_table[cur_cluster]);
+}
+
+/* Set clock frequency */
+static int bL_cpufreq_set_target(struct cpufreq_policy *policy,
+=09=09unsigned int target_freq, unsigned int relation)
+{
+=09struct cpufreq_freqs freqs;
+=09u32 cpu =3D policy->cpu, freq_tab_idx, cur_cluster;
+=09int ret =3D 0;
+
+=09cur_cluster =3D cpu_to_cluster(policy->cpu);
+
+=09freqs.old =3D bL_cpufreq_get(policy->cpu);
+
+=09/* Determine valid target frequency using freq_table */
+=09cpufreq_frequency_table_target(policy, freq_table[cur_cluster],
+=09=09=09target_freq, relation, &freq_tab_idx);
+=09freqs.new =3D freq_table[cur_cluster][freq_tab_idx].frequency;
+
+=09freqs.cpu =3D policy->cpu;
+
+=09pr_debug("%s: cpu: %d, cluster: %d, oldfreq: %d, target freq: %d, new f=
req: %d\n",
+=09=09=09__func__, cpu, cur_cluster, freqs.old, target_freq,
+=09=09=09freqs.new);
+
+=09if (freqs.old =3D=3D freqs.new)
+=09=09return 0;
+
+=09for_each_cpu(freqs.cpu, policy->cpus)
+=09=09cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+
+=09ret =3D clk_set_rate(clk[cur_cluster], freqs.new * 1000);
+=09if (ret) {
+=09=09pr_err("clk_set_rate failed: %d\n", ret);
+=09=09return ret;
+=09}
+
+=09policy->cur =3D freqs.new;
+
+=09for_each_cpu(freqs.cpu, policy->cpus)
+=09=09cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+
+=09return ret;
+}
+
+static void put_cluster_clk_and_freq_table(struct device *cpu_dev)
+{
+=09u32 cluster =3D cpu_to_cluster(cpu_dev->id);
+
+=09if (!atomic_dec_return(&cluster_usage[cluster])) {
+=09=09clk_put(clk[cluster]);
+=09=09opp_free_cpufreq_table(cpu_dev, &freq_table[cluster]);
+=09=09dev_dbg(cpu_dev, "%s: cluster: %d\n", __func__, cluster);
+=09}
+}
+
+static int get_cluster_clk_and_freq_table(struct device *cpu_dev)
+{
+=09u32 cluster =3D cpu_to_cluster(cpu_dev->id);
+=09char name[14] =3D "cpu-cluster.";
+=09int ret;
+
+=09if (atomic_inc_return(&cluster_usage[cluster]) !=3D 1)
+=09=09return 0;
+
+=09ret =3D arm_bL_ops->init_opp_table(cpu_dev);
+=09if (ret) {
+=09=09dev_err(cpu_dev, "%s: init_opp_table failed, cpu: %d, err: %d\n",
+=09=09=09=09__func__, cpu_dev->id, ret);
+=09=09goto atomic_dec;
+=09}
+
+=09ret =3D opp_init_cpufreq_table(cpu_dev, &freq_table[cluster]);
+=09if (ret) {
+=09=09dev_err(cpu_dev, "%s: failed to init cpufreq table, cpu: %d, err: %d=
\n",
+=09=09=09=09__func__, cpu_dev->id, ret);
+=09=09goto atomic_dec;
+=09}
+
+=09name[12] =3D cluster + '0';
+=09clk[cluster] =3D clk_get_sys(name, NULL);
+=09if (!IS_ERR(clk[cluster])) {
+=09=09dev_dbg(cpu_dev, "%s: clk: %p & freq table: %p, cluster: %d\n",
+=09=09=09=09__func__, clk[cluster], freq_table[cluster],
+=09=09=09=09cluster);
+=09=09return 0;
+=09}
+
+=09dev_err(cpu_dev, "%s: Failed to get clk for cpu: %d, cluster: %d\n",
+=09=09=09__func__, cpu_dev->id, cluster);
+=09ret =3D PTR_ERR(clk[cluster]);
+=09opp_free_cpufreq_table(cpu_dev, &freq_table[cluster]);
+
+atomic_dec:
+=09atomic_dec(&cluster_usage[cluster]);
+=09dev_err(cpu_dev, "%s: Failed to get data for cluster: %d\n", __func__,
+=09=09=09cluster);
+=09return ret;
+}
+
+/* Per-CPU initialization */
+static int bL_cpufreq_init(struct cpufreq_policy *policy)
+{
+=09u32 cur_cluster =3D cpu_to_cluster(policy->cpu);
+=09struct device *cpu_dev;
+=09int ret;
+
+=09cpu_dev =3D get_cpu_device(policy->cpu);
+=09if (!cpu_dev) {
+=09=09pr_err("%s: failed to get cpu%d device\n", __func__,
+=09=09=09=09policy->cpu);
+=09=09return -ENODEV;
+=09}
+
+=09ret =3D get_cluster_clk_and_freq_table(cpu_dev);
+=09if (ret)
+=09=09return ret;
+
+=09ret =3D cpufreq_frequency_table_cpuinfo(policy, freq_table[cur_cluster]=
);
+=09if (ret) {
+=09=09dev_err(cpu_dev, "CPU %d, cluster: %d invalid freq table\n",
+=09=09=09=09policy->cpu, cur_cluster);
+=09=09put_cluster_clk_and_freq_table(cpu_dev);
+=09=09return ret;
+=09}
+
+=09cpufreq_frequency_table_get_attr(freq_table[cur_cluster], policy->cpu);
+
+=09if (arm_bL_ops->get_transition_latency)
+=09=09policy->cpuinfo.transition_latency =3D
+=09=09=09arm_bL_ops->get_transition_latency(cpu_dev);
+=09else
+=09=09policy->cpuinfo.transition_latency =3D CPUFREQ_ETERNAL;
+
+=09policy->cur =3D bL_cpufreq_get(policy->cpu);
+
+=09cpumask_copy(policy->cpus, topology_core_cpumask(policy->cpu));
+
+=09dev_info(cpu_dev, "CPU %d initialized\n", policy->cpu);
+=09return 0;
+}
+
+static int bL_cpufreq_exit(struct cpufreq_policy *policy)
+{
+=09struct device *cpu_dev;
+
+=09cpu_dev =3D get_cpu_device(policy->cpu);
+=09if (!cpu_dev) {
+=09=09pr_err("%s: failed to get cpu%d device\n", __func__,
+=09=09=09=09policy->cpu);
+=09=09return -ENODEV;
+=09}
+
+=09put_cluster_clk_and_freq_table(cpu_dev);
+=09dev_dbg(cpu_dev, "%s: Exited, cpu: %d\n", __func__, policy->cpu);
+
+=09return 0;
+}
+
+/* Export freq_table to sysfs */
+static struct freq_attr *bL_cpufreq_attr[] =3D {
+=09&cpufreq_freq_attr_scaling_available_freqs,
+=09NULL,
+};
+
+static struct cpufreq_driver bL_cpufreq_driver =3D {
+=09.name=09=09=09=3D "arm-big-little",
+=09.flags=09=09=09=3D CPUFREQ_STICKY,
+=09.verify=09=09=09=3D bL_cpufreq_verify_policy,
+=09.target=09=09=09=3D bL_cpufreq_set_target,
+=09.get=09=09=09=3D bL_cpufreq_get,
+=09.init=09=09=09=3D bL_cpufreq_init,
+=09.exit=09=09=09=3D bL_cpufreq_exit,
+=09.have_multiple_policies=09=3D true,
+=09.attr=09=09=09=3D bL_cpufreq_attr,
+};
+
+int bL_cpufreq_register(struct cpufreq_arm_bL_ops *ops)
+{
+=09int ret;
+
+=09if (arm_bL_ops) {
+=09=09pr_debug("%s: Already registered: %s, exiting\n", __func__,
+=09=09=09=09arm_bL_ops->name);
+=09=09return -EBUSY;
+=09}
+
+=09if (!ops || !strlen(ops->name) || !ops->init_opp_table) {
+=09=09pr_err("%s: Invalid arm_bL_ops, exiting\n", __func__);
+=09=09return -ENODEV;
+=09}
+
+=09arm_bL_ops =3D ops;
+
+=09ret =3D cpufreq_register_driver(&bL_cpufreq_driver);
+=09if (ret) {
+=09=09pr_info("%s: Failed registering platform driver: %s, err: %d\n",
+=09=09=09=09__func__, ops->name, ret);
+=09=09arm_bL_ops =3D NULL;
+=09} else {
+=09=09pr_info("%s: Registered platform driver: %s\n", __func__,
+=09=09=09=09ops->name);
+=09}
+
+=09return ret;
+}
+EXPORT_SYMBOL_GPL(bL_cpufreq_register);
+
+void bL_cpufreq_unregister(struct cpufreq_arm_bL_ops *ops)
+{
+=09if (arm_bL_ops !=3D ops) {
+=09=09pr_err("%s: Registered with: %s, can't unregister, exiting\n",
+=09=09=09=09__func__, arm_bL_ops->name);
+=09=09return;
+=09}
+
+=09cpufreq_unregister_driver(&bL_cpufreq_driver);
+=09pr_info("%s: Un-registered platform driver: %s\n", __func__,
+=09=09=09arm_bL_ops->name);
+=09arm_bL_ops =3D NULL;
+}
+EXPORT_SYMBOL_GPL(bL_cpufreq_unregister);
diff --git a/drivers/cpufreq/arm_big_little.h b/drivers/cpufreq/arm_big_lit=
tle.h
new file mode 100644
index 0000000..70f18fc
--- /dev/null
+++ b/drivers/cpufreq/arm_big_little.h
@@ -0,0 +1,40 @@
+/*
+ * ARM big.LITTLE platform's CPUFreq header file
+ *
+ * Copyright (C) 2013 ARM Ltd.
+ * Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
+ *
+ * Copyright (C) 2013 Linaro.
+ * Viresh Kumar <viresh.kumar@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+#ifndef CPUFREQ_ARM_BIG_LITTLE_H
+#define CPUFREQ_ARM_BIG_LITTLE_H
+
+#include <linux/cpufreq.h>
+#include <linux/device.h>
+#include <linux/types.h>
+
+struct cpufreq_arm_bL_ops {
+=09char name[CPUFREQ_NAME_LEN];
+=09int (*get_transition_latency)(struct device *cpu_dev);
+
+=09/*
+=09 * This must set opp table for cpu_dev in a similar way as done by
+=09 * of_init_opp_table().
+=09 */
+=09int (*init_opp_table)(struct device *cpu_dev);
+};
+
+int bL_cpufreq_register(struct cpufreq_arm_bL_ops *ops);
+void bL_cpufreq_unregister(struct cpufreq_arm_bL_ops *ops);
+
+#endif /* CPUFREQ_ARM_BIG_LITTLE_H */
diff --git a/drivers/cpufreq/arm_big_little_dt.c b/drivers/cpufreq/arm_big_=
little_dt.c
new file mode 100644
index 0000000..452ff46
--- /dev/null
+++ b/drivers/cpufreq/arm_big_little_dt.c
@@ -0,0 +1,92 @@
+/*
+ * Generic big.LITTLE CPUFreq Interface driver
+ *
+ * It provides necessary ops to arm_big_little cpufreq driver and gets
+ * Frequency information from Device Tree. Freq table in DT must be in KHz=
.
+ *
+ * Copyright (C) 2013 Linaro.
+ * Viresh Kumar <viresh.kumar@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/cpufreq.h>
+#include <linux/device.h>
+#include <linux/export.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/opp.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include "arm_big_little.h"
+
+static int dt_init_opp_table(struct device *cpu_dev)
+{
+=09struct device_node *np =3D NULL;
+=09int count =3D 0, ret;
+
+=09for_each_child_of_node(of_find_node_by_path("/cpus"), np) {
+=09=09if (count++ !=3D cpu_dev->id)
+=09=09=09continue;
+=09=09if (!of_get_property(np, "operating-points", NULL))
+=09=09=09return -ENODATA;
+
+=09=09cpu_dev->of_node =3D np;
+
+=09=09ret =3D of_init_opp_table(cpu_dev);
+=09=09if (ret)
+=09=09=09return ret;
+
+=09=09return 0;
+=09}
+
+=09return -ENODEV;
+}
+
+static int dt_get_transition_latency(struct device *cpu_dev)
+{
+=09struct device_node *np =3D NULL;
+=09u32 transition_latency =3D CPUFREQ_ETERNAL;
+=09int count =3D 0;
+
+=09for_each_child_of_node(of_find_node_by_path("/cpus"), np) {
+=09=09if (count++ !=3D cpu_dev->id)
+=09=09=09continue;
+
+=09=09of_property_read_u32(np, "clock-latency", &transition_latency);
+=09=09return 0;
+=09}
+
+=09return -ENODEV;
+}
+
+static struct cpufreq_arm_bL_ops dt_bL_ops =3D {
+=09.name=09=3D "dt-bl",
+=09.get_transition_latency =3D dt_get_transition_latency,
+=09.init_opp_table =3D dt_init_opp_table,
+};
+
+static int generic_bL_init(void)
+{
+=09return bL_cpufreq_register(&dt_bL_ops);
+}
+module_init(generic_bL_init);
+
+static void generic_bL_exit(void)
+{
+=09return bL_cpufreq_unregister(&dt_bL_ops);
+}
+module_exit(generic_bL_exit);
+
+MODULE_AUTHOR("Viresh Kumar <viresh.kumar@linaro.org>");
+MODULE_DESCRIPTION("Generic ARM big LITTLE cpufreq driver via DT");
+MODULE_LICENSE("GPL");
--=20
1.7.12.rc2.18.g61b472e


