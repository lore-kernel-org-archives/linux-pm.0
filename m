From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: Kernel warning in cpufreq_add_dev()
Date: Wed, 24 Aug 2016 18:43:16 +0530
Message-ID: <20160824131316.GI25143@ubuntu>
References: <20160819110032.GM1041@n2100.armlinux.org.uk>
 <1601399.OxUAWWKTJN@vostro.rjw.lan>
 <20160820014634.GA25143@ubuntu>
 <2310664.2BksGViL4r@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:35222 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752805AbcHXNNY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Aug 2016 09:13:24 -0400
Received: by mail-pf0-f176.google.com with SMTP id x72so6909463pfd.2
        for <linux-pm@vger.kernel.org>; Wed, 24 Aug 2016 06:13:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2310664.2BksGViL4r@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 22-08-16, 19:32, Rafael J. Wysocki wrote:
> But it will be called in that path during physical CPU hot-add, won't it?

What about something like this instead (completely untested) ?

@Russell: Can you please try this ??

-- 
viresh

-------------------------8<-------------------------

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 3dd4884c6f9e..a702d6246385 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -916,20 +916,11 @@ static struct kobj_type ktype_cpufreq = {
 	.release	= cpufreq_sysfs_release,
 };
 
-static int add_cpu_dev_symlink(struct cpufreq_policy *policy, int cpu)
+static int add_cpu_dev_symlink(struct cpufreq_policy *policy,
+			       struct device *dev)
 {
-	struct device *cpu_dev;
-
-	pr_debug("%s: Adding symlink for CPU: %u\n", __func__, cpu);
-
-	if (!policy)
-		return 0;
-
-	cpu_dev = get_cpu_device(cpu);
-	if (WARN_ON(!cpu_dev))
-		return 0;
-
-	return sysfs_create_link(&cpu_dev->kobj, &policy->kobj, "cpufreq");
+	dev_dbg(dev, "%s: Adding symlink\n", __func__);
+	return sysfs_create_link(&dev->kobj, &policy->kobj, "cpufreq");
 }
 
 static void remove_cpu_dev_symlink(struct cpufreq_policy *policy, int cpu)
@@ -948,12 +939,17 @@ static void remove_cpu_dev_symlink(struct cpufreq_policy *policy, int cpu)
 /* Add/remove symlinks for all related CPUs */
 static int cpufreq_add_dev_symlink(struct cpufreq_policy *policy)
 {
+	struct device *cpu_dev;
 	unsigned int j;
 	int ret = 0;
 
 	/* Some related CPUs might not be present (physically hotplugged) */
 	for_each_cpu(j, policy->real_cpus) {
-		ret = add_cpu_dev_symlink(policy, j);
+		cpu_dev = get_cpu_device(j);
+		if (WARN_ON(!cpu_dev))
+			continue;
+
+		ret = add_cpu_dev_symlink(policy, cpu_dev);
 		if (ret)
 			break;
 	}
@@ -1073,13 +1069,9 @@ static void handle_update(struct work_struct *work)
 
 static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
 {
-	struct device *dev = get_cpu_device(cpu);
 	struct cpufreq_policy *policy;
 	int ret;
 
-	if (WARN_ON(!dev))
-		return NULL;
-
 	policy = kzalloc(sizeof(*policy), GFP_KERNEL);
 	if (!policy)
 		return NULL;
@@ -1355,7 +1347,7 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 	if (!policy || cpumask_test_and_set_cpu(cpu, policy->real_cpus))
 		return 0;
 
-	return add_cpu_dev_symlink(policy, cpu);
+	return add_cpu_dev_symlink(policy, dev);
 }
 
 static void cpufreq_offline(unsigned int cpu)
