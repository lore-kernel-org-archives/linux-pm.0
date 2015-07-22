From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] cpufreq: Fix possible memory leak during CPU removal
Date: Wed, 22 Jul 2015 22:18:41 +0200
Message-ID: <3005422.83Yq8KhGHU@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64104 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752815AbbGVTvz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 22 Jul 2015 15:51:55 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

After commit 9b07109f06a1 (cpufreq: Fix double addition of sysfs
links) the second sif argument of __cpufreq_remove_dev_prepare()
and __cpufreq_remove_dev_finish() is not used by them any more.

However, there also is a problem in cpufreq_remove_dev() that if
any of the above functions returns an error, we'll fail to
clean up after a CPU that is going away (and it is going away
no matter what).

For this reason, replace the sif argument of __cpufreq_remove_dev_prepare()
and __cpufreq_remove_dev_finish() with a bool force argument that
will tell each of them to avoid aborting in case of a governor
callback failure and do the cleanup regardless.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

On top of:
http://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git/commit/?h=bleeding-edge&id=9b07109f06a1edd6e636b1e7397157eae0e6baa4

Note: The above commit is on a testing branch only at the moment.

---
 drivers/cpufreq/cpufreq.c |   23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -1376,8 +1376,7 @@ out_release_rwsem:
 	return ret;
 }
 
-static int __cpufreq_remove_dev_prepare(struct device *dev,
-					struct subsys_interface *sif)
+static int __cpufreq_remove_dev_prepare(struct device *dev, bool force)
 {
 	unsigned int cpu = dev->id;
 	int ret = 0;
@@ -1395,7 +1394,8 @@ static int __cpufreq_remove_dev_prepare(
 		ret = __cpufreq_governor(policy, CPUFREQ_GOV_STOP);
 		if (ret) {
 			pr_err("%s: Failed to stop governor\n", __func__);
-			return ret;
+			if (!force)
+				return ret;
 		}
 	}
 
@@ -1429,8 +1429,7 @@ static int __cpufreq_remove_dev_prepare(
 	return ret;
 }
 
-static int __cpufreq_remove_dev_finish(struct device *dev,
-				       struct subsys_interface *sif)
+static int __cpufreq_remove_dev_finish(struct device *dev, bool force)
 {
 	unsigned int cpu = dev->id;
 	int ret;
@@ -1450,7 +1449,8 @@ static int __cpufreq_remove_dev_finish(s
 		ret = __cpufreq_governor(policy, CPUFREQ_GOV_POLICY_EXIT);
 		if (ret) {
 			pr_err("%s: Failed to exit governor\n", __func__);
-			return ret;
+			if (!force)
+				return ret;
 		}
 	}
 
@@ -1480,11 +1480,8 @@ static int cpufreq_remove_dev(struct dev
 		return 0;
 
 	if (cpu_online(cpu)) {
-		ret = __cpufreq_remove_dev_prepare(dev, sif);
-		if (!ret)
-			ret = __cpufreq_remove_dev_finish(dev, sif);
-		if (ret)
-			return ret;
+		__cpufreq_remove_dev_prepare(dev, true);
+		__cpufreq_remove_dev_finish(dev, true);
 	}
 
 	/* sysfs links are removed only on subsys callback */
@@ -2376,11 +2373,11 @@ static int cpufreq_cpu_callback(struct n
 			break;
 
 		case CPU_DOWN_PREPARE:
-			__cpufreq_remove_dev_prepare(dev, NULL);
+			__cpufreq_remove_dev_prepare(dev, false);
 			break;
 
 		case CPU_POST_DEAD:
-			__cpufreq_remove_dev_finish(dev, NULL);
+			__cpufreq_remove_dev_finish(dev, false);
 			break;
 
 		case CPU_DOWN_FAILED:

