From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH v9 4/8] arm64: add PSCI CPU_SUSPEND based cpu_suspend support
Date: Fri,  5 Sep 2014 18:34:53 +0100
Message-ID: <1409938498-17984-5-git-send-email-lorenzo.pieralisi@arm.com>
References: <1409938498-17984-1-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:54607 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754746AbaIERe4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 5 Sep 2014 13:34:56 -0400
In-Reply-To: <1409938498-17984-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: devicetree@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Charles Garcia Tobin <Charles.Garcia-Tobin@arm.com>, Nicolas Pitre <nico@linaro.org>, Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Stephen Boyd <sboyd@codeaurora.org>, Kevin Hilman <khilman@linaro.org>, Sebastian Capella <sebcape@gmail.com>, Mark Brown <broonie@kernel.org>, Paul Walmsley <paul@pwsan.com>, Chander Kashyap <k.chander@samsung.com>, Geoff

This patch implements the cpu_suspend cpu operations method through
the PSCI CPU SUSPEND API. The PSCI implementation translates the idle state
index passed by the cpu_suspend core call into a valid PSCI state according=
 to
the PSCI states initialized at boot through the cpu_init_idle() CPU
operations hook.

The PSCI CPU suspend operation hook checks if the PSCI state is a
standby state. If it is, it calls the PSCI suspend implementation
straight away, without saving any context. If the state is a power
down state the kernel calls the __cpu_suspend API (that saves the CPU
context) and passed the PSCI suspend finisher as a parameter so that PSCI
can be called by the __cpu_suspend implementation after saving and flushing
the context as last function before power down.

For power down states, entry point is set to cpu_resume physical address,
that represents the default kernel execution address following a CPU reset.

Reviewed-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm64/kernel/psci.c | 104 +++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 104 insertions(+)

diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
index 5539547..866c1c8 100644
--- a/arch/arm64/kernel/psci.c
+++ b/arch/arm64/kernel/psci.c
@@ -21,6 +21,7 @@
 #include <linux/reboot.h>
 #include <linux/pm.h>
 #include <linux/delay.h>
+#include <linux/slab.h>
 #include <uapi/linux/psci.h>
=20
 #include <asm/compiler.h>
@@ -28,6 +29,7 @@
 #include <asm/errno.h>
 #include <asm/psci.h>
 #include <asm/smp_plat.h>
+#include <asm/suspend.h>
 #include <asm/system_misc.h>
=20
 #define PSCI_POWER_STATE_TYPE_STANDBY=09=090
@@ -65,6 +67,8 @@ enum psci_function {
 =09PSCI_FN_MAX,
 };
=20
+static DEFINE_PER_CPU_READ_MOSTLY(struct psci_power_state *, psci_power_st=
ate);
+
 static u32 psci_function_id[PSCI_FN_MAX];
=20
 static int psci_to_linux_errno(int errno)
@@ -93,6 +97,18 @@ static u32 psci_power_state_pack(struct psci_power_state=
 state)
 =09=09 & PSCI_0_2_POWER_STATE_AFFL_MASK);
 }
