From: Juri Lelli <juri.lelli@arm.com>
Subject: [PATCH] cpuidle/cpuidle-big_little: fix reading cpu id part number
Date: Fri,  8 Aug 2014 13:42:37 +0100
Message-ID: <1407501757-15231-1-git-send-email-juri.lelli@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:46482 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756722AbaHHMoo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 8 Aug 2014 08:44:44 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: lorenzo.pieralisi@arm.com, Juri Lelli <juri.lelli@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Russell King <rmk+kernel@arm.linux.org.uk>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Juri Lelli <juri.lelli@gmail.com>

Commit af040ffc9ba1 ("ARM: make it easier to check the CPU part number
correctly") changed ARM_CPU_PART_X masks, and the way they are returned and
checked against. Usage of read_cpuid_part_number() is now deprecated, and
calling places updated accordingly. This actually broke cpuidle-big_little
initialization, as bl_idle_driver_init() performs a check using and hardcod=
ed
mask on cpu_id.

Update the check to reflect changes on ARM_CPU_PART_X masks. Also,
make the check easier to understand.

Signed-off-by: Juri Lelli <juri.lelli@arm.com>
Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: Juri Lelli <juri.lelli@gmail.com>
---
 drivers/cpuidle/cpuidle-big_little.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-big_little.c b/drivers/cpuidle/cpuidle=
-big_little.c
index b45fc62..a712896 100644
--- a/drivers/cpuidle/cpuidle-big_little.c
+++ b/drivers/cpuidle/cpuidle-big_little.c
@@ -138,7 +138,7 @@ static int bl_enter_powerdown(struct cpuidle_device *de=
v,
 =09return idx;
 }
=20
-static int __init bl_idle_driver_init(struct cpuidle_driver *drv, int cpu_=
id)
+static int __init bl_idle_driver_init(struct cpuidle_driver *drv, int matc=
h_id)
 {
 =09struct cpuinfo_arm *cpu_info;
 =09struct cpumask *cpumask;
@@ -154,7 +154,7 @@ static int __init bl_idle_driver_init(struct cpuidle_dr=
iver *drv, int cpu_id)
 =09=09cpuid =3D is_smp() ? cpu_info->cpuid : read_cpuid_id();
=20
 =09=09/* read cpu id part number */
-=09=09if ((cpuid & 0xFFF0) =3D=3D cpu_id)
+=09=09if (((cpuid ^ match_id) & 0xFF00FFF0) =3D=3D 0)
 =09=09=09cpumask_set_cpu(cpu, cpumask);
 =09}
=20
--=20
1.7.9.5


