From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: [RFC PATCH] cpufreq/hotplug: Fix cpu-hotplug cpufreq race conditions
Date: Mon, 01 Jun 2015 01:40:40 -0500
Message-ID: <20150601064031.2972.59208.stgit@perfhull-ltc.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e38.co.us.ibm.com ([32.97.110.159]:53830 "EHLO
	e38.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751226AbbFAGly (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 1 Jun 2015 02:41:54 -0400
Received: from /spool/local
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <preeti@linux.vnet.ibm.com>;
	Mon, 1 Jun 2015 00:41:53 -0600
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: viresh.kumar@linaro.org, rjw@rjwysocki.net
Cc: ego@linux.vnet.ibm.com, paulus@samba.org, linux-kernel@vger.kernel.org, shilpa.bhat@linux.vnet.ibm.com, linux-pm@vger.kernel.org

The problem showed up when running hotplug operations and changing
governors in parallel. The crash would be at:

[  174.319645] Unable to handle kernel paging request for data at address 0x00000000
[  174.319782] Faulting instruction address: 0xc00000000053b3e0
cpu 0x1: Vector: 300 (Data Access) at [c000000003fdb870]
    pc: c00000000053b3e0: __bitmap_weight+0x70/0x100
    lr: c00000000085a338: need_load_eval+0x38/0xf0
    sp: c000000003fdbaf0
   msr: 9000000100009033
   dar: 0
 dsisr: 40000000
  current = 0xc000000003151a40
  paca    = 0xc000000007da0980	 softe: 0	 irq_happened: 0x01
    pid   = 842, comm = kworker/1:2
enter ? for help
[c000000003fdbb40] c00000000085a338 need_load_eval+0x38/0xf0
[c000000003fdbb70] c000000000856a10 od_dbs_timer+0x90/0x1e0
[c000000003fdbbe0] c0000000000f489c process_one_work+0x24c/0x910
[c000000003fdbc90] c0000000000f50dc worker_thread+0x17c/0x540
[c000000003fdbd20] c0000000000fed70 kthread+0x120/0x140
[c000000003fdbe30] c000000000009678 ret_from_kernel_thread+0x5c/0x64

While debugging the issue, other problems in this area were uncovered,
all of them necessitating serialized calls to __cpufreq_governor().  One
potential race condition that can happen today is the below:

CPU0					CPU1

cpufreq_set_policy()

__cpufreq_governor
(CPUFREQ_GOV_POLICY_EXIT)
				__cpufreq_remove_dev_finish()

free(dbs_data)			__cpufreq_governor
				(CPUFRQ_GOV_START)

				dbs_data->mutex <= NULL dereference

The issue here is that calls to cpufreq_governor_dbs() is not serialized
and they can conflict with each other in numerous ways. One way to sort
this out would be to serialize all calls to cpufreq_governor_dbs()
by setting the governor busy if a call is in progress and
blocking all other calls. But this approach will not cover all loop
holes. Take the above scenario: CPU1 will still hit a NULL dereference if
care is not taken to check for a NULL dbs_data.

To sort such scenarios, we could filter out the sequence of events: A
CPUFREQ_GOV_START cannot be called without an INIT, if the previous
event was an EXIT. However this results in analysing all possible
sequence of events and adding each of them as a filter. This results in
unmanagable code. There is high probability of missing out on a race
condition. Both the above approaches were tried out earlier [1]

Let us therefore look at the heart of the issue. It is not really about
serializing calls to cpufreq_governor_dbs(), it seems to be about
serializing entire sequence of CPUFREQ_GOV* operations. For instance, in
cpufreq_set_policy(), we STOP,EXIT the old policy and INIT and START the
new policy. Between the EXIT and INIT, there must not be
anybody else starting the policy. And between INIT and START, there must
be nobody stopping the policy.

A similar argument holds for the CPUFREQ_GOV* operations in
 __cpufreq_policy_dev_{prepare|finish} and cpufreq_add_policy(). Hence
until each of these functions complete in totality, none of the others
should run in parallel. The interleaving of the individual calls to
cpufreq_governor_dbs() is resulting in invalid operations. This patch
therefore tries to serialize entire cpufreq functions calling CPUFREQ_GOV*
operations, with respect to each other.

However there are a few concerns:

a. On those archs, which do not have CPUFREQ_HAVE_GOVERNOR_PER_POLICY flag
set, this patch results in softlockups. This may be because we are setting
the governor busy in a preempt enabled section, which will block other
cpufreq operations across all cpus.

b. This has still not solved the kernel panic mentioned a the beginning of
the changelog. But it does resolve the kernel panic on a 3.18 stable kernel.
The 3.18 kernel survives parallel hotplug and cpufreq governor change
operations with this patch.

So the reason this patch was posted out as an RFC was to resolve the
above two issues wrg to this patch and get the discussion going on resolving
potential race conditions in parallel cpufreq and hotplug operations which
seems rampant and not easily solvable. There are race conditions in
parallel cpufreq operations themselves.

This RFC patch brings forth potential issues and possible approaches to
solutions.

[1] http://comments.gmane.org/gmane.linux.power-management.general/49337

Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
---
 drivers/cpufreq/cpufreq.c |   68 +++++++++++++++++++++++++++++++++++++++++++--
 include/linux/cpufreq.h   |    2 +
 2 files changed, 67 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 8ae655c..e03e738 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -121,6 +121,45 @@ struct kobject *get_governor_parent_kobj(struct cpufreq_policy *policy)
 }
 EXPORT_SYMBOL_GPL(get_governor_parent_kobj);
 
+static bool is_governor_busy(struct cpufreq_policy *policy)
+{
+	if (have_governor_per_policy())
+		return policy->governor_busy;
+	else
+		return policy->governor->governor_busy;
+}
+
+static void __set_governor_busy(struct cpufreq_policy *policy, bool busy)
+{
+	if (have_governor_per_policy())
+		policy->governor_busy = busy;
+	else
+		policy->governor->governor_busy = busy;
+}
+
+static void set_governor_busy(struct cpufreq_policy *policy, bool busy)
+{
+	if (busy) {
+try_again:
+		if (is_governor_busy(policy))
+			goto try_again;
+
+		mutex_lock(&cpufreq_governor_lock);
+
+		if (is_governor_busy(policy)) {
+			mutex_unlock(&cpufreq_governor_lock);
+			goto try_again;
+		}
+
+		__set_governor_busy(policy, true);
+		mutex_unlock(&cpufreq_governor_lock);
+	} else {
+		mutex_lock(&cpufreq_governor_lock);
+		__set_governor_busy(policy, false);
+		mutex_unlock(&cpufreq_governor_lock);
+	}
+}
+
 static inline u64 get_cpu_idle_time_jiffy(unsigned int cpu, u64 *wall)
 {
 	u64 idle_time;
@@ -966,9 +1005,11 @@ static int cpufreq_add_policy_cpu(struct cpufreq_policy *policy,
 	unsigned long flags;
 
 	if (has_target()) {
+		set_governor_busy(policy, true);
 		ret = __cpufreq_governor(policy, CPUFREQ_GOV_STOP);
 		if (ret) {
 			pr_err("%s: Failed to stop governor\n", __func__);
+			set_governor_busy(policy, false);
 			return ret;
 		}
 	}
@@ -990,10 +1031,11 @@ static int cpufreq_add_policy_cpu(struct cpufreq_policy *policy,
 
 		if (ret) {
 			pr_err("%s: Failed to start governor\n", __func__);
+			set_governor_busy(policy, false);
 			return ret;
 		}
 	}
-
+	set_governor_busy(policy, false);
 	return sysfs_create_link(&dev->kobj, &policy->kobj, "cpufreq");
 }
 
@@ -1349,12 +1391,13 @@ static int __cpufreq_remove_dev_prepare(struct device *dev,
 	}
 
 	if (has_target()) {
+		set_governor_busy(policy, true);
 		ret = __cpufreq_governor(policy, CPUFREQ_GOV_STOP);
 		if (ret) {
 			pr_err("%s: Failed to stop governor\n", __func__);
+			set_governor_busy(policy, false);
 			return ret;
 		}
-
 		strncpy(per_cpu(cpufreq_cpu_governor, cpu),
 			policy->governor->name, CPUFREQ_NAME_LEN);
 	}
@@ -1377,6 +1420,8 @@ static int __cpufreq_remove_dev_prepare(struct device *dev,
 					      "cpufreq"))
 				pr_err("%s: Failed to restore kobj link to cpu:%d\n",
 				       __func__, cpu_dev->id);
+
+			set_governor_busy(policy, false);
 			return ret;
 		}
 
