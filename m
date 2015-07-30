From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2] cpufreq: Avoid attempts to create duplicate symbolic
 links
Date: Thu, 30 Jul 2015 14:30:13 +0530
Message-ID: <20150730090013.GE31351@linux>
References: <1660815.CyKx9SEI9c@vostro.rjw.lan>
 <4080510.IQ60sVQvbL@vostro.rjw.lan>
 <20150727143935.GB18535@linux>
 <2112385.YuDJ7h1x56@vostro.rjw.lan>
 <20150729091136.GN7557@n2100.arm.linux.org.uk>
 <CAJZ5v0iUn0rSVSqyXscCfGgujpM7r9o9xjQgDOk+JQ=y6seRgQ@mail.gmail.com>
 <20150729142148.GF5100@linux>
 <CAJZ5v0gQTYgr1mweGV+CeQHgnkYp+PDwvqv09XRZHbMiQgjzQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gQTYgr1mweGV+CeQHgnkYp+PDwvqv09XRZHbMiQgjzQQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

I am not going to fight hard to prove a point as the code is in good
working conditions, but wanted to finish the discussion ..

On 29-07-15, 22:32, Rafael J. Wysocki wrote:
> On Wed, Jul 29, 2015 at 4:21 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > On 29-07-15, 15:57, Rafael J. Wysocki wrote:
> >> In practice, this means a cpufreq driver registration done in parallel
> >> with CPU hotplug.
> >
> > Not necessarily. Also consider the case where cpufreq driver is already working
> > for a set of CPUs. And a new set of CPUs (that will share the policy) are
> > getting physically added to the system.
> 
> That's what I mean by "hotplug" (as opposed to online/offline).

You were talking about driver registration done in parallel with
hotplug. But I was pointing at something else.

Suppose a system that has:
- 8 CPUs, 0-3 and 4-7 share policy
- 4-7 physically hotplugged out
- cpufreq driver registered and so policy0 active for cpu 0-3.
- We hotplug 4-7.

So, this is a bit different compared to the case where Russell mentioned
the Racy thing. Not sure if this case also has similary racy situations
though.

> Problem is, we can't do that for all of them.

Right.

> If the CPU is ofline
> while being registered (the common case for hot-add) and it doesn't
> have a policy already, we can't link it to an existing policy anyway,
> so that operation has to be carried out later.  That is, we need to
> create links for those CPUs after the policy has been created in any
> case.

Right, but at least the cpufreq-core is already requested on behalf of
such CPUs. We aren't creating links based on the assumption that a
add_dev() will be called for these devices.

> Moreover, the only case when we need to create links for online CPUs

offline CPUs as well..

> is the registration of a cpufreq driver, because only then we can see
> online CPUs that should be linked to a policy, but aren't.  It takes
> less code to treat them in the same way as the offline CPUs at that
> point (and create the links for them right after the policy has been
> created) than to defer it to until sif->add() is called for each of
> them, because we know that sif->add() is practically guaraneed to
> succeeed for them (this is the code path in which we call
> cpufreq_add_policy_cpu() and the governor "stop" only fails if it
> hasn't been started for that policy).

Choose whatever you feel is right. I have already written below code, so
just pasting it here. Its not to say, that this code looks better :P

---
 drivers/cpufreq/cpufreq.c | 108 +++++++++++++++++++++-------------------------
 1 file changed, 48 insertions(+), 60 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 24e4ba568e77..87faabce777d 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -31,6 +31,12 @@
 #include <linux/tick.h>
 #include <trace/events/power.h>
 
+/*
+ * CPUs that were offline when a request to allocate policy was issued, symlinks
+ * for them should be created once the policy is available for them.
+ */
+cpumask_t real_cpus_pending;
+
 static LIST_HEAD(cpufreq_policy_list);
 
 static inline bool policy_is_inactive(struct cpufreq_policy *policy)
@@ -941,62 +947,46 @@ EXPORT_SYMBOL(cpufreq_sysfs_remove_file);
 static int add_cpu_dev_symlink(struct cpufreq_policy *policy, int cpu)
 {
 	struct device *cpu_dev;
-
-	pr_debug("%s: Adding symlink for CPU: %u\n", __func__, cpu);
-
-	if (!policy)
-		return 0;
+	int ret;
 
 	cpu_dev = get_cpu_device(cpu);
 	if (WARN_ON(!cpu_dev))
 		return 0;
 
-	return sysfs_create_link(&cpu_dev->kobj, &policy->kobj, "cpufreq");
-}
-
-static void remove_cpu_dev_symlink(struct cpufreq_policy *policy, int cpu)
-{
-	struct device *cpu_dev;
-
-	pr_debug("%s: Removing symlink for CPU: %u\n", __func__, cpu);
+	dev_dbg(cpu_dev, "%s: Adding symlink for CPU: %u\n", __func__, cpu);
 
-	cpu_dev = get_cpu_device(cpu);
-	if (WARN_ON(!cpu_dev))
-		return;
+	ret = sysfs_create_link(&cpu_dev->kobj, &policy->kobj, "cpufreq");
+	if (ret)
+		dev_err(cpu_dev, "%s: Failed to create link (%d)\n", __func__,
+			ret);
+	else
+		cpumask_set_cpu(cpu, policy->real_cpus);
 
-	sysfs_remove_link(&cpu_dev->kobj, "cpufreq");
+	return ret;
 }
 
-/* Add/remove symlinks for all related CPUs */
-static int cpufreq_add_dev_symlink(struct cpufreq_policy *policy)
+/*
+ * Create symlinks for CPUs which are already added via subsys callbacks (and
+ * were offline then), before the policy was created.
+ */
+static int cpufreq_add_pending_symlinks(struct cpufreq_policy *policy)
 {
-	unsigned int j;
-	int ret = 0;
+	struct cpumask mask;
+	int cpu, ret;
+
+	cpumask_and(&mask, policy->related_cpus, &real_cpus_pending);
 
-	/* Some related CPUs might not be present (physically hotplugged) */
-	for_each_cpu(j, policy->real_cpus) {
-		if (j == policy->kobj_cpu)
-			continue;
+	if (cpumask_empty(&mask))
+		return 0;
 
-		ret = add_cpu_dev_symlink(policy, j);
+	for_each_cpu(cpu, &mask) {
+		ret = add_cpu_dev_symlink(policy, cpu);
 		if (ret)
-			break;
+			return ret;
+		cpumask_clear_cpu(cpu, &real_cpus_pending);
 	}
 
-	return ret;
-}
-
-static void cpufreq_remove_dev_symlink(struct cpufreq_policy *policy)
-{
-	unsigned int j;
-
-	/* Some related CPUs might not be present (physically hotplugged) */
-	for_each_cpu(j, policy->real_cpus) {
-		if (j == policy->kobj_cpu)
-			continue;
-
-		remove_cpu_dev_symlink(policy, j);
-	}
+	return 0;
 }
 
 static int cpufreq_add_dev_interface(struct cpufreq_policy *policy)
@@ -1028,7 +1018,7 @@ static int cpufreq_add_dev_interface(struct cpufreq_policy *policy)
 			return ret;
 	}
 
-	return cpufreq_add_dev_symlink(policy);
+	return cpufreq_add_pending_symlinks(policy);
 }
 
 static int cpufreq_init_policy(struct cpufreq_policy *policy)
