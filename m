From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: Avoid double addition/removal of sysfs links
Date: Wed, 22 Jul 2015 05:00:05 +0200
Message-ID: <10898142.yiJePgsQ3c@vostro.rjw.lan>
References: <20150718163149.GP7557@n2100.arm.linux.org.uk> <CAJZ5v0hXkEbRqd1ZWGABxbofQ+Y8yjn_JknVUXPGKy=kkE=Xhw@mail.gmail.com> <6175136.CkGk6PGZKa@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:57713 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753422AbbGVCdT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jul 2015 22:33:19 -0400
In-Reply-To: <6175136.CkGk6PGZKa@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

On Wednesday, July 22, 2015 03:56:21 AM Rafael J. Wysocki wrote:
> On Wednesday, July 22, 2015 01:15:01 AM Rafael J. Wysocki wrote:
> > Hi VIresh,
> > 
> > On Mon, Jul 20, 2015 at 11:47 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > Consider a dual core (0/1) system with two CPUs:
> > > - sharing clock/voltage rails and hence cpufreq-policy
> > > - CPU1 is offline while the cpufreq driver is registered
> > >
> > > - cpufreq_add_dev() is called from subsys callback for CPU0 and we
> > >   create the policy for the CPUs and create link for CPU1.
> > > - cpufreq_add_dev() is called from subsys callback for CPU1, we find
> > >   that the cpu is offline and we try to create a sysfs link for CPU1.
> > 
> > So the problem is that the cpu_is_offline(cpu) check in
> > cpufreq_add_dev() matches two distinct cases: (1) the CPU was not
> > present before and it is just being hot-added and (2) the CPU is
> > initially offline, but present, and this is the first time its device
> > is registered.  In the first case we can expect that the CPU will
> > become online shortly (although that is not guaranteed too), but in
> > the second case that very well may not happen.
> > 
> > We need to be able to distinguish between those two cases and your
> > patch does that, but I'm not sure if this really is the most
> > straightforward way to do it.
> 
> It looks like we need a mask of related CPUs that are present.  Or,
> alternatively, a mask of CPUs that would have been related had they
> been present.
> 
> That's sort of what your patch is adding, but not quite.

OK, below is my take on this (untested), on top of https://patchwork.kernel.org/patch/6839031/

We still only create policies for online CPUs which may be confusing in some
cases, but that's because drivers may not be able to handle CPUs that aren't
online.


---
 drivers/cpufreq/cpufreq.c |   41 +++++++++++++++++++++++++----------------
 include/linux/cpufreq.h   |    1 +
 2 files changed, 26 insertions(+), 16 deletions(-)

