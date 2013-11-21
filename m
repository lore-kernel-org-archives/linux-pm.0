From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH RFC v3 08/12] arm64: kernel: implement HW breakpoints CPU PM notifier
Date: Thu, 21 Nov 2013 11:24:15 +0000
Message-ID: <1385033059-25896-9-git-send-email-lorenzo.pieralisi@arm.com>
References: <1385033059-25896-1-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:33122 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751461Ab3KULY7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Nov 2013 06:24:59 -0500
In-Reply-To: <1385033059-25896-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Dave Martin <dave.martin@arm.com>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Mark Rutland <mark.rutland@arm.com>, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>, Russell King <linux@arm.linux.org.uk>, Colin Cross <ccross@android.com>, Yu Tang <ytang5@marvell.com>, Zhou Zhu <zzhu3@marvell.com>, Kumar Sankaran <ksankaran@apm.com>, Loc Ho <lho@apm.com>, Feng Kan <fkan@apm.com>, Nicolas Pitre <nico@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, Graeme Gregory <graeme.gregory@linaro.org>, Hanjun Guo <hanjun.guo@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Christoffer Dall <christoffer.dall@linaro.org>

When a CPU is shutdown either through CPU idle or suspend to RAM, the
content of HW breakpoint registers must be reset or restored to proper
values when CPU resume from low power states. This patch adds debug registe=
r
restore operations to the HW breakpoint control function and implements a
CPU PM notifier that allows to restore the content of HW breakpoint registe=
rs
to allow proper suspend/resume operations.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm64/kernel/hw_breakpoint.c | 79 ++++++++++++++++++++++++++++++++---=
----
 1 file changed, 66 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_break=
point.c
index e894591..bcaaac9 100644
--- a/arch/arm64/kernel/hw_breakpoint.c
+++ b/arch/arm64/kernel/hw_breakpoint.c
@@ -20,6 +20,7 @@
=20
 #define pr_fmt(fmt) "hw-breakpoint: " fmt
=20
+#include <linux/cpu_pm.h>
 #include <linux/errno.h>
 #include <linux/hw_breakpoint.h>
 #include <linux/perf_event.h>
@@ -171,7 +172,8 @@ static enum debug_el debug_exception_level(int privileg=
e)
=20
 enum hw_breakpoint_ops {
 =09HW_BREAKPOINT_INSTALL,
-=09HW_BREAKPOINT_UNINSTALL
+=09HW_BREAKPOINT_UNINSTALL,
+=09HW_BREAKPOINT_RESTORE
 };
=20
 /**
@@ -210,6 +212,10 @@ static int hw_breakpoint_slot_setup(struct perf_event =
**slots, int max_slots,
 =09=09=09=09return i;
 =09=09=09}
 =09=09=09break;
+=09=09case HW_BREAKPOINT_RESTORE:
+=09=09=09if (*slot =3D=3D bp)
+=09=09=09=09return i;
+=09=09=09break;
 =09=09default:
 =09=09=09pr_warn_once("Unhandled hw breakpoint ops %d\n", ops);
 =09=09=09return -EINVAL;
@@ -256,7 +262,8 @@ static int hw_breakpoint_control(struct perf_event *bp,
 =09=09 * level.
 =09=09 */
 =09=09enable_debug_monitors(dbg_el);
-
+=09=09/* Fall through */
+=09case HW_BREAKPOINT_RESTORE:
 =09=09/* Setup the address register. */
 =09=09write_wb_reg(val_reg, i, info->address);
=20
@@ -840,18 +847,36 @@ void hw_breakpoint_thread_switch(struct task_struct *=
next)
 /*
  * CPU initialisation.
  */
