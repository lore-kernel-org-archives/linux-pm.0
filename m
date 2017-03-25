From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: create sysfs symlink for cpus onlined after boot
Date: Sat, 25 Mar 2017 14:30:52 +0100
Message-ID: <10150781.HaZ29TrTvP@aspire.rjw.lan>
References: <1490304286-18311-1-git-send-email-pprakash@codeaurora.org> <CAJZ5v0j956ttMf3Oaek2=xSKFeqKnhO=1+RN3+81H5E1rXY4UA@mail.gmail.com> <f2e4a303-715d-17f7-7dcd-e48dc3eee407@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:64181 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750731AbdCYNgb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 25 Mar 2017 09:36:31 -0400
In-Reply-To: <f2e4a303-715d-17f7-7dcd-e48dc3eee407@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Prakash, Prashanth" <pprakash@codeaurora.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>

On Friday, March 24, 2017 10:31:51 AM Prakash, Prashanth wrote:
> On 3/23/2017 5:30 PM, Rafael J. Wysocki wrote:
> > On Thu, Mar 23, 2017 at 10:24 PM, Prashanth Prakash
> > <pprakash@codeaurora.org> wrote:
> >> Adds an additional code path within cpufreq_online to create sysfs
> >> symlinks for cpus that are bought onilne for the first time after
> >> completion of boot.
> >>
> >> With maxcpus=N kernel parameter, it is possible to bring additional
> >> cpus online after boot. In these cases per-cpu "cpufreq" symlinks
> >> are not being created during registration as policy may not exist
> >> for the cpus that were offline during boot.
> >>
> >> Signed-off-by: Prashanth Prakash <pprakash@codeaurora.org>
> > This looks way overly complicated to me.  Let me look at it in the
> > next couple of days.
> Sure. Thanks!

So the patch below works for me.  Please test.

The problem is that we only try to create links once, when CPUs are registered
or when the cpufreq driver is registered (depending on which happens first),
but if all CPUs that would share a policy are offline at that time, the policy is not
there and we don't create the links at all.

This means we also need to try to create the links when creating a new policy
(because the CPUs may have been added without the links at this point already).

A slight side effect of this is that failures to create links are not regarded
as hard errors now and only cause messages to be printed, but I don't see
how that could be a big issue.

---
 drivers/cpufreq/cpufreq.c |   30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -918,11 +918,20 @@ static struct kobj_type ktype_cpufreq =
 	.release	= cpufreq_sysfs_release,
 };
 
-static int add_cpu_dev_symlink(struct cpufreq_policy *policy,
-			       struct device *dev)
+static void add_cpu_dev_symlink(struct cpufreq_policy *policy, unsigned int cpu)
 {
+	struct device *dev;
+
+	if (cpumask_test_and_set_cpu(cpu, policy->real_cpus))
+		return;
+
+	dev = get_cpu_device(cpu);
+	if (!dev)
+		return;
+
 	dev_dbg(dev, "%s: Adding symlink\n", __func__);
-	return sysfs_create_link(&dev->kobj, &policy->kobj, "cpufreq");
+	if (sysfs_create_link(&dev->kobj, &policy->kobj, "cpufreq"))
+		dev_err(dev, "cpufreq symlink creation failed\n");
 }
 
 static void remove_cpu_dev_symlink(struct cpufreq_policy *policy,
@@ -1184,6 +1193,9 @@ static int cpufreq_online(unsigned int c
 		for_each_cpu(j, policy->related_cpus)
 			per_cpu(cpufreq_cpu_data, j) = policy;
 		write_unlock_irqrestore(&cpufreq_driver_lock, flags);
+
+		for_each_cpu(j, policy->related_cpus)
+			add_cpu_dev_symlink(policy, j);
 	} else {
 		policy->min = policy->user_policy.min;
 		policy->max = policy->user_policy.max;
@@ -1303,16 +1315,10 @@ static int cpufreq_add_dev(struct device
 
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
