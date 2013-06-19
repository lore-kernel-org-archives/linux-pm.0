From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH v4 1/7] cpufreq: Store cpufreq policies in a list
Date: Wed, 19 Jun 2013 19:12:42 +0200
Message-ID: <1371661969-7660-2-git-send-email-l.majewski@samsung.com>
References: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
 <1371661969-7660-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1371661969-7660-1-git-send-email-l.majewski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocky" <rjw@sisk.pl>
Cc: "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Lukasz Majewski <l.majewski@samsung.com>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, linux-kernel <linux-kernel@vger.kernel.org>, Lukasz Majewski <l.majewski@majess.pl>, Andre Przywara <andre.przywara@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>
List-Id: linux-pm@vger.kernel.org

Policies available in a cpufreq framework are now linked together. They are
accessible via cpufreq_policy_list defined at cpufreq core.

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
Signed-off-by: Myungjoo Ham <myungjoo.ham@samsung.com>

Changes for v4:
- New patch
---
 drivers/cpufreq/cpufreq.c |    3 +++
 include/linux/cpufreq.h   |    1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 2ce86ed..665e641 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -46,6 +46,7 @@ static DEFINE_PER_CPU(struct cpufreq_policy *, cpufreq_cpu_data);
 static DEFINE_PER_CPU(char[CPUFREQ_NAME_LEN], cpufreq_cpu_governor);
 #endif
 static DEFINE_RWLOCK(cpufreq_driver_lock);
+static LIST_HEAD(cpufreq_policy_list);
 
 /*
  * cpu_policy_rwsem is a per CPU reader-writer semaphore designed to cure
@@ -989,6 +990,7 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 	}
 #endif
 
+	list_add(&policy->policy_list, &cpufreq_policy_list);
 	ret = cpufreq_add_dev_interface(cpu, policy, dev);
 	if (ret)
 		goto err_out_unregister;
@@ -1992,6 +1994,7 @@ int cpufreq_unregister_driver(struct cpufreq_driver *driver)
 	subsys_interface_unregister(&cpufreq_interface);
 	unregister_hotcpu_notifier(&cpufreq_cpu_notifier);
 
+	list_del(&cpufreq_policy_list);
 	write_lock_irqsave(&cpufreq_driver_lock, flags);
 	cpufreq_driver = NULL;
 	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index ab1932c..5348981 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -117,6 +117,7 @@ struct cpufreq_policy {
 
 	struct cpufreq_real_policy	user_policy;
 
+	struct list_head        policy_list;
 	struct kobject		kobj;
 	struct completion	kobj_unregister;
 };
-- 
1.7.10.4
