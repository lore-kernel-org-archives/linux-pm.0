From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: Fix incorrect usage of clamp_val()
Date: Tue, 31 May 2016 22:46:13 +0200
Message-ID: <4985583.nmytFqifgB@vostro.rjw.lan>
References: <a5c21ebe773d364b49bc5df9c4f69ff2eb181dbb.1464693539.git.viresh.kumar@linaro.org> <20160531182308.GJ9864@graphite.smuckle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:46204 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751484AbcEaUmX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 31 May 2016 16:42:23 -0400
In-Reply-To: <20160531182308.GJ9864@graphite.smuckle.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org

On Tuesday, May 31, 2016 11:23:08 AM Steve Muckle wrote:
> On Tue, May 31, 2016 at 04:49:42PM +0530, Viresh Kumar wrote:
> > clamp_val() doesn't change anything by itself, rather it returns the
> > clamped value.
> > 
> > Fix it.
> > 
> > Fixes: 0ac587b32f49 ("cpufreq: Use clamp_val() in __cpufreq_driver_target()")
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> > Hi Rafael,
> > 
> > Please merge this with the offending commit if you are fine with rebase,
> > else apply this one as well.
> > 
> > Sorry for blindly copying code.
> > 
> >  drivers/cpufreq/cpufreq.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index d0c02a7eec0f..c6a14ba239a2 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -1927,7 +1927,7 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
> >  		return -ENODEV;
> >  
> >  	/* Make sure that target_freq is within supported range */
> > -	clamp_val(target_freq, policy->min, policy->max);
> > +	target_freq = clamp_val(target_freq, policy->min, policy->max);
> >  
> >  	pr_debug("target for CPU %u: %u kHz, relation %u, requested %u kHz\n",
> >  		 policy->cpu, target_freq, relation, old_target_freq);
> 
> As mentioned in the other thread cpufreq_driver_fast_switch() has this
> problem as well, might as well fix it in this patch also.

Patch apppended.

---
From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH] cpufreq: Fix clamp_val() usage in cpufreq_driver_fast_switch()

The return value of clamp_val() has to be stored actually.

Fixes: b7898fda5bc7 (cpufreq: Support for fast frequency switching)
Reported-by: Steve Muckle <steve.muckle@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -1829,7 +1829,7 @@ EXPORT_SYMBOL(cpufreq_unregister_notifie
 unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
 					unsigned int target_freq)
 {
-	clamp_val(target_freq, policy->min, policy->max);
+	target_freq = clamp_val(target_freq, policy->min, policy->max);
 
 	return cpufreq_driver->fast_switch(policy, target_freq);
 }

