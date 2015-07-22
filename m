From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v2] cpufreq: Fix possible memory leak during CPU removal
Date: Thu, 23 Jul 2015 00:27:58 +0200
Message-ID: <1975585.UxCn1xIBB2@vostro.rjw.lan>
References: <3005422.83Yq8KhGHU@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3005422.83Yq8KhGHU@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

After commit 9b07109f06a1 (cpufreq: Fix double addition of sysfs
links) the second sif argument of __cpufreq_remove_dev_prepare()
and __cpufreq_remove_dev_finish() is not used by them any more.

However, there also is a problem in cpufreq_remove_dev() that
if any of the above functions returns an error, we'll fail to
clean up after a CPU that is going away (and it is going away
no matter what).  Moreover, error codes returned by them are
ignored by cpufreq_cpu_callback(), so even if any of them is
aborted and returns an error code, the caller of the notifier
callback will not know about that.

For this reason, make __cpufreq_remove_dev_prepare() and
__cpufreq_remove_dev_finish() never fail, change them to void
functions and drop the sif argument from them.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

On top of:
http://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git/commit/?h=bleeding-edge&id=9b07109f06a1edd6e636b1e7397157eae0e6baa4

Note: The commit mentioned above is on a testing branch only
at the moment.

Well, I seem to be blind.

v1 -> v2: *Notice* that the return values of the functions in question
are not checked by cpufreq_cpu_callback(), so they actually don't need to
return anything and therefore they may never fail.  Take that into account
and (1) make them void, (2) make them never abort and (3) really drop the
second arg from them (it isn't needed at all).

---
 drivers/cpufreq/cpufreq.c |   44 ++++++++++++++------------------------------
 1 file changed, 14 insertions(+), 30 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -1376,11 +1376,9 @@ out_release_rwsem:
 	return ret;
 }
 
-static int __cpufreq_remove_dev_prepare(struct device *dev,
-					struct subsys_interface *sif)
+static void __cpufreq_remove_dev_prepare(struct device *dev)
 {
 	unsigned int cpu = dev->id;
-	int ret = 0;
 	struct cpufreq_policy *policy;
 
 	pr_debug("%s: unregistering CPU %u\n", __func__, cpu);
@@ -1388,15 +1386,13 @@ static int __cpufreq_remove_dev_prepare(
 	policy = cpufreq_cpu_get_raw(cpu);
 	if (!policy) {
 		pr_debug("%s: No cpu_data found\n", __func__);
-		return -EINVAL;
+		return;
 	}
 
 	if (has_target()) {
-		ret = __cpufreq_governor(policy, CPUFREQ_GOV_STOP);
-		if (ret) {
+		int ret = __cpufreq_governor(policy, CPUFREQ_GOV_STOP);
+		if (ret)
 			pr_err("%s: Failed to stop governor\n", __func__);
-			return ret;
-		}
 	}
 
 	down_write(&policy->rwsem);
@@ -1415,7 +1411,7 @@ static int __cpufreq_remove_dev_prepare(
 	/* Start governor again for active policy */
 	if (!policy_is_inactive(policy)) {
 		if (has_target()) {
-			ret = __cpufreq_governor(policy, CPUFREQ_GOV_START);
+			int ret = __cpufreq_governor(policy, CPUFREQ_GOV_START);
 			if (!ret)
 				ret = __cpufreq_governor(policy, CPUFREQ_GOV_LIMITS);
 
@@ -1425,33 +1421,27 @@ static int __cpufreq_remove_dev_prepare(
 	} else if (cpufreq_driver->stop_cpu) {
 		cpufreq_driver->stop_cpu(policy);
 	}
-
-	return ret;
 }
 
-static int __cpufreq_remove_dev_finish(struct device *dev,
-				       struct subsys_interface *sif)
+static void __cpufreq_remove_dev_finish(struct device *dev)
 {
 	unsigned int cpu = dev->id;
-	int ret;
 	struct cpufreq_policy *policy = per_cpu(cpufreq_cpu_data, cpu);
 
 	if (!policy) {
 		pr_debug("%s: No cpu_data found\n", __func__);
-		return -EINVAL;
+		return;
 	}
 
 	/* Only proceed for inactive policies */
 	if (!policy_is_inactive(policy))
-		return 0;
+		return;
 
 	/* If cpu is last user of policy, free policy */
 	if (has_target()) {
-		ret = __cpufreq_governor(policy, CPUFREQ_GOV_POLICY_EXIT);
-		if (ret) {
+		int ret = __cpufreq_governor(policy, CPUFREQ_GOV_POLICY_EXIT);
+		if (ret)
 			pr_err("%s: Failed to exit governor\n", __func__);
-			return ret;
-		}
 	}
 
 	/*
@@ -1461,8 +1451,6 @@ static int __cpufreq_remove_dev_finish(s
 	 */
 	if (cpufreq_driver->exit)
 		cpufreq_driver->exit(policy);
-
-	return 0;
 }
 
 /**
@@ -1474,17 +1462,13 @@ static int cpufreq_remove_dev(struct dev
 {
 	unsigned int cpu = dev->id;
 	struct cpufreq_policy *policy = per_cpu(cpufreq_cpu_data, cpu);
-	int ret;
 
 	if (!policy)
 		return 0;
 
 	if (cpu_online(cpu)) {
-		ret = __cpufreq_remove_dev_prepare(dev, sif);
-		if (!ret)
-			ret = __cpufreq_remove_dev_finish(dev, sif);
-		if (ret)
-			return ret;
+		__cpufreq_remove_dev_prepare(dev);
+		__cpufreq_remove_dev_finish(dev);
 	}
 
 	/* sysfs links are removed only on subsys callback */
@@ -2376,11 +2360,11 @@ static int cpufreq_cpu_callback(struct n
 			break;
 
 		case CPU_DOWN_PREPARE:
-			__cpufreq_remove_dev_prepare(dev, NULL);
+			__cpufreq_remove_dev_prepare(dev);
 			break;
 
 		case CPU_POST_DEAD:
-			__cpufreq_remove_dev_finish(dev, NULL);
+			__cpufreq_remove_dev_finish(dev);
 			break;
 
 		case CPU_DOWN_FAILED:
