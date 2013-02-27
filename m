From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 3/3] cpufreq: governors: Avoid unnecessary per cpu timer interrupts
Date: Wed, 27 Feb 2013 16:59:12 +0530
Message-ID: <a7469422cc31973c889fd01f1b4541e7ec5dd2d5.1361964515.git.viresh.kumar@linaro.org>
References: <5249868a014d716eb38cc90e04ed0f6051e65fc3.1361964515.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:58387 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759385Ab3B0L3e (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 Feb 2013 06:29:34 -0500
In-Reply-To: <5249868a014d716eb38cc90e04ed0f6051e65fc3.1361964515.git.viresh.kumar@linaro.org>
In-Reply-To: <5249868a014d716eb38cc90e04ed0f6051e65fc3.1361964515.git.viresh.kumar@linaro.org>
References: <5249868a014d716eb38cc90e04ed0f6051e65fc3.1361964515.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, rickard.andersson@stericsson.com, fabio.baltieri@linaro.org, Viresh Kumar <viresh.kumar@linaro.org>

Following patch has introduced per cpu timers or works for ondemand and
conservative governors.

=09commit 2abfa876f1117b0ab45f191fb1f82c41b1cbc8fe
=09Author: Rickard Andersson <rickard.andersson@stericsson.com>
=09Date:   Thu Dec 27 14:55:38 2012 +0000

=09    cpufreq: handle SW coordinated CPUs

This causes additional unnecessary interrupts on all cpus when the load is
recently evaluated by any other cpu. i.e. When load is recently evaluated b=
y cpu
x, we don't really need any other cpu to evaluate this load again for the n=
ext
sampling_rate time.

Some sort of code is present to avoid that but we are still getting timer
interrupts for all cpus. A good way of avoiding this would be to modify del=
ays
for all cpus (policy->cpus) whenever any cpu has evaluated load.

This patch does this change and some related code cleanup.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_conservative.c | 10 ++++++---
 drivers/cpufreq/cpufreq_governor.c     | 38 ++++++++++++++++++++++++------=
----
 drivers/cpufreq/cpufreq_governor.h     |  2 ++
 drivers/cpufreq/cpufreq_ondemand.c     | 13 +++++++-----
 4 files changed, 44 insertions(+), 19 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufr=
eq_conservative.c
index 4fd0006..de5f66a 100644
--- a/drivers/cpufreq/cpufreq_conservative.c
+++ b/drivers/cpufreq/cpufreq_conservative.c
@@ -113,19 +113,23 @@ static void cs_check_cpu(int cpu, unsigned int load)
=20
 static void cs_dbs_timer(struct work_struct *work)
 {
-=09struct delayed_work *dw =3D to_delayed_work(work);
 =09struct cs_cpu_dbs_info_s *dbs_info =3D container_of(work,
 =09=09=09struct cs_cpu_dbs_info_s, cdbs.work.work);
 =09unsigned int cpu =3D dbs_info->cdbs.cur_policy->cpu;
 =09struct cs_cpu_dbs_info_s *core_dbs_info =3D &per_cpu(cs_cpu_dbs_info,
 =09=09=09cpu);
 =09int delay =3D delay_for_sampling_rate(cs_tuners.sampling_rate);
+=09bool modify_all =3D true;
=20
 =09mutex_lock(&core_dbs_info->cdbs.timer_mutex);
-=09if (need_load_eval(&core_dbs_info->cdbs, cs_tuners.sampling_rate))
+=09if (!need_load_eval(&core_dbs_info->cdbs, cs_tuners.sampling_rate))
+=09=09modify_all =3D false;
+=09else
 =09=09dbs_check_cpu(&cs_dbs_data, cpu);
=20
-=09schedule_delayed_work_on(smp_processor_id(), dw, delay);
+=09gov_queue_work(&cs_dbs_data, dbs_info->cdbs.cur_policy, delay,
+=09=09=09modify_all);
+
 =09mutex_unlock(&core_dbs_info->cdbs.timer_mutex);
 }
=20
diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_g=
overnor.c
index 5a76086..f0747f1 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -161,20 +161,37 @@ void dbs_check_cpu(struct dbs_data *dbs_data, int cpu=
)
 }
 EXPORT_SYMBOL_GPL(dbs_check_cpu);
=20
-static inline void dbs_timer_init(struct dbs_data *dbs_data, int cpu,
-=09=09=09=09  unsigned int sampling_rate)
+static inline void __gov_queue_work(int cpu, struct dbs_data *dbs_data,
+=09=09unsigned int delay)
 {
-=09int delay =3D delay_for_sampling_rate(sampling_rate);
 =09struct cpu_dbs_common_info *cdbs =3D dbs_data->get_cpu_cdbs(cpu);
=20
-=09schedule_delayed_work_on(cpu, &cdbs->work, delay);
+=09mod_scheduled_delayed_work_on(cpu, &cdbs->work, delay);
 }
