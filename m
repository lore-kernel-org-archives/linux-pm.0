From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH v2 06/13] arm64: kernel: implement fpsimd CPU PM notifier
Date: Mon, 14 Oct 2013 12:03:03 +0100
Message-ID: <1381748590-14279-7-git-send-email-lorenzo.pieralisi@arm.com>
References: <1381748590-14279-1-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:57058 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755857Ab3JNLCd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Oct 2013 07:02:33 -0400
In-Reply-To: <1381748590-14279-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Dave Martin <dave.martin@arm.com>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Mark Rutland <mark.rutland@arm.com>, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>, Russell King <linux@arm.linux.org.uk>, Colin Cross <ccross@android.com>, Yu Tang <ytang5@marvell.com>, Zhou Zhu <zzhu3@marvell.com>, Kumar Sankaran <ksankaran@apm.com>, Loc Ho <lho@apm.com>, Feng Kan <fkan@apm.com>, Nicolas Pitre <nico@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, Graeme Gregory <graeme.gregory@linaro.org>, Hanjun Guo <hanjun.guo@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>

When a CPU enters a low power state, its FP register content is lost.
This patch adds a notifier to save the FP context on CPU shutdown
and restore it on CPU resume. The context is saved and restored only
if the suspending thread is not a kernel thread, mirroring the current
context switch behaviour.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm64/kernel/fpsimd.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index bb785d2..4aef42a 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -17,6 +17,7 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
=20
+#include <linux/cpu_pm.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/sched.h>
@@ -113,6 +114,39 @@ EXPORT_SYMBOL(kernel_neon_end);
=20
 #endif /* CONFIG_KERNEL_MODE_NEON */
=20
+#ifdef CONFIG_CPU_PM
+static int fpsimd_cpu_pm_notifier(struct notifier_block *self,
+=09=09=09=09  unsigned long cmd, void *v)
+{
+=09switch (cmd) {
+=09case CPU_PM_ENTER:
+=09=09if (current->mm)
+=09=09=09fpsimd_save_state(&current->thread.fpsimd_state);
+=09=09break;
+=09case CPU_PM_EXIT:
+=09=09if (current->mm)
+=09=09=09fpsimd_load_state(&current->thread.fpsimd_state);
+=09=09break;
+=09case CPU_PM_ENTER_FAILED:
+=09default:
+=09=09return NOTIFY_DONE;
+=09}
+=09return NOTIFY_OK;
+}
+
+static struct notifier_block fpsimd_cpu_pm_notifier_block =3D {
+=09.notifier_call =3D fpsimd_cpu_pm_notifier,
+};
+
+static void fpsimd_pm_init(void)
+{
+=09cpu_pm_register_notifier(&fpsimd_cpu_pm_notifier_block);
+}
+
+#else
+static inline void fpsimd_pm_init(void) { }
+#endif /* CONFIG_CPU_PM */
+
 /*
  * FP/SIMD support code initialisation.
  */
@@ -131,6 +165,8 @@ static int __init fpsimd_init(void)
 =09else
 =09=09elf_hwcap |=3D HWCAP_ASIMD;
=20
+=09fpsimd_pm_init();
+
 =09return 0;
 }
 late_initcall(fpsimd_init);
--=20
1.8.4


