From: Kapileshwar Singh <kapileshwar.singh@arm.com>
Subject: [PATCH 2/2] thermal: cpu_cooling: Fix power calculation when CPUs are offline
Date: Wed, 11 Mar 2015 17:53:37 +0000
Message-ID: <1426096417-27522-3-git-send-email-kapileshwar.singh@arm.com>
References: <1426096417-27522-1-git-send-email-kapileshwar.singh@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:37281 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751639AbbCKRxr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 11 Mar 2015 13:53:47 -0400
In-Reply-To: <1426096417-27522-1-git-send-email-kapileshwar.singh@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: edubezval@gmail.com, rui.zhang@intel.com, Javi.Merino@arm.com, Punit.Agrawal@arm.com, kapileshwar.singh@arm.com

Ensure that the CPU for which the frequency is being requested
is online. If none of the CPUs are online the requested power is
returned as 0.

Acked-by: Javi Merino <javi.merino@arm.com>
Signed-off-by: Kapileshwar Singh <kapileshwar.singh@arm.com>
---
 drivers/thermal/cpu_cooling.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 2e15133b4793..07a9629edf4b 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -555,7 +555,18 @@ static int cpufreq_get_requested_power(struct thermal_=
cooling_device *cdev,
 =09struct cpufreq_cooling_device *cpufreq_device =3D cdev->devdata;
 =09u32 *load_cpu =3D NULL;
=20
-=09freq =3D cpufreq_quick_get(cpumask_any(&cpufreq_device->allowed_cpus));
+=09cpu =3D cpumask_any_and(&cpufreq_device->allowed_cpus, cpu_online_mask)=
;
+
+=09/*
+=09 * All the CPUs are offline, thus the requested power by
+=09 * the cdev is 0
+=09 */
+=09if (cpu >=3D nr_cpu_ids) {
+=09=09*power =3D 0;
+=09=09return 0;
+=09}
+
+=09freq =3D cpufreq_quick_get(cpu);
=20
 =09if (trace_thermal_power_cpu_get_power_enabled()) {
 =09=09u32 ncpus =3D cpumask_weight(&cpufreq_device->allowed_cpus);
--=20
1.7.9.5