@@ -1155,7 +1145,6 @@ static void cpufreq_policy_put_kobj(struct cpufreq_policy *policy, bool notify)
 					     CPUFREQ_REMOVE_POLICY, policy);
 
 	down_write(&policy->rwsem);
-	cpufreq_remove_dev_symlink(policy);
 	kobj = &policy->kobj;
 	cmp = &policy->kobj_unregister;
 	up_write(&policy->rwsem);
@@ -1235,10 +1224,9 @@ static int cpufreq_online(unsigned int cpu)
 	down_write(&policy->rwsem);
 
 	if (new_policy) {
+		cpumask_copy(policy->real_cpus, cpumask_of(cpu));
 		/* related_cpus should at least include policy->cpus. */
 		cpumask_or(policy->related_cpus, policy->related_cpus, policy->cpus);
-		/* Remember CPUs present at the policy creation time. */
-		cpumask_and(policy->real_cpus, policy->cpus, cpu_present_mask);
 	}
 
 	/*
@@ -1363,23 +1351,17 @@ static int cpufreq_online(unsigned int cpu)
 static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 {
 	unsigned cpu = dev->id;
-	int ret;
+	struct cpufreq_policy *policy = per_cpu(cpufreq_cpu_data, cpu);
+	int ret = 0;
 
 	dev_dbg(dev, "%s: adding CPU%u\n", __func__, cpu);
 
-	if (cpu_online(cpu)) {
+	if (policy)
+		ret = add_cpu_dev_symlink(policy, cpu);
+	else if (cpu_online(cpu))
 		ret = cpufreq_online(cpu);
-	} else {
-		/*
-		 * A hotplug notifier will follow and we will handle it as CPU
-		 * online then.  For now, just create the sysfs link, unless
-		 * there is no policy or the link is already present.
-		 */
-		struct cpufreq_policy *policy = per_cpu(cpufreq_cpu_data, cpu);
-
-		ret = policy && !cpumask_test_and_set_cpu(cpu, policy->real_cpus)
-			? add_cpu_dev_symlink(policy, cpu) : 0;
-	}
+	else
+		cpumask_set_cpu(cpu, &real_cpus_pending);
 
 	return ret;
 }
@@ -1469,8 +1451,10 @@ static int cpufreq_remove_dev(struct device *dev, struct subsys_interface *sif)
 	unsigned int cpu = dev->id;
 	struct cpufreq_policy *policy = per_cpu(cpufreq_cpu_data, cpu);
 
-	if (!policy)
+	if (!policy) {
+		cpumask_clear_cpu(cpu, &real_cpus_pending);
 		return 0;
+	}
 
 	if (cpu_online(cpu)) {
 		cpufreq_offline_prepare(cpu);
@@ -1485,7 +1469,8 @@ static int cpufreq_remove_dev(struct device *dev, struct subsys_interface *sif)
 	}
 
 	if (cpu != policy->kobj_cpu) {
-		remove_cpu_dev_symlink(policy, cpu);
+		dev_dbg(dev, "%s: Removing symlink\n", __func__);
+		sysfs_remove_link(&dev->kobj, "cpufreq");
 	} else {
 		/*
 		 * The CPU owning the policy object is going away.  Move it to
@@ -2550,6 +2535,9 @@ int cpufreq_unregister_driver(struct cpufreq_driver *driver)
 	if (cpufreq_boost_supported())
 		cpufreq_sysfs_remove_file(&boost.attr);
 
+	if (WARN_ON(!cpumask_empty(&real_cpus_pending)))
+		cpumask_clear(&real_cpus_pending);
+
 	unregister_hotcpu_notifier(&cpufreq_cpu_notifier);
 
 	write_lock_irqsave(&cpufreq_driver_lock, flags);
