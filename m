From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 2/3] cpufreq: ondemand: Don't update sample_type if we don't evaluate load again
Date: Wed, 27 Feb 2013 16:59:11 +0530
Message-ID: <d7420494c2b37fa34869a38f09abe3f8c4575448.1361964515.git.viresh.kumar@linaro.org>
References: <5249868a014d716eb38cc90e04ed0f6051e65fc3.1361964515.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5249868a014d716eb38cc90e04ed0f6051e65fc3.1361964515.git.viresh.kumar@linaro.org>
In-Reply-To: <5249868a014d716eb38cc90e04ed0f6051e65fc3.1361964515.git.viresh.kumar@linaro.org>
References: <5249868a014d716eb38cc90e04ed0f6051e65fc3.1361964515.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, rickard.andersson@stericsson.com, fabio.baltieri@linaro.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Because we have per cpu timer now, we check if we need to evaluate load aga=
in or
not (In case it is recently evaluated). Here the 2nd cpu which got timer
interrupt updates core_dbs_info->sample_type irrespective of load evaluatio=
n is
required or not. Which is wrong as the first cpu is dependent on this varia=
ble
set to an older value.

Moreover it would be best in this case to schedule 2nd cpu's timer to
sampling_rate instead of freq_lo or hi as that must be managed by the other=
 cpu.
In case the other cpu idles in between then also we wouldn't loose much pow=
er.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_ondemand.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_o=
ndemand.c
index f3eb26c..a815c88 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -223,34 +223,32 @@ static void od_dbs_timer(struct work_struct *work)
 =09unsigned int cpu =3D dbs_info->cdbs.cur_policy->cpu;
 =09struct od_cpu_dbs_info_s *core_dbs_info =3D &per_cpu(od_cpu_dbs_info,
 =09=09=09cpu);
-=09int delay, sample_type =3D core_dbs_info->sample_type;
-=09bool eval_load;
+=09int delay =3D 0, sample_type =3D core_dbs_info->sample_type;
=20
 =09mutex_lock(&core_dbs_info->cdbs.timer_mutex);
-=09eval_load =3D need_load_eval(&core_dbs_info->cdbs,
-=09=09=09od_tuners.sampling_rate);
+=09if (!need_load_eval(&core_dbs_info->cdbs, od_tuners.sampling_rate))
+=09=09goto max_delay;
=20
 =09/* Common NORMAL_SAMPLE setup */
 =09core_dbs_info->sample_type =3D OD_NORMAL_SAMPLE;
 =09if (sample_type =3D=3D OD_SUB_SAMPLE) {
 =09=09delay =3D core_dbs_info->freq_lo_jiffies;
-=09=09if (eval_load)
-=09=09=09__cpufreq_driver_target(core_dbs_info->cdbs.cur_policy,
-=09=09=09=09=09=09core_dbs_info->freq_lo,
-=09=09=09=09=09=09CPUFREQ_RELATION_H);
+=09=09__cpufreq_driver_target(core_dbs_info->cdbs.cur_policy,
+=09=09=09=09core_dbs_info->freq_lo, CPUFREQ_RELATION_H);
 =09} else {
-=09=09if (eval_load)
-=09=09=09dbs_check_cpu(&od_dbs_data, cpu);
+=09=09dbs_check_cpu(&od_dbs_data, cpu);
 =09=09if (core_dbs_info->freq_lo) {
 =09=09=09/* Setup timer for SUB_SAMPLE */
 =09=09=09core_dbs_info->sample_type =3D OD_SUB_SAMPLE;
 =09=09=09delay =3D core_dbs_info->freq_hi_jiffies;
-=09=09} else {
-=09=09=09delay =3D delay_for_sampling_rate(od_tuners.sampling_rate
-=09=09=09=09=09=09* core_dbs_info->rate_mult);
 =09=09}
 =09}
=20
+max_delay:
+=09if (!delay)
+=09=09delay =3D delay_for_sampling_rate(od_tuners.sampling_rate
+=09=09=09=09* core_dbs_info->rate_mult);
+
 =09schedule_delayed_work_on(smp_processor_id(), dw, delay);
 =09mutex_unlock(&core_dbs_info->cdbs.timer_mutex);
 }
--=20
1.7.12.rc2.18.g61b472e
