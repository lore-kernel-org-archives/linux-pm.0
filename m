From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH v7 3/8] drivers: cpuidle: implement DT based idle states infrastructure
Date: Wed, 13 Aug 2014 16:52:02 +0100
Message-ID: <1407945127-27554-4-git-send-email-lorenzo.pieralisi@arm.com>
References: <1407945127-27554-1-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:37844 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753411AbaHMPwZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 13 Aug 2014 11:52:25 -0400
In-Reply-To: <1407945127-27554-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: devicetree@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Charles Garcia Tobin <Charles.Garcia-Tobin@arm.com>, Nicolas Pitre <nico@linaro.org>, Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Stephen Boyd <sboyd@codeaurora.org>, Kevin Hilman <khilman@linaro.org>, Sebastian Capella <sebcape@gmail.com>, Tomasz Figa <t.figa@samsung.com>, Mark Brown <broonie@kernel.org>, Paul Walmsley <paul@pwsan.com>, Chander Kashyap <k.chander@samsung.com>, Geoff

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
 drivers/cpuidle/Kconfig          |   3 +
 drivers/cpuidle/Makefile         |   1 +
 drivers/cpuidle/dt_idle_states.c | 140 +++++++++++++++++++++++++++++++++++=
++++
 drivers/cpuidle/dt_idle_states.h |   5 ++
 4 files changed, 149 insertions(+)
 create mode 100644 drivers/cpuidle/dt_idle_states.c
 create mode 100644 drivers/cpuidle/dt_idle_states.h

diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
index 32748c3..8deb934 100644
--- a/drivers/cpuidle/Kconfig
+++ b/drivers/cpuidle/Kconfig
@@ -25,6 +25,9 @@ config CPU_IDLE_GOV_MENU
 =09bool "Menu governor (for tickless system)"
 =09default y
=20
+config DT_IDLE_STATES
+=09bool
+
 menu "ARM CPU Idle Drivers"
 depends on ARM
 source "drivers/cpuidle/Kconfig.arm"
diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
index 11edb31..002b653 100644
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
index 0000000..207f8f7
--- /dev/null
+++ b/drivers/cpuidle/dt_idle_states.c
@@ -0,0 +1,140 @@
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
+ * @drv:=09  Pointer to CPU idle driver to be initialized
+ * @start_idx:    First idle state index to be initialized
+ *
+ * If DT idle states are detected and are valid the state count and states
+ * array entries in the cpuidle driver are initialized accordingly startin=
g
+ * from index start_idx.
+ *
+ * Return: number of valid DT idle states parsed, <0 on failure
+ */
+int dt_init_idle_driver(struct cpuidle_driver *drv, unsigned int start_idx=
)
+{
+=09struct cpuidle_state *idle_state;
+=09struct device_node *state_node, *cpu_node;
+=09int i;
+=09unsigned int state_idx =3D start_idx;
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
+=09=09if (err) {
+=09=09=09pr_err("Parsing idle state node %s failed with err %d\n",
+=09=09=09       state_node->full_name, err);
+=09=09=09return err;
+=09=09}
+=09}
+=09/*
+=09 * Update the driver state count only if some valid DT idle states
+=09 * were detected
+=09 */
+=09if (i)
+=09=09drv->state_count =3D state_idx;
+
+=09/*
+=09 * Return the number of present and valid DT idle states, which can
+=09 * also be 0 on platforms with missing DT idle states or legacy DT
+=09 * configuration predating the DT idle states bindings.
+=09 */
+=09return i;
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


