From: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH RFC v3 4/6] arm64: add PSCI CPU_SUSPEND based cpu_suspend support
Date: Tue,  6 May 2014 19:04:41 +0100
Message-ID: <1399399483-17112-5-git-send-email-lorenzo.pieralisi@arm.com>
References: <1399399483-17112-1-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1399399483-17112-1-git-send-email-lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Charles Garcia Tobin <Charles.Garcia-Tobin-5wv7dgnIgG8@public.gmane.org>, Nicolas Pitre <nico-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Amit Kucheria <amit.kucheria-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Antti Miettinen <ananaza-X3B1VOXEql0@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Capella <sebastian.capella-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Tomasz Figa <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

This patch implements the cpu_suspend cpu operations method through
the PSCI CPU_SUSPEND API. The PSCI implementation translates the idle state
index passed by the cpu_suspend core call into a valid PSCI state according=
 to
the PSCI states initialized at boot by the PSCI suspend backend.

Entry point is set to cpu_resume physical address, that represents the
default kernel execution address following a CPU reset.

Idle state indices missing a DT node description are initialized to power
state standby WFI so that if called by the idle driver they provide the
default behaviour.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
---
 arch/arm64/include/asm/psci.h |   4 ++
 arch/arm64/kernel/psci.c      | 102 ++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 106 insertions(+)

diff --git a/arch/arm64/include/asm/psci.h b/arch/arm64/include/asm/psci.h
index d15ab8b4..9a4b663 100644
--- a/arch/arm64/include/asm/psci.h
+++ b/arch/arm64/include/asm/psci.h
@@ -14,6 +14,10 @@
 #ifndef __ASM_PSCI_H
 #define __ASM_PSCI_H
=20
+struct cpuidle_driver;
 void psci_init(void);
=20
+int __init psci_dt_register_idle_states(struct cpuidle_driver *,
+=09=09=09=09=09struct device_node *[]);
+
 #endif /* __ASM_PSCI_H */
diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
index ea4828a..0e32ab4 100644
--- a/arch/arm64/kernel/psci.c
+++ b/arch/arm64/kernel/psci.c
@@ -15,15 +15,18 @@
=20
 #define pr_fmt(fmt) "psci: " fmt
=20
+#include <linux/cpuidle.h>
 #include <linux/init.h>
 #include <linux/of.h>
 #include <linux/smp.h>
+#include <linux/slab.h>
=20
 #include <asm/compiler.h>
 #include <asm/cpu_ops.h>
 #include <asm/errno.h>
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
@@ -176,6 +192,77 @@ static const struct of_device_id psci_of_match[] __ini=
tconst =3D {
 =09{},
 };
=20
+int __init psci_dt_register_idle_states(struct cpuidle_driver *drv,
+=09=09=09=09=09struct device_node *state_nodes[])
+{
+=09int cpu, i;
+=09struct psci_power_state *psci_states;
+=09const struct cpu_operations *cpu_ops_ptr;
+
+=09if (!state_nodes)
+=09=09return -EINVAL;
+=09/*
+=09 * This is belt-and-braces: make sure that if the idle
+=09 * specified protocol is psci, the cpu_ops have been
+=09 * initialized to psci operations. Anything else is
+=09 * a recipe for mayhem.
+=09 */
+=09for_each_cpu(cpu, drv->cpumask) {
+=09=09cpu_ops_ptr =3D cpu_ops[cpu];
+=09=09if (WARN_ON(!cpu_ops_ptr || strcmp(cpu_ops_ptr->name, "psci")))
+=09=09=09return -EOPNOTSUPP;
+=09}
+
+=09psci_states =3D kcalloc(drv->state_count, sizeof(*psci_states),
+=09=09=09      GFP_KERNEL);
+
+=09if (!psci_states) {
+=09=09pr_warn("psci idle state allocation failed\n");
+=09=09return -ENOMEM;
+=09}
+
+=09for_each_cpu(cpu, drv->cpumask) {
+=09=09if (per_cpu(psci_power_state, cpu)) {
+=09=09=09pr_warn("idle states already initialized on cpu %u\n",
+=09=09=09=09cpu);
+=09=09=09continue;
+=09=09}
+=09=09per_cpu(psci_power_state, cpu) =3D psci_states;
+=09}
+
+
+=09for (i =3D 0; i < drv->state_count; i++) {
+=09=09u32 psci_power_state;
+
+=09=09if (!state_nodes[i]) {
+=09=09=09/*
+=09=09=09 * An index with a missing node pointer falls back to
+=09=09=09 * simple STANDBYWFI
+=09=09=09 */
+=09=09=09psci_states[i].type =3D PSCI_POWER_STATE_TYPE_STANDBY;
+=09=09=09continue;
+=09=09}
+
+=09=09if (of_property_read_u32(state_nodes[i], "entry-method-param",
+=09=09=09=09=09 &psci_power_state)) {
+=09=09=09pr_warn(" * %s missing entry-method-param property\n",
+=09=09=09=09state_nodes[i]->full_name);
+=09=09=09/*
+=09=09=09 * If entry-method-param property is missing, fall
+=09=09=09 * back to STANDBYWFI state
+=09=09=09 */
+=09=09=09psci_states[i].type =3D PSCI_POWER_STATE_TYPE_STANDBY;
+=09=09=09continue;
+=09=09}
+
+=09=09pr_debug("psci-power-state %#x index %u\n",
+=09=09=09 psci_power_state, i);
+=09=09psci_power_state_unpack(psci_power_state, &psci_states[i]);
+=09}
+
+=09return 0;
+}
+
 void __init psci_init(void)
 {
 =09struct device_node *np;
@@ -279,6 +366,18 @@ static void cpu_psci_cpu_die(unsigned int cpu)
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
@@ -288,6 +387,9 @@ const struct cpu_operations cpu_psci_ops =3D {
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


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
