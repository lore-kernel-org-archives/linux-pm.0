From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 5/6] cpufreq: governor: replace per-cpu delayed work
 with timers
Date: Fri, 4 Dec 2015 11:41:01 +0530
Message-ID: <20151204061101.GA3430@ubuntu>
References: <cover.1449115453.git.viresh.kumar@linaro.org>
 <691a3524afaa8d08d61987b1c2913948b4e59f01.1449115453.git.viresh.kumar@linaro.org>
 <10439879.00aCyM9quW@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:32801 "EHLO
	mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750929AbbLDGLG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 4 Dec 2015 01:11:06 -0500
Received: by pfnn128 with SMTP id n128so21079036pfn.0
        for <linux-pm@vger.kernel.org>; Thu, 03 Dec 2015 22:11:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <10439879.00aCyM9quW@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ashwin.chaugule@linaro.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, open list <linux-kernel@vger.kernel.org>

On 04-12-15, 02:18, Rafael J. Wysocki wrote:
> > +	shared->skip_work--;
> 
> Is there any reason for incrementing and decrementing this instead of setting
> it to either 0 or 1 (or maybe either 'true' or 'false' for that matter)?
> 
> If my reading of the patch is correct, it can only be either 0 or 1 anyway, right?

No. It can be 0, 1 or 2.

If the timer handler is running on any CPU, we increment skip_work, so
its value is 1. If at the same time, we try to stop the governor, we
increment it again and its value is 2 now.

Once timer-handler finishes, it decrements it and its value become 1.
Which guarantees that no other timer handler starts executing at this
point of time and we can safely do gov_cancel_timers(). And once we
are sure that we don't have any work/timer left, we make it 0 (as we
aren't sure of the current value, which can be 0 (if the timer handler
wasn't running when we stopped the governor) or 1 (if the timer
handler was running while stopping the governor)).

Hope this clarifies it.

> > +static void dbs_timer_handler(unsigned long data)
> > +{
> > +	struct cpu_dbs_info *cdbs = (struct cpu_dbs_info *)data;
> > +	struct cpu_common_dbs_info *shared = cdbs->shared;
> > +	struct cpufreq_policy *policy;
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&shared->timer_lock, flags);
> > +	policy = shared->policy;
> 
> Why do we need policy here?
> 
> > +
> > +	/*
> > +	 * Timer handler isn't allowed to queue work at the moment, because:
> > +	 * - Another timer handler has done that
> > +	 * - We are stopping the governor
> > +	 * - Or we are updating the sampling rate of ondemand governor
> > +	 */
> > +	if (shared->skip_work)
> > +		goto unlock;
> > +
> > +	shared->skip_work++;
> > +	queue_work(system_wq, &shared->work);
> >  
> >  unlock:
> 
> What about writing the above as
> 
> 	if (!shared->work_in_progress) {
> 		shared->work_in_progress = true;
> 		queue_work(system_wq, &shared->work);
> 	}
> 
> and then you won't need the unlock label.

Here is a diff for that:

diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index a3f9bc9b98e9..c9e420bd0eec 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -265,11 +265,9 @@ static void dbs_timer_handler(unsigned long data)
 {
        struct cpu_dbs_info *cdbs = (struct cpu_dbs_info *)data;
        struct cpu_common_dbs_info *shared = cdbs->shared;
-       struct cpufreq_policy *policy;
        unsigned long flags;
 
        spin_lock_irqsave(&shared->timer_lock, flags);
-       policy = shared->policy;
 
        /*
         * Timer handler isn't allowed to queue work at the moment, because:
@@ -277,13 +275,11 @@ static void dbs_timer_handler(unsigned long data)
         * - We are stopping the governor
         * - Or we are updating the sampling rate of ondemand governor
         */
-       if (shared->skip_work)
-               goto unlock;
-
-       shared->skip_work++;
-       queue_work(system_wq, &shared->work);
+       if (!shared->skip_work) {
+               shared->skip_work++;
+               queue_work(system_wq, &shared->work);
+       }
 
-unlock:
        spin_unlock_irqrestore(&shared->timer_lock, flags);
 }

I will resend this patch now.

-- 
viresh
