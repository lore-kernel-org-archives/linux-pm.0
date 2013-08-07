From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH v3 2/3] ARM: vexpress: tc2: disable GIC CPU IF in tc2_pm_suspend
Date: Wed,  7 Aug 2013 12:43:32 +0100
Message-ID: <1375875813-13358-3-git-send-email-lorenzo.pieralisi@arm.com>
References: <1375875813-13358-1-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:33191 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932518Ab3HGLnn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 7 Aug 2013 07:43:43 -0400
In-Reply-To: <1375875813-13358-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Kevin Hilman <khilman@linaro.org>, Olof Johansson <olof@lixom.net>, Amit Kucheria <amit.kucheria@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Nicolas Pitre <nicolas.pitre@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Jon Medhurst <tixy@linaro.org>

To prevent cores from exiting wfi when they are about to be shut down
the GIC CPU IF must be disabled so that the GIC CPU IF IRQ output line
is not asserted to the cores. wfi completion must be prevented since,
in absence of coordinating HW logic, if the power controller receives
a standbywfi signal but in the meantime the processor restarts executing
owing to a pending IRQ, the core might be reset when running in a
non-quiescent state (eg with pending load/store transactions)

Raw GIC distributor IRQ signals are routed to the power controller, that
is capable of taking core out of reset on pending IRQs even if their GIC
CPU IF is disabled, thus keeping the normal wfi behaviour.

GIC CPU IF is restored upon CPU wake-up by the respective MCPM API
consumers (ie CPU idle driver and suspend to RAM thread).

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm/mach-vexpress/tc2_pm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-vexpress/tc2_pm.c b/arch/arm/mach-vexpress/tc2_p=
m.c
index dfb55d4..3303ac6 100644
--- a/arch/arm/mach-vexpress/tc2_pm.c
+++ b/arch/arm/mach-vexpress/tc2_pm.c
@@ -16,6 +16,7 @@
 #include <linux/kernel.h>
 #include <linux/spinlock.h>
 #include <linux/errno.h>
+#include <linux/irqchip/arm-gic.h>
=20
 #include <asm/mcpm.h>
 #include <asm/proc-fns.h>
@@ -211,6 +212,7 @@ static void tc2_pm_suspend(u64 residency)
 =09cpu =3D MPIDR_AFFINITY_LEVEL(mpidr, 0);
 =09cluster =3D MPIDR_AFFINITY_LEVEL(mpidr, 1);
 =09ve_spc_set_resume_addr(cluster, cpu, virt_to_phys(mcpm_entry_point));
+=09gic_cpu_if_down();
 =09tc2_pm_down(residency);
 }
=20
--=20
1.8.2.2


