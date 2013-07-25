From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH v6 1/8] cpufreq: Store cpufreq policies in a list
Date: Thu, 25 Jul 2013 18:33:24 +0200
Message-ID: <1374770011-22171-2-git-send-email-l.majewski@samsung.com>
References: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
 <1374770011-22171-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1374770011-22171-1-git-send-email-l.majewski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>
Cc: "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, linux-kernel <linux-kernel@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, durgadoss.r@intel.com
List-Id: linux-pm@vger.kernel.org

Policies available in a cpufreq framework are now linked together. They are
accessible via cpufreq_policy_list defined at cpufreq core.

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
Signed-off-by: Myungjoo Ham <myungjoo.ham@samsung.com>

---
Changes for v6:
- Move policy list entry delete code to __cpufreq_remove_dev()
- Protect operations on cpufreq_policy_list elements with lock

Changes for v5:
- Call list_add() only when device successfully added

Changes for v4:
- New patch

 drivers/cpufreq/cpufreq.c |    9 +++++++++
 include/linux/cpufreq.h   |    1 +
 2 files changed, 10 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 0937b8d..172a25e 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -46,6 +46,7 @@ static struct cpufreq_driver *cpufreq_driver;
 static DEFINE_PER_CPU(struct cpufreq_policy *, cpufreq_cpu_data);
 static DEFINE_RWLOCK(cpufreq_driver_lock);
 static DEFINE_MUTEX(cpufreq_governor_lock);
+static LIST_HEAD(cpufreq_policy_list);
 
 #ifdef CONFIG_HOTPLUG_CPU
 /* This one keeps track of the previously set governor of a removed CPU */
@@ -1054,6 +1055,10 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 	if (ret)
 		goto err_out_unregister;
 
+	write_lock_irqsave(&cpufreq_driver_lock, flags);
+	list_add(&policy->policy_list, &cpufreq_policy_list);
+	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
+
 	kobject_uevent(&policy->kobj, KOBJ_ADD);
 	module_put(cpufreq_driver->owner);
 	pr_debug("initialization complete\n");
@@ -1202,6 +1207,10 @@ static int __cpufreq_remove_dev(struct device *dev,
 		if (cpufreq_driver->exit)
 			cpufreq_driver->exit(data);
 
+		write_lock_irqsave(&cpufreq_driver_lock, flags);
+		list_del(&data->policy_list);
+		write_unlock_irqrestore(&cpufreq_driver_lock, flags);
+
 		free_cpumask_var(data->related_cpus);
 		free_cpumask_var(data->cpus);
 		kfree(data);
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 90d5a15..d8e30fc 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -117,6 +117,7 @@ struct cpufreq_policy {
 
 	struct cpufreq_real_policy	user_policy;
 
+	struct list_head        policy_list;
 	struct kobject		kobj;
 	struct completion	kobj_unregister;
 	int			transition_ongoing; /* Tracks transition status */
-- 
1.7.10.4
