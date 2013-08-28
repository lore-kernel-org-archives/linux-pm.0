From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [RFC PATCH 09/14] arm64: kernel: implement debug monitors CPU PM notifiers
Date: Wed, 28 Aug 2013 12:36:01 +0100
Message-ID: <1377689766-17642-10-git-send-email-lorenzo.pieralisi@arm.com>
References: <1377689766-17642-1-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:39002 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753718Ab3H1LgM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 28 Aug 2013 07:36:12 -0400
In-Reply-To: <1377689766-17642-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Dave Martin <dave.martin@arm.com>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Mark Rutland <mark.rutland@arm.com>, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>, Russell King <linux@arm.linux.org.uk>, Colin Cross <ccross@android.com>, Yu Tang <ytang5@marvell.com>, Zhou Zhu <zzhu3@marvell.com>, Kumar Sankaran <ksankaran@apm.com>, Loc Ho <lho@apm.com>, Feng Kan <fkan@apm.com>, Nicolas Pitre <nico@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, Graeme Gregory <graeme.gregory@linaro.org>, Hanjun Guo <hanjun.guo@linaro.org>

When a CPU is shutdown either through CPU idle or suspend to RAM, the
content of debug monitor registers must be reset or restored to proper
values when CPU resume from low power states. This patch implements a
CPU PM notifier that allows to restore the content of debug monitor
registers to allow proper suspend/resume operations.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm64/kernel/debug-monitors.c | 38 ++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-m=
onitors.c
index cbfacf7..f78148f 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -19,6 +19,7 @@
  */
=20
 #include <linux/cpu.h>
+#include <linux/cpu_pm.h>
 #include <linux/debugfs.h>
 #include <linux/hardirq.h>
 #include <linux/init.h>
@@ -154,6 +155,42 @@ static struct notifier_block os_lock_nb =3D {
 =09.notifier_call =3D os_lock_notify,
 };
=20
+#ifdef CONFIG_CPU_PM
+static DEFINE_PER_CPU(u32, mdscr);
+
+static int dm_cpu_pm_notify(struct notifier_block *self, unsigned long act=
ion,
+=09=09=09     void *v)
+{
+=09switch (action) {
+=09case CPU_PM_ENTER:
+=09=09__get_cpu_var(mdscr) =3D mdscr_read();
+=09=09break;
+=09case CPU_PM_EXIT:
+=09=09clear_os_lock(NULL);
+=09=09mdscr_write(__get_cpu_var(mdscr));
+=09=09break;
+=09case CPU_PM_ENTER_FAILED:
+=09default:
+=09=09return NOTIFY_DONE;
+=09}
+
+=09return NOTIFY_OK;
+}
+
+static struct notifier_block dm_cpu_pm_nb =3D {
+=09.notifier_call =3D dm_cpu_pm_notify,
+};
+
+static void __init debug_monitors_pm_init(void)
+{
+=09cpu_pm_register_notifier(&dm_cpu_pm_nb);
+}
+#else
+static inline void debug_monitors_pm_init(void)
+{
+}
+#endif
+
 static int debug_monitors_init(void)
 {
 =09/* Clear the OS lock. */
@@ -162,6 +199,7 @@ static int debug_monitors_init(void)
=20
 =09/* Register hotplug handler. */
 =09register_cpu_notifier(&os_lock_nb);
+=09debug_monitors_pm_init();
 =09return 0;
 }
 postcore_initcall(debug_monitors_init);
--=20
1.8.3.4


