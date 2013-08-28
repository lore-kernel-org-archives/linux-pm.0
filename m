From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [RFC PATCH 11/14] arm64: kernel: implement HW breakpoints CPU PM notifier
Date: Wed, 28 Aug 2013 12:36:03 +0100
Message-ID: <1377689766-17642-12-git-send-email-lorenzo.pieralisi@arm.com>
References: <1377689766-17642-1-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:39071 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755029Ab3H1LgM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 28 Aug 2013 07:36:12 -0400
In-Reply-To: <1377689766-17642-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Dave Martin <dave.martin@arm.com>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Mark Rutland <mark.rutland@arm.com>, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>, Russell King <linux@arm.linux.org.uk>, Colin Cross <ccross@android.com>, Yu Tang <ytang5@marvell.com>, Zhou Zhu <zzhu3@marvell.com>, Kumar Sankaran <ksankaran@apm.com>, Loc Ho <lho@apm.com>, Feng Kan <fkan@apm.com>, Nicolas Pitre <nico@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, Graeme Gregory <graeme.gregory@linaro.org>, Hanjun Guo <hanjun.guo@linaro.org>

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
 arch/arm64/kernel/hw_breakpoint.c | 63 +++++++++++++++++++++++++++++++++++=
++--
 1 file changed, 61 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_break=
point.c
index 84d1e62..59afa21 100644
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
@@ -869,6 +876,57 @@ static struct notifier_block hw_breakpoint_reset_nb =
=3D {
 =09.notifier_call =3D hw_breakpoint_reset_notify,
 };
=20
+#ifdef CONFIG_CPU_PM
+static void hw_breakpoint_restore(void)
+{
+=09int i;
+=09struct perf_event **slots;
+
+=09for (slots =3D __get_cpu_var(bp_on_reg), i =3D 0; i < core_num_brps; ++=
i) {
+=09=09if (slots[i]) {
+=09=09=09hw_breakpoint_control(slots[i], HW_BREAKPOINT_RESTORE);
+=09=09} else {
+=09=09=09write_wb_reg(AARCH64_DBG_REG_BCR, i, 0UL);
+=09=09=09write_wb_reg(AARCH64_DBG_REG_BVR, i, 0UL);
+=09=09}
+=09}
+
+=09for (slots =3D __get_cpu_var(wp_on_reg), i =3D 0; i < core_num_wrps; ++=
i) {
+=09=09if (slots[i]) {
+=09=09=09hw_breakpoint_control(slots[i], HW_BREAKPOINT_RESTORE);
+=09=09} else {
+=09=09=09write_wb_reg(AARCH64_DBG_REG_WCR, i, 0UL);
+=09=09=09write_wb_reg(AARCH64_DBG_REG_WVR, i, 0UL);
+=09=09}
+=09}
+}
+
+static int hw_breakpoint_cpu_pm_notify(struct notifier_block *self,
+=09=09=09=09       unsigned long action,
+=09=09=09=09       void *v)
+{
+=09if (action =3D=3D CPU_PM_EXIT) {
+=09=09hw_breakpoint_restore();
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
@@ -895,6 +953,7 @@ static int __init arch_hw_breakpoint_init(void)
=20
 =09/* Register hotplug notifier. */
 =09register_cpu_notifier(&hw_breakpoint_reset_nb);
+=09hw_breakpoint_pm_init();
=20
 =09return 0;
 }
--=20
1.8.3.4


