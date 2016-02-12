From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: Avoid unnecessary locking in show() and store()
Date: Fri, 12 Feb 2016 17:10:09 +0100
Message-ID: <15659367.8so4AOBv9e@vostro.rjw.lan>
References: <2946666.LCVBdOefy1@vostro.rjw.lan> <16931364.qnKxgPucoY@vostro.rjw.lan> <20160212155829.GA32705@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:45254 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751503AbcBLQIy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 12 Feb 2016 11:08:54 -0500
In-Reply-To: <20160212155829.GA32705@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Friday, February 12, 2016 09:28:29 PM Viresh Kumar wrote:
> On 12-02-16, 14:18, Rafael J. Wysocki wrote:
> > Well, having a check that never fails is certainly unuseful.
> > 
> > > So, even we may want to add a WARN_ON() for that case instead.
> > 
> > I can add WARN_ON()s just fine.
> 
> What about dropping the check completely ?

Fine by me.

---
From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH] cpufreq: Drop unnecessary checks from show() and store()

The show() and store() routines in the cpufreq core don't need to
check if the struct freq_attr they want to use really provides the
callbacks they need as expected (if that's not the case, it means
a bug in the code anyway), so change them to avoid doing that.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c |   21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -863,12 +863,7 @@ static ssize_t show(struct kobject *kobj
 	ssize_t ret;
 
 	down_read(&policy->rwsem);
-
-	if (fattr->show)
-		ret = fattr->show(policy, buf);
-	else
-		ret = -EIO;
-
+	ret = fattr->show(policy, buf);
 	up_read(&policy->rwsem);
 
 	return ret;
@@ -883,18 +878,12 @@ static ssize_t store(struct kobject *kob
 
 	get_online_cpus();
 
-	if (!cpu_online(policy->cpu))
-		goto unlock;
-
-	down_write(&policy->rwsem);
-
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

