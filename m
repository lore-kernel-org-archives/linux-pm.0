From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH RFC 1/4] arm64: kernel: implement DT based idle states infrastructure
Date: Tue, 18 Mar 2014 10:20:25 +0000
Message-ID: <1395138028-19630-2-git-send-email-lorenzo.pieralisi@arm.com>
References: <1395138028-19630-1-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:54082 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753780AbaCRKTN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 18 Mar 2014 06:19:13 -0400
In-Reply-To: <1395138028-19630-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Charles Garcia Tobin <Charles.Garcia-Tobin@arm.com>, Nicolas Pitre <nico@linaro.org>, Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Stephen Boyd <sboyd@codeaurora.org>, Kevin Hilman <khilman@linaro.org>, Sebastian Capella <sebastian.capella@linaro.org>, Tomasz Figa <t.figa@samsung.com>

On most common ARM systems, the low-power states a CPU can be put into are
not discoverable in HW and require device tree bindings to describe
the respective power domains, power down protocol and idle states parameter=
s.

In order to enable DT based idle states and configure idle drivers, this
patch implements the bulk infrastructure required to parse the device tree
idle states bindings and functions to initizialize idle driver and protocol
back-ends.

Protocol back-ends (eg PSCI) must register a protocol initializer with
the idle state parser so that upon protocol detection, the parsing code
can call the back-end infrastructure to complete the idle driver
initialization.

Idle state index 0 is always initialized, ie always considered present
on all ARM platforms.

Code that initializes idle states checks the CPU idle driver cpumask so
that multiple CPU idle drivers can be initialized through it in the
kernel. The CPU idle driver cpumask defines which idle states should be
considered valid for the driver, ie idle states that are valid on a set
of cpus the idle driver manages.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm64/Kconfig                   |   4 +
 arch/arm64/include/asm/idle_states.h |  20 ++
 arch/arm64/kernel/Makefile           |   1 +
 arch/arm64/kernel/idle_states.c      | 397 +++++++++++++++++++++++++++++++=
++++
 4 files changed, 422 insertions(+)
 create mode 100644 arch/arm64/include/asm/idle_states.h
 create mode 100644 arch/arm64/kernel/idle_states.c

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 27bbcfc..3132572 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -295,6 +295,10 @@ config ARCH_SUSPEND_POSSIBLE
 config ARM64_CPU_SUSPEND
 =09def_bool PM_SLEEP
=20
+config ARM64_IDLE_STATES
+=09def_bool CPU_IDLE
+=09select ARM64_CPU_SUSPEND
+
 endmenu
=20
 menu "CPU Power Management"
diff --git a/arch/arm64/include/asm/idle_states.h b/arch/arm64/include/asm/=
idle_states.h
new file mode 100644
index 0000000..0b9f9ba
--- /dev/null
+++ b/arch/arm64/include/asm/idle_states.h
@@ -0,0 +1,20 @@
+#ifndef __ARM64_IDLE_STATES
+#define __ARM64_IDLE_STATES
+
+struct idle_state {
+=09u32=09index;
+=09u32=09entry_latency;
+=09u32=09exit_latency;
+=09u32=09min_residency;
+=09u32=09param;
+=09struct device_node *node;
+=09struct idle_state *state;
+=09cpumask_t=09cpus;
+=09bool=09logic_state_retained;
+=09bool=09cache_state_retained;
+};
+
+struct cpuidle_driver;
+
+int __init arm_init_idle_driver(struct cpuidle_driver *drv);
+#endif
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 2d4554b..2afc9a0 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -19,6 +19,7 @@ arm64-obj-$(CONFIG_HW_PERF_EVENTS)=09+=3D perf_event.o
 arm64-obj-$(CONFIG_HAVE_HW_BREAKPOINT)+=3D hw_breakpoint.o
 arm64-obj-$(CONFIG_EARLY_PRINTK)=09+=3D early_printk.o
 arm64-obj-$(CONFIG_ARM64_CPU_SUSPEND)=09+=3D sleep.o suspend.o
+arm64-obj-$(CONFIG_ARM64_IDLE_STATES)=09+=3D idle_states.o
 arm64-obj-$(CONFIG_JUMP_LABEL)=09=09+=3D jump_label.o
=20
 obj-y=09=09=09=09=09+=3D $(arm64-obj-y) vdso/
