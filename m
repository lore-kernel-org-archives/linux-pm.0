From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [RFC PATCH 3/3] cpuidle: big.LITTLE: vexpress-TC2 CPU idle driver
Date: Thu, 25 Jul 2013 12:14:26 +0100
Message-ID: <1374750866-750-4-git-send-email-lorenzo.pieralisi@arm.com>
References: <1374750866-750-1-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:39858 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755009Ab3GYLOg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jul 2013 07:14:36 -0400
In-Reply-To: <1374750866-750-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Kevin Hilman <khilman@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Olof Johansson <olof@lixom.net>, Nicolas Pitre <nicolas.pitre@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jon Medhurst <tixy@linaro.org>

The big.LITTLE architecture is composed of two clusters of cpus. One cluste=
r
contains less powerful but more energy efficient processors and the other
cluster groups the powerful but energy-intensive cpus.

The TC2 testchip implements two clusters of CPUs (A7 and A15 clusters in
a big.LITTLE configuration) connected through a CCI interconnect that manag=
es
coherency of their respective L2 caches and intercluster distributed
virtual memory messages (DVM).

TC2 testchip integrates a power controller that manages cores resets, wake-=
up
IRQs and cluster low-power states. Power states are managed at cluster
level, which means that voltage is removed from a cluster iff all cores
in a cluster are in a wfi state. Single cores can enter a reset state
which is identical to wfi in terms of power consumption but simplifies the
way cluster states are entered.

This patch provides a multiple driver CPU idle implementation for TC2
which paves the way for a generic big.LITTLE idle driver for all
upcoming big.LITTLE based systems on chip.

The driver relies on the MCPM infrastructure to coordinate and manage
core power states; in particular MCPM allows to suspend specific cores
and hides the CPUs coordination required to shut-down clusters of CPUs.

Power down sequences for the respective clusters are implemented in the
MCPM TC2 backend, with all code needed to clean caches and exit coherency.

The multiple driver CPU idle infrastructure allows to define different
C-states for big and little cores, determined at boot by checking the
part id of the possible CPUs and initializing the respective logical
masks in the big and little drivers.

Current big.little systems are composed of A7 and A15 clusters, as
implemented in TC2, but in the future that may change and the driver
will have evolve to retrieve what is a 'big' cpu and what is a 'little'
cpu in order to build the correct topology.

Cc: Kevin Hilman <khilman@linaro.org>
Cc: Amit Kucheria <amit.kucheria@linaro.org>
Cc: Olof Johansson <olof@lixom.net>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 MAINTAINERS                          |   9 ++
 drivers/cpuidle/Kconfig              |  10 ++
 drivers/cpuidle/Makefile             |   1 +
 drivers/cpuidle/cpuidle-big_little.c | 187 +++++++++++++++++++++++++++++++=
++++
 4 files changed, 207 insertions(+)
 create mode 100644 drivers/cpuidle/cpuidle-big_little.c

diff --git a/MAINTAINERS b/MAINTAINERS
index bf61e04..01f1b3d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2263,6 +2263,15 @@ F:=09drivers/cpufreq/arm_big_little.h
 F:=09drivers/cpufreq/arm_big_little.c
 F:=09drivers/cpufreq/arm_big_little_dt.c
=20
+CPUIDLE DRIVER - ARM BIG LITTLE
+M:      Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
+M:      Daniel Lezcano <daniel.lezcano@linaro.org>
+L:      linux-pm@vger.kernel.org
+L:      linux-arm-kernel@lists.infradead.org
+T:      git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
+S:      Maintained
+F:      drivers/cpuidle/cpuidle-big_little.c
+
 CPUIDLE DRIVERS
 M:=09Rafael J. Wysocki <rjw@sisk.pl>
 M:=09Daniel Lezcano <daniel.lezcano@linaro.org>
diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
index 0e2cd5c..0f86587 100644
--- a/drivers/cpuidle/Kconfig
+++ b/drivers/cpuidle/Kconfig
@@ -42,6 +42,16 @@ config CPU_IDLE_ZYNQ
 =09help
 =09  Select this to enable cpuidle on Xilinx Zynq processors.