=20
-static inline void dbs_timer_exit(struct dbs_data *dbs_data, int cpu)
+void gov_queue_work(struct dbs_data *dbs_data, struct cpufreq_policy *poli=
cy,
+=09=09unsigned int delay, bool all_cpus)
 {
-=09struct cpu_dbs_common_info *cdbs =3D dbs_data->get_cpu_cdbs(cpu);
+=09int i;
+
+=09if (!all_cpus) {
+=09=09__gov_queue_work(smp_processor_id(), dbs_data, delay);
+=09} else {
+=09=09for_each_cpu(i, policy->cpus)
+=09=09=09__gov_queue_work(i, dbs_data, delay);
+=09}
+}
+EXPORT_SYMBOL_GPL(gov_queue_work);
+
+void gov_cancel_work(struct dbs_data *dbs_data, struct cpufreq_policy *pol=
icy)
+{
+=09struct cpu_dbs_common_info *cdbs;
+=09int i;
=20
-=09cancel_delayed_work_sync(&cdbs->work);
+=09for_each_cpu(i, policy->cpus) {
+=09=09cdbs =3D dbs_data->get_cpu_cdbs(i);
+=09=09cancel_delayed_work_sync(&cdbs->work);
+=09}
 }
=20
 /* Will return if we need to evaluate cpu load again or not */
@@ -301,16 +318,15 @@ unlock:
 =09=09/* Initiate timer time stamp */
 =09=09cpu_cdbs->time_stamp =3D ktime_get();
=20
-=09=09for_each_cpu(j, policy->cpus)
-=09=09=09dbs_timer_init(dbs_data, j, *sampling_rate);
+=09=09gov_queue_work(dbs_data, policy,
+=09=09=09=09delay_for_sampling_rate(*sampling_rate), true);
 =09=09break;
=20
 =09case CPUFREQ_GOV_STOP:
 =09=09if (dbs_data->governor =3D=3D GOV_CONSERVATIVE)
 =09=09=09cs_dbs_info->enable =3D 0;
=20
-=09=09for_each_cpu(j, policy->cpus)
-=09=09=09dbs_timer_exit(dbs_data, j);
+=09=09gov_cancel_work(dbs_data, policy);
=20
 =09=09mutex_lock(&dbs_data->mutex);
 =09=09mutex_destroy(&cpu_cdbs->timer_mutex);
diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_g=
overnor.h
index d2ac911..8c0116e 100644
--- a/drivers/cpufreq/cpufreq_governor.h
+++ b/drivers/cpufreq/cpufreq_governor.h
@@ -175,4 +175,6 @@ bool need_load_eval(struct cpu_dbs_common_info *cdbs,
 =09=09unsigned int sampling_rate);
 int cpufreq_governor_dbs(struct dbs_data *dbs_data,
 =09=09struct cpufreq_policy *policy, unsigned int event);
+void gov_queue_work(struct dbs_data *dbs_data, struct cpufreq_policy *poli=
cy,
+=09=09unsigned int delay, bool all_cpus);
 #endif /* _CPUFREQ_GOVERNER_H */
diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_o=
ndemand.c
index a815c88..7d9cfdb 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -217,17 +217,19 @@ static void od_check_cpu(int cpu, unsigned int load_f=
req)
=20
 static void od_dbs_timer(struct work_struct *work)
 {
-=09struct delayed_work *dw =3D to_delayed_work(work);
 =09struct od_cpu_dbs_info_s *dbs_info =3D
 =09=09container_of(work, struct od_cpu_dbs_info_s, cdbs.work.work);
 =09unsigned int cpu =3D dbs_info->cdbs.cur_policy->cpu;
 =09struct od_cpu_dbs_info_s *core_dbs_info =3D &per_cpu(od_cpu_dbs_info,
 =09=09=09cpu);
 =09int delay =3D 0, sample_type =3D core_dbs_info->sample_type;
+=09bool modify_all =3D true;
=20
 =09mutex_lock(&core_dbs_info->cdbs.timer_mutex);
-=09if (!need_load_eval(&core_dbs_info->cdbs, od_tuners.sampling_rate))
+=09if (!need_load_eval(&core_dbs_info->cdbs, od_tuners.sampling_rate)) {
+=09=09modify_all =3D false;
 =09=09goto max_delay;
+=09}
=20
 =09/* Common NORMAL_SAMPLE setup */
 =09core_dbs_info->sample_type =3D OD_NORMAL_SAMPLE;
@@ -249,7 +251,8 @@ max_delay:
 =09=09delay =3D delay_for_sampling_rate(od_tuners.sampling_rate
 =09=09=09=09* core_dbs_info->rate_mult);
=20
-=09schedule_delayed_work_on(smp_processor_id(), dw, delay);
+=09gov_queue_work(&od_dbs_data, dbs_info->cdbs.cur_policy, delay,
+=09=09=09modify_all);
 =09mutex_unlock(&core_dbs_info->cdbs.timer_mutex);
 }
=20
@@ -312,8 +315,8 @@ static void update_sampling_rate(unsigned int new_rate)
 =09=09=09cancel_delayed_work_sync(&dbs_info->cdbs.work);
 =09=09=09mutex_lock(&dbs_info->cdbs.timer_mutex);
=20
-=09=09=09schedule_delayed_work_on(cpu, &dbs_info->cdbs.work,
-=09=09=09=09=09usecs_to_jiffies(new_rate));
+=09=09=09gov_queue_work(&od_dbs_data, dbs_info->cdbs.cur_policy,
+=09=09=09=09=09usecs_to_jiffies(new_rate), true);
=20
 =09=09}
 =09=09mutex_unlock(&dbs_info->cdbs.timer_mutex);
--=20
1.7.12.rc2.18.g61b472e


