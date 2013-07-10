From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH] cpufreq: Fix cpufreq regression after suspend/resume
Date: Thu, 11 Jul 2013 03:59:59 +0530
Message-ID: <51DDE067.2020106@linux.vnet.ibm.com>
References: <51C08370.4050906@gmx.de> <CAKohpok1gThXL925Yz5UgC54vTVQgymBA1cLGER_g-dgZu0JLA@mail.gmail.com> <51CF1E53.6060902@gmx.de> <8029836.CFiJCXmRQ0@vostro.rjw.lan> <51D05DF4.50704@linux.vnet.ibm.com> <51D06556.7080204@gmx.de> <51D07E7F.2030709@linux.vnet.ibm.com> <51DDC8FA.4020609@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e28smtp07.in.ibm.com ([122.248.162.7]:55436 "EHLO
	e28smtp07.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754415Ab3GJWd1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Jul 2013 18:33:27 -0400
Received: from /spool/local
	by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Thu, 11 Jul 2013 03:55:49 +0530
In-Reply-To: <51DDC8FA.4020609@gmx.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Viresh Kumar <viresh.kumar@linaro.org>, cpufreq@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Toralf,

On 07/11/2013 02:20 AM, Toralf F=C3=B6rster wrote:
> I tested the patch several times on top of a66b2e5 - the origin issue=
 is
> fixed but - erratically another issue now appears : all 4 cores are r=
uns
> after wakeup at 2.6 GHz.
> The temporary hot fix is to switch between governor performance and
> ondemand for all 4 cores.
>=20
>

Thanks for all your testing efforts. The commit a66b2e5 took a shortcut=
 to
achieve its goals but failed subtly in many aspects. Below is a patch (=
only
compile-tested) which tries to achieve the goal (preserve sysfs files) =
in
the proper way, by separating out the cpufreq-core bits from the sysfs =
bits.
You might want to give it a try on current mainline and see if it impro=
ves
anything.

Regards,
Srivatsa S. Bhat


(Applies on current mainline)
---

 drivers/cpufreq/cpufreq.c |  144 ++++++++++++++++++++++++++-----------=
--------
 1 file changed, 82 insertions(+), 62 deletions(-)


diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 6a015ad..28c690f 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -834,11 +834,8 @@ static int cpufreq_add_dev_interface(unsigned int =
cpu,
 				     struct cpufreq_policy *policy,
 				     struct device *dev)
 {
-	struct cpufreq_policy new_policy;
 	struct freq_attr **drv_attr;
-	unsigned long flags;
 	int ret =3D 0;
-	unsigned int j;
=20
 	/* prepare interface data */
 	ret =3D kobject_init_and_add(&policy->kobj, &ktype_cpufreq,
@@ -870,31 +867,10 @@ static int cpufreq_add_dev_interface(unsigned int=
 cpu,
 			goto err_out_kobj_put;
 	}
=20
-	write_lock_irqsave(&cpufreq_driver_lock, flags);
-	for_each_cpu(j, policy->cpus) {
-		per_cpu(cpufreq_cpu_data, j) =3D policy;
-		per_cpu(cpufreq_policy_cpu, j) =3D policy->cpu;
-	}
-	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
-
 	ret =3D cpufreq_add_dev_symlink(cpu, policy);
 	if (ret)
 		goto err_out_kobj_put;
=20
-	memcpy(&new_policy, policy, sizeof(struct cpufreq_policy));
-	/* assure that the starting sequence is run in __cpufreq_set_policy *=
/
-	policy->governor =3D NULL;
-
-	/* set default policy */
-	ret =3D __cpufreq_set_policy(policy, &new_policy);
-	policy->user_policy.policy =3D policy->policy;
-	policy->user_policy.governor =3D policy->governor;
-
-	if (ret) {
-		pr_debug("setting policy failed\n");
-		if (cpufreq_driver->exit)
-			cpufreq_driver->exit(policy);
-	}
 	return ret;
=20
 err_out_kobj_put:
@@ -905,7 +881,7 @@ err_out_kobj_put:
=20
 #ifdef CONFIG_HOTPLUG_CPU
 static int cpufreq_add_policy_cpu(unsigned int cpu, unsigned int sibli=
ng,
-				  struct device *dev)
+				  struct device *dev, bool init_sysfs)
 {
 	struct cpufreq_policy *policy;
 	int ret =3D 0, has_target =3D !!cpufreq_driver->target;
@@ -933,30 +909,25 @@ static int cpufreq_add_policy_cpu(unsigned int cp=
u, unsigned int sibling,
 		__cpufreq_governor(policy, CPUFREQ_GOV_LIMITS);
 	}
=20
-	ret =3D sysfs_create_link(&dev->kobj, &policy->kobj, "cpufreq");
-	if (ret) {
-		cpufreq_cpu_put(policy);
-		return ret;
+	if (init_sysfs) {
+		ret =3D sysfs_create_link(&dev->kobj, &policy->kobj, "cpufreq");
+		if (ret) {
+			cpufreq_cpu_put(policy);
+			return ret;
+		}
 	}
=20
 	return 0;
 }
 #endif
=20
-/**
- * cpufreq_add_dev - add a CPU device
- *
- * Adds the cpufreq interface for a CPU device.
- *
- * The Oracle says: try running cpufreq registration/unregistration co=
ncurrently
- * with with cpu hotplugging and all hell will break loose. Tried to c=
lean this
- * mess up, but more thorough testing is needed. - Mathieu
- */
-static int cpufreq_add_dev(struct device *dev, struct subsys_interface=
 *sif)
+static int __cpufreq_add_dev(struct device *dev, struct subsys_interfa=
ce *sif,
+			     bool init_sysfs)
 {
 	unsigned int j, cpu =3D dev->id;
 	int ret =3D -ENOMEM;
 	struct cpufreq_policy *policy;
+	struct cpufreq_policy new_policy;
 	unsigned long flags;
 #ifdef CONFIG_HOTPLUG_CPU
 	struct cpufreq_governor *gov;
@@ -984,7 +955,8 @@ static int cpufreq_add_dev(struct device *dev, stru=
ct subsys_interface *sif)
 		struct cpufreq_policy *cp =3D per_cpu(cpufreq_cpu_data, sibling);
 		if (cp && cpumask_test_cpu(cpu, cp->related_cpus)) {
 			read_unlock_irqrestore(&cpufreq_driver_lock, flags);
-			return cpufreq_add_policy_cpu(cpu, sibling, dev);
+			return cpufreq_add_policy_cpu(cpu, sibling, dev,
+						      init_sysfs);
 		}
 	}
 	read_unlock_irqrestore(&cpufreq_driver_lock, flags);
@@ -1049,9 +1021,33 @@ static int cpufreq_add_dev(struct device *dev, s=
truct subsys_interface *sif)
 	}
 #endif
=20
-	ret =3D cpufreq_add_dev_interface(cpu, policy, dev);
-	if (ret)
-		goto err_out_unregister;
+	write_lock_irqsave(&cpufreq_driver_lock, flags);
+	for_each_cpu(j, policy->cpus) {
+		per_cpu(cpufreq_cpu_data, j) =3D policy;
+		per_cpu(cpufreq_policy_cpu, j) =3D policy->cpu;
+	}
+	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
+
+	if (init_sysfs) {
+		ret =3D cpufreq_add_dev_interface(cpu, policy, dev);
+		if (ret)
+			goto err_out_unregister;
+	}
+
+	memcpy(&new_policy, policy, sizeof(struct cpufreq_policy));
+	/* assure that the starting sequence is run in __cpufreq_set_policy *=
/
+	policy->governor =3D NULL;
+
+	/* set default policy */
+	ret =3D __cpufreq_set_policy(policy, &new_policy);
+	policy->user_policy.policy =3D policy->policy;
+	policy->user_policy.governor =3D policy->governor;
+
+	if (ret) {
+		pr_debug("setting policy failed\n");
+		if (cpufreq_driver->exit)
+			cpufreq_driver->exit(policy);
+	}
=20
 	kobject_uevent(&policy->kobj, KOBJ_ADD);
 	module_put(cpufreq_driver->owner);
@@ -1081,6 +1077,20 @@ module_out:
 	return ret;
 }
=20
+/**
+ * cpufreq_add_dev - add a CPU device
+ *
+ * Adds the cpufreq interface for a CPU device.
+ *
+ * The Oracle says: try running cpufreq registration/unregistration co=
ncurrently
+ * with with cpu hotplugging and all hell will break loose. Tried to c=
lean this
+ * mess up, but more thorough testing is needed. - Mathieu
+ */
+static int cpufreq_add_dev(struct device *dev, struct subsys_interface=
 *sif)
+{
+	return __cpufreq_add_dev(dev, sif, true);
+}
+
 static void update_policy_cpu(struct cpufreq_policy *policy, unsigned =
int cpu)
 {
 	int j;
@@ -1106,7 +1116,7 @@ static void update_policy_cpu(struct cpufreq_poli=
cy *policy, unsigned int cpu)
  * This routine frees the rwsem before returning.
  */
 static int __cpufreq_remove_dev(struct device *dev,
-		struct subsys_interface *sif)
+				struct subsys_interface *sif, bool remove_sysfs)
 {
 	unsigned int cpu =3D dev->id, ret, cpus;
 	unsigned long flags;
@@ -1145,9 +1155,9 @@ static int __cpufreq_remove_dev(struct device *de=
v,
 		cpumask_clear_cpu(cpu, data->cpus);
 	unlock_policy_rwsem_write(cpu);
=20
-	if (cpu !=3D data->cpu) {
+	if (cpu !=3D data->cpu && remove_sysfs) {
 		sysfs_remove_link(&dev->kobj, "cpufreq");
-	} else if (cpus > 1) {
+	} else if (cpus > 1 && remove_sysfs) {
 		/* first sibling now owns the new sysfs dir */
 		cpu_dev =3D get_cpu_device(cpumask_first(data->cpus));
 		sysfs_remove_link(&cpu_dev->kobj, "cpufreq");
@@ -1184,26 +1194,25 @@ static int __cpufreq_remove_dev(struct device *=
dev,
=20
 	/* If cpu is last user of policy, free policy */
 	if (cpus =3D=3D 1) {
-		lock_policy_rwsem_read(cpu);
-		kobj =3D &data->kobj;
-		cmp =3D &data->kobj_unregister;
-		unlock_policy_rwsem_read(cpu);
-		kobject_put(kobj);
-
-		/* we need to make sure that the underlying kobj is actually
-		 * not referenced anymore by anybody before we proceed with
-		 * unloading.
-		 */
-		pr_debug("waiting for dropping of refcount\n");
-		wait_for_completion(cmp);
-		pr_debug("wait complete\n");
-
 		if (cpufreq_driver->exit)
 			cpufreq_driver->exit(data);
=20
 		free_cpumask_var(data->related_cpus);
 		free_cpumask_var(data->cpus);
 		kfree(data);
+
+		if (remove_sysfs) {
+			lock_policy_rwsem_read(cpu);
+			kobj =3D &data->kobj;
+			cmp =3D &data->kobj_unregister;
+			unlock_policy_rwsem_read(cpu);
+			kobject_put(kobj);
+
+			pr_debug("waiting for dropping of refcount\n");
+			wait_for_completion(cmp);
+			pr_debug("wait complete\n");
+		}
+
 	} else if (cpufreq_driver->target) {
 		__cpufreq_governor(data, CPUFREQ_GOV_START);
 		__cpufreq_governor(data, CPUFREQ_GOV_LIMITS);
@@ -1221,7 +1230,7 @@ static int cpufreq_remove_dev(struct device *dev,=
 struct subsys_interface *sif)
 	if (cpu_is_offline(cpu))
 		return 0;
=20
-	retval =3D __cpufreq_remove_dev(dev, sif);
+	retval =3D __cpufreq_remove_dev(dev, sif, true);
 	return retval;
 }
=20
@@ -1943,13 +1952,24 @@ static int __cpuinit cpufreq_cpu_callback(struc=
t notifier_block *nfb,
 		case CPU_ONLINE:
 			cpufreq_add_dev(dev, NULL);
 			break;
+		case CPU_ONLINE_FROZEN:
+			__cpufreq_add_dev(dev, NULL, false);
+			break;
+
 		case CPU_DOWN_PREPARE:
 		case CPU_UP_CANCELED_FROZEN:
-			__cpufreq_remove_dev(dev, NULL);
+			__cpufreq_remove_dev(dev, NULL, true);
+			break;
+		case CPU_DOWN_PREPARE_FROZEN:
+			__cpufreq_remove_dev(dev, NULL, false);
 			break;
+
 		case CPU_DOWN_FAILED:
 			cpufreq_add_dev(dev, NULL);
 			break;
+		case CPU_DOWN_FAILED_FROZEN:
+			__cpufreq_add_dev(dev, NULL, false);
+			break;
 		}
 	}
 	return NOTIFY_OK;

