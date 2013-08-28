From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [RFC PATCH 10/14] arm64: kernel: refactor code to install/uninstall breakpoints
Date: Wed, 28 Aug 2013 12:36:02 +0100
Message-ID: <1377689766-17642-11-git-send-email-lorenzo.pieralisi@arm.com>
References: <1377689766-17642-1-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:39166 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755091Ab3H1LgO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 28 Aug 2013 07:36:14 -0400
In-Reply-To: <1377689766-17642-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Dave Martin <dave.martin@arm.com>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Mark Rutland <mark.rutland@arm.com>, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>, Russell King <linux@arm.linux.org.uk>, Colin Cross <ccross@android.com>, Yu Tang <ytang5@marvell.com>, Zhou Zhu <zzhu3@marvell.com>, Kumar Sankaran <ksankaran@apm.com>, Loc Ho <lho@apm.com>, Feng Kan <fkan@apm.com>, Nicolas Pitre <nico@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, Graeme Gregory <graeme.gregory@linaro.org>, Hanjun Guo <hanjun.guo@linaro.org>

Most of the code executed to install and uninstall breakpoints is
common and can be factored out in a function that through a runtime
operations type provides the requested implementation.

This patch creates a common function that can be used to install/uninstall
breakpoints and defines the set of operations that can be carried out
through it.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm64/kernel/hw_breakpoint.c | 142 +++++++++++++++++++++++-----------=
----
 1 file changed, 88 insertions(+), 54 deletions(-)

diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_break=
point.c
index 329218c..84d1e62 100644
--- a/arch/arm64/kernel/hw_breakpoint.c
+++ b/arch/arm64/kernel/hw_breakpoint.c
@@ -169,15 +169,63 @@ static enum debug_el debug_exception_level(int privil=
ege)
 =09}
 }
=20
-/*
- * Install a perf counter breakpoint.
+enum hw_breakpoint_ops {
+=09HW_BREAKPOINT_INSTALL,
+=09HW_BREAKPOINT_UNINSTALL
+};
+
+/**
+ * hw_breakpoint_slot_setup - Find and setup a perf slot according to
+ *=09=09=09      operations
+ *
+ * @slots: pointer to array of slots
+ * @max_slots: max number of slots
+ * @bp: perf_event to setup
+ * @ops: operation to be carried out on the slot
+ *
+ * Return:
+ *=09slot index on success
+ *=09-ENOSPC if no slot is available/matches
+ *=09-EINVAL on wrong operations parameter
  */
