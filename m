From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH] arm: vexpress: tc2: fix CPU hotplug and CPU idle race on cluster power down
Date: Fri, 27 Sep 2013 15:29:13 +0100
Message-ID: <1380292153-10480-1-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:34890 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752155Ab3I0O3X (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 27 Sep 2013 10:29:23 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>, Kevin Hilman <khilman@linaro.org>, Olof Johansson <olof@lixom.net>, Nicolas Pitre <nicolas.pitre@linaro.org>, Dave Martin <dave.martin@arm.com>

On the TC2 testchip, when all CPUs in a cluster enter standbywfi and
commit a power down request, the power controller will wait for
standbywfil2 coming from L2 cache controller to shut the cluster down.
By the time all CPUs in a cluster commit a power down request and enter wfi=
,
the power controller cannot backtrack, or put it another way, a CPU must
not be allowed to complete execution independently of the power
controller, the only way for it to resume properly must be upon wake-up IRQ
pending and subsequent reset triggered from the power controller.

Current MCPM back-end for TC2 disables the GIC CPU IF only when power
down is committed through the suspend method, that makes sense since a
suspended CPU is still online and can receive interrupts whereas a
hotplugged CPU, since it is offline, migrated all IRQs and shutdown
the per-CPU peripherals, hence their PPIs.

The flaw with this reasoning is the following. If all CPUs in a clusters ar=
e
entering a power down state either through CPU idle or CPU hotplug, when th=
e
last man successfully completes the MCPM power down sequence (and executes
wfi), power controller waits for L2 wfi signal to quiesce the cluster and s=
hut
it down. If, when all CPUs are sitting in wfi, an online CPU hotplugs back =
in
one of the CPUs in the cluster being shutdown, that CPU receives an IPI tha=
t
causes wfi to complete (since MCPM power down method does not disable the G=
IC
CPU IF in that case - CPU being hotplugged out, not idle) and the power
controller will never see the stanbywfil2 signal coming from L2 that is
required for shutdown to happen and the system deadlocks.

The only solution to this problem consists in disabling the GIC CPU IF
on a CPU committed to power down regardless of the power down entry
method (CPU hotplug or CPU idle). This way, CPU wake-up is under power
controller control, which prevents unexpected wfi exit caused by a
pending IRQ.

This patch moves the GIC CPU IF disable call in the TC2 MCPM implementation
from the suspend method to the power down method to fix the mentioned
race condition.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
---
 arch/arm/mach-vexpress/tc2_pm.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-vexpress/tc2_pm.c b/arch/arm/mach-vexpress/tc2_p=
m.c
index 7aeb5d6..e6eb481 100644
--- a/arch/arm/mach-vexpress/tc2_pm.c
+++ b/arch/arm/mach-vexpress/tc2_pm.c
@@ -131,6 +131,16 @@ static void tc2_pm_down(u64 residency)
 =09} else
 =09=09BUG();
=20
+=09/*
+=09 * If the CPU is committed to power down, make sure
+=09 * the power controller will be in charge of waking it
+=09 * up upon IRQ, ie IRQ lines are cut from GIC CPU IF
+=09 * to the CPU by disabling the GIC CPU IF to prevent wfi
+=09 * from completing execution behind power controller back
+=09 */
+=09if (!skip_wfi)
+=09=09gic_cpu_if_down();
+
 =09if (last_man && __mcpm_outbound_enter_critical(cpu, cluster)) {
 =09=09arch_spin_unlock(&tc2_pm_lock);
=20
@@ -231,7 +241,6 @@ static void tc2_pm_suspend(u64 residency)
 =09cpu =3D MPIDR_AFFINITY_LEVEL(mpidr, 0);
 =09cluster =3D MPIDR_AFFINITY_LEVEL(mpidr, 1);
 =09ve_spc_set_resume_addr(cluster, cpu, virt_to_phys(mcpm_entry_point));
-=09gic_cpu_if_down();
 =09tc2_pm_down(residency);
 }
=20
--=20
1.8.2.2