=20
+static void psci_power_state_unpack(u32 power_state,
+=09=09=09=09    struct psci_power_state *state)
+{
+=09state->id =3D (power_state & PSCI_0_2_POWER_STATE_ID_MASK) >>
+=09=09=09PSCI_0_2_POWER_STATE_ID_SHIFT;
+=09state->type =3D (power_state & PSCI_0_2_POWER_STATE_TYPE_MASK) >>
+=09=09=09PSCI_0_2_POWER_STATE_TYPE_SHIFT;
+=09state->affinity_level =3D
+=09=09=09(power_state & PSCI_0_2_POWER_STATE_AFFL_MASK) >>
+=09=09=09PSCI_0_2_POWER_STATE_AFFL_SHIFT;
+}
+
 /*
  * The following two functions are invoked via the invoke_psci_fn pointer
  * and will not be inlined, allowing us to piggyback on the AAPCS.
@@ -199,6 +215,63 @@ static int psci_migrate_info_type(void)
 =09return err;
 }
=20
+static int __maybe_unused cpu_psci_cpu_init_idle(struct device_node *cpu_n=
ode,
+=09=09=09=09=09=09 unsigned int cpu)
+{
+=09int i, ret, count =3D 0;
+=09struct psci_power_state *psci_states;
+=09struct device_node *state_node;
+
+=09/*
+=09 * If the PSCI cpu_suspend function hook has not been initialized
+=09 * idle states must not be enabled, so bail out
+=09 */
+=09if (!psci_ops.cpu_suspend)
+=09=09return -EOPNOTSUPP;
+
+=09/* Count idle states */
+=09while ((state_node =3D of_parse_phandle(cpu_node, "cpu-idle-states",
+=09=09=09=09=09      count))) {
+=09=09count++;
+=09=09of_node_put(state_node);
+=09}
+
+=09if (!count)
+=09=09return -ENODEV;
+
+=09psci_states =3D kcalloc(count, sizeof(*psci_states), GFP_KERNEL);
+=09if (!psci_states)
+=09=09return -ENOMEM;
+
+=09for (i =3D 0; i < count; i++) {
+=09=09u32 psci_power_state;
+
+=09=09state_node =3D of_parse_phandle(cpu_node, "cpu-idle-states", i);
+
+=09=09ret =3D of_property_read_u32(state_node,
+=09=09=09=09=09   "arm,psci-suspend-param",
+=09=09=09=09=09   &psci_power_state);
+=09=09if (ret) {
+=09=09=09pr_warn(" * %s missing arm,psci-suspend-param property\n",
+=09=09=09=09state_node->full_name);
+=09=09=09of_node_put(state_node);
+=09=09=09goto free_mem;
+=09=09}
+
+=09=09of_node_put(state_node);
+=09=09pr_debug("psci-power-state %#x index %d\n", psci_power_state,
+=09=09=09=09=09=09=09    i);
+=09=09psci_power_state_unpack(psci_power_state, &psci_states[i]);
+=09}
+=09/* Idle states parsed correctly, initialize per-cpu pointer */
+=09per_cpu(psci_power_state, cpu) =3D psci_states;
+=09return 0;
+
+free_mem:
+=09kfree(psci_states);
+=09return ret;
+}
+
 static int get_set_conduit_method(struct device_node *np)
 {
 =09const char *method;
@@ -436,8 +509,39 @@ static int cpu_psci_cpu_kill(unsigned int cpu)
 #endif
 #endif
=20
+static int psci_suspend_finisher(unsigned long index)
+{
+=09struct psci_power_state *state =3D __get_cpu_var(psci_power_state);
+
+=09return psci_ops.cpu_suspend(state[index - 1],
+=09=09=09=09    virt_to_phys(cpu_resume));
+}
+
+static int __maybe_unused cpu_psci_cpu_suspend(unsigned long index)
+{
+=09int ret;
+=09struct psci_power_state *state =3D __get_cpu_var(psci_power_state);
+=09/*
+=09 * idle state index 0 corresponds to wfi, should never be called
+=09 * from the cpu_suspend operations
+=09 */
+=09if (WARN_ON_ONCE(!index))
+=09=09return -EINVAL;
+
+=09if (state->type =3D=3D PSCI_POWER_STATE_TYPE_STANDBY)
+=09=09ret =3D psci_ops.cpu_suspend(state[index - 1], 0);
+=09else
+=09=09ret =3D __cpu_suspend(index, psci_suspend_finisher);
+
+=09return ret;
+}
+
 const struct cpu_operations cpu_psci_ops =3D {
 =09.name=09=09=3D "psci",
+#ifdef CONFIG_CPU_IDLE
+=09.cpu_init_idle=09=3D cpu_psci_cpu_init_idle,
+=09.cpu_suspend=09=3D cpu_psci_cpu_suspend,
+#endif
 #ifdef CONFIG_SMP
 =09.cpu_init=09=3D cpu_psci_cpu_init,
 =09.cpu_prepare=09=3D cpu_psci_cpu_prepare,
--=20
1.9.1