-int arch_install_hw_breakpoint(struct perf_event *bp)
+static int hw_breakpoint_slot_setup(struct perf_event **slots, int max_slo=
ts,
+=09=09=09=09    struct perf_event *bp,
+=09=09=09=09    enum hw_breakpoint_ops ops)
+{
+=09int i;
+=09struct perf_event **slot;
+
+=09for (i =3D 0; i < max_slots; ++i) {
+=09=09slot =3D &slots[i];
+=09=09switch (ops) {
+=09=09case HW_BREAKPOINT_INSTALL:
+=09=09=09if (!*slot) {
+=09=09=09=09*slot =3D bp;
+=09=09=09=09return i;
+=09=09=09}
+=09=09=09break;
+=09=09case HW_BREAKPOINT_UNINSTALL:
+=09=09=09if (*slot =3D=3D bp) {
+=09=09=09=09*slot =3D NULL;
+=09=09=09=09return i;
+=09=09=09}
+=09=09=09break;
+=09=09default:
+=09=09=09pr_warn_once("Unhandled hw breakpoint ops %d\n", ops);
+=09=09=09return -EINVAL;
+=09=09}
+=09}
+=09return -ENOSPC;
+}
+
+static int hw_breakpoint_control(struct perf_event *bp,
+=09=09=09=09 enum hw_breakpoint_ops ops)
 {
 =09struct arch_hw_breakpoint *info =3D counter_arch_bp(bp);
-=09struct perf_event **slot, **slots;
+=09struct perf_event **slots;
 =09struct debug_info *debug_info =3D &current->thread.debug;
 =09int i, max_slots, ctrl_reg, val_reg, reg_enable;
+=09enum debug_el dbg_el =3D debug_exception_level(info->ctrl.privilege);
 =09u32 ctrl;
=20
 =09if (info->ctrl.type =3D=3D ARM_BREAKPOINT_EXECUTE) {
@@ -196,67 +244,53 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
 =09=09reg_enable =3D !debug_info->wps_disabled;
 =09}
=20
-=09for (i =3D 0; i < max_slots; ++i) {
-=09=09slot =3D &slots[i];
+=09i =3D hw_breakpoint_slot_setup(slots, max_slots, bp, ops);
=20
-=09=09if (!*slot) {
-=09=09=09*slot =3D bp;
-=09=09=09break;
-=09=09}
-=09}
+=09if (WARN_ONCE(i < 0, "Can't find any breakpoint slot"))
+=09=09return i;
=20
-=09if (WARN_ONCE(i =3D=3D max_slots, "Can't find any breakpoint slot"))
-=09=09return -ENOSPC;
+=09switch (ops) {
+=09case HW_BREAKPOINT_INSTALL:
+=09=09/*
+=09=09 * Ensure debug monitors are enabled at the correct exception
+=09=09 * level.
+=09=09 */
+=09=09enable_debug_monitors(dbg_el);
=20
-=09/* Ensure debug monitors are enabled at the correct exception level.  *=
/
-=09enable_debug_monitors(debug_exception_level(info->ctrl.privilege));
+=09=09/* Setup the address register. */
+=09=09write_wb_reg(val_reg, i, info->address);
=20
-=09/* Setup the address register. */
-=09write_wb_reg(val_reg, i, info->address);
+=09=09/* Setup the control register. */
+=09=09ctrl =3D encode_ctrl_reg(info->ctrl);
+=09=09write_wb_reg(ctrl_reg, i,
+=09=09=09     reg_enable ? ctrl | 0x1 : ctrl & ~0x1);
+=09=09break;
+=09case HW_BREAKPOINT_UNINSTALL:
+=09=09/* Reset the control register. */
+=09=09write_wb_reg(ctrl_reg, i, 0);
=20
-=09/* Setup the control register. */
-=09ctrl =3D encode_ctrl_reg(info->ctrl);
-=09write_wb_reg(ctrl_reg, i, reg_enable ? ctrl | 0x1 : ctrl & ~0x1);
+=09=09/*
+=09=09 * Release the debug monitors for the correct exception
+=09=09 * level.
+=09=09 */
+=09=09disable_debug_monitors(dbg_el);
+=09=09break;
+=09}
=20
 =09return 0;
 }
=20
-void arch_uninstall_hw_breakpoint(struct perf_event *bp)
+/*
+ * Install a perf counter breakpoint.
+ */
+int arch_install_hw_breakpoint(struct perf_event *bp)
 {
-=09struct arch_hw_breakpoint *info =3D counter_arch_bp(bp);
-=09struct perf_event **slot, **slots;
-=09int i, max_slots, base;
-
-=09if (info->ctrl.type =3D=3D ARM_BREAKPOINT_EXECUTE) {
-=09=09/* Breakpoint */
-=09=09base =3D AARCH64_DBG_REG_BCR;
-=09=09slots =3D __get_cpu_var(bp_on_reg);
-=09=09max_slots =3D core_num_brps;
-=09} else {
-=09=09/* Watchpoint */
-=09=09base =3D AARCH64_DBG_REG_WCR;
-=09=09slots =3D __get_cpu_var(wp_on_reg);
-=09=09max_slots =3D core_num_wrps;
-=09}
-
-=09/* Remove the breakpoint. */
-=09for (i =3D 0; i < max_slots; ++i) {
-=09=09slot =3D &slots[i];
-
-=09=09if (*slot =3D=3D bp) {
-=09=09=09*slot =3D NULL;
-=09=09=09break;
-=09=09}
-=09}
-
-=09if (WARN_ONCE(i =3D=3D max_slots, "Can't find any breakpoint slot"))
-=09=09return;
-
-=09/* Reset the control register. */
-=09write_wb_reg(base, i, 0);
+=09return hw_breakpoint_control(bp, HW_BREAKPOINT_INSTALL);
+}
=20
-=09/* Release the debug monitors for the correct exception level.  */
-=09disable_debug_monitors(debug_exception_level(info->ctrl.privilege));
+void arch_uninstall_hw_breakpoint(struct perf_event *bp)
+{
+=09hw_breakpoint_control(bp, HW_BREAKPOINT_UNINSTALL);
 }
=20
 static int get_hbp_len(u8 hbp_len)
--=20
1.8.3.4


