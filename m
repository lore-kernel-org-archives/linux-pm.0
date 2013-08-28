From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [RFC PATCH 08/14] arm: kvm: implement CPU PM notifier
Date: Wed, 28 Aug 2013 12:36:00 +0100
Message-ID: <1377689766-17642-9-git-send-email-lorenzo.pieralisi@arm.com>
References: <1377689766-17642-1-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:38834 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755045Ab3H1LgJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 28 Aug 2013 07:36:09 -0400
In-Reply-To: <1377689766-17642-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Dave Martin <dave.martin@arm.com>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Mark Rutland <mark.rutland@arm.com>, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>, Russell King <linux@arm.linux.org.uk>, Colin Cross <ccross@android.com>, Yu Tang <ytang5@marvell.com>, Zhou Zhu <zzhu3@marvell.com>, Kumar Sankaran <ksankaran@apm.com>, Loc Ho <lho@apm.com>, Feng Kan <fkan@apm.com>, Nicolas Pitre <nico@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, Graeme Gregory <graeme.gregory@linaro.org>, Hanjun Guo <hanjun.guo@linaro.org>

Upon CPU shutdown and consequent warm-reboot, the hypervisor CPU state
must be re-initialized. This patch implements a CPU PM notifier that
upon warm-boot calls a KVM hook to reinitialize properly the hypervisor
state so that the CPU can be safely resumed.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kvm/arm.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 741f66a..6ee62b0 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -17,6 +17,7 @@
  */
=20
 #include <linux/cpu.h>
+#include <linux/cpu_pm.h>
 #include <linux/errno.h>
 #include <linux/err.h>
 #include <linux/kvm_host.h>
@@ -835,6 +836,33 @@ static struct notifier_block hyp_init_cpu_nb =3D {
 =09.notifier_call =3D hyp_init_cpu_notify,
 };
=20
+#ifdef CONFIG_CPU_PM
+static int hyp_init_cpu_pm_notifier(struct notifier_block *self,
+=09=09=09=09    unsigned long cmd,
+=09=09=09=09    void *v)
+{
+=09if (cmd =3D=3D CPU_PM_EXIT) {
+=09=09cpu_init_hyp_mode(NULL);
+=09=09return NOTIFY_OK;
+=09}
+
+=09return NOTIFY_DONE;
+}
+
+static struct notifier_block hyp_init_cpu_pm_nb =3D {
+=09.notifier_call =3D hyp_init_cpu_pm_notifier,
+};
+
+static void __init hyp_cpu_pm_init(void)
+{
+=09cpu_pm_register_notifier(&hyp_init_cpu_pm_nb);
+}
+#else
+static inline void hyp_cpu_pm_init(void)
+{
+}
+#endif
+
 /**
  * Inits Hyp-mode on all online CPUs
  */
@@ -995,6 +1023,8 @@ int kvm_arch_init(void *opaque)
 =09=09goto out_err;
 =09}
=20
+=09hyp_cpu_pm_init();
+
 =09kvm_coproc_table_init();
 =09return 0;
 out_err:
--=20
1.8.3.4