=20
+config CPU_IDLE_BIG_LITTLE
+=09bool "Support for ARM big.LITTLE processors"
+=09depends on ARCH_VEXPRESS_TC2_PM
+=09select ARM_CPU_SUSPEND
+=09select CPU_IDLE_MULTIPLE_DRIVERS
+=09help
+=09  Select this option to enable CPU idle driver for big.LITTLE based
+=09  ARM systems. Driver manages CPUs coordination through MCPM and
+=09  define different C-states for little and big cores through the
+=09  multiple CPU idle drivers infrastructure.
 endif
=20
 config ARCH_NEEDS_CPU_IDLE_COUPLED
diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
index 8767a7b..3b6445c 100644
--- a/drivers/cpuidle/Makefile
+++ b/drivers/cpuidle/Makefile
@@ -8,3 +8,4 @@ obj-$(CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED) +=3D coupled.o
 obj-$(CONFIG_CPU_IDLE_CALXEDA) +=3D cpuidle-calxeda.o
 obj-$(CONFIG_ARCH_KIRKWOOD) +=3D cpuidle-kirkwood.o
 obj-$(CONFIG_CPU_IDLE_ZYNQ) +=3D cpuidle-zynq.o
+obj-$(CONFIG_CPU_IDLE_BIG_LITTLE) +=3D cpuidle-big_little.o
diff --git a/drivers/cpuidle/cpuidle-big_little.c b/drivers/cpuidle/cpuidle=
-big_little.c
new file mode 100644
index 0000000..98cb375
--- /dev/null
+++ b/drivers/cpuidle/cpuidle-big_little.c
@@ -0,0 +1,187 @@
+/*
+ * Copyright (c) 2013 ARM/Linaro
+ *
+ * Authors: Daniel Lezcano <daniel.lezcano@linaro.org>
+ *          Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
+ *          Nicolas Pitre <nicolas.pitre@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Maintainer: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
+ * Maintainer: Daniel Lezcano <daniel.lezcano@linaro.org>
+ */
+#include <linux/cpuidle.h>
+#include <linux/cpu_pm.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+
+#include <asm/cpu.h>
+#include <asm/cputype.h>
+#include <asm/cpuidle.h>
+#include <asm/mcpm.h>
+#include <asm/smp_plat.h>
+#include <asm/suspend.h>
+
+static int bl_enter_powerdown(struct cpuidle_device *dev,
+=09=09=09      struct cpuidle_driver *drv, int idx);
+
+static struct cpuidle_driver bl_idle_little_driver =3D {
+=09.name =3D "little_idle",
+=09.owner =3D THIS_MODULE,
+=09.states[0] =3D ARM_CPUIDLE_WFI_STATE,
+=09.states[1] =3D {
+=09=09.enter=09=09=09=3D bl_enter_powerdown,
+=09=09.exit_latency=09=09=3D 1000,
+=09=09.target_residency=09=3D 3500,
+=09=09.flags=09=09=09=3D CPUIDLE_FLAG_TIME_VALID |
+=09=09=09=09=09  CPUIDLE_FLAG_TIMER_STOP,
+=09=09.name=09=09=09=3D "C1",
+=09=09.desc=09=09=09=3D "ARM little-cluster power down",
+=09},
+=09.state_count =3D 2,
+};
+
+static struct cpuidle_driver bl_idle_big_driver =3D {
+=09.name =3D "big_idle",
+=09.owner =3D THIS_MODULE,
+=09.states[0] =3D ARM_CPUIDLE_WFI_STATE,
+=09.states[1] =3D {
+=09=09.enter=09=09=09=3D bl_enter_powerdown,
+=09=09.exit_latency=09=09=3D 1000,
+=09=09.target_residency=09=3D 3000,
+=09=09.flags=09=09=09=3D CPUIDLE_FLAG_TIME_VALID |
+=09=09=09=09=09  CPUIDLE_FLAG_TIMER_STOP,
+=09=09.name=09=09=09=3D "C1",
+=09=09.desc=09=09=09=3D "ARM big-cluster power down",
+=09},
+=09.state_count =3D 2,
+};
+
+/*
+ * notrace prevents trace shims from getting inserted where they
+ * should not. Global jumps and ldrex/strex must not be inserted
+ * in power down sequences where caches and MMU may be turned off.
+ */
+static int notrace bl_powerdown_finisher(unsigned long arg)
+{
+=09/* MCPM works with HW CPU identifiers */
+=09unsigned int mpidr =3D read_cpuid_mpidr();
+=09unsigned int cluster =3D (mpidr >> 8) & 0xf;
+=09unsigned int cpu =3D mpidr & 0xf;
+
+=09mcpm_set_entry_vector(cpu, cluster, cpu_resume);
+=09/*
+=09 * Residency value passed to mcpm_cpu_suspend back-end
+=09 * has to be given clear semantics. Set to 0 as a
+=09 * temporary value.
+=09 */
+=09mcpm_cpu_suspend(0);
+=09/* return value !=3D 0 means failure */
+=09return 1;
+}
+
+/**
+ * bl_enter_powerdown - Programs CPU to enter the specified state
+ * @dev: cpuidle device
+ * @drv: The target state to be programmed
+ * @idx: state index
+ *
+ * Called from the CPUidle framework to program the device to the
+ * specified target state selected by the governor.
+ */
+static int bl_enter_powerdown(struct cpuidle_device *dev,
+=09=09=09=09struct cpuidle_driver *drv, int idx)
+{
+=09struct timespec ts_preidle, ts_postidle, ts_idle;
+=09int ret;
+
+=09/* Used to keep track of the total time in idle */
+=09getnstimeofday(&ts_preidle);
+
+=09cpu_pm_enter();
+
+=09ret =3D cpu_suspend(0, bl_powerdown_finisher);
+=09/* signals the MCPM core that CPU is out of low power state */
+=09mcpm_cpu_powered_up();
+
+=09cpu_pm_exit();
+
+=09getnstimeofday(&ts_postidle);
+=09ts_idle =3D timespec_sub(ts_postidle, ts_preidle);
+
+=09dev->last_residency =3D ts_idle.tv_nsec / NSEC_PER_USEC +
+=09=09=09=09=09ts_idle.tv_sec * USEC_PER_SEC;
+=09local_irq_enable();
+=09return idx;
+}
+
+static int __init bl_idle_driver_init(struct cpuidle_driver *drv, int cpu_=
id)
+{
+=09struct cpuinfo_arm *cpu_info;
+=09struct cpumask *cpumask;
+=09unsigned long cpuid;
+=09int cpu;
+
+=09cpumask =3D kzalloc(cpumask_size(), GFP_KERNEL);
+=09if (!cpumask)
+=09=09return -ENOMEM;
+
+=09for_each_possible_cpu(cpu) {
+=09=09cpu_info =3D &per_cpu(cpu_data, cpu);
+=09=09cpuid =3D is_smp() ? cpu_info->cpuid : read_cpuid_id();
+
+=09=09/* read cpu id part number */
+=09=09if ((cpuid & 0xFFF0) =3D=3D cpu_id)
+=09=09=09cpumask_set_cpu(cpu, cpumask);
+=09}
+
+=09drv->cpumask =3D cpumask;
+
+=09return 0;
+}
+
+static int __init bl_idle_init(void)
+{
+=09int ret;
+=09/*
+=09 * Initialize the driver just for a compliant set of machines
+=09 */
+=09if (!of_machine_is_compatible("arm,vexpress,v2p-ca15_a7"))
+=09=09return -ENODEV;
+=09/*
+=09 * For now the differentiation between little and big cores
+=09 * is based on the part number. A7 cores are considered little
+=09 * cores, A15 are considered big cores. This distinction may
+=09 * evolve in the future with a more generic matching approach.
+=09 */
+=09ret =3D bl_idle_driver_init(&bl_idle_little_driver,
+=09=09=09=09  ARM_CPU_PART_CORTEX_A7);
+=09if (ret)
+=09=09return ret;
+
+=09ret =3D bl_idle_driver_init(&bl_idle_big_driver, ARM_CPU_PART_CORTEX_A1=
5);
+=09if (ret)
+=09=09goto out_uninit_little;
+
+=09ret =3D cpuidle_register(&bl_idle_little_driver, NULL);
+=09if (ret)
+=09=09goto out_uninit_big;
+
+=09ret =3D cpuidle_register(&bl_idle_big_driver, NULL);
+=09if (ret)
+=09=09goto out_unregister_little;
+
+=09return 0;
+
+out_unregister_little:
+=09cpuidle_unregister(&bl_idle_little_driver);
+out_uninit_big:
+=09kfree(bl_idle_big_driver.cpumask);
+out_uninit_little:
+=09kfree(bl_idle_little_driver.cpumask);
+
+=09return ret;
+}
+device_initcall(bl_idle_init);
--=20
1.8.2.2


