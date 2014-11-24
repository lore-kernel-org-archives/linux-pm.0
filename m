From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH v2] cpufreq: Ref the policy object sooner
Date: Mon, 24 Nov 2014 10:08:03 +0100
Message-ID: <1416820083-20902-1-git-send-email-tomeu.vizoso@collabora.com>
References: <CAKohponxpSoUXHc9S-y_zgo=T44-6Ayk4vRbW=jRHqQRsdbrGQ@mail.gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKohponxpSoUXHc9S-y_zgo=T44-6Ayk4vRbW=jRHqQRsdbrGQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Do it before it's assigned to cpufreq_cpu_data, otherwise when a driver
tries to get the cpu frequency during initialization the policy kobj is
referenced and we get this warning:

------------[ cut here ]------------
WARNING: CPU: 1 PID: 64 at include/linux/kref.h:47 kobject_get+0x64/0x70()
Modules linked in:
CPU: 1 PID: 64 Comm: irq/77-tegra-ac Not tainted 3.18.0-rc4-next-20141114ccu-00050-g3eff942 #326
[<c0016fac>] (unwind_backtrace) from [<c001272c>] (show_stack+0x10/0x14)
[<c001272c>] (show_stack) from [<c06085d8>] (dump_stack+0x98/0xd8)
[<c06085d8>] (dump_stack) from [<c002892c>] (warn_slowpath_common+0x84/0xb4)
[<c002892c>] (warn_slowpath_common) from [<c00289f8>] (warn_slowpath_null+0x1c/0x24)
[<c00289f8>] (warn_slowpath_null) from [<c0220290>] (kobject_get+0x64/0x70)
[<c0220290>] (kobject_get) from [<c03e944c>] (cpufreq_cpu_get+0x88/0xc8)
[<c03e944c>] (cpufreq_cpu_get) from [<c03e9500>] (cpufreq_get+0xc/0x64)
[<c03e9500>] (cpufreq_get) from [<c0285288>] (actmon_thread_isr+0x134/0x198)
[<c0285288>] (actmon_thread_isr) from [<c0069008>] (irq_thread_fn+0x1c/0x40)
[<c0069008>] (irq_thread_fn) from [<c0069324>] (irq_thread+0x134/0x174)
[<c0069324>] (irq_thread) from [<c0040290>] (kthread+0xdc/0xf4)
[<c0040290>] (kthread) from [<c000f4b8>] (ret_from_fork+0x14/0x3c)
---[ end trace b7bd64a81b340c59 ]---

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>

---

v2:	* Properly unwind when erroring out.
---
 drivers/cpufreq/cpufreq.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 4473eba..ae27ea6 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -898,46 +898,31 @@ static int cpufreq_add_dev_interface(struct cpufreq_policy *policy,
 	struct freq_attr **drv_attr;
 	int ret = 0;
 
-	/* prepare interface data */
-	ret = kobject_init_and_add(&policy->kobj, &ktype_cpufreq,
-				   &dev->kobj, "cpufreq");
-	if (ret)
-		return ret;
-
 	/* set up files for this cpu device */
 	drv_attr = cpufreq_driver->attr;
 	while ((drv_attr) && (*drv_attr)) {
 		ret = sysfs_create_file(&policy->kobj, &((*drv_attr)->attr));
 		if (ret)
-			goto err_out_kobj_put;
+			return ret;
 		drv_attr++;
 	}
 	if (cpufreq_driver->get) {
 		ret = sysfs_create_file(&policy->kobj, &cpuinfo_cur_freq.attr);
 		if (ret)
-			goto err_out_kobj_put;
+			return ret;
 	}
 
 	ret = sysfs_create_file(&policy->kobj, &scaling_cur_freq.attr);
 	if (ret)
-		goto err_out_kobj_put;
+		return ret;
 
 	if (cpufreq_driver->bios_limit) {
 		ret = sysfs_create_file(&policy->kobj, &bios_limit.attr);
 		if (ret)
-			goto err_out_kobj_put;
+			return ret;
 	}
 
-	ret = cpufreq_add_dev_symlink(policy);
-	if (ret)
-		goto err_out_kobj_put;
-
-	return ret;
-
-err_out_kobj_put:
-	kobject_put(&policy->kobj);
-	wait_for_completion(&policy->kobj_unregister);
-	return ret;
+	return cpufreq_add_dev_symlink(policy);
 }
 
 static void cpufreq_init_policy(struct cpufreq_policy *policy)
@@ -1196,6 +1181,8 @@ static int __cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 		goto err_set_policy_cpu;
 	}
 
+	down_write(&policy->rwsem);
+
 	/* related cpus should atleast have policy->cpus */
 	cpumask_or(policy->related_cpus, policy->related_cpus, policy->cpus);
 
@@ -1208,9 +1195,17 @@ static int __cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 	if (!recover_policy) {
 		policy->user_policy.min = policy->min;
 		policy->user_policy.max = policy->max;
+
+		/* prepare interface data */
+		ret = kobject_init_and_add(&policy->kobj, &ktype_cpufreq,
+					   &dev->kobj, "cpufreq");
+		if (ret) {
+			pr_err("%s: failed to init policy->kobj: %d\n",
+			       __func__, ret);
+			goto err_init_policy_kobj;
+		}
 	}
 
-	down_write(&policy->rwsem);
 	write_lock_irqsave(&cpufreq_driver_lock, flags);
 	for_each_cpu(j, policy->cpus)
 		per_cpu(cpufreq_cpu_data, j) = policy;
@@ -1301,6 +1296,11 @@ err_get_freq:
 		per_cpu(cpufreq_cpu_data, j) = NULL;
 	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
 
+	if (!recover_policy) {
+		kobject_put(&policy->kobj);
+		wait_for_completion(&policy->kobj_unregister);
+	}
+err_init_policy_kobj:
 	up_write(&policy->rwsem);
 
 	if (cpufreq_driver->exit)
-- 
1.9.3