Index: linux-pm/include/linux/cpufreq.h
===================================================================
--- linux-pm.orig/include/linux/cpufreq.h
+++ linux-pm/include/linux/cpufreq.h
@@ -62,6 +62,7 @@ struct cpufreq_policy {
 	/* CPUs sharing clock, require sw coordination */
 	cpumask_var_t		cpus;	/* Online CPUs only */
 	cpumask_var_t		related_cpus; /* Online + Offline CPUs */
+	cpumask_var_t		real_cpus; /* Related and present */
 
 	unsigned int		shared_type; /* ACPI: ANY or ALL affected CPUs
 						should set cpufreq */
Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -1002,7 +1002,7 @@ static int cpufreq_add_dev_symlink(struc
 	int ret = 0;
 
 	/* Some related CPUs might not be present (physically hotplugged) */
-	for_each_cpu_and(j, policy->related_cpus, cpu_present_mask) {
+	for_each_cpu(j, policy->real_cpus) {
 		if (j == policy->kobj_cpu)
 			continue;
 
@@ -1019,7 +1019,7 @@ static void cpufreq_remove_dev_symlink(s
 	unsigned int j;
 
 	/* Some related CPUs might not be present (physically hotplugged) */
-	for_each_cpu_and(j, policy->related_cpus, cpu_present_mask) {
+	for_each_cpu(j, policy->real_cpus) {
 		if (j == policy->kobj_cpu)
 			continue;
 
@@ -1157,11 +1157,14 @@ static struct cpufreq_policy *cpufreq_po
 	if (!zalloc_cpumask_var(&policy->related_cpus, GFP_KERNEL))
 		goto err_free_cpumask;
 
+	if (!zalloc_cpumask_var(&policy->real_cpus, GFP_KERNEL))
+		goto err_free_rcpumask;
+
 	ret = kobject_init_and_add(&policy->kobj, &ktype_cpufreq, &dev->kobj,
 				   "cpufreq");
 	if (ret) {
 		pr_err("%s: failed to init policy->kobj: %d\n", __func__, ret);
-		goto err_free_rcpumask;
+		goto err_free_real_cpus;
 	}
 
 	INIT_LIST_HEAD(&policy->policy_list);
@@ -1178,6 +1181,8 @@ static struct cpufreq_policy *cpufreq_po
 
 	return policy;
 
+err_free_real_cpus:
+	free_cpumask_var(policy->real_cpus);
 err_free_rcpumask:
 	free_cpumask_var(policy->related_cpus);
 err_free_cpumask:
@@ -1228,6 +1233,7 @@ static void cpufreq_policy_free(struct c
 	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
 
 	cpufreq_policy_put_kobj(policy, notify);
+	free_cpumask_var(policy->real_cpus);
 	free_cpumask_var(policy->related_cpus);
 	free_cpumask_var(policy->cpus);
 	kfree(policy);
@@ -1252,14 +1258,17 @@ static int cpufreq_add_dev(struct device
 
 	pr_debug("adding CPU %u\n", cpu);
 
-	/*
-	 * Only possible if 'cpu' wasn't physically present earlier and we are
-	 * here from subsys_interface add callback. A hotplug notifier will
-	 * follow and we will handle it like logical CPU hotplug then. For now,
-	 * just create the sysfs link.
-	 */
-	if (cpu_is_offline(cpu))
-		return add_cpu_dev_symlink(per_cpu(cpufreq_cpu_data, cpu), cpu);
+	if (cpu_is_offline(cpu)) {
+		/*
+		 * Only possible if we are here from the subsys_interface add
+		 * callback.  A hotplug notifier will follow and we will handle
+		 * it as logical CPU hotplug then.  For now, just create the
+		 * sysfs link, unless there is no policy.
+		 */
+		policy = per_cpu(cpufreq_cpu_data, cpu);
+		return policy && !cpumask_test_and_set_cpu(cpu, policy->real_cpus)
+			? add_cpu_dev_symlink(policy, cpu) : 0;
+	}
 
 	if (!down_read_trylock(&cpufreq_rwsem))
 		return 0;
@@ -1301,6 +1310,9 @@ static int cpufreq_add_dev(struct device
 	/* related cpus should atleast have policy->cpus */
 	cpumask_or(policy->related_cpus, policy->related_cpus, policy->cpus);
 
+	cpumask_and(policy->cpus, policy->cpus, cpu_present_mask);
+	cpumask_or(policy->real_cpus, policy->real_cpus, policy->cpus);
+
 	/*
 	 * affected cpus must always be the one, which are online. We aren't
 	 * managing offline cpus here.
@@ -1525,19 +1537,16 @@ static int cpufreq_remove_dev(struct dev
 	 * link or free policy here.
 	 */
 	if (cpu_is_offline(cpu)) {
-		struct cpumask mask;
-
 		if (!policy)
 			return 0;
 
-		cpumask_copy(&mask, policy->related_cpus);
-		cpumask_clear_cpu(cpu, &mask);
+		cpumask_clear_cpu(cpu, policy->real_cpus);
 
 		/*
 		 * Free policy only if all policy->related_cpus are removed
 		 * physically.
 		 */
-		if (cpumask_intersects(&mask, cpu_present_mask)) {
+		if (!cpumask_empty(policy->real_cpus)) {
 			remove_cpu_dev_symlink(policy, cpu);
 			return 0;
 		}

