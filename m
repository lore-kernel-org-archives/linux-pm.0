From: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v9 6/8] drivers: cpuidle: CPU idle ARM64 driver
Date: Fri,  5 Sep 2014 18:34:55 +0100
Message-ID: <1409938498-17984-7-git-send-email-lorenzo.pieralisi@arm.com>
References: <1409938498-17984-1-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1409938498-17984-1-git-send-email-lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Charles Garcia Tobin <Charles.Garcia-Tobin-5wv7dgnIgG8@public.gmane.org>, Nicolas Pitre <nico-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Amit Kucheria <amit.kucheria-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Antti Miettinen <ananaza-X3B1VOXEql0@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Capella <sebcape-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Chander Kashyap <k.chander-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Geoff
List-Id: linux-pm@vger.kernel.org

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
the cpu_suspend function, that triggers the suspend operation through
the CPU operations suspend back-end hook. cpu_suspend passes the idle
state index as a parameter so that the CPU operations suspend back-end
can retrieve the required idle state data by using the idle state
index to execute a look-up on its internal data structures.

Reviewed-by: Ashwin Chaugule <ashwin.chaugule-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Reviewed-by: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
---
 drivers/cpuidle/Kconfig         |   5 ++
 drivers/cpuidle/Kconfig.arm64   |  14 +++++
 drivers/cpuidle/Makefile        |   4 ++
 drivers/cpuidle/cpuidle-arm64.c | 133 ++++++++++++++++++++++++++++++++++++=
++++
 4 files changed, 156 insertions(+)
 create mode 100644 drivers/cpuidle/Kconfig.arm64
 create mode 100644 drivers/cpuidle/cpuidle-arm64.c

diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
index 8deb934..c5029c1 100644
--- a/drivers/cpuidle/Kconfig
+++ b/drivers/cpuidle/Kconfig
@@ -33,6 +33,11 @@ depends on ARM
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
index 002b653..4d177b9 100644
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
index 0000000..50997ea
--- /dev/null
+++ b/drivers/cpuidle/cpuidle-arm64.c
@@ -0,0 +1,133 @@
+/*
+ * ARM64 generic CPU idle driver.
+ *
+ * Copyright (C) 2014 ARM Ltd.
+ * Author: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
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
+
+#include <asm/cpuidle.h>
+#include <asm/suspend.h>
+
+#include "dt_idle_states.h"
+
+/*
+ * arm64_enter_idle_state - Programs CPU to enter the specified state
+ *
+ * dev: cpuidle device
+ * drv: cpuidle driver
+ * idx: state index
+ *
+ * Called from the CPUidle framework to program the device to the
+ * specified target state selected by the governor.
+ */
+static int arm64_enter_idle_state(struct cpuidle_device *dev,
+=09=09=09=09  struct cpuidle_driver *drv, int idx)
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
+static struct cpuidle_driver arm64_idle_driver =3D {
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
+=09=09.enter                  =3D arm64_enter_idle_state,
+=09=09.exit_latency           =3D 1,
+=09=09.target_residency       =3D 1,
+=09=09.power_usage=09=09=3D UINT_MAX,
+=09=09.flags                  =3D CPUIDLE_FLAG_TIME_VALID,
+=09=09.name                   =3D "WFI",
+=09=09.desc                   =3D "ARM64 WFI",
+=09}
+};
+
+static const struct of_device_id arm64_idle_state_match[] __initconst =3D =
{
+=09{ .compatible =3D "arm,idle-state",
+=09  .data =3D arm64_enter_idle_state },
+=09{ },
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
+=09int cpu, ret;
+=09struct cpuidle_driver *drv =3D &arm64_idle_driver;
+
+=09/*
+=09 * Initialize idle states data, starting at index 1.
+=09 * This driver is DT only, if no DT idle states are detected (ret =3D=
=3D 0)
+=09 * let the driver initialization fail accordingly since there is no
+=09 * reason to initialize the idle driver if only wfi is supported.
+=09 */
+=09ret =3D dt_init_idle_driver(drv, arm64_idle_state_match, 1);
+=09if (ret <=3D 0) {
+=09=09if (ret)
+=09=09=09pr_err("failed to initialize idle states\n");
+=09=09return ret ? : -ENODEV;
+=09}
+
+=09/*
+=09 * Call arch CPU operations in order to initialize
+=09 * idle states suspend back-end specific data
+=09 */
+=09for_each_possible_cpu(cpu) {
+=09=09ret =3D cpu_init_idle(cpu);
+=09=09if (ret) {
+=09=09=09pr_err("CPU %d failed to init idle CPU ops\n", cpu);
+=09=09=09return ret;
+=09=09}
+=09}
+
+=09ret =3D cpuidle_register(drv, NULL);
+=09if (ret) {
+=09=09pr_err("failed to register cpuidle driver\n");
+=09=09return ret;
+=09}
+
+=09return 0;
+}
+device_initcall(arm64_idle_init);
--=20
1.9.1


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
