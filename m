From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 1/4] cpufreq: Add per policy governor-init/exit infrastructure
Date: Mon, 11 Feb 2013 13:20:00 +0530
Message-ID: <ece24bb874ad1834fc43b83f053b2560db8c25d3.1360568193.git.viresh.kumar@linaro.org>
References: <cover.1360568193.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1360568193.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1360568193.git.viresh.kumar@linaro.org>
References: <cover.1360568193.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, linaro-dev@lists.linaro.org, francescolavra.fl@gmail.com, toddpoynor@google.com, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Currently, there can't be multiple instances of single governor_type. If we=
 have
a multi-package system, where we have multiple instances of struct policy (=
per
package), we can't have multiple instances of same governor. i.e. We can't =
have
multiple instances of ondemand governor for multiple packages.

Governors directory in sysfs is created at /sys/devices/system/cpu/cpufreq/
governor-name/. Which again reflects that there can be only one instance of=
 a
governor_type in the system.

This is a bottleneck for multicluster system, where we want different packa=
ges
to use same governor type, but with different tunables.

This patch is inclined towards providing this infrastructure. Because we ar=
e
required to allocate governor's resources dynamically now, we must do it at
policy creation and end. And so got CPUFREQ_GOV_POLICY_INIT/EXIT.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 21 ++++++++++++++++++---
 include/linux/cpufreq.h   |  9 ++++++---
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 04aab05..40f7083 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1081,6 +1081,8 @@ static int __cpufreq_remove_dev(struct device *dev, s=
truct subsys_interface *sif
=20
 =09/* If cpu is last user of policy, free policy */
 =09if (cpus =3D=3D 1) {
+=09=09__cpufreq_governor(data, CPUFREQ_GOV_POLICY_EXIT);
+
 =09=09lock_policy_rwsem_read(cpu);
 =09=09kobj =3D &data->kobj;
 =09=09cmp =3D &data->kobj_unregister;
@@ -1669,7 +1671,7 @@ EXPORT_SYMBOL(cpufreq_get_policy);
 static int __cpufreq_set_policy(struct cpufreq_policy *data,
 =09=09=09=09struct cpufreq_policy *policy)
 {
-=09int ret =3D 0;
+=09int ret =3D 0, failed =3D 1;
 =09struct cpufreq_driver *driver =3D rcu_dereference(cpufreq_driver);
=20
 =09pr_debug("setting new policy for CPU %u: %u - %u kHz\n", policy->cpu,
@@ -1724,18 +1726,31 @@ static int __cpufreq_set_policy(struct cpufreq_poli=
cy *data,
 =09=09=09pr_debug("governor switch\n");
=20
 =09=09=09/* end old governor */
-=09=09=09if (data->governor)
+=09=09=09if (data->governor) {
 =09=09=09=09__cpufreq_governor(data, CPUFREQ_GOV_STOP);
+=09=09=09=09__cpufreq_governor(data,
+=09=09=09=09=09=09CPUFREQ_GOV_POLICY_EXIT);
+=09=09=09}
=20
 =09=09=09/* start new governor */
 =09=09=09data->governor =3D policy->governor;
-=09=09=09if (__cpufreq_governor(data, CPUFREQ_GOV_START)) {
+=09=09=09if (!__cpufreq_governor(data, CPUFREQ_GOV_POLICY_INIT)) {
+=09=09=09=09if (!__cpufreq_governor(data, CPUFREQ_GOV_START))
+=09=09=09=09=09failed =3D 0;
+=09=09=09=09else
+=09=09=09=09=09__cpufreq_governor(data,
+=09=09=09=09=09=09=09CPUFREQ_GOV_POLICY_EXIT);
+=09=09=09}
+
+=09=09=09if (failed) {
 =09=09=09=09/* new governor failed, so re-start old one */
 =09=09=09=09pr_debug("starting governor %s failed\n",
 =09=09=09=09=09=09=09data->governor->name);
 =09=09=09=09if (old_gov) {
 =09=09=09=09=09data->governor =3D old_gov;
 =09=09=09=09=09__cpufreq_governor(data,
+=09=09=09=09=09=09=09CPUFREQ_GOV_POLICY_INIT);
+=09=09=09=09=09__cpufreq_governor(data,
 =09=09=09=09=09=09=09   CPUFREQ_GOV_START);
 =09=09=09=09}
 =09=09=09=09ret =3D -EINVAL;
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index a22944c..3b822ce 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -106,6 +106,7 @@ struct cpufreq_policy {
 =09=09=09=09=09 * governors are used */
 =09unsigned int=09=09policy; /* see above */
 =09struct cpufreq_governor=09*governor; /* see below */
+=09void=09=09=09*governor_data;
=20
 =09struct work_struct=09update; /* if update_policy() needs to be
 =09=09=09=09=09 * called, but you're in IRQ context */
@@ -178,9 +179,11 @@ static inline unsigned long cpufreq_scale(unsigned lon=
g old, u_int div, u_int mu
  *                          CPUFREQ GOVERNORS                        *
  *********************************************************************/
=20
-#define CPUFREQ_GOV_START  1
-#define CPUFREQ_GOV_STOP   2
-#define CPUFREQ_GOV_LIMITS 3
+#define CPUFREQ_GOV_START=091
+#define CPUFREQ_GOV_STOP=092
+#define CPUFREQ_GOV_LIMITS=093
+#define CPUFREQ_GOV_POLICY_INIT=094
+#define CPUFREQ_GOV_POLICY_EXIT=094
=20
 struct cpufreq_governor {
 =09char=09name[CPUFREQ_NAME_LEN];
--=20
1.7.12.rc2.18.g61b472e
