From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2 5/6] cpufreq: governor: replace per-cpu delayed work with timers
Date: Tue, 08 Dec 2015 00:17:18 +0100
Message-ID: <2389125.q3qMOpRs8O@vostro.rjw.lan>
References: <cover.1449115453.git.viresh.kumar@linaro.org> <20151207075027.GC3294@ubuntu> <3999637.u4UiK7zxOR@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:48649 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755831AbbLGWrV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 7 Dec 2015 17:47:21 -0500
In-Reply-To: <3999637.u4UiK7zxOR@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ashwin.chaugule@linaro.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, LKML <linux-kernel@vger.kernel.org>

On Monday, December 07, 2015 11:43:50 PM Rafael J. Wysocki wrote:
> On Monday, December 07, 2015 01:20:27 PM Viresh Kumar wrote:
> > On 07-12-15, 02:28, Rafael J. Wysocki wrote:
> > > What about if that happens in parallel with the decrementation in
> > > dbs_work_handler()?
> > > 
> > > Is there anything preventing that from happening?
> > 
> > Hmmm, you are right. Following is required for that.
> > 
> > diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
> > index c9e420bd0eec..d8a89e653933 100644
> > --- a/drivers/cpufreq/cpufreq_governor.c
> > +++ b/drivers/cpufreq/cpufreq_governor.c
> > @@ -230,6 +230,7 @@ static void dbs_work_handler(struct work_struct *work)
> >         struct dbs_data *dbs_data;
> >         unsigned int sampling_rate, delay;
> >         bool eval_load;
> > +       unsigned long flags;
> >  
> >         policy = shared->policy;
> >         dbs_data = policy->governor_data;
> > @@ -257,7 +258,10 @@ static void dbs_work_handler(struct work_struct *work)
> >         delay = dbs_data->cdata->gov_dbs_timer(policy, eval_load);
> >         mutex_unlock(&shared->timer_mutex);
> >  
> > +       spin_lock_irqsave(&shared->timer_lock, flags);
> >         shared->skip_work--;
> > +       spin_unlock_irqrestore(&shared->timer_lock, flags);
> > +
> >         gov_add_timers(policy, delay);
> >  }
> 
> OK, so can you please send an updated patch with the above change folded in?

In fact, I've already folded the above changes into the $subject patch (but this
is an exception).

I'll send the "atomic" changes separately.

Thanks,
Rafael

