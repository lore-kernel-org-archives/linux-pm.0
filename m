From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] cpufreq: Avoid double addition/removal of sysfs links
Date: Mon, 20 Jul 2015 15:17:10 +0530
Message-ID: <a8a3c524facf3b2c1621a54d09c7022f4267d2e5.1437385355.git.viresh.kumar@linaro.org>
References: <20150718163149.GP7557@n2100.arm.linux.org.uk>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:35401 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752460AbbGTJrR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jul 2015 05:47:17 -0400
Received: by pdrg1 with SMTP id g1so99468251pdr.2
        for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2015 02:47:16 -0700 (PDT)
In-Reply-To: <20150718163149.GP7557@n2100.arm.linux.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, linux@arm.linux.org.uk
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, open list <linux-kernel@vger.kernel.org>

Consider a dual core (0/1) system with two CPUs:
- sharing clock/voltage rails and hence cpufreq-policy
- CPU1 is offline while the cpufreq driver is registered

- cpufreq_add_dev() is called from subsys callback for CPU0 and we
  create the policy for the CPUs and create link for CPU1.
- cpufreq_add_dev() is called from subsys callback for CPU1, we find
  that the cpu is offline and we try to create a sysfs link for CPU1.
- This results in double addition of the sysfs link and we get this:

	WARNING: CPU: 0 PID: 1 at fs/sysfs/dir.c:31 sysfs_warn_dup+0x60/0x7c()
	sysfs: cannot create duplicate filename '/devices/system/cpu/cpu1/cpufreq'
	Modules linked in:
	CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.2.0-rc2+ #1704
	Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
	Backtrace:
	[<c0013248>] (dump_backtrace) from [<c00133e4>] (show_stack+0x18/0x1c)
	 r6:c01a1f30 r5:0000001f r4:00000000 r3:00000000
	[<c00133cc>] (show_stack) from [<c076920c>] (dump_stack+0x7c/0x98)
	[<c0769190>] (dump_stack) from [<c0029ab4>] (warn_slowpath_common+0x80/0xbc)
	 r4:d74abbd0 r3:d74c0000
	[<c0029a34>] (warn_slowpath_common) from [<c0029b94>] (warn_slowpath_fmt+0x38/0x40)
	 r8:ffffffef r7:00000000 r6:d75a8960 r5:c0993280 r4:d6b4d000
	[<c0029b60>] (warn_slowpath_fmt) from [<c01a1f30>] (sysfs_warn_dup+0x60/0x7c)
	 r3:d6b4dfe7 r2:c0930750
	[<c01a1ed0>] (sysfs_warn_dup) from [<c01a22c8>] (sysfs_do_create_link_sd+0xb8/0xc0)
	 r6:d75a8960 r5:c0993280 r4:d00aba20
	[<c01a2210>] (sysfs_do_create_link_sd) from [<c01a22fc>] (sysfs_create_link+0x2c/0x3c)
	 r10:00000001 r8:c14db3c8 r7:d7b89010 r6:c0ae7c60 r5:d7b89010 r4:d00d1200
	[<c01a22d0>] (sysfs_create_link) from [<c0506160>] (add_cpu_dev_symlink+0x34/0x5c)
	[<c050612c>] (add_cpu_dev_symlink) from [<c05084d0>] (cpufreq_add_dev+0x674/0x794)
	 r5:00000001 r4:00000000
	[<c0507e5c>] (cpufreq_add_dev) from [<c03db114>] (subsys_interface_register+0x8c/0xd0)
	 r10:00000003 r9:d7bb01f0 r8:c14db3c8 r7:00106738 r6:c0ae7c60 r5:c0acbd08
	 r4:c0ae7e20
	[<c03db088>] (subsys_interface_register) from [<c0508a2c>] (cpufreq_register_driver+0x104/0x1f4)


The check for offline-cpu in cpufreq_add_dev() is present to ensure that
link gets added for the CPUs, that weren't physically present earlier
and we missed the case where a CPU is offline while registering the
driver.

Fix this by keeping track of CPUs for which link is already created, and
avoiding duplicate sysfs entries.

Fixes: 87549141d516 ("cpufreq: Stop migrating sysfs files on hotplug")
Reported-by: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Russell,

