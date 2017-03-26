From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: create sysfs symlink for cpus onlined after boot
Date: Sun, 26 Mar 2017 03:19:54 +0200
Message-ID: <2246294.s9H9y0mptv@aspire.rjw.lan>
References: <1490304286-18311-1-git-send-email-pprakash@codeaurora.org> <372627201.N4ERmeoXuC@aspire.rjw.lan> <2716739.7ZKP1HnjcS@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:51801 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751227AbdCZBZn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 25 Mar 2017 21:25:43 -0400
In-Reply-To: <2716739.7ZKP1HnjcS@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Prakash, Prashanth" <pprakash@codeaurora.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>

On Sunday, March 26, 2017 03:05:56 AM Rafael J. Wysocki wrote:
> On Saturday, March 25, 2017 06:15:07 PM Rafael J. Wysocki wrote:
> > On Saturday, March 25, 2017 02:30:52 PM Rafael J. Wysocki wrote:
> > > On Friday, March 24, 2017 10:31:51 AM Prakash, Prashanth wrote:
> > > > On 3/23/2017 5:30 PM, Rafael J. Wysocki wrote:
> > > > > On Thu, Mar 23, 2017 at 10:24 PM, Prashanth Prakash
> > > > > <pprakash@codeaurora.org> wrote:
> > > > >> Adds an additional code path within cpufreq_online to create sysfs
> > > > >> symlinks for cpus that are bought onilne for the first time after
> > > > >> completion of boot.
> > > > >>
> > > > >> With maxcpus=N kernel parameter, it is possible to bring additional
> > > > >> cpus online after boot. In these cases per-cpu "cpufreq" symlinks
> > > > >> are not being created during registration as policy may not exist
> > > > >> for the cpus that were offline during boot.
> > > > >>
> > > > >> Signed-off-by: Prashanth Prakash <pprakash@codeaurora.org>
> > > > > This looks way overly complicated to me.  Let me look at it in the
> > > > > next couple of days.
> > > > Sure. Thanks!
> > > 
> > > So the patch below works for me.  Please test.
> > > 
> > > The problem is that we only try to create links once, when CPUs are registered
> > > or when the cpufreq driver is registered (depending on which happens first),
> > > but if all CPUs that would share a policy are offline at that time, the policy is not
> > > there and we don't create the links at all.
> > > 
> > > This means we also need to try to create the links when creating a new policy
> > > (because the CPUs may have been added without the links at this point already).
> > > 
> > > A slight side effect of this is that failures to create links are not regarded
> > > as hard errors now and only cause messages to be printed, but I don't see
> > > how that could be a big issue.
> > 
> > Actually, the rwlock around the for_each_cpu() loop in cpufreq_online() doesn't
> > matter AFAICS, so the code can be slightly simplified by dropping it.
> 
> And I forgot about the cleanup on errors in cpufreq_online(), so one more
> update follows (with a changelog and all).

One more update, sorry.

remove_cpu_dev_symlink() needs a device pointer, not a CPU number.  Also the
links cleanup need not be done under policy->rwsem.

---
From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH] cpufreq: Fix creation of symbolic links to policy directories

The cpufreq core only tries to create symbolic links from CPU
directories in sysfs to policy directories in cpufreq_add_dev(),
either when a given CPU is registered or when the cpufreq driver
is registered, whichever happens first.  That is not sufficient,
however, because cpufreq_add_dev() may be called for an offline CPU
whose policy object has not been created yet and, quite obviously,
the symbolic cannot be added in that case.

Fix that by making cpufreq_online() attempt to add symbolic links to
policy objects for the CPUs in the related_cpus mask of every new
policy object created by it.

The cpufreq_driver_lock locking around the for_each_cpu() loop
in cpufreq_online() is dropped, because it is not necessary and the
code is somewhat simpler without it.  Moreover, failures to create
a symbolic link will not be regarded as hard errors any more and
the CPUs without those links will not be taken offline automatically,
but that should not be problematic in practice.

Reported-by: Prashanth Prakash <pprakash@codeaurora.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c |   38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -918,11 +918,19 @@ static struct kobj_type ktype_cpufreq =
 	.release	= cpufreq_sysfs_release,
 };
 
-static int add_cpu_dev_symlink(struct cpufreq_policy *policy,
-			       struct device *dev)
+static void add_cpu_dev_symlink(struct cpufreq_policy *policy, unsigned int cpu)
 {
+	struct device *dev = get_cpu_device(cpu);
+
+	if (!dev)
+		return;
+
+	if (cpumask_test_and_set_cpu(cpu, policy->real_cpus))
+		return;
+
 	dev_dbg(dev, "%s: Adding symlink\n", __func__);
-	return sysfs_create_link(&dev->kobj, &policy->kobj, "cpufreq");
+	if (sysfs_create_link(&dev->kobj, &policy->kobj, "cpufreq"))
+		dev_err(dev, "cpufreq symlink creation failed\n");
 }
 
 static void remove_cpu_dev_symlink(struct cpufreq_policy *policy,
@@ -1180,10 +1188,10 @@ static int cpufreq_online(unsigned int c
 		policy->user_policy.min = policy->min;
 		policy->user_policy.max = policy->max;
 
-		write_lock_irqsave(&cpufreq_driver_lock, flags);
-		for_each_cpu(j, policy->related_cpus)
+		for_each_cpu(j, policy->related_cpus) {
 			per_cpu(cpufreq_cpu_data, j) = policy;
-		write_unlock_irqrestore(&cpufreq_driver_lock, flags);
+			add_cpu_dev_symlink(policy, j);
+		}
 	} else {
 		policy->min = policy->user_policy.min;
 		policy->max = policy->user_policy.max;
@@ -1275,13 +1283,15 @@ out_exit_policy:
 
 	if (cpufreq_driver->exit)
 		cpufreq_driver->exit(policy);
+
+	for_each_cpu(j, policy->real_cpus)
+		remove_cpu_dev_symlink(policy, get_cpu_device(j));
+
 out_free_policy:
 	cpufreq_policy_free(policy);
 	return ret;
 }
 
-static int cpufreq_offline(unsigned int cpu);
-
 /**
  * cpufreq_add_dev - the cpufreq interface for a CPU device.
  * @dev: CPU device.
@@ -1303,16 +1313,10 @@ static int cpufreq_add_dev(struct device
 
 	/* Create sysfs link on CPU registration */
 	policy = per_cpu(cpufreq_cpu_data, cpu);
-	if (!policy || cpumask_test_and_set_cpu(cpu, policy->real_cpus))
-		return 0;
+	if (policy)
+		add_cpu_dev_symlink(policy, cpu);
 
-	ret = add_cpu_dev_symlink(policy, dev);
-	if (ret) {
-		cpumask_clear_cpu(cpu, policy->real_cpus);
-		cpufreq_offline(cpu);
-	}
-
-	return ret;
+	return 0;
 }
 
 static int cpufreq_offline(unsigned int cpu)
