From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3 4/5] cpufreq: governor: Quit work-handlers early if
 governor is stopped
Date: Wed, 28 Oct 2015 13:55:59 +0530
Message-ID: <20151028082559.GD30039@ubuntu>
References: <cover.1444723240.git.viresh.kumar@linaro.org>
 <1e579d2bf8dbee09295725cda37bd92222fe61fb.1444723240.git.viresh.kumar@linaro.org>
 <11662041.x9fsKCWszL@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:36577 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932551AbbJ1I0F (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 28 Oct 2015 04:26:05 -0400
Received: by pacfv9 with SMTP id fv9so138228pac.3
        for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2015 01:26:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <11662041.x9fsKCWszL@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>

On 28-10-15, 08:10, Rafael J. Wysocki wrote:
> I have a hard time figuring out what the patch is supposed to achieve from
> the above.

We had a problem earlier, where even after stopping the governor for a
policy, the work was still queued for some of its CPUs.

We failed to understand the real problem then, and so abused the wider
cpufreq_governor_lock.

I understood the problem much better now, and got a straight forward,
and precise solution for that.

> Do we eventually want to get rid of cpufreq_governor_lock and that's why we're
> doing this?

That's another benefit we get out of this change.

> > +	mutex_lock(&shared->timer_mutex);
> > +	shared->policy = NULL;
> > +	mutex_unlock(&shared->timer_mutex);

Right.

> So this assumes that dbs_timer() will acquire the mutex and see that
> shared->policy is now NULL, so it will bail out immediately, but ->
> 
> > +
> >  	gov_cancel_work(dbs_data, policy);
> >  
> > -	shared->policy = NULL;
> >  	mutex_destroy(&shared->timer_mutex);
> 
> -> the mutex is destroyed here, so what the guarantee that the mutex will
> still be around when dbs_timer() runs?

You really got me worried for few minutes :)

The earlier update of shared->policy = NULL, makes sure that no
work-handler can start real work. After the unlock the work handlers
will start executing but will return early.

We also have gov_cancel_work(), which will until the time all the
current handlers have finished executing and no work is queued.

And so we are sure that there are no users of the mutex when it is
destroyed.

-- 
viresh