Can you please give this a try? (completely untested).

 drivers/cpufreq/cpufreq.c | 26 +++++++++++++++++++++++---
 include/linux/cpufreq.h   |  1 +
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index cdbe0676d246..12d089b78cad 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -984,17 +984,26 @@ EXPORT_SYMBOL(cpufreq_sysfs_remove_file);
 static int add_cpu_dev_symlink(struct cpufreq_policy *policy, int cpu)
 {
 	struct device *cpu_dev;
+	int ret;
 
 	pr_debug("%s: Adding symlink for CPU: %u\n", __func__, cpu);
 
 	if (!policy)
 		return 0;
 
+	/* Already added for offline CPUS from subsys callback */
+	if (cpumask_test_cpu(cpu, policy->symlinks))
+		return 0;
+
 	cpu_dev = get_cpu_device(cpu);
 	if (WARN_ON(!cpu_dev))
 		return 0;
 
-	return sysfs_create_link(&cpu_dev->kobj, &policy->kobj, "cpufreq");
+	ret = sysfs_create_link(&cpu_dev->kobj, &policy->kobj, "cpufreq");
+	if (!ret)
+		cpumask_set_cpu(cpu, policy->symlinks);
+
+	return ret;
 }
 
 static void remove_cpu_dev_symlink(struct cpufreq_policy *policy, int cpu)
@@ -1007,6 +1016,7 @@ static void remove_cpu_dev_symlink(struct cpufreq_policy *policy, int cpu)
 	if (WARN_ON(!cpu_dev))
 		return;
 
+	cpumask_clear_cpu(cpu, policy->symlinks);
 	sysfs_remove_link(&cpu_dev->kobj, "cpufreq");
 }
 
@@ -1038,6 +1048,10 @@ static void cpufreq_remove_dev_symlink(struct cpufreq_policy *policy)
 		if (j == policy->kobj_cpu)
 			continue;
 
+		/* Already removed for offline CPUS from subsys callback */
+		if (!cpumask_test_cpu(j, policy->symlinks))
+			continue;
+
 		remove_cpu_dev_symlink(policy, j);
 	}
 }
@@ -1172,11 +1186,14 @@ static struct cpufreq_policy *cpufreq_policy_alloc(struct device *dev)
 	if (!zalloc_cpumask_var(&policy->related_cpus, GFP_KERNEL))
 		goto err_free_cpumask;
 
+	if (!zalloc_cpumask_var(&policy->symlinks, GFP_KERNEL))
+		goto err_free_related_cpumask;
+
 	ret = kobject_init_and_add(&policy->kobj, &ktype_cpufreq, &dev->kobj,
 				   "cpufreq");
 	if (ret) {
 		pr_err("%s: failed to init policy->kobj: %d\n", __func__, ret);
-		goto err_free_rcpumask;
+		goto err_free_symlink_cpumask;
 	}
 
 	INIT_LIST_HEAD(&policy->policy_list);
@@ -1193,7 +1210,9 @@ static struct cpufreq_policy *cpufreq_policy_alloc(struct device *dev)
 
 	return policy;
 
-err_free_rcpumask:
+err_free_symlink_cpumask:
+	free_cpumask_var(policy->symlinks);
+err_free_related_cpumask:
 	free_cpumask_var(policy->related_cpus);
 err_free_cpumask:
 	free_cpumask_var(policy->cpus);
@@ -1243,6 +1262,7 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy, bool notify)
 	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
 
 	cpufreq_policy_put_kobj(policy, notify);
+	free_cpumask_var(policy->symlinks);
 	free_cpumask_var(policy->related_cpus);
 	free_cpumask_var(policy->cpus);
 	kfree(policy);
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index a82049683016..b4812f6977c6 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -62,6 +62,7 @@ struct cpufreq_policy {
 	/* CPUs sharing clock, require sw coordination */
 	cpumask_var_t		cpus;	/* Online CPUs only */
 	cpumask_var_t		related_cpus; /* Online + Offline CPUs */
+	cpumask_var_t		symlinks; /* CPUs for which cpufreq sysfs directory is present */
 
 	unsigned int		shared_type; /* ACPI: ANY or ALL affected CPUs
 						should set cpufreq */
-- 
2.4.0

