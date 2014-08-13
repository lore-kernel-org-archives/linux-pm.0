From: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v7 5/8] arm64: add PSCI CPU_SUSPEND based cpu_suspend support
Date: Wed, 13 Aug 2014 16:52:04 +0100
Message-ID: <1407945127-27554-6-git-send-email-lorenzo.pieralisi@arm.com>
References: <1407945127-27554-1-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1407945127-27554-1-git-send-email-lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Charles Garcia Tobin <Charles.Garcia-Tobin-5wv7dgnIgG8@public.gmane.org>, Nicolas Pitre <nico-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Amit Kucheria <amit.kucheria-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Antti Miettinen <ananaza-X3B1VOXEql0@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Capella <sebcape-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tomasz Figa <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Chander Kashyap <k.chander-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Geoff
List-Id: linux-pm@vger.kernel.org

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

Reviewed-by: Ashwin Chaugule <ashwin.chaugule-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
---
 arch/arm64/kernel/psci.c | 100 +++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 100 insertions(+)

diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
index 5539547..8258a77 100644
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
@@ -199,6 +215,59 @@ static int psci_migrate_info_type(void)
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
+=09=09=09=09=09      count)))
+=09=09count++;
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
+=09=09=09goto free_mem;
+=09=09}
+
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
@@ -436,8 +505,39 @@ static int cpu_psci_cpu_kill(unsigned int cpu)
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


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
