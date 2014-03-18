From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH RFC 2/4] arm64: add PSCI CPU_SUSPEND based cpu_suspend support
Date: Tue, 18 Mar 2014 10:20:26 +0000
Message-ID: <1395138028-19630-3-git-send-email-lorenzo.pieralisi@arm.com>
References: <1395138028-19630-1-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:54208 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753953AbaCRKTO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 18 Mar 2014 06:19:14 -0400
In-Reply-To: <1395138028-19630-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Charles Garcia Tobin <Charles.Garcia-Tobin@arm.com>, Nicolas Pitre <nico@linaro.org>, Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Stephen Boyd <sboyd@codeaurora.org>, Kevin Hilman <khilman@linaro.org>, Sebastian Capella <sebastian.capella@linaro.org>, Tomasz Figa <t.figa@samsung.com>

This patch implements the cpu_suspend cpu operations method through
the PSCI CPU_SUSPEND API. The PSCI implementation translates the idle state
index passed by the cpu_suspend core call into a valid PSCI state according=
 to
the PSCI states initialized at boot by the PSCI protocol backend.

Entry point is set to cpu_resume physical address, that represents the
default kernel execution address following a CPU reset.

Idle state index 0 is initialized to power state standby WFI so that if cal=
led
by the idle driver it provides the default behaviour.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm64/include/asm/psci.h   |  6 +++
 arch/arm64/kernel/idle_states.c |  1 +
 arch/arm64/kernel/psci.c        | 84 +++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 91 insertions(+)

diff --git a/arch/arm64/include/asm/psci.h b/arch/arm64/include/asm/psci.h
index e5312ea..b8ec598 100644
--- a/arch/arm64/include/asm/psci.h
+++ b/arch/arm64/include/asm/psci.h
@@ -14,6 +14,12 @@
 #ifndef __ASM_PSCI_H
 #define __ASM_PSCI_H
=20
+struct idle_state;
+
 int psci_init(void);
=20
+int __init psci_register_idle_states(struct cpumask *cpumask,
+=09=09=09=09     struct idle_state *idle_states,
+=09=09=09=09     unsigned int count);
+
 #endif /* __ASM_PSCI_H */
diff --git a/arch/arm64/kernel/idle_states.c b/arch/arm64/kernel/idle_state=
s.c
index 0386cff..eb1e912 100644
--- a/arch/arm64/kernel/idle_states.c
+++ b/arch/arm64/kernel/idle_states.c
@@ -31,6 +31,7 @@ struct protocol_init {
 };
=20
 static const struct protocol_init protocols[] __initconst =3D {
+=09{"arm,psci", psci_register_idle_states},
 =09{}
 };
=20
diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
index 4f97db3..fe01589 100644
--- a/arch/arm64/kernel/psci.c
+++ b/arch/arm64/kernel/psci.c
@@ -18,12 +18,15 @@
 #include <linux/init.h>
 #include <linux/of.h>
 #include <linux/smp.h>
+#include <linux/slab.h>
=20
 #include <asm/compiler.h>
 #include <asm/cpu_ops.h>
 #include <asm/errno.h>
+#include <asm/idle_states.h>
 #include <asm/psci.h>
 #include <asm/smp_plat.h>
+#include <asm/suspend.h>
=20
 #define PSCI_POWER_STATE_TYPE_STANDBY=09=090
 #define PSCI_POWER_STATE_TYPE_POWER_DOWN=091
@@ -54,6 +57,8 @@ enum psci_function {
 =09PSCI_FN_MAX,
 };
=20
+static DEFINE_PER_CPU_READ_MOSTLY(struct psci_power_state *, psci_power_st=
ate);
+
 static u32 psci_function_id[PSCI_FN_MAX];
=20
 #define PSCI_RET_SUCCESS=09=090
@@ -94,6 +99,17 @@ static u32 psci_power_state_pack(struct psci_power_state=
 state)
 =09=09=09<< PSCI_POWER_STATE_AFFL_SHIFT);
 }
