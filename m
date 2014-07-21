From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH v6 2/7] drivers: cpuidle: implement DT based idle states infrastructure
Date: Mon, 21 Jul 2014 17:06:21 +0100
Message-ID: <1405958786-17243-3-git-send-email-lorenzo.pieralisi@arm.com>
References: <1405958786-17243-1-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:41598 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932793AbaGUQGl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Jul 2014 12:06:41 -0400
In-Reply-To: <1405958786-17243-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: devicetree@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Charles Garcia Tobin <Charles.Garcia-Tobin@arm.com>, Nicolas Pitre <nico@linaro.org>, Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Stephen Boyd <sboyd@codeaurora.org>, Kevin Hilman <khilman@linaro.org>, Sebastian Capella <sebcape@gmail.com>, Tomasz Figa <t.figa@samsung.com>, Mark Brown <broonie@kernel.org>, Paul Walmsley <paul@pwsan.com>, Chander Kashyap <chander.kashyap@linaro.org>, Geoff

On most common ARM systems, the low-power states a CPU can be put into are
not discoverable in HW and require device tree bindings to describe
power down suspend operations and idle states parameters.

In order to enable DT based idle states and configure idle drivers, this
patch implements the bulk infrastructure required to parse the device tree
idle states bindings and initialize the corresponding CPUidle driver states
data.

The parsing API accepts a start index that defines the first idle state
that should be initialized by the parsing code in order to give new and
legacy driver flexibility over which states should be parsed using the
new DT mechanism.

The idle states list is obtained from the first cpu in the driver
cpumask, which implicitly means the parsing code expects idle states
(and related list of phandles) to be the same for all CPUs in the
CPUidle driver mask. The kernel does not check this assumption, it must
be enforced by the bootloader to ensure correct system behaviour.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 drivers/cpuidle/Kconfig          |   8 +++
 drivers/cpuidle/Makefile         |   1 +
 drivers/cpuidle/dt_idle_states.c | 138 +++++++++++++++++++++++++++++++++++=
++++
 drivers/cpuidle/dt_idle_states.h |   5 ++
 4 files changed, 152 insertions(+)
 create mode 100644 drivers/cpuidle/dt_idle_states.c
 create mode 100644 drivers/cpuidle/dt_idle_states.h

diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
index 1b96fb9..414e7a96 100644
--- a/drivers/cpuidle/Kconfig
+++ b/drivers/cpuidle/Kconfig
@@ -30,6 +30,14 @@ config CPU_IDLE_GOV_MENU
 =09bool "Menu governor (for tickless system)"
 =09default y
=20
+config DT_IDLE_STATES
+        bool "Idle states DT support"
+=09depends on ARM || ARM64
+=09help
+=09 Allows the CPU idle framework to initialize CPU idle drivers
+=09 state data by using DT provided nodes compliant with idle states
+=09 device tree bindings.
+
 menu "ARM CPU Idle Drivers"
 depends on ARM
 source "drivers/cpuidle/Kconfig.arm"
diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
index d8bb1ff..b27a062 100644
--- a/drivers/cpuidle/Makefile
+++ b/drivers/cpuidle/Makefile
@@ -4,6 +4,7 @@
=20
 obj-y +=3D cpuidle.o driver.o governor.o sysfs.o governors/
 obj-$(CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED) +=3D coupled.o
+obj-$(CONFIG_DT_IDLE_STATES)=09=09  +=3D dt_idle_states.o
=20
 ##########################################################################=
########
 # ARM SoC drivers
