From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 3/7] cpufreq: Introduce ->usable() callback for cpufreq drivers
Date: Wed, 26 Nov 2014 11:22:58 +0530
Message-ID: <95b84bb8af3d4d9667a79db520cfa37d9444d75b.1416980448.git.viresh.kumar@linaro.org>
References: <cover.1416980447.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:37949 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752211AbaKZFxa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Nov 2014 00:53:30 -0500
Received: by mail-pd0-f171.google.com with SMTP id y13so2111487pdi.16
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2014 21:53:29 -0800 (PST)
In-Reply-To: <cover.1416980447.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1416980447.git.viresh.kumar@linaro.org>
References: <cover.1416980447.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, edubezval@gmail.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, l.majewski@samsung.com, Viresh Kumar <viresh.kumar@linaro.org>

Currently there is no callback for cpufreq drivers which is called once the
policy is ready to be used. There are some requirements where such a callback is
required.

One of them is registering a cooling device with the help of
of_cpufreq_cooling_register(). This routine tries to get 'struct cpufreq_policy'
for CPUs which isn't yet initialed at the time ->init() is called and so we face
issues while registering the cooling device.

Because we can't register cooling device from ->init(), we need a callback that
is called after the policy is ready to be used and hence we introduce ->usable()
callback.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 5 +++++
 include/linux/cpufreq.h   | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index de2c3e1..4fb95b9 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1285,8 +1285,13 @@ static int __cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 	up_write(&policy->rwsem);
 
 	kobject_uevent(&policy->kobj, KOBJ_ADD);
+
 	up_read(&cpufreq_rwsem);
 
+	/* Callback for handling stuff after policy is ready */
+	if (cpufreq_driver->usable)
+		cpufreq_driver->usable(policy);
+
 	pr_debug("initialization complete\n");
 
 	return 0;
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index db3c130..4795c0b 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -267,6 +267,10 @@ struct cpufreq_driver {
 	void		(*stop_cpu)(struct cpufreq_policy *policy);
 	int		(*suspend)(struct cpufreq_policy *policy);
 	int		(*resume)(struct cpufreq_policy *policy);
+
+	/* Will be called after the driver is fully initialized */
+	void		(*usable)(struct cpufreq_policy *policy);
+
 	struct freq_attr **attr;
 
 	/* platform specific boost support code */
-- 
2.0.3.693.g996b0fd

