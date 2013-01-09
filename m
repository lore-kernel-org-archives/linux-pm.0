From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] cpufreq: Simplify __cpufreq_remove_dev()
Date: Wed,  9 Jan 2013 16:50:44 +0530
Message-ID: <aa10abe640afed8700abf262dbfc9b9c22659b6a.1357729671.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, linaro-dev@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, shawn.guo@linaro.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

__cpufreq_remove_dev() is called on multiple occasions: cpufreq_driver
unregister and cpu removals.

Current implementation of this routine is overly complex without much need.=
 If
the cpu to be removed is the policy->cpu, we remove the policy first and ad=
d all
other cpus again from policy->cpus and then finally call __cpufreq_remove_d=
ev()
again to remove the cpu to be deleted. Haahhhh..

There exist a simple solution to removal of a cpu:
- Simply use the old policy structure
- update its fields like: policy->cpu, etc.
- notify any users of cpufreq, which depend on changing policy->cpu

Hence this patch, which tries to implement the above theory. It is tested w=
ell
by myself on ARM big.LITTLE TC2 SoC, which has 5 cores (2 A15 and 3 A7). Bo=
th
A15's share same struct policy and all A7's share same policy structure.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Tested-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Hi Guys,

I am just an beginner in cpufreq stuff, please ignore any foolish mistakes.=
 :)

Yesterday, i reviewed a cpufreq driver that had some ugly code in init()
routine:
http://www.spinics.net/lists/arm-kernel/msg215348.html

It wasn't ugly due to the author of the patch, but the way
__cpufreq_remove_dev() is implemented. And then i thought to simplify it.

[Probably need to simplify cpufreq_add_dev() too, but that can be done as n=
ext
step.]

I have rebased this patch over some other cpufreq core fixes i had posted
earlier:

https://lkml.org/lkml/2012/12/16/5

ARM mail servers are broken and hence this patch can't be applied as is. :(
I have pushed this and the dependency patch here:

http://git.linaro.org/gitweb?p=3Darm/big.LITTLE/mp.git;a=3Dshortlog;h=3Dref=
s/heads/cpufreq-fixes-v2

@Shawn: I believe your driver don't require that ugly code anymore (Though =
i
know there is a situation for that to happen, if we have two cpus, you remo=
ve
second one and then add it back. With this cpufreq_add_dev() would call ini=
t()
first and then try to match if there are any managed_policies present. But =
the
issue you pointed out about unregistering the driver would be solved by thi=
s
patch.)

 drivers/cpufreq/cpufreq.c       | 158 +++++++++++++++++-------------------=
----
 drivers/cpufreq/cpufreq_stats.c |  21 +++++-
 drivers/cpufreq/freq_table.c    |  10 +++
 include/linux/cpufreq.h         |   5 ++
 4 files changed, 101 insertions(+), 93 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 271d3be..8df41ad 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1036,6 +1036,22 @@ module_out:
 =09return ret;
 }