diff --git a/drivers/cpuidle/dt_idle_states.c b/drivers/cpuidle/dt_idle_sta=
tes.c
new file mode 100644
index 0000000..5413132
--- /dev/null
+++ b/drivers/cpuidle/dt_idle_states.c
@@ -0,0 +1,138 @@
+/*
+ * DT idle states parsing code.
+ *
+ * Copyright (C) 2014 ARM Ltd.
+ * Author: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#define pr_fmt(fmt) "DT idle-states: " fmt
+
+#include <linux/cpuidle.h>
+#include <linux/cpumask.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+
+#include "dt_idle_states.h"
+
+static int init_state_node(struct cpuidle_state *idle_state,
+=09=09=09   struct device_node *state_node)
+{
+=09int err;
+
+=09err =3D of_property_read_u32(state_node, "wakeup-latency-us",
+=09=09=09=09   &idle_state->exit_latency);
+=09if (err) {
+=09=09u32 entry_latency, exit_latency;
+
+=09=09err =3D of_property_read_u32(state_node, "entry-latency-us",
+=09=09=09=09=09   &entry_latency);
+=09=09if (err) {
+=09=09=09pr_debug(" * %s missing entry-latency-us property\n",
+=09=09=09=09 state_node->full_name);
+=09=09=09return -EINVAL;
+=09=09}
+
+=09=09err =3D of_property_read_u32(state_node, "exit-latency-us",
+=09=09=09=09=09   &exit_latency);
+=09=09if (err) {
+=09=09=09pr_debug(" * %s missing exit-latency-us property\n",
+=09=09=09=09 state_node->full_name);
+=09=09=09return -EINVAL;
+=09=09}
+=09=09/*
+=09=09 * If wakeup-latency-us is missing, default to entry+exit
+=09=09 * latencies as defined in idle states bindings
+=09=09 */
+=09=09idle_state->exit_latency =3D entry_latency + exit_latency;
+=09}
+
+=09err =3D of_property_read_u32(state_node, "min-residency-us",
+=09=09=09=09   &idle_state->target_residency);
+=09if (err) {
+=09=09pr_debug(" * %s missing min-residency-us property\n",
+=09=09=09     state_node->full_name);
+=09=09return -EINVAL;
+=09}
+
+=09idle_state->flags =3D CPUIDLE_FLAG_TIME_VALID;
+=09if (of_property_read_bool(state_node, "local-timer-stop"))
+=09=09idle_state->flags |=3D CPUIDLE_FLAG_TIMER_STOP;
+=09/*
+=09 * TODO:
+=09 *=09replace with kstrdup and pointer assignment when name
+=09 *=09and desc become string pointers
+=09 */
+=09strncpy(idle_state->name, state_node->name, CPUIDLE_NAME_LEN - 1);
+=09strncpy(idle_state->desc, state_node->name, CPUIDLE_DESC_LEN - 1);
+=09return 0;
+}
+
+/**
+ * dt_init_idle_driver() - Parse the DT idle states and initialize the
+ *=09=09=09   idle driver states array
+ *
+ * @drv:=09  Pointer to CPU idle driver to be initialized
+ * @start_idx:    First idle state index to be initialized
+ *
+ * On success the states array in the cpuidle driver contains
+ * initialized entries in the states array, starting from index start_idx.
+ *
+ * Return:
+ *=090 on success
+ *=09<0 on failure
+ */
+int dt_init_idle_driver(struct cpuidle_driver *drv, unsigned int start_idx=
)
+{
+=09unsigned int i, state_idx =3D start_idx;
+=09struct cpuidle_state *idle_state;
+=09struct device_node *state_node, *cpu_node;
+
+
+=09if (state_idx >=3D CPUIDLE_STATE_MAX)
+=09=09return -EINVAL;
+=09/*
+=09 * We get the idle states for the first logical cpu in the
+=09 * driver mask. The kernel does not check idle states on all
+=09 * cpus in the driver mask, they are assumed to be the same
+=09 * by default.
+=09 */
+=09cpu_node =3D of_cpu_device_node_get(cpumask_first(drv->cpumask));
+
+=09for (i =3D 0; ; i++) {
+=09=09int err;
+
+=09=09state_node =3D of_parse_phandle(cpu_node, "cpu-idle-states", i);
+=09=09if (!state_node)
+=09=09=09break;
+
+=09=09if (state_idx =3D=3D CPUIDLE_STATE_MAX) {
+=09=09=09pr_warn("State index reached static CPU idle driver states array =
size\n");
+=09=09=09break;
+=09=09}
+
+=09=09idle_state =3D &drv->states[state_idx++];
+=09=09err =3D init_state_node(idle_state, state_node);
+=09=09if (err)
+=09=09=09return err;
+=09}
+
+=09/*
+=09 * If no idle states are detected, return an error and let the idle
+=09 * driver initialization fail accordingly since initializing a driver
+=09 * with simple WFI as an idle state is equivalent to letting the
+=09 * kernel run the default idle loop.
+=09 */
+=09if (!i)
+=09=09return -ENODATA;
+
+=09drv->state_count =3D state_idx;
+=09return 0;
+}
+EXPORT_SYMBOL_GPL(dt_init_idle_driver);
diff --git a/drivers/cpuidle/dt_idle_states.h b/drivers/cpuidle/dt_idle_sta=
tes.h
new file mode 100644
index 0000000..728c37c
--- /dev/null
+++ b/drivers/cpuidle/dt_idle_states.h
@@ -0,0 +1,5 @@
+#ifndef __DT_IDLE_STATES
+#define __DT_IDLE_STATES
+
+int dt_init_idle_driver(struct cpuidle_driver *drv, unsigned int start_idx=
);
+#endif
--=20
1.9.1