diff --git a/arch/arm64/kernel/idle_states.c b/arch/arm64/kernel/idle_state=
s.c
new file mode 100644
index 0000000..0386cff
--- /dev/null
+++ b/arch/arm64/kernel/idle_states.c
@@ -0,0 +1,397 @@
+/*
+ * ARM device tree idle states parsing code.
+ *
+ * Copyright (C) 2014 ARM Ltd.
+ * Author: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/cpuidle.h>
+#include <linux/cpumask.h>
+#include <linux/cpu_pm.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+
+#include <asm/idle_states.h>
+#include <asm/psci.h>
+#include <asm/suspend.h>
+
+static struct idle_state idle_states[CPUIDLE_STATE_MAX] __initdata;
+typedef int (*idle_states_initializer)(struct cpumask *, struct idle_state=
 *,
+=09=09=09=09       unsigned int);
+
+struct protocol_init {
+=09const char *prot;
+=09idle_states_initializer prot_init;
+};
+
+static const struct protocol_init protocols[] __initconst =3D {
+=09{}
+};
+
+static __init const struct protocol_init *get_protocol(const char *str)
+{
+=09int i;
+
+=09if (!str)
+=09=09return NULL;
+
+=09for (i =3D 0; protocols[i].prot; i++)
+=09=09if (!strcmp(protocols[i].prot, str))
+=09=09=09return &protocols[i];
+
+=09return NULL;
+}
+
+static void __init idle_state_cpu_mask(int cpu, struct idle_state *idle_st=
ate,
+=09=09=09=09       struct device_node *cn)
+{
+=09int i =3D 0;
+=09struct device_node *cpu_state;
+
+=09do {
+=09=09cpu_state =3D of_parse_phandle(cn, "cpu-idle-states", i++);
+=09=09if (cpu_state && idle_state->node =3D=3D cpu_state)
+=09=09=09cpumask_set_cpu(cpu, &idle_state->cpus);
+=09=09of_node_put(cpu_state);
+=09} while (cpu_state);
+}
+
+static int __init parse_idle_states_node(struct device_node *parent, int c=
nt,
+=09=09=09=09=09 const cpumask_t *cpus)
+{
+=09struct device_node *state;
+=09struct idle_state *idle_state;
+=09int cpu;
+
+=09for_each_child_of_node(parent, state) {
+
+=09=09if (!of_device_is_compatible(state, "arm,idle-state")) {
+=09=09=09pr_warn(" %s has child nodes that are not idle states\n",
+=09=09=09=09parent->full_name);
+=09=09=09continue;
+=09=09}
+
+=09=09idle_state =3D &idle_states[cnt];
+
+=09=09pr_debug(" * %s...\n", state->full_name);
+
+=09=09idle_state->node =3D state;
+=09=09/*
+=09=09 * Check cpus on which the idle state is valid
+=09=09 */
+=09=09for_each_possible_cpu(cpu) {
+=09=09=09struct device_node *cn;
+
+=09=09=09cn =3D of_get_cpu_node(cpu, NULL);
+=09=09=09if (!cn) {
+=09=09=09=09pr_err("missing device node for CPU %d\n", cpu);
+=09=09=09=09continue;
+=09=09=09}
+=09=09=09idle_state_cpu_mask(cpu, idle_state, cn);
+=09=09}
+
+=09=09/*
+=09=09 * The driver cpumask is not a subset of cpus on which the
+=09=09 * idle state is valid, hence the idle state is skipped for
+=09=09 * this driver.
+=09=09 */
+=09=09if (!cpumask_subset(cpus, &idle_state->cpus))
+=09=09=09continue;
+
+=09=09if (of_property_read_u32(state, "index", &idle_state->index)) {
+=09=09=09pr_debug(" * %s missing index property\n",
+=09=09=09=09     state->full_name);
+=09=09=09continue;
+=09=09}
+
+=09=09if (of_property_read_u32(state, "entry-latency-us",
+=09=09=09=09=09 &idle_state->entry_latency)) {
+=09=09=09pr_debug(" * %s missing entry latency property\n",
+=09=09=09=09     state->full_name);
+=09=09=09continue;
+=09=09}
+
+=09=09if (of_property_read_u32(state, "exit-latency-us",
+=09=09=09=09=09 &idle_state->exit_latency)) {
+=09=09=09pr_debug(" * %s missing exit latency property\n",
+=09=09=09=09     state->full_name);
+=09=09=09continue;
+=09=09}
+
+=09=09if (of_property_read_u32(state, "min-residency-us",
+=09=09=09=09=09 &idle_state->min_residency)) {
+=09=09=09pr_debug(" * %s missing min-residency property\n",
+=09=09=09=09     state->full_name);
+=09=09=09continue;
+=09=09}
+
+=09=09if (of_property_read_u32(state, "entry-method-param",
+=09=09=09=09=09 &idle_state->param)) {
+=09=09=09pr_debug(" * %s missing entry-method-param property\n",
+=09=09=09=09     state->full_name);
+=09=09=09continue;
+=09=09}
+
+=09=09if (++cnt =3D=3D CPUIDLE_STATE_MAX) {
+=09=09=09pr_warn("Number of parsed states equal static CPU idle state limi=
t\n");
+=09=09=09of_node_put(state);
+=09=09=09break;
+=09=09}
+=09}
+
+=09return cnt;
+}
+
+static int __init parse_idle_states(struct device_node *root, int cnt,
+=09=09=09=09    const cpumask_t *cpus)
+{
+=09int head_idx, curr_idx;
+=09struct device_node *curr =3D root;
+
+=09/*
+=09 * Breadth-first DT idle states parsing
+=09 *
+=09 * Sweep idle states level in the device tree and use the
+=09 * idle_states array to stash the visited nodes, as a queue.
+=09 *
+=09 * parse_idle_states_node() updates the idle_states array by
+=09 * initializing entries, stashing the device tree node for the
+=09 * corresponding state (struct idle_state.node) and incrementing
+=09 * the idle states counter that is returned so that curr_idx is
+=09 * kept up-to-date while descending into tree levels.
+=09 *
+=09 * Store the initial counter head_idx and curr_idx and use head_idx
+=09 * as a queue of node indices to be visited.
+=09 *
+=09 * When we reach the max number of CPU idle states or
+=09 * head_idx =3D=3D curr_idx (empty nodes queue) we are done.
+=09 */
+=09head_idx =3D curr_idx =3D cnt;
+
+=09do {
+=09=09curr_idx =3D parse_idle_states_node(curr, curr_idx, cpus);
+=09=09if (curr_idx =3D=3D CPUIDLE_STATE_MAX || head_idx =3D=3D curr_idx)
+=09=09=09break;
+=09=09/*
+=09=09 * idle_states array is updated by parse_idle_states_node(),
+=09=09 * we can use the initialized states as a queue of nodes
+=09=09 * that need to be checked for their idle states siblings.
+=09=09 * head_idx works as a pointer into the queue to get the
+=09=09 * next node to be parsed.
+=09=09 */
+=09=09curr =3D idle_states[head_idx++].node;
+=09} while (curr);
+
+=09return curr_idx;
+}
+
+/*
+ * Sort states according to their index value, higher indexes
+ * imply higher power savings, as expected by the CPU idle subsystem.
+ */
+static void __init sort_states(int count)
+{
+=09int i, j;
+=09struct idle_state *idle_state;
+
+=09/*
+=09 * move pointers instead of entries
+=09 */
+=09for (i =3D 0; i < count; i++)
+=09=09idle_states[i].state =3D &idle_states[i];
+
+=09/*
+=09 * Selection sort is acceptable here, since the
+=09 * number of states is small (<=3DCPUIDLE_STATE_MAX)
+=09 *
+=09 * Index starts from 1, we know index 0 is standby wfi and
+=09 * it is always the idle state with higher power consumption
+=09 */
+=09for (i =3D 1; i < count - 1; i++) {
+=09=09u32 elem =3D i;
+=09=09for (j =3D i+1; j < count; j++) {
+=09=09=09if (idle_states[j].state->index <
+=09=09=09=09=09idle_states[elem].state->index)
+=09=09=09=09elem =3D j;
+=09=09}
+=09=09if (i !=3D elem) {
+=09=09=09idle_state =3D idle_states[i].state;
+=09=09=09idle_states[i].state =3D idle_states[elem].state;
+=09=09=09idle_states[elem].state =3D idle_state;
+=09=09}
+=09}
+}
+
+/*
+ * arm_dt_init_idle_states - Parse DT idle states and initialize the proto=
col
+ *=09=09=09     back-end
+ *
+ * @prot: pointer to the protocol initializer. Initialized only if return =
code
+ *        is >0
+ * @cpus: CPU idle driver cpumask
+ *
+ * Returns:
+ *=09Number of idle states detected upon success
+ *=09<0 on failure
+ */
+static int __init arm_dt_init_idle_states(const struct protocol_init **pro=
t,
+=09=09=09=09=09  const cpumask_t *cpus)
+{
+=09struct device_node *cpups;
+=09const char *entry_method;
+=09/* start from 1, stanbywfi is always there */
+=09int cnt =3D 1, ret =3D 0;
+
+=09if (!prot)
+=09=09return -EINVAL;
+
+=09cpups =3D of_find_node_by_path("/cpus/idle-states");
+
+=09if (!cpups)
+=09=09return -ENODEV;
+
+=09cnt =3D parse_idle_states(cpups, cnt, cpus);
+
+=09if (cnt =3D=3D 1) {
+=09=09ret =3D -ENODATA;
+=09=09goto put_node;
+=09}
+
+=09/*
+=09 * idle driver expects states to sorted in terms of power
+=09 * consumption
+=09 */
+=09sort_states(cnt);
+
+=09if (of_property_read_string(cpups, "entry-method", &entry_method)) {
+=09=09pr_warn(" * %s missing entry_method property\n",
+=09=09=09    cpups->full_name);
+=09=09ret =3D -EOPNOTSUPP;
+=09=09goto put_node;
+=09}
+
+=09*prot =3D get_protocol(entry_method);
+=09if (!*prot) {
+=09=09pr_warn("Missing protocol initializer\n");
+=09=09ret =3D -EOPNOTSUPP;
+=09=09goto put_node;
+=09}
+
+=09pr_debug("detected %u idle states\n", cnt);
+
+put_node:
+=09of_node_put(cpups);
+=09return ret ? : cnt;
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
+=09=09/*
+=09=09 * idle index 0 is just standby wfi, does not require CPU
+=09=09 * to be suspended
+=09=09 */
+=09=09cpu_do_idle();
+=09=09return idx;
+=09}
+
+=09cpu_pm_enter();
+=09/*
+=09 * Pass idle state index to cpu_suspend which in turn will call
+=09 * the CPU ops suspend protocol with idle index as a parameter
+=09 */
+=09ret =3D cpu_suspend(idx);
+
+=09cpu_pm_exit();
+
+=09return ret ? : idx;
+}
+
+int __init arm_init_idle_driver(struct cpuidle_driver *drv)
+{
+=09int i,  idle_states_nb;
+=09struct idle_state *idle_state;
+=09struct cpuidle_state *s;
+=09const struct protocol_init *prot;
+
+=09drv->states[0].exit_latency =3D 1;
+=09drv->states[0].target_residency =3D 1;
+=09drv->states[0].flags =3D CPUIDLE_FLAG_TIME_VALID;
+=09drv->states[0].enter =3D arm_enter_idle_state;
+=09strncpy(drv->states[0].name, "ARM WFI", CPUIDLE_NAME_LEN);
+=09strncpy(drv->states[0].desc, "ARM WFI", CPUIDLE_DESC_LEN);
+
+=09idle_states_nb =3D arm_dt_init_idle_states(&prot, drv->cpumask);
+
+=09if (idle_states_nb < 0) {
+=09=09/*
+=09=09 * No DT based idle states detected
+=09=09 * Initialize driver count and exit successfully.
+=09=09 */
+=09=09drv->state_count =3D 1;
+=09=09return 0;
+=09}
+
+=09/*
+=09 * We finally have some idle states to initialize.
+=09 * Driver state 0 corresponds to WFI, start from index 1 and count up
+=09 * to idle_states_nb (parsed idle states + WFI).
+=09 * arm_dt_init_idle_states() ensures that CPUIDLE_STATE_MAX is not
+=09 * exceeded.
+=09 */
+=09s =3D &drv->states[1];
+=09for (i =3D 1; i < idle_states_nb; i++, s++) {
+=09=09idle_state =3D idle_states[i].state;
+=09=09if (!idle_state)
+=09=09=09break;
+
+=09=09strncpy(s->name, idle_state->node->name, CPUIDLE_NAME_LEN);
+=09=09strncpy(s->desc, idle_state->node->name, CPUIDLE_DESC_LEN);
+
+=09=09s->exit_latency =3D
+=09=09=09idle_state->entry_latency + idle_state->exit_latency;
+=09=09s->target_residency =3D idle_state->min_residency;
+=09=09/*
+=09=09 * TBD: flag for timers is set implicitly for now but must be
+=09=09 * linked to power domains.
+=09=09 */
+=09=09if (!idle_state->logic_state_retained)
+=09=09=09s->flags |=3D CPUIDLE_FLAG_TIMER_STOP;
+=09=09s->flags |=3D CPUIDLE_FLAG_TIME_VALID;
+=09=09s->enter =3D arm_enter_idle_state;
+=09}
+
+=09/*
+=09 * If we are here, we have a protocol back-end to initialize.
+=09 *
+=09 * If protocol initializer fails reset states count to 1 (wfi)
+=09 */
+=09if (prot->prot_init(drv->cpumask, idle_states, idle_states_nb))
+=09=09i =3D 1;
+
+=09pr_info("idle states initialized, prototocol: %s states count: %u",
+=09=09prot->prot, i);
+
+=09drv->state_count =3D i;
+=09return 0;
+}
+
--=20
1.8.4


