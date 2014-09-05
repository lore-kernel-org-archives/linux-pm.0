From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH v9 5/8] drivers: cpuidle: implement DT based idle states infrastructure
Date: Fri,  5 Sep 2014 18:34:54 +0100
Message-ID: <1409938498-17984-6-git-send-email-lorenzo.pieralisi@arm.com>
References: <1409938498-17984-1-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:54705 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754715AbaIERe6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 5 Sep 2014 13:34:58 -0400
In-Reply-To: <1409938498-17984-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: devicetree@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Charles Garcia Tobin <Charles.Garcia-Tobin@arm.com>, Nicolas Pitre <nico@linaro.org>, Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Stephen Boyd <sboyd@codeaurora.org>, Kevin Hilman <khilman@linaro.org>, Sebastian Capella <sebcape@gmail.com>, Mark Brown <broonie@kernel.org>, Paul Walmsley <paul@pwsan.com>, Chander Kashyap <k.chander@samsung.com>, Geoff

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

The idle states node(s) is obtained from the phandle list of the first cpu
in the driver cpumask;  the kernel checks that the idle state node phandle
is the same for all CPUs in the driver cpumask before declaring the idle st=
ate
as valid and start parsing its content.

The idle state enter function pointer is initialized through DT match
structures passed in by the CPUidle driver, so that ARM legacy code can
cope with platform specific idle entry method based on compatible
string matching and the code used to initialize the enter function pointer
can be moved to the DT generic layer.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 drivers/cpuidle/Kconfig          |   3 +
 drivers/cpuidle/Makefile         |   1 +
 drivers/cpuidle/dt_idle_states.c | 213 +++++++++++++++++++++++++++++++++++=
++++
 drivers/cpuidle/dt_idle_states.h |   7 ++
 4 files changed, 224 insertions(+)
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
index 0000000..52f4d11
--- /dev/null
+++ b/drivers/cpuidle/dt_idle_states.c
@@ -0,0 +1,213 @@
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
+=09=09=09   const struct of_device_id *matches,
+=09=09=09   struct device_node *state_node)
+{
+=09int err;
+=09const struct of_device_id *match_id;
+
+=09match_id =3D of_match_node(matches, state_node);
+=09if (!match_id)
+=09=09return -ENODEV;
+=09/*
+=09 * CPUidle drivers are expected to initialize the const void *data
+=09 * pointer of the passed in struct of_device_id array to the idle
+=09 * state enter function.
+=09 */
+=09idle_state->enter =3D match_id->data;
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
+/*
+ * Check that the idle state is uniform across all CPUs in the CPUidle dri=
ver
+ * cpumask
+ */
+static bool idle_state_valid(struct device_node *state_node, unsigned int =
idx,
+=09=09=09     const cpumask_t *cpumask)
+{
+=09int cpu;
+=09struct device_node *cpu_node, *curr_state_node;
+=09bool valid =3D true;
+
+=09/*
+=09 * Compare idle state phandles for index idx on all CPUs in the
+=09 * CPUidle driver cpumask. Start from next logical cpu following
+=09 * cpumask_first(cpumask) since that's the CPU state_node was
+=09 * retrieved from. If a mismatch is found bail out straight
+=09 * away since we certainly hit a firmware misconfiguration.
+=09 */
+=09for (cpu =3D cpumask_next(cpumask_first(cpumask), cpumask);
+=09     cpu < nr_cpu_ids; cpu =3D cpumask_next(cpu, cpumask)) {
+=09=09cpu_node =3D of_cpu_device_node_get(cpu);
+=09=09curr_state_node =3D of_parse_phandle(cpu_node, "cpu-idle-states",
+=09=09=09=09=09=09   idx);
+=09=09if (state_node !=3D curr_state_node)
+=09=09=09valid =3D false;
+
+=09=09of_node_put(curr_state_node);
+=09=09of_node_put(cpu_node);
+=09=09if (!valid)
+=09=09=09break;
+=09}
+
+=09return valid;
+}
+
+/**
+ * dt_init_idle_driver() - Parse the DT idle states and initialize the
+ *=09=09=09   idle driver states array
+ * @drv:=09  Pointer to CPU idle driver to be initialized
+ * @matches:=09  Array of of_device_id match structures to search in for
+ *=09=09  compatible idle state nodes. The data pointer for each valid
+ *=09=09  struct of_device_id entry in the matches array must point to
+ *=09=09  a function with the following signature, that corresponds to
+ *=09=09  the CPUidle state enter function signature:
+ *
+ *=09=09  int (*)(struct cpuidle_device *dev,
+ *=09=09=09  struct cpuidle_driver *drv,
+ *=09=09=09  int index);
+ *
+ * @start_idx:    First idle state index to be initialized
+ *
+ * If DT idle states are detected and are valid the state count and states
+ * array entries in the cpuidle driver are initialized accordingly startin=
g
+ * from index start_idx.
+ *
+ * Return: number of valid DT idle states parsed, <0 on failure
+ */
+int dt_init_idle_driver(struct cpuidle_driver *drv,
+=09=09=09const struct of_device_id *matches,
+=09=09=09unsigned int start_idx)
+{
+=09struct cpuidle_state *idle_state;
+=09struct device_node *state_node, *cpu_node;
+=09int i, err =3D 0;
+=09const cpumask_t *cpumask;
+=09unsigned int state_idx =3D start_idx;
+
+=09if (state_idx >=3D CPUIDLE_STATE_MAX)
+=09=09return -EINVAL;
+=09/*
+=09 * We get the idle states for the first logical cpu in the
+=09 * driver mask (or cpu_possible_mask if the driver cpumask is not set)
+=09 * and we check through idle_state_valid() if they are uniform
+=09 * across CPUs, otherwise we hit a firmware misconfiguration.
+=09 */
+=09cpumask =3D drv->cpumask ? : cpu_possible_mask;
+=09cpu_node =3D of_cpu_device_node_get(cpumask_first(cpumask));
+
+=09for (i =3D 0; ; i++) {
+=09=09state_node =3D of_parse_phandle(cpu_node, "cpu-idle-states", i);
+=09=09if (!state_node)
+=09=09=09break;
+
+=09=09if (!idle_state_valid(state_node, i, cpumask)) {
+=09=09=09pr_warn("%s idle state not valid, bailing out\n",
+=09=09=09=09state_node->full_name);
+=09=09=09err =3D -EINVAL;
+=09=09=09break;
+=09=09}
+
+=09=09if (state_idx =3D=3D CPUIDLE_STATE_MAX) {
+=09=09=09pr_warn("State index reached static CPU idle driver states array =
size\n");
+=09=09=09break;
+=09=09}
+
+=09=09idle_state =3D &drv->states[state_idx++];
+=09=09err =3D init_state_node(idle_state, matches, state_node);
+=09=09if (err) {
+=09=09=09pr_err("Parsing idle state node %s failed with err %d\n",
+=09=09=09       state_node->full_name, err);
+=09=09=09err =3D -EINVAL;
+=09=09=09break;
+=09=09}
+=09=09of_node_put(state_node);
+=09}
+
+=09of_node_put(state_node);
+=09of_node_put(cpu_node);
+=09if (err)
+=09=09return err;
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
index 0000000..4818134
--- /dev/null
+++ b/drivers/cpuidle/dt_idle_states.h
@@ -0,0 +1,7 @@
+#ifndef __DT_IDLE_STATES
+#define __DT_IDLE_STATES
+
+int dt_init_idle_driver(struct cpuidle_driver *drv,
+=09=09=09const struct of_device_id *matches,
+=09=09=09unsigned int start_idx);
+#endif
--=20
1.9.1


