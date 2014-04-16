From: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH RFC v2 3/4] drivers: cpuidle: CPU idle ARM64 driver
Date: Wed, 16 Apr 2014 16:44:53 +0100
Message-ID: <1397663094-28027-4-git-send-email-lorenzo.pieralisi@arm.com>
References: <1397663094-28027-1-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1397663094-28027-1-git-send-email-lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Charles Garcia Tobin <Charles.Garcia-Tobin-5wv7dgnIgG8@public.gmane.org>, Nicolas Pitre <nico-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Amit Kucheria <amit.kucheria-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Antti Miettinen <ananaza-X3B1VOXEql0@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Capella <sebastian.capella-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Tomasz Figa <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

This patch implements a generic CPU idle driver for ARM64 machines.

It relies on the DT idle states infrastructure to initialize idle
states count and respective parameters. Current code assumes the driver
is managing idle states on all possible CPUs but can be easily
generalized to support heterogenous systems and build cpumasks at
runtime using MIDRs or DT cpu nodes compatible properties.

Suspend back-ends (eg PSCI) must register a suspend initializer with
the CPU idle driver so that the suspend backend call can be detected,
and the driver code can call the back-end infrastructure to complete the
suspend backend initialization.

Idle state index 0 is always initialized as a simple wfi state, ie always
considered present and functional on all ARM64 platforms.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
---
 drivers/cpuidle/Kconfig         |   5 ++
 drivers/cpuidle/Kconfig.arm64   |  13 ++++
 drivers/cpuidle/Makefile        |   4 +
 drivers/cpuidle/cpuidle-arm64.c | 159 ++++++++++++++++++++++++++++++++++++=
++++
 4 files changed, 181 insertions(+)
 create mode 100644 drivers/cpuidle/Kconfig.arm64
 create mode 100644 drivers/cpuidle/cpuidle-arm64.c

diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
index 995654e..0654eb5 100644
--- a/drivers/cpuidle/Kconfig
+++ b/drivers/cpuidle/Kconfig
@@ -44,6 +44,11 @@ depends on ARM
 source "drivers/cpuidle/Kconfig.arm"
 endmenu
=20
+menu "ARM64 CPU Idle Drivers"
+depends on ARM64
+source "drivers/cpuidle/Kconfig.arm64"
+endmenu
+
 menu "POWERPC CPU Idle Drivers"
 depends on PPC
 source "drivers/cpuidle/Kconfig.powerpc"
