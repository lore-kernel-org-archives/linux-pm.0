From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH v6 5/7] drivers: cpuidle: CPU idle ARM64 driver
Date: Mon, 21 Jul 2014 17:06:24 +0100
Message-ID: <1405958786-17243-6-git-send-email-lorenzo.pieralisi@arm.com>
References: <1405958786-17243-1-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:41770 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932667AbaGUQGn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Jul 2014 12:06:43 -0400
In-Reply-To: <1405958786-17243-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: devicetree@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Charles Garcia Tobin <Charles.Garcia-Tobin@arm.com>, Nicolas Pitre <nico@linaro.org>, Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Stephen Boyd <sboyd@codeaurora.org>, Kevin Hilman <khilman@linaro.org>, Sebastian Capella <sebcape@gmail.com>, Tomasz Figa <t.figa@samsung.com>, Mark Brown <broonie@kernel.org>, Paul Walmsley <paul@pwsan.com>, Chander Kashyap <chander.kashyap@linaro.org>, Geoff

This patch implements a generic CPU idle driver for ARM64 machines.

It relies on the DT idle states infrastructure to initialize idle
states count and respective parameters. Current code assumes the driver
is managing idle states on all possible CPUs but can be easily
generalized to support heterogenous systems and build cpumasks at
runtime using MIDRs or DT cpu nodes compatible properties.

The driver relies on the arm64 CPU operations to call the idle
initialization hook used to parse and save suspend back-end specific
idle states information upon probing.

Idle state index 0 is always initialized as a simple wfi state, ie always
considered present and functional on all ARM64 platforms.

Idle state indices higher than 0 trigger idle state entry by calling
the cpu_suspend function, that does save the CPU context and executes
the CPU operations suspend back-end hook. cpu_suspend passes the idle
state index as a parameter so that the CPU operations suspend back-end
can retrieve the required idle state data by using the idle state
index to execute a look-up on its internal data structures.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 drivers/cpuidle/Kconfig         |   5 ++
 drivers/cpuidle/Kconfig.arm64   |  14 +++++
 drivers/cpuidle/Makefile        |   4 ++
 drivers/cpuidle/cpuidle-arm64.c | 128 ++++++++++++++++++++++++++++++++++++=
++++
 4 files changed, 151 insertions(+)
 create mode 100644 drivers/cpuidle/Kconfig.arm64
 create mode 100644 drivers/cpuidle/cpuidle-arm64.c

diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
index 414e7a96..ebf0c2e 100644
--- a/drivers/cpuidle/Kconfig
+++ b/drivers/cpuidle/Kconfig
@@ -43,6 +43,11 @@ depends on ARM
 source "drivers/cpuidle/Kconfig.arm"
 endmenu
=20
+menu "ARM64 CPU Idle Drivers"
+depends on ARM64
+source "drivers/cpuidle/Kconfig.arm64"
+endmenu
+
 menu "MIPS CPU Idle Drivers"
 depends on MIPS
 source "drivers/cpuidle/Kconfig.mips"
diff --git a/drivers/cpuidle/Kconfig.arm64 b/drivers/cpuidle/Kconfig.arm64
new file mode 100644
index 0000000..d0a08ed
--- /dev/null
+++ b/drivers/cpuidle/Kconfig.arm64
@@ -0,0 +1,14 @@
+#
+# ARM64 CPU Idle drivers
+#
+
+config ARM64_CPUIDLE
+=09bool "Generic ARM64 CPU idle Driver"
+=09select ARM64_CPU_SUSPEND
+=09select DT_IDLE_STATES
+=09help
+=09  Select this to enable generic cpuidle driver for ARM64.
+=09  It provides a generic idle driver whose idle states are configured
+=09  at run-time through DT nodes. The CPUidle suspend backend is
+=09  initialized by calling the CPU operations init idle hook
+=09  provided by architecture code.
diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
index b27a062..706cb7f 100644
--- a/drivers/cpuidle/Makefile
+++ b/drivers/cpuidle/Makefile
@@ -23,6 +23,10 @@ obj-$(CONFIG_ARM_EXYNOS_CPUIDLE)        +=3D cpuidle-exy=
nos.o
 obj-$(CONFIG_MIPS_CPS_CPUIDLE)=09=09+=3D cpuidle-cps.o
=20
 ##########################################################################=
#####
+# ARM64 drivers
+obj-$(CONFIG_ARM64_CPUIDLE)=09=09+=3D cpuidle-arm64.o
+
+##########################################################################=
#####
 # POWERPC drivers
 obj-$(CONFIG_PSERIES_CPUIDLE)=09=09+=3D cpuidle-pseries.o
 obj-$(CONFIG_POWERNV_CPUIDLE)=09=09+=3D cpuidle-powernv.o
