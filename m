From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v7 3/8] drivers: cpuidle: implement DT based idle states
 infrastructure
Date: Thu, 14 Aug 2014 12:29:11 +0100
Message-ID: <20140814112911.GA5039@red-moon>
References: <1407945127-27554-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1407945127-27554-4-git-send-email-lorenzo.pieralisi@arm.com>
 <alpine.LFD.2.11.1408131223501.1133@knanqh.ubzr>
 <20140813170440.GA30822@e102568-lin.cambridge.arm.com>
 <alpine.LFD.2.11.1408131319210.1133@knanqh.ubzr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <alpine.LFD.2.11.1408131319210.1133@knanqh.ubzr>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Mark Rutland <Mark.Rutland@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Tomasz Figa <t.figa@samsung.com>, Lina Iyer <lina.iyer@linaro.org>, Chander Kashyap <k.chander@samsung.com>, Vincent Guittot <vincent.guittot@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, ashwin.chaugule@linaro.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Sebastian Capella <sebcape@gmail.com>, Mark Brown <broonie@kernel.org>, Antti Miettinen <ananaza@iki.fi>, Paul Walmsley <paul@pwsan.com>, Geoff Levand <geoff@infradead.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Stephen Boyd <sboyd@>
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 13, 2014 at 06:29:49PM +0100, Nicolas Pitre wrote:
> On Wed, 13 Aug 2014, Lorenzo Pieralisi wrote:

[...]

> > > > The idle states list is obtained from the first cpu in the driver
> > > > cpumask, which implicitly means the parsing code expects idle states
> > > > (and related list of phandles) to be the same for all CPUs in the
> > > > CPUidle driver mask. The kernel does not check this assumption, it must
> > > > be enforced by the bootloader to ensure correct system behaviour.
> > > 
> > > Can we make the kernel a little less reliant on bootloader to ensure 
> > > correct system behaviour please?  If assumptions are assumed by the 
> > > kernel, it should at least print a warning and simply ignore the 
> > > information when such assumption are not respected.
> > 
> > I think the check adds complexity (it means stashing the idle states
> > phandles for the first cpu, loop through the cpus in the mask and compare
> > the phandles to the ones stashed for the first cpu for all cpus in the
> > driver mask) for not much.
> > 
> > I was told that it is not up to the kernel to validate the DT, but if
> > you want I can implement the check even though I really think it is
> > overkill.
> 
> DT validation is not the same as resiliance against messed-up DT 
> content.  If the kernel is going to boot regardless then this is fine.  
> If the kernel is going to crash, or work suboptimally without returning 
> a clue because some implicit assumptions are not respected then this is 
> bad.
> 
> And people _will_ mess up their DT from time to time.
> 
> So if you tell me a messed-up DT won't bear much consequences then I'm 
> fine with that.

Nico, on second thoughts, since Ashwin raised the point too and I think
that at these early stages it might turn out useful, I gave coding
the check a go. I tried to make the check self contained so that we can
yank it out if we do not want it in the final version or we will want
to remove it later.

Here the refreshed patch is:

-- >8 --
Subject: [PATCH] drivers: cpuidle: implement DT based idle states
 infrastructure

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
 drivers/cpuidle/dt_idle_states.c | 175 +++++++++++++++++++++++++++++++++++++++
 drivers/cpuidle/dt_idle_states.h |   5 ++
 4 files changed, 184 insertions(+)
 create mode 100644 drivers/cpuidle/dt_idle_states.c
 create mode 100644 drivers/cpuidle/dt_idle_states.h

diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
index 32748c3..8deb934 100644
--- a/drivers/cpuidle/Kconfig
+++ b/drivers/cpuidle/Kconfig
@@ -25,6 +25,9 @@ config CPU_IDLE_GOV_MENU
 	bool "Menu governor (for tickless system)"
 	default y
 
+config DT_IDLE_STATES
+	bool
+
 menu "ARM CPU Idle Drivers"
 depends on ARM
 source "drivers/cpuidle/Kconfig.arm"
diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
index 11edb31..002b653 100644
--- a/drivers/cpuidle/Makefile
+++ b/drivers/cpuidle/Makefile
@@ -4,6 +4,7 @@
 
 obj-y += cpuidle.o driver.o governor.o sysfs.o governors/
 obj-$(CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED) += coupled.o
+obj-$(CONFIG_DT_IDLE_STATES)		  += dt_idle_states.o
 
 ##################################################################################
 # ARM SoC drivers