-static void reset_ctrl_regs(void *unused)
+static void hw_breakpoint_reset(void *unused)
 {
 =09int i;
-
-=09for (i =3D 0; i < core_num_brps; ++i) {
-=09=09write_wb_reg(AARCH64_DBG_REG_BCR, i, 0UL);
-=09=09write_wb_reg(AARCH64_DBG_REG_BVR, i, 0UL);
+=09struct perf_event **slots;
+=09/*
+=09 * When a CPU goes through cold-boot, it does not have any installed
+=09 * slot, so it is safe to share the same function for restoring and
+=09 * resetting breakpoints; when a CPU is hotplugged in, it goes
+=09 * through the slots, which are all empty, hence it just resets control
+=09 * and value for debug registers.
+=09 * When this function is triggered on warm-boot through a CPU PM
+=09 * notifier some slots might be initialized; if so they are
+=09 * reprogrammed according to the debug slots content.
+=09 */
+=09for (slots =3D this_cpu_ptr(bp_on_reg), i =3D 0; i < core_num_brps; ++i=
) {
+=09=09if (slots[i]) {
+=09=09=09hw_breakpoint_control(slots[i], HW_BREAKPOINT_RESTORE);
+=09=09} else {
+=09=09=09write_wb_reg(AARCH64_DBG_REG_BCR, i, 0UL);
+=09=09=09write_wb_reg(AARCH64_DBG_REG_BVR, i, 0UL);
+=09=09}
 =09}
=20
-=09for (i =3D 0; i < core_num_wrps; ++i) {
-=09=09write_wb_reg(AARCH64_DBG_REG_WCR, i, 0UL);
-=09=09write_wb_reg(AARCH64_DBG_REG_WVR, i, 0UL);
+=09for (slots =3D this_cpu_ptr(wp_on_reg), i =3D 0; i < core_num_wrps; ++i=
) {
+=09=09if (slots[i]) {
+=09=09=09hw_breakpoint_control(slots[i], HW_BREAKPOINT_RESTORE);
+=09=09} else {
+=09=09=09write_wb_reg(AARCH64_DBG_REG_WCR, i, 0UL);
+=09=09=09write_wb_reg(AARCH64_DBG_REG_WVR, i, 0UL);
+=09=09}
 =09}
 }
=20
@@ -861,7 +886,7 @@ static int hw_breakpoint_reset_notify(struct notifier_b=
lock *self,
 {
 =09int cpu =3D (long)hcpu;
 =09if (action =3D=3D CPU_ONLINE)
-=09=09smp_call_function_single(cpu, reset_ctrl_regs, NULL, 1);
+=09=09smp_call_function_single(cpu, hw_breakpoint_reset, NULL, 1);
 =09return NOTIFY_OK;
 }
=20
@@ -869,6 +894,33 @@ static struct notifier_block hw_breakpoint_reset_nb =
=3D {
 =09.notifier_call =3D hw_breakpoint_reset_notify,
 };
=20
+#ifdef CONFIG_CPU_PM
+static int hw_breakpoint_cpu_pm_notify(struct notifier_block *self,
+=09=09=09=09       unsigned long action,
+=09=09=09=09       void *v)
+{
+=09if (action =3D=3D CPU_PM_EXIT) {
+=09=09hw_breakpoint_reset(NULL);
+=09=09return NOTIFY_OK;
+=09}
+
+=09return NOTIFY_DONE;
+}
+
+static struct notifier_block hw_breakpoint_cpu_pm_nb =3D {
+=09.notifier_call =3D hw_breakpoint_cpu_pm_notify,
+};
+
+static void __init hw_breakpoint_pm_init(void)
+{
+=09cpu_pm_register_notifier(&hw_breakpoint_cpu_pm_nb);
+}
+#else
+static inline void hw_breakpoint_pm_init(void)
+{
+}
+#endif
+
 /*
  * One-time initialisation.
  */
@@ -884,8 +936,8 @@ static int __init arch_hw_breakpoint_init(void)
 =09 * Reset the breakpoint resources. We assume that a halting
 =09 * debugger will leave the world in a nice state for us.
 =09 */
-=09smp_call_function(reset_ctrl_regs, NULL, 1);
-=09reset_ctrl_regs(NULL);
+=09smp_call_function(hw_breakpoint_reset, NULL, 1);
+=09hw_breakpoint_reset(NULL);
=20
 =09/* Register debug fault handlers. */
 =09hook_debug_fault_code(DBG_ESR_EVT_HWBP, breakpoint_handler, SIGTRAP,
@@ -895,6 +947,7 @@ static int __init arch_hw_breakpoint_init(void)
=20
 =09/* Register hotplug notifier. */
 =09register_cpu_notifier(&hw_breakpoint_reset_nb);
+=09hw_breakpoint_pm_init();
=20
 =09return 0;
 }
--=20
1.8.4


