From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH v4 3/6] drivers: cpuidle: implement OF based idle states infrastructure
Date: Wed, 11 Jun 2014 17:18:37 +0100
Message-ID: <1402503520-8611-4-git-send-email-lorenzo.pieralisi@arm.com>
References: <1402503520-8611-1-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:55346 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755866AbaFKQSk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 11 Jun 2014 12:18:40 -0400
In-Reply-To: <1402503520-8611-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Charles Garcia Tobin <Charles.Garcia-Tobin@arm.com>, Nicolas Pitre <nico@linaro.org>, Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Stephen Boyd <sboyd@codeaurora.org>, Kevin Hilman <khilman@linaro.org>, Sebastian Capella <sebcape@gmail.com>, Tomasz Figa <t.figa@samsung.com>, Mark Brown <broonie@kernel.org>, Paul Walmsley <paul@pwsan.com>, Chander Kashyap <chander.kashyap@linaro.org>

On most common ARM systems, the low-power states a CPU can be put into are
not discoverable in HW and require device tree bindings to describe
power down suspend operations and idle states parameters.

In order to enable DT based idle states and configure idle drivers, this
patch implements the bulk infrastructure required to parse the device tree
idle states bindings and initialize the corresponding CPUidle driver states
data.

Code that initializes idle states checks the CPU idle driver cpumask so
that multiple CPU idle drivers can be initialized through it in the
kernel. The CPU idle driver cpumask defines which idle states should be
considered valid for the driver, ie idle states that are valid on a set
of cpus the idle driver manages.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 drivers/cpuidle/Kconfig          |   9 ++
 drivers/cpuidle/Makefile         |   1 +
 drivers/cpuidle/of_idle_states.c | 282 +++++++++++++++++++++++++++++++++++=
++++
 drivers/cpuidle/of_idle_states.h |   8 ++
 4 files changed, 300 insertions(+)
 create mode 100644 drivers/cpuidle/of_idle_states.c
 create mode 100644 drivers/cpuidle/of_idle_states.h

diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
index 1b96fb9..760ce20 100644
--- a/drivers/cpuidle/Kconfig
+++ b/drivers/cpuidle/Kconfig
@@ -30,6 +30,15 @@ config CPU_IDLE_GOV_MENU
 =09bool "Menu governor (for tickless system)"
 =09default y
=20
+config OF_IDLE_STATES
+        bool "Idle states DT support"
+=09depends on ARM || ARM64
+=09default n
+=09help
+=09 Allows the CPU idle framework to initialize CPU idle drivers
+=09 state data by using DT provided nodes compliant with idle states
+=09 device tree bindings.
+
 menu "ARM CPU Idle Drivers"
 depends on ARM
 source "drivers/cpuidle/Kconfig.arm"
diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
index d8bb1ff..d5ebf4b 100644
--- a/drivers/cpuidle/Makefile
+++ b/drivers/cpuidle/Makefile
@@ -4,6 +4,7 @@
=20
 obj-y +=3D cpuidle.o driver.o governor.o sysfs.o governors/
 obj-$(CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED) +=3D coupled.o
+obj-$(CONFIG_OF_IDLE_STATES)=09=09  +=3D of_idle_states.o
=20
 ##########################################################################=
########
 # ARM SoC drivers
