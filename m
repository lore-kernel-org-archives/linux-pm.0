From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH 1/5] cpufreq: Define cpufreq_set_drv_attr_files() to add per
 CPU sysfs attributes
Date: Thu, 06 Jun 2013 09:07:48 +0200
Message-ID: <1370502472-7249-2-git-send-email-l.majewski@samsung.com>
References: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocky" <rjw@sisk.pl>
Cc: "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Lukasz Majewski <l.majewski@samsung.com>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, linux-kernel <linux-kernel@vger.kernel.org>, Lukasz Majewski <l.majewski@majess.pl>, Andre Przywara <andre.przywara@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
List-Id: linux-pm@vger.kernel.org

The cpufreq_set_drv_attr_files() function creates sysfs file entry for
each available CPU. With it in place it is possible to add different
set of attributes without code duplication.

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
Signed-off-by: Myungjoo Ham <myungjoo.ham@samsung.com>
---
 drivers/cpufreq/cpufreq.c |   23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 1b8a48e..ca74e27 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -730,12 +730,23 @@ static int cpufreq_add_dev_symlink(unsigned int cpu,
 	return ret;
 }
 
+static int cpufreq_set_drv_attr_files(struct cpufreq_policy *policy,
+				      struct freq_attr **drv_attr)
+{
+	while ((drv_attr) && (*drv_attr)) {
+		if (sysfs_create_file(&policy->kobj, &((*drv_attr)->attr)))
+			return 1;
+		drv_attr++;
+	}
+
+	return 0;
+}
+
 static int cpufreq_add_dev_interface(unsigned int cpu,
 				     struct cpufreq_policy *policy,
 				     struct device *dev)
 {
 	struct cpufreq_policy new_policy;
-	struct freq_attr **drv_attr;
 	unsigned long flags;
 	int ret = 0;
 	unsigned int j;
@@ -747,13 +758,9 @@ static int cpufreq_add_dev_interface(unsigned int cpu,
 		return ret;
 
 	/* set up files for this cpu device */
-	drv_attr = cpufreq_driver->attr;
-	while ((drv_attr) && (*drv_attr)) {
-		ret = sysfs_create_file(&policy->kobj, &((*drv_attr)->attr));
-		if (ret)
-			goto err_out_kobj_put;
-		drv_attr++;
-	}
+	if (cpufreq_set_drv_attr_files(policy, cpufreq_driver->attr))
+		goto err_out_kobj_put;
+
 	if (cpufreq_driver->get) {
 		ret = sysfs_create_file(&policy->kobj, &cpuinfo_cur_freq.attr);
 		if (ret)
-- 
1.7.10.4