diff --git a/drivers/cpuidle/cpuidle-arm64.c b/drivers/cpuidle/cpuidle-arm6=
4.c
new file mode 100644
index 0000000..1aeb426
--- /dev/null
+++ b/drivers/cpuidle/cpuidle-arm64.c
@@ -0,0 +1,128 @@
+/*
+ * ARM64 generic CPU idle driver.
+ *
+ * Copyright (C) 2014 ARM Ltd.
+ * Author: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#define pr_fmt(fmt) "CPUidle arm64: " fmt
+
+#include <linux/cpuidle.h>
+#include <linux/cpumask.h>
+#include <linux/cpu_pm.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/slab.h>
+
+#include <asm/cpuidle.h>
+#include <asm/suspend.h>
+
+#include "dt_idle_states.h"
+
+/*
+ * arm_enter_idle_state - Programs CPU to enter the specified state
+ *
+ * dev: cpuidle device
+ * drv: cpuidle driver
+ * idx: state index
+ *
+ * Called from the CPUidle framework to program the device to the
+ * specified target state selected by the governor.
+ */
+static int arm_enter_idle_state(struct cpuidle_device *dev,
+=09=09=09=09struct cpuidle_driver *drv, int idx)
+{
+=09int ret;
+
+=09if (!idx) {
+=09=09cpu_do_idle();
+=09=09return idx;
+=09}
+
+=09ret =3D cpu_pm_enter();
+=09if (!ret) {
+=09=09/*
+=09=09 * Pass idle state index to cpu_suspend which in turn will
+=09=09 * call the CPU ops suspend protocol with idle index as a
+=09=09 * parameter.
+=09=09 */
+=09=09ret =3D cpu_suspend(idx);
+
+=09=09cpu_pm_exit();
+=09}
+
+=09return ret ? -1 : idx;
+}
+
+struct cpuidle_driver arm64_idle_driver =3D {
+=09.name =3D "arm64_idle",
+=09.owner =3D THIS_MODULE,
+=09/*
+=09 * State at index 0 is standby wfi and considered standard
+=09 * on all ARM platforms. If in some platforms simple wfi
+=09 * can't be used as "state 0", DT bindings must be implemented
+=09 * to work around this issue and allow installing a special
+=09 * handler for idle state index 0.
+=09 */
+=09.states[0] =3D {
+=09=09.enter                  =3D arm_enter_idle_state,
+=09=09.exit_latency           =3D 1,
+=09=09.target_residency       =3D 1,
+=09=09.power_usage=09=09=3D UINT_MAX,
+=09=09.flags                  =3D CPUIDLE_FLAG_TIME_VALID,
+=09=09.name                   =3D "WFI",
+=09=09.desc                   =3D "ARM64 WFI",
+=09}
+};
+
+/*
+ * arm64_idle_init
+ *
+ * Registers the arm64 specific cpuidle driver with the cpuidle
+ * framework. It relies on core code to parse the idle states
+ * and initialize them using driver data structures accordingly.
+ */
+static int __init arm64_idle_init(void)
+{
+=09int i, ret;
+=09struct cpuidle_driver *drv =3D &arm64_idle_driver;
+
+=09drv->cpumask =3D kzalloc(cpumask_size(), GFP_KERNEL);
+=09if (!drv->cpumask)
+=09=09return -ENOMEM;
+
+=09cpumask_copy(drv->cpumask, cpu_possible_mask);
+=09/*
+=09 * Start at index 1, request idle state nodes to be filled
+=09 */
+=09ret =3D dt_init_idle_driver(drv, 1);
+=09if (ret)
+=09=09goto free_mem;
+=09/*
+=09 * Call arch CPU operations in order to initialize
+=09 * idle states suspend back-end specific data
+=09 */
+=09for_each_cpu(i, drv->cpumask) {
+=09=09ret =3D cpu_init_idle(i);
+=09=09if (ret)
+=09=09=09goto free_mem;
+=09}
+
+=09for (i =3D 1; i < drv->state_count; i++)
+=09=09drv->states[i].enter =3D arm_enter_idle_state;
+
+=09ret =3D cpuidle_register(drv, NULL);
+=09if (ret)
+=09=09goto free_mem;
+
+=09return 0;
+free_mem:
+=09kfree(drv->cpumask);
+=09return ret;
+}
+device_initcall(arm64_idle_init);
--=20
1.9.1