diff --git a/drivers/cpuidle/dt_idle_states.c b/drivers/cpuidle/dt_idle_states.c
new file mode 100644
index 0000000..13273e2
--- /dev/null
+++ b/drivers/cpuidle/dt_idle_states.c
@@ -0,0 +1,175 @@
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
+			   struct device_node *state_node)
+{
+	int err;
+
+	err = of_property_read_u32(state_node, "wakeup-latency-us",
+				   &idle_state->exit_latency);
+	if (err) {
+		u32 entry_latency, exit_latency;
+
+		err = of_property_read_u32(state_node, "entry-latency-us",
+					   &entry_latency);
+		if (err) {
+			pr_debug(" * %s missing entry-latency-us property\n",
+				 state_node->full_name);
+			return -EINVAL;
+		}
+
+		err = of_property_read_u32(state_node, "exit-latency-us",
+					   &exit_latency);
+		if (err) {
+			pr_debug(" * %s missing exit-latency-us property\n",
+				 state_node->full_name);
+			return -EINVAL;
+		}
+		/*
+		 * If wakeup-latency-us is missing, default to entry+exit
+		 * latencies as defined in idle states bindings
+		 */
+		idle_state->exit_latency = entry_latency + exit_latency;
+	}
+
+	err = of_property_read_u32(state_node, "min-residency-us",
+				   &idle_state->target_residency);
+	if (err) {
+		pr_debug(" * %s missing min-residency-us property\n",
+			     state_node->full_name);
+		return -EINVAL;
+	}
+
+	idle_state->flags = CPUIDLE_FLAG_TIME_VALID;
+	if (of_property_read_bool(state_node, "local-timer-stop"))
+		idle_state->flags |= CPUIDLE_FLAG_TIMER_STOP;
+	/*
+	 * TODO:
+	 *	replace with kstrdup and pointer assignment when name
+	 *	and desc become string pointers
+	 */
+	strncpy(idle_state->name, state_node->name, CPUIDLE_NAME_LEN - 1);
+	strncpy(idle_state->desc, state_node->name, CPUIDLE_DESC_LEN - 1);
+	return 0;
+}
+
+/*
+ * Check that the idle state is uniform across all CPUs in the CPUidle driver
+ * cpumask
+ */
+static bool idle_state_valid(struct device_node *state_node, unsigned int idx,
+			     const cpumask_t *cpumask)
+{
+	int cpu;
+	struct device_node *cpu_node, *curr_state_node;
+
+	/*
+	 * Compare idle state phandles for index idx on all CPUs in the
+	 * CPUidle driver cpumask. Start from next logical cpu following
+	 * cpumask_first(cpumask) since that's the CPU state_node was
+	 * retrieved from. If a mismatch is found bail out straight
+	 * away since we certainly hit a firmware misconfiguration.
+	 */
+	for (cpu = cpumask_next(cpumask_first(cpumask), cpumask);
+	     cpu < nr_cpu_ids; cpu = cpumask_next(cpu, cpumask)) {
+		cpu_node = of_cpu_device_node_get(cpu);
+		curr_state_node = of_parse_phandle(cpu_node, "cpu-idle-states",
+						   idx);
+		if (state_node != curr_state_node)
+			return false;
+	}
+
+	return true;
+}
+
+/**
+ * dt_init_idle_driver() - Parse the DT idle states and initialize the
+ *			   idle driver states array
+ * @drv:	  Pointer to CPU idle driver to be initialized
+ * @start_idx:    First idle state index to be initialized
+ *
+ * If DT idle states are detected and are valid the state count and states
+ * array entries in the cpuidle driver are initialized accordingly starting
+ * from index start_idx.
+ *
+ * Return: number of valid DT idle states parsed, <0 on failure
+ */
+int dt_init_idle_driver(struct cpuidle_driver *drv, unsigned int start_idx)
+{
+	struct cpuidle_state *idle_state;
+	struct device_node *state_node, *cpu_node;
+	int i;
+	unsigned int state_idx = start_idx;
+
+	if (state_idx >= CPUIDLE_STATE_MAX)
+		return -EINVAL;
+	/*
+	 * We get the idle states for the first logical cpu in the
+	 * driver mask. The kernel does not check idle states on all
+	 * cpus in the driver mask, they are assumed to be the same
+	 * by default.
+	 */
+	cpu_node = of_cpu_device_node_get(cpumask_first(drv->cpumask));
+
+	for (i = 0; ; i++) {
+		int err;
+
+		state_node = of_parse_phandle(cpu_node, "cpu-idle-states", i);
+		if (!state_node)
+			break;
+
+		if (!idle_state_valid(state_node, i, drv->cpumask)) {
+			pr_warn("%s idle state not valid, bailing out\n",
+				state_node->full_name);
+			return -EINVAL;
+		}
+
+		if (state_idx == CPUIDLE_STATE_MAX) {
+			pr_warn("State index reached static CPU idle driver states array size\n");
+			break;
+		}
+
+		idle_state = &drv->states[state_idx++];
+		err = init_state_node(idle_state, state_node);
+		if (err) {
+			pr_err("Parsing idle state node %s failed with err %d\n",
+			       state_node->full_name, err);
+			return err;
+		}
+	}
+	/*
+	 * Update the driver state count only if some valid DT idle states
+	 * were detected
+	 */
+	if (i)
+		drv->state_count = state_idx;
+
+	/*
+	 * Return the number of present and valid DT idle states, which can
+	 * also be 0 on platforms with missing DT idle states or legacy DT
+	 * configuration predating the DT idle states bindings.
+	 */
+	return i;
+}
+EXPORT_SYMBOL_GPL(dt_init_idle_driver);
diff --git a/drivers/cpuidle/dt_idle_states.h b/drivers/cpuidle/dt_idle_states.h
new file mode 100644
index 0000000..728c37c
--- /dev/null
+++ b/drivers/cpuidle/dt_idle_states.h
@@ -0,0 +1,5 @@
+#ifndef __DT_IDLE_STATES
+#define __DT_IDLE_STATES
+
+int dt_init_idle_driver(struct cpuidle_driver *drv, unsigned int start_idx);
+#endif
-- 
1.8.4