diff --git a/drivers/cpuidle/of_idle_states.c b/drivers/cpuidle/of_idle_sta=
tes.c
new file mode 100644
index 0000000..acdbf45
--- /dev/null
+++ b/drivers/cpuidle/of_idle_states.c
@@ -0,0 +1,282 @@
+/*
+ * OF idle states parsing code.
+ *
+ * Copyright (C) 2014 ARM Ltd.
+ * Author: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#define pr_fmt(fmt) "OF idle-states: " fmt
+
+#include <linux/cpuidle.h>
+#include <linux/cpumask.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/list_sort.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/slab.h>
+
+#include "of_idle_states.h"
+
+struct state_elem {
+=09struct list_head list;
+=09struct device_node *node;
+=09u32 val;
+};
+
+static struct list_head head __initdata =3D LIST_HEAD_INIT(head);
+
+static bool __init state_cpu_valid(struct device_node *state_node,
+=09=09=09=09   struct device_node *cpu_node)
+{
+=09int i =3D 0;
+=09struct device_node *cpu_state;
+
+=09while ((cpu_state =3D of_parse_phandle(cpu_node,
+=09=09=09=09=09     "cpu-idle-states", i++))) {
+=09=09if (cpu_state && state_node =3D=3D cpu_state) {
+=09=09=09of_node_put(cpu_state);
+=09=09=09return true;
+=09=09}
+=09=09of_node_put(cpu_state);
+=09}
+=09return false;
+}
+
+static bool __init state_cpus_valid(const cpumask_t *cpus,
+=09=09=09=09    struct device_node *state_node)
+{
+=09int cpu;
+=09struct device_node *cpu_node;
+
+=09/*
+=09 * Check if state is valid on driver cpumask cpus
+=09 */
+=09for_each_cpu(cpu, cpus) {
+=09=09cpu_node =3D of_get_cpu_node(cpu, NULL);
+
+=09=09if (!cpu_node) {
+=09=09=09pr_err("Missing device node for CPU %d\n", cpu);
+=09=09=09return false;
+=09=09}
+
+=09=09if (!state_cpu_valid(state_node, cpu_node))
+=09=09=09return false;
+=09}
+
+=09return true;
+}
+
+static int __init state_cmp(void *priv, struct list_head *a,
+=09=09=09    struct list_head *b)
+{
+=09struct state_elem *ela, *elb;
+
+=09ela =3D container_of(a, struct state_elem, list);
+=09elb =3D container_of(b, struct state_elem, list);
+
+=09return ela->val - elb->val;
+}
+
+static int __init add_state_node(cpumask_t *cpumask,
+=09=09=09=09 struct device_node *state_node)
+{
+=09struct state_elem *el;
+=09u32 val;
+
+=09pr_debug(" * %s...\n", state_node->full_name);
+
+=09if (!state_cpus_valid(cpumask, state_node))
+=09=09return -EINVAL;
+=09/*
+=09 * Parse just the property required to sort the states.
+=09 * Since we are missing a value defining the energy
+=09 * efficiency of a state, for now the sorting code uses
+=09 *
+=09 * exit-latency-us
+=09 *
+=09 * as sorting rank.
+=09 */
+=09if (of_property_read_u32(state_node, "exit-latency-us",
+=09=09=09=09 &val)) {
+=09=09pr_debug(" * %s missing exit-latency-us property\n",
+=09=09=09     state_node->full_name);
+=09=09return -EINVAL;
+=09}
+
+=09el =3D kmalloc(sizeof(*el), GFP_KERNEL);
+=09if (!el) {
+=09=09pr_err("%s failed to allocate memory\n", __func__);
+=09=09return -ENOMEM;
+=09}
+
+=09el->node =3D state_node;
+=09el->val =3D val;
+=09list_add_tail(&el->list, &head);
+
+=09return 0;
+}
+
+static void __init init_state_node(struct cpuidle_driver *drv,
+=09=09=09=09   struct device_node *state_node,
+=09=09=09=09   int *cnt)
+{
+=09struct cpuidle_state *idle_state;
+
+=09pr_debug(" * %s...\n", state_node->full_name);
+
+=09idle_state =3D &drv->states[*cnt];
+
+=09if (of_property_read_u32(state_node, "exit-latency-us",
+=09=09=09=09 &idle_state->exit_latency)) {
+=09=09pr_debug(" * %s missing exit-latency-us property\n",
+=09=09=09     state_node->full_name);
+=09=09return;
+=09}
+
+=09if (of_property_read_u32(state_node, "min-residency-us",
+=09=09=09=09 &idle_state->target_residency)) {
+=09=09pr_debug(" * %s missing min-residency-us property\n",
+=09=09=09     state_node->full_name);
+=09=09return;
+=09}
+=09/*
+=09 * It is unknown to the idle driver if and when the tick_device
+=09 * loses context when the CPU enters the idle states. To solve
+=09 * this issue the tick device must be linked to a power domain
+=09 * so that the idle driver can check on which states the device
+=09 * loses its context. Current code takes the conservative choice
+=09 * of defining the idle state as one where the tick device always
+=09 * loses its context. On platforms where tick device never loses
+=09 * its context (ie it is not a C3STOP device) this turns into
+=09 * a nop. On platforms where the tick device does lose context in some
+=09 * states, this code can be optimized, when power domain specifications
+=09 * for ARM CPUs are finalized.
+=09 */
+=09idle_state->flags =3D CPUIDLE_FLAG_TIME_VALID | CPUIDLE_FLAG_TIMER_STOP=
;
+
+=09strncpy(idle_state->name, state_node->name, CPUIDLE_NAME_LEN);
+=09strncpy(idle_state->desc, state_node->name, CPUIDLE_NAME_LEN);
+
+=09(*cnt)++;
+}
+
+static int __init init_idle_states(struct cpuidle_driver *drv,
+=09=09=09=09   struct device_node *state_nodes[],
+=09=09=09=09   unsigned int start_idx, bool init_nodes)
+{
+=09struct state_elem *el;
+=09struct list_head *curr, *tmp;
+=09unsigned int cnt =3D start_idx;
+
+=09list_for_each_entry(el, &head, list) {
+=09=09/*
+=09=09 * Check if the init function has to fill the
+=09=09 * state_nodes array on behalf of the CPUidle driver.
+=09=09 */
+=09=09if (init_nodes)
+=09=09=09state_nodes[cnt] =3D el->node;
+=09=09/*
+=09=09 * cnt is updated on return if a state was added.
+=09=09 */
+=09=09init_state_node(drv, el->node, &cnt);
+
+=09=09if (cnt =3D=3D CPUIDLE_STATE_MAX) {
+=09=09=09pr_warn("State index reached static CPU idle state limit\n");
+=09=09=09break;
+=09=09}
+=09}
+
+=09drv->state_count =3D cnt;
+
+=09list_for_each_safe(curr, tmp, &head) {
+=09=09list_del(curr);
+=09=09kfree(container_of(curr, struct state_elem, list));
+=09}
+
+=09/*
+=09 * If no idle states are detected, return an error and let the idle
+=09 * driver initialization fail accordingly.
+=09 */
+=09return (cnt > start_idx) ? 0 : -ENODATA;
+}
+
+static void __init add_idle_states(struct cpuidle_driver *drv,
+=09=09=09=09   struct device_node *idle_states)
+{
+=09struct device_node *state_node;
+
+=09for_each_child_of_node(idle_states, state_node) {
+=09=09if ((!of_device_is_compatible(state_node, "arm,idle-state"))) {
+=09=09=09pr_warn(" * %s: children of /cpus/idle-states must be \"arm,idle-=
state\" compatible\n",
+=09=09=09=09     state_node->full_name);
+=09=09=09continue;
+=09=09}
+=09=09/*
+=09=09 * If memory allocation fails, better bail out.
+=09=09 * Initialized nodes are freed at initialization
+=09=09 * completion in of_init_idle_driver().
+=09=09 */
+=09=09if ((add_state_node(drv->cpumask, state_node) =3D=3D -ENOMEM))
+=09=09=09break;
+=09}
+=09/*
+=09 * Sort the states list before initializing the CPUidle driver
+=09 * states array.
+=09 */
+=09list_sort(NULL, &head, state_cmp);
+}
+
+/**
+ * of_init_idle_driver() - Parse the DT idle states and initialize the
+ *=09=09=09   idle driver states array
+ *
+ * @drv:=09  Pointer to CPU idle driver to be initialized
+ * @state_nodes:  Array of struct device_nodes to be initialized if
+ *=09=09  init_nodes =3D=3D true. Must be sized CPUIDLE_STATE_MAX
+ * @start_idx:    First idle state index to be initialized
+ * @init_nodes:   Boolean to request device nodes initialization
+ *
+ * On success the states array in the cpuidle driver contains
+ * initialized entries in the states array, starting from index start_idx.
+ * If init_nodes =3D=3D true, on success the state_nodes array is initiali=
zed
+ * with idle state DT node pointers, starting from index start_idx,
+ * in a 1:1 relation with the idle driver states array.
+ *
+ * Return:
+ *=090 on success
+ *=09<0 on failure
+ */
+int __init of_init_idle_driver(struct cpuidle_driver *drv,
+=09=09=09       struct device_node *state_nodes[],
+=09=09=09       unsigned int start_idx, bool init_nodes)
+{
+=09struct device_node *idle_states_node;
+=09int ret;
+
+=09if (start_idx >=3D CPUIDLE_STATE_MAX) {
+=09=09pr_warn("State index exceeds static CPU idle driver states array siz=
e\n");
+=09=09return -EINVAL;
+=09}
+
+=09if (WARN(init_nodes && !state_nodes,
+=09=09"Requested nodes stashing in an invalid nodes container\n"))
+=09=09return -EINVAL;
+
+=09idle_states_node =3D of_find_node_by_path("/cpus/idle-states");
+=09if (!idle_states_node)
+=09=09return -ENOENT;
+
+=09add_idle_states(drv, idle_states_node);
+
+=09ret =3D init_idle_states(drv, state_nodes, start_idx, init_nodes);
+
+=09of_node_put(idle_states_node);
+
+=09return ret;
+}
diff --git a/drivers/cpuidle/of_idle_states.h b/drivers/cpuidle/of_idle_sta=
tes.h
new file mode 100644
index 0000000..049f94f
--- /dev/null
+++ b/drivers/cpuidle/of_idle_states.h
@@ -0,0 +1,8 @@
+#ifndef __OF_IDLE_STATES
+#define __OF_IDLE_STATES
+
+int __init of_init_idle_driver(struct cpuidle_driver *drv,
+=09=09=09       struct device_node *state_nodes[],
+=09=09=09       unsigned int start_idx,
+=09=09=09       bool init_nodes);
+#endif
--=20
1.8.4


