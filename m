From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2] cpufreq: stats: Walk online CPUs with CPU
 offline/online locked
Date: Tue, 24 May 2016 10:26:30 +0530
Message-ID: <20160524045630.GP17585@vireshk-i7>
References: <19792191.esL3UuyORb@vostro.rjw.lan>
 <5580598.s7imtWPVt5@vostro.rjw.lan>
 <20160523035703.GF2850@vireshk-i7>
 <3351136.myUMJKBnm0@vostro.rjw.lan>
 <20160523151910.GC17585@vireshk-i7>
 <CAJZ5v0h-1rqishrGAJXnvzyKjxoAxMcitW64LCZqtGC6vTRmCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0h-1rqishrGAJXnvzyKjxoAxMcitW64LCZqtGC6vTRmCg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On 23-05-16, 22:47, Rafael J. Wysocki wrote:
> Assuming that the loops are over online CPUs and not over possible
> CPUs I suppose?

I wasn't focussing on that loop lately but the policy->rwsem :)

> Anyway, if you are talking about the code without the patch (which I
> guess is the case), the reason why it is racy is because, if
> cpufreq_stats_init() runs in parallel with CPU online, the CPU going
> online may be missed by it.  To my eyes that happens if
> cpufreq_online() has already advanced beyond the point where the
> notifier would have been invoked, but hasn't returned yet when the
> for_each_online_cpu() loop in cpufreq_stats_init() is executed.

Yes. That's a race we need to fix. I agree.

> Worse yet, if a CPU goes offline when cpufreq_stats_exit() is running
> and that happens exactly between the notifier unregistration and the
> for_each_online_cpu() loop, the stats table will never be freed for
> that CPU (say the policy isn't shared).

Same here.

> Switching over to loops over possible CPUs doesn't address those races
> (at least not the second one), and I'm not really sure why I thought
> it would address them, but adding CPU online/offline locking to
> cpufreq_stats_init/exit() can address them, so it looks like the very
> first version of my patch (ie.
> https://patchwork.kernel.org/patch/9128509/) was actually correct,
> because it didn't put too much code under the CPU offline/online
> locking. :-)

Well, I think there is one more way of getting all this fixed, which may
eventually look much more cleaner.

What if we update cpufreq core instead of stats with something like this:

-------------------------8<-------------------------

From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Tue, 24 May 2016 10:16:25 +0530
Subject: [PATCH] cpufreq: Initiate notifiers for existing policy

Races are possible in the init/exit paths of the cpufreq-stats layer,
which may lead to 'stats' sysfs directory not getting created or removed
for some of the policies. This can happen while the policy is getting
created while cpufreq_stats_init/exit() are getting called.

To avoid adding unnecessary locks in the init/exit paths of the
cpufreq-stats layer, update the policy notifier register/unregister
routines to send notifications for any existing cpufreq policies.

Also make sure (with help of cpufreq_driver_lock) that
CPUFREQ_CREATE/REMOVE notifiers aren't getting issued in parallel from
the policy creation/removal paths.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c       | 35 +++++++++++++++++++++++++-
 drivers/cpufreq/cpufreq_stats.c | 55 ++++++-----------------------------------
 2 files changed, 41 insertions(+), 49 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index c3f950f0e5f0..90f4bf03701d 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1269,10 +1269,10 @@ static int cpufreq_online(unsigned int cpu)
 		ret = cpufreq_add_dev_interface(policy);
 		if (ret)
 			goto out_exit_policy;
+		write_lock_irqsave(&cpufreq_driver_lock, flags);
 		blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
 				CPUFREQ_CREATE_POLICY, policy);
 
-		write_lock_irqsave(&cpufreq_driver_lock, flags);
 		list_add(&policy->policy_list, &cpufreq_policy_list);
 		write_unlock_irqrestore(&cpufreq_driver_lock, flags);
 	}