=20
+static void psci_power_state_unpack(u32 power_state,
+=09=09=09=09    struct psci_power_state *state)
+{
+=09state->id =3D (power_state >> PSCI_POWER_STATE_ID_SHIFT)
+=09=09=09& PSCI_POWER_STATE_ID_MASK;
+=09state->type =3D (power_state >> PSCI_POWER_STATE_TYPE_SHIFT)
+=09=09=09& PSCI_POWER_STATE_TYPE_MASK;
+=09state->affinity_level =3D (power_state >> PSCI_POWER_STATE_AFFL_SHIFT)
+=09=09=09& PSCI_POWER_STATE_AFFL_MASK;
+}
+
 /*
  * The following two functions are invoked via the invoke_psci_fn pointer
  * and will not be inlined, allowing us to piggyback on the AAPCS.
@@ -176,6 +192,59 @@ static const struct of_device_id psci_of_match[] __ini=
tconst =3D {
 =09{},
 };
=20
+int __init psci_register_idle_states(struct cpumask *cpumask,
+=09=09=09=09     struct idle_state *idle_states,
+=09=09=09=09     unsigned int count)
+{
+=09int cpu, i;
+=09struct psci_power_state *psci_states;
+=09const struct cpu_operations *cpu_ops_ptr;
+
+=09if (!idle_states)
+=09=09return -EINVAL;
+=09/*
+=09 * This is belt-and-braces: make sure that if the idle
+=09 * specified protocol is psci, the cpu_ops have been
+=09 * initialized to psci operations. Anything else is
+=09 * a recipe for mayhem.
+=09 */
+=09for_each_cpu(cpu, cpumask) {
+=09=09cpu_ops_ptr =3D cpu_ops[cpu];
+=09=09if (WARN_ON(!cpu_ops_ptr || strcmp(cpu_ops_ptr->name, "psci")))
+=09=09=09return -EOPNOTSUPP;
+=09}
+
+=09psci_states =3D kcalloc(count, sizeof(*psci_states), GFP_KERNEL);
+
+=09if (!psci_states) {
+=09=09pr_warn("psci idle state allocation failed\n");
+=09=09return -ENOMEM;
+=09}
+
+=09for_each_cpu(cpu, cpumask) {
+=09=09if (per_cpu(psci_power_state, cpu)) {
+=09=09=09pr_warn("idle states already initialized on cpu %u\n",
+=09=09=09=09cpu);
+=09=09=09continue;
+=09=09}
+=09=09per_cpu(psci_power_state, cpu) =3D psci_states;
+=09}
+
+=09/*
+=09 * Index 0 is always considered as standby wfi
+=09 */
+=09psci_states[0].type =3D PSCI_POWER_STATE_TYPE_STANDBY;
+
+=09for (i =3D 1; i < count; i++) {
+=09=09pr_debug("psci-power-state %#x index %u\n",
+=09=09=09 idle_states[i].state->param, i);
+=09=09psci_power_state_unpack(idle_states[i].state->param,
+=09=09=09=09=09&psci_states[i]);
+=09}
+
+=09return 0;
+}
+
 int __init psci_init(void)
 {
 =09struct device_node *np;
@@ -282,6 +351,18 @@ static void cpu_psci_cpu_die(unsigned int cpu)
 }
 #endif
=20
+#ifdef CONFIG_ARM64_CPU_SUSPEND
+static int cpu_psci_cpu_suspend(unsigned long index)
+{
+=09struct psci_power_state *state =3D __get_cpu_var(psci_power_state);
+
+=09if (!state)
+=09=09return -EOPNOTSUPP;
+
+=09return psci_ops.cpu_suspend(state[index], virt_to_phys(cpu_resume));
+}
+#endif
+
 const struct cpu_operations cpu_psci_ops =3D {
 =09.name=09=09=3D "psci",
 =09.cpu_init=09=3D cpu_psci_cpu_init,
@@ -291,6 +372,9 @@ const struct cpu_operations cpu_psci_ops =3D {
 =09.cpu_disable=09=3D cpu_psci_cpu_disable,
 =09.cpu_die=09=3D cpu_psci_cpu_die,
 #endif
+#ifdef CONFIG_ARM64_CPU_SUSPEND
+=09.cpu_suspend=09=3D cpu_psci_cpu_suspend,
+#endif
 };
=20
 #endif
--=20
1.8.4


