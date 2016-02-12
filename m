From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: Avoid unnecessary locking in show() and store()
Date: Fri, 12 Feb 2016 14:18:52 +0100
Message-ID: <16931364.qnKxgPucoY@vostro.rjw.lan>
References: <2946666.LCVBdOefy1@vostro.rjw.lan> <20160212063115.GE16949@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:65385 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752459AbcBLNRh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 12 Feb 2016 08:17:37 -0500
In-Reply-To: <20160212063115.GE16949@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Friday, February 12, 2016 12:01:15 PM Viresh Kumar wrote:
> On 11-02-16, 02:25, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > The show() and store() routines in the cpufreq core don't need to
> > acquire all of the locks to check if the struct freq_attr they want
> > to use really provides the callbacks they need as expected, so change
> > them to avoid doing that.
> > 
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/cpufreq/cpufreq.c |   27 +++++++++++----------------
> >  1 file changed, 11 insertions(+), 16 deletions(-)
> > 
> > Index: linux-pm/drivers/cpufreq/cpufreq.c
> > ===================================================================
> > --- linux-pm.orig/drivers/cpufreq/cpufreq.c
> > +++ linux-pm/drivers/cpufreq/cpufreq.c
> > @@ -862,13 +862,11 @@ static ssize_t show(struct kobject *kobj
> >  	struct freq_attr *fattr = to_attr(attr);
> >  	ssize_t ret;
> >  
> > -	down_read(&policy->rwsem);
> > -
> > -	if (fattr->show)
> > -		ret = fattr->show(policy, buf);
> > -	else
> > -		ret = -EIO;
> > +	if (!fattr->show)
> > +		return -EIO;
> >  
> > +	down_read(&policy->rwsem);
> > +	ret = fattr->show(policy, buf);
> >  	up_read(&policy->rwsem);
> >  
> >  	return ret;
> > @@ -881,20 +879,17 @@ static ssize_t store(struct kobject *kob
> >  	struct freq_attr *fattr = to_attr(attr);
> >  	ssize_t ret = -EINVAL;
> >  
> > -	get_online_cpus();
> > -
> > -	if (!cpu_online(policy->cpu))
> > -		goto unlock;
> > +	if (!fattr->store)
> > +		return -EIO;
> >  
> > -	down_write(&policy->rwsem);
> > +	get_online_cpus();
> >  
> > -	if (fattr->store)
> > +	if (cpu_online(policy->cpu)) {
> > +		down_write(&policy->rwsem);
> >  		ret = fattr->store(policy, buf, count);
> > -	else
> > -		ret = -EIO;
> > +		up_write(&policy->rwsem);
> > +	}
> >  
> > -	up_write(&policy->rwsem);
> > -unlock:
> 
> I have no problems with the patch as is, but how are we going to benefit from it
> ?
> 
> 'if (fattr->show/store)' is never ever going to fail, unless we have a bug here.

Well, having a check that never fails is certainly unuseful.

> So, even we may want to add a WARN_ON() for that case instead.

I can add WARN_ON()s just fine.

---
From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH] cpufreq: Avoid unnecessary locking in show() and store()

The show() and store() routines in the cpufreq core don't need to
acquire all of the locks to check if the struct freq_attr they want
to use really provides the callbacks they need as expected, so change
them to avoid doing that.

While at it, add WARN_ON()s around those checks as they are only supposed
to ever fail if there's a bug in the code.

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
+	if (WARN_ON(!fattr->show))
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
+	if (WARN_ON(!fattr->store))
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

