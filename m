From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] cpufreq: Avoid unnecessary locking in show() and store()
Date: Thu, 11 Feb 2016 02:25:15 +0100
Message-ID: <2946666.LCVBdOefy1@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The show() and store() routines in the cpufreq core don't need to
acquire all of the locks to check if the struct freq_attr they want
to use really provides the callbacks they need as expected, so change
them to avoid doing that.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c |   27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -862,13 +862,11 @@ static ssize_t show(struct kobject *kobj
 	struct freq_attr *fattr = to_attr(attr);
 	ssize_t ret;
 
-	down_read(&policy->rwsem);
-
-	if (fattr->show)
-		ret = fattr->show(policy, buf);
-	else
-		ret = -EIO;
+	if (!fattr->show)
+		return -EIO;
 
+	down_read(&policy->rwsem);
+	ret = fattr->show(policy, buf);
 	up_read(&policy->rwsem);
 
 	return ret;
@@ -881,20 +879,17 @@ static ssize_t store(struct kobject *kob
 	struct freq_attr *fattr = to_attr(attr);
 	ssize_t ret = -EINVAL;
 
-	get_online_cpus();
-
-	if (!cpu_online(policy->cpu))
-		goto unlock;
+	if (!fattr->store)
+		return -EIO;
 
-	down_write(&policy->rwsem);
+	get_online_cpus();
 
-	if (fattr->store)
+	if (cpu_online(policy->cpu)) {
+		down_write(&policy->rwsem);
 		ret = fattr->store(policy, buf, count);
-	else
-		ret = -EIO;
+		up_write(&policy->rwsem);
+	}
 
-	up_write(&policy->rwsem);
-unlock:
 	put_online_cpus();
 
 	return ret;
