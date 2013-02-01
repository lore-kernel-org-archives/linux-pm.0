From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] cpufreq: governors: Reset tunables only for cpufreq_unregister_governor()
Date: Fri,  1 Feb 2013 11:12:58 +0530
Message-ID: <d9de945975ad2064693275335b4022c8efd013e3.1359697315.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:36854 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752741Ab3BAFnJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 1 Feb 2013 00:43:09 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-dev@lists.linaro.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, fabio.baltieri@linaro.org, Viresh Kumar <viresh.kumar@linaro.org>

Currently, whenever governor->governor() is called for CPUFRREQ_GOV_START e=
vent
we reset few tunables of governor. Which isn't correct, as this routine is
called for every cpu hot-[un]plugging event. We should actually be resettin=
g
these only when the governor module is removed and re-installed.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c          |  4 ++++
 drivers/cpufreq/cpufreq_governor.c | 24 ++++++++++++++++--------
 include/linux/cpufreq.h            |  1 +
 3 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 8d521422..9656420 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1561,6 +1561,9 @@ static int __cpufreq_governor(struct cpufreq_policy *=
policy,
 =09=09=09=09=09=09policy->cpu, event);
 =09ret =3D policy->governor->governor(policy, event);
=20
+=09if (!policy->governor->initialized && (event =3D=3D CPUFREQ_GOV_START))
+=09=09policy->governor->initialized =3D 1;
+
 =09/* we keep one module reference alive for
 =09=09=09each CPU governed by this CPU */
 =09if ((event !=3D CPUFREQ_GOV_START) || ret)
@@ -1584,6 +1587,7 @@ int cpufreq_register_governor(struct cpufreq_governor=
 *governor)
=20
 =09mutex_lock(&cpufreq_governor_mutex);
=20
+=09governor->initialized =3D 0;
 =09err =3D -EBUSY;
 =09if (__find_governor(governor->name) =3D=3D NULL) {
 =09=09err =3D 0;
diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_g=
overnor.c
index 7aaa9b1..79795c4 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -254,11 +254,6 @@ int cpufreq_governor_dbs(struct dbs_data *dbs_data,
 =09=09=09return rc;
 =09=09}
=20
-=09=09/* policy latency is in nS. Convert it to uS first */
-=09=09latency =3D policy->cpuinfo.transition_latency / 1000;
-=09=09if (latency =3D=3D 0)
-=09=09=09latency =3D 1;
-
 =09=09/*
 =09=09 * conservative does not implement micro like ondemand
 =09=09 * governor, thus we are bound to jiffes/HZ
@@ -270,20 +265,33 @@ int cpufreq_governor_dbs(struct dbs_data *dbs_data,
 =09=09=09cpufreq_register_notifier(cs_ops->notifier_block,
 =09=09=09=09=09CPUFREQ_TRANSITION_NOTIFIER);
=20
-=09=09=09dbs_data->min_sampling_rate =3D MIN_SAMPLING_RATE_RATIO *
-=09=09=09=09jiffies_to_usecs(10);
+=09=09=09if (!policy->governor->initialized)
+=09=09=09=09dbs_data->min_sampling_rate =3D
+=09=09=09=09=09MIN_SAMPLING_RATE_RATIO *
+=09=09=09=09=09jiffies_to_usecs(10);
 =09=09} else {
 =09=09=09od_dbs_info->rate_mult =3D 1;
 =09=09=09od_dbs_info->sample_type =3D OD_NORMAL_SAMPLE;
 =09=09=09od_ops->powersave_bias_init_cpu(cpu);
-=09=09=09od_tuners->io_is_busy =3D od_ops->io_busy();
+
+=09=09=09if (!policy->governor->initialized)
+=09=09=09=09od_tuners->io_is_busy =3D od_ops->io_busy();
 =09=09}
=20
+=09=09if (policy->governor->initialized)
+=09=09=09goto unlock;
+
+=09=09/* policy latency is in nS. Convert it to uS first */
+=09=09latency =3D policy->cpuinfo.transition_latency / 1000;
+=09=09if (latency =3D=3D 0)
+=09=09=09latency =3D 1;
+
 =09=09/* Bring kernel and HW constraints together */
 =09=09dbs_data->min_sampling_rate =3D max(dbs_data->min_sampling_rate,
 =09=09=09=09MIN_LATENCY_MULTIPLIER * latency);
 =09=09*sampling_rate =3D max(dbs_data->min_sampling_rate, latency *
 =09=09=09=09LATENCY_MULTIPLIER);
+unlock:
 =09=09mutex_unlock(&dbs_data->mutex);
=20
 =09=09/* Initiate timer time stamp */
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index feb360c..6bf3f2d 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -183,6 +183,7 @@ static inline unsigned long cpufreq_scale(unsigned long=
 old, u_int div, u_int mu
=20
 struct cpufreq_governor {
 =09char=09name[CPUFREQ_NAME_LEN];
+=09int=09initialized;
 =09int=09(*governor)=09(struct cpufreq_policy *policy,
 =09=09=09=09 unsigned int event);
 =09ssize_t=09(*show_setspeed)=09(struct cpufreq_policy *policy,
--=20
1.7.12.rc2.18.g61b472e


