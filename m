From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v2] cpufreq: Drop unnecessary arguments from two functions
Date: Wed, 22 Jul 2015 19:48:38 +0200
Message-ID: <1661535.WGIelkkBTd@vostro.rjw.lan>
References: <1710735.NHMxY7dJsV@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:47295 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757185AbbGVRVw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 22 Jul 2015 13:21:52 -0400
In-Reply-To: <1710735.NHMxY7dJsV@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: cpufreq: Drop unnecessary arguments from two functions

After commit 9b07109f06a1 (cpufreq: Fix double addition of sysfs
links) The second sif argument of __cpufreq_remove_dev_prepare()
and __cpufreq_remove_dev_finish() is not used by them any more,
so drop it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Rebased on top of:
http://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git/commit/?h=bleeding-edge&id=9b07109f06a1edd6e636b1e7397157eae0e6baa4

Note: The above commit is on a testing branch only at the moment.

---
 drivers/cpufreq/cpufreq.c |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -1376,8 +1376,7 @@ out_release_rwsem:
 	return ret;
 }
 
-static int __cpufreq_remove_dev_prepare(struct device *dev,
-					struct subsys_interface *sif)
+static int __cpufreq_remove_dev_prepare(struct device *dev)
 {
 	unsigned int cpu = dev->id;
 	int ret = 0;
@@ -1429,8 +1428,7 @@ static int __cpufreq_remove_dev_prepare(
 	return ret;
 }
 
-static int __cpufreq_remove_dev_finish(struct device *dev,
-				       struct subsys_interface *sif)
+static int __cpufreq_remove_dev_finish(struct device *dev)
 {
 	unsigned int cpu = dev->id;
 	int ret;
@@ -1480,9 +1478,9 @@ static int cpufreq_remove_dev(struct dev
 		return 0;
 
 	if (cpu_online(cpu)) {
-		ret = __cpufreq_remove_dev_prepare(dev, sif);
+		ret = __cpufreq_remove_dev_prepare(dev);
 		if (!ret)
-			ret = __cpufreq_remove_dev_finish(dev, sif);
+			ret = __cpufreq_remove_dev_finish(dev);
 		if (ret)
 			return ret;
 	}
@@ -2376,11 +2374,11 @@ static int cpufreq_cpu_callback(struct n
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