=20
+static void update_policy_cpu(struct cpufreq_policy *policy, unsigned int =
cpu)
+{
+=09unsigned int old_cpu =3D policy->cpu;
+=09int j;
+
+=09policy->cpu =3D cpu;
+
+=09for_each_cpu(j, policy->cpus) {
+=09=09if (!cpu_online(j))
+=09=09=09continue;
+=09=09per_cpu(cpufreq_policy_cpu, j) =3D cpu;
+=09}
+
+=09cpufreq_frequency_table_update_policy_cpu(old_cpu, cpu);
+=09cpufreq_stats_update_policy_cpu(old_cpu, cpu);
+}
=20
 /**
  * __cpufreq_remove_dev - remove a CPU device
@@ -1046,132 +1062,92 @@ module_out:
  */
 static int __cpufreq_remove_dev(struct device *dev, struct subsys_interfac=
e *sif)
 {
-=09unsigned int cpu =3D dev->id;
+=09unsigned int cpu =3D dev->id, ret, cpus;
 =09unsigned long flags;
 =09struct cpufreq_policy *data;
 =09struct kobject *kobj;
 =09struct completion *cmp;
-#ifdef CONFIG_SMP
 =09struct device *cpu_dev;
-=09unsigned int j;
-#endif
=20
-=09pr_debug("unregistering CPU %u\n", cpu);
+=09pr_debug("%s: unregistering CPU %u\n", __func__, cpu);
=20
 =09spin_lock_irqsave(&cpufreq_driver_lock, flags);
 =09data =3D per_cpu(cpufreq_cpu_data, cpu);
=20
 =09if (!data) {
+=09=09pr_debug("%s: No cpu_data found\n", __func__);
 =09=09spin_unlock_irqrestore(&cpufreq_driver_lock, flags);
 =09=09unlock_policy_rwsem_write(cpu);
 =09=09return -EINVAL;
 =09}
-=09per_cpu(cpufreq_cpu_data, cpu) =3D NULL;
=20
-#ifdef CONFIG_SMP
-=09/* if this isn't the CPU which is the parent of the kobj, we
-=09 * only need to unlink, put and exit
-=09 */
-=09if (unlikely(cpu !=3D data->cpu)) {
-=09=09pr_debug("removing link\n");
+=09if (cpufreq_driver->target)
 =09=09__cpufreq_governor(data, CPUFREQ_GOV_STOP);
-=09=09cpumask_clear_cpu(cpu, data->cpus);
-=09=09spin_unlock_irqrestore(&cpufreq_driver_lock, flags);
-
-=09=09__cpufreq_governor(data, CPUFREQ_GOV_START);
-=09=09__cpufreq_governor(data, CPUFREQ_GOV_LIMITS);
-
-=09=09kobj =3D &dev->kobj;
-=09=09cpufreq_cpu_put(data);
-=09=09unlock_policy_rwsem_write(cpu);
-=09=09sysfs_remove_link(kobj, "cpufreq");
-=09=09return 0;
-=09}
-#endif
-
-#ifdef CONFIG_SMP
=20
 #ifdef CONFIG_HOTPLUG_CPU
 =09strncpy(per_cpu(cpufreq_cpu_governor, cpu), data->governor->name,
 =09=09=09CPUFREQ_NAME_LEN);
 #endif
=20
-=09/* if we have other CPUs still registered, we need to unlink them,
-=09 * or else wait_for_completion below will lock up. Clean the
-=09 * per_cpu(cpufreq_cpu_data) while holding the lock, and remove
-=09 * the sysfs links afterwards.
-=09 */
-=09if (unlikely(cpumask_weight(data->cpus) > 1)) {
-=09=09for_each_cpu(j, data->cpus) {
-=09=09=09if (j =3D=3D cpu)
-=09=09=09=09continue;
-=09=09=09per_cpu(cpufreq_cpu_data, j) =3D NULL;
-=09=09}
-=09}
-
-=09spin_unlock_irqrestore(&cpufreq_driver_lock, flags);
+=09per_cpu(cpufreq_cpu_data, cpu) =3D NULL;
+=09cpus =3D cpumask_weight(data->cpus);
+=09cpumask_clear_cpu(cpu, data->cpus);
=20
-=09if (unlikely(cpumask_weight(data->cpus) > 1)) {
-=09=09for_each_cpu(j, data->cpus) {
-=09=09=09if (j =3D=3D cpu)
-=09=09=09=09continue;
-=09=09=09pr_debug("removing link for cpu %u\n", j);
-#ifdef CONFIG_HOTPLUG_CPU
-=09=09=09strncpy(per_cpu(cpufreq_cpu_governor, j),
-=09=09=09=09data->governor->name, CPUFREQ_NAME_LEN);
-#endif
-=09=09=09cpu_dev =3D get_cpu_device(j);
-=09=09=09kobj =3D &cpu_dev->kobj;
+=09if (unlikely((cpu =3D=3D data->cpu) && (cpus > 1))) {
+=09=09/* first sibling now owns the new sysfs dir */
+=09=09cpu_dev =3D get_cpu_device(cpumask_first(data->cpus));
+=09=09sysfs_remove_link(&cpu_dev->kobj, "cpufreq");
+=09=09ret =3D kobject_move(&data->kobj, &cpu_dev->kobj);
+=09=09if (ret) {
+=09=09=09pr_err("%s: Failed to move kobj: %d", __func__, ret);
+=09=09=09cpumask_set_cpu(cpu, data->cpus);
+=09=09=09ret =3D sysfs_create_link(&cpu_dev->kobj, &data->kobj,
+=09=09=09=09=09"cpufreq");
+=09=09=09spin_unlock_irqrestore(&cpufreq_driver_lock, flags);
 =09=09=09unlock_policy_rwsem_write(cpu);
-=09=09=09sysfs_remove_link(kobj, "cpufreq");
-=09=09=09lock_policy_rwsem_write(cpu);
-=09=09=09cpufreq_cpu_put(data);
+=09=09=09return -EINVAL;
 =09=09}
+
+=09=09update_policy_cpu(data, cpu_dev->id);
+=09=09pr_debug("%s: policy Kobject moved to cpu: %d from: %d\n",
+=09=09=09=09__func__, cpu_dev->id, cpu);
 =09}
-#else
-=09spin_unlock_irqrestore(&cpufreq_driver_lock, flags);
-#endif
=20
-=09if (cpufreq_driver->target)
-=09=09__cpufreq_governor(data, CPUFREQ_GOV_STOP);
+=09spin_unlock_irqrestore(&cpufreq_driver_lock, flags);
=20
-=09kobj =3D &data->kobj;
-=09cmp =3D &data->kobj_unregister;
+=09pr_debug("%s: removing link, cpu: %d\n", __func__, cpu);
+=09cpufreq_cpu_put(data);
 =09unlock_policy_rwsem_write(cpu);
-=09kobject_put(kobj);
+=09sysfs_remove_link(&dev->kobj, "cpufreq");
=20
-=09/* we need to make sure that the underlying kobj is actually
-=09 * not referenced anymore by anybody before we proceed with
-=09 * unloading.
-=09 */
-=09pr_debug("waiting for dropping of refcount\n");
-=09wait_for_completion(cmp);
-=09pr_debug("wait complete\n");
-
-=09lock_policy_rwsem_write(cpu);
-=09if (cpufreq_driver->exit)
-=09=09cpufreq_driver->exit(data);
-=09unlock_policy_rwsem_write(cpu);
+=09/* If cpu is last user of policy, free policy */
+=09if (cpus =3D=3D 1) {
+=09=09lock_policy_rwsem_write(cpu);
+=09=09kobj =3D &data->kobj;
+=09=09cmp =3D &data->kobj_unregister;
+=09=09unlock_policy_rwsem_write(cpu);
+=09=09kobject_put(kobj);
=20
-#ifdef CONFIG_HOTPLUG_CPU
-=09/* when the CPU which is the parent of the kobj is hotplugged
-=09 * offline, check for siblings, and create cpufreq sysfs interface
-=09 * and symlinks
-=09 */
-=09if (unlikely(cpumask_weight(data->cpus) > 1)) {
-=09=09/* first sibling now owns the new sysfs dir */
-=09=09cpumask_clear_cpu(cpu, data->cpus);
-=09=09cpufreq_add_dev(get_cpu_device(cpumask_first(data->cpus)), NULL);
+=09=09/* we need to make sure that the underlying kobj is actually
+=09=09 * not referenced anymore by anybody before we proceed with
+=09=09 * unloading.
+=09=09 */
+=09=09pr_debug("waiting for dropping of refcount\n");
+=09=09wait_for_completion(cmp);
+=09=09pr_debug("wait complete\n");
=20
-=09=09/* finally remove our own symlink */
 =09=09lock_policy_rwsem_write(cpu);
-=09=09__cpufreq_remove_dev(dev, sif);
-=09}
-#endif
+=09=09if (cpufreq_driver->exit)
+=09=09=09cpufreq_driver->exit(data);
+=09=09unlock_policy_rwsem_write(cpu);
=20
-=09free_cpumask_var(data->related_cpus);
-=09free_cpumask_var(data->cpus);
-=09kfree(data);
+=09=09free_cpumask_var(data->related_cpus);
+=09=09free_cpumask_var(data->cpus);
+=09=09kfree(data);
+=09} else if (cpufreq_driver->target) {
+=09=09__cpufreq_governor(data, CPUFREQ_GOV_START);
+=09=09__cpufreq_governor(data, CPUFREQ_GOV_LIMITS);
+=09}
=20
 =09return 0;
 }
diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stat=
s.c
index e40e508..0afface 100644
--- a/drivers/cpufreq/cpufreq_stats.c
+++ b/drivers/cpufreq/cpufreq_stats.c
@@ -170,11 +170,13 @@ static int freq_table_get_index(struct cpufreq_stats =
*stat, unsigned int freq)
 static void cpufreq_stats_free_table(unsigned int cpu)
 {
 =09struct cpufreq_stats *stat =3D per_cpu(cpufreq_stats_table, cpu);
+
 =09if (stat) {
+=09=09pr_debug("%s: Free stat table\n", __func__);
 =09=09kfree(stat->time_in_state);
 =09=09kfree(stat);
+=09=09per_cpu(cpufreq_stats_table, cpu) =3D NULL;
 =09}
-=09per_cpu(cpufreq_stats_table, cpu) =3D NULL;
 }
=20
 /* must be called early in the CPU removal sequence (before
@@ -183,8 +185,10 @@ static void cpufreq_stats_free_table(unsigned int cpu)
 static void cpufreq_stats_free_sysfs(unsigned int cpu)
 {
 =09struct cpufreq_policy *policy =3D cpufreq_cpu_get(cpu);
-=09if (policy && policy->cpu =3D=3D cpu)
+=09if (policy && (cpumask_weight(policy->cpus) =3D=3D 1)) {
+=09=09pr_debug("%s: Free sysfs stat\n", __func__);
 =09=09sysfs_remove_group(&policy->kobj, &stats_attr_group);
+=09}
 =09if (policy)
 =09=09cpufreq_cpu_put(policy);
 }
@@ -262,6 +266,19 @@ error_get_fail:
 =09return ret;
 }
=20
+void cpufreq_stats_update_policy_cpu(unsigned int old_cpu,
+=09=09unsigned int new_cpu)
+{
+=09struct cpufreq_stats *stat =3D per_cpu(cpufreq_stats_table, old_cpu);
+
+=09pr_debug("Updating stats_table for new_cpu %u from old_cpu %u\n",
+=09=09=09new_cpu, old_cpu);
+=09per_cpu(cpufreq_stats_table, new_cpu) =3D per_cpu(cpufreq_stats_table,
+=09=09=09old_cpu);
+=09per_cpu(cpufreq_stats_table, old_cpu) =3D NULL;
+=09stat->cpu =3D new_cpu;
+}
+
 static int cpufreq_stat_notifier_policy(struct notifier_block *nb,
 =09=09unsigned long val, void *data)
 {
diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
index 49cda25..a4b384f 100644
--- a/drivers/cpufreq/freq_table.c
+++ b/drivers/cpufreq/freq_table.c
@@ -227,6 +227,16 @@ void cpufreq_frequency_table_put_attr(unsigned int cpu=
)
 }
 EXPORT_SYMBOL_GPL(cpufreq_frequency_table_put_attr);
=20
+void cpufreq_frequency_table_update_policy_cpu(unsigned int old_cpu,
+=09=09unsigned int new_cpu)
+{
+=09pr_debug("Updating show_table for new_cpu %u from old_cpu %u\n",
+=09=09=09new_cpu, old_cpu);
+=09per_cpu(cpufreq_show_table, new_cpu) =3D per_cpu(cpufreq_show_table,
+=09=09=09old_cpu);
+=09per_cpu(cpufreq_show_table, old_cpu) =3D NULL;
+}
+
 struct cpufreq_frequency_table *cpufreq_frequency_get_table(unsigned int c=
pu)
 {
 =09return per_cpu(cpufreq_show_table, cpu);
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index a55b88e..a42aa05 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -405,6 +405,11 @@ extern struct freq_attr cpufreq_freq_attr_scaling_avai=
lable_freqs;
=20
 void cpufreq_frequency_table_get_attr(struct cpufreq_frequency_table *tabl=
e,
 =09=09=09=09      unsigned int cpu);
+void cpufreq_frequency_table_update_policy_cpu(unsigned int old_cpu,
+=09=09unsigned int new_cpu);
=20
 void cpufreq_frequency_table_put_attr(unsigned int cpu);
+
+void cpufreq_stats_update_policy_cpu(unsigned int old_cpu,
+=09=09unsigned int new_cpu);
 #endif /* _LINUX_CPUFREQ_H */
--=20
1.7.12.rc2.18.g61b472e