diff --git a/drivers/cpuidle/Kconfig.arm64 b/drivers/cpuidle/Kconfig.arm64
new file mode 100644
index 0000000..b83612c
--- /dev/null
+++ b/drivers/cpuidle/Kconfig.arm64
@@ -0,0 +1,13 @@
+#
+# ARM64 CPU Idle drivers
+#
+
+config ARM64_CPUIDLE
+=09bool "Generic ARM64 CPU idle Driver"
+=09select OF_IDLE_STATES
+=09help
+=09  Select this to enable generic cpuidle driver for ARM v8.
+=09  It provides a generic idle driver whose idle states are configured
+=09  at run-time through DT nodes. The CPUidle suspend backend is
+=09  initialized by the device tree parsing code on matching the entry
+=09  method to the respective CPU operations.
diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
index 2fc5139..161a5f2 100644
--- a/drivers/cpuidle/Makefile
+++ b/drivers/cpuidle/Makefile
@@ -16,6 +16,10 @@ obj-$(CONFIG_ARM_U8500_CPUIDLE)         +=3D cpuidle-ux5=
00.o
 obj-$(CONFIG_ARM_AT91_CPUIDLE)          +=3D cpuidle-at91.o
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
index 0000000..2cfde6c
--- /dev/null
+++ b/drivers/cpuidle/cpuidle-arm64.c
@@ -0,0 +1,159 @@
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
+#include <linux/cpuidle.h>
+#include <linux/cpumask.h>
+#include <linux/cpu_pm.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+
+#include <asm/psci.h>
+#include <asm/suspend.h>
+
+#include "of_idle_states.h"
+
+typedef int (*suspend_init_fn)(struct cpuidle_driver *,
+=09=09=09       struct device_node *[]);
+
+struct cpu_suspend_ops {
+=09const char *id;
+=09suspend_init_fn init_fn;
+};
+
+static const struct cpu_suspend_ops suspend_operations[] __initconst =3D {
+=09{"arm,psci", psci_dt_register_idle_states},
+=09{}
+};
+
+static __init const struct cpu_suspend_ops *get_suspend_ops(const char *st=
r)
+{
+=09int i;
+
+=09if (!str)
+=09=09return NULL;
+
+=09for (i =3D 0; suspend_operations[i].id; i++)
+=09=09if (!strcmp(suspend_operations[i].id, str))
+=09=09=09return &suspend_operations[i];
+
+=09return NULL;
+}
+
+/*
+ * arm_enter_idle_state - Programs CPU to enter the specified state
+ *
+ * @dev: cpuidle device
+ * @drv: cpuidle driver
+ * @idx: state index
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
+=09cpu_pm_enter();
+=09/*
+=09 * Pass idle state index to cpu_suspend which in turn will call
+=09 * the CPU ops suspend protocol with idle index as a parameter.
+=09 *
+=09 * Some states would not require context to be saved and flushed
+=09 * to DRAM, so calling cpu_suspend would not be stricly necessary.
+=09 * When power domains specifications for ARM CPUs are finalized then
+=09 * this code can be optimized to prevent saving registers if not
+=09 * needed.
+=09 */
+=09ret =3D cpu_suspend(idx);
+
+=09cpu_pm_exit();
+
+=09return ret ? -1 : idx;
+}
+
+struct cpuidle_driver arm64_idle_driver =3D {
+=09.name =3D "arm64_idle",
+=09.owner =3D THIS_MODULE,
+};
+
+static struct device_node *state_nodes[CPUIDLE_STATE_MAX] __initdata;
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
+=09const char *entry_method;
+=09struct device_node *idle_states_node;
+=09const struct cpu_suspend_ops *suspend_init;
+=09struct cpuidle_driver *drv =3D &arm64_idle_driver;
+
+=09idle_states_node =3D of_find_node_by_path("/cpus/idle-states");
+=09if (!idle_states_node)
+=09=09return -ENOENT;
+
+=09if (of_property_read_string(idle_states_node, "entry-method",
+=09=09=09=09    &entry_method)) {
+=09=09pr_warn(" * %s missing entry-method property\n",
+=09=09=09    idle_states_node->full_name);
+=09=09of_node_put(idle_states_node);
+=09=09return -EOPNOTSUPP;
+=09}
+
+=09suspend_init =3D get_suspend_ops(entry_method);
+=09if (!suspend_init) {
+=09=09pr_warn("Missing suspend initializer\n");
+=09=09of_node_put(idle_states_node);
+=09=09return -EOPNOTSUPP;
+=09}
+
+=09/*
+=09 * State at index 0 is standby wfi and considered standard
+=09 * on all ARM platforms. If in some platforms simple wfi
+=09 * can't be used as "state 0", DT bindings must be implemented
+=09 * to work around this issue and allow installing a special
+=09 * handler for idle state index 0.
+=09 */
+=09drv->states[0].exit_latency =3D 1;
+=09drv->states[0].target_residency =3D 1;
+=09drv->states[0].flags =3D CPUIDLE_FLAG_TIME_VALID;
+=09strncpy(drv->states[0].name, "ARM WFI", CPUIDLE_NAME_LEN);
+=09strncpy(drv->states[0].desc, "ARM WFI", CPUIDLE_DESC_LEN);
+
+=09drv->cpumask =3D (struct cpumask *) cpu_possible_mask;
+=09/*
+=09 * Start at index 1, request idle state nodes to be filled
+=09 */
+=09ret =3D of_init_idle_driver(drv, state_nodes, 1, true);
+=09if (ret)
+=09=09return ret;
+
+=09if (suspend_init->init_fn(drv, state_nodes))
+=09=09return -EOPNOTSUPP;
+
+=09for (i =3D 0; i < drv->state_count; i++)
+=09=09drv->states[i].enter =3D arm_enter_idle_state;
+
+=09return cpuidle_register(drv, NULL);
+}
+device_initcall(arm64_idle_init);
--=20
1.8.4


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
