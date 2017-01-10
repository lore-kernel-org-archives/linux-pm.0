From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 12/12] PM / OPP: Update Documentation to remove RCU
 specific bits
Date: Tue, 10 Jan 2017 10:09:41 +0530
Message-ID: <20170110043941.GE6332@vireshk-i7>
References: <cover.1481106919.git.viresh.kumar@linaro.org>
 <164ad6c0c6a5200eae99a7ac23554f33542f465b.1481106919.git.viresh.kumar@linaro.org>
 <20170109223937.GR17126@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:34403 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1764774AbdAJEjp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Jan 2017 23:39:45 -0500
Received: by mail-pf0-f172.google.com with SMTP id 127so39896975pfg.1
        for <linux-pm@vger.kernel.org>; Mon, 09 Jan 2017 20:39:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20170109223937.GR17126@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>

On 09-01-17, 14:39, Stephen Boyd wrote:
> On 12/07, Viresh Kumar wrote:
> > @@ -137,15 +121,18 @@ functions return the matching pointer representing the opp if a match is
> >  found, else returns error. These errors are expected to be handled by standard
> >  error checks such as IS_ERR() and appropriate actions taken by the caller.
> >  
> > +Callers of these functions shall call dev_pm_opp_put() after they have used the
> > +OPP. Otherwise the memory for the OPP will never get freed and result in
> > +memleak.
> > +
> >  dev_pm_opp_find_freq_exact - Search for an OPP based on an *exact* frequency and
> >  	availability. This function is especially useful to enable an OPP which
> >  	is not available by default.
> >  	Example: In a case when SoC framework detects a situation where a
> >  	higher frequency could be made available, it can use this function to
> >  	find the OPP prior to call the dev_pm_opp_enable to actually make it available.
> > -	 rcu_read_lock();
> >  	 opp = dev_pm_opp_find_freq_exact(dev, 1000000000, false);
> > -	 rcu_read_unlock();
> > +	 dev_pm_opp_put(opp);
> >  	 /* dont operate on the pointer.. just do a sanity check.. */
> >  	 if (IS_ERR(opp)) {
> >  		pr_err("frequency not disabled!\n");
> > @@ -163,9 +150,8 @@ dev_pm_opp_find_freq_floor - Search for an available OPP which is *at most* the
> >  	frequency.
> >  	Example: To find the highest opp for a device:
> >  	 freq = ULONG_MAX;
> > -	 rcu_read_lock();
> >  	 dev_pm_opp_find_freq_floor(dev, &freq);
> > -	 rcu_read_unlock();
> > +	 dev_pm_opp_put(opp);
> 
> opp doesn't exist in the scope here. Missing an assignment during
> the dev_pm_opp_find_freq_floor() call?

Thanks for noticing this. Following is the diff I am adding to this patch:

diff --git a/Documentation/power/opp.txt b/Documentation/power/opp.txt
index be895e32022d..0c007e250cd1 100644
--- a/Documentation/power/opp.txt
+++ b/Documentation/power/opp.txt
@@ -150,7 +150,7 @@ dev_pm_opp_find_freq_floor - Search for an available OPP which is *at most* the
        frequency.
        Example: To find the highest opp for a device:
         freq = ULONG_MAX;
-        dev_pm_opp_find_freq_floor(dev, &freq);
+        opp = dev_pm_opp_find_freq_floor(dev, &freq);
         dev_pm_opp_put(opp);
 
 dev_pm_opp_find_freq_ceil - Search for an available OPP which is *at least* the
@@ -159,7 +159,7 @@ dev_pm_opp_find_freq_ceil - Search for an available OPP which is *at least* the
        frequency.
        Example 1: To find the lowest opp for a device:
         freq = 0;
-        dev_pm_opp_find_freq_ceil(dev, &freq);
+        opp = dev_pm_opp_find_freq_ceil(dev, &freq);
         dev_pm_opp_put(opp);
        Example 2: A simplified implementation of a SoC cpufreq_driver->target:
         soc_cpufreq_target(..)
@@ -252,6 +252,7 @@ dev_pm_opp_get_freq - Retrieve the freq represented by the opp pointer.
                 if (!IS_ERR(max_opp) && !IS_ERR(requested_opp))
                        r = soc_test_validity(max_opp, requested_opp);
                 dev_pm_opp_put(max_opp);
+                dev_pm_opp_put(requested_opp);
                /* do other things */
         }
         soc_test_validity(..)


Please add your RBY if it looks fine to you now.

-- 
viresh