@@ -1728,6 +1728,8 @@ EXPORT_SYMBOL_GPL(cpufreq_get_driver_data);
  */
 int cpufreq_register_notifier(struct notifier_block *nb, unsigned int list)
 {
+	struct cpufreq_policy *policy;
+	unsigned long flags;
 	int ret;
 
 	if (cpufreq_disabled())
@@ -1751,8 +1753,28 @@ int cpufreq_register_notifier(struct notifier_block *nb, unsigned int list)
 		mutex_unlock(&cpufreq_fast_switch_lock);
 		break;
 	case CPUFREQ_POLICY_NOTIFIER:
+		write_lock_irqsave(&cpufreq_driver_lock, flags);
+
+		/* Notify about all existing policies */
+		for_each_policy(policy) {
+			nb->notifier_call(nb, CPUFREQ_CREATE_POLICY,
+					policy);
+			if (policy_is_inactive(policy))
+				continue;
+
+			nb->notifier_call(nb, CPUFREQ_START, policy);
+		}
+
 		ret = blocking_notifier_chain_register(
 				&cpufreq_policy_notifier_list, nb);
+		if (ret) {
+			/* Notify about all existing policies */
+			for_each_policy(policy) {
+				nb->notifier_call(nb, CPUFREQ_REMOVE_POLICY,
+						  policy);
+			}
+		}
+		write_unlock_irqrestore(&cpufreq_driver_lock, flags);
 		break;
 	default:
 		ret = -EINVAL;
@@ -1774,6 +1796,8 @@ EXPORT_SYMBOL(cpufreq_register_notifier);
  */
 int cpufreq_unregister_notifier(struct notifier_block *nb, unsigned int list)
 {
+	struct cpufreq_policy *policy;
+	unsigned long flags;
 	int ret;
 
 	if (cpufreq_disabled())
@@ -1793,6 +1817,15 @@ int cpufreq_unregister_notifier(struct notifier_block *nb, unsigned int list)
 	case CPUFREQ_POLICY_NOTIFIER:
 		ret = blocking_notifier_chain_unregister(
 				&cpufreq_policy_notifier_list, nb);
+		if (!ret) {
+			write_lock_irqsave(&cpufreq_driver_lock, flags);
+			/* Notify about all existing policies */
+			for_each_policy(policy) {
+				nb->notifier_call(nb, CPUFREQ_REMOVE_POLICY,
+						  policy);
+			}
+			write_unlock_irqrestore(&cpufreq_driver_lock, flags);
+		}
 		break;
 	default:
 		ret = -EINVAL;
diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
index 5e370a30a964..d4618144b4c0 100644
--- a/drivers/cpufreq/cpufreq_stats.c
+++ b/drivers/cpufreq/cpufreq_stats.c
@@ -130,7 +130,7 @@ static int freq_table_get_index(struct cpufreq_stats *stats, unsigned int freq)
 	return -1;
 }
 
-static void __cpufreq_stats_free_table(struct cpufreq_policy *policy)
+static void cpufreq_stats_free_table(struct cpufreq_policy *policy)
 {
 	struct cpufreq_stats *stats = policy->stats;
 
@@ -146,20 +146,7 @@ static void __cpufreq_stats_free_table(struct cpufreq_policy *policy)
 	policy->stats = NULL;
 }
 
-static void cpufreq_stats_free_table(unsigned int cpu)
-{
-	struct cpufreq_policy *policy;
-
-	policy = cpufreq_cpu_get(cpu);
-	if (!policy)
-		return;
-
-	__cpufreq_stats_free_table(policy);
-
-	cpufreq_cpu_put(policy);
-}
-
-static int __cpufreq_stats_create_table(struct cpufreq_policy *policy)
+static int cpufreq_stats_create_table(struct cpufreq_policy *policy)
 {
 	unsigned int i = 0, count = 0, ret = -ENOMEM;
 	struct cpufreq_stats *stats;
@@ -226,23 +213,6 @@ static int __cpufreq_stats_create_table(struct cpufreq_policy *policy)
 	return ret;
 }
 
-static void cpufreq_stats_create_table(unsigned int cpu)
-{
-	struct cpufreq_policy *policy;
-
-	/*
-	 * "likely(!policy)" because normally cpufreq_stats will be registered
-	 * before cpufreq driver
-	 */
-	policy = cpufreq_cpu_get(cpu);
-	if (likely(!policy))
-		return;
-
-	__cpufreq_stats_create_table(policy);
-
-	cpufreq_cpu_put(policy);
-}
-
 static int cpufreq_stat_notifier_policy(struct notifier_block *nb,
 		unsigned long val, void *data)
 {
@@ -250,9 +220,9 @@ static int cpufreq_stat_notifier_policy(struct notifier_block *nb,
 	struct cpufreq_policy *policy = data;
 
 	if (val == CPUFREQ_CREATE_POLICY)
-		ret = __cpufreq_stats_create_table(policy);
+		ret = cpufreq_stats_create_table(policy);
 	else if (val == CPUFREQ_REMOVE_POLICY)
-		__cpufreq_stats_free_table(policy);
+		cpufreq_stats_free_table(policy);
 
 	return ret;
 }
@@ -314,7 +284,6 @@ static struct notifier_block notifier_trans_block = {
 static int __init cpufreq_stats_init(void)
 {
 	int ret;
-	unsigned int cpu;
 
 	spin_lock_init(&cpufreq_stats_lock);
 	ret = cpufreq_register_notifier(&notifier_policy_block,
@@ -322,31 +291,21 @@ static int __init cpufreq_stats_init(void)
 	if (ret)
 		return ret;
 
-	for_each_online_cpu(cpu)
-		cpufreq_stats_create_table(cpu);
-
 	ret = cpufreq_register_notifier(&notifier_trans_block,
 				CPUFREQ_TRANSITION_NOTIFIER);
 	if (ret) {
 		cpufreq_unregister_notifier(&notifier_policy_block,
 				CPUFREQ_POLICY_NOTIFIER);
-		for_each_online_cpu(cpu)
-			cpufreq_stats_free_table(cpu);
-		return ret;
 	}
 
-	return 0;
+	return ret;
 }
 static void __exit cpufreq_stats_exit(void)
 {
-	unsigned int cpu;
-
-	cpufreq_unregister_notifier(&notifier_policy_block,
-			CPUFREQ_POLICY_NOTIFIER);
 	cpufreq_unregister_notifier(&notifier_trans_block,
 			CPUFREQ_TRANSITION_NOTIFIER);
-	for_each_online_cpu(cpu)
-		cpufreq_stats_free_table(cpu);
+	cpufreq_unregister_notifier(&notifier_policy_block,
+			CPUFREQ_POLICY_NOTIFIER);
 }
 
 MODULE_AUTHOR("Zou Nan hai <nanhai.zou@intel.com>");
