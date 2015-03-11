From: Kapileshwar Singh <kapileshwar.singh@arm.com>
Subject: [PATCH 1/2] thermal: cpu_cooling: Remove cpu_dev update on policy CPU update
Date: Wed, 11 Mar 2015 17:53:36 +0000
Message-ID: <1426096417-27522-2-git-send-email-kapileshwar.singh@arm.com>
References: <1426096417-27522-1-git-send-email-kapileshwar.singh@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:37270 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052AbbCKRxr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 11 Mar 2015 13:53:47 -0400
In-Reply-To: <1426096417-27522-1-git-send-email-kapileshwar.singh@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: edubezval@gmail.com, rui.zhang@intel.com, Javi.Merino@arm.com, Punit.Agrawal@arm.com, kapileshwar.singh@arm.com

It was initially understood that an update to the cpu_device
(cached in cpufreq_cooling_device) was required to ascertain the
correct operating point of the device on a cpufreq policy->cpu update
or creation or deletion of a cpufreq policy.
(e.g. when the existing policy CPU goes offline).

This was added in:

e0128d8ab423 - thermal: cpu_cooling: implement the power cooling device API

This update is not required and it is possible to ascertain the OPPs
from the leading CPU in a cpufreq domain even if the CPU is hotplugged out.

Acked-by: Javi Merino <javi.merino@arm.com>
Signed-off-by: Kapileshwar Singh <kapileshwar.singh@arm.com>
---
 drivers/thermal/cpu_cooling.c |   40 -------------------------------------=
---
 1 file changed, 40 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index c4974144c787..2e15133b4793 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -199,39 +199,6 @@ unsigned long cpufreq_cooling_get_level(unsigned int c=
pu, unsigned int freq)
 }
 EXPORT_SYMBOL_GPL(cpufreq_cooling_get_level);
=20
-static void update_cpu_device(int cpu)
-{
-=09struct cpufreq_cooling_device *cpufreq_dev;
-
-=09mutex_lock(&cooling_cpufreq_lock);
-=09list_for_each_entry(cpufreq_dev, &cpufreq_dev_list, node) {
-=09=09if (cpumask_test_cpu(cpu, &cpufreq_dev->allowed_cpus)) {
-=09=09=09cpufreq_dev->cpu_dev =3D get_cpu_device(cpu);
-=09=09=09if (!cpufreq_dev->cpu_dev) {
-=09=09=09=09dev_warn(&cpufreq_dev->cool_dev->device,
-=09=09=09=09=09"No cpu device for new policy cpu %d\n",
-=09=09=09=09=09 cpu);
-=09=09=09}
-=09=09=09break;
-=09=09}
-=09}
-=09mutex_unlock(&cooling_cpufreq_lock);
-}
-
-static void remove_cpu_device(int cpu)
-{
-=09struct cpufreq_cooling_device *cpufreq_dev;
-
-=09mutex_lock(&cooling_cpufreq_lock);
-=09list_for_each_entry(cpufreq_dev, &cpufreq_dev_list, node) {
-=09=09if (cpumask_test_cpu(cpu, &cpufreq_dev->allowed_cpus)) {
-=09=09=09cpufreq_dev->cpu_dev =3D NULL;
-=09=09=09break;
-=09=09}
-=09}
-=09mutex_unlock(&cooling_cpufreq_lock);
-}
-
 /**
  * cpufreq_thermal_notifier - notifier callback for cpufreq policy change.
  * @nb:=09struct notifier_block * with callback info.
@@ -268,13 +235,6 @@ static int cpufreq_thermal_notifier(struct notifier_bl=
ock *nb,
 =09=09}
 =09=09mutex_unlock(&cooling_cpufreq_lock);
 =09=09break;
-
-=09case CPUFREQ_CREATE_POLICY:
-=09=09update_cpu_device(policy->cpu);
-=09=09break;
-=09case CPUFREQ_REMOVE_POLICY:
-=09=09remove_cpu_device(policy->cpu);
-=09=09break;
 =09default:
 =09=09return NOTIFY_DONE;
 =09}
--=20
1.7.9.5