@@ -1387,6 +1432,7 @@ static int __cpufreq_remove_dev_prepare(struct device *dev,
 		cpufreq_driver->stop_cpu(policy);
 	}
 
+	set_governor_busy(policy, false);
 	return 0;
 }
 
@@ -1418,11 +1464,13 @@ static int __cpufreq_remove_dev_finish(struct device *dev,
 	/* If cpu is last user of policy, free policy */
 	if (cpus == 1) {
 		if (has_target()) {
+			set_governor_busy(policy, true);
 			ret = __cpufreq_governor(policy,
 					CPUFREQ_GOV_POLICY_EXIT);
 			if (ret) {
 				pr_err("%s: Failed to exit governor\n",
 				       __func__);
+				set_governor_busy(policy, false);
 				return ret;
 			}
 		}
@@ -1446,16 +1494,19 @@ static int __cpufreq_remove_dev_finish(struct device *dev,
 		if (!cpufreq_suspended)
 			cpufreq_policy_free(policy);
 	} else if (has_target()) {
+		set_governor_busy(policy, true);
 		ret = __cpufreq_governor(policy, CPUFREQ_GOV_START);
 		if (!ret)
 			ret = __cpufreq_governor(policy, CPUFREQ_GOV_LIMITS);
 
 		if (ret) {
 			pr_err("%s: Failed to start governor\n", __func__);
+			set_governor_busy(policy, false);
 			return ret;
 		}
 	}
 
+	set_governor_busy(policy, false);
 	return 0;
 }
 
@@ -2203,10 +2254,12 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 
 	pr_debug("governor switch\n");
 
+
 	/* save old, working values */
 	old_gov = policy->governor;
 	/* end old governor */
 	if (old_gov) {
+		set_governor_busy(policy, true);
 		__cpufreq_governor(policy, CPUFREQ_GOV_STOP);
 		up_write(&policy->rwsem);
 		__cpufreq_governor(policy, CPUFREQ_GOV_POLICY_EXIT);
@@ -2215,6 +2268,10 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 
 	/* start new governor */
 	policy->governor = new_policy->governor;
+
+	if (!old_gov)
+		set_governor_busy(policy, true);
+
 	if (!__cpufreq_governor(policy, CPUFREQ_GOV_POLICY_INIT)) {
 		if (!__cpufreq_governor(policy, CPUFREQ_GOV_START))
 			goto out;
@@ -2232,11 +2289,16 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 		__cpufreq_governor(policy, CPUFREQ_GOV_START);
 	}
 
+	set_governor_busy(policy, false);
+
 	return -EINVAL;
 
  out:
 	pr_debug("governor: change or update limits\n");
-	return __cpufreq_governor(policy, CPUFREQ_GOV_LIMITS);
+	ret = __cpufreq_governor(policy, CPUFREQ_GOV_LIMITS);
+
+	set_governor_busy(policy, false);
+	return ret;
 }
 
 /**
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 2ee4888..ae2f97f 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -80,6 +80,7 @@ struct cpufreq_policy {
 	struct cpufreq_governor	*governor; /* see below */
 	void			*governor_data;
 	bool			governor_enabled; /* governor start/stop flag */
+	bool			governor_busy;
 
 	struct work_struct	update; /* if update_policy() needs to be
 					 * called, but you're in IRQ context */
@@ -451,6 +452,7 @@ struct cpufreq_governor {
 			will fallback to performance governor */
 	struct list_head	governor_list;
 	struct module		*owner;
+	bool			governor_busy;
 };
 
 /* Pass a target to the cpufreq driver */

