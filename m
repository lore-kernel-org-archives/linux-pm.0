From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] cpufreq: remove sysfs files for CPU which failed to come back after resume
Date: Fri, 20 Dec 2013 10:38:20 +0530
Message-ID: <c6b53b186145559668722120ea1f37d28ddb3177.1387516043.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, srivatsa.bhat@linux.vnet.ibm.com, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

There are cases where cpufreq_add_dev() may fail for some CPUs during r=
esume.
With the current code we will still have sysfs cpufreq files for such C=
PUs, and
struct cpufreq_policy would be already freed for them. Hence any operat=
ion on
those sysfs files would result in kernel warnings.

To fix this, lets remove those sysfs files or put the associated kobjec=
t in case
of such errors. Also, to make it simple lets remove the sysfs links fro=
m all the
CPUs (except policy->cpu) during suspend as that operation wouldn't res=
ult with a
loss of sysfs file permissions. And so we will create those links durin=
g resume
as well.

Reported-and-tested-by: Bj=C3=B8rn Mork <bjorn@mork.no>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 61 ++++++++++++++++++++++++---------------=
--------
 1 file changed, 31 insertions(+), 30 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 02d534d..cea96c9 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -845,8 +845,7 @@ static void cpufreq_init_policy(struct cpufreq_poli=
cy *policy)
=20
 #ifdef CONFIG_HOTPLUG_CPU
 static int cpufreq_add_policy_cpu(struct cpufreq_policy *policy,
-				  unsigned int cpu, struct device *dev,
-				  bool frozen)
+				  unsigned int cpu, struct device *dev)
 {
 	int ret =3D 0;
 	unsigned long flags;
@@ -877,9 +876,7 @@ static int cpufreq_add_policy_cpu(struct cpufreq_po=
licy *policy,
 		}
 	}
=20
-	/* Don't touch sysfs links during light-weight init */
-	if (!frozen)
-		ret =3D sysfs_create_link(&dev->kobj, &policy->kobj, "cpufreq");
+	ret =3D sysfs_create_link(&dev->kobj, &policy->kobj, "cpufreq");
=20
 	return ret;
 }
@@ -926,6 +923,27 @@ err_free_policy:
 	return NULL;
 }
=20
+static void cpufreq_policy_put_kobj(struct cpufreq_policy *policy)
+{
+	struct kobject *kobj;
+	struct completion *cmp;
+
+	down_read(&policy->rwsem);
+	kobj =3D &policy->kobj;
+	cmp =3D &policy->kobj_unregister;
+	up_read(&policy->rwsem);
+	kobject_put(kobj);
+
+	/*
+	 * We need to make sure that the underlying kobj is
+	 * actually not referenced anymore by anybody before we
+	 * proceed with unloading.
+	 */
+	pr_debug("waiting for dropping of refcount\n");
+	wait_for_completion(cmp);
+	pr_debug("wait complete\n");
+}
+
 static void cpufreq_policy_free(struct cpufreq_policy *policy)
 {
 	free_cpumask_var(policy->related_cpus);
@@ -986,7 +1004,7 @@ static int __cpufreq_add_dev(struct device *dev, s=
truct subsys_interface *sif,
 	list_for_each_entry(tpolicy, &cpufreq_policy_list, policy_list) {
 		if (cpumask_test_cpu(cpu, tpolicy->related_cpus)) {
 			read_unlock_irqrestore(&cpufreq_driver_lock, flags);
-			ret =3D cpufreq_add_policy_cpu(tpolicy, cpu, dev, frozen);
+			ret =3D cpufreq_add_policy_cpu(tpolicy, cpu, dev);
 			up_read(&cpufreq_rwsem);
 			return ret;
 		}
@@ -1096,7 +1114,10 @@ err_get_freq:
 	if (cpufreq_driver->exit)
 		cpufreq_driver->exit(policy);
 err_set_policy_cpu:
+	if (frozen)
+		cpufreq_policy_put_kobj(policy);
 	cpufreq_policy_free(policy);
+
 nomem_out:
 	up_read(&cpufreq_rwsem);
=20
@@ -1118,7 +1139,7 @@ static int cpufreq_add_dev(struct device *dev, st=
ruct subsys_interface *sif)
 }
=20
 static int cpufreq_nominate_new_policy_cpu(struct cpufreq_policy *poli=
cy,
-					   unsigned int old_cpu, bool frozen)
+					   unsigned int old_cpu)
 {
 	struct device *cpu_dev;
 	int ret;
@@ -1126,10 +1147,6 @@ static int cpufreq_nominate_new_policy_cpu(struc=
t cpufreq_policy *policy,
 	/* first sibling now owns the new sysfs dir */
 	cpu_dev =3D get_cpu_device(cpumask_any_but(policy->cpus, old_cpu));
=20
-	/* Don't touch sysfs files during light-weight tear-down */
-	if (frozen)
-		return cpu_dev->id;
-
 	sysfs_remove_link(&cpu_dev->kobj, "cpufreq");
 	ret =3D kobject_move(&policy->kobj, &cpu_dev->kobj);
 	if (ret) {
@@ -1196,7 +1213,7 @@ static int __cpufreq_remove_dev_prepare(struct de=
vice *dev,
 		if (!frozen)
 			sysfs_remove_link(&dev->kobj, "cpufreq");
 	} else if (cpus > 1) {
-		new_cpu =3D cpufreq_nominate_new_policy_cpu(policy, cpu, frozen);
+		new_cpu =3D cpufreq_nominate_new_policy_cpu(policy, cpu);
 		if (new_cpu >=3D 0) {
 			update_policy_cpu(policy, new_cpu);
=20
@@ -1218,8 +1235,6 @@ static int __cpufreq_remove_dev_finish(struct dev=
ice *dev,
 	int ret;
 	unsigned long flags;
 	struct cpufreq_policy *policy;
-	struct kobject *kobj;
-	struct completion *cmp;
=20
 	read_lock_irqsave(&cpufreq_driver_lock, flags);
 	policy =3D per_cpu(cpufreq_cpu_data, cpu);
@@ -1249,22 +1264,8 @@ static int __cpufreq_remove_dev_finish(struct de=
vice *dev,
 			}
 		}
=20
-		if (!frozen) {
-			down_read(&policy->rwsem);
-			kobj =3D &policy->kobj;
-			cmp =3D &policy->kobj_unregister;
-			up_read(&policy->rwsem);
-			kobject_put(kobj);
-
-			/*
-			 * We need to make sure that the underlying kobj is
-			 * actually not referenced anymore by anybody before we
-			 * proceed with unloading.
-			 */
-			pr_debug("waiting for dropping of refcount\n");
-			wait_for_completion(cmp);
-			pr_debug("wait complete\n");
-		}
+		if (!frozen)
+			cpufreq_policy_put_kobj(policy);
=20
 		/*
 		 * Perform the ->exit() even during light-weight tear-down,
--=20
1.7.12.rc2.18.g61b472e

